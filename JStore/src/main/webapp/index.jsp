<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="head.jsp" />

    </head>
    <body>
        <jsp:include page="bodyheader.jsp" />

        <!-- banner -->
        <div class="banner">
            <jsp:include page="bannernavleft.jsp" />
            <div class="clearContentCusPg">
                <jsp:include page="bannernavright.jsp" />
            </div>
            <div class="clearfix"></div>
        </div>
        <!-- banner -->

        <div class="clearContentCusPg">
            <jsp:include page="content.jsp" />
        </div>

        <div id="addContentCusPg" class="container">

        </div>
        <ul id="pagination-demo" class="pagination-sm"></ul>

        <jsp:include page="footer.jsp" />
        <jsp:include page="footerscript.jsp" />

        <script type="text/javascript" src="<%=request.getContextPath()%>/asset/Paginationplugin/jquery.twbsPagination.min.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {

                $('#keySearchContent').keyup(function () {
                    if ($('#keySearchContent').val().length > 0) {
                        $('.clearContentCusPg').hide();
                        $('#addContentCusPg').show();
                        $('#pagination-demo').show();

                        var keyword = $('#keySearchContent').val();

                        var $pagination = $('#pagination-demo');
                        var defaultOpts = {
                            totalPages: 20,
                            visiblePages: 7
                        };
                        $pagination.twbsPagination(defaultOpts);
                        $.ajax({
                            type: 'POST',
                            data: {keyword: keyword, currentpage: 1},
                            dataType: 'JSON',
                            url: "timkiemsanpham",
                            success: function (data) {
                                var totalPages = data.newTotalPages;
                                console.log(data.listpro);
//                                console.log(data.newTotalPages);

                                $('#addContentCusPg').html(showProduct(data));

                                var currentPage = $pagination.twbsPagination('getCurrentPage');
                                $pagination.twbsPagination('destroy');
                                $pagination.twbsPagination($.extend({}, defaultOpts, {
                                    startPage: currentPage,
                                    totalPages: totalPages,
                                    onPageClick: function (event, page) {
                                        $.ajax({
                                            type: 'POST',
                                            data: {keyword: keyword, currentpage: page},
                                            dataType: 'JSON',
                                            url: "timkiemsanpham",
                                            success: function (data) {
                                                console.log(data.listpro);
                                                $('#addContentCusPg').html(showProduct(data));
                                            }
                                        });
                                    }

                                }));
                            }
                        });

                    } else {
                        $('.clearContentCusPg').show();
                        $('#addContentCusPg').hide();
                        $('#pagination-demo').hide();
                    }




                });


                function showProduct(data) {
                    var content = "";
                    content += ` <h3>List Product</h3>
        <div class="agile_top_brands_grids">`;

                    $.each(data, function (i, val) {
                        $.each(val, function (j, item) {
                            content += ` 
       
            <div class="col-md-3 top_brand_left">
                <div class="hover14 column">
                    <div class="agile_top_brand_left_grid">
                        <div class="agile_top_brand_left_grid_pos">
                            <img src="<%=request.getContextPath()%>/asset/client/images/offer.png" alt=" " class="img-responsive" />
                        </div>
                        <div class="agile_top_brand_left_grid1">
                            <figure>
                                <div class="snipcart-item block">
                                    <div class="snipcart-thumb">
                                        <a href="#"><img src="` + item.images + `" alt=" " class="img-responsive" /></a>
                                        <p>` + item.name + `</p>
                                        <h4>$` + item.promotionprice + ` <span>$` + item.price + `</span></h4>
                                    </div>
                                    <div class="snipcart-details top_brand_home_details">
                                        <form action="#" method="post">
                                            <fieldset>
                                                <input type="hidden" name="cmd" value="_cart" />
                                                <input type="hidden" name="add" value="1" />
                                                <input type="hidden" name="business" value=" " />
                                                <input type="hidden" name="item_name" value="` + item.name + `" />
                                                <input type="hidden" name="amount" value="` + item.promotionprice + `" />
                                                <input type="hidden" name="discount_amount" value=" " />
                                                <input type="hidden" name="currency_code" value="USD" />
                                                <input type="hidden" name="return" value=" " />
                                                <input type="hidden" name="cancel_return" value=" " />
                                                <input type="submit" name="submit" value="Add to cart" class="button" />
                                            </fieldset>
                                        </form>
                                    </div>
                                </div>
                            </figure>
                        </div>
                    </div>
                </div>
            </div>
           
    `;
                        });
                    });
                    content += ` 
        </div>`;

                    return content;
                }

            });
        </script>
    </body>
</html>
