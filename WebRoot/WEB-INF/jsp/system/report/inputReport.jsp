<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
 <!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg" >
    <input type="hidden" name="type" id="type">

    <div class="col-sm-12">
        <div class="form-control form-inline" style="margin-bottom: 15px;height:2%;padding:10px;">
            <input class="form-control" id="nav-search-input" type="text"
			   name="input_date_start"
                                 onclick="laydate()"
			   placeholder="录入日期开始于">
		- <input class="form-control" id="nav-search-input" type="text"
			   name="input_date_end"
                                 onclick="laydate()"
			   placeholder="录入日期结束于">
            <a class="btn btn-warning btn-outline" style="margin-left: 10px; height:32px;" title="导出到Excel" type="button" target="_blank" onclick="toExcel(this);" href="javascript:;">导出</a>
        </div>

    </div>

    
	<!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert/sweetalert.min.js"></script>
	<script type="text/javascript">
	 $(document).ready(function () {
		//loading end
		parent.layer.closeAll('loading');


     });
	
	 function toExcel(ele){
	  	var input_date_start = $("input[name='input_date_start']").val();
	  	var input_date_end = $("input[name='input_date_end']").val();
	  	$(ele).attr("href", "<%=basePath%>report/toInputReportExcel.do?"
	  			+"&input_date_start="+input_date_start
	  			+"&input_date_end="+input_date_end);
	}

	</script>
</body>

</html>
