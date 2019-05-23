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
	<%@ include file="../../../system/admin/top.jsp"%>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">

<form action="workflow/leave/${msg }.do" name="leaveForm" id="leaveForm" method="post">
	<%--用户ID--%>
	<input type="hidden" name="requester_id" id="requester_id" value="${userpds.USER_ID}"/>
	<!-- leave id -->
	<input type="hidden" name="id" id="id" value="${pd.id}" />
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div class="row">
							<div class="col-lg-12">
								<select class="form-control" name="leave_type" id="leave_type" title="请假类型">
									<option value="0"
											<c:if test="${pd.leave_type == '0'}"> selected</c:if>>
										病假
									</option>
									<option value="1"
											<c:if test="${pd.leave_type == '1'}"> selected</c:if>>
										事假
									</option>
									<option value="2"
											<c:if test="${pd.leave_type == '2'}"> selected</c:if>>
										婚假
									</option>
									<option value="3"
											<c:if test="${pd.leave_type == '3'}"> selected</c:if>>
										产假
									</option>
								</select>
								<div class="form-group form-inline" style="margin-top: 15px;">
									<label>开始时间:</label>
									<input  placeholder="选择开始时间" title="开始时间" class="form-control layer-date" value="${pd.start_time}" name="start_time" id="start_time">
									<label>结束时间:</label>
									<input  placeholder="选择结束时间" title="结束时间" class="form-control layer-date" value="${pd.end_time}" name="end_time" id="end_time">
								</div>
								<div class="form-group">
									<label>请假原因:</label>
									<textarea class="form-control" rows="10" cols="20" name="reason" id="reason" placeholder="这里输入请假原因" maxlength="250" title="请假原因" >${pd.reason}</textarea>
								</div>
							</div>
						</div>
					</div>
					<div style="height: 20px;"></div>
					<tr>
						<td><button type="submit" class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="return funcsave();">保存</button></td>
						<c:if test="${msg eq 'addLeave'}">
							<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddLeaves');">关闭</a></td>
						</c:if>
						<c:if test="${msg eq 'editLeave'}">
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditLeaves');">关闭</a></td>
						</c:if>
					</tr>
				</div>
			</div>

		</div>
	</div>
</form>
<!-- 日期框 -->
<!-- layerDate plugin javascript -->
<script src="static/js/layer/laydate/laydate.js"></script>
<script type="text/javascript">
	//保存
	function funcsave() {

		if ($("#leave_type").val() == "" && $("#leave_type").val() == "") {
			$("#leave_type").tips({
				side: 3,
				msg: "请选择请假类型",
				bg: '#AE81FF',
				time: 2
			});
			$("#leave_type").focus();
			return false;
		}

		if ($("#start_time").val() == "" && $("#start_time").val() == "") {

			$("#start_time").tips({
				side: 3,
				msg: "请选择开始时间",
				bg: '#AE81FF',
				time: 2
			});
			$("#start_time").focus();
			return false;
		}
		if ($("#end_time").val() == "" && $("#end_time").val() == "") {

			$("#end_time").tips({
				side: 3,
				msg: "请选择结束时间",
				bg: '#AE81FF',
				time: 2
			});
			$("#end_time").focus();
			return false;
		}
	}
	var start_time = {
		elem: '#start_time',
		format: 'YYYY-MM-DD',
		min: laydate.now(), //设定最小日期为当前日期
		max: '2099-06-16 23:59:59', //最大日期
		istime: false,
		istoday: true,
		choose: function(datas){
			end_time.min = datas; //开始日选好后，重置结束日的最小日期
			end_time.start = datas //将结束日的初始值设定为开始日
		},
		clear:function(dd){
			alert("clear");
		}
	};
	var end_time = {
		elem: '#end_time',
		format: 'YYYY-MM-DD',
		min: laydate.now(),
		max: '2099-06-16 23:59:59',
		istime: false,
		istoday: true,
		choose: function(datas){
			start_time.max = datas; //结束日选好后，重置开始日的最大日期
		}
	};

	laydate(start_time);
	laydate(end_time);

	//关闭页面
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();

	}
</script>
</body>

</html>
