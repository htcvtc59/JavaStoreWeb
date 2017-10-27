<html>

    <head>
        <title>Shop</title>
        <!--Import Google Icon Font-->
        <link type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/materialize/css/materialize.min.css"  media="screen,projection"/>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <script type="text/javascript" src="<%=request.getContextPath()%>/asset/public/jquery-3.2.1.min.js"></script>
        <script src="<%=request.getContextPath()%>/asset/public/socket.io.js" type="text/javascript"></script>

        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" type="text/css">-->
        <script type="text/javascript">
            var socket = io.connect('http://localhost:3000');

            socket.on('connect', () => {
                socket.send('hi');
                socket.on('message', function (msg) {
                    console.log(msg);
                });

            });

            socket.on('bossol', (data) => {
                if (data[0].name == "Oke") {
                    $('#bossolof').html(`<h5>ADMIN STORE ONLINE</h5>`);
                }
            });

            socket.on('bossof', (data) => {
                if (data == "bossoff") {
                    $('#bossolof').html("");
                }
            });



            $(document).ready(function () {

                var userinfo = null;

                $('#forminitChat').off('click').on('click', function () {
                    var name = $('#txtname').val();
                    var email = $('#txtemail').val();
                    var phone = $('#txtphone').val();

                    socket.emit('client-send-initchat', {name: name, email: email, phone: phone});
                });


                socket.on("userinitoke", function (data) {
                    var valdata = JSON.parse(data);
                    if (valdata != null) {
                        $('#intChatForm').hide(1000);
                        $('#chatForm').show(1000);

                        userinfo = valdata;


                        $('#btnSendMes').attr('data-id', valdata.key);
                    }

                });


                $('#btnSendMes').off('click').on('click', function () {

//                    alert($('#btnSendMes').data('id'));

                    socket.emit('mesusersendtoserver', {message: $('#txtmessage').val(), info: userinfo, key: $('#btnSendMes').data('id')});

                });



                socket.on("messendserverticlientmes", function (data) {
                    var valdata = JSON.parse(data.res);
//                    console.log(data);
//                    console.log(data.keyroot);
//                    console.log(data.res.value.name);


                    if (valdata.value.name == "cus") {
//                        console.log(data);

                        $('.simplebar-content').append(`<div class="row" >
                        <div class="col s8 card">
                            <div class="row">
                                <div class="col s12" >
                                    Me:<h6>` + valdata.value.message + `</h6>
                                          <p>` + new Date(valdata.value.signup).toString() + `</p>
                                </div>
                            </div>
                        </div>
                        <div class="col s4"></div>
                    </div>`);


                    }

                    if (valdata.value.name == "me") {

                        $('.simplebar-content').append(`<div class="row" >
                        <div class="col s4"></div>
                        <div class="col s8 card">
                            <div class="row">
                                <div class="col s12">
                                    Admin:<h6>` + valdata.value.message + `</h6>
                                          <p>` + new Date(valdata.value.signup).toString() + `</p>
                                </div>
                            </div>
                        </div>
                    </div>`);


                    }




                });
              

                socket.on('disconnect', () => {
                    userinfo = null;
                });


            });



        </script>

        <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/public/style.css" type="text/css">
        <!--<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/public/jquery.scrollbar.css" >-->
        <!--<script type="text/javascript" src="<%=request.getContextPath()%>/asset/public/jquery.scrollbar.min.js"></script>-->

        <!--<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/asset/bootstrap/css/bootstrap.min.css">-->
        <script type="text/javascript" src="<%=request.getContextPath()%>/asset/materialize/js/materialize.min.js"></script>
        <link rel="stylesheet" href="https://unpkg.com/simplebar@latest/dist/simplebar.css" />
        <script src="https://unpkg.com/simplebar@latest/dist/simplebar.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                $('#intChatForm').show();
                $('#chatForm').hide();


            });
        </script>
    </head>

    <body>
        <div class="row" >
            <div class="col s12" id="bossolof"></div>
            <div class="col s12 m4 l4"></div>
            <div class="col s12 m4 l4 card" id="intChatForm">
                <form >
                    <div class="input-field col s12">
                        <input id="txtname" type="text" class="validate">
                        <label for="txtname">Name</label>
                    </div>
                    <div class="input-field col s12">
                        <input id="txtemail" type="email" class="validate">
                        <label for="txtemail">Email</label>
                    </div>
                    <div class="input-field col s12">
                        <input id="txtphone" type="number" class="validate">
                        <label for="txtphone">Phone</label>
                    </div>
                    <div class="input-field col s12">
                        <a type="submit" class="waves-effect waves-light btn" id="forminitChat">Chat</a>
                    </div>
                </form>

            </div>
            <div class="col s12 m4 l4"></div>
        </div>

        <div class="row" id="chatForm">
            <div class="col s12"></div>
            <div class="col s12 m4 l3"></div>
            <div class="col s12 m4 l6 card"  >
                <div data-simplebar  style="height: 500px;" >



                </div>


                <div class="row">
                    <div class="col s12">
                        <div class="input-field col s8 l8">
                            <input id="txtmessage" type="text" class="validate">
                            <label for="message" data-error="wrong" data-success="right">Message</label>
                            <button class="waves-effect waves-light btn" id="btnSendMes">Send</button>
                        </div>

                    </div>
                </div>



            </div>
            <div class="col s12 m4 l3"></div>
        </div>
    </body>
</html>