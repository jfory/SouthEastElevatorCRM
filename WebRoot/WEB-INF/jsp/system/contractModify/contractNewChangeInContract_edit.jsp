<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 图片插件 -->
<link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
<!-- Check Box -->
<link href="static/js/iCheck/custom.css" rel="stylesheet">
<!-- Sweet Alert -->
<link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
	<!-- 选择报价页面 -->
	<div id="ChangeTheAgreement" class="animated fadeIn"></div>
	
	<div class="wrapper wrapper-content animated fadeInRight" style="padding: 0;">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div id="top" ,name="top"></div>
						
						<form role="form" class="form-inline" action=""
							method="post" name="DeviceForm" id="DeviceForm">
							<div class="form-group">
								<button type="button" class="btn  btn-primary"
									style="margin-bottom: 0px;" title="新建" 
									onclick="CNadd('${pd.item_id}','${pd.HT_UUID}');">新建
								</button>
								项目名称:${headMsg.item_name}&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp客户名称:${headMsg.customer_name}
							</div>
							
							<button class="btn  btn-success" title="刷新" type="button"
	                               style="float: right" onclick="refreshCurrentTab();">刷新
	                       	</button>
						</form>
						
						<div class="row">
							</br>
						</div>
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>变更协议号</th>
										<th>次第</th>
										<th>业务员</th>
										<th>总价格</th>
										<th>申请日期</th>
										<th>状态</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty contractModifyList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${contractModifyList}" var="cm" varStatus="vs">
													<tr>
														<td>${cm.modify_number}</td>
														<td>${cm.squence}</td>
														<td>${cm.NAME}</td>
														<td>${cm.total}</td>
														<td>${cm.input_date}</td>
														<td>
																${cm.act_status=="1"?"待启动":""}
																${cm.act_status=="2"?"待审核":""}
																${cm.act_status=="3"?"审核中":""}
																${cm.act_status=="4"?"已通过":""}
																${cm.act_status=="5"?"被驳回":""}
																${cm.act_status=="6"?"已通过":""}
														</td>
														<td>
															<!-- 公共 -->
															<button class="btn btn-sm btn-info" title="查看"
																type="button" onclick="CNselect('${cm.id}');">查看
															</button>
															
															<c:if test="${cm.act_status == '1' || cm.act_status == '5'}">
																<button class="btn btn-sm btn-primary" title="编辑"
																type="button" onclick="CNedit('${cm.id}');">编辑
																</button>
																<button class="btn btn-sm btn-danger" title="删除"
																		type="button" onclick="CNdelte('${cm.id}');">删除
																</button>
															</c:if>
															
															<c:if test="${cm.act_status == '1'}">
															<button class="btn  btn-warning btn-sm" title="启动流程"
																	type="button" onclick="startLeave('${cm.id}','${cm.act_key}')">启动
															</button>
															</c:if>
															
															 <c:if test="${cm.act_status == '5'}">
																<button class="btn  btn-warning btn-sm" title="重新提交" type="button" 
																onclick="restartAgent('${cm.task_id}','${cm.id}');">重新提交</button>
															  </c:if>
															
															<c:if test="${cm.act_status != '1'}">
															    <button class="btn  btn-info btn-sm" title="审核记录" type="button" 
															    onclick="viewHistory('${cm.act_key}');">审核记录</button>
								 							  </c:if>
															
															<c:if test="${cm.act_status == '4'}">
																<!-- <button class="btn btn-sm btn-success" title="输出"
																		type="button" onclick="CNapproved();">输出
																</button> -->
																<a class="btn btn-sm btn-success" title="输出" type="button" target="_blank" href="<%=basePath%>contractModify/toContractModify.do?id=${cm.id}">输出</a>
															</c:if>
														
														</td>
													</tr>
												</c:forEach>
											</c:if>
											<!-- 权限设置 -->
											<c:if test="${QX.cha == 0 }">
												<tr>
													<td colspan="100" class="center">您无权查看</td>
												</tr>
											</c:if>
										</c:when>
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center">没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
							<div class="col-lg-12" style="padding-left: 0px; padding-right: 0px">
								${page.pageStr}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--返回顶部开始-->
	<div id="back-to-top">
		<a class="btn btn-warning btn-back-to-top"
			href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
			<i class="fa fa-chevron-up"></i>
		</a>
	</div>
	<!--返回顶部结束-->
	<!-- Fancy box -->
	<script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
	<script src="static/js/iCheck/icheck.min.js"></script>
	<!-- Sweet alert -->
	<script src="static/js/sweetalert/sweetalert.min.js"></script>
	
	<script type="text/javascript">
	//---------------------------xcx-------------------------Start
	
	//新建
	function CNadd(item_id,HT_UUID){
		$("#ChangeTheAgreement").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "变更协议",
	        actions: ["Close"],
	        /*content: '<%=basePath%>contractNew/goChangeTheAgreement.do',*/
	        content: '<%=basePath%>contractModify/goAdd.do?ht_uuid='+HT_UUID+'&item_id='+item_id,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	};
	
	//查看
	function CNselect(id){
		$("#ChangeTheAgreement").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "变更协议",
	        actions: ["Close"],
	        /*content: '<%=basePath%>contractNew/goChangeTheAgreement.do',*/
	        content: '<%=basePath%>contractModify/goEdit.do?id='+id+'&forwardMsg=view',
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}
	
	//编辑
	function CNedit(id){
		$("#ChangeTheAgreement").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "变更协议",
	        actions: ["Close"],
	        /*content: '<%=basePath%>contractNew/goChangeTheAgreement.do',*/
	        content: '<%=basePath%>contractModify/goEdit.do?id='+id+'&forwardMsg=edit',
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}
	
	//删除
	function CNdelte(id){
		swal({
            title: "您确定要删除此条变更协议号的信息吗？",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            cancelButtonText: "取消",
            closeOnConfirm: false,
            closeOnCancel: false
        },
        function (isConfirm) {
            if (isConfirm) {
            	var url = "<%=basePath%>contractModify/delete.do?id="+id;
				$.get(url,function(data){
					if(data.msg=='success'){
						swal({   
				        	title: "删除成功！",
				        	text: "您已经成功删除了这条信息。",
				        	type: "success",  
				        	 }, 
				        	function(){   
				        		//
							    refreshCurrentTab();
				        	});
					}else{
						swal("删除失败", "您的删除操作失败了！", "error");
					}
				});
            } else {
                swal("已取消", "您取消了删除操作！", "error");
            }
        });
	}
	
	//启动流程
	function startLeave(id,act_key){
		swal({
			title: "您确定要启动流程吗？",
			text: "点击确定将会启动该流程，请谨慎操作！",
			type: "warning",
			showCancelButton: true,
			confirmButtonColor: "#DD6B55",
			confirmButtonText: "启动",
			cancelButtonText: "取消",
			closeOnConfirm: false,
            closeOnCancel: false
	        },function (isConfirm) {
			if (isConfirm)
			{
				var url = "<%=basePath%>contractModify/apply.do?id="+id+"&act_key="+ act_key;
				$.get(url, function (data) {
					console.log(data.msg);
					if (data.msg == "success") {
						swal({   
							title: "启动成功！",
							text: "您已经成功启动该流程。\n该流程实例ID为："+act_key+",下一个任务为："+data.task_name,
				        	type: "success",  
						    },function(){
							    refreshCurrentTab();
						    });
						
					} else {
						swal("启动失败","error");
					}
				});
			} 
			else
			{
				swal("已取消", "您已经取消启动操作了！", "error");
			}
		});
	}
  	
	//审核记录
	 function viewHistory(instance_id){
		 $("#ChangeTheAgreement").kendoWindow({
			 width: "900px",
			 height: "500px",
			 title: "查看审核记录",
			 actions: ["Close"],
			 content: '<%=basePath%>workflow/goViewHistory.do?pid='+instance_id,
			 modal : true,
			 visible : false,
			 resizable : true
		 }).data("kendoWindow").center().open();
	 }
    
	//重新提交流程
	 function restartAgent(task_id,id){
		 swal({
			 title: "您确定要重新提交吗？",
			 text: "重新提交流程进行审核！",
			 type: "warning",
			 showCancelButton: true,
			 confirmButtonColor: "#DD6B55",
			 confirmButtonText: "提交",
			 cancelButtonText: "取消"
		 },
		 function (isConfirm) {
			 if (isConfirm === true) {
				 var url = "<%=basePath%>contractModify/restartAgent.do?task_id="+task_id+"&id="+id+"&tm="+new Date().getTime();
				 $.get(url, function (data) {
					 console.log(data.msg);
					 if (data.msg == "success") {
						 swal({
							 title: "重新提交成功！",
							 text: "您已经成功重新提交了该流程！",
							 type: "success"
						 },
						 function(){
							 refreshCurrentTab();
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
			 } else if (isConfirm == false) {
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
	
	//---------------------------xcx-------------------------End
	

    //刷新iframe
    function refreshCurrentTab() {
        $("#DeviceForm").submit();
    }
    //检索
    function search() {
        $("#DeviceForm").submit();
    }
    
	/* back to top */
	function setWindowScrollTop(win, topHeight) {
		if (win.document.documentElement) {
			win.document.documentElement.scrollTop = topHeight;
		}
		if (win.document.body) {
			win.document.body.scrollTop = topHeight;
		}
	}
	</script>
</body>
</html>


