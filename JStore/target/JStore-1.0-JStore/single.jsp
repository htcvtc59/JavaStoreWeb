
<%@page import="com.shop.client.encodedecode.EncryptionDecryption"%>
<%@page import="com.shop.admin.iconnectdb.DAOFactory"%>
<%@page import="com.shop.admin.iconnectdb.idao.tblProductDAO"%>
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
                    <li><i class="fa fa-home" aria-hidden="true"></i><a href="index.html">Home</a><span>|</span></li>
                    <li>Single Page</li>
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
                <%
                    DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
                    tblProductDAO productDAO = microsoftFactory.getProductDAO();
                    EncryptionDecryption td = new EncryptionDecryption();
                    String id = request.getParameter("id");
                    ArrayList<ProductAdmin> listproAdmin = productDAO.dataidProductAdmin(Integer.parseInt(td.decrypt(id)));

                    for (ProductAdmin p : listproAdmin) {

                %>
                <div class="agileinfo_single">
                    <h5><%=p.getName()%></h5>
                    <div class="col-md-4 agileinfo_single_left">
                        <img id="example" src="<%=p.getImages()%>" alt=" " class="img-responsive" />
                    </div>
                    <div class="col-md-8 agileinfo_single_right">
                        <div class="rating1">
                            <span class="starRating">
                                <input id="rating5" type="radio" name="rating" value="5">
                                <label for="rating5">5</label>
                                <input id="rating4" type="radio" name="rating" value="4">
                                <label for="rating4">4</label>
                                <input id="rating3" type="radio" name="rating" value="3" checked>
                                <label for="rating3">3</label>
                                <input id="rating2" type="radio" name="rating" value="2">
                                <label for="rating2">2</label>
                                <input id="rating1" type="radio" name="rating" value="1">
                                <label for="rating1">1</label>
                            </span>
                        </div>
                        <div class="w3agile_description">
                            <h4>Description :</h4>
                            <p><%=p.getDescription()%></p>
                        </div>
                        <div class="snipcart-item block">
                            <div class="snipcart-thumb agileinfo_single_right_snipcart">
                                <h4>$<%=p.getPromotionprice()%> <span>$<%=p.getPrice()%></span></h4>
                            </div>
                            <div class="snipcart-details agileinfo_single_right_details">
                                <form action="#" method="post">
                                    <fieldset>
                                        <input type="hidden" name="cmd" value="_cart" />
                                        <input type="hidden" name="add" value="1" />
                                        <input type="hidden" name="business" value=" " />
                                        <input type="hidden" name="shipping" value="<%=p.getId()%>" />
                                        <input type="hidden" name="item_name" value="<%=p.getName()%>" />
                                        <input type="hidden" name="amount" value="<%=p.getPromotionprice()%>" />
                                        <input type="hidden" name="discount_amount" value=" " />
                                        <input type="hidden" name="currency_code" value="USD" />
                                        <input type="hidden" name="return" value=" " />
                                        <input type="hidden" name="cancel_return" value=" " />
                                        <input type="submit" name="submit" value="Add to cart" class="button" />
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <%}%>
            </div>
            <div class="clearfix"></div>
        </div>
        <!-- //banner -->
        <jsp:include page="footer.jsp" />
        <jsp:include page="footerscript.jsp" />
    </body>
</html>
