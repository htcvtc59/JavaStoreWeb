<%@page import="java.util.ArrayList"%>
<%@page import="com.shop.admin.dto.SlideAdmin"%>
<%@page import="com.shop.admin.iconnectdb.DAOFactory"%>
<%@page import="com.shop.admin.iconnectdb.idao.tblSlideDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="w3l_banner_nav_right">
        <section class="slider">
            <div class="flexslider">
                <ul class="slides">
                    <%
                    DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
                    tblSlideDAO slideDAO = microsoftFactory.getSlideDAO();
                    ArrayList<SlideAdmin> listSlideAdmin = slideDAO.dataSlideAdmin();
                    for (SlideAdmin slide : listSlideAdmin) {
                         
                    
                    %>
                    
                    <li>
                        <div class="w3l_banner_nav_right_banner">
                            <h3>Make your <span>food</span> with Spicy.</h3>
                            <div class="more">
                                <a href="san_pham" class="button--saqui button--round-l button--text-thick" data-text="Shop now">Shop now</a>
                            </div>
                        </div>
                    </li>
                   <% } %>
                </ul>
            </div>
        </section>
        <!-- flexSlider -->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/asset/client/css/flexslider.css" type="text/css" media="screen" property="" />
        <script defer src="<%=request.getContextPath()%>/asset/client/js/jquery.flexslider.js"></script>
        <script type="text/javascript">
            $(window).load(function () {
                $('.flexslider').flexslider({
                    animation: "slide",
                    start: function (slider) {
                        $('body').removeClass('loading');
                    }
                });
            });
        </script>
        <!-- //flexSlider -->
    </div>