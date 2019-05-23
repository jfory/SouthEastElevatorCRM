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
<form action="elevatorConfig/${msg}.do" name="optionalInfoForm" id="optionalInfoForm" method="post">
	<%-- <!-- 可选项Id -->
	<input type="text" name="elevator_optional_id" id="elevator_optional_id" value="${pd.elevator_optional_id}" /> --%>
	<%--主键--%>
	<input type="hidden" name="optional_info_id" id="optional_info_id" value="${pd.optional_info_id}"/>
	
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
                                        	
                                    </div>
                                    <div class="panel-body"  >
                                    	<div class="form-group form-inline" id="info">
                                   
                                    	</div>
                                    	
                                    	<div class="form-group form-inline" >
                                    		
                                    		 <table class="table table-striped table-bordered table-hover"  id="addCheckbox">
                                    	
												 <thead>
												 	
				                                    <tr>
				                                        <th style="width:20%;">名称</th>
				                                        <th style="width:10%">电梯重量(KG)</th>
				                                        <th style="width:10%;">单位</th>
				                                        <th style="width:10%;">金额</th>
				                                        <th style="width:20%;">交货期</th>
				                                        <th style="width:20%;">操作</th>
				                                    </tr>
				                                    
				                                    <tr>
				                                    	<td><input type="text"></td>
				                                    	<td>
				                                    		<select>
				                                    			<option value="">请选择</option>
				                                    			<c:forEach items="${elevatorWeightList }" var="elevatorWeight">
				                                    				<option value="${elevatorWeight.elevator_weight_id} ">${elevatorWeight.elevator_weight_name}</option>
				                                    			</c:forEach>
				                                    		</select>
				                                    	</td>
				                                    	<td>
				                                    		<select>
				                                    			<option value="">请选择</option>
				                                    			<c:forEach items="${elevatorUnitList }" var="elevatorUnit">
				                                    				<option value="${elevatorUnit.elevator_unit_id} ">${elevatorUnit.elevator_unit_name}</option>
				                                    			</c:forEach>
				                                    		</select>
				                                    	</td>
				                                    	<td><input type="text"></td>
				                                    	<td><input type="text"></td>
				                                    	<td><button class="btn  btn-primary btn-sm" title="新增" type="button"onclick="addRows();">新增</button></td>
				                                    </tr>
				                                    
			                               	 	</thead>
													
											</table>
                                    		
                                    	</div>
                                   </div>
                                </div>
                            	
                            
                                
                                
                                    
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	功能详情  &nbsp;&nbsp;&nbsp;<!--  <span style="color: red">总金额=功能单价*电梯数量</span>  -->
                                    </div>
                                    <div class="panel-body" >
                                    	
                                        
                                        <div class="form-group form-inline">
	                                    	<span style="color: red">*</span>
											<label style="width: 6%">功能格式:</label>
											<select style="width: 25%" class="form-control" id="optional_info_status" name="optional_info_status"  onchange="test();" >
	                                    		<option value="">请选择</option>
	                                    		<option value="1" ${pd.optional_info_status eq 1 ? 'selected':''}>名称</option>
	                                    		<option value="2" ${pd.optional_info_status eq 2 ? 'selected':''}>名称/单选</option>
	                                    		<option value="3" ${pd.optional_info_status eq 3 ? 'selected':''}>多条件</option>
	                                    	</select>
	                                    	
	                                    	
											
                                        	
                                    			
                                   		
                                        		 	
                                    	</div>
                                    	
                                    	<div class="form-group form-inline" id="c3">
                                    	
                                    		<span style="color: red">*</span>
											<label style="width: 6%">单位:</label>
											<select style="width: 25%" class="form-control" id="elevator_unit_id" name="elevator_unit_id"  >
	                                    		<option value="">请选择</option>
	                                    		<c:forEach items="${elevatorUnitList }" var="elevatorUnit">
	                                    			<option value="${elevatorUnit.elevator_unit_id }" ${elevatorUnit.elevator_unit_id eq pd.elevator_unit_id ?'selected':''}>${elevatorUnit.elevator_unit_name }</option>
	                                    		</c:forEach>
	                                    	</select>
	                                    	
                                    		<span style="color: red">*</span>
                                    		<label style="width:6%">价格:</label>
                                       		<input style="width:25%" type="text"  placeholder="价格"  id="optional_info_price" name="optional_info_price" value="${pd.optional_info_price }" class="form-control">
                                       		
                                       		<span style="color: red">*</span>
                                    		<label style="width:6%">交货期:</label>
                                       		<input style="width:25%" type="text"  placeholder="交货期"  id="optional_info_delivery" name="optional_info_delivery" value="${pd.optional_info_delivery }" class="form-control">
                                    	</div>
                                        
                                        
                                        
                                   		
                                   		<div class="form-group">
                                   			<span>&nbsp;&nbsp;</span>
                                        	<label style="width:6%">备注:</label>
                                        	<textarea class="form-control" rows="10" cols="20" name="optional_info_remark" id="optional_info_remark" placeholder="这里输入备注" maxlength="250" title="备注" >${pd.optional_info_remark}</textarea>
                                        	
                                        	<input type="text" id="optional_info_jsonstr" name="optional_info_jsonstr" value="${pd.optional_info_jsonstr}">
                                   	   </div>
                                   	  
                                   </div>
                                </div>    
                               
                            
                            </div>
                            
                        </div>
                        
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                        <c:if test="${msg eq 'addOptionalInfo'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddOptionalInfo');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'editOptionalInfo'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditOptionalInfo');">关闭</a></td>
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
		var jsonStr = $("#optional_info_jsonstr").val();
		if(jsonStr!=null && jsonStr!=""){
			loadJsonStr(jsonStr);
		}
		
		$("#addCheckbox").hide();
		
		var str = $("input:checkbox:checked").map(function(index,elem){
			return $(elem).val();
		}).get().join(',');
		
		$("#product_id").val(str);
		loadProduct();
		test();
		
	});
	
	
	
		//保存
		function save(){
			
			var optional_info_status = $("#optional_info_status").val();
			
			if($("#models_id").val()==""){
				$("#models_id").focus();
				$("#models_id").tips({
					side:3,
		            msg:'请选择型号',
		            bg:'#AE81FF',
		            time:2
		        });
				
				return false;
			}
			
			if($("#models_price").val()==""){
				$("#models_price").focus();
				$("#models_price").tips({
					side:3,
		            msg:'请选择功能',
		            bg:'#AE81FF',
		            time:2
		        });
				
				return false;
			}
			
			if(optional_info_status == 3){
				var jsonStr = "[";
				$("#addCheckbox tr:not(:first)").each(function(){
					jsonStr += "{";
					var optional_info_name = $(this).find("td").eq(0).find("input").eq(0).val();
					var elevator_weight_id = $(this).find("td").eq(1).find("select").eq(0).val();
					var elevator_unit_id = $(this).find("td").eq(2).find("select").eq(0).val();
					var optional_info_price = $(this).find("td").eq(3).find("input").eq(0).val();
					var optional_info_delivery = $(this).find("td").eq(4).find("input").eq(0).val();
					jsonStr += "'optional_info_name':'"+optional_info_name+"',"
					jsonStr += "'elevator_weight_id':'"+elevator_weight_id+"',"
					jsonStr += "'elevator_unit_id':'"+elevator_unit_id+"',"
					jsonStr += "'optional_info_price':'"+optional_info_price+"',"
					jsonStr += "'optional_info_delivery':'"+optional_info_delivery+"'"
					jsonStr += "},"
				});
				jsonStr = jsonStr.substring(0,jsonStr.length-1);
				jsonStr += "]";
				
				$("#optional_info_jsonstr").val(jsonStr);
			}
		
		/* 	$.post("offer/functionEnit.do",{id:id,models_price:models_price,product_id:product_id,models_id:models_id},function(result){
				if(result.success){
					CloseSUWin("SetFunction");
					alert("保存成功");
					window.parent.frames.addItemName();
					window.parent.frames.countProjectPrice(item_id);
				}
			}); */
			
			
			
			
			$("#optionalInfoForm").submit();
			
			
			//window.opener.location.reload()；
		}
		
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		}
		
		
		
		
		//加载产品
		function loadProduct(){
			var str = "";
			var models_id = $("#models_id").val();
			var elevator_id = $("#elevator_id").val();
			var id = $("#id").val();
			if(models_id !=null && models_id != ""){
				$.post("offer/loadProduct.do",{elevator_id:elevator_id,models_id:models_id},function(result){
					var product = eval(result.productList);
					var productInfo = eval(result.productInfoList);
					var models_price = result.models_price;
					
					$("#ba").html("");
					$("#op").html("");
					$("#nop").html("");
					for(var i=0;i<product.length;i++){
						//基本项
						if(product[i].product_type == 1){
							$("#ba").append(
									
									'<span>&nbsp;&nbsp;&nbsp;</span>'+
		                			'<label>'+product[i].product_name+'</label>'+
		                			'<span>&nbsp;</span>'+
		                			'<label>'+product[i].product_price+'</label>￥'+
		                			'<input type="checkbox" name="baseProduct"  value=\"'+product[i].product_id+'\"  onclick="countPrice()">'
									);
							
							if(productInfo!=null){
								for(var j=0;j<productInfo.length;j++){   
									if(product[i].product_id == productInfo[j].product_id){
										$("input[name='baseProduct']").attr("checked",true);
										str += product[i].product_id +",";
										break;
									}
								}
							}
						}
						//选配项
						if(product[i].product_type == 2){
							$("#op").append(
									
									'<span>&nbsp;&nbsp;&nbsp;</span>'+
		                			'<label>'+product[i].product_name+'</label>'+
		                			'<span>&nbsp;</span>'+
		                			'<label>'+product[i].product_price+'</label>￥'+
		                			'<input type="checkbox" name="optional"  value=\"'+product[i].product_id+'\"  onclick="countPrice()">'
									);
							if(productInfo!=null){
								for(var j=0;j<productInfo.length;j++){
									if(product[i].product_id == productInfo[j].product_id){
										$("input[name='optional']").attr("checked",true);
										str += product[i].product_id +",";
										break;
									}
								}
							}
						}
						//非标项
						if(product[i].product_type == 3){
							$("#nop").append(
									
									'<span>&nbsp;&nbsp;&nbsp;</span>'+
		                			'<label>'+product[i].product_name+'</label>'+
		                			'<span>&nbsp;</span>'+
		                			'<label>'+product[i].product_price+'</label>'+
		                			'<input type="checkbox" name="notOptional"  value=\"'+product[i].product_id+'\"  onclick="countPrice()">'
									);
							if(productInfo!=null){
								for(var j=0;j<productInfo.length;j++){
									if(product[i].product_id == productInfo[j].product_id){
										$("input[name='notOptional']").attr("checked",true);
										str += product[i].product_id +",";
										break;
									}
								}
							}
						}
					}
					//封装产品ID
					if(str!=null){
						if(str.indexOf(",",str.length-1)>-1){
							str = str.substring(0,str.length-1);
						}else{
							str = str.substring(0,str.length);
						}
					}else{
						str="";
					}
					$("#product_id").val(str);
					$("#models_price").val(models_price);
				});
				
				
			}else{
				$("#ba").html("");
				$("#op").html("");
				$("#nop").html("");
				$("#models_price").val("");
				$("#product_id").val("");
			}
		}
		
		//点击功能计算电梯价钱
		function countPrice(){
			
			var str="";
			var id = $("#id").val();
			str = $("input:checkbox:checked").map(function(index,elem){
				return $(elem).val();
			}).get().join(',');
			
			
			
			if(str!=null && str!=''){
				$("#product_id").val(str);
				$.post("offer/offerCountTotalPrice",{str:str,id:id},function(result){
					if(result.success){
						$("#models_price").val(result.countPrice);
						
					}
				});
			}else{
				$("#models_price").val("");
				$("#product_id").val("");
			}
		}
		
		
		
		 
		
		function test(){
			var optional_info_status = $("#optional_info_status option:selected").val();
			var optional_info_id = $("#optional_info_id").val();
			$("#c3").show();
			$("#addCheckbox").hide();
			$("#info").empty();
			$.post("elevatorConfig/load.do",{optional_info_status:optional_info_status,optional_info_id:optional_info_id},function(result){
				var elevatorWeightList  = eval(result.elevatorWeightList);
				
				if(optional_info_status == 1){
				
			 	$("#info").append(
								  '<span style="color: red">*</span>'+
		        				  '<label style="width:6%">功能名称:</label>'+
		           				  '<input style="width:25%" type="text"  placeholder="功能名称"  id="optional_info_name" name="optional_info_name" value="'+result.optional_info_name+'" class="form-control">'
		           				  
								 );  
				}else if(optional_info_status == 2){
					$("#info").append(
									  '<span style="color: red">*</span>'+
		            				  '<label style="width:6%">功能名称:</label>'+
		               				  '<input style="width:25%" type="text"  placeholder="功能名称"  id="optional_info_name" name="optional_info_name" value="'+result.optional_info_name+'" class="form-control">'+
		            				  '&nbsp;&nbsp;&nbsp;'+
									  '<span style="color: red">*</span>'+
							 		  '<label style="width: 6%">电梯重量:</label>'+
							 		  '<select style="width: 25%" class="form-control" id="elevator_weight_id" name="elevator_weight_id" >'+
							 		  '<option value="">请选择型号</option>'+
							 		  '</select>'
               						);
					for(var i=0;i<elevatorWeightList.length;i++){
						$("#elevator_weight_id").append(
		                     		'<option value="'+elevatorWeightList[i].elevator_weight_id+'">'+elevatorWeightList[i].elevator_weight_name+'</option>'
		                     	);
						if(result.elevator_weight_id == elevatorWeightList[i].elevator_weight_id){
							$("#elevator_weight_id").find("option[value='"+elevatorWeightList[i].elevator_weight_id+"']").attr("selected",true); 
							
						}
					}
				}else if(optional_info_status == 3){
					
					
					$("#addCheckbox").show();
					$("#c3").hide();
				}
			});
			
		}
	
		
		
		
		//table 添加行
		function addRows(){
			var tr = $("#addCheckbox").find("tr").eq(1).clone();
			$(tr).find("td").eq(0).find("input").eq(0).val("");
			$(tr).find("td").eq(3).find("input").eq(0).val("");
			$(tr).find("td").eq(4).find("input").eq(0).val("");
			$(tr).find("td:last").html("").append(
													'<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delRows(this);">删除</button>'
													);
				$("#addCheckbox").append(tr);
				
		}
		
		//table 删除行
		function delRows(obj){
			$(obj).parent().parent().remove();
		}
		
		
		function loadJsonStr(jsonStr){
			var jsonStrList = eval('('+jsonStr+')');
			for(var i=0;i<jsonStrList.length-1;i++){
				addRows();
				
			}
			for(var i=0;i<jsonStrList.length;i++){
				$("#addCheckbox").find("tr:not(:first)").eq(i).each(function(){
					$(this).find("td").eq(0).find("input").eq(0).val(jsonStrList[i].optional_info_name);
					$(this).find("td").eq(1).find("select").eq(0).val(jsonStrList[i].elevator_weight_id);
					$(this).find("td").eq(2).find("select").eq(0).val(jsonStrList[i].elevator_unit_id);
					$(this).find("td").eq(3).find("input").eq(0).val(jsonStrList[i].optional_info_price);
					$(this).find("td").eq(4).find("input").eq(0).val(jsonStrList[i].optional_info_delivery);
				});
			}
		}
		
		
		
		
		
	</script>
</html>
