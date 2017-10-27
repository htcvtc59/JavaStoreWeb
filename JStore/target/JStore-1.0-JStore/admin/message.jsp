<%@page import="java.sql.Date"%>
<%@page import="com.shop.admin.dto.SlideAdmin"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="robots" content="all,follow">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Slide</title>
        <jsp:include page="../admin/head.jsp" />
        <jsp:include page="../admin/footerjs.jsp" />

        <script src="<%=request.getContextPath()%>/asset/public/socket.io.js" type="text/javascript"></script>

        <script type="text/javascript" >
            var socket = io.connect('http://localhost:3000');
            socket.on('connect', function () {
                socket.emit('bossonline', {socketid: socket.id, name: 'Oke'});

                socket.emit('listparentmess');
            });



            $(document).ready(function () {

                $('#formbtnChat').html(`<input type="text" class="form-control" id="txtMess" />
                                    <span class="input-group-btn"><button class="btn btn-primary" id="btnChat">
                                            Chat
                                        </button></span>`);

                $('#formbtnChat').hide();

                socket.on("messendserverticlientmes", function (data) {
                    var valdata = JSON.parse(data.res);
                    
                    if (valdata.value.name == "me") {
                        $('#listMesUser').append(`<div class="row" id='mesu` + valdata.key + `'>
                                        <div class="col-5 col-lg-5 offset-1 card">
                                            <div class="row">
                                                <div class="col-1">
                                                    <button class="btn btn-danger btndelelemesi" data-id='` + valdata.key + `' data-keyroot='` + data.keyroot + `' ><i class="fa fa-times" 
                                                      aria-hidden="true"></i></button>
                                                </div>
                                                <div class="col-11">
                                                     Me:<h6>` + valdata.value.message + `</h6>
                                          <p>` + new Date(valdata.value.signup).toString() + `</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>`);
                    }


                    if (valdata.value.name == "cus") {

                        $('#listMesUser').append(`<div class="row" id='mesu` + valdata.key + `'>
                                        <div class="col-5 col-lg-5 card offset-6">
                                            <div class="row">
                                                <div class="col-1">
                                                    <button class="btn btn-danger btndelelemesi" data-id='` + valdata.key + `' data-keyroot='` + data.keyroot + `'><i class="fa fa-times" aria-hidden="true"></i></button>
                                                </div>
                                                <div class="col-11">
                                                  <h6>` + valdata.value.message + `</h6>
                                          <p>` + new Date(valdata.value.signup).toString() + `</p>
                                                </div>
                                            </div>
                                        </div>

                                    </div>`);


                    }



                });



                socket.on('listparentmessresult', function (data) {
//                    console.log(JSON.parse(data));

                    var dataall = JSON.parse(data);

                    $.each(dataall, function (i, val) {
                        $('#usermessage').append(`<div class='row card messinit' id='` + i + `' data-id='` + i + `' style="margin-bottom: 5px;">
                                        <div class="col-9 col-lg-9 offset-1" style="height: 100px;">
                                            <div class="row">
                                                <div class="col-1">
                                                    <button class="btn btn-danger" id="btndeletemesinit" data-id='` + i + `'><i class="fa fa-times" aria-hidden="true"></i></button>
                                                </div>
                                                <div class="col-11">
                                    <div class="col-4">
                                  ` + val.name + `
                                             </div>
                                   <div class="col-8">
                                  ` + val.email + ` ` + val.phone + `
                                             </div>
        
                                                </div>
                                            </div>
                                        </div>
                                    </div>`);

                    });

                });


                socket.on("userdatainit", function (data) {
                    var valdata = JSON.parse(data);
//                    console.log(valdata);
                    $('#usermessage').append(`<div class='row card messinit' id='` + valdata.key + `' data-id='` + valdata.key + `' style="margin-bottom: 5px;">
                                        <div class="col-9 col-lg-9 offset-1" style="height: 100px;">
                                            <div class="row">
                                                <div class="col-1">
                                                    <button class="btn btn-danger" id="btndeletemesinit" data-id='` + valdata.key + `'><i class="fa fa-times" aria-hidden="true"></i></button>
                                                </div>
                                                <div class="col-11">
                                    <div class="col-4">
                                  ` + valdata.value.name + `
                                             </div>
                                   <div class="col-8">
                                  ` + valdata.value.email + ` ` + valdata.value.phone + `
                                             </div>
        
                                                </div>
                                            </div>
                                        </div>
                                    </div>`);
                });

                $("body").off('click').on('click', '#btndeletemesinit', function () {

                    var messageid = $(this).data('id');

//                    alert(messageid);

                    socket.emit('deletemesinit', messageid);
                    socket.on('deletemesinitresult', function (data) {
                        var valdata = JSON.parse(data);
                        if (valdata.key == messageid) {
                            $('#' + messageid).remove();
                            $('#formbtnChat').hide();
                            $('#listMesUser').html("");

                        }
                    });
                });

                $(document).off('click').on('click', '.messinit', function () {
                    var idmesroot = $(this).data('id');

//                    alert(idmesroot);

                    socket.emit('dataroomsmesuser', idmesroot);

                    $('#formbtnChat').html(`<input type="text" class="form-control" id="txtMess" />
                                    <span class="input-group-btn"><button class="btn btn-primary" id="btnChat">
                                            Chat
                                        </button></span>`);

                    $('#btnChat').attr('data-id', idmesroot);
                    $('#formbtnChat').show(1000);

                    socket.on('dataroomsmesuserresult', function (data) {

//                        console.log(data);

                        var valdata = JSON.parse(data);

                        $('#listMesUser').html("");

                        $.each(valdata, function (i, val) {

                            if (val.name == "me") {

                                $('#listMesUser').append(`<div class="row" id='mesu` + i + `'>
                                        <div class="col-5 col-lg-5 offset-1 card">
                                            <div class="row">
                                                <div class="col-1">
                                                    <button class="btn btn-danger btndelelemesi" data-id='` + i + `' data-keyroot='` + idmesroot + `' ><i class="fa fa-times" 
                                                      aria-hidden="true"></i></button>
                                                </div>
                                                <div class="col-11">
                                                     Me:<h6>` + val.message + `</h6>
                                          <p>` + new Date(val.signup).toString() + `</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>`);
                            }

                            if (val.name == "cus") {

                                $('#listMesUser').append(`<div class="row" id='mesu` + i + `'>
                                        <div class="col-5 col-lg-5 card offset-6">
                                            <div class="row">
                                                <div class="col-1">
                                                    <button class="btn btn-danger btndelelemesi" data-id='` + i + `' data-keyroot='` + idmesroot + `'><i class="fa fa-times" aria-hidden="true"></i></button>
                                                </div>
                                                <div class="col-11">
                                                  <h6>` + val.message + `</h6>
                                          <p>` + new Date(val.signup).toString() + `</p>
                                                </div>
                                            </div>
                                        </div>

                                    </div>`);
                            }

                        });

                    });

                });



                $("body").on('click', '.btndelelemesi', function () {
//                    alert($(this).data('id') + "----" + $(this).data('keyroot'));
                    socket.emit("deleteonemesroom", {keyroot: $(this).data('keyroot'), keymes: $(this).data('id')})

                    socket.on("deleteonemesroomresult", function (data) {
//                        console.log(data);
                        var valdata = JSON.parse(data);
                        $('#mesu' + valdata.key).remove();


                    });

                });


                $("body").on('click', '#btnChat', function () {

                    alert($('#txtMess').val() + "-----" + $(this).data('id'));

                    socket.emit("messervertoclientdata", {keyroot: $(this).data('id'), mess: $('#txtMess').val()});



                });



            });
        </script>

        <!--Scroll-->
        <script type="text/javascript" src="<%=request.getContextPath()%>/asset/public/jquery.scrollbar.min.js"></script>
        <link href="<%=request.getContextPath()%>/asset/public/jquery.scrollbar.css" rel="stylesheet" type="text/css">
        <script type="text/javascript">
            jQuery(document).ready(function () {
                jQuery('.scrollbar-inner').scrollbar();
            });
        </script>
    </head>
    <body>
        <jsp:include page="../admin/menu.jsp" />
        <div class="container-fluid">
            <div class="row" style="min-height: 50rem;">
                <div class="col-12 col-sm-12 col-xl-12 col-md-12 col-lg-12">
                    <div class="row">
                        <div class="col-4 col-lg-4" >
                            <div class="card" style="height: 600px; margin-top: 100px;">
                                <!--Start Mess Uer-->
                                <div class="container scrollbar-inner" id="usermessage">



                                </div>
                                <!--End Mess Uer-->

                            </div>

                        </div>

                        <div class="col-8 col-lg-8" style="position: relative;">
                            <div class="card" style="height: 600px; margin-top: 100px; width: 100%;">
                                <div class="container scrollbar-inner" id="listMesUser">






                                </div>


                                <!--<textarea class="form-control" rows="20" id="txtareaMes"></textarea>-->


                                <div class="input-group input-group-md" style="position: absolute; bottom: 5px;" id="formbtnChat">

                                </div>


                            </div>
                        </div>
                        <!--End Mess All-->

                    </div>

                </div>
            </div>
        </div>

        <jsp:include page="../admin/footer.jsp" />

    </body>
</html>
