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
<form action="escalatorStandard/${msg}.do" name="escalatorStandardForm" id="escalatorStandardForm" method="post">
	<input type="hidden" name="id" id="id" value="${pd.id}" />
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
                                        	扶梯标准价格详情
                                    </div>
                                    <div class="panel-body" >
                                        
                                        <div class="form-group form-inline">
	                                    	
											
											<span style="color: red">*</span>
											<label style="width: 10%">型号:</label>
											<select style="width: 18%" class="form-control" id="escalator_model_id" name="escalator_model_id" >
												<option value="">请选择</option>
												<option value="1" ${pd.escalator_model_id eq 1 ? "selected":"" }>30°</option>
												<option value="2" ${pd.escalator_model_id eq 2 ? "selected":"" }>35°</option>
											</select>
											
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">规格:</label>
											<select style="width: 18%" class="form-control" id="escalator_standard_id" name="escalator_standard_id">
												<option value="">请选择</option>
												<option value="1" ${pd.escalator_standard_id eq 1 ? "selected":"" }>3.0</option>
												<option value="2" ${pd.escalator_standard_id eq 2 ? "selected":"" }>3.1</option>
												<option value="3" ${pd.escalator_standard_id eq 3 ? "selected":"" }>3.2</option>
												<option value="4" ${pd.escalator_standard_id eq 4 ? "selected":"" }>3.3</option>
												<option value="5" ${pd.escalator_standard_id eq 5 ? "selected":"" }>3.4</option>
												<option value="6" ${pd.escalator_standard_id eq 6 ? "selected":"" }>3.5</option>
												<option value="7" ${pd.escalator_standard_id eq 7 ? "selected":"" }>3.6</option>
												<option value="8" ${pd.escalator_standard_id eq 8 ? "selected":"" }>3.7</option>
												<option value="9" ${pd.escalator_standard_id eq 9 ? "selected":"" }>3.8</option>
												<option value="10" ${pd.escalator_standard_id eq 10 ? "selected":"" }>3.9</option>
												
												<option value="11" ${pd.escalator_standard_id eq 11 ? "selected":"" }>4.0</option>
												<option value="12" ${pd.escalator_standard_id eq 12 ? "selected":"" }>4.1</option>
												<option value="13" ${pd.escalator_standard_id eq 13 ? "selected":"" }>4.2</option>
												<option value="14" ${pd.escalator_standard_id eq 14 ? "selected":"" }>4.3</option>
												<option value="15" ${pd.escalator_standard_id eq 15 ? "selected":"" }>4.4</option>
												<option value="16" ${pd.escalator_standard_id eq 16 ? "selected":"" }>4.5</option>
												<option value="17" ${pd.escalator_standard_id eq 17 ? "selected":"" }>4.6</option>
												<option value="18" ${pd.escalator_standard_id eq 18 ? "selected":"" }>4.7</option>
												<option value="19" ${pd.escalator_standard_id eq 19 ? "selected":"" }>4.8</option>
												<option value="20" ${pd.escalator_standard_id eq 20 ? "selected":"" }>4.9</option>
												
												<option value="21" ${pd.escalator_standard_id eq 21 ? "selected":"" }>5.0</option>
												<option value="22" ${pd.escalator_standard_id eq 22 ? "selected":"" }>5.1</option>
												<option value="23" ${pd.escalator_standard_id eq 23 ? "selected":"" }>5.2</option>
												<option value="24" ${pd.escalator_standard_id eq 24 ? "selected":"" }>5.3</option>
												<option value="25" ${pd.escalator_standard_id eq 25 ? "selected":"" }>5.4</option>
												<option value="26" ${pd.escalator_standard_id eq 26 ? "selected":"" }>5.5</option>
												<option value="27" ${pd.escalator_standard_id eq 27 ? "selected":"" }>5.6</option>
												<option value="28" ${pd.escalator_standard_id eq 28 ? "selected":"" }>5.7</option>
												<option value="29" ${pd.escalator_standard_id eq 29 ? "selected":"" }>5.8</option>
												<option value="30" ${pd.escalator_standard_id eq 30 ? "selected":"" }>5.9</option>
												
												<option value="31" ${pd.escalator_standard_id eq 31 ? "selected":"" }>6.0</option>
												<option value="32" ${pd.escalator_standard_id eq 32 ? "selected":"" }>6.1</option>
												<option value="33" ${pd.escalator_standard_id eq 33 ? "selected":"" }>6.2</option>
												<option value="34" ${pd.escalator_standard_id eq 34 ? "selected":"" }>6.3</option>
												<option value="35" ${pd.escalator_standard_id eq 35 ? "selected":"" }>6.4</option>
												<option value="36" ${pd.escalator_standard_id eq 36 ? "selected":"" }>6.5</option>
												<option value="37" ${pd.escalator_standard_id eq 37 ? "selected":"" }>6.6</option>
												<option value="38" ${pd.escalator_standard_id eq 38 ? "selected":"" }>6.7</option>
												<option value="39" ${pd.escalator_standard_id eq 39 ? "selected":"" }>6.8</option>
												<option value="40" ${pd.escalator_standard_id eq 40 ? "selected":"" }>6.9</option>
												
												<option value="41" ${pd.escalator_standard_id eq 41 ? "selected":"" }>7.0</option>
												<option value="42" ${pd.escalator_standard_id eq 42 ? "selected":"" }>7.1</option>
												<option value="43" ${pd.escalator_standard_id eq 43 ? "selected":"" }>7.2</option>
												<option value="44" ${pd.escalator_standard_id eq 44 ? "selected":"" }>7.3</option>
												<option value="45" ${pd.escalator_standard_id eq 45 ? "selected":"" }>7.4</option>
												<option value="46" ${pd.escalator_standard_id eq 46 ? "selected":"" }>7.5</option>
												
											</select>
											
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">宽度(MM):</label>
											<select style="width: 18%" class="form-control" id="escalator_width_id" name="escalator_width_id">
												<option value="">请选择</option>
												<option value="1" ${pd.escalator_width_id eq 1 ? "selected":"" }>1000MM</option>
												<option value="2" ${pd.escalator_width_id eq 2 ? "selected":"" }>800MM</option>
												<option value="3" ${pd.escalator_width_id eq 3 ? "selected":"" }>600MM</option>
											</select>
                                    	</div>
                                        
                                        <div class="form-group form-inline">
                                        	
                                    		<span style="color: red">*</span>	
                                   			<label style="width:10%">扶梯金额:</label>
                                       		<input style="width:18%" type="text" placeholder="这里输入电梯标准金额"  id="escalator_standard_price" name="escalator_standard_price" value="${pd.escalator_standard_price }" class="form-control">
                                        		 	
                                        </div>
                                        
                                   		
                                   		<div class="form-group">
                                   			<span>&nbsp;&nbsp;</span>
                                        	<label style="width:6%">描述:</label>
                                        	<textarea class="form-control" rows="10" cols="20" name="escalator_standard_description" id="escalator_standard_description" placeholder="这里输入描述" maxlength="250" title="备注" >${pd.escalator_standard_description}</textarea>
                                   	   </div>
                                   	   
                                   </div>
                                </div>
                            	
                                    
                                    
                               
                            
                            </div>
                            
                        </div>
                        
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                        <c:if test="${msg eq 'addEscalatorStandard'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddEscalatorStandard');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'editEscalatorStandard'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditEscalatorStandard');">关闭</a></td>
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
			if($("#escalator_model_id").val()==""){
				$("#escalator_model_id").focus();
				$("#escalator_model_id").tips({
					side:3,
		            msg:'请选择扶梯型号',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			if($("#escalator_standard_id").val()==""){
				$("#escalator_standard_id").focus();
				$("#escalator_standard_id").tips({
					side:3,
		            msg:'请选择扶梯规格',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			if($("#escalator_width_id").val()==""){
				$("#escalator_width_id").focus();
				$("#escalator_width_id").tips({
					side:3,
		            msg:'请选择扶梯宽度',
		            bg:'#AE81FF',
		            time:2
		        });
				
				return false;
			}
			
			
			
			if($("#escalator_standard_price").val()==""){
				$("#escalator_standard_price").focus();
				$("#escalator_standard_price").tips({
					side:3,
		            msg:'请填写扶梯金额',
		            bg:'#AE81FF',
		            time:2
		        });
				
				
				return false;
			}
			
			
			
			
			
			$("#escalatorStandardForm").submit();
		}
		
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		}
		
		
		
		
		
		 
		
		
	
		
		
		
		
		
		
		
		
		
		
		
	</script>
</html>
