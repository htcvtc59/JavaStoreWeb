<%@page import="com.shop.client.CartChild"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@page import="com.shop.client.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="head.jsp" />
    </head>
    <body> 
        <jsp:include page="bodyheader.jsp" />
        <!-- products-breadcrumb -->
        <div class="products-breadcrumb">
            <div class="container">
                <ul>
                    <li><i class="fa fa-home" aria-hidden="true"></i><a href="index.html">Home</a><span>|</span></li>
                    <li>Checkout</li>
                </ul>
            </div>
        </div>
        <!-- //products-breadcrumb -->
        <!-- banner -->
        <div class="banner">
            <jsp:include page="bannernavleft.jsp" />
            <div class="w3l_banner_nav_right">
                
                <!-- about -->
                <div class="privacy about">
                    <h3>Chec<span>kout</span></h3>
                    <h1>${cartmessage}</h1>

                    <div class="checkout-right">
                        <h4>Your shopping cart contains: 
                            <span>
                                <%  if (session.getAttribute("cart") != null) {
                                        Cart cart1 = (Cart) session.getAttribute("cart");
                                        Hashtable content1 = cart1.getContent();

                                %> <%=content1.size()%> <%}%>Products 
                            </span></h4>
                        <table class="timetable_sub">
                            <thead>
                                <tr>
                                    <th>SL No.</th>	
                                    <th>Product</th>
                                    <th>Quality</th>
                                    <th>Product Name</th>

                                    <th>Price</th>
                                    <th>Remove</th>
                                </tr>
                            </thead>
                            <tbody>
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
                                            String image = cc.getProduct().getImages();
                                            Double price = cc.getProduct().getPromotionprice();
                                            int quantity = cc.getQuantity();

                                %>
                                <tr class="rem<%=j%>">
                                    <td class="invert"><%=j%></td>
                                    <td class="invert-image"><a href="#"><img src="<%=image%>" alt=" " height="30" width="30" class="img-responsive" /></a></td>
                                    <td class="invert">
                                        <div class="quantity"> 
                                            <div class="quantity-select">                           
                                                <div class="entry value-minus" data-id="<%=id%>" >&nbsp;</div>
                                                <div class="entry value"><span><%=quantity%></span></div>
                                                <div class="entry value-plus active" data-id="<%=id%>" >&nbsp;</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="invert"><%=name%></td>

                                    <td class="invert cartprice<%=id%>" >$<%=(price * quantity)%></td>
                                    <td class="invert">
                                        <div class="rem">
                                            <div class="close1" data-j="<%=j%>" data-id="<%=id%>"> </div>
                                        </div>

                                    </td>
                                </tr>

                                <%  }
                                    }
                                %>
                            </tbody></table>
                    </div>
                    <div class="checkout-left">	
                        <div class="col-md-4 checkout-left-basket">
                            <h4>Continue to basket</h4>
                            <ul>
                                <!--<li>Product1 <i>-</i> <span>$15.00 </span></li>-->
                                <!--<li>Product2 <i>-</i> <span>$25.00 </span></li>-->
                                <!--<li>Product3 <i>-</i> <span>$29.00 </span></li>-->
                                <!--<li>Total Service Charges <i>-</i> <span>$15.00</span></li>-->
                                <li>Total <i>-</i> <span id="total2u" >$<%
                                    if (session.getAttribute("cart") != null) {
                                        Cart cart2 = (Cart) session.getAttribute("cart");
                                        Hashtable content2 = cart2.getContent();
                                        Enumeration e2 = content2.keys();
                                        Double total2 = 0.0;
                                        while (e2.hasMoreElements()) {
                                            String id = e2.nextElement().toString();
                                            CartChild cc2 = (CartChild) content2.get(id);
                                            Double price = cc2.getProduct().getPromotionprice();
                                            int quantity = cc2.getQuantity();
                                            total2 += price * quantity;
                                        }
                                        %> <%=total2%> <% }%></span></li>
                            </ul>
                        </div>
                        <div class="col-md-8 address_form_agile">
                            <h4>Ship</h4>
                            <form action="mailstore" method="post" class="creditly-card-form agileinfo_form">
                                <section class="creditly-wrapper wthree, w3_agileits_wrapper">
                                    <div class="information-wrapper">
                                        <div class="first-row form-group">
                                            <div class="controls">
                                                <label class="control-label">Full name: </label>
                                                <input class="billing-address-name form-control" type="text" name="txtname" placeholder="Full name">
                                            </div>
                                            <div class="w3_agileits_card_number_grids">
                                                <div class="w3_agileits_card_number_grid_left">
                                                    <div class="controls">
                                                        <label class="control-label">Mobile number:</label>
                                                        <input class="form-control" type="text" name="txtmobile" placeholder="Mobile number">
                                                    </div>
                                                </div>
                                                <div class="w3_agileits_card_number_grid_right">
                                                    <div class="controls">
                                                        <label class="control-label">Email: </label>
                                                        <input class="form-control" type="text" name="txtemail" placeholder="Email">
                                                    </div>
                                                </div>
                                                <div class="clear"> </div>
                                            </div>
                                            <div class="controls">
                                                <label class="control-label">City: </label>
                                                <textarea class="form-control" type="text" name="txtcity" placeholder="City"></textarea>
                                            </div>
                                        </div>
                                        <button class="submit check_out">Delivery to this Address</button>
                                    </div>
                                </section>
                            </form>
                            <div class="checkout-right-basket">
                                <a href="payment.jsp">Make a Payment Other<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span></a>
                            </div>
                        </div>

                        <div class="clearfix"> </div>

                    </div>

                </div>
                <!-- //about -->
            </div>
            <div class="clearfix"></div>
        </div>
        <!-- //banner -->
        <jsp:include page="footer.jsp" />
        <jsp:include page="footerscript.jsp" />

        <!-- js -->
        <script type="text/javascript" src="<%=request.getContextPath()%>/asset/client/js/jquery-1.11.1.min.js"></script>
        <!--quantity-->
        <script type="text/javascript">
            $('.value-plus').on('click', function () {
                var divUpd = $(this).parent().find('.value'), newVal = parseInt(divUpd.text(), 10) + 1;
                divUpd.text(newVal);

                var cartlist = [];
                cartlist.push({
                    id: $(this).data("id"),
                    quantity: newVal,
                    action: 'update'

                });

                console.log(cartlist);

                $.ajax({
                    url: 'gio_hang_san_pham',
                    data: JSON.stringify(cartlist),
                    dataType: 'json',
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    success: function (res) {
                        if (res.status == true) {
                            $('#total2u').text("$" + res.total2);
                            $('.cartprice' + res.id).text("$" + res["price2" + res.id]);
                        }
                        console.log(res);
                    }
                });

            });

            $('.value-minus').on('click', function () {
                var divUpd = $(this).parent().find('.value'), newVal = parseInt(divUpd.text(), 10) - 1;
                if (newVal >= 1)
                    divUpd.text(newVal);

                if (newVal == 0) {
                    newVal = 1;
                }

                var cartlist = [];
                cartlist.push({
                    id: $(this).data("id"),
                    quantity: newVal,
                    action: 'update'

                });

                console.log(cartlist);

                $.ajax({
                    url: 'gio_hang_san_pham',
                    data: JSON.stringify(cartlist),
                    dataType: 'json',
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    success: function (res) {
                        if (res.status == true) {
                            $('#total2u').text("$" + res.total2);
                            $('.cartprice' + res.id).text("$" + res["price2" + res.id]);
                        }
                        console.log(res);
                    }
                });

            });
        </script>
        <!--quantity-->
        <script type="text/javascript">
            $(document).ready(function (c) {

                $('.close1').on('click', function (c) {
                    var j = $(this).data("j");
                    var id = $(this).data("id");

                    $.ajax({
                        url: 'gio_hang_san_pham',
                        data: {id: id, action: 'delete'},
                        dataType: 'json',
                        type: 'POST',
                        success: function (res) {
                            if (res.status == true) {
                                $('#total2u').text("$" + res.total2);
                            }
                        }
                    });


                    $('.rem' + j).fadeOut('slow', function (c) {
                        $('.rem' + j).remove();
                    });
                });





            });
        </script>


        <!-- //js -->
        <!-- script-for sticky-nav -->
        <script>
            $(document).ready(function () {
                var navoffeset = $(".agileits_header").offset().top;
                $(window).scroll(function () {
                    var scrollpos = $(window).scrollTop();
                    if (scrollpos >= navoffeset) {
                        $(".agileits_header").addClass("fixed");
                    } else {
                        $(".agileits_header").removeClass("fixed");
                    }
                });

            });
        </script>
        <!-- //script-for sticky-nav -->
    </body>
</html>
