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
	<%@ include file="../../system/admin/top.jsp"%>
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

<form action="offer/${msg }.do" name="elevatorNonstandardForm" id="elevatorNonstandardForm" method="post">
	<input type="hidden" name="msg" id="msg" value="${msg}">
	<!-- province id -->
	<input type="hidden" name="centre_id" id="centre_id" value="${pd.centre_id}" />
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div class="row">
							<div class="col-lg-12">
								
								
								<div class="form-group">
								
									
									
											<span style="color: red">*</span>
											<label >非标功能:</label>
											<select  class="form-control" id="elevator_nonstandard_id" name="elevator_nonstandard_id">
												<option value="">请选择</option>
												<c:forEach items="${elevatorNonstandardList }" var="elevatorNonstandard">
													<option value="${elevatorNonstandard.id }" ${nonstandardCentre.elevator_nonstandard_id eq elevatorNonstandard.id ?'selected':''}>${elevatorNonstandard.name }</option>
												</c:forEach>
											</select>
											
											
								</div>
							</div>
						</div>
					</div>
					<div style="height: 20px;"></div>
					<tr>
						<td><button type="submit" class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="return funcsave();">保存</button></td>
						<c:if test="${msg eq 'elevatorNonstandardManager'}">
							<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('elevatorNonstandard');">关闭</a></td>
						</c:if>
						<%-- <c:if test="${msg eq 'elevatorNonstandard'}">
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('elevatorNonstandard');">关闭</a></td>
						</c:if> --%>
					</tr>
				</div>
			</div>

		</div>
	</div>
</form>
<!-- 日期框 -->
<!-- layerDate plugin javascript -->
<%--zTree--%>
<script type="text/javascript"
		src="plugins/zTree/3.5.24/js/jquery.ztree.all.js"></script>
<script src="static/js/layer/laydate/laydate.js"></script>
<script type="text/javascript">
	//保存
	function funcsave() {

		if ($("#elevator_nonstandard_id").val() == "" && $("#elevator_nonstandard_id").val() == "") {
			$("#elevator_nonstandard_id").tips({
				side: 3,
				msg: "请选择非标项功能",
				bg: '#AE81FF',
				time: 2
			});
			$("#elevator_nonstandard_id").focus();
			return false;
		}
		
		

		
	}
	
	
	
	

	//关闭页面
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();

	}
	

		
	


	
	
	

	

	$(document).ready(function() {
		
	});
	
	
	
	
	
	

</script>
</body>

</html>
