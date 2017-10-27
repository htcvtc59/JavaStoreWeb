
<%@page import="com.shop.client.encodedecode.EncryptionDecryption"%>
<%@page import="com.shop.admin.dto.ProductAdmin"%>
<%@page import="java.util.ArrayList"%>
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
                    <li><i class="fa fa-home" aria-hidden="true"></i><a href="trang_chu">Home</a><span>|</span></li>
                    <li>Branded Foods</li>
                </ul>
            </div>
        </div>
        <!-- //products-breadcrumb -->
        <!-- banner -->
        <div class="banner">
            <jsp:include page="bannernavleft.jsp"/>
            <div class="w3l_banner_nav_right">
                <div class="w3l_banner_nav_right_banner3">
                    <h3>Best Deals For New Products<span class="blink_me"></span></h3>
                </div>
                <div class="w3l_banner_nav_right_banner3_btm">
                    <div class="col-md-4 w3l_banner_nav_right_banner3_btml">
                        <div class="view view-tenth">
                            <img src="<%=request.getContextPath()%>/asset/client/images/13.jpg" alt=" " class="img-responsive" />
                            <div class="mask">
                                <h4>Grocery Store</h4>
                                <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt.</p>
                            </div>
                        </div>
                        <h4>Utensils</h4>
                        <ol>
                            <li>sunt in culpa qui officia</li>
                            <li>commodo consequat</li>
                            <li>sed do eiusmod tempor incididunt</li>
                        </ol>
                    </div>
                    <div class="col-md-4 w3l_banner_nav_right_banner3_btml">
                        <div class="view view-tenth">
                            <img src="<%=request.getContextPath()%>/asset/client/images/14.jpg" alt=" " class="img-responsive" />
                            <div class="mask">
                                <h4>Grocery Store</h4>
                                <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt.</p>
                            </div>
                        </div>
                        <h4>Hair Care</h4>
                        <ol>
                            <li>enim ipsam voluptatem officia</li>
                            <li>tempora incidunt ut labore et</li>
                            <li>vel eum iure reprehenderit</li>
                        </ol>
                    </div>
                    <div class="col-md-4 w3l_banner_nav_right_banner3_btml">
                        <div class="view view-tenth">
                            <img src="<%=request.getContextPath()%>/asset/client/images/15.jpg" alt=" " class="img-responsive" />
                            <div class="mask">
                                <h4>Grocery Store</h4>
                                <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt.</p>
                            </div>
                        </div>
                        <h4>Cookies</h4>
                        <ol>
                            <li>dolorem eum fugiat voluptas</li>
                            <li>ut aliquid ex ea commodi</li>
                            <li>magnam aliquam quaerat</li>
                        </ol>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div class="w3ls_w3l_banner_nav_right_grid">
                    <h3>Popular Brands</h3>
                    <div class="w3ls_w3l_banner_nav_right_grid1">
                        <%
                            if (request.getAttribute("listproductAdmins") != null) {
                                ArrayList<ProductAdmin> productAdmins = (ArrayList<ProductAdmin>) request.getAttribute("listproductAdmins");
                                for (ProductAdmin pa : productAdmins) {

                                    EncryptionDecryption td = new EncryptionDecryption();

                        %>

                        <div class="col-md-3 w3ls_w3l_banner_left">
                            <div class="hover14 column">
                                <div class="agile_top_brand_left_grid w3l_agile_top_brand_left_grid">
                                    <div class="agile_top_brand_left_grid_pos">
                                        <img src="<%=request.getContextPath()%>/asset/client/images/offer.png" alt="..." class="img-responsive" />
                                    </div>
                                    <div class="agile_top_brand_left_grid1">
                                        <figure>
                                            <div class="snipcart-item block">
                                                <div class="snipcart-thumb">
                                                    <a href="single.jsp?id=<%=td.encrypt(String.valueOf(pa.getId()))%>"><img src="<%=pa.getImages()%>" alt="..." height="140" width="140" class="img-responsive" /></a>
                                                    <p><%=pa.getName()%></p>
                                                    <h4>$<%=pa.getPromotionprice()%><span>$<%=pa.getPrice()%></span></h4>
                                                </div>
                                                <div class="snipcart-details">
                                                    <form action="#" method="post">
                                                        <fieldset>
                                                            <input type="hidden" name="cmd" value="_cart" />
                                                            <input type="hidden" name="add" value="1" />
                                                            <input type="hidden" name="business" value=" " />
                                                            <input type="hidden" name="shipping" value="<%=pa.getId()%>" />
                                                            <input type="hidden" name="item_name" value="<%=pa.getName()%>" />
                                                            <input type="hidden" name="amount" value="<%=pa.getPromotionprice()%>" />
                                                            <input type="hidden" name="discount_amount" value=" " />
                                                            <input type="hidden" name="currency_code" value="USD" />
                                                            <input type="hidden" name="return" value=" " />
                                                            <input type="hidden" name="cancel_return" value=" " />
                                                            <input type="submit" name="submit" value="Add to cart" class="button" />
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                        </figure>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% }
                            }%>

                        <div class="clearfix"> </div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!-- //banner -->
        <jsp:include page="footer.jsp" />
        <jsp:include page="footerscript.jsp" />
    </body>
</html>
