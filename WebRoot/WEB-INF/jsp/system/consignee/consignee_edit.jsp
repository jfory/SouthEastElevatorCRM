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
    <link type="text/css" rel="stylesheet" href="static/css/bootstrap-table/bootstrap-table.min.css"/>
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	<script type="text/javascript"
		src="static/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript"
		src="static/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
	
</head>

<body class="gray-bg" >
<form action="consignee/${msg}.do" name="consigneeForm" id="consigneeForm" method="post">
	
	<input type="hidden" name="item_id" id="item_id" value="${pd.item_id}" />
	<input type="hidden" name="consignee_id" id="consignee_id" value="${pd.consignee_id}" />
	<%--用户ID--%>
	
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
							  
								<div class="col-sm-12">
                                    <div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                      	出货单信息
			                                    </div>
                                    			<div class="panel-body">        
			                                        <div class="form-group form-inline">                                
	                                    				<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>出货单编号:</label>
				                                        <input style="width:22%" placeholder="这里输入出货单编号"  type="text" name="consignee_no" id="consignee_no" value="${pd.consignee_no }"  title="出货单编号" class="form-control" >
				                                        
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>收货人姓名:</label>
				                                        <input style="width:22%" placeholder="这里输入收货人姓名"  type="text" name="consignee_name" id="consignee_name" value="${pd.consignee_name }"  title="收货人姓名" class="form-control" >
				                                        
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>收货人地址:</label>
				                                        <input style="width:22%" placeholder="这里输入收货人地址"  type="text" name="consignee_address" id="consignee_address" value="${pd.consignee_address }"  title="收货人地址" class="form-control" >
				                                        
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>联系方式:</label>
				                                        <input style="width:22%" placeholder="这里输入收货人地址"  type="text" name="consignee_contact" id="consignee_contact" value="${pd.consignee_contact }"  title="联系方式" class="form-control" >
				                                        
				                                    	<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>类型:</label>
				                                    	<select style="width:22%" name="consignee_type" id="consignee_type"  class="form-control m-b" >
				                                    		<option value="">请选择</option>
				                                    		<option value="1" ${pd.consignee_type=='1'?'selected':''}>正常</option>
				                                    		<option value="2" ${pd.consignee_type=='2'?'selected':''}>补发</option>
				                                    	</select>
				                                    	
				                                    	<input type="hidden" id="elevator_id" name="elevator_id" value="${pd.elevator_id }">
				                                    </div>
			                                        
		                                    	</div>
		                                	</div>
		                                	
		                                	
		                                	
		                                	<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                      	电梯详情信息
			                                    </div>
                                    			<div class="panel-body">        
			                                        <div class="form-group form-inline">                                
	                                    				
	                                    				
	                                    				
	                                    				
	                            <table class="table table-striped table-bordered table-hover" >
	                                <thead>
	                                    <tr>
	                                        <th style="width:2%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
	                                        <th style="width:98%;">电梯工号</th>
	                                                                       
	                                        
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty elevatorDetailsList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${elevatorDetailsList}" var="var" >
													<tr>
														<td><input type="checkbox" class="i-checks" name='ids' id='${var.id}' value='${var.id}'
														
														<c:forEach items='${elevatorIds}' var='elevatorId' >
															<c:if test="${var.id eq elevatorId}">checked</c:if>
														</c:forEach> 
														 ></td>
														<td>${var.no}</td>
														
														
													</tr>
												</c:forEach>
											</c:if>
											<c:if test="${QX.cha == 0 }">
												<tr>
													<td colspan="100" class="center">您无权查看</td>
												</tr>
											</c:if>
										</c:when>
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center" >没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
                                </tbody>
	                            </table>
								
								
				                                    	
				                                    	
				                                    </div>
			                                        
		                                    	</div>
		                                	</div>
		                            	</div>
                                    </div>
                                    
                               
                                
                            </div>
                            
                        </div>
                        
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                        <c:if test="${msg eq 'addConsignee'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddConsignee');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'editConsignee'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditConsignee');">关闭</a></td>
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
		<!-- Sweet alert -->
    <script src="static/js/sweetalert2/sweetalert2.js"></script>
    <script src="static/js/iCheck/icheck.min.js"></script>
	<script type="text/javascript">
	
	//初始化电梯信息
	$(document).ready(function(){
		$('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });
		
		
	});
	
	 /* checkbox全选 */
    $("#zcheckbox").on('ifChecked', function(event){
    	$('input').iCheck('check');
  	});
    /* checkbox取消全选 */
    $("#zcheckbox").on('ifUnchecked', function(event){
    	
    	$('input').iCheck('uncheck');
  	});
	
	
		//保存
		function save(){
			
			if($("#consignee_no").val()==""){
				$("#consignee_no").focus();
				$("#consignee_no").tips({
					side:3,
		            msg:'请填写出货单编号',
		            bg:'#AE81FF',
		            time:2
		        });
				
				return false;
			}
			
			if($("#consignee_name").val()==""){
				$("#consignee_name").focus();
				$("#consignee_name").tips({
					side:3,
		            msg:'请填写收货人名称',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			if($("#consignee_address").val()==""){
				$("#consignee_address").focus();
				$("#consignee_address").tips({
					side:3,
		            msg:'请填写收货人地址',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			if($("#consignee_contact").val()==""){
				$("#consignee_contact").focus();
				$("#consignee_contact").tips({
					side:3,
		            msg:'请填写联系方式',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			if($("#consignee_type").val()==""){
				$("#consignee_type").focus();
				$("#consignee_type").tips({
					side:3,
		            msg:'请选择类型',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			
			var str = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++){
			  if(document.getElementsByName('ids')[i].checked){
			  	if(str=='') str += document.getElementsByName('ids')[i].value;
			  	else str += ',' + document.getElementsByName('ids')[i].value;
			  }
			  $("#elevator_id").val(str);
			}
			if(str==''){
				swal({
	                title: "您未选择任何数据",
	                text: "请选择你需要操作的数据！",
	                type: "error",
	                showCancelButton: false,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "OK",
	                closeOnConfirm: true,
	                timer:1500
	            });
				return false;
			}
			
			
			
			$("#consigneeForm").submit();
		}
		
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		}
		
		
		
		
		
		 
		
		
		
		
		
	
		
		
		
		
		
		//刷新iframe
        function refreshCurrentTab() {
      	/* 	alert("refresh");
      		alert("src=>"+window.location); */
        	window.location.reload();
        }
		
		
	</script>
</html>
