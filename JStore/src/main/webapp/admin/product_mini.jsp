<%@page import="java.sql.Date"%>
<%@page import="com.shop.admin.dto.ProductAdmin"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="robots" content="all,follow">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SanPham</title>
        <jsp:include page="../admin/head.jsp" />
        <jsp:include page="../admin/footerjs.jsp" />
        <script type="text/javascript" src="<%=request.getContextPath()%>/ckplugin/ckeditor/ckeditor.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/ckplugin/ckfinder/ckfinder.js"></script>
        <script type="text/javascript" >

        </script>
    </head>
    <body>
        <jsp:include page="../admin/menu.jsp" />
        <div class="container-fluid">
            <div class="row" style="min-height: 50rem;">
                <div class="col-12 col-sm-12 col-xl-12 col-md-12 col-lg-12">

                    <div id="example_wrapper" class="card dataTables_wrapper container-fluid dt-bootstrap4">
                        <table id="" class="table table-striped table-bordered display nowrap" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th><a class="fa fa-plus btn btn-sm btn-primary" href="<%=request.getContextPath()%>/admin/san_pham_sp_create/cdata" ></a>Action</th>
                                    <th>#</th>
                                    <th>Name</th>
                                    <th>Code</th>
                                    <th>MetaTitle</th>
                                    <th>Description</th>
                                    <th>Images</th>
                                    <th>MoreImages</th>
                                    <th>Price</th>
                                    <th>PromotionPrice</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <th><a class="fa fa-plus btn btn-sm btn-primary" href="<%=request.getContextPath()%>/admin/san_pham_sp_create/cdata" ></a>Action</th>
                                    <th>#</th>
                                    <th>Name</th>
                                    <th>Code</th>
                                    <th>MetaTitle</th>
                                    <th>Description</th>
                                    <th>Images</th>
                                    <th>MoreImages</th>
                                    <th>Price</th>
                                    <th>PromotionPrice</th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <%
                                    if (request.getAttribute("listProduct") != null) {
                                        ArrayList<ProductAdmin> listProductAdmin = (ArrayList<ProductAdmin>) request.getAttribute("listProduct");

                                        for (ProductAdmin pro : listProductAdmin) {
                                            int id = pro.getId();
                                            String name = pro.getName();
                                            String code = pro.getCode();
                                            String metatitle = pro.getMetatitle();
                                            String description = pro.getDescription();
                                            String images = pro.getImages();
                                            String moreimages = pro.getMoreimages();
                                            double price = pro.getPrice();
                                            double promotionprice = pro.getPromotionprice();
                                            boolean includedvat = pro.isIncludedvat();
                                            int quantity = pro.getQuantity();
                                            int categoryid = pro.getCategoryid();
                                            String detail = pro.getDetail();
                                            int warranty = pro.getWarranty();
                                            Date createddate = pro.getCreateddate();
                                            boolean status = pro.isStatus();
                                            Date tophot = pro.getTophot();
                                            int viewcount = pro.getViewcount();


                                %>
                                <tr>
                                    <td>
                                        <a class="fa fa-pencil btn btn-sm btn-success btnUpdate" href="<%=request.getContextPath()%>/admin/san_pham_sp_update/udata/<%=id%>"></a>
                                        <a class="fa fa-times btn btn-sm btn-danger btnDelete" href="<%=request.getContextPath()%>/admin/san_pham_sp/delete/<%=id%>"></a>
                                    </td>
                                    <td><%=id%></td>
                                    <td><%=name%></td>
                                    <td><% if (code == null) {%>...<%} else {%><%=code%><%}%></td>
                                    <td><%=metatitle%></td>
                                    <td><%=description%></td>
                                    <td>
                                        <%
                                            for (String imgi : images.split(",")) {
                                                String imgs = imgi;
                                        %>
                                        <img height="80" width="80" src="<%=imgs%>" alt='...' />

                                        <% }
                                        %>
                                    </td>
                                    <td>
                                        <%
                                            for (String imgimore : moreimages.split(",")) {
                                                String imgsmore = imgimore;
                                        %>
                                        <img height="80" width="80" src="<%=imgsmore%>" alt='...' />
                                        <% }
                                        %>
                                    </td>
                                    <td><%=price%></td>
                                    <td><%=promotionprice%></td>
                                </tr>
                                <% }
                                    }%>
                            </tbody>
                        </table>
                        <table id="" class="table table-striped table-bordered display nowrap" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>IncludedVat</th>
                                    <th>Quantity</th>
                                    <th>CategoryID</th>
                                    <th>Detail</th>
                                    <th>Warranty</th>
                                    <th>CreatedDate</th>
                                    <th>Status</th>
                                    <th>TopHot</th>
                                    <th>ViewCount</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <th>#</th>
                                    <th>IncludedVat</th>
                                    <th>Quantity</th>
                                    <th>CategoryID</th>
                                    <th>Detail</th>
                                    <th>Warranty</th>
                                    <th>CreatedDate</th>
                                    <th>Status</th>
                                    <th>TopHot</th>
                                    <th>ViewCount</th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <%
                                    if (request.getAttribute("listProduct") != null) {
                                        ArrayList<ProductAdmin> listProductAdmin = (ArrayList<ProductAdmin>) request.getAttribute("listProduct");
                                        for (ProductAdmin pro : listProductAdmin) {
                                            int id = pro.getId();
                                            String name = pro.getName();
                                            String code = pro.getCode();
                                            String metatitle = pro.getMetatitle();
                                            String description = pro.getDescription();
                                            String images = pro.getImages();
                                            String moreimages = pro.getMoreimages();
                                            double price = pro.getPrice();
                                            double promotionprice = pro.getPromotionprice();
                                            boolean includedvat = pro.isIncludedvat();
                                            int quantity = pro.getQuantity();
                                            int categoryid = pro.getCategoryid();
                                            String detail = pro.getDetail();
                                            int warranty = pro.getWarranty();
                                            Date createddate = pro.getCreateddate();
                                            boolean status = pro.isStatus();
                                            Date tophot = pro.getTophot();
                                            int viewcount = pro.getViewcount();

                                %>
                                <tr>
                                    <td><%=id%></td>
                                    <td><% if (includedvat) {%>Yes<%} else {%>No<%}%></td>
                                    <td><%=quantity%></td>
                                    <td><%=categoryid%></td>
                                    <td><%=detail%></td>
                                    <td><%=warranty%></td>
                                    <td><%=createddate%></td>
                                    <td><%if (status == true) {%>Active<%} else {%>Not Active<%}%></td>
                                    <td><% if (tophot == null) {%>...<%} else {%><%=tophot%><%}%></td>
                                    <td><%=viewcount%></td>
                                </tr>
                                <% }
                                    }%>
                            </tbody>
                        </table>
                    </div>   
                </div>
            </div>
        </div>

        <jsp:include page="../admin/footer.jsp" />

    </body>
</html>
