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
								<div class="panel-heading">创建二排单</div>
									<div class="panel-body">
									<div class="row" style="margin-left: 10px">
										         <div class="form-group form-inline">
												    <span style="color: red;">*</span>
												    <label style="width: 15%">项目名称:</label> 
												    <input style="width: 30%" type="text" name="item_name" readonly="readonly"
														id="item_name" value="${pd.item_name}" disabled="disabled"
														placeholder="这里输入项目名称" title="项目名称" class="form-control" />
													<span type="hidden">&nbsp&nbsp&nbsp</span>
										            <span style="color: red;">*</span>
											        <label style="width: 15%">排产款是否到账:</label>
											        <select style="width: 30%" class="form-control" disabled="disabled"
													name="is_subscription" readonly id="is_subscription">
													<option value="">请选择</option>
													<option value="1" <c:if test="${pd.is_subscription =='1'}"> selected</c:if>>是</option>
													<option value="2" <c:if test="${pd.is_subscription =='2'}"> selected</c:if>>否</option>
												</select> 
										        </div>
										
												<div class="form-group form-inline">
									           <!-- 上传文件 -->
												<label style="width: 15%;margin-left:10px;">上传客户确认函:</label>
												 <input class="form-control" style="width: 30%" type="hidden" name="contract_text" id="contract_text" disabled="disabled" 
												 placeholder="这里输入附件" value="${pd.contract_text}" title="附件" /> 
												 <input style="width: 30%" class="form-control" type="file" name="contract" id="contract" disabled="disabled"
												readonly placeholder="这里输入附件" title="附件" onchange="upload(this,$('#contract_text'))" />
												<c:if
													test="${pd ne null and pd.contract_text ne null and pd.contract_text ne '' }">
													<a class="btn btn-mini btn-success"
														onclick="downFile($('#contract_text'))">下载附件</a>
												</c:if>
												<label style="width: 15%;margin-left:24px;">上传排产资料:</label>
												 <input class="form-control" style="width: 30%" type="hidden" name="production_datum" id="production_datum" disabled="disabled" 
												 placeholder="这里输入附件" value="${pd.production_datum}" title="附件" /> 
												 <input style="width: 30%" class="form-control" type="file" name="production" id="production" disabled="disabled"
												readonly placeholder="这里输入附件" title="附件" onchange="upload(this,$('#production_datum'))" />
												<c:if
													test="${pd ne null and pd.production_datum ne null and pd.production_datum ne '' }">
													<a class="btn btn-mini btn-success"
														onclick="downFile($('#production_datum'))">下载附件</a>
												</c:if>
											</div>
											<div class="form-group form-inline">
									          <!-- 上传文件 -->
												<label style="width: 15%;margin-left:10px;">土建勘测报告:</label>
												 <input class="form-control" style="width: 30%" type="hidden" name="appraisal_datum" id="appraisal_datum" disabled="disabled" 
												 placeholder="这里输入附件" value="${pd.appraisal_datum}" title="附件" /> 
												 <input style="width: 30%" class="form-control" type="file" name="appraisal" id="appraisal" disabled="disabled"
												readonly placeholder="这里输入附件" title="附件" onchange="upload(this,$('#appraisal_datum'))" />
												<c:if
													test="${pd ne null and pd.appraisal_datum ne null and pd.appraisal_datum ne '' }">
													<a class="btn btn-mini btn-success"
														onclick="downFile($('#appraisal_datum'))">下载附件</a>
												</c:if>
											</div>
											 <%-- <div class="form-group form-inline">
											        <span style="color: red;">*</span>
												    <label style="width: 15%">项目名称确认:</label> 
												    <input style="width: 30%" type="text" name="customerName" 
														id="customerName" value="${pd.customerName}" disabled="disabled"
														placeholder="这里输入项目名称" title="项目名称" class="form-control" />
													<span type="hidden">&nbsp&nbsp&nbsp</span>
													<span style="color: red;">*</span>
												    <label style="width: 15%">最终用户名确认:</label> 
												    <input style="width: 30%" type="text" name="ultimatelyUserName" 
														id="ultimatelyUserName" value="${pd.ultimatelyUserName}" disabled="disabled"
														placeholder="这里输入项目名称" title="项目名称" class="form-control" />
										   </div> --%>
										   <div class="form-group form-inline">
												 <label style="width: 15%;margin-left:10px;">日期:</label>
												 <input style="width: 30%" type="text" name="signedTime" disabled="disabled"
														id="signedTime" value="${pd.signedTime}" readonly
														placeholder="这里输入日期" title="签订日期" onclick="laydate()" class="form-control" />
										   </div>
										</div>
									</div>
							</div>
							<tr>
								<td><a class="btn btn-danger"
							        style="width: 150px; height: 34px; float: right;"
							        onclick="javascript:CloseSUWin('Viewstra');">关闭</a></td>
							</tr>
						</div>
					</div>
				</div>
	</form>
</body>
</html>
