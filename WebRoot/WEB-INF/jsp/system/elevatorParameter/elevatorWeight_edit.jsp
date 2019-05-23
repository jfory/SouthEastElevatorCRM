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
</head>

<body class="gray-bg">

<form action="elevatorParameter/${msg }.do" name="elevatorWeightForm" id="elevatorWeightForm" method="post">
	
	<!-- province id -->
	<input type="hidden" name="elevator_weight_id" id="elevator_weight_id" value="${pd.elevator_weight_id}" />
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div class="row">
							<div class="col-lg-12">
								
								
								<div class="form-group">
									<label  id="agentNo">重量参数名称:</label>
                                    <input  type="text"  placeholder="重量参数名称"  id="elevator_weight_name" name="elevator_weight_name" value="${pd.elevator_weight_name }"  class="form-control">
                                    <label>电梯类型:</label>
                                    <select class="form-control" id="elevator_id" name="elevator_id">
                                    	<option value="">请选择</option>
                                    	<c:forEach  items="${elevatorList }" var="elevator">
                                    		<option value="${elevator.elevator_id }" ${elevator.elevator_id eq pd.elevator_id ? 'selected':'' }>${elevator.elevator_name }</option>
                                    	</c:forEach>
                                    </select>
								</div>
							</div>
						</div>
					</div>
					<div style="height: 20px;"></div>
					<tr>
						<td><button type="submit" class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="return funcsave();">保存</button></td>
						<c:if test="${msg eq 'addElevatorWeight'}">
							<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddElevatorWeight');">关闭</a></td>
						</c:if>
						<c:if test="${msg eq 'editElevatorWeight'}">
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditElevatorWeight');">关闭</a></td>
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

		if ($("#elevator_weight_name").val() == "" && $("#elevator_weight_name").val() == "") {
			$("#elevator_weight_name").tips({
				side: 3,
				msg: "请输入重量参数名称",
				bg: '#AE81FF',
				time: 2
			});
			$("#elevator_weight_name").focus();
			return false;
		}
		
		

		
	}
	
	//名称是否存在
	$("#elevator_weight_name").on("blur",function(){
		if($("#elevator_weight_name").val()!=null && $("#elevator_weight_name").val() !==""){
			var elevator_weight_id = $("#elevator_weight_id").val();
			var elevator_weight_name = $("#elevator_weight_name").val();
			$.post("elevatorParameter/existsElevatorWeightName.do",{elevator_weight_id:elevator_weight_id,elevator_weight_name:elevator_weight_name},function(result){
				if(!result.success){
					
					$("#elevator_weight_name").tips({
						side: 3,
						msg: result.errorMsg,
						bg: '#AE81FF',
						time: 2
					});
					$("#elevator_weight_name").focus();
					$("#elevator_weight_name").val("");
					
				}
			});
		}
	});
	
	

	//关闭页面
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();

	}
</script>
</body>

</html>
