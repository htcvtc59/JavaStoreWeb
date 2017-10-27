<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- header -->
<div class="agileits_header">
    <div class="w3l_offers">
        <a href="san_pham">Today's special Offers !</a>
    </div>
    <div class="w3l_search">
        <form action="#" method="post">
            <input id="keySearchContent" type="text" name="Product" value="Search a product..." onfocus="this.value = '';" onblur="if (this.value == '') {
                        this.value = 'Search a product...';
                    }" required="">
            <input type="submit" value=" ">
        </form>
    </div>
    <div class="product_list_header">  
        <form action="#" method="post" class="last">
            <fieldset>
                <input type="hidden" name="cmd" value="_cart" />
                <input type="hidden" name="display" value="1" />
                <input type="submit" name="submit" value="View your cart" class="button" />
            </fieldset>
        </form>
    </div>
    <div class="w3l_header_right" id="ggfaceac" >
        <!--Account login-->
        <%
            if (session.getAttribute("username") == null) {
        %>

        <ul>
            <li class="dropdown profile_details_drop">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user" aria-hidden="true"></i><span class="caret"></span></a>
                <div class="mega-dropdown-menu">
                    <div class="w3ls_vegetables">
                        <ul class="dropdown-menu drp-mnu">
                            <li><a href="dang_nhap">Login</a></li> 
                            <li><a href="dang_nhap">Sign Up</a></li>
                        </ul>
                    </div>                  
                </div>	
            </li>
        </ul>

        <%
            }
            if (session.getAttribute("username") != null) {

                int show = (int) session.getAttribute("show");

                if (show == 1) {
        %>
        <ul>
            <li class="dropdown profile_details_drop">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user" aria-hidden="true"></i><span class="caret"></span></a>
                <div class="mega-dropdown-menu">
                    <div class="w3ls_vegetables">
                        <ul class="dropdown-menu drp-mnu">
                            <li><a href="tai_khoan_kh?action=logout" >Sign out Client</a></li>
                        </ul>
                    </div>                  
                </div>	
            </li>
        </ul>
        <%
            }
            if (show == 2) {
                String nameg = (String) session.getAttribute("nameg");
                String imageg = (String) session.getAttribute("imageg");
        %>
        <ul>
            <li class="dropdown profile_details_drop">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user" aria-hidden="true"></i><span class="caret"></span></a>
                <div class="mega-dropdown-menu">
                    <div class="w3ls_vegetables">
                        <ul class="dropdown-menu drp-mnu">
                            <li><%=nameg%></li>
                            <li><img alt="..." src="<%=imageg%>" height="50" width="50" ></li>
                            <li>        <a href="tai_khoan_kh?action=logout" onclick="signOut();">Sign out Google</a>
                            </li>
                        </ul>
                    </div>                  
                </div>	
            </li>
        </ul>
        <%
            }
            if (show == 3) {
                String namef = (String) session.getAttribute("namef");
                String imagef = (String) session.getAttribute("imagef");
        %>

        <ul>
            <li class="dropdown profile_details_drop">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user" aria-hidden="true"></i><span class="caret"></span></a>
                <div class="mega-dropdown-menu">
                    <div class="w3ls_vegetables">
                        <ul class="dropdown-menu drp-mnu">
                            <li><%=namef%></li>
                            <li><img alt="..." src="<%=imagef%>" height="50" width="50" ></li>
                            <li>        <a href="tai_khoan_kh?action=logout" onclick="fbLogoutUser();">Sign out Facebook</a>
                            </li>
                        </ul>
                    </div>                  
                </div>	
            </li>
        </ul>

        <%
                }

            }
        %>


    </div>
    <div class="w3l_header_right1">
        <h2><a href="<%=request.getContextPath()%>/khguimail">Contact Us</a></h2>
    </div>
    <div class="clearfix"> </div>
</div>
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
<div class="logo_products">
    <div class="container">
        <div class="w3ls_logo_products_left">
            <h1><a href="trang_chu"><span>Grocery</span> Store</a></h1>
        </div>
        <div class="w3ls_logo_products_left1">
            <ul class="special_items">
                <li><a href="#">Events</a><i>/</i></li>
                <li><a href="#">About Us</a><i>/</i></li>
                 <li><a href="#">Services</a><i>/</i></li>
                <li><a href="chat.jsp">Chat</a></i>
            </ul>
        </div>
        <div class="w3ls_logo_products_left1">
            <ul class="phone_email">
                <li><i class="fa fa-phone" aria-hidden="true"></i>(+0123) 234 567</li>
                <li><i class="fa fa-envelope-o" aria-hidden="true"></i><a href="mailto:store@grocery.com">store@grocery.com</a></li>
            </ul>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<!-- //header -->