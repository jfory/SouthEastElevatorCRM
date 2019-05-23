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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>保存结果</title>
<base href="<%=basePath%>">
<meta name="description" content="overview & stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <!-- 全局js -->
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/metisMenu/jquery.metisMenu.js"></script>
    <script src="static/js/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="static/js/layer/layer.min.js"></script>
    <!-- 自定义js -->
    <script src="static/js/common.js?v=4.1.0"></script>
    <script type="text/javascript" src="static/js/contabs.js"></script>
    <!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
  <!-- Sweet alert -->
    <script src="static/js/sweetalert/sweetalert.min.js"></script>
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
<!-- 引入kendoui组件 -->
	<script src="static/js/kendoui/js/kendo.web.min.js"></script>
	<link href="static/js/kendoui/styles/kendo.common.min.css" rel="stylesheet">
	<link href="static/js/kendoui/styles/kendo.metro.min.css" rel="stylesheet">

</head>
<body>
	<script type="text/javascript">

		var rowIndex = "${pd.rowIndex}";
		var c_ = "${srPd.c_}";
		var z_ = "${srPd.z_}";
		var m_ = "${srPd.m_}";
		var sbj_ = "${srPd.sbj_}";
		var zk_ = "${srPd.zk_}";
		var yjze_ = "${srPd.yjze_}";
		var yjbl_ = "${srPd.yjbl_}";
		var sjbj_ = "${srPd.sjbj_}";
		var ele_azf_ = "${srPd.ele_azf_}";
		var azf_ = "${srPd.azf_}";
		var ysf_ = "${srPd.ysf_}";
		var id = "${id}";
		var bjc_id = "${bjc_id}";
		var buttonStr = "${buttonStr}";
		var buttonStr = "${buttonStr}";
		var buttonStr = "${buttonStr}";
		var buttonStr = "${buttonStr}";
		rowIndex = parseInt(rowIndex)+1;
		window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(0).find("input").eq(0).val(bjc_id);
		window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(2).text(c_+"/"+z_+"/"+m_);
		window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(3).text(sbj_);
		window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(4).text(zk_);
		window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(5).text(yjze_);
		window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(6).text(yjbl_);
		window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(7).text(ele_azf_);
		window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(10).text(ysf_);
		window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(11).text(sjbj_);
		window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(12).text("").append(buttonStr);

		var COUNT_SL    ="${CountPd.COUNT_SL}";
		var COUNT_SJZJ  ="${CountPd.COUNT_SJZJ}";
		var COUNT_ZK    ="${CountPd.COUNT_ZK}";
		var COUNT_YJ    ="${CountPd.COUNT_YJ}";
		var COUNT_BL    ="${CountPd.COUNT_BL}";
		var COUNT_AZF   ="${CountPd.COUNT_AZF}";
		var COUNT_YSF   ="${CountPd.COUNT_YSF}";
		var COUNT_TATOL ="${CountPd.COUNT_TATOL}";
		window.parent.$('#tab1 tr:last').find('td').eq(1).text(COUNT_SL);
		window.parent.$('#tab1 tr:last').find('td').eq(3).text(COUNT_SJZJ);
		window.parent.$('#tab1 tr:last').find('td').eq(4).text(COUNT_ZK);
		window.parent.$('#tab1 tr:last').find('td').eq(5).text(COUNT_YJ);
		window.parent.$('#tab1 tr:last').find('td').eq(6).text(COUNT_BL);
		window.parent.$('#tab1 tr:last').find('td').eq(7).find("input[name=TB_COUNT_AZF]").val(COUNT_AZF);
		window.parent.$('#tab1 tr:last').find('td').eq(10).text(COUNT_YSF);
		window.parent.$('#tab1 tr:last').find('td').eq(11).text(COUNT_TATOL);
		
		window.parent.$("#"+id).data("kendoWindow").close();
	</script>
</body>
</html>