<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<%@ include file="../../system/admin/top.jsp"%>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>${pd.SYSNAME}</title>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css"/>
	<!-- Sweet Alert -->
	<link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
	<style type="text/css">
		.ztree li span.button.defaultSkin_ico_open {
			margin-right: 2px;
			background-position: -110px -16px;
			vertical-align: top;
		}
		.ztree li span.button.defaultSkin_ico_close {
			margin-right: 2px;
			background-position: -110px -16px;
			vertical-align: top;
		}
		.ztree li span.button.defaultSkin_ico_docu {
			margin-right: 2px;
			background-position: -110px -16px;
			vertical-align: top;
		}

	</style>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<%--用户ID--%>
				<form action="forecast/${msg }.do" name="quotaForm" id="quotaForm" method="post">
				<input type="hidden" name="year" id="year" value="${pd.year}">
				<input type="hidden" name="month" id="month" value="${pd.month}">
				<input type="hidden" name="operateType" id="operateType" value="${operateType}">
				<input type="hidden" name="id" id="id" value="${pd.id}"/>
				<input type="hidden" name="user_id" id="user_id" value="${pd.user_id}"/>
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div class="row">
							<div class="col-sm-12">
				                <div class="form-group">
									<label style="width:20%;margin-top: 25px;margin-bottom: 10px">月份编号:</label>
									<select id="monthNoY" name="monthNoY" onchange="setMonth(this);" class="form-control m-b">
										<option value=''>请选择年份</option>
									</select>
									<select id="monthNoM" name="monthNoM" class="form-control m-b">
										<option value=''>请选择月份</option>
									</select>
	                        	</div>
				                <div class="form-group form-inline">
		                        	<input type="hidden" name="month_no" id="month_no"  value="${pd.month_no}">
									<label style="width:20%;margin-top: 25px;margin-bottom: 10px">该月指标:</label>
		                        	<input style="width:30%" type="text" name="month_quota" id="month_quota"  value="${pd.month_quota}"  title="该月指标"  placeholder="这里输入该月指标" class="form-control">
	                        	</div>
							</div>
						</div>
					</div>
					<div style="height: 20px;"></div>
					<tr>
						<td><a class="btn btn-primary" style="width: 150px; height: 34px;float:left;" onclick="save();">保存</a></td>
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('setQuota');">关闭</a></td>
					</tr>
				</div>
			</form>
			</div>

		</div>
	</div>
<%--zTree--%>
<script type="text/javascript"
		src="plugins/zTree/3.5.24/js/jquery.ztree.all.js"></script>
<!-- Sweet alert -->
<script src="static/js/sweetalert2/sweetalert2.js"></script>
<script src="static/js/layer/laydate/laydate.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		 //loading end
		 parent.layer.closeAll('loading');
		 //本页面点击
		 layer.closeAll('loading');
		 //给年份设置初始值
		 var optStr = "<option value=''>请选择年份</option>";
		 var yearPd = $("#year").val();
		 var selected = "";
		 for(var i = 0;i<100;i++){
		 	var year = 20+""+PrefixInteger(i,2);
		 	if(yearPd==year){
		 		selected = "selected";
		 	}else{
		 		selected = "";
		 	}
		 	optStr += "<option value='"+year+"' "+selected+" >"+year+"</option>";
		 }
		 $("#monthNoY").html(optStr);
		 if($("#monthNoY").val()!=""){
		 	setMonth($("#monthNoY"));
		 }
     });

	//日期范围限制
    var start = {
        elem: '#start_time',
        format: 'YYYYMM',
        max: '209906', //最大日期
        istime:true,
        istoday: false,
        choose: function (datas) {
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        elem: '#end_time',
        format: 'YYYYMM',
        max: '209906',
        istime: true,
        istoday: false,
        choose: function (datas) {
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    laydate(start);
    laydate(end);

    //数字补零
    function PrefixInteger(num, n) {
        return (Array(n).join(0) + num).slice(-n);
    }
    //设置月份
    function setMonth(obj){
    	var year = $(obj).val();
    	var userId = $("#user_id").val();
    	var type = $("#operateType").val();
    	var monthNo = $("#month_no").val();
    	var monthPd = $("#month").val();
    	$.post("<%=basePath%>forecast/getMonthNoByYear?year="+year+"&user_id="+userId+"&type="+type+"&month_no="+monthNo,
    			function(data){
    				if(data.msg=="success"){
    					var jsonObj = data.monthList;
    					var optStr = "<option value=''>请选择月份</option>";
    					var selected = "";
    					for(var i =0;i<jsonObj.length;i++){
    						if(monthPd==jsonObj[i]){
    							selected = "selected";
    						}else{
    							selected = "";
    						}
    						optStr += "<option value='"+jsonObj[i]+"' "+selected+" >"+jsonObj[i]+"</option>";
    					}
    					$("#monthNoM").html(optStr);
    				}
    			}
    	);
    }

	//保存
	function save(){
		if($("#monthNoY").val()==""){
			$("#monthNoY").focus();
			$("#monthNoY").tips({
				side:3,
	            msg:"请选择年份",
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		if($("#monthNoM").val()==""){
			$("#monthNoM").focus();
			$("#monthNoM").tips({
				side:3,
	            msg:"请选择月份",
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		var month_no = $("#monthNoY").val()+""+$("#monthNoM").val();
		$("#month_no").val(month_no);
		$("#quotaForm").submit();
	}

	//关闭页面
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();

	}
</script>
</body>

</html>
