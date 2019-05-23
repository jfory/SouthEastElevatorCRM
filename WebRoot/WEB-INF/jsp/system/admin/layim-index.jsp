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
<%-- <!-- jsp文件头和头部 -->
		<%@ include file="../../system/admin/top.jsp"%>  --%>

<!-- <link rel="stylesheet" href="static/web-im/static/css/webim.css" />  -->
</head>
<link href="static/layim/css/layim.css" type="text/css" rel="stylesheet"/>
<script src="static/js/jquery.min.js"></script>
<!--sdk-->
<script src="static/web-im/static/sdk/strophe.js"></script>
<script type="text/javascript" src="static/web-im/static/js/jquery-1.11.1.js"></script>
<script type='text/javascript' src='static/web-im/static/sdk/strophe.js'></script>
<script type="text/javascript" src="static/web-im/static/sdk/easemob.im-1.1.js"></script>
<script type="text/javascript" src="static/web-im/static/js/bootstrap.js"></script> 

<script src="static/layim/lay/lib.js"></script>
<script src="static/layim/lay/layer/layer.min.js"></script>
<script src="static/layim/lay/layim.js"></script>

<script type="text/javascript">
$(document).ready(function () {
 	$("#username").val("maiyatang");
 	$("#password").val("maiyatang");
 	
 });
 

</script>
<body>
<div id="login-box">
	<input type="hidden" id="username"/>
	<input type="hidden" id="password"/>
</div>
<!-- <div id="loginmodal" class="modal hide in" role="dialog"
        aria-hidden="true" data-backdrop="static">
        <div class="modal-header">
            <h3>用户登录</h3>
        </div>
        <div class="modal-body">
            <table>
                <tr>
                    <td width="65%">
                        <label for="username">用户名:</label>
                        <input type="text" name="username" value="" id="username" tabindex="1"/>
                        <label for="password">密码:</label>
                        <input type="password" name="password" value="" id="password" tabindex="2" />
                        <label for="token">令牌:</label>
                        <input type="text" name="token" value="" id="token" disabled="disabled" tabindex="3" />
                    </td>
                </tr>
            </table>
            <label class="checkbox">
                <input type="checkbox" name="usetoken" id="usetoken" tabindex="4" />使用令牌登录
            </label>    
        </div>
        <div class="modal-footer">
            <button class="flatbtn-blu" onclick="login()" tabindex="3">登录</button>
            <button class="flatbtn-blu" onclick="showRegist()" tabindex="4">注册</button>
        </div>
    </div> -->
    
</body>
</html>