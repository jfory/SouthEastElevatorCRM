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
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg" >
	<input type="hidden" name="checkJson" id="checkJson" value="${checkJson}">



 <!--返回顶部开始-->
        <div id="back-to-top">
            <a class="btn btn-warning btn-back-to-top" href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
                <i class="fa fa-chevron-up"></i>
            </a>
        </div>
        <!--返回顶部结束-->
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
		/* checkbox */
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });
     	
     	var checkJson = $("#checkJson").val();
     	var checkObj = eval("("+checkJson+")");
     	var bodyStr = "<form action='install/saveSelfCheck.do' name='SelfcheckForm' id='SelfcheckForm' method='post'>";
     	bodyStr += "<input type='hidden' name='saveJson' id='saveJson'>";
     	bodyStr += "<input type='hidden' name='details_id' id='details_id' value='${details_id}'>";
     	bodyStr += "<div class='wrapper wrapper-content'><div class='row'><div class='col-sm-12'>";
     	$.each(checkObj, function(index, obj){
     		bodyStr += "<div class='row' name='rows'><div class='col-sm-12'><div class='panel panel-primary'><div class='panel-heading'><label>分类 -> </label><label>"+obj.type+"</label></div><div class='panel-body'>";
     		$.each(obj.children, function(index, child){
	     		bodyStr += "<div class='form-group form-inline' name='options'>";
	     		bodyStr += "<label style='width:5%;margin-left: 20px'> 名称:</label>";
	     		bodyStr += "<input type='text' style='width:5%;border-style:none' readonly value='"+child.name+"'>";
	     		bodyStr += "<label style='width:5%;margin-left: 20px'>标准值:</label>";
	     		bodyStr += "<input type='text' style='width:5%;border-style:none' readonly value='"+child.std+"'>";
	     		bodyStr += "<label style='width:5%;margin-left: 20px'> 公差:</label>";
	     		bodyStr += "<input type='text' style='width:5%;border-style:none' readonly value='"+child.tol+"'>";
	     		bodyStr += "<label style='width:5%;margin-left: 20px'> 单位:</label>";
	     		bodyStr += "<input type='text' style='width:5%;border-style:none' readonly value='"+child.unit+"'>";
	     		bodyStr += "<label style='width:5%;margin-left: 20px'>实际值:</label>";
	     		bodyStr += "<input type='text' class='form-control' style='width:22%;margin-left:20px'/>";
	     		bodyStr += "<input type='checkbox' class='i-checks' name='states' value='1' style='margin-left:20px' onclick='return false'>合格  ";
	     		bodyStr += "<input type='checkbox' class='i-checks' name='states' value='2' style='margin-left:5px' onclick='return false'>不合格  ";
	     		bodyStr += "<input type='checkbox' class='i-checks' name='states' value='0' style='margin-left:5px' onclick='return false'>无此项  ";
	     		bodyStr += "</div>";
     		});
            bodyStr += "</div></div></div></div>";
     	});
     	bodyStr += "<div style='height: 20px;'></div><tr><td><a class='btn btn-primary' style='width:150px;height:34px;float:left;'onclick='save();'>保存</a></td><td>";
		bodyStr += "<a class='btn btn-danger' style='width:150px;height:34px;float:right;' onclick='javascript:CloseSUWin();'>关闭</a></td></tr>";
     	bodyStr += "</div></div></div>";
     	$("body").prepend(bodyStr);
     });

    //检测合格
    function checkOption(){
		$("div[name='options']").each(function(index, obj){
			var std = parseInt($(obj).find("input").eq(1).val());
			var tol = parseInt($(obj).find("input").eq(2).val());
			var val = parseInt($(obj).find("input").eq(4).val());
			if(isNaN(val)||val==""){
				$(obj).find("input[name='states']").eq(0).attr("checked", false);
				$(obj).find("input[name='states']").eq(1).attr("checked", false);
				$(obj).find("input[name='states']").eq(2).attr("checked", true);
			}else if(val>(std+tol)||val<(std-tol)){
				$(obj).find("input[name='states']").eq(0).attr("checked", false);
				$(obj).find("input[name='states']").eq(2).attr("checked", false);
				$(obj).find("input[name='states']").eq(1).attr("checked", true);
			}else{
				$(obj).find("input[name='states']").eq(1).attr("checked", false);
				$(obj).find("input[name='states']").eq(2).attr("checked", false);
				$(obj).find("input[name='states']").eq(0).attr("checked", true);
			}
		});
    }

    //生成json
    function setJson(){
        var jsonStr = "[";
        var childStr = "[";
    	$("div[name='rows']").each(function(index, obj){
    		var type = $(obj).find("label").eq(1).html();
            jsonStr += "{'type':'"+type+"','children':";
    		$(obj).find("div[name='options']").each(function(){
    			var name = $(this).find("input").eq(0).val();
    			var std = $(this).find("input").eq(1).val();
    			var tol = $(this).find("input").eq(2).val();
    			var unit = $(this).find("input").eq(3).val();
    			var actl = $(this).find("input").eq(4).val();
    			var state = $(this).find("input[name='states']:checked").val();
                childStr += "{'name':'"+name+"','std':'"+std+"','tol':'"+tol+"','unit':'"+unit+"','actl':'"+actl+"','state':'"+state+"'},"
    		});
            childStr = childStr.substring(0,childStr.length-1)+"]";
            jsonStr = jsonStr+childStr+"},";
            childStr = "[";
    	});
        jsonStr = jsonStr.substring(0,jsonStr.length-1)+"]";
        $("#saveJson").val(jsonStr);
    }

    //保存
    function save(){
    	checkOption();
    	setJson();
    	$("#SelfcheckForm").submit();
    }


	//检索
	function search(){
		$("#SelfcheckForm").submit();
	}
	//刷新iframe
    function refreshCurrentTab() {
     	$("#SelfcheckForm").submit();
    }

	function CloseSUWin() {
		window.parent.$("#SelfcheckReport").data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
