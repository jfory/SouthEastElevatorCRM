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


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>${pd.SYSNAME}</title>
    <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css"/>
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	
	
</head>

<body class="gray-bg">
<form action="elevatorUnit/${msg}.do" name="elevatorUnitForm" id="elevatorUnitForm" method="post">
	<input type="hidden" name="elevator_unit_id" id="elevator_unit_id" value="${pd.elevator_unit_id}" />
	<%--用户ID--%>
	<input type="hidden" name="requester_id" id="requester_id" value="${userpds.USER_ID}"/>
	
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
                            
                               <div class="ibox float-e-margins" id="menuContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
									<div class="ibox-content">
										
									</div>
							  </div>
							  
								
                                	<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	单元详情
                                    </div>
                                    <div class="panel-body" >
                                        
                                       
                                        
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
											<label style="width:6%" >名称:</label>
                                    		<input style="width:20%"  type="text"  placeholder="名称"  id="elevator_unit_name" name="elevator_unit_name" value="${pd.elevator_unit_name }"  class="form-control">
                                    			
                                    		
                                        		 	
                                        </div>
                                        
                                   		
                                   		<div class="form-group">
                                   			<span>&nbsp;&nbsp;</span>
                                        	<label style="width:6%">描述:</label>
                                        	<textarea class="form-control" rows="10" cols="20" name="elevator_unit_remark" id="elevator_unit_remark" placeholder="这里输入描述" maxlength="250" title="备注" >${pd.elevator_unit_remark}</textarea>
                                   	   </div>
                                   	   
                                   </div>
                                </div>
                            	
                                    
                                    
                               
                            
                            </div>
                            
                        </div>
                        
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                        <c:if test="${msg eq 'addElevatorUnit'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddElevatorUnit');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'editElevatorUnit'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditElevatorUnit');">关闭</a></td>
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
	
	
	$(document).ready(function(){
		findStoreyBySpeedId();
	});
	
	
	
		//保存
		function save(){
			
			
			
			
			if($("#elevator_unit_name").val()==""){
				$("#elevator_unit_name").focus();
				$("#elevator_unit_name").tips({
					side:3,
		            msg:'请填写单元名称',
		            bg:'#AE81FF',
		            time:2
		        });
				
				
				return false;
			}
			
			
			
			
			
			
			
			$("#elevatorUnitForm").submit();
		}
		
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		}
		
	
		
		//名称是否存在
		$("#elevator_unit_name").on("blur",function(){
			if($("#elevator_unit_name").val()!=null && $("#elevator_unit_name").val() !==""){
				var elevator_unit_id = $("#elevator_unit_id").val();
				var elevator_unit_name = $("#elevator_unit_name").val();
				$.post("elevatorUnit/existsElevatorUnitName.do",{elevator_unit_id:elevator_unit_id,elevator_unit_name:elevator_unit_name},function(result){
					if(!result.success){
						
						$("#elevator_unit_name").tips({
							side: 3,
							msg: result.errorMsg,
							bg: '#AE81FF',
							time: 2
						});
						$("#elevator_unit_name").focus();
						$("#elevator_unit_name").val("");
						
					}
				});
			}
		});
		
		 
		
		
	
		
		
		
		
		
		
		
		
		
		
		
	</script>
</html>
