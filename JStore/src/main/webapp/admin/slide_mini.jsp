<%@page import="java.sql.Date"%>
<%@page import="com.shop.admin.dto.SlideAdmin"%>
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
        <title>Slide</title>
        <jsp:include page="../admin/head.jsp" />
        <jsp:include page="../admin/footerjs.jsp" />
        <script type="text/javascript" src="<%=request.getContextPath()%>/ckplugin/ckfinder/ckfinder.js"></script>


        <script type="text/javascript" >
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
                    arrImgUrlmore.splice(0,arrImgUrlmore.length);
                    var finder = new CKFinder();
                    finder.basePath = '/JStore/Upload/';
                    finder.selectActionFunction = function (url) {
                        arrImgUrlmore.push(url);
                        $('#Inimgurlsmore').val(arrImgUrlmore);
                        $('#showimgbtnmore').empty().append("<img height='80' id='Imgsmore" + j + "' width='80' src='" + url + "' alt='...' /><button class='fa fa-times btn btn-sm btn-danger btndeleteimgsmore' data-id='" + j + "' ></button>");
                    };
                    finder.popup();
                });


                $("body").off('click').on('click', '.btndeleteimgsmore', function (e) {
                    e.preventDefault();
                    var idimg = $(this).data("id");
                    $('#Imgsmore' + idimg).remove();
                    $(this).remove();
                    arrImgUrlmore.splice(arrImgUrlmore[idimg], 1);
                    $('#Inimgurlsmore').val(arrImgUrlmore);
                });

                $('.btnUpdate').off('click').on('click', function () {

                    var idslide = $(this).data('id');
                    var image = $('.slideimage' + idslide).text();
                    var displayorder = $('.slidedisplayorder' + idslide).text();
                    var link = $('.slidelink' + idslide).text();
                    var description = $('.slidedes' + idslide).text();
                    var status = $('.slidestatus' + idslide).data('id');
                    

                    $.post('slide_mini.jsp', {id: idslide, image: image, displayorder: displayorder, link: link, description: description, status: status}, function () {

                        $('#slideidu').removeAttr('placeholder').val(idslide);
                        $('#Inimgurlsmore').removeAttr('placeholder').val(image);
                        $('#showimgbtnmore').empty().append("<img height='80' width='80' src='" + image + "' alt='...' />");
                        $('#slidedisplayorderu').removeAttr('placeholder').val(displayorder);
                        $('#slidelinku').removeAttr('placeholder').val(link);
                        $('#slidedescriptionu').removeAttr('placeholder').val(description);

                        if (status == true) {
                            $('#slidestatusu').prop("checked", true);
                        } else if (status == false) {
                            $('#slidestatusu').prop("checked", false);
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
                            <div class="modal-dialog modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Create</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body"> 
                                        <form method="POST" action="bang_anh_show?action=add"> 

                                            <div class="form-group">
                                                <label>Image</label>
                                                <div class="row">
                                                    <div class="col-5" >
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" id="urlimage" ><span class="input-group-btn">
                                                                <button type="button" class="btn btn-primary" id="clickfileImg">Select file</button></span>
                                                        </div>
                                                    </div>
                                                    <div class="col-7">
                                                        <input type="text" name="txtSlideImages" id="Inimgurls" class="form-control" hidden="true" />
                                                        <div class="row" id="showimgbtn">

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="slidelink">Link</label>
                                                <input type="text" class="form-control" id="slidelink" name="txtSlideLink" 
                                                       placeholder="Enter Link" />
                                            </div>
                                            <div class="form-group">
                                                <label for="slidedescription">Description</label>
                                                <textarea  class="form-control" id="slidedescription" name="txtSlideDescription" 
                                                           placeholder="Enter Description" rows="3" ></textarea>
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
                            <div class="modal-dialog modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Update</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">

                                        <form method="POST" action="bang_anh_show?action=update" >

                                            <div class="form-group" hidden="true">
                                                <label for="slideidu">ID</label>
                                                <input type="text" class="form-control" id="slideidu" name="txtSlideIdU" 
                                                       placeholder="Enter Id" />
                                            </div>

                                            <div class="form-group">
                                                <label >Image</label>
                                                <div class="row">
                                                    <div class="col-5" >
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" id="urlimagemore" ><span class="input-group-btn">
                                                                <button type="button" class="btn btn-primary" id="clickfileImgmore">Select file</button></span>
                                                        </div>
                                                    </div>
                                                    <div class="col-7">
                                                        <input type="text" name="txtSlideImageU" id="Inimgurlsmore" class="form-control"  hidden="true" />
                                                        <div class="row" id="showimgbtnmore">

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="slidedisplayorderu">DisplayOrder</label>
                                                <input type="text" class="form-control" id="slidedisplayorderu" name="txtSlideDisplayOrderU" 
                                                       placeholder="Enter DisplayOrder" />
                                            </div>

                                            <div class="form-group">
                                                <label for="slidelinku">Link</label>
                                                <input type="text" class="form-control" id="slidelinku" name="txtSlideLinkU" 
                                                       placeholder="Enter Link" />
                                            </div>
                                            <div class="form-group">
                                                <label for="slidedescriptionu">Description</label>
                                                <textarea  class="form-control" id="slidedescriptionu" name="txtSlideDescriptionU" 
                                                           placeholder="Enter Description" rows="3" ></textarea>
                                            </div>

                                            <div class="form-group">
                                                <label for="slidestatusu">Status</label>
                                                <input type="checkbox" class="checkbox-template" id="slidestatusu" name="txtSlideStatusU" />
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
                                    <th>Image</th>
                                    <th>DisplayOrder</th>
                                    <th>Link</th>
                                    <th>Description</th>
                                    <th>CreatedDate</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <th><a class="fa fa-plus btn btn-sm btn-primary" href="#" data-toggle="modal"
                                           data-target="#exampleModal"></a>Action</th>
                                    <th>#</th>
                                    <th>Image</th>
                                    <th>DisplayOrder</th>
                                    <th>Link</th>
                                    <th>Description</th>
                                    <th>CreatedDate</th>
                                    <th>Status</th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <%
                                    if (request.getAttribute("listSlide") != null) {
                                        ArrayList<SlideAdmin> listSlideAdmin = (ArrayList<SlideAdmin>) request.getAttribute("listSlide");
                                        for (SlideAdmin slide : listSlideAdmin) {
                                            int id = slide.getId();
                                            String image = slide.getImage();
                                            int displayorder = slide.getDisplayorder();
                                            String link = slide.getLink();
                                            String description = slide.getDescription();
                                            Date createddate = slide.getCreateddate();
                                            Boolean status = slide.isStatus();
                                %>
                                <tr>
                                    <td>
                                        <a class="fa fa-pencil btn btn-sm btn-success btnUpdate" href="#" data-id="<%=id%>" data-toggle="modal" data-target="#exampleModalUpdate"></a>
                                        <a class="fa fa-times btn btn-sm btn-danger btnDelete" href="<%=request.getContextPath()%>/admin/anh_show/delete/<%=id%>"></a>
                                    </td>
                                    <td><%=id%></td>
                                    <td class="slideimage<%=id%>" ><%=image%></td>
                                    <td class="slidedisplayorder<%=id%>" ><%=displayorder%></td>
                                    <td class="slidelink<%=id%>" ><%=link%></td>
                                    <td class="slidedes<%=id%>" ><%=description%></td>
                                    <td><%=createddate%></td>
                                    <td class="slidestatus<%=id%>" data-id="<%=status%>" ><%if (status == true) {%>Active<%} else {%>Not Active<%}%></td>
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
