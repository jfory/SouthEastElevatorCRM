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
    <!-- 图片插件 -->
    <link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
    <!-- echarts -->
    <link href="static/css/echarts/style.css" rel="stylesheet">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg" >
    <input type="hidden" name="type" id="type">

    <div class="col-sm-12">
        <div class="form-control form-inline" style="margin-bottom: 15px;height:2%">
            <select name="yearOption" id="yearOption" style="width:15%;margin-top: 5px" class="form-control m-b">
                <option value=''>全部年份</option>
            </select>
            <button type="button" class="btn btn-primary " style="margin-bottom:10px" onclick="setByType()"><i style="font-size:18px;" class="fa fa-search"></i></button>
        </div>

        <form action="" name="ReportForm" id="ReportForm" method="post">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>柱状图</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                        <a class="dropdown-toggle" data-toggle="dropdown" href="graph_flot.html#">
                            <i class="fa fa-wrench"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li><a href="javascript:void(0);" onclick="setType('year')">按年份</a>
                            </li>
                            <li><a href="javascript:void(0);" onclick="setType('month')">按月份</a>
                            </li>
                            <li><a href="javascript:void(0);" onclick="setType('quarter')">按季度</a>
                            </li>
                        </ul>
                        <a class="close-link">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>
                </div>
                <div class="ibox-content">
                    <div class="echarts" id="echarts-bar-chart"></div>
                </div>
            </div>
        </form>
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
    var chart;
	 $(document).ready(function () {
		//loading end
		parent.layer.closeAll('loading');

        //加载条件查询的年份
        setYearOption();

        //默认加载年份
        setType('year');
     });

    function setYearOption(){
        $.post("<%=basePath%>customer/findReportYearList.do",
            function(data){
                var yearList = data.yearList;
                var yearStr;
                for(var i = 0;i<yearList.length;i++){
                    yearStr += "<option value='"+yearList[i]+"'>"+yearList[i]+"年</option>";
                }
                $("#yearOption").append(yearStr);
            }
        );
    }



    function setType(type){
        $("#type").val(type);
        if(type!="year"){
            var yearOption = $("#yearOption").val();
            if(yearOption==""){
                var defaultSelect = $("#yearOption option:last").val();
                $("#yearOption").val(defaultSelect);
            }
        }
        setByType();
    }

    //set by type
    function setByType(){
        var type = $("#type").val();
        var yearOption = $("#yearOption").val();
        $.post("<%=basePath%>customer/setByType.do?type="+type+"&yearOption="+yearOption,
            function(data){
                chart = echarts.init(document.getElementById("echarts-bar-chart"));
                var obj = eval("("+data+")");
                chart.setOption(obj,true);
            }
        );
    }

	</script>
</body>

</html>
