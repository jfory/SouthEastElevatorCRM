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
    
	<title>${pd.SYSNAME}</title>
	<!-- <script src="http://code.jquery.com/jquery-1.7.2.min.js"></script> -->
</head>

<body class="gray-bg" >
	 <div id="contract"  class="col-sm-12">
    	<form>
    	<div  class="form-control form-inline" style="margin-bottom: 15px;height:2%;padding:10px;">
			  <input class="form-control" id="nav-search-input1" type="text"
			   name="input_date" onclick="laydate()"
			   placeholder="统计日期" >
			  <!--  <select id="test" style="height: 34px;margin-left: 10px;" onchange="contract()">
			  	    <option id="btn_sreach" value="1"  selected="selected">合同评审</option>
    				<option id="btn_sreach2"  value="2"  >合同评审台数</option>
    		   </select> -->
    		   <button id="btn_sreach" type="button" class="btn btn-primary " style="" onclick="sreanch1()"><i style="font-size:18px;" class="fa fa-search"></i></button>
    	<a class="btn btn-warning btn-outline" style="margin-left: 10px; height:32px;" title="导出到Excel" type="button" target="_blank" onclick="toExcel(this);" href="javascript:;">导出</a>
        </div>
        <div class="ibox-content">
            <div class="echarts" id="echarts-bar-chart1" style="width:1015px;height:600px;margin: 10px;"></div>
       	</div>
    	</form>
   </div>
   <!-- <div  id="contractRolling" class="gray-bg"  style="display:none">
   		<form>
   			<div class="form-control form-inline" style="margin-bottom: 15px;height:2%;padding:10px;;">
				   <input class="form-control" id="nav-search-input2" type="text"
				   name="input_date2" onclick="laydate()"
				   placeholder="统计日期">
				   <select id="test2" style="height: 34px;margin-left: 10px;" onchange="contractRolling()">
	    		   		<option id="btn_sreach" value="1">合同评审</option>
	    		   		<option id="btn_sreach2" value="2" selected="selected">合同评审台数</option>
	    		   </select>
	    		   <button id="btn_sreach" type="button" class="btn btn-primary " style="" onclick="sreanch2()"><i style="font-size:18px;" class="fa fa-search"></i></button>
	    		   <a class="btn btn-warning btn-outline" style="margin-left: 10px; height:32px;" title="导出到Excel" type="button" target="_blank" onclick="toExcel(this);" href="javascript:;">导出</a>
        	 </div>
        	<div class="ibox-content">
            		<div class="echarts" id="echarts-bar-chart2" style="width:1015px;height:600px;"></div>
       		</div>
       	</form>
    </div> -->
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
		if($("#contract").is(":visible")){
	    	chart = echarts.init(document.getElementById("echarts-bar-chart1"));
			 $('#nav-search-input1').val(getNowFormatDate());
			sreanch1();
		}/* else{
			chart = echarts.init(document.getElementById("echarts-bar-chart2"));
			$('#nav-search-input2').val(getNowFormatDate());
			 sreanch2();
		} */
     });
	 
	 function contract(){
		 var obj = document.getElementById("test");
		 var index = obj.selectedIndex; // 选中索引
		 var value = obj.options[index].value; // 选中值
		 var text = obj.options[index].text;
		 var contract =  document.getElementById("contract");
		 var contractRolling = document.getElementById("contractRolling");
		 if(text=='合同评审'){
			 contractRolling.style.display='none';
			 contract.style.display='block';
		 return;
	 }else{
		 contract.style.display='none';
		 contractRolling.style.display='block';
	 	sreanch2();
	 	return;
	 }
		 }
	 	function contractRolling(){
			 var obj = document.getElementById("test2");
			 var index = obj.selectedIndex; // 选中索引
			 var value = obj.options[index].value; // 选中值
			 var text = obj.options[index].text;
			 var contract =  document.getElementById("contract");
			 var contractRolling = document.getElementById("contractRolling");
			 if(text=='合同评审'){
				/*  contractRolling.style.display='none';
				 contract.style.display='block'; */
				 refurbish();
				 return ;
		 }else{
			 contract.style.display='none';
			 contractRolling.style.display='block';
			 sreanch2();
			 return ;
		 }
	 	}
	 	
	 	function toExcel(ele){
	 		 var date = document.getElementById("nav-search-input1").value;
	 			var a = date.split("-");
		 		var month = a[1];
		 		$(ele).attr("href", "<%=basePath%>report/toContracTreviewExcel.do?"
			  			+"&date="+date
			  			+"&month="+month);
	 	}
	 	
	 	
	 	
	 	var chart;
	    //set by type
	    function sreanch1(){
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
	    
	    var chart;
	    function sreanch2(){
	    	chart = echarts.init(document.getElementById("echarts-bar-chart2"));
	    	if(!$('#nav-search-input2').val()){
	    		$('#nav-search-input2').val(getNowFormatDate());
	    	}
			$('#nav-search-input2').val();
	    	$('#btn_sreach2').attr("disabled", "disabled");
		  	var input_date = $("input[name='input_date2']").val();
	        $.post("<%=basePath%>report/sreachItemTrendReport.do?input_date="+input_date,
	            function(data){
	        		$('#btn_sreach2').removeAttr("disabled");
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
	 	 //当前页面刷新
	 	 function   refurbish(){
	 		window.location.reload();
	 	 } 
	</script>
</body>
</html>