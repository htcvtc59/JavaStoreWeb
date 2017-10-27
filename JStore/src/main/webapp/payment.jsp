
<%@page import="com.shop.client.CartChild"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@page import="com.shop.client.Cart"%>
<%@page import="com.shop.client.encodedecode.EncryptionDecryption"%>
<%@page import="com.shop.admin.dto.ProductAdmin"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="head.jsp" />

        <script src="https://www.paypalobjects.com/api/checkout.js"></script>

    </head>
    <body>
        <jsp:include page="bodyheader.jsp" />
        <!-- products-breadcrumb -->
        <div class="products-breadcrumb">
            <div class="container">
                <ul>
                    <li><i class="fa fa-home" aria-hidden="true"></i><a href="index.html">Home</a><span>|</span></li>
                    <li>Payment</li>
                </ul>
            </div>
        </div>
        <!-- //products-breadcrumb -->
        <!-- banner -->
        <div class="banner">
            <jsp:include page="bannernavleft.jsp"/>
            <div class="w3l_banner_nav_right">
                <!-- payment -->
                <div class="privacy about">
                    <h3>Pay<span>ment</span></h3>
                    <h1>${cartmessage}</h1>
                    <div class="checkout-right">
                        <!--Horizontal Tab-->
                        <div id="parentHorizontalTab">
                            <ul class="resp-tabs-list hor_1">
                                <li>Paypal</li>
                                <li>BaoKim</li>
                                <li>StripeJS</li>
                            </ul>
                            <div class="resp-tabs-container hor_1">
                                <div>
                                    <!--target="paypal"-->
                                    <form target="_top" action="${initParam['posturl']}" method="post" >

                                        <input type="hidden" name="business" value="${initParam['business']}"/>
                                        <input type="hidden" name="cmd" value="_cart"/>
                                        <!--<input type="hidden" name="add" value="1"/>-->
                                        <input type="hidden" name="upload" value="1"/>
                                        <!--<input type="hidden" name="display" value="1"/>-->

                                        <input type="hidden" name="return" value="${initParam['returnurl']}"/>
                                        <input type="hidden" name="cancel_return" value="${initParam['cancelreturnurl']}"/>

            <!--<input type="hidden" name="paymentaction" value="${initParam['authtoken']}"/>-->
                                        <!--<input type="hidden" name="currency_code" value="USD"/>-->

                                        <%
                                            if (session.getAttribute("cart") != null) {

                                                Cart cart = (Cart) session.getAttribute("cart");
                                                Hashtable content = cart.getContent();
                                                Enumeration e = content.keys();
                                                int j = 0;
                                                while (e.hasMoreElements()) {
                                                    j++;
                                                    String id = e.nextElement().toString();
                                                    CartChild cc = (CartChild) content.get(id);
                                                    String name = cc.getProduct().getName();
                                                    Double price = cc.getProduct().getPromotionprice();
                                                    int quantity = cc.getQuantity();
                                        %>
                                        <input type="hidden" name="item_name_<%=j%>" value="<%=name%>"/>
                                        <input type="hidden" name="item_number_<%=j%>" value="p1"/>
                                        <input type="hidden" name="amount_<%=j%>" value="<%=price%>"/>
                                        <input type="hidden" name="quantity_<%=j%>" value="<%=quantity%>"/>


                                        <%}
                                            }%>


                                        <input type="image" name="submit"
                                               src="https://www.paypalobjects.com/en_US/i/btn/btn_xpressCheckout.gif"
                                               alt="Payplay">

                                    </form>
                                </div>
                                <div>
                                    <a type="image" href="dichvuthanhtoankhac?action=paybkim" >
                                        <img alt="Thanh toán an toàn với Bảo Kim !" 
                                             title="Thanh toán trực tuyến an toàn dùng tài khoản Ngân hàng (VietcomBank, TechcomBank, Đông Á, VietinBank, Quân Đội, VIB, SHB,... và thẻ Quốc tế (Visa, Master Card...) qua Cổng thanh toán trực tuyến BảoKim.vn"
                                             border="0" src="http://www.baokim.vn/developers/uploads/baokim_btn/thanhtoanantoan-l.png" />
                                    </a>
                                </div>
                                <div>
                                    <%
                                        if (session.getAttribute("cart") != null) {

                                            Cart cart = (Cart) session.getAttribute("cart");
                                            Hashtable content = cart.getContent();
                                            Enumeration e = content.keys();
                                            Double price = 0.0;
                                            while (e.hasMoreElements()) {
                                                String id = e.nextElement().toString();
                                                CartChild cc = (CartChild) content.get(id);
                                                price += cc.getProduct().getPromotionprice() * cc.getQuantity();
                                            }
                                            int priceint = (int) Math.round(price);

                                    %>
                                    <form action="dichvuthanhtoankhac?action=stripe" method="POST">
                                        <script
                                            src="https://checkout.stripe.com/checkout.js" class="stripe-button"
                                            data-key="pk_test_dMOrASP37wKPhaCQaxegqxaf"
                                            data-amount=<%=priceint*100%>
                                            data-name="ThanhToan"
                                            data-description="Store"
                                            data-image="https://stripe.com/img/documentation/checkout/marketplace.png"
                                            data-locale="auto">
                                        </script>
                                    </form>

                                    <%}%>
                                </div>



                            </div>
                        </div>

                        <!--Plug-in Initialisation-->

                        <!-- // Pay -->

                    </div>

                </div>
                <!-- //payment -->
            </div>
            <div class="clearfix"></div>
        </div>
        <!-- //banner -->

        <!-- js -->
        <script src="<%=request.getContextPath()%>/asset/client/js/jquery-1.11.1.min.js"></script>
        <!-- easy-responsive-tabs -->    
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/asset/client/css/easy-responsive-tabs.css " />
        <script src="<%=request.getContextPath()%>/asset/client/js/easyResponsiveTabs.js"></script>
        <!-- //easy-responsive-tabs --> 
        <script type="text/javascript">
                                                $(document).ready(function () {
                                                    //Horizontal Tab
                                                    $('#parentHorizontalTab').easyResponsiveTabs({
                                                        type: 'default', //Types: default, vertical, accordion
                                                        width: 'auto', //auto or any width like 600px
                                                        fit: true, // 100% fit in a container
                                                        tabidentify: 'hor_1', // The tab groups identifier
                                                        activate: function (event) { // Callback function if tab is switched
                                                            var $tab = $(this);
                                                            var $info = $('#nested-tabInfo');
                                                            var $name = $('span', $info);
                                                            $name.text($tab.text());
                                                            $info.show();
                                                        }
                                                    });
                                                });
        </script>
        <!-- credit-card -->

        <script type="text/javascript" src="<%=request.getContextPath()%>/asset/client/js/creditly.js"></script>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/client/css/creditly.css" type="text/css" media="all" />

        <script type="text/javascript">
                                                $(function () {
                                                    var creditly = Creditly.initialize(
                                                            '.creditly-wrapper .expiration-month-and-year',
                                                            '.creditly-wrapper .credit-card-number',
                                                            '.creditly-wrapper .security-code',
                                                            '.creditly-wrapper .card-type');

                                                    $(".creditly-card-form .submit").click(function (e) {
                                                        e.preventDefault();
                                                        var output = creditly.validate();
                                                        if (output) {
                                                            // Your validated credit card output
                                                            console.log(output);
                                                        }
                                                    });
                                                });
        </script>
        <!-- //credit-card -->

        <jsp:include page="footer.jsp" />

        <!-- Bootstrap Core JavaScript -->
        <script src="<%=request.getContextPath()%>/asset/client/js/bootstrap.min.js"></script>

        <script type="text/javascript" >
                                                $(document).ready(function () {
                                                    $(".dropdown").hover(
                                                            function () {
                                                                $('.dropdown-menu', this).stop(true, true).slideDown("fast");
                                                                $(this).toggleClass('open');
                                                            },
                                                            function () {
                                                                $('.dropdown-menu', this).stop(true, true).slideUp("fast");
                                                                $(this).toggleClass('open');
                                                            }
                                                    );
                                                });
        </script>
        <!-- here stars scrolling icon -->



    </body>
</html>
