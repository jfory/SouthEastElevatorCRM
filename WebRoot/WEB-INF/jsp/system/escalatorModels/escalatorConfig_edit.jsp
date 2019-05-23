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
<form action="escalatorModels/${msg}.do" name="modelsForm" id="modelsForm" method="post">
	<div id="ViewElevatorBase" class="animated fadeIn"></div>
	<input type="hidden" name="id" id="id" value="${pd.ID}" />
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
                                        	型号详情
                                    </div>
                                    <div class="panel-body" >
                                        
                                        <div class="form-group form-inline">
	                                    	
											
											<span style="color: red">*</span>
											<label style="width: 6%">楼梯类型:</label>
											<select style="width: 25%" class="form-control" id="elevator_id" name="elevator_id" onchange="elevatorOptionalListByElevatorId();">
												<option value="4">扶梯</option>
											</select>
											
											<span style="color: red">*</span>
											<label style="width: 6%">产品线:</label>
											<select style="width: 25%" class="form-control" id="product_id" name="product_id" >
												<option value="">请选择</option>
												<c:forEach items="${productList }" var="product">
													<option value="${product.product_id }" ${product.product_id eq pd.PRODUCT_ID ? 'selected':'' } >${product.product_name }</option>
												</c:forEach>
											</select>
											
											<span style="color: red">*</span>
											<label style="width:6%" >型号名称:</label>
                                    		<input style="width:25%"  type="text"  placeholder="型号名称"  id="name" name="name" value="${pd.NAME }"  class="form-control">
                                    			
                                    		
                                        		 	
                                    	</div>
                                        
                                        
                                   		
                                   		<div class="form-group">
                                   			<span>&nbsp;&nbsp;</span>
                                        	<label style="width:6%">型号描述:</label>
                                        	<textarea class="form-control" rows="10" cols="20" name="remark" id="remark" placeholder="这里输入备注" maxlength="250" title="备注" >${pd.REMARK}</textarea>
                                   	   </div>
                                   	   
                                   </div>
                                </div>
							  
							  	<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	扶梯标准信息
                                    </div>
                                    <div class="panel-body" >
                                        <div class="form-group form-inline">
											<span style="color: red">*</span>
											<label style="width: 6%">型号:</label>
											<select style="width: 25%" class="form-control" id="elevator_speed_id" name="elevator_speed_id" onchange="countEscalatorStandardPrice()">
												<option value="">请选择</option>
												<option value="1" ${stdPd.escalator_model_id eq 1 ? "selected":"" }>30°</option>
												<option value="2" ${stdPd.escalator_model_id eq 2 ? "selected":"" }>35°</option>
											</select>
											<span style="color: red">*</span>
											<label style="width: 6%">规格:</label>
											<select style="width: 25%" class="form-control" id="elevator_weight_id" name="elevator_weight_id" onchange="countEscalatorStandardPrice()">
												<option value="">请选择</option>
												<option value="1" ${stdPd.escalator_standard_id eq 1 ? "selected":"" }>3.0</option>
												<option value="2" ${stdPd.escalator_standard_id eq 2 ? "selected":"" }>3.1</option>
												<option value="3" ${stdPd.escalator_standard_id eq 3 ? "selected":"" }>3.2</option>
												<option value="4" ${stdPd.escalator_standard_id eq 4 ? "selected":"" }>3.3</option>
												<option value="5" ${stdPd.escalator_standard_id eq 5 ? "selected":"" }>3.4</option>
												<option value="6" ${stdPd.escalator_standard_id eq 6 ? "selected":"" }>3.5</option>
												<option value="7" ${stdPd.escalator_standard_id eq 7 ? "selected":"" }>3.6</option>
												<option value="8" ${stdPd.escalator_standard_id eq 8 ? "selected":"" }>3.7</option>
												<option value="9" ${stdPd.escalator_standard_id eq 9 ? "selected":"" }>3.8</option>
												<option value="10" ${stdPd.escalator_standard_id eq 10 ? "selected":"" }>3.9</option>
												
												<option value="11" ${stdPd.escalator_standard_id eq 11 ? "selected":"" }>4.0</option>
												<option value="12" ${stdPd.escalator_standard_id eq 12 ? "selected":"" }>4.1</option>
												<option value="13" ${stdPd.escalator_standard_id eq 13 ? "selected":"" }>4.2</option>
												<option value="14" ${stdPd.escalator_standard_id eq 14 ? "selected":"" }>4.3</option>
												<option value="15" ${stdPd.escalator_standard_id eq 15 ? "selected":"" }>4.4</option>
												<option value="16" ${stdPd.escalator_standard_id eq 16 ? "selected":"" }>4.5</option>
												<option value="17" ${stdPd.escalator_standard_id eq 17 ? "selected":"" }>4.6</option>
												<option value="18" ${stdPd.escalator_standard_id eq 18 ? "selected":"" }>4.7</option>
												<option value="19" ${stdPd.escalator_standard_id eq 19 ? "selected":"" }>4.8</option>
												<option value="20" ${stdPd.escalator_standard_id eq 20 ? "selected":"" }>4.9</option>
												
												<option value="21" ${stdPd.escalator_standard_id eq 21 ? "selected":"" }>5.0</option>
												<option value="22" ${stdPd.escalator_standard_id eq 22 ? "selected":"" }>5.1</option>
												<option value="23" ${stdPd.escalator_standard_id eq 23 ? "selected":"" }>5.2</option>
												<option value="24" ${stdPd.escalator_standard_id eq 24 ? "selected":"" }>5.3</option>
												<option value="25" ${stdPd.escalator_standard_id eq 25 ? "selected":"" }>5.4</option>
												<option value="26" ${stdPd.escalator_standard_id eq 26 ? "selected":"" }>5.5</option>
												<option value="27" ${stdPd.escalator_standard_id eq 27 ? "selected":"" }>5.6</option>
												<option value="28" ${stdPd.escalator_standard_id eq 28 ? "selected":"" }>5.7</option>
												<option value="29" ${stdPd.escalator_standard_id eq 29 ? "selected":"" }>5.8</option>
												<option value="30" ${stdPd.escalator_standard_id eq 30 ? "selected":"" }>5.9</option>
												
												<option value="31" ${stdPd.escalator_standard_id eq 31 ? "selected":"" }>6.0</option>
												<option value="32" ${stdPd.escalator_standard_id eq 32 ? "selected":"" }>6.1</option>
												<option value="33" ${stdPd.escalator_standard_id eq 33 ? "selected":"" }>6.2</option>
												<option value="34" ${stdPd.escalator_standard_id eq 34 ? "selected":"" }>6.3</option>
												<option value="35" ${stdPd.escalator_standard_id eq 35 ? "selected":"" }>6.4</option>
												<option value="36" ${stdPd.escalator_standard_id eq 36 ? "selected":"" }>6.5</option>
												<option value="37" ${stdPd.escalator_standard_id eq 37 ? "selected":"" }>6.6</option>
												<option value="38" ${stdPd.escalator_standard_id eq 38 ? "selected":"" }>6.7</option>
												<option value="39" ${stdPd.escalator_standard_id eq 39 ? "selected":"" }>6.8</option>
												<option value="40" ${stdPd.escalator_standard_id eq 40 ? "selected":"" }>6.9</option>
												
												<option value="41" ${stdPd.escalator_standard_id eq 41 ? "selected":"" }>7.0</option>
												<option value="42" ${stdPd.escalator_standard_id eq 42 ? "selected":"" }>7.1</option>
												<option value="43" ${stdPd.escalator_standard_id eq 43 ? "selected":"" }>7.2</option>
												<option value="44" ${stdPd.escalator_standard_id eq 44 ? "selected":"" }>7.3</option>
												<option value="45" ${stdPd.escalator_standard_id eq 45 ? "selected":"" }>7.4</option>
												<option value="46" ${stdPd.escalator_standard_id eq 46 ? "selected":"" }>7.5</option>
											</select>
                                        	<span style="color: red">*</span>
											<label style="width: 6%">宽度:</label>
											<select style="width: 25%" class="form-control" id="elevator_storey_id" name="elevator_storey_id" onchange="countEscalatorStandardPrice()">
												<option value="">请选择</option>
												<option value="1" ${stdPd.escalator_width_id eq 1 ? "selected":"" }>1000MM</option>
												<option value="2" ${stdPd.escalator_width_id eq 2 ? "selected":"" }>800MM</option>
												<option value="3" ${stdPd.escalator_width_id eq 3 ? "selected":"" }>600MM</option>
											</select>
                                    	</div>
                                        <div class="form-group form-inline">
                                    		<span style="color: red">*</span>
											<label style="width:6%" >标准价格:</label>
                                    		<input style="width:25%"  type="text"  placeholder="价格"  id="elevator_standard_price" name="elevator_standard_price" value="${stdPd.escalator_standard_price }"  class="form-control">
                                    		
                                        </div>
                                   </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                        <c:if test="${msg eq 'escalatorModelsAdd'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddModels');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'modelsEdit'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditModels');">关闭</a></td>
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
	
		//计算家用电梯标准价格
		function countEscalatorStandardPrice(){
			var elevator_speed_id = $("#elevator_speed_id").val();
			var elevator_weight_id = $("#elevator_weight_id").val();
			var elevator_storey_id = $("#elevator_storey_id").val();
			
			$.post("escalatorModels/countEscalatorStandardPrice.do",{escalator_model_id:elevator_speed_id,escalator_standard_id:elevator_weight_id,escalator_width_id:elevator_storey_id},function(result){
				if(result.success){
					$("#elevator_standard_price").val(result.elevator_standard_price);
					countsPrice();
				}else{
					$("#elevator_standard_price").val("");
				}
			});
			
		}
	
		//保存
		function save(){
			$("#modelsForm").submit();
		}
		
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		}
		
	</script>
</html>
