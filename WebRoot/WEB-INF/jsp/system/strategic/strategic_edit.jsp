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
	//保存
	function save() {
		if ($("#stra_name").val() == "" && $("#stra_name").val() == "") {
			$("#stra_name").focus();
			$("#stra_name").tips({
				side : 3,
				msg : "请输入协议名称",
				bg : '#AE81FF',
				time : 3
			});

			return false;
		}

		if ($("#end_Time").val() == "" && $("#end_Time").val() == "") {
			$("#end_Time").focus();
			$("#end_Time").tips({
				side : 3,
				msg : "请选择协议结束日期",
				bg : '#AE81FF',
				time : 3
			});

			return false;
		}

		if ($("#customer_no").val() == "" && $("#customer_no").val() == "") {
			$("#customer_no").focus();
			$("#customer_no").tips({
				side : 3,
				msg : "请选择战略客户",
				bg : '#AE81FF',
				time : 3
			});

			return false;
		}
		if ($("#stra_SignedTime").val() == "" && $("#stra_SignedTime").val() == "") {
			$("#stra_SignedTime").focus();
			$("#stra_SignedTime").tips({
				side : 3,
				msg : "请选择签订日期",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
		$("#strategicForm").submit();
	}
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
	}

	//文件异步上传   e代表当前File对象,v代表对应路径值
	function upload(e, v) {
		var filePath = $(e).val();
		var arr = filePath.split("\\");
		var fileName = arr[arr.length - 1];
		var suffix = filePath.substring(filePath.lastIndexOf("."))
				.toLowerCase();
		var fileType = ".xls|.xlsx|.doc|.docx|.txt|.pdf|";
		if (filePath == null || filePath == "") {
			$(v).val("");
			return false;
		}

		//var data = new FormData($("#agentForm")[0]);
		var data = new FormData();
		data.append("file", $(e)[0].files[0]);
		$.ajax({
			url : "contract/upload.do",
			type : "POST",
			data : data,
			cache : false,
			processData : false,
			contentType : false,
			success : function(result) {
				if (result.success) {
					$(v).val(result.filePath);
				} else {
					alert(result.errorMsg);
				}
			}
		});
	}
	// 下载文件   e代表当前路径值 
	function downFile(e) {
		var downFile = $(e).val();
		window.location.href = "contract/down?downFile=" + downFile;
	}

	//日期范围限制
	var start = {
		elem : '#start_time',
		format : 'YYYY/MM/DD hh:mm:ss',
		max : '2099-06-16 23:59:59', //最大日期
		istime : true,
		istoday : false,
		choose : function(datas) {
			end.min = datas; //开始日选好后，重置结束日的最小日期
			end.start = datas //将结束日的初始值设定为开始日
		}
	};
	var end = {
		elem : '#end_time',
		format : 'YYYY/MM/DD hh:mm:ss',
		max : '2099-06-16 23:59:59',
		istime : true,
		istoday : false,
		choose : function(datas) {
			start.max = datas; //结束日选好后，重置开始日的最大日期
		}
	};
	laydate(start);
	laydate(end);
</script>
</head>
<body class="gray-bg">
	<form action="strategic/${msg}.do" name="strategicForm"
		id="strategicForm" method="post">
		<input type="hidden" name="stra_no" id="stra_no" value="${pd.stra_no}" />
		<input type="hidden" name="stra_strategy_key" id="stra_strategy_key" value="${pd.stra_strategy_key}" />
		<input type="hidden" name="stra_approval" id="stra_approval" value="${pd.stra_approval}" />
		<input type="hidden" name="stra_uuid" id="stra_uuid" value="${pd.stra_uuid}" />
		<input type="hidden" name="requester_id" id="requester_id" value="${pd.requester_id}" />
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
							<div class="panel panel-primary">
								<div class="panel-heading">战略客户协议</div>
								<div class="panel-body">
									<div class="row" style="margin-left: 10px">
										<c:if test="${msg== 'saveS' }">
										<div class="form-group form-inline">
											<span style="color: red;">*</span> 
											<label style="width: 15%">协议名称:</label>
											<input style="width: 30%" type="text" name="stra_name"
												id="stra_name" value="${pd.stra_name}" placeholder="这里输入协议名称"
												title="协议名称" class="form-control" /> 
												<span style="color: red;">*</span> 
												 <label style="width: 15%">协议结束日期:</label> 
											<input style="width: 30%" type="text" name="end_Time"
												id="end_Time" value="${pd.end_Time}" readonly
												placeholder="这里输入协议结束日期" title="协议结束日期" onclick="laydate()"
												class="form-control" />
										</div>
										</c:if>
										<c:if test="${msg== 'editS' }">
										  <div class="form-group form-inline">
										    <span style="color: red;">*</span> 
											<label style="width: 15%">协议编号:</label>
											<input style="width: 30%" type="text" name="stra_no"
												id="stra_no" value="${pd.stra_no}" readonly="readonly"
												title="协议名称" class="form-control" />
											<span style="color: red;">*</span> 
											<label style="width: 15%">协议名称:</label>
											<input style="width: 30%" type="text" name="stra_name"
												id="stra_name" value="${pd.stra_name}" placeholder="这里输入协议名称"
												title="协议名称" class="form-control" /> 
										</div>
										</c:if>
										<div class="form-group form-inline">
										 <span style="color: red;">*</span> 
										<label style="width: 15%">请选择战略客户:</label>
											 <select
										style="width: 30%" class="form-control" name="customer_no"
										id="customer_no">
										<option value="">请选择</option>
										<c:forEach items="${customerlist}" var="cus">
											<option value="${cus.customer_no}"
												<c:if test="${cus.customer_no eq pd.customer_no && pd.customer_no != ''}">selected</c:if>>${cus.customer_name }</option>
										</c:forEach>
									</select>
										</div>
										<div class="form-group form-inline">
											<label style="width: 15%; margin-left: 10px;">协议条款:</label>
											<textarea rows="3" cols="64" name="stra_clause"
												id="stra_clause" placeholder="这里输入协议条款"
												class="form-control">${pd.stra_clause }</textarea>
										</div>
										<c:if test="${msg== 'editS' }">
										<div class="form-group form-inline">
										   <label style="width: 15%; margin-left: 10px;">协议结束日期:</label> 
											<input style="width: 30%" type="text" name="end_Time"
												id="end_Time" value="${pd.end_Time}" readonly
												placeholder="这里输入协议结束日期" title="协议结束日期" onclick="laydate()"
												class="form-control" />
										</div>
										</c:if>
										<div class="form-group form-inline">
											<label style="width: 15%; margin-left: 10px;">甲方:</label> 
											<input style="width: 30%" type="text" name="stra_owner"
											    id="stra_owner" value="${pd.stra_owner}"
												placeholder="这里输入甲方" title="甲方" class="form-control" />
											<label style="width: 15%; margin-left: 10px;">乙方:</label> 
											<input style="width: 30%" type="text" name="stra_second"
											    id="stra_second" value="${pd.stra_second}"
												placeholder="这里输入乙方" title="乙方" class="form-control" />
										</div>
										<div class="form-group form-inline">
											<label style="width: 15%; margin-left: 10px;">法定代表人:</label> 
											<input style="width: 30%" type="text" name="stra_ow_representative" 
												id="stra_ow_representative" value="${pd.stra_ow_representative}" 
												placeholder="这里输入法定代表人" title="法定代表人" class="form-control">
												<label style="width: 15%; margin-left: 10px;">法定代表人:</label> 
											<input style="width: 30%" type="text" name="stra_se_representative" 
												id="stra_se_representative" value="${pd.stra_se_representative}" 
												placeholder="这里输入法定代表人" title="法定代表人" class="form-control">
										</div>
										<div class="form-group form-inline">
											<label style="width: 15%; margin-left: 10px;">委托人:</label> 
											<input style="width: 30%" type="text" type="text" name="stra_ow_entrusted"
												id="stra_ow_entrusted" value="${pd.stra_ow_entrusted}" placeholder="这里输入委托人"
												title="委托人" class="form-control"> 
											<label style="width: 15%; margin-left: 10px;">委托人:</label> 
											<input style="width: 30%" type="text" type="text" name="stra_se_entrusted"
												id="stra_se_entrusted" value="${pd.stra_se_entrusted}" placeholder="这里输入委托人"
												title="委托人" class="form-control"> 
										</div>
										<div class="form-group form-inline">
											<label style="width: 15%; margin-left: 10px;">联系电话:</label> 
											<input style="width: 30%" type="text" type="text" name="stra_ow_phone"
												id="stra_ow_phone" value="${pd.stra_ow_phone}" placeholder="这里输入联系电话"
												title="联系电话" class="form-control"> 
											<label style="width: 15%; margin-left: 10px;">联系电话:</label> 
											<input style="width: 30%" type="text" type="text" name="stra_se_phone"
												id="stra_se_phone" value="${pd.stra_se_phone}" placeholder="这里输入联系电话"
												title="联系电话" class="form-control"> 
										</div>
										<div class="form-group form-inline">
										<span style="color: red;">*</span> 
											<label style="width: 15%">签订日期:</label> 
											<input style="width: 30%" type="text" name="stra_SignedTime"
												id="stra_SignedTime" value="${pd.stra_SignedTime}" readonly
												placeholder="这里输入签订日期" title="签订日期" onclick="laydate()"
												class="form-control" />
										</div>
									</div>
								</div>
							</div>
							<tr>
								<td><a class="btn btn-primary"
									style="width: 150px; height: 34px; float: left;"
									onclick="save();">保存</a></td>
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
