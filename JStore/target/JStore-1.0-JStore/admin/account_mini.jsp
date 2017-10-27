<%@page import="java.util.ArrayList"%>
<%@page import="com.shop.admin.dto.AccountAdmin"%>
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
        <title>TaiKhoan</title>
        <jsp:include page="../admin/head.jsp" />
        <jsp:include page="../admin/footerjs.jsp" />
        <script type="text/javascript" >
            $(document).ready(function () {

                $('.btnUpdate').off('click').on('click', function () {
                    var idu = $(this).data('id');
                    var pass = $('.aapass' + idu).text();
                    var note = $('.aanote' + idu).text();
                    var status = $('.aastatus' + idu).data('id');
                    console.log(idu + pass + note + status);
                    $.post('account_mini.jsp', {id: idu, pass: pass, note: note, status: status}, function () {
                        $('#idu').removeAttr('placeholder').val(idu);
                        $('#passwordu').removeAttr('placeholder').val(pass);
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

                        <!-- Modal -->
                        <div class="modal fade" style="margin-top: 5rem !important;" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Create</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body"> 
                                        <form method="POST" action="bang_tai_khoan?action=add" id="formAccountCreate" > <!--enctype="multipart/form-data"-->
                                            <div class="form-group">
                                                <label for="txtUserName">UserName</label>
                                                <input type="text" class="form-control" id="txtUserName" name="txtuser" 
                                                       placeholder="Enter Username" />
                                            </div>
                                            <div class="form-group">
                                                <label for="txtPassWord">PassWord</label>
                                                <input type="password" class="form-control" id="txtPassWord" name="txtpass" 
                                                       placeholder="Enter Password" />
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

                                        <form method="POST" action="bang_tai_khoan?action=update" id="formAccountUpdate">

                                            <div class="form-group" hidden="true">
                                                <label for="idu">Id</label>
                                                <input type="text" class="form-control" id="idu" name="aaidu" 
                                                       placeholder="Enter ID"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="passwordu">Password</label>
                                                <input type="text" class="form-control" id="passwordu" name="aapassu" 
                                                       placeholder="Enter Password"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="noteu">Note</label>
                                                <input type="text" class="form-control" id="noteu" name="aanoteu" 
                                                       placeholder="Enter Note"/>
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
                                    <th><a class="fa fa-plus btn btn-sm btn-primary" href="#" data-toggle="modal"
                                           data-target="#exampleModal"></a>Action</th>
                                    <th>#</th>
                                    <th>UserName</th>
                                    <th>PassWord</th>
                                    <th>Salt</th>
                                    <th>Note</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <th><a class="fa fa-plus btn btn-sm btn-primary" href="#" data-toggle="modal"
                                           data-target="#exampleModal" ></a>Action</th>
                                    <th>#</th>
                                    <th>UserName</th>
                                    <th>PassWord</th>
                                    <th>Salt</th>
                                    <th>Note</th>
                                    <th>Status</th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <%

                                    if (request.getAttribute("listAA") != null) {
                                        ArrayList<AccountAdmin> listAccountAdmin = (ArrayList<AccountAdmin>) request.getAttribute("listAA");
                                        for (AccountAdmin aa : listAccountAdmin) {
                                            int id = aa.getId();
                                            String username = aa.getUsername();
                                            String password = aa.getPassword();
                                            String salt = aa.getSalt();
                                            String note = aa.getNote();
                                            Boolean status = aa.isStatus();


                                %>
                                <tr>
                                    <td>
                                        <a class="fa fa-pencil btn btn-sm btn-success btnUpdate" href="#" data-id="<%=id%>" data-toggle="modal" data-target="#exampleModalUpdate"></a>
                                        <a class="fa fa-times btn btn-sm btn-danger btnDelete" href="<%=request.getContextPath()%>/admin/tai_khoan/delete/<%=id%>"></a>
                                    </td>
                                    <td><%=id%></td>
                                    <td><%=username%></td>
                                    <td class="aapass<%=id%>" ><%=password%></td>
                                    <td><%=salt%></td>
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
