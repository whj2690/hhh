<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>错误 - CRM系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="alert alert-danger">
            <h4 class="alert-heading">发生错误</h4>
            <p>${error}</p>
            <hr>
            <p class="mb-0">
                <a href="javascript:history.back()" class="btn btn-outline-danger">返回上一页</a>
            </p>
        </div>
    </div>
</body>
</html> 