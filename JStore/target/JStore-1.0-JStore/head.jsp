<%@page contentType="text/html" pageEncoding="UTF-8"%>
<title>Online Shopping</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Grocery Store Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
      Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
    function hideURLbar(){ window.scrollTo(0,1); } </script>
<link rel="shortcut icon" href="<%=request.getContextPath()%>/asset/bootstrap/img/favicon.ico">

<!-- //for-mobile-apps -->
<link href="<%=request.getContextPath()%>/asset/client/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<link href="<%=request.getContextPath()%>/asset/client/css/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- font-awesome icons -->
<link href="<%=request.getContextPath()%>/asset/client/css/font-awesome.css" rel="stylesheet" type="text/css" media="all" /> 
<!-- //font-awesome icons -->
<!-- js -->
<script src="<%=request.getContextPath()%>/asset/client/js/jquery-1.11.1.min.js"></script>
<!-- //js -->
<link href='//fonts.googleapis.com/css?family=Ubuntu:400,300,300italic,400italic,500,500italic,700,700italic' rel='stylesheet' type='text/css'>
<link href='//fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
<!-- start-smoth-scrolling -->
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/client/js/move-top.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/client/js/easing.js"></script>
<script type="text/javascript">
    jQuery(document).ready(function ($) {
        $(".scroll").click(function (event) {
            event.preventDefault();
            $('html,body').animate({scrollTop: $(this.hash).offset().top}, 1000);
        });
    });</script>
<!-- start-smoth-scrolling -->


<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="559136337775-q7q16rtkmts1ul40lkre0glkf5otspbu.apps.googleusercontent.com">
<script type="text/javascript" src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>

<!--Login With Google and Facebook-->

<script type="text/javascript">
    function statusChangeCallback(response) {
//                                        console.log('statusChangeCallback');
//                                        console.log(response);

        if (response.status === 'connected') {
            testAPI();
        } else {

            document.getElementById('status').innerHTML = 'Please log ' +
                    'into this app.';
        }
    }

    function checkLoginState() {
        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);
        });
    }

    window.fbAsyncInit = function () {
        FB.init({
            appId: '1405560769493137',
            cookie: true,
            xfbml: true,
            version: 'v2.8'
        });
//    FB.getLoginStatus(function (response) {
//        statusChangeCallback(response);
//    });

    };
    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id))
            return;
        js = d.createElement(s);
        js.id = id;
        js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.10&appId=1405560769493137";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
    function testAPI() {
//                                        console.log('Welcome!  Fetching your information.... ');
        FB.api('/me?fields=id,name,email,picture', function (response) {
            var jsonObj = JSON.stringify(response.picture);
            var arr = JSON.parse(jsonObj);
            var datas = {
                idf: response.id,
                namef: response.name,
                emailf: response.email,
                imagef: arr.data.url
            }


//$('.fb-login-button').off('click').on('click', function () {

            $.ajax({
                type: 'POST',
                url: "tai_khoan_kh?action=fb",
                contentType: 'application/json;charset=utf-8',
                data: JSON.stringify(datas),
                success: function (res) {
                    if (res.status == true) {
                        window.location.href = "http://localhost:8084/JStore/trang_chu";
                        console.log(res.status);
                    }
                },
                timeout: 2000
            });
//});






//                                            console.log(response.id + response.name + response.email + arr.data.url);

        });
    }

    function fbLogoutUser() {
        FB.getLoginStatus(function (response) {
            if (response && response.status === 'connected') {
                FB.logout(function (response) {
                    document.location.reload();
                });
            }
        });
    }

</script>

<!--Google-->
<script type="text/javascript">
    function onSignIn(googleUser) {
        // Useful data for your client-side scripts:
        var profile = googleUser.getBasicProfile();
        var data = {
            id: profile.getId(),
            fullname: profile.getName(),
            givenname: profile.getGivenName(),
            fimalyname: profile.getFamilyName(),
            imageurl: profile.getImageUrl(),
            email: profile.getEmail()
        }

        $.ajax({
            type: 'POST',
            url: "tai_khoan_kh?action=gg",
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(data),
            success: function (res) {
                if (res.status == true) {
                    window.location.href = "http://localhost:8084/JStore/trang_chu";
                    console.log(res.status);
                }
            },
            timeout: 2000
        });
//                                        console.log("ID: " + profile.getId());
//                                        console.log('Full Name: ' + profile.getName());
//                                        console.log('Given Name: ' + profile.getGivenName());
//                                        console.log('Family Name: ' + profile.getFamilyName());
//                                        console.log("Image URL: " + profile.getImageUrl());
//                                        console.log("Email: " + profile.getEmail());
//
//
//                                        var id_token = googleUser.getAuthResponse().id_token;
//                                        console.log("ID Token: " + id_token);
    }
    ;</script>

<!--Sign out google-->
<script type="text/javascript">
    function signOut() {
        var auth2 = gapi.auth2.getAuthInstance();
        auth2.signOut().then(function () {
            console.log('User signed out.');
        });
    }

    function onLoad() {
        gapi.load('auth2', function () {
            gapi.auth2.init();
            signOut();
        });
    }
</script>
