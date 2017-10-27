<%@page import="java.sql.Date"%>
<%@page import="com.shop.admin.dto.CategoryAdmin"%>
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
        <title>TheLoai</title>
        <jsp:include page="../admin/head.jsp" />
        <jsp:include page="../admin/footerjs.jsp" />

        <script type="text/javascript" >
            $(document).ready(function () {

                $('.btnUpdate').off('click').on('click', function () {

                    var idcate = $(this).data('id');
                    var name = $('.catename' + idcate).text();
                    var metatitle = $('.catemetatitle' + idcate).text();
                    var parentid = $('.cateparentid' + idcate).text();
                    var displayorder = $('.catedisplay' + idcate).text();
                    var seotitle = $('.cateseo' + idcate).text();
                    var status = $('.catestatus' + idcate).data('id');

                    $.post('category_mini.jsp', {id: idcate, name: name, metatitle: metatitle, parentid: parentid, displayorder: displayorder, seotitle: seotitle, status: status}, function () {

                        $('#cateidu').removeAttr('placeholder').val(idcate);
                        $('#catenameu').removeAttr('placeholder').val(name);
                        $('#catemetatitleu').removeAttr('placeholder').val(metatitle);
                        $('#cateparentidu').removeAttr('placeholder').val(parentid);
                        $('#catedisplayorderu').removeAttr('placeholder').val(displayorder);
                        $('#cateseotitleu').removeAttr('placeholder').val(seotitle);

                        if (status == true) {
                            $('#catestatusu').prop("checked", true);
                        } else if (status == false) {
                            $('#catestatusu').prop("checked", false);
                        }

                    });

                });



            });

        </script>
    </head>
    <body>
        <jsp:include page="../admin/menu.jsp" />
        <div class="container-fluid">
            <div class="row" style="min-height: 50rem;">
                <div class="col-12 col-sm-12 col-xl-12 col-md-12 col-lg-12">
                    <div class="col-12 col-sm-12 col-xl-12 col-md-12 col-lg-12">
                         <!-- Modal -->
                        <div class="modal fade" style="margin-top: 5rem !important;" id="exampleModal" tabindex="-1" role="dialog"
                             aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Create</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body"> 
                                        <form method="POST" action="bang_the_loai?action=add"> 
                                            <div class="form-group">
                                                <label for="catename">Name</label>
                                                <input type="text" class="form-control" id="catename" name="txtName" 
                                                       placeholder="Enter Name" />
                                            </div>
                                            <div class="form-group">
                                                <label for="catemetatitle">MetaTitle</label>
                                                <input type="text" class="form-control" id="catemetatitle" name="txtMetaTitle" 
                                                       placeholder="Enter MetaTitle" />
                                            </div>
                                            <div class="form-group">
                                                <label for="cateparentid">ParentID</label>
                                                <select class="form-control" id="cateparentid" name="txtParentID" >
                                                    <option value="0" >---Root---</option>
                                                    <%
                                                        if (request.getAttribute("listCategory") != null) {
                                                            ArrayList<CategoryAdmin> listCategoryAdmin = (ArrayList<CategoryAdmin>) request.getAttribute("listCategory");
                                                            for (CategoryAdmin category : listCategoryAdmin) {
                                                                int id = category.getId();
                                                                String name = category.getName();
                                                    %>
                                                    <option value="<%=id%>" ><%=name%></option>
                                                    <% }
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="catedisplayorder">DisplayOrder</label>
                                                <input type="text" class="form-control" id="catedisplayorder" name="txtDisplayOrder" 
                                                       placeholder="Enter DisplayOrder" />
                                            </div>
                                            <div class="form-group">
                                                <label for="cateseotitle">SeoTitle</label>
                                                <input type="text" class="form-control" id="cateseotitle" name="txtSeoTitle" 
                                                       placeholder="Enter SeoTitle" />
                                            </div>
                                            <input type="submit" class="btn btn-primary" value="Save" />
                                        </form>

                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!--Update-->

                        <!-- Modal -->
                        <div class="modal fade" style="margin-top: 5rem !important;" id="exampleModalUpdate" tabindex="-1" role="dialog" 
                             aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Update</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">

                                        <form method="POST" action="bang_the_loai?action=update" >
                                            <div class="form-group" hidden="true">
                                                <label for="cateidu">ID</label>
                                                <input type="text" class="form-control" id="cateidu" name="txtIdU" 
                                                       placeholder="Enter Id" />
                                            </div>

                                            <div class="form-group">
                                                <label for="catenameu">Name</label>
                                                <input type="text" class="form-control" id="catenameu" name="txtNameU" 
                                                       placeholder="Enter Name" />
                                            </div>
                                            <div class="form-group">
                                                <label for="catemetatitleu">MetaTitle</label>
                                                <input type="text" class="form-control" id="catemetatitleu" name="txtMetaTitleU" 
                                                       placeholder="Enter MetaTitle" />
                                            </div>
                                            <div class="form-group">
                                                <label for="cateparentidu">ParentID</label>
                                                <select class="form-control" id="cateparentidu" name="txtParentIDU" >
                                                    <option value="0" >---Root---</option>
                                                    <%
                                                        if (request.getAttribute("listCategory") != null) {
                                                            ArrayList<CategoryAdmin> listCategoryAdmin = (ArrayList<CategoryAdmin>) request.getAttribute("listCategory");
                                                            for (CategoryAdmin category : listCategoryAdmin) {
                                                                int id = category.getId();
                                                                String name = category.getName();
                                                    %>
                                                    <option value="<%=id%>" ><%=name%></option>
                                                    <% }
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="catedisplayorderu">DisplayOrder</label>
                                                <input type="text" class="form-control" id="catedisplayorderu" name="txtDisplayOrderU" 
                                                       placeholder="Enter DisplayOrder" />
                                            </div>
                                            <div class="form-group">
                                                <label for="cateseotitleu">SeoTitle</label>
                                                <input type="text" class="form-control" id="cateseotitleu" name="txtSeoTitleU" 
                                                       placeholder="Enter SeoTitle" />
                                            </div>

                                            <div class="form-group">
                                                <label for="catestatusu">Status</label>
                                                <input type="checkbox" class="checkbox-template" id="catestatusu" name="txtStatusU" />
                                            </div>

                                            <input type="submit" class="btn btn-primary" value="Save" />
                                        </form>

                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--End Update-->
                    </div>

                    <div id="example_wrapper" class="card dataTables_wrapper container-fluid dt-bootstrap4">
                        <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th><a class="fa fa-plus btn btn-sm btn-primary" href="#" data-toggle="modal"
                                           data-target="#exampleModal"></a>Action</th>
                                    <th>#</th>
                                    <th>Name</th>
                                    <th>MetaTitle</th>
                                    <th>ParentID</th>
                                    <th>DisplayOrder</th>
                                    <th>SeoTitle</th>
                                    <th>CreatedDate</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <th><a class="fa fa-plus btn btn-sm btn-primary" href="#" data-toggle="modal"
                                           data-target="#exampleModal"></a>Action</th>
                                    <th>#</th>
                                    <th>Name</th>
                                    <th>MetaTitle</th>
                                    <th>ParentID</th>
                                    <th>DisplayOrder</th>
                                    <th>SeoTitle</th>
                                    <th>CreatedDate</th>
                                    <th>Status</th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <%
                                    if (request.getAttribute("listCategory") != null) {
                                        ArrayList<CategoryAdmin> listCategoryAdmin = (ArrayList<CategoryAdmin>) request.getAttribute("listCategory");
                                        for (CategoryAdmin category : listCategoryAdmin) {
                                            int id = category.getId();
                                            String name = category.getName();
                                            String metatitle = category.getMetatitle();
                                            int parentid = category.getParentid();
                                            int displayorder = category.getDisplayorder();
                                            String seotitle = category.getSeotitle();
                                            Date createddate = category.getCreateddate();
                                            Boolean status = category.isStatus();
                                %>
                                <tr>
                                    <td>
                                        <a class="fa fa-pencil btn btn-sm btn-success btnUpdate" href="#" data-id="<%=id%>" data-toggle="modal" data-target="#exampleModalUpdate"></a>
                                        <a class="fa fa-times btn btn-sm btn-danger btnDelete" href="<%=request.getContextPath()%>/admin/the_loai/delete/<%=id%>"></a>
                                    </td>
                                    <td><%=id%></td>
                                    <td class="catename<%=id%>" ><%=name%></td>
                                    <td class="catemetatitle<%=id%>" ><%=metatitle%></td>
                                    <td class="cateparentid<%=id%>" ><%=parentid%></td>
                                    <td class="catedisplay<%=id%>" ><%=displayorder%></td>
                                    <td class="cateseo<%=id%>" ><%=seotitle%></td>
                                    <td><%=createddate%></td>
                                    <td class="catestatus<%=id%>" data-id="<%=status%>" ><%if (status == true) {%>Active<%} else {%>Not Active<%}%></td>
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
