<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="page home-page">
    <!-- Main Navbar-->
    <header class="header">
        <nav class="navbar">
            <!-- Search Box-->
            <div class="search-box">
                <button class="dismiss"><i class="icon-close"></i></button>
                <form id="searchForm" action="#" role="search">
                    <input type="search" placeholder="What are you looking for..." class="form-control">
                </form>
            </div>
            <div class="container-fluid">
                <div class="navbar-holder d-flex align-items-center justify-content-between">
                    <!-- Navbar Header-->
                    <div class="navbar-header">
                        <!-- Navbar Brand --><a href="index" class="navbar-brand">
                            <div class="brand-text brand-big hidden-lg-down"><span>Quản Trị</span><strong> Store</strong></div>
                            <div class="brand-text brand-small"><strong>BD</strong></div></a>
                        <!-- Toggle Button--><a id="toggle-btn" href="#" class="menu-btn active"><span></span><span></span><span></span></a>
                    </div>
                    <!-- Navbar Menu -->
                    <ul class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
                        <!-- Search-->
                        <li class="nav-item d-flex align-items-center"><a id="search" href="#"><i class="icon-search"></i></a></li>
                        <!-- Notifications-->
                        <li class="nav-item dropdown"> <a id="notifications" rel="nofollow" data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link"><i class="fa fa-bell-o"></i><span class="badge bg-red">12</span></a>
                            <ul aria-labelledby="notifications" class="dropdown-menu">
                                <li><a rel="nofollow" href="#" class="dropdown-item"> 
                                        <div class="notification">
                                            <div class="notification-content"><i class="fa fa-envelope bg-green"></i>You have 6 new messages </div>
                                            <div class="notification-time"><small>4 minutes ago</small></div>
                                        </div></a></li>
                                <li><a rel="nofollow" href="#" class="dropdown-item"> 
                                        <div class="notification">
                                            <div class="notification-content"><i class="fa fa-twitter bg-blue"></i>You have 2 followers</div>
                                            <div class="notification-time"><small>4 minutes ago</small></div>
                                        </div></a></li>
                                <li><a rel="nofollow" href="#" class="dropdown-item"> 
                                        <div class="notification">
                                            <div class="notification-content"><i class="fa fa-upload bg-orange"></i>Server Rebooted</div>
                                            <div class="notification-time"><small>4 minutes ago</small></div>
                                        </div></a></li>
                                <li><a rel="nofollow" href="#" class="dropdown-item"> 
                                        <div class="notification">
                                            <div class="notification-content"><i class="fa fa-twitter bg-blue"></i>You have 2 followers</div>
                                            <div class="notification-time"><small>10 minutes ago</small></div>
                                        </div></a></li>
                                <li><a rel="nofollow" href="#" class="dropdown-item all-notifications text-center"> <strong>view all notifications                                            </strong></a></li>
                            </ul>
                        </li>
                        <!-- Messages                        -->
                        <li class="nav-item dropdown"> <a id="messages" rel="nofollow" data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link"><i class="fa fa-envelope-o"></i><span class="badge bg-orange">10</span></a>
                            <ul aria-labelledby="notifications" class="dropdown-menu">
                                <li><a rel="nofollow" href="#" class="dropdown-item d-flex"> 
                                        <div class="msg-profile"> <img src="" alt="..." class="img-fluid rounded-circle"></div>
                                        <div class="msg-body">
                                            <h3 class="h5">Jason Doe</h3><span>Sent You Message</span>
                                        </div></a></li>
                                <li><a rel="nofollow" href="#" class="dropdown-item d-flex"> 
                                        <div class="msg-profile"> <img src="" alt="..." class="img-fluid rounded-circle"></div>
                                        <div class="msg-body">
                                            <h3 class="h5">Frank Williams</h3><span>Sent You Message</span>
                                        </div></a></li>
                                <li><a rel="nofollow" href="#" class="dropdown-item d-flex"> 
                                        <div class="msg-profile"> <img src="" alt="..." class="img-fluid rounded-circle"></div>
                                        <div class="msg-body">
                                            <h3 class="h5">Ashley Wood</h3><span>Sent You Message</span>
                                        </div></a></li>
                                <li><a rel="nofollow" href="#" class="dropdown-item all-notifications text-center"> <strong>Read all messages    </strong></a></li>
                            </ul>
                        </li>
                        <!-- Logout    -->
                        <li class="nav-item"><a href="account?action=Logout" class="nav-link logout">Đăng xuất<i class="fa fa-sign-out"></i></a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    <div class="page-content d-flex align-items-stretch">
        <!-- Side Navbar -->
        <nav class="side-navbar">
            <!-- Sidebar Header-->
            <div class="sidebar-header d-flex align-items-center">
                <div class="avatar"><img src="<%=request.getContextPath()%>/asset/bootstrap/img/avatart-p.png" alt="..." class="img-fluid rounded-circle"></div>
                <div class="title">
                    <h1 class="h4">Quản Trị</h1>
                </div>
            </div>
            <!-- Sidebar Navidation Menus--><span class="heading">Bảng điều khiển</span>
            <ul class="list-unstyled">
                <li class="active"> <a href="<%=request.getContextPath()%>/admin/trang_quan_tri"><i class="icon-home"></i>Trang chủ</a></li>
                <li><a href="#dashvariants" aria-expanded="false" data-toggle="collapse"> <i class="icon-interface-windows"></i>Quản lý chung </a>
                    <ul id="dashvariants" class="collapse list-unstyled">
                        <li><a href="<%=request.getContextPath()%>/admin/tai_khoan/data">Bảng tài khoản quản trị</a></li>
                        <li><a href="<%=request.getContextPath()%>/admin/the_loai/data">Bảng thể loại sản phẩm</a></li>
                        <li><a href="<%=request.getContextPath()%>/admin/san_pham_sp/data">Bảng sản phẩm</a></li>
                        <li><a href="<%=request.getContextPath()%>/admin/anh_show/data">Bảng Slide</a></li>
                        <li><a href="<%=request.getContextPath()%>/admin/tk_nguoi_dung/data">Bảng Tài Khoản Người Dùng</a></li>
                        <li><a href="<%=request.getContextPath()%>/admin/quang_cao/data">Bảng Quản lý đơn hàng</a></li>

                    </ul>
                </li>
                <li> <a href="message.jsp"> <i class="fa fa-comments"></i>Tin Nhắn </a></li>
<!--                <li> <a href="charts.html"> <i class="fa fa-bar-chart"></i>Charts </a></li>
                <li> <a href="forms.html"> <i class="icon-padnote"></i>Forms </a></li>
                <li> <a href="login.html"> <i class="icon-interface-windows"></i>Login Page</a></li>-->
<!--            </ul><span class="heading">Extras</span>
            <ul class="list-unstyled">
                <li> <a href="#"> <i class="icon-flask"></i>Demo </a></li>
                <li> <a href="#"> <i class="icon-screen"></i>Demo </a></li>
                <li> <a href="#"> <i class="icon-mail"></i>Demo </a></li>
                <li> <a href="#"> <i class="icon-picture"></i>Demo </a></li>
            </ul>-->
        </nav>
        <div class="content-inner">
            <!-- Page Header-->
            <header class="page-header">
                <div class="container-fluid">
                    <h2 class="no-margin-bottom">Trang</h2>
                </div>
            </header>


