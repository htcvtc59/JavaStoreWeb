<%-- 
    Document   : login
    Created on : Oct 13, 2017, 9:09:48 AM
    Author     : MacOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="head.jsp" />
        <script type="text/javascript" src="https://www.google.com/recaptcha/api.js" async defer></script>
    </head>
    <body>
        <jsp:include page="bodyheader.jsp" />
        <!-- products-breadcrumb -->
        <div class="products-breadcrumb">
            <div class="container">
                <ul>
                    <li><i class="fa fa-home" aria-hidden="true"></i><a href="trang_chu">Home</a><span>|</span></li>
                    <li>Sign In & Sign Up</li>
                </ul>
            </div>
        </div>
        <!-- //products-breadcrumb -->
        <jsp:include page="bannernavleft.jsp" />
        <div class="w3l_banner_nav_right">

            <!-- login -->
            <div class="w3_login">
                <h3>Sign In & Sign Up</h3>
                    <h3><% if (request.getAttribute("status") != null) {
                        String status = (String)request.getAttribute("status");
                        %><%=status%><%
                    }%></h3>
                <div class="w3_login_module">
                    <div class="module form-module">
                        <div class="toggle"><i class="fa fa-times fa-pencil"></i>
                            <div class="tooltip">Click Me</div>
                        </div>
                        <div class="form">
                            <h2>Login to your account</h2>
                            <form action="tai_khoan_kh?action=form" method="post">
                                <input type="text" name="Username" placeholder="Username" required=" ">
                                <input type="password" name="Password" placeholder="Password" required=" ">
                                <div class="g-recaptcha" data-sitekey="6LdX_TQUAAAAAG8PZYBLbuHRFHMrUkwUW95eAkth"></div>

                                <input type="submit" value="Login">
                            </form>

                            <!--Login With Google and Facebook-->

                            <fb:login-button scope="public_profile,email" onlogin="checkLoginState();"
                                             class="fb-login-button" data-max-rows="1" 
                                             data-size="large"
                                             data-button-type="login_with" 
                                             data-show-faces="false" data-auto-logout-link="false" 
                                             data-use-continue-as="true" 
                                             >
                            </fb:login-button>

                            <div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div>

                            <!--End Login Google Facebook-->
                        </div>
                        <div class="form">
                            <h2>Create an account</h2>
                            <form action="tai_khoan_kh?action=addclient" method="post">
                                <input type="text" name="txtcRealname" placeholder="Realname" required=" ">
                                <input type="text" name="txtcUsername" placeholder="Username" required=" ">
                                <input type="password" name="txtcPassword" placeholder="Password" required=" ">
                                <input type="email" name="txtcEmail" placeholder="Email Address" required=" ">
                                <input type="submit" value="Register">
                            </form>
                        </div>
                        <div class="cta"><a href="#">Forgot your password?</a></div>
                    </div>
                </div>
                <script>
                    $('.toggle').click(function () {
                        // Switches the Icon
                        $(this).children('i').toggleClass('fa-pencil');
                        // Switches the forms  
                        $('.form').animate({
                            height: "toggle",
                            'padding-top': 'toggle',
                            'padding-bottom': 'toggle',
                            opacity: "toggle"
                        }, "slow");
                    });
                </script>
            </div>
            <!-- //login -->
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- //banner -->
    <!-- newsletter-top-serv-btm -->
    <div class="newsletter-top-serv-btm">
        <div class="container">
            <div class="col-md-4 wthree_news_top_serv_btm_grid">
                <div class="wthree_news_top_serv_btm_grid_icon">
                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                </div>
                <h3>Nam libero tempore</h3>
                <p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus 
                    saepe eveniet ut et voluptates repudiandae sint et.</p>
            </div>
            <div class="col-md-4 wthree_news_top_serv_btm_grid">
                <div class="wthree_news_top_serv_btm_grid_icon">
                    <i class="fa fa-bar-chart" aria-hidden="true"></i>
                </div>
                <h3>officiis debitis aut rerum</h3>
                <p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus 
                    saepe eveniet ut et voluptates repudiandae sint et.</p>
            </div>
            <div class="col-md-4 wthree_news_top_serv_btm_grid">
                <div class="wthree_news_top_serv_btm_grid_icon">
                    <i class="fa fa-truck" aria-hidden="true"></i>
                </div>
                <h3>eveniet ut et voluptates</h3>
                <p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus 
                    saepe eveniet ut et voluptates repudiandae sint et.</p>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
    <!-- //newsletter-top-serv-btm -->

    <jsp:include page="footer.jsp" />
    <jsp:include page="footerscript.jsp" />

</body>
</html>
