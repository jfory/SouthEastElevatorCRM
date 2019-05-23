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
<form action="homeElevatorStandard/${msg}.do" name="homeElevatorStandardForm" id="homeElevatorStandardForm" method="post">
	<input type="hidden" name="home_standard_id" id="home_standard_id" value="${pd.home_standard_id}" />
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
                                        	家用电梯标准价格详情
                                    </div>
                                    <div class="panel-body" >
                                        
                                        <div class="form-group form-inline">
	                                    	
											
											<span style="color: red">*</span>
											<label style="width: 10%">电梯速度(m/s):</label>
											<select style="width: 18%" class="form-control" id="home_speed_id" name="home_speed_id" onchange="findStoreyBySpeedId()">
												<option value="">请选择</option>
												<option value="1" ${pd.home_speed_id eq 1 ? "selected":"" }>0.5-1.0</option>
											</select>
											
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">电梯重量(KG):</label>
											<select style="width: 18%" class="form-control" id="home_weight_id" name="home_weight_id">
												<option value="">请选择</option>
												<option value="1" ${pd.home_weight_id eq 1 ? "selected":"" }>320</option>
												<option value="2" ${pd.home_weight_id eq 2 ? "selected":"" }>400</option>
												<option value="3" ${pd.home_weight_id eq 3 ? "selected":"" }>450</option>
											</select>
											
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">层站门:</label>
											<select style="width: 18%" class="form-control" id="home_storey_id" name="home_storey_id">
												<option value="">请选择</option>
												<option value="1" ${pd.home_storey_id eq 1 ? "selected":"" }>2/2/2</option>
												<option value="2" ${pd.home_storey_id eq 2 ? "selected":"" }>3/3/3</option>
												<option value="3" ${pd.home_storey_id eq 3 ? "selected":"" }>4/4/4</option>
												<option value="4" ${pd.home_storey_id eq 4 ? "selected":"" }>5/5/5</option>
												<option value="5" ${pd.home_storey_id eq 5 ? "selected":"" }>6/6/6</option>
											</select>
                                    	</div>
                                        
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
											<label style="width:10%" >名称:</label>
                                    		<input style="width:18%"  type="text"  placeholder="名称"  id="home_standard_name" name="home_standard_name" value="${pd.home_standard_name }"  class="form-control">
                                    			
                                    		&nbsp;&nbsp;&nbsp;
                                        	<span style="color: red">*</span>
                                    			
                                   			<label style="width:10%">电梯标准金额:</label>
                                       		<input style="width:18%" type="text" placeholder="这里输入电梯标准金额"  id="home_standard_price" name="home_standard_price" value="${pd.home_standard_price }" class="form-control">
                                        		 	
                                        </div>
                                        
                                   		
                                   		<div class="form-group">
                                   			<span>&nbsp;&nbsp;</span>
                                        	<label style="width:6%">描述:</label>
                                        	<textarea class="form-control" rows="10" cols="20" name="home_standard_description" id="home_standard_description" placeholder="这里输入描述" maxlength="250" title="备注" >${pd.home_standard_description}</textarea>
                                   	   </div>
                                   	   
                                   </div>
                                </div>
                            	
                                    
                                    
                               
                            
                            </div>
                            
                        </div>
                        
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                        <c:if test="${msg eq 'addHomeElevatorStandard'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddHomeElevatorStandard');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'editHomeElevatorStandard'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditHomeElevatorStandard');">关闭</a></td>
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
		
	});
	
	
	
		//保存
		function save(){
			if($("#home_speed_id").val()==""){
				$("#home_speed_id").focus();
				$("#home_speed_id").tips({
					side:3,
		            msg:'请选择电梯速度',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			if($("#home_weight_id").val()==""){
				$("#home_weight_id").focus();
				$("#home_weight_id").tips({
					side:3,
		            msg:'请选择电梯重量',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			if($("#home_storey_id").val()==""){
				$("#home_storey_id").focus();
				$("#home_storey_id").tips({
					side:3,
		            msg:'请选择电梯楼层',
		            bg:'#AE81FF',
		            time:2
		        });
				
				return false;
			}
			
			if($("#home_standard_name").val()==""){
				$("#home_standard_name").focus();
				$("#home_standard_name").tips({
					side:3,
		            msg:'请填写名称',
		            bg:'#AE81FF',
		            time:2
		        });
				
				
				return false;
			}
			
			if($("#home_standard_price").val()==""){
				$("#home_standard_price").focus();
				$("#home_standard_price").tips({
					side:3,
		            msg:'请填写电梯标准金额',
		            bg:'#AE81FF',
		            time:2
		        });
				
				
				return false;
			}
			
			
			
			
			
			$("#homeElevatorStandardForm").submit();
		}
		
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		}
		
		
		
		
		
		 
		
		
	
		
		
		
		
		
		
		
		
		
		
		
	</script>
</html>
