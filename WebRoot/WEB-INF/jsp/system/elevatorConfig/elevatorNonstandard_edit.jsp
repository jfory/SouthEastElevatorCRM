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

<form action="elevatorConfig/${msg }.do" name="elevatorNonstandardForm" id="elevatorNonstandardForm" method="post">
	<input type="hidden" name="msg" id="msg" value="${msg}">
	<!-- province id -->
	<input type="hidden" name="elevator_nonstandard_id" id="elevator_nonstandard_id" value="${pd.elevator_nonstandard_id}" />
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div class="row">
							<div class="col-lg-12">
								
								
								<div class="form-group">
								
									<span style="color: red">*</span>
									<label style="width: 8%">电梯类型:</label>
										<select  style="width: 20%" class="form-control" id="elevator_id" name="elevator_id" onchange="elevatorOptionalListByElevatorId()">
											<option value="">请选择</option>
											<c:forEach items="${elevatorList }" var="elevator">
												<option value="${elevator.elevator_id }" ${elevator.elevator_id eq pd.elevator_id ? 'selected':'' } >${elevator.elevator_name }</option>
											</c:forEach>
										</select>
									
									<span style="color: red">*</span>
											<label style="width:8%">非标配置:</label>
											<input type="text" readonly="readonly" style="width:20%" 
												name="customer_area_text_ordinary" id="customer_area_text_ordinary" 
												value="${pd.name }"  
												placeholder="请选择功能" title="配置功能" 
												class="form-control" onClick="showAreaMenuOrdinary()"/>
											<input style="width:170px"  type="hidden" name="id" id="id"  value="${pd.id}"   title="配置功能"   class="form-control" >	
											
											<!-- ztree区域显示模块 -->
									 		<div class="ibox float-e-margins" id="areaContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:800px;overflow-y:scroll;overflow-x:auto">
												<div class="ibox-content">
													<div>
														<ul id="elevator_cascade_zTree" class="ztree" style="margin-top:0; width:800px;"></ul>
													</div>
												</div>
									 		</div>
									
											<span style="color: red">*</span>
											<label style="width: 8%">单位:</label>
											<select style="width: 20%" class="form-control" id="elevator_unit_id" name="elevator_unit_id">
												<option value="">请选择</option>
												<c:forEach items="${elevatorUnitList }" var="elevatorUnit">
													<option value="${elevatorUnit.elevator_unit_id }" ${elevatorUnit.elevator_unit_id eq pd.elevator_unit_id ? 'selected':'' }>${elevatorUnit.elevator_unit_name }</option>
												</c:forEach>
											</select>
											
											<span style="color: red">*</span>
											<label style="width: 8%">状态:</label>
											<select style="width: 20%" class="form-control" id="elevator_nonstandard_state" name="elevator_nonstandard_state">
												<option value="">请选择</option>
												<option value="1" ${pd.elevator_nonstandard_state eq 1 ? 'selected':'' }>启用</option>
			                                        <option value="2" ${pd.elevator_nonstandard_state eq 2 ? 'selected':'' }>禁用</option>
			                                        <option value="3" ${pd.elevator_nonstandard_state eq 3 ? 'selected':'' }>历史记录</option>
											</select> 
											<label>交货期:</label>
                                    <input  type="text"  placeholder="交货期"  id="elevator_nonstandard_delivery" name="elevator_nonstandard_delivery" value="${pd.elevator_nonstandard_delivery }"  class="form-control">
									
                                    <label>非标项价格:</label>
                                    <input  type="text"  placeholder="非标项价格"  id="elevator_nonstandard_price" name="elevator_nonstandard_price" value="${pd.elevator_nonstandard_price }"  class="form-control">
                                    
                                   	<label>描述:</label>
                                   	<textarea class="form-control" rows="10" cols="20" name="elevator_nonstandard_description" id="elevator_nonstandard_description" placeholder="这里输入备注" maxlength="250" title="备注" >${pd.elevator_nonstandard_description}</textarea>
								</div>
							</div>
						</div>
					</div>
					<div style="height: 20px;"></div>
					<tr>
						<td><button type="submit" class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="return funcsave();">保存</button></td>
						<c:if test="${msg eq 'addElevatorNonstandard'}">
							<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddElevatorNonstandard');">关闭</a></td>
						</c:if>
						<c:if test="${msg eq 'editElevatorNonstandard'}">
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditElevatorNonstandard');">关闭</a></td>
						</c:if>
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

		if ($("#elevator_nonstandard_name").val() == "" && $("#elevator_nonstandard_name").val() == "") {
			$("#elevator_nonstandard_name").tips({
				side: 3,
				msg: "请输入非标项名称",
				bg: '#AE81FF',
				time: 2
			});
			$("#elevator_nonstandard_name").focus();
			return false;
		}
		
		

		
	}
	
	//名称是否存在
	$("#elevator_speed_name").on("blur",function(){
		if($("#elevator_speed_name").val()!=null && $("#elevator_speed_name").val() !==""){
			var elevator_speed_id = $("#elevator_speed_id").val();
			var elevator_speed_name = $("#elevator_speed_name").val();
			$.post("elevatorConfig/existsElevatorSpeedName.do",{elevator_speed_id:elevator_speed_id,elevator_speed_name:elevator_speed_name},function(result){
				if(!result.success){
					
					$("#elevator_speed_name").tips({
						side: 3,
						msg: result.errorMsg,
						bg: '#AE81FF',
						time: 2
					});
					$("#elevator_speed_name").focus();
					$("#elevator_speed_name").val("");
					
				}
			});
		}
	});
	
	

	//关闭页面
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();

	}
	
	//功能显示 
	function showAreaMenuOrdinary() {
		var areaObj = $("#customer_area_text_ordinary");
		var areaOffset = $("#customer_area_text_ordinary").offset();
		$("#areaContent").css({left:(areaOffset.left+6) + "px", top:areaOffset.top + areaObj.outerHeight() + "px"}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	}
		
	var cascade_setting = {
		view: {
			dblClickExpand: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			beforeClick: beforeClickArea,
			onClick: onClickArea
		}
	};


	var elevatorCascadeNodes =null;
	var log, className = "dark";
	
	
	function beforeClickArea(treeId, treeNode) {
		var url = "<%=basePath%>elevatorCascade/checkElevatorCascadeNode.do";
		$.post(
			url,
			{parentId:treeNode.id},
			function(data){
				if(data.msg=='success'){
					$("#id").val(treeNode.id);
					$("#customer_area_text_ordinary").val(treeNode.name);
					$("#area_id_merchant").val(treeNode.id);
					$("#area_id_text_merchant").val(treeNode.name);
					$("#areaContent").hide();
					
					settingBranch(treeNode.id);
					return true;
				}
			}
		);
	}

	function onClickArea(e, treeId, treeNode) {}

	$(document).ready(function() {
		$.fn.zTree.init($("#elevator_cascade_zTree"), cascade_setting, elevatorCascadeNodes);
		var AreazTree = $.fn.zTree.getZTreeObj("elevator_cascade_zTree");
		AreazTree.expandAll(true);
		
		var msg = $("#msg").val();
		if(msg != "editElevatorNonstandard"){
		
			elevatorOptionalListByElevatorId();
		}
	});
	
	
	function showMenu() {
		var deptObj = $("#departmentSelect");
		var deptOffset = $("#departmentSelect").offset();
		$("#areaContent").css({left:(deptOffset.left+6) + "px", top:deptOffset.top + deptObj.outerHeight() + "px"}).slideDown("fast");

		$("body").bind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
			hideMenu();
		}
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	
	// 根据选择楼梯类型加载非标配置信息列表
	function elevatorOptionalListByElevatorId(){
		var elevator_id = $("#elevator_id").val();
		
		
		if(elevator_id != null && elevator_id != ""){
			
			$.post("elevatorConfig/elevatorOptionalListByElevatorId.do",{elevator_id:elevator_id},function(result){
				var str = eval('('+result+')');
				
				$("#customer_area_text_ordinary").val("");
				elevatorCascadeNodes = str;
				$.fn.zTree.init($("#elevator_cascade_zTree"), cascade_setting, elevatorCascadeNodes);
				var AreazTree = $.fn.zTree.getZTreeObj("elevator_cascade_zTree");
				AreazTree.expandAll(true);
				
				
			});
			
		}else{
			$("#customer_area_text_ordinary").val("");
		}
	}

</script>
</body>

</html>
