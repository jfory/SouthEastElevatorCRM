<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/static/";
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>${pd.SYSNAME}</title>

    <link rel="shortcut icon" href="favicon.ico">
    <link href="static/css/bootstrap.min.css" rel="stylesheet">
    <link href="static/css/font-awesome.css" rel="stylesheet">

    <link href="static/css/animate.css" rel="stylesheet">
    <link href="static/css/style.css" rel="stylesheet">

</head>

<body class="gray-bg">


<div class="middle-box text-center animated fadeInDown">
    <h1>404</h1>
    <h2 class="font-bold">页面未找到！</h2>

        <div class="error-desc">
        </div>
</div>

<!-- 全局js -->
<script src="static/js/jquery.min.js"></script>
<script src="static/js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        //loading end
        parent.layer.closeAll('loading');
    });
</script>
</body>

</html>
