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
<form action="offer/${msg}.do" name="offerForm" id="offerForm" method="post">
	<div id="SetFunction" class="adimated fadeIn"></div>
	<div id="SetFunctions" class="adimated fadeIn"></div>
	<div id="viewHistory" class="animated fadeIn"></div>
	<input type="hidden" name="offer_id" id="offer_id" value="${pd.offer_id}" />
	<%--用户ID--%>
	<input type="hidden" name="msg" id="msg" value="${msg}"/>
	
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
			                                        项目基本信息
			                                    </div>
                                    			<div class="panel-body">        
			                                        <div class="form-group form-inline">                                
	                                    				<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>项目名称:</label>
				                                        <input style="width:22%" placeholder="这里输入项目名称" readonly="readonly" type="text" name="item_name" id="item_name" value="${pd.item_name }"  title="项目名称" class="form-control" onblur="checkItemName();">
				                                    	<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>销售类型:</label>
				                                    	<select style="width:22%" name="sale_type" id="sale_type" disabled="disabled" class="form-control m-b" onchange="setOrderOrg();">
				                                    		<option value="">请选择销售类型</option>
				                                    		<option value="1" ${pd.sale_type=='1'?'selected':''}>经销</option>
				                                    		<option value="2" ${pd.sale_type=='2'?'selected':''}>直销</option>
				                                    		<option value="3" ${pd.sale_type=='3'?'selected':''}>代销</option>
				                                    	</select>
			                                    		<c:if test="${operateType=='edit'}">
			                                    			<label style="width:10%;margin-top: 25px;margin-bottom: 10px">项目编号:</label>
				                                    		<input style="width:24%" readonly="readonly" type="text" name="item_no" id="item_no" value="${pd.item_no }"  title="项目编号" class="form-control">
			                                    		</c:if>
				                                    </div>
			                                        <div class="form-group form-inline">
	                                    				<label style="width:10%;"><span><font color="red">*</font></span>最终用户:</label>
	                                    				<select style="width:22%" name="end_user" id="end_user" disabled="disabled" onchange="setCustomerNo();" class="selectpicker" data-live-search="true">
	                                    					<option value="">请选择最终用户</option>
	                                    					<c:forEach items="${customerList}" var="var">
	                                    						<option value="${var.customer_id}_${var.customer_no}" ${pd.end_user==var.customer_id?"selected":""}>${var.customer_name}</option>
	                                    					</c:forEach>
	                                    				</select>
	                                    				<label style="width:10%;"><span><font color="red">*</font></span>客户编号:</label>
				                                        <input style="width:22%" placeholder="这里输入客户编号" type="text" name="customer_no" id="customer_no" value="${pd.customer_no }"  title="客户编号" readonly="readonly" class="form-control">
	                                        		</div>
		                                    	</div>
		                                	</div>
		                            	</div>
                                    </div>
                                    
                               	
                               
	                                    	
											
											
										
                                    		
											
								<select style="width: 25%;display: none;" class="form-control" id="item_id" name="item_id"  onchange="addItemName()">
									<option value="">请选择</option>
									<c:forEach items="${itemList }" var="item">
										<option value="${item.item_id }" <c:if test="${pd.item_id eq item.item_id }">selected</c:if>   >${item.item_name }</option>
									</c:forEach>
								</select>
								
								<input  style="width:25%" class="form-control"  type="hidden" id="item_name" name="item_name" value="${pd.item_name }">	
                                 		
                                     	
                                 			
                                   			
                                
                                
                                 <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	内容补充
                                    </div>
                                    <div class="panel-body" >
                                    	
                                        
                                        <div class="form-group form-inline">
	                                    	
											
											
											<span style="color: red">*</span>
											  <label style="width:6%">合同可能:</label>
											  			 <select style="width:25%" name="agreement_possible" id="agreement_possible" class="form-control m-b">
											  			 	<option value="">请选择合同可能</option>
				                                        	<option value="50" ${item.agreement_possible=="50"?"selected":""}>50%</option>
				                                        	<option value="60" ${item.agreement_possible=="60"?"selected":""}>60%</option>
				                                        	<option value="70" ${item.agreement_possible=="70"?"selected":""}>70%</option>
				                                        	<option value="80" ${item.agreement_possible=="80"?"selected":""}>80%</option>
				                                        	<option value="90" ${item.agreement_possible=="90"?"selected":""}>90%</option>
				                                        	<option value="100" ${item.agreement_possible=="100"?"selected":""}>100%</option>
											  			 </select>
											<span style="color: red">*</span>  			 
				                                        <label style="width:6%">市场区分:</label>
				                                        <select style="width:25%" name="market_type" id="market_type" class="form-control m-b">
				                                        	<option value="">请选择市场区分</option>
				                                        	<option value="住宅" ${item.market_type=="住宅"?"selected":""}>住宅</option>
				                                        	<option value="工厂" ${item.market_type=="工厂"?"selected":""}>工厂</option>
				                                        	<option value="医院" ${item.market_type=="医院"?"selected":""}>医院</option>
				                                        	<option value="商业" ${item.market_type=="商业"?"selected":""}>商业</option>
				                                        	<option value="政府机关" ${item.market_type=="政府机关"?"selected":""}>政府机关</option>
				                                        	<option value="别墅" ${item.market_type=="别墅"?"selected":""}>别墅</option>
				                                        	<option value="公寓" ${item.market_type=="公寓"?"selected":""}>公寓</option>
				                                        	<option value="学校" ${item.market_type=="学校"?"selected":""}>学校</option>
				                                        	<option value="公共交通" ${item.market_type=="公共交通"?"selected":""}>公共交通</option>
				                                        	<option value="酒店" ${item.market_type=="酒店"?"selected":""}>酒店</option>
				                                        	<option value="小业主" ${item.market_type=="小业主"?"selected":""}>小业主</option>
				                                        	<option value="总包方" ${item.market_type=="总包方"?"selected":""}>总包方</option>
				                                        	<option value="OEM">OEM</option>
				                                        </select>
				                                        <span style="color: red">*</span>
				                                    	<label style="width:6%;margin-top: 25px;margin-bottom: 10px">我司劣势:</label>
				                                        <select style="width:25%" name="self_inferiority" id="self_inferiority" class="form-control m-b">
				                                        	<option value="">请选择我司劣势</option>
				                                        	<option value="价格" ${item.self_inferiority=="价格"?"selected":""}>价格</option>
				                                        	<option value="品牌" ${item.self_inferiority=="品牌"?"selected":""}>品牌</option>
				                                        	<option value="关系" ${item.self_inferiority=="关系"?"selected":""}>关系</option>
				                                        	<option value="技术" ${item.self_inferiority=="技术"?"selected":""}>技术</option>
				                                        </select>
			                                    	</div>
			                                        
                                    			
                                        
                                   		
                                   </div>
                                </div> 
                               
                            	  <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	电梯详情   <!-- <span style="color: red">总价格=型号价格*电梯数量</span> -->
                                        	
                                        	<!--  <button class="btn  btn-success" title="刷新项目总价" type="button" style="float:right" onclick="refreshProjectPrice()">刷新项目总价</button>-->
                                    </div>
                                    <div class="panel-body" >
                                    	
                                        
                                        <div class="form-group form-inline">
	                                    	
											<table class="table table-striped table-bordered table-hover" id="table" ></table>
                                    	</div>
                                        
                                      
                                   </div>
                                </div>    
                                
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	价格
                                    </div>
                                    <div class="panel-body" >
                                    	
                                        
                                        <div class="form-group form-inline">
	                                    	 <span style="color: red">*</span>
		                                     <label style="width:6%">项目总额:</label>
		                                     <input style="width:25%" readonly="readonly" type="text" name="item_total" id="item_total"  value="${item.item_total}" placeholder="项目总价"  title="项目总额"   class="form-control">
                                    		
                                    	</div>
                                        
                                      
                                   </div>
                                </div>  
                                
                                
                            </div>
                            
                        </div>
                        
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                        <c:if test="${msg eq 'offerAdd'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddOffer');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'offerEdit'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditOffer');">关闭</a></td>
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
		/* var item_id = $("#item_id").val();
		$("#table").bootstrapTable({
			url:"offer/elevatorList.do?item_id="+item_id,
			pagination:true,
			pageNumber:1,
			pageSize:5,
			pageList:[10,25,50,100],
			columns:[{
				field:"elevator_name",
				title:"电梯名称"
			},{
				field:"models_name",
				title:"电梯规格"
			},{
				field:"num",
				title:"数量"
			},{
				field:"total",
				title:"总价格"
			},{
				field:"operate",
				title:"操作",
				formatter:operateFormatter
			}]
		}); */
		addItemName();
	});
	
	
	
	
	//列表嵌套按钮
	function operateFormatter(value,row,index){
		if(row.elevator_instance_id != null && row.elevator_approval == "待审核"){
			return [
				'<button class="btn  btn-warning btn-sm" title="报价设置" type="button" onclick="setFunction('+row.id+',\''+row.item_id+'\','+row.elevator_id+','+row.models_id+','+row.flag+',\''+row.models_name+'\',\''+row.product_id+'\')" >报价设置</button>&nbsp;',
				'<button class="btn  btn-primary btn-sm" title="提交" type="button" onclick="startElevator('+row.id+','+row.elevator_instance_id+');">提交</button>&nbsp',
				'<button class="btn  btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('+row.elevator_instance_id+');">审核记录</button>',
				
			
			].join("  ");
		}else if(row.elevator_instance_id != null && row.elevator_approval == "被驳回"){
			return [
				'<button class="btn  btn-warning btn-sm" title="报价设置" type="button" onclick="setFunction('+row.id+',\''+row.item_id+'\','+row.elevator_id+','+row.models_id+','+row.flag+',\''+row.models_name+'\',\''+row.product_id+'\')" >报价设置</button>&nbsp;',
				'<button class="btn  btn-primary btn-sm" title="重新申请" type="button" onclick="restartElevator('+row.task_id+ ','+row.id +');">重新申请电梯非标审核</button>&nbsp',
				'<button class="btn  btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('+row.elevator_instance_id+');">审核记录</button>',
			
			].join("  ");
		
			
		}else if(row.elevator_instance_id != null && row.elevator_approval == "审核中"){
			return [
				
				'<button class="btn  btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('+row.elevator_instance_id+');">审核记录</button>',
			
			].join("  ");
		}else if(row.elevator_instance_id != null && row.elevator_approval == "通过"){
			return [
				/* '<button class="btn  btn-primary btn-sm" title="查看" type="button" onclick="handleElevator('+row.id+',\''+row.item_id+'\','+row.elevator_id+','+row.models_id+','+row.flag+',\''+row.models_name+'\');">查看</button>', */
				'<button class="btn  btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('+row.elevator_instance_id+');">审核记录</button>',
			
			].join("  ");
		}else{
			
			return [
				'<button class="btn  btn-warning btn-sm" title="报价设置" type="button" onclick="setFunction('+row.id+',\''+row.item_id+'\','+row.elevator_id+','+row.models_id+','+row.flag+',\''+row.models_name+'\',\''+row.product_id+'\')" >报价设置</button>&nbsp;',
			].join("  ");
		}
	}
	
	//统计项目总价
	function countProjectPrice(item_id){
		$.post("offer/countProjectPrice.do",{item_id:item_id},function(result){
			if(result!=null){
				$("#item_total").val(result.item_total);
			}
		});
	}
	
	
	//跳转功能设置
	function setFunction(id,item_id,elevator_id,models_id,flag,models_name,product_id){
		if(models_id ==null || models_id =="" || typeof(models_id) == "undefined"){
			models_id = "";
		}
		
		$("#SetFunction").kendoWindow({
			width:"1200px",
			height:"700px",
			title:"型号设置",
			actions: ["Close"],
	        content: '<%=basePath%>offer/setFunction.do?id='+id+"&item_id="+item_id+"&elevator_id="+elevator_id+"&models_id="+models_id+"&flag="+flag+"&models_name="+models_name+"&product_id="+product_id,
	        modal : true,
			visible : false,
			resizable : true
		}).data("kendoWindow").maximize().open();
	}
	
	
	
	
		//保存
		function save(){
			
			if($("#offer_name").val()==""){
				$("#offer_name").focus();
				$("#offer_name").tips({
					side:3,
		            msg:'请填写报价名称',
		            bg:'#AE81FF',
		            time:2
		        });
				
				return false;
			}
			
			if($("#item_id").val()==""){
				$("#item_id").focus();
				$("#item_id").tips({
					side:3,
		            msg:'请选择项目',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			if($("#item_total").val()==""){
				$("#item_total").focus();
				$("#item_total").tips({
					side:3,
		            msg:'请先设置电梯功能',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			
			
			
			
			
			$("#offerForm").submit();
		}
		
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		}
		
		
		//获取项目名称  切换电梯信息
		function addItemName(){
			var itemName = $("#item_id").find("option:selected").text();
			$("#item_name").val(itemName);
			var item_id = $("#item_id").val();
			if(item_id!=null && item_id!=""){
				
				countProjectPrice(item_id);//刷新项目价钱
			}else{
				$("#item_total").val("");
			}
			$("#table").bootstrapTable("destroy","");
			$("#table").bootstrapTable({
				url:"offer/elevatorList.do?item_id="+item_id,
				pagination:true,
				pageNumber:1,
				pageSize:10,
				
				columns:[{
					field:"id",
					title:"编号"
				},{
					field:"elevator_name",
					title:"电梯名称"
				},{
					field:"models_name",
					title:"电梯规格"
				},{
					field:"total",
					title:"总价格"
				},{
					field:"elevator_approval",
					title:"审核状态"
				},{
					field:"operate",
					title:"操作",
					formatter:operateFormatter
				}]
			});
		}
		
		
		 
		
		//刷新项目总价
		function refreshProjectPrice(){
			var item_id = $("#item_id").val();
			if(item_id !=null && item_id !=""){
				countProjectPrice(item_id)
			}else{
				alert("请先选择项目");
			}
		}
		
		
		
		
		//启动流程
		function startElevator(id,elevator_instance_id){
			swal({
				title: "您确定要启动流程吗？",
				text: "点击确定将会启动该流程，请谨慎操作！",
				type: "warning",
				showCancelButton: true,
				confirmButtonColor: "#DD6B55",
				confirmButtonText: "启动",
				cancelButtonText: "取消"
			}).then(function (isConfirm) {
				if (isConfirm === true) {
					var url = "<%=basePath%>offer/apply.do?id="+id+'&elevator_instance_id='+elevator_instance_id;
					$.get(url, function (data) {
						if (data.msg == "success") {
							
							swal({
								title: "申请成功！",
								text: "您已经成功启动该流程。\n该流程实例ID为："+elevator_instance_id+",下一个任务为："+data.task_name,
								type: "success",
									}).then(function(){
										refreshCurrentTab(1);
									});
							
							

						} else {
							swal({
								title: "启动失败！",
								text:  data.err,
								type: "error",
								showConfirmButton: false,
								timer: 1000
							});
						}
					});

				} else if (isConfirm === false) {
					swal({
						title: "取消启动！",
						text: "您已经取消启动操作了！",
						type: "error",
						showConfirmButton: false,
						timer: 1000
					});
				}
			});
		}
		
		//重新申请电梯非标审核
		 function restartElevator(task_id,id){

			 swal({
				 title: "您确定要重新提交吗？",
				 text: "重新提交将会把数据提交到下一层任务处理者！",
				 type: "warning",
				 showCancelButton: true,
				 confirmButtonColor: "#DD6B55",
				 confirmButtonText: "重新提交",
				 cancelButtonText: "取消"
			 }).then(function (isConfirm) {
				 if (isConfirm === true) {
					 var url = "<%=basePath%>offer/restartElevator.do?task_id="+task_id+"&id="+id+"&tm="+new Date().getTime();
					 $.get(url, function (data) {
						 if (data.msg == "success") {
							 swal({
								 title: "重新提交成功！",
								 text: "您已经成功重新提交了该电梯非标审核。",
								 type: "success",
							 }).then(function(){
								 refreshCurrentTab(1);
							 });

						 } else {
							 swal({
								 title: "重新提交失败！",
								 text:  data.err,
								 type: "error",
								 showConfirmButton: false,
								 timer: 1000
							 });
						 }
					 });

				 } else if (isConfirm === false) {
					 swal({
						 title: "取消重新提交！",
						 text: "您已经取消重新提交操作了！",
						 type: "error",
						 showConfirmButton: false,
						 timer: 1000
					 });
				 }
			 });
		 }
		
		//查看历史
		 function viewHistory(elevator_instance_id){
			 $("#viewHistory").kendoWindow({
				 width: "900px",
				 height: "500px",
				 title: "查看历史记录",
				 actions: ["Close"],
				 content: '<%=basePath%>workflow/goViewHistory?pid='+elevator_instance_id,
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").center().open();
		 }
		
		//审核配置
			function handleElevator(id,item_id,elevator_id,models_id,flag,models_name){
				if(models_id ==null || models_id =="" || typeof(models_id) == "undefined"){
					models_id = "";
				}
				
				$("#SetFunctions").kendoWindow({
					width:"1200px",
					height:"700px",
					title:"配置参数",
					actions: ["Close"],
			        content: '<%=basePath%>offer/elevatorHandleManages.do?id='+id+"&item_id="+item_id+"&elevator_id="+elevator_id+"&models_id="+models_id+"&flag="+flag+"&models_name="+models_name,
			        modal : true,
					visible : false,
					resizable : true
				}).data("kendoWindow").maximize().open();
			}
		
		//刷新iframe
        function refreshCurrentTab() {
      	/* 	alert("refresh");
      		alert("src=>"+window.location); */
        	window.location.reload();
        }
		
		
	</script>
</html>
