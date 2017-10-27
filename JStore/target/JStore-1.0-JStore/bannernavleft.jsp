<%@page import="com.shop.client.encodedecode.EncryptionDecryption"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.shop.admin.dto.CategoryAdmin"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.shop.admin.iconnectdb.idao.tblCategoryDAO"%>
<%@page import="com.shop.admin.iconnectdb.DAOFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="w3l_banner_nav_left">
    <nav class="navbar nav_bottom">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header nav_2">
            <button type="button" class="navbar-toggle collapsed navbar-toggle1" data-toggle="collapse" data-target="#bs-megadropdown-tabs">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div> 
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-megadropdown-tabs">
            <ul class="nav navbar-nav nav_1">
                <%
                    DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
                    tblCategoryDAO categoryDAO = microsoftFactory.getCategoryDAO();
                    ArrayList<CategoryAdmin> listAccountAdmin = categoryDAO.dataCategoryOrder();
                    EncryptionDecryption td = new EncryptionDecryption();


                    for (CategoryAdmin ca : listAccountAdmin) {
                        int idca = ca.getId();
                        String nameca = ca.getName();
                        String metaca = ca.getMetatitle();
                        int parentca = ca.getParentid();

                        ArrayList<CategoryAdmin> listChild = categoryDAO.dataCategoryParentID(idca);

                        if (parentca == 0 && listChild.size() == 0) {
                %>
                <li><a href="<%=request.getContextPath()%>/<%=metaca%>.html?gg=<%=td.encrypt(String.valueOf(idca))%>"><%=nameca%></a></li>
                    <%
                    } else if (parentca == 0 && listChild.size() != 0) {
                    %>
                <li class="dropdown mega-dropdown active">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><%=nameca%><span class="caret"></span></a>				
                    <div class="dropdown-menu mega-dropdown-menu w3ls_vegetables_menu">
                        <div class="w3ls_vegetables">
                            <ul>
                                <% for (CategoryAdmin c : listChild) {
                                        int idc = c.getId();
                                        String namec = c.getName();
                                        String metac = c.getMetatitle();
                                        int parentc = c.getParentid();

                                %>
                                <li><a href="<%=request.getContextPath()%>/<%=metac%>.html?gg=<%=td.encrypt(String.valueOf(idc))%>"><%=namec%></a></li>
                                    <% }%>
                            </ul>
                        </div>                  
                    </div>				
                </li>


                <%   }

                    }
                %>


                <!--                <li><a href="san_pham">Branded Foods</a></li>
                                <li><a href="household.html">Households</a></li>
                                <li class="dropdown mega-dropdown active">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Veggies & Fruits<span class="caret"></span></a>				
                                    <div class="dropdown-menu mega-dropdown-menu w3ls_vegetables_menu">
                                        <div class="w3ls_vegetables">
                                            <ul>	
                                                <li><a href="vegetables.html">Vegetables</a></li>
                                                <li><a href="vegetables.html">Fruits</a></li>
                                            </ul>
                                        </div>                  
                                    </div>				
                                </li>
                                <li><a href="kitchen.html">Kitchen</a></li>
                                <li><a href="short-codes.html">Short Codes</a></li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Beverages<span class="caret"></span></a>
                                    <div class="dropdown-menu mega-dropdown-menu w3ls_vegetables_menu">
                                        <div class="w3ls_vegetables">
                                            <ul>
                                                <li><a href="drinks.html">Soft Drinks</a></li>
                                                <li><a href="drinks.html">Juices</a></li>
                                            </ul>
                                        </div>                  
                                    </div>	
                                </li>
                                <li><a href="pet.html">Pet Food</a></li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Frozen Foods<span class="caret"></span></a>
                                    <div class="dropdown-menu mega-dropdown-menu w3ls_vegetables_menu">
                                        <div class="w3ls_vegetables">
                                            <ul>
                                                <li><a href="frozen.html">Frozen Snacks</a></li>
                                                <li><a href="frozen.html">Frozen Nonveg</a></li>
                                            </ul>
                                        </div>                  
                                    </div>	
                                </li>
                                <li><a href="bread.html">Bread & Bakery</a></li>-->

            </ul>
        </div><!-- /.navbar-collapse -->
    </nav>
</div>