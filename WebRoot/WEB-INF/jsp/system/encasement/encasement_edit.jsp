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
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	<script type="text/javascript"
		src="static/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript"
		src="static/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
	
</head>

<body class="gray-bg" >
<form action="encasement/${msg}.do" name="encasementForm" id="encasementForm" method="post">
	<input type="hidden" name="consignee_id" id="consignee_id" value="${pd.consignee_id}">
	<input type="hidden" name="elevator_no" id="elevator_no" value="${pd.elevator_no}" />
	<input type="hidden" name="encasement_id" id="encasement_id" value="${pd.encasement_id}" />
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
			                                      	装箱信息
			                                    </div>
                                    			<div class="panel-body">        
			                                        <div class="form-group form-inline">                                
	                                    				<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>装箱编号:</label>
				                                        <input style="width:22%" placeholder="这里输入装箱编号"  type="text" name="encasement_no" id="encasement_no" value="${pd.encasement_no }"  title="装箱编号" class="form-control" >
				                                        
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>装箱人姓名:</label>
				                                        <input style="width:22%" placeholder="这里输入装箱人姓名"  type="text" name="encasement_name" id="encasement_name" value="${pd.encasement_name }"  title="装箱人姓名" class="form-control" >
				                                        
				                                       
				                                    	
				                                    	
				                                    	
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
                        <c:if test="${msg eq 'addEncasement'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddEncasement');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'editEncasement'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditEncasement');">关闭</a></td>
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
	<script type="text/javascript">
	
	//初始化电梯信息
	$(document).ready(function(){
		
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
			
			
			
			
			$("#encasementForm").submit();
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
