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
				<form action="discount/${msg }.do" name="discountConfigForm" id="discountConfigForm" method="post">
				<input type="hidden" name="operateType" id="operateType" value="${operateType}">
				<input type="hidden" name="id" id="id" value="${pd.id}"/>
				<input type="hidden" name="user_id" id="user_id" value="${pd.user_id}"/>
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div class="row">
							<div class="col-sm-12">
				                <div class="form-group form-inline">
									<label>折扣(百分比):</label>
		                        	<input type="text" name="discount" id="discount"  value="${pd.discount}"  title="折扣"  placeholder="这里输入折扣" class="form-control">
		                        </div>
				                <div class="form-group form-inline">
									<label>限额:</label>
		                        	<input type="text" name="limit_config" id="limit_config"  value="${pd.limit_config}"  title="限额"  placeholder="这里输入限额" class="form-control">
	                        	</div>
							</div>
						</div>
					</div>
					<div style="height: 20px;"></div>
					<tr>
						<td><a class="btn btn-primary" style="width: 150px; height: 34px;float:left;" onclick="save();">保存</a></td>
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('discountConfig');">关闭</a></td>
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
     });

	//保存
	function save(){
		if($("#discount").val()==""){
			$("#discount").focus();
			$("#discount").tips({
				side:3,
	            msg:"请输入折扣",
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		var re = /^[0-9]+.?[0-9]*$/;
		if(!re.test($("#discount").val())||$("#discount").val()<0||$("#discount").val()>100){
			$("#discount").focus();
			$("#discount").tips({
				side:3,
	            msg:"请输入0-100之间的数字",
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		if($("#limit").val()==""){
			$("#limit").focus();
			$("#limit").tips({
				side:3,
	            msg:"请输入限额",
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		$("#discountConfigForm").submit();
	}


	//关闭页面
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();

	}
</script>
</body>

</html>
