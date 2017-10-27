var express = require('express');
var app = express();
var request = require('request');

var server = require("http").Server(app);
var io = require("socket.io")(server);

server.listen(process.env.PORT || 3000);

var users = [];

var bosssocket = [];

var boss = null
io.on("connection", function (socket) {
    // console.log(socket.id);
    console.log(socket.adapter.rooms);

    socket.on("bossonline", function (data) {
        bosssocket.splice(0, bosssocket.length);
        bosssocket.push(data);
        boss = data.socketid;
        socket.boss = data;
        io.sockets.emit("bossol", bosssocket);
    });

    socket.on('message', function (data) {
        // console.log(data);
        if (boss != null) {
            io.sockets.emit("bossol", bosssocket);
        }
    });


    socket.on("client-send-initchat", function (data) {
        // console.log(data);
        users.push(data);
        socket.username = data;

        initchat(data.name, data.email, data.phone)
            .then(res => {
                // console.log(res);
                io.sockets.emit("userdatainit", res);

                var keyroot = JSON.parse(res);
                // console.log(keyroot.key + "-------");

                // tao phong 
                // socket.join(keyroot.key);
                // socket.phong = keyroot.key;
                // var mang = [];
                // for (r in socket.adapter.rooms) {
                //     mang.push(r);
                // }


                io.sockets.emit("userinitoke", res);

            })
            .catch(err => console.log(err))

    });

    socket.on("deletemesinit", function (data) {
        deleteparentmes(data).then(res => {
            io.sockets.emit("deletemesinitresult", res);
        })
            .catch(err => console.log(err))
    });



    socket.on("mesusersendtoserver", function (data) {
        //    console.log(data);

        socket.leave(socket.phong);

        // tao phong 
        socket.join(data.info.key);
        socket.phong = data.key;

        console.log(data.info.key + "-----------");


        sendmessages(data.info.key, "cus", data.message).then(res => {
            io.sockets.in(socket.phong).emit("messendserverticlientmes", { keyroot: data.info.key, res: res });

            // io.to(socket.phong).emit("mesusersendtoserverresult", { keyroot: data.info.key, res: res });
        })
            .catch(err => console.log(err))



    });

    socket.on("messervertoclientdata", function (data) {

        socket.leave(socket.phong);
        

        // tao phong 
        socket.join(data.keyroot);
        socket.phong = data.keyroot;

        console.log(data.keyroot + "---------");


        sendmessages(data.keyroot, "me", data.mess).then(res => {
            io.sockets.in(socket.phong).emit("messendserverticlientmes", { keyroot: data.keyroot, res: res });
            // io.to(socket.phong).emit("mesusersendtoserverresult", { keyroot: data.keyroot, res: res });
        })
            .catch(err => console.log(err))


    });


    socket.on("dataroomsmesuser", function (data) {
        //    console.log(data);

        

        getdatames(data).then(res => {
            // console.log(res);
            io.sockets.emit("dataroomsmesuserresult", res);

        })
            .catch(err => console.log(err))

    });


    socket.on('deleteonemesroom', function (data) {
        // console.log(data);
        // console.log(data.keyroot);
        // console.log(data.keymes);

        deletemeschild(data.keyroot, data.keymes).then(res => {
            io.sockets.emit('deleteonemesroomresult', res);

        })
            .catch(err => console.log(err))


    });



    socket.on("listparentmess", function () {

        getdataall().then(result => {
            io.sockets.emit("listparentmessresult", result);
        }).catch(err => console.log(err))


    });







    socket.on('disconnect', function () {
        if (socket.id === boss) {
            io.sockets.emit("bossof", "bossoff");
            boss = null;
        }
        users.splice(users.indexOf(socket.username), 1);
    });

    // socket.once("disconnect", function () {
    //     console.log(socket.id);
    // });
});




// function firebase

const urlfirbase = 'https://us-central1-jstorejavachat.cloudfunctions.net/Chat';


let initchat = (name, email, phone) => {
    return new Promise((resolve, reject) => {
        let url = urlfirbase + '/' + encodeURIComponent(name) + '/' + encodeURIComponent(email) + '/' + phone
        request.get(url, (err, res, body) => {
            if (err != null) { return reject(new Error(err)) }
            resolve(body)
        })
    })
}

// initchat('Hảo', 'trơn@gmail.com', '04242424').then(res => console.log(res))
//     .catch(err => console.log(err))


let sendmessages = (rootkey, name, message) => {
    return new Promise((resolve, reject) => {
        let url = urlfirbase + '/app/' + '/' + rootkey + '/' + name + '/' + encodeURIComponent(message)
        request.get(url, (err, res, body) => {
            if (err != null) { return reject(new Error(err)) }
            resolve(body)
        })
    })
}

// sendmessages('-KxJC0fE04mZDrbCvwDE','cus','là nội dung gì').then(res => console.log(res))
//     .catch(err => console.log(err))

let getdataall = () => {
    return new Promise((resolve, reject) => {
        let url = urlfirbase + '/getdatainfo'
        request.get(url, (err, res, body) => {
            if (err != null) { return reject(new Error(err)) }
            return resolve(body)
        })
    })

}
// getdataall().then(result=>console.log(JSON.parse(result))).catch(err=>console.log(err))


let getdatames = (key) => {
    return new Promise((resolve, reject) => {
        let url = urlfirbase + '/getdatames/' + key
        request.get(url, (err, res, body) => {
            if (err != null) { return reject(new Error(err)) }
            resolve(body)
        })
    })
}

// getdatames('-KxJC0fE04mZDrbCvwDE').then(res => console.log(JSON.parse(res)))
//     .catch(err => console.log(err))

let deletemeschild = (keyroot, keymes) => {
    return new Promise((resolve, reject) => {
        let url = urlfirbase + '/app/messages/delete/' + keyroot + '/' + keymes
        request.get(url, (err, res, body) => {
            if (err != null || err == false) { return reject(new Error(err)) }
            resolve(body)
        })
    })
}

// deletemeschild('-KxJC0fE04mZDrbCvwDE','-KxJIjeys1HCVOjFe_Rb').then(res => console.log(JSON.parse(res)))
//     .catch(err => console.log(err))

let deleteparentmes = (keyroot) => {
    return new Promise((resolve, reject) => {
        let url = urlfirbase + '/deleteparentmes/' + keyroot
        request.get(url, (err, res, body) => {
            if (err != null) { return reject(new Error(err)) }
            resolve(body)
        })
    })
}
// getdataall().then(result => console.log(JSON.parse(result))).catch(err => console.log(err))

// deleteparentmes('-KxIxWopIcdNVAQ7W3Rq').then(res => console.log(JSON.parse(res)))
//     .catch(err => console.log(err))



// end function firebase

