<%@ page session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8"/>
<title>layui WebIM 1.0beta Demo</title>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
		<%@ include file="../../system/admin/top.jsp"%> 
<!--sdk-->
<script src="static/web-im/static/sdk/strophe.js"></script>
<script src="static/web-im/static/sdk/easemob.im-1.1.js"></script>
<script src="static/web-im/static/sdk/easemob.im-1.1.shim.js"></script><!--兼容老版本sdk需引入此文件-->

<!--config-->
<script src="static/web-im/static/js/easemob.im.config.js"></script>
</head>
<link href="css/layim.css" type="text/css" rel="stylesheet"/>
<body>
<script src="lay/lib.js"></script>
<script src="lay/layer/layer.min.js"></script>
<script src="lay/layim.js"></script>

<script type="text/javascript">
<script type="text/javascript">
$(document).ready(function () {
 	$("#username").val("maiyatang");
 	$("#password").val("maiyatang");
 	login();
 });
</script>
</script>
</body>
</html>