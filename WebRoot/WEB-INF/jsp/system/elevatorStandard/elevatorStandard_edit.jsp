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
<form action="elevatorStandard/${msg}.do" name="elevatorStandardForm" id="elevatorStandardForm" method="post">
	<input type="hidden" name="elevator_standard_id" id="elevator_standard_id" value="${pd.elevator_standard_id}" />
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
                                        	电梯标准价格详情
                                    </div>
                                    <div class="panel-body" >
                                        
                                        <div class="form-group form-inline">
	                                    	
											
											<span style="color: red">*</span>
											<label style="width: 10%">电梯速度(m/s):</label>
											<select style="width: 18%" class="form-control" id="elevator_speed_id" name="elevator_speed_id" onchange="findStoreyBySpeedId()">
												<option value="">请选择</option>
												<c:forEach items="${elevatorSpeedList }" var="elevatorSpeed">
													<option value="${elevatorSpeed.elevator_speed_id }" ${elevatorSpeed.elevator_speed_id eq pd.elevator_speed_id ? 'selected':''}>${elevatorSpeed.elevator_speed_name }</option>
												</c:forEach>
											</select>
											
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">电梯重量(KG):</label>
											<select style="width: 18%" class="form-control" id="elevator_weight_id" name="elevator_weight_id">
												<option value="">请选择</option>
												<c:forEach items="${elevatorWeightList }" var="elevatorWeight">
													<option value="${elevatorWeight.elevator_weight_id }" ${elevatorWeight.elevator_weight_id eq pd.elevator_weight_id ?'selected':'' } >${elevatorWeight.elevator_weight_name }</option>
												</c:forEach>
											</select>
											
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">电梯楼层(层):</label>
											<select style="width: 18%" class="form-control" id="elevator_storey_id" name="elevator_storey_id">
												
											</select>
                                    	</div>
                                        
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
											<label style="width:10%" >名称:</label>
                                    		<input style="width:18%"  type="text"  placeholder="名称"  id="elevator_standard_name" name="elevator_standard_name" value="${pd.elevator_standard_name }"  class="form-control">
                                    			
                                    		&nbsp;&nbsp;&nbsp;
                                        	<span style="color: red">*</span>
                                    			
                                   			<label style="width:10%">电梯标准金额:</label>
                                       		<input style="width:18%" type="text" placeholder="这里输入电梯标准金额"  id="elevator_standard_price" name="elevator_standard_price" value="${pd.elevator_standard_price }" class="form-control">
                                        		 	
                                        </div>
                                        
                                   		
                                   		<div class="form-group">
                                   			<span>&nbsp;&nbsp;</span>
                                        	<label style="width:6%">描述:</label>
                                        	<textarea class="form-control" rows="10" cols="20" name="elevator_standard_description" id="elevator_standard_description" placeholder="这里输入描述" maxlength="250" title="备注" >${pd.elevator_standard_description}</textarea>
                                   	   </div>
                                   	   
                                   </div>
                                </div>
                            	
                                    
                                    
                               
                            
                            </div>
                            
                        </div>
                        
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                        <c:if test="${msg eq 'addElevatorStandard'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddElevatorStandard');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'editElevatorStandard'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditElevatorStandard');">关闭</a></td>
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
			if($("#elevator_speed_id").val()==""){
				$("#elevator_speed_id").focus();
				$("#elevator_speed_id").tips({
					side:3,
		            msg:'请选择电梯速度',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			if($("#elevator_weight_id").val()==""){
				$("#elevator_weight_id").focus();
				$("#elevator_weight_id").tips({
					side:3,
		            msg:'请选择电梯重量',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			if($("#elevator_storey_id").val()==""){
				$("#elevator_storey_id").focus();
				$("#elevator_storey_id").tips({
					side:3,
		            msg:'请选择电梯楼层',
		            bg:'#AE81FF',
		            time:2
		        });
				
				return false;
			}
			
			if($("#elevator_standard_name").val()==""){
				$("#elevator_standard_name").focus();
				$("#elevator_standard_name").tips({
					side:3,
		            msg:'请填写名称',
		            bg:'#AE81FF',
		            time:2
		        });
				
				
				return false;
			}
			
			if($("#elevator_standard_price").val()==""){
				$("#elevator_standard_price").focus();
				$("#elevator_standard_price").tips({
					side:3,
		            msg:'请填写电梯标准金额',
		            bg:'#AE81FF',
		            time:2
		        });
				
				
				return false;
			}
			
			
			
			
			
			$("#elevatorStandardForm").submit();
		}
		
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		}
		
		//根据电梯速度参数查询楼层
		function findStoreyBySpeedId(){
			var elevator_speed_id = $("#elevator_speed_id").val();
			var elevator_standard_id = $("#elevator_standard_id").val();
			$("#elevator_storey_id").html("");
			if(elevator_speed_id !=null && elevator_speed_id !=""){
				$.post("elevatorStandard/findStoreyBySpeedId.do",{elevator_speed_id:elevator_speed_id,elevator_standard_id:elevator_standard_id},function(result){
					var elevatorStoreyList = eval(result.elevatorStoreyList);
					var elevatorStandardList = eval(result.elevatorStandardList);
					$("#elevator_storey_id").append('<option value="">请选择</option>');
					for(var i=0;i<elevatorStoreyList.length;i++){
						$("#elevator_storey_id").append('<option value="'+elevatorStoreyList[i].elevator_storey_id+'">'+elevatorStoreyList[i].elevator_storey_name+'</option>');
						for(var j=0;j<elevatorStandardList.length;j++){
							if(elevatorStoreyList[i].elevator_storey_id == elevatorStandardList[j].elevator_storey_id){
								$("#elevator_storey_id").find("option[value='"+elevatorStoreyList[i].elevator_storey_id+"']").attr("selected",true);
								break;
							}
						}
					}
					
				});
			}else{
				$("#elevator_storey_id").append('<option value="">请先选择电梯速度参数</option>');
			}
		}
		
		
		
		 
		
		
	
		
		
		
		
		
		
		
		
		
		
		
	</script>
</html>
