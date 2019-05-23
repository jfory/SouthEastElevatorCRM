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
    <!-- echarts -->
    <link href="static/css/echarts/style.css" rel="stylesheet">
    
    <style type="text/css">
    	.echarts{
    		height: 500px;
    	}
    </style>
    
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg" >
    <input type="hidden" name="type" id="type">

    <div class="col-sm-12">
        <div class="form-control form-inline" style="margin-bottom: 15px;height:2%;padding:10px;">
            <input class="form-control" id="nav-search-input" type="text"
			   name="input_date" onclick="laydate()"
			   placeholder="录入日期">
            <button id="btn_sreach" type="button" class="btn btn-primary " style="" onclick="sreanch()"><i style="font-size:18px;" class="fa fa-search"></i></button>
            <a class="btn btn-warning btn-outline" style="margin-left: 10px; height:32px;" title="导出到Excel" type="button" target="_blank" onclick="toExcel(this);" href="javascript:;">导出</a>
        </div>
		<div class="ibox-content">
            <div class="echarts" id="echarts-bar-chart"></div>
        </div>
    </div>

    
	<!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert/sweetalert.min.js"></script>
    <!-- ECharts -->
    <script src="static/js/plugins/echarts/echarts3/echarts.js"></script>
	<script type="text/javascript">
	 $(document).ready(function () {
		//loading end
		parent.layer.closeAll('loading');


        chart = echarts.init(document.getElementById("echarts-bar-chart"));
        
        $('#nav-search-input').val(getNowFormatDate());
        
        sreanch();
     });
	
	 function toExcel(ele){
		var input_date = $("input[name='input_date']").val();
	  	$(ele).attr("href", "<%=basePath%>report/toItemTrendReportExcel.do?"
	  			+"input_date="+input_date);
	}
	
	var chart;
    //set by type
    function sreanch(){
    	$('#btn_sreach').attr("disabled", "disabled");
	  	var input_date = $("input[name='input_date']").val();
        $.post("<%=basePath%>report/sreachItemTrendReport.do?input_date="+input_date,
            function(data){
        		$('#btn_sreach').removeAttr("disabled");
                var obj = eval("("+data+")");
                chart.setOption(obj,true);
            }
        );
    }
	 
  //获取当前时间，格式YYYY-MM-DD
    function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = year + seperator1 + month + seperator1 + strDate;
        return currentdate;
    }

	</script>
</body>

</html>
