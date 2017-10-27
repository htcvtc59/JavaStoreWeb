<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="robots" content="all,follow">
        <title>DangNhap</title>

        <!-- Bootstrap CSS-->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/bootstrap/css/bootstrap.min.css">
        <!-- Google fonts - Roboto -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,700">
        <!-- theme stylesheet-->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/bootstrap/css/style.default.css" id="theme-stylesheet">
        <!-- Custom stylesheet - for your changes-->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/bootstrap/css/custom.css">
        <!-- Favicon-->
        <link rel="shortcut icon" href="<%=request.getContextPath()%>/asset/bootstrap/img/favicon.ico">
        <!-- Font Awesome CDN-->
        <!-- you can replace it by local Font Awesome-->
        <script type="text/javascript" src="https://use.fontawesome.com/99347ac47f.js"></script>
        <!-- Font Icons CSS-->
        <link rel="stylesheet" href="https://file.myfontastic.com/da58YPMQ7U5HY8Rb6UxkNf/icons.css">
        <!-- Tweaks for older IEs--><!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
            <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->

    </head>
    <body>
        <div class="page login-page">
            <div class="container d-flex align-items-center">
                <div class="form-holder has-shadow">
                    <div class="row">
                        <!-- Logo & Information Panel-->
                        <div class="col-lg-6">
                            <div class="info d-flex align-items-center">
                                <div class="content">
                                    <div class="logo">
                                        <h1>Trang Quản Trị</h1>
                                    </div>
                                    <p><img src="../asset/bootstrap/img/favicon.ico" /></p>
                                </div>
                            </div>
                        </div>
                        <!-- Form Panel    -->
                        <div class="col-lg-6 bg-white">
                            <div class="form d-flex align-items-center">
                                <div class="content">
                                    <form id="login-form" action="account" method="post">
                                        <div class="form-group">
                                            <input id="login-username" type="text" name="qtusername" required="true" class="input-material">
                                            <label for="login-username" class="label-material">Tên đăng nhập</label>
                                        </div>
                                        <div class="form-group">
                                            <input id="login-password" type="password" name="qtpassword" required="true" class="input-material">
                                            <label for="login-password" class="label-material">Mật khẩu</label>
                                        </div>
                                        <input type="submit" class="btn btn-primary" value="Đăng nhập"/>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Javascript files-->
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/asset/bootstrap/js/tether.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/asset/bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/asset/bootstrap/js/jquery.cookie.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/asset/bootstrap/js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/asset/bootstrap/js/front.js"></script>
        <!-- Google Analytics: change UA-XXXXX-X to be your site's ID.-->
        <!---->
        <script type="text/javascript" >
            (function (b, o, i, l, e, r) {
                b.GoogleAnalyticsObject = l;
                b[l] || (b[l] =
                        function () {
                            (b[l].q = b[l].q || []).push(arguments)
                        });
                b[l].l = +new Date;
                e = o.createElement(i);
                r = o.getElementsByTagName(i)[0];
                e.src = '//www.google-analytics.com/analytics.js';
                r.parentNode.insertBefore(e, r)
            }(window, document, 'script', 'ga'));
            ga('create', 'UA-XXXXX-X');
            ga('send', 'pageview');
        </script>
    </body>
</html>
