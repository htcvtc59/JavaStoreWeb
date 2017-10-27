<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Javascript files-->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/bootstrap/js/tether.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/bootstrap/js/jquery.cookie.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/bootstrap/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/bootstrap/js/charts-home.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/asset/bootstrap/js/front.js"></script>
<!-- Google Analytics: change UA-XXXXX-X to be your site's ID.-->
<!---->
<script type="text/javascript">
    (function (b, o, i, l, e, r) {
        b.GoogleAnalyticsObject = l;
        b[l] || (b[l] =
                function () {
                    (b[l].q = b[l].q || []).push(arguments)
                });
        b[l].l = +new Date;
        e = o.createElement(i);
        r = o.getElementsByTagName(i)[0];
        e.src = '//www.google-analytics.com/analytics.js';
        r.parentNode.insertBefore(e, r)
    }(window, document, 'script', 'ga'));
    ga('create', 'UA-XXXXX-X');
    ga('send', 'pageview');
</script>

<script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#example').DataTable({
            "scrollX": true,
            "scrollY": 550
        });
        $('table.display').DataTable({
            "scrollX": true,
            "scrollY": 550
        });
    });
</script>
<style type="text/css" >
    div.dataTables_wrapper {
        width: 100%;
        margin: 0 auto;
    }
</style>