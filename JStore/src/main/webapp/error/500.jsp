<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isErrorPage="true" %>

<% response.setStatus(500);%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <title>500</title>
        <jsp:include page="head.jsp" />
    </head>
    <body class="five-zero-zero">
        <div class="five-zero-zero-container">
            <div class="error-code">500</div>
            <div class="error-message">Lỗi máy chủ</div>
            <div class="button-place">
                <a href="<%=request.getContextPath()%>/trang_chu" class="btn btn-default btn-lg waves-effect">Trở về trang chủ</a>
            </div>
        </div>
    </body>
</html>