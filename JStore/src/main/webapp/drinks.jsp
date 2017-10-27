<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="head.jsp" />
        <link href="<%=request.getContextPath()%>/asset/pagination.css" type="text/css" rel="stylesheet"/>      
        <link href="<%=request.getContextPath()%>/asset/pagination.less" type="text/plain" rel="stylesheet"/>
    </head>
    <body>
        <jsp:include page="bodyheader.jsp" />
        <!-- products-breadcrumb -->
        <div class="products-breadcrumb">
            <div class="container">
                <ul>
                    <li><i class="fa fa-home" aria-hidden="true"></i><a href="index.html">Home</a><span>|</span></li>
                    <li>Beverages</li>
                </ul>
            </div>
        </div>
        <!-- //products-breadcrumb -->

        <!-- banner -->
        <div class="banner">
            <jsp:include page="bannernavleft.jsp"/>

            <div class="w3l_banner_nav_right">
                <div class="w3l_banner_nav_right_banner7">
                    <h3>Best Deals For New Products<span class="blink_me"></span></h3>
                </div>
                <div class="w3ls_w3l_banner_nav_right_grid w3ls_w3l_banner_nav_right_grid_sub">
                    <h3>Beverages</h3>
                    <div class="w3ls_w3l_banner_nav_right_grid1" >
                        <div id="tbodyContact"></div>


                        <div class="clearfix"> </div>
                    </div>
                    <div class="w3ls_w3l_banner_nav_right_grid1">
                        <div class="clearfix"> </div>
                        <h6> <div id="pagination-container" class="custom-paginationjs"></div>
                        </h6>
                        
                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!-- //banner -->


        <script src="<%=request.getContextPath()%>/asset/pagination.js" type="text/javascript" ></script>
        <script type="text/javascript">
            $(window).on('load', function () {

                loadTableContact("null", 9);
            });
            function loadTableContact(keysearch, key) {

                $('#pagination-container').pagination({
                    dataSource: function (done) {
                        var result = [];
                        $.ajax({
                            type: 'POST',
                            url: 'sanphamtheoloai',
                            dataType: 'json',
                            data: {keysearch: keysearch, key: key},
                            success: function (response) {
                                $(response).each(function (index, element) {
                                    result.push(element);
                                });
                                done(result);
                            },
                            timeout: 0
                        });
                    },
                    className: 'paginationjs-theme-blue paginationjs-big',
                    showGoInput: true,
                    showGoButton: true,
                    pageSize: 2,
                    callback: function (data, pagination) {
//                        console.log(pagination);
                        function simpleTemlating(data) {
                            var content = "";
                            $.each(data, function (index, item) {
//                                console.log(item);

                                content += `<div class="col-md-3 w3ls_w3l_banner_left">
                            <div class="hover14 column">
                                <div class="agile_top_brand_left_grid w3l_agile_top_brand_left_grid">
                                    <div class="agile_top_brand_left_grid_pos">
                                        <img src="asset/client/images/offer.png" alt=" " class="img-responsive" />
                                    </div>
                                    <div class="agile_top_brand_left_grid1">
                                        <figure>
                                            <div class="snipcart-item block">
                                                <div class="snipcart-thumb">
                                                    <a href="single.html"><img src="` + item.images + `" alt=" " class="img-responsive" /></a>
                                                    <p>` + item.name + `</p>
                                                    <h4>$` + item.promotionprice + ` <span>$` + item.price + `</span></h4>
                                                </div>
                                                <div class="snipcart-details">
                                                    <form action="#" method="post">
                                                        <fieldset>
                                                            <input type="hidden" name="cmd" value="_cart" />
                                                            <input type="hidden" name="add" value="1" />
                                                            <input type="hidden" name="business" value=" " />
                                                            <input type="hidden" name="item_name" value="` + item.name + `" />
                                                            <input type="hidden" name="amount" value="` + item.promotionprice + `" />
                                                            <input type="hidden" name="discount_amount" value="1.00" />
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
                        </div>`;

                            });
                            return content;
                        }
                        var html = simpleTemlating(data);
                        $("#tbodyContact").html(html);
                    }
                });
            }
        </script>
        
        <jsp:include page="footer.jsp" />
        <jsp:include page="footerscript.jsp" />

    </body>
</html>
