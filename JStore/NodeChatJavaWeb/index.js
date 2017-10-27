var request = require('request');

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

getdatames('-KxR9hBQPlFJI8NX3z3R').then(res => console.log(JSON.parse(res)))
    .catch(err => console.log(err))

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
getdataall().then(result=>console.log(JSON.parse(result))).catch(err=>console.log(err))

// deleteparentmes('-KxIxWopIcdNVAQ7W3Rq').then(res => console.log(JSON.parse(res)))
//     .catch(err => console.log(err))

