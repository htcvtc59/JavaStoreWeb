<%@page import="com.shop.admin.dto.ProductAdmin"%>
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
        <title>SanPham</title>
        <jsp:include page="../admin/head.jsp" />
        <jsp:include page="../admin/footerjs.jsp" />
        <script type="text/javascript" src="<%=request.getContextPath()%>/ckplugin/ckeditor/ckeditor.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/ckplugin/ckfinder/ckfinder.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                var i = 0;
                var arrImgUrl = [];
                $('#clickfileImg').on('click', function () {
                    i++;
                    var finder = new CKFinder();
                    finder.basePath = '/JStore/Upload/';
                    finder.selectActionFunction = function (url) {
                        $('#urlimage').val(url);
                        arrImgUrl.push(url);
                        $('#Inimgurls').val(arrImgUrl);
                        $('#showimgbtn').append("<img height='80' id='Imgs" + i + "' width='80' src='" + url + "' alt='...' /><button class='fa fa-times btn btn-sm btn-danger btndeleteimgs' data-id='" + i + "' ></button>");
                    };
                    finder.popup();
                });

                $("body").off('click').on('click', '.btndeleteimgs', function (e) {
                    e.preventDefault();
                    var idimg = $(this).data("id");
                    $('#Imgs' + idimg).remove();
                    $(this).remove();
                    arrImgUrl.splice(arrImgUrl[idimg], 1);
                    $('#Inimgurls').val(arrImgUrl);
                });

                var j = 0;
                var arrImgUrlmore = [];
                $('#clickfileImgmore').on('click', function () {
                    j++;
                    var finder = new CKFinder();
                    finder.basePath = '/JStore/Upload/';
                    finder.selectActionFunction = function (url) {
                        $('#urlimagemore').val(url);
                        arrImgUrlmore.push(url);
                        $('#Inimgurlsmore').val(arrImgUrlmore);
                        $('#showimgbtnmore').append("<img height='80' id='Imgsmore" + j + "' width='80' src='" + url + "' alt='...' /><button class='fa fa-times btn btn-sm btn-danger btndeleteimgsmore' data-id='" + j + "' ></button>");
                    };
                    finder.popup();
                });

                $(document).off('click').on('click', '.btndeleteimgsmore', function (e) {
                    e.preventDefault();
                    var idimg = $(this).data("id");
                    $('#Imgsmore' + idimg).remove();
                    $(this).remove();
                    arrImgUrlmore.splice(arrImgUrlmore[idimg], 1);
                    $('#Inimgurlsmore').val(arrImgUrlmore);
                });



            });
        </script>
    </head>
    <body>
        <jsp:include page="../admin/menu.jsp" />
        <div class="container-fluid">
            <div class="row" style="min-height: 50rem;">
                <div class="col-10 col-sm-10 col-xl-10 col-md-10 col-lg-10 card offset-1">
                    <form method="POST" action="bang_san_pham?action=add" > 
                        <div class="form-group">
                            <label for="proname">Name</label>
                            <input type="text" class="form-control" id="proname" name="txtProName" 
                                   placeholder="Enter Name" />
                        </div>
                        <div class="form-group">
                            <label for="prometatitle">MetaTitle</label>
                            <input type="text" class="form-control" id="prometatitle" name="txtProMetaTitle" 
                                   placeholder="Enter MetaTitle" />
                        </div>

                        <div class="form-group">
                            <label for="ckeditordespro">Description</label>
                            <textarea class="form-control" name="txtProDes" id="ckeditordespro" rows="3"></textarea>
                        </div>

                        <div class="form-group">
                            <label >Images</label>
                            <div class="row">
                                <div class="col-5" >
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="urlimage" ><span class="input-group-btn">
                                            <button type="button" class="btn btn-primary" id="clickfileImg">Select file</button></span>
                                    </div>
                                </div>
                                <div class="col-7">
                                    <input type="text" name="txtProImgUrl" id="Inimgurls" class="form-control" hidden="true" />
                                    <div class="row" id="showimgbtn">

                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="form-group">
                            <label >MoreImages</label>
                            <div class="row">
                                <div class="col-5" >
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="urlimagemore" ><span class="input-group-btn">
                                            <button type="button" class="btn btn-primary" id="clickfileImgmore">Select file</button></span>
                                    </div>
                                </div>
                                <div class="col-7">
                                    <input type="text" name="txtProImgUrlmore" id="Inimgurlsmore" class="form-control" hidden="true" />
                                    <div class="row" id="showimgbtnmore">

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="proprice">Price</label>
                            <input type="text" class="form-control" id="proprice" name="txtProPrice" 
                                   placeholder="Enter Price" />
                        </div>

                        <div class="form-group">
                            <label for="propromotionprice">PromotionPrice</label>
                            <input type="text" class="form-control" id="propromotionprice" name="txtProPromotionPrice" 
                                   placeholder="Enter PromotionPrice" />
                        </div>

                        <div class="form-group">
                            <label for="proquantity">Quantity</label>
                            <input type="text" class="form-control" id="proquantity" name="txtProQuantity" 
                                   placeholder="Enter Quantity" />
                        </div>

                        <div class="form-group">
                            <label for="procategoryid">CategoryID</label>
                            <select class="form-control" id="procategoryid" name="txtProCategoryID" >
                                <option value="0" >---Root---</option>
                                <%
                                    if (request.getAttribute("listCategoryPro") != null) {
                                        ArrayList<CategoryAdmin> listCategoryAdmin = (ArrayList<CategoryAdmin>) request.getAttribute("listCategoryPro");
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
                            <label for="ckeditorprodetail">Detail</label>
                            <textarea class="form-control" name="txtProDetail" id="ckeditorprodetail" rows="3"></textarea>

                        </div>

                            <input type="submit" class="btn btn-primary" value="Save" />
                    </form>

                </div>
            </div>
        </div>

        <jsp:include page="../admin/footer.jsp" />
        <script type="text/javascript" >

            var editor = CKEDITOR.replace('ckeditordespro');
            CKFinder.setupCKEditor(editor, '<%=request.getContextPath()%>/ckplugin/ckfinder');

            var editordetail = CKEDITOR.replace('ckeditorprodetail');
            CKFinder.setupCKEditor(editordetail, '<%=request.getContextPath()%>/ckplugin/ckfinder');

        </script>

    </body>
</html>
