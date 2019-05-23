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
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>


</head>

<body class="gray-bg">
	<form action="product/${msg}.do" name="productForm" id="productForm"
		method="post">
		<input type="hidden" name="product_id" id="product_id"
			value="${pd.product_id}" />
		<%--用户ID--%>
		<input type="hidden" name="requester_id" id="requester_id"
			value="${userpds.USER_ID}" />

		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content">
							<div class="row">
								<div class="col-sm-12">
									<div class="ibox float-e-margins" id="menuContent"
										class="menuContent"
										style="display: none; position: absolute; z-index: 99; border: solid 1px #18a689; max-height: 300px; overflow-y: scroll; overflow-x: auto">
										<div class="ibox-content"></div>
									</div>
									<div class="panel panel-primary">
										<div class="panel-heading">产品线详情</div>
										<div class="panel-body">
											<div class="form-group form-inline">
												<span style="color: red">*</span> <label style="width: 13%">产品线名称:</label>
												<input style="width: 20%" type="text" placeholder="产品名称"
													id="product_name" name="product_name"
													value="${pd.product_name }" class="form-control"> <span
													style="color: red">*</span> <label style="width: 13%">所属电梯类型:</label>
												<select style="width: 20%" class="form-control"
													name="elevator_type" id="elevator_type">
													<option value="">请选择</option>
													<c:forEach items="${elevatorLits}" var="elev">
														<option value="${elev.elevator_id}"
															<c:if test="${elev.elevator_id eq pd.elevator_type && pd.elevator_type != ''}">selected</c:if>>${elev.elevator_name}</option>
													</c:forEach>
												</select>
											</div>

											<div class="form-group">
												<span>&nbsp;&nbsp;</span> <label style="width: 13%">产品线描述:</label>
												<textarea class="form-control" rows="10" cols="20"
													name="product_description" id="product_description"
													placeholder="这里输入备注" maxlength="250" title="备注">${pd.product_description}</textarea>
											</div>

										</div>
									</div>
								</div>
							</div>
						</div>
						<div style="height: 20px;"></div>
						<tr>
							<td><a class="btn btn-primary"
								style="width: 150px; height: 34px; float: left;"
								onclick="save();">保存</a></td>
							<c:if test="${msg eq 'productAdd'}">
								<td><a class="btn btn-danger"
									style="width: 150px; height: 34px; float: right;"
									onclick="javascript:CloseSUWin('AddProduct');">关闭</a></td>
							</c:if>
							<c:if test="${msg eq 'productEdit'}">
								<td><a class="btn btn-danger"
									style="width: 150px; height: 34px; float: right;"
									onclick="javascript:CloseSUWin('EditProduct');">关闭</a></td>
							</c:if>
						</tr>
					</div>
				</div>
			</div>
		</div>
	</form>

</body>


<%--zTree--%>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.all.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

	});
	//保存
	function save() {
		if ($("#product_name").val() == "") {
			$("#product_name").focus();
			$("#product_name").tips({
				side : 3,
				msg : '请填写产品线名称',
				bg : '#AE81FF',
				time : 2
			});
			return false;
		}

		if ($("#elevator_type").val() == "") {
			$("#elevator_type").focus();
			$("#elevator_type").tips({
				side : 3,
				msg : '请选择电梯类型',
				bg : '#AE81FF',
				time : 2
			});
			return false;
		}

		$("#productForm").submit();
	}

	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
	}
</script>
</html>
