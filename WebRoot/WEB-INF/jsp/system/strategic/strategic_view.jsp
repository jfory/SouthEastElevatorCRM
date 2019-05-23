<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>

<head>

<base href="<%=basePath%>">


<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<title>${pd.SYSNAME}</title>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>
<!-- Fancy box -->
<script src="static/js/fancybox/jquery.fancybox.js"></script>

<link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>


<!-- 日期控件-->
<script src="static/js/layer/laydate/laydate.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		/* 图片 */
		$('.fancybox').fancybox({
			openEffect : 'none',
			closeEffect : 'none'
		});
	});
	
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		}
</script>
</head>
<body class="gray-bg">
	<form action="strategic/${msg}.do" name="strategicForm"
		id="strategicForm" method="post">
		<input type="hidden" name="stra_no" id="stra_no" value="${pd.stra_no}" />
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
							<div class="panel panel-primary">
								<div class="panel-heading">战略客户协议</div>
								<div class="panel-body">
									<div class="row" style="margin-left: 10px">
										  <div class="form-group form-inline">
										    <span style="color: red;">*</span> 
											<label style="width: 15%">协议编号:</label>
											<input style="width: 30%" type="text" name="stra_no" disabled="disabled"
												id="stra_no" value="${pd.stra_no}" readonly="readonly"
												title="协议名称" class="form-control" />
											<span style="color: red;">*</span> 
											<label style="width: 15%">协议名称:</label>
											<input style="width: 30%" type="text" name="stra_name" disabled="disabled"
												id="stra_name" value="${pd.stra_name}" placeholder="这里输入协议名称"
												title="协议名称" class="form-control" /> 
										</div>
										<div class="form-group form-inline">
										<span style="color: red;">*</span> 
										<label style="width: 15%">请选择战略客户:</label>
											 <select
										style="width: 30%" class="form-control" name="customer_name"
										id="customer_name"  disabled="disabled">
										<option value="">请选择</option>
										<c:forEach items="${customerlist}" var="cus">
											<option value="${cus.customer_no}"
												<c:if test="${cus.customer_no eq pd.customer_no && pd.customer_no != ''}">selected</c:if>>${cus.customer_name }</option>
										</c:forEach>
										</select>
										</div>
										<div class="form-group form-inline">
											<label style="width: 15%; margin-left: 10px;">协议条款:</label>
											<textarea rows="3" cols="64" name="stra_clause" disabled="disabled"
												id="stra_clause" placeholder="这里输入协议条款"
												class="form-control">${pd.stra_clause }</textarea>
										</div>
										<div class="form-group form-inline">
										   <label style="width: 15%; margin-left: 10px;">协议结束日期:</label> 
											<input style="width: 30%" type="text" name="end_Time" disabled="disabled"
												id="end_Time" value="${pd.end_Time}" readonly
												placeholder="这里输入协议结束日期" title="协议结束日期" onclick="laydate()"
												class="form-control" />
										</div>
										<div class="form-group form-inline">
											<label style="width: 15%; margin-left: 10px;">甲方:</label> 
											<input style="width: 30%" type="text" name="stra_owner" disabled="disabled"
											    id="stra_owner" value="${pd.stra_owner}"
												placeholder="这里输入甲方" title="甲方" class="form-control" />
											<label style="width: 15%; margin-left: 10px;">乙方:</label> 
											<input style="width: 30%" type="text" name="stra_second" disabled="disabled"
											    id="stra_second" value="${pd.stra_second}"
												placeholder="这里输入乙方" title="乙方" class="form-control" />
										</div>
										<div class="form-group form-inline">
											<label style="width: 15%; margin-left: 10px;">法定代表人:</label> 
											<input style="width: 30%" type="text" name="stra_ow_representative" disabled="disabled"
												id="stra_ow_representative" value="${pd.stra_ow_representative}" 
												placeholder="这里输入法定代表人" title="法定代表人" class="form-control">
												<label style="width: 15%; margin-left: 10px;">法定代表人:</label> 
											<input style="width: 30%" type="text" name="stra_se_representative"  disabled="disabled"
												id="stra_se_representative" value="${pd.stra_se_representative}" 
												placeholder="这里输入法定代表人" title="法定代表人" class="form-control">
										</div>
										<div class="form-group form-inline">
											<label style="width: 15%; margin-left: 10px;">委托人:</label> 
											<input style="width: 30%" type="text" type="text" name="stra_ow_entrusted" disabled="disabled"
												id="stra_ow_entrusted" value="${pd.stra_ow_entrusted}" placeholder="这里输入委托人"
												title="委托人" class="form-control"> 
											<label style="width: 15%; margin-left: 10px;">委托人:</label> 
											<input style="width: 30%" type="text" type="text" name="stra_se_entrusted" disabled="disabled"
												id="stra_se_entrusted" value="${pd.stra_se_entrusted}" placeholder="这里输入委托人"
												title="委托人" class="form-control"> 
										</div>
										<div class="form-group form-inline">
											<label style="width: 15%; margin-left: 10px;">联系电话:</label> 
											<input style="width: 30%" type="text" type="text" name="stra_ow_phone" disabled="disabled"
												id="stra_ow_phone" value="${pd.stra_ow_phone}" placeholder="这里输入联系电话"
												title="联系电话" class="form-control"> 
											<label style="width: 15%; margin-left: 10px;">联系电话:</label> 
											<input style="width: 30%" type="text" type="text" name="stra_se_phone" disabled="disabled"
												id="stra_se_phone" value="${pd.stra_se_phone}" placeholder="这里输入联系电话"
												title="联系电话" class="form-control"> 
										</div>
										<div class="form-group form-inline">
										<span style="color: red;">*</span> 
											<label style="width: 15%">签订日期:</label> 
											<input style="width: 30%" type="text" name="stra_SignedTime" disabled="disabled"
												id="stra_SignedTime" value="${pd.stra_SignedTime}" readonly
												placeholder="这里输入签订日期" title="签订日期" onclick="laydate()"
												class="form-control" />
										</div>
									</div>
								</div>
							</div>
							<tr>
								<td><a class="btn btn-danger"
							        style="width: 150px; height: 34px; float: right;"
							        onclick="javascript:CloseSUWin('EditShops');">关闭</a></td>
							</tr>
						</div>
					</div>
				</div>
	</form>
</body>
</html>
