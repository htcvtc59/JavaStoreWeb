<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.shop.admin.dto.AccountClientAdmin"%>
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
        <title>TaiKhoanNguoiDung</title>
        <jsp:include page="../admin/head.jsp" />
        <jsp:include page="../admin/footerjs.jsp" />
        <script type="text/javascript" >
            $(document).ready(function () {

                $('.btnUpdate').off('click').on('click', function () {
                    var idu = $(this).data('id');
                    var note = $('.aanote' + idu).text();
                    var status = $('.aastatus' + idu).data('id');
                    $.post('accountclient_mini.jsp', {id: idu, note: note, status: status}, function () {
                        $('#idu').removeAttr('placeholder').val(idu);
                        $('#noteu').removeAttr('placeholder').val(note);
                        if (status == true) {
                            $('#statusu').prop("checked", true);
                        } else if (status == false) {
                            $('#statusu').prop("checked", false);
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

                        <!--Update-->

                        <!-- Modal -->
                        <div class="modal fade" style="margin-top: 5rem !important;" id="exampleModalUpdate" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Update</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">

                                        <form method="POST" action="tai_khoan_nguoidung?action=update" id="formAccountUpdate">

                                            <div class="form-group" hidden="true">
                                                <label for="idu">Id</label>
                                                <input type="text" class="form-control" id="idu" name="aaidu" 
                                                       placeholder="Enter ID"/>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label for="noteu">Note</label>
                                                <textarea class="form-control" id="noteu" name="aanoteu" 
                                                          placeholder="Enter Note"></textarea>
                                            </div>
                                            <div class="form-group">
                                                <label for="statusu">Status</label>
                                                <input type="checkbox" class="checkbox-template" id="statusu" name="aastatusu" />
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
                                    <th>Action</th>
                                    <th>#</th>
                                    <th>RealName</th>
                                    <th>IDaccount</th>
                                    <th>UserName</th>
                                    <th>Password</th>
                                    <th>Email</th>
                                    <th>Salt</th>
                                    <th>CreatedDate</th>
                                    <th>Note</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <th>Action</th>
                                    <th>#</th>
                                    <th>RealName</th>
                                    <th>IDaccount</th>
                                    <th>UserName</th>
                                    <th>Password</th>
                                    <th>Email</th>
                                    <th>Salt</th>
                                    <th>CreatedDate</th>
                                    <th>Note</th>
                                    <th>Status</th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <%

                                    if (request.getAttribute("listAcoutnClient") != null) {
                                        ArrayList<AccountClientAdmin> listAccountClientAdmin = (ArrayList<AccountClientAdmin>) request.getAttribute("listAcoutnClient");
                                        for (AccountClientAdmin aa : listAccountClientAdmin) {
                                            int id = aa.getId();
                                            String realname = aa.getRealname();
                                            String idaccount = aa.getIdaccount();
                                            String username = aa.getUsername();
                                            String password = aa.getPassword();
                                            String email = aa.getEmail();
                                            String salt = aa.getSalt();
                                            Date createddate = aa.getCreateddate();
                                            String note = aa.getNote();
                                            Boolean status = aa.isStatus();


                                %>
                                <tr>
                                    <td>
                                        <a class="fa fa-pencil btn btn-sm btn-success btnUpdate" href="#" data-id="<%=id%>" data-toggle="modal" data-target="#exampleModalUpdate"></a>
                                        <a class="fa fa-times btn btn-sm btn-danger btnDelete" href="<%=request.getContextPath()%>/admin/tk_nguoi_dung/delete/<%=id%>"></a>
                                    </td>
                                    <td><%=id%></td>
                                    <td><%=realname%></td>
                                    <td><%if (idaccount == null) {%>...<%} else {%><%=idaccount%><%}%></td>
                                    <td><%=username%></td>
                                    <td><%=password%></td>
                                    <td><%=email%></td>
                                    <td><%=salt%></td>
                                    <td><%=createddate%></td>
                                    <td class="aanote<%=id%>" ><%if (note == null) {%>...<%} else {%><%=note%><%}%></td>
                                    <td class="aastatus<%=id%>" data-id="<%=status%>" ><%if (status == true) {%>Active<%} else {%>Not Active<%}%></td>
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
