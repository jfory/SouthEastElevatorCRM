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

<form action="elevatorConfig/${msg }.do" name="elevatorBaseForm" id="elevatorBaseForm" method="post">
	
	<!-- province id -->
	<input type="hidden" name="elevator_base_id" id="elevator_base_id" value="${pd.elevator_base_id}" />
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div class="row">
							<div class="col-lg-12">
								
								
								<div class="form-group">
									<label>电梯类型:</label>
										<select  style="width: 20%" class="form-control" id="elevator_id" name="elevator_id" >
											<option value="">请选择</option>
											<c:forEach items="${elevatorList }" var="elevator">
												<option value="${elevator.elevator_id }" ${elevator.elevator_id eq pd.elevator_id ? 'selected':'' } >${elevator.elevator_name }</option>
											</c:forEach>
									</select>
									<label>基础配置名称:</label>
                                    <input  type="text"  placeholder="基础配置名称"  id="elevator_base_name" name="elevator_base_name" value="${pd.elevator_base_name }"  class="form-control">
                                   
                                    
                                   	<label>描述:</label>
                                   	<textarea class="form-control" rows="10" cols="20" name="elevator_base_description" id="elevator_base_description" placeholder="这里输入备注" maxlength="250" title="备注" >${pd.elevator_base_description}</textarea>
								</div>
							</div>
						</div>
					</div>
					<div style="height: 20px;"></div>
					<tr>
						<td><button type="submit" class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="return funcsave();">保存</button></td>
						<c:if test="${msg eq 'addElevatorBase'}">
							<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddElevatorBase');">关闭</a></td>
						</c:if>
						<c:if test="${msg eq 'editElevatorBase'}">
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditElevatorBase');">关闭</a></td>
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

		if ($("#elevator_base_name").val() == "" && $("#elevator_base_name").val() == "") {
			$("#elevator_base_name").tips({
				side: 3,
				msg: "请输入基础配置名称",
				bg: '#AE81FF',
				time: 2
			});
			$("#elevator_base_name").focus();
			return false;
		}
		
		

		
	}
	
	//名称是否存在
	$("#elevator_base_name").on("blur",function(){
		if($("#elevator_base_name").val()!=null && $("#elevator_base_name").val() !==""){
			var elevator_base_id = $("#elevator_base_id").val();
			var elevator_base_name = $("#elevator_base_name").val();
			$.post("elevatorConfig/existsElevatorBaseName.do",{elevator_base_id:elevator_base_id,elevator_base_name:elevator_base_name},function(result){
				if(!result.success){
					
					$("#elevator_base_name").tips({
						side: 3,
						msg: result.errorMsg,
						bg: '#AE81FF',
						time: 2
					});
					$("#elevator_base_name").focus();
					$("#elevator_base_name").val("");
					
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
