<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	<link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
     	<div id="EditItem" class="animated fadeIn"></div><!-- 打开查看 -->
    	<div id="EditShops" class="animated fadeIn"></div><!-- 打开查看 -->
        <div id="EditLeaves" class="animated fadeIn"></div>
        <div id="AddLeaves" class="animated fadeIn"></div>
		<div id="viewDiagram" class="animated fadeIn"></div>
		<div id="handleLeave" class="animated fadeIn"></div>
		<div id="viewHistory" class="animated fadeIn"></div>
	        <div class="row">
				<div class="panel blank-panel">
					<div class="panel-heading">
						<div class="panel-options">
							<ul class="nav nav-tabs">
								<li id="nav-tab-2">
									<a class="count-info-sm" data-toggle="tab" href="#tab-2" onclick="tabChange(2)">
										<i class="fa fa-hourglass-2"></i>
										待我处理
										<c:if test="${pd.count>0}">
											<span class="label label-warning">${pd.count}</span>
										</c:if>
									</a>
								</li>
								<li id="nav-tab-3">
									<a class="count-info-sm"  data-toggle="tab" href="#tab-3" onclick="tabChange(3)">
										<i class="fa fa-hourglass"></i>
										我已处理
										<c:if test="${pd.count1>0}">
											<span class="label label-warning">${pd.count1}</span>
										</c:if>
									</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="panel-body">
						<div class="tab-content">
							<div id="tab-1" class="tab-pane">
								<div class="ibox float-e-margins">
									
								</div>
							</div>
							<!-- 待处理 -->
							<div id="tab-2" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<div id="top2"name="top2"></div>
										<form role="form" class="form-inline" action="item/ItemAudit.do" method="post" name="leaveForm2" id="leaveForm2">
											<button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab(2);">刷新</button>
										</form>
										<div class="row">
											</br>
										</div>
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover">
												<thead>
												<tr>
													<th style="text-align:center;">序号</th>
													<th style="width:5%;">项目编号</th>
			                                        <th style="width:10%;">项目名称</th>
			                                        <th style="width:10%;">项目录入时间</th>
			                                        <th style="width:8%;">跟进状态</th>
			                                        <th style="width:8%;">项目状态</th>
			                                        <th style="width:8%;">审核状态</th>
			                                        <th style="text-align:center;">当前流程</th>
			                                        <th style="width:15%;text-align:center;">操作</th>
												</tr>
												</thead>
												<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty itemList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${itemList}" var="var" varStatus="vs2">
													<tr>
														<td style="text-align:center;" class='center' style="width: 30px;">${vs2.index+1}</td>
														<td>${var.item_no}</td>
														<td>${var.item_name}</td>
														<th>${var.HTLRSJ}</th>
														<td>${var.ZL_TYPE}</td>
														<td>
															${var.item_status==""?"未选择":""}
															${var.item_status=="1"?"信息":""}
															${var.item_status=="2"?"报价":""}
															${var.item_status=="3"?"投标":""}
															${var.item_status=="4"?"洽谈":""}
															${var.item_status=="5"?"合同":""}
															${var.item_status=="6"?"中标":""}
															${var.item_status=="7"?"失标":""}
															${var.item_status=="8"?"取消":""}
															${var.item_status=="9"?"生效":""}
															${var.item_status=="11"?"关闭":""}
														</td>
														
														<!-- 审核状态 -->
														<td>
															<c:if test="${var.item_approval eq 1}">新建</c:if>
															<c:if test="${var.item_approval eq 2}">待审核</c:if>
															<c:if test="${var.item_approval eq 3}">审核中</c:if>
															<c:if test="${var.item_approval eq 4}">已通过</c:if>
															<c:if test="${var.item_approval eq 5}">被驳回</c:if>
															
														</td>
														<td style="text-align:center;"><a onclick="viewDiagram('${var.item_instance_id}');">${var.task_name}</a></td>
														<td style="text-align:center;">
																		<button class="btn  btn-success btn-sm" title="查看" type="button" onclick="edit('${var.item_id}','sel');">查看</button>
																		<c:if test="${var.type == '0'}">
																			<button class="btn  btn-primary btn-sm" title="签收" type="button" onclick="claimstra('${var.task_id}');">签收</button>
																		</c:if>
																		<c:if test="${var.type == '1'}">
																			<button class="btn  btn-warning btn-sm" title="办理" type="button" onclick="goHandlestra('${var.task_id}','${var.item_id}');">办理</button>
																		</c:if>
														</td>
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
										</br>
										<div class="col-lg-12" style="padding-left:0px;padding-right:0px;margin:10px -10px 10px -10px">
											${page.pageStrForActiviti}
										</div>
									</div>
								</div>
							</div>
							<%--已处理--%>
							<div id="tab-3" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<div id="top3" name="top3"></div>
										<form role="form" class="form-inline" action="item/listDonitem.do" method="post" name="leaveForm3" id="leaveForm3">
											<button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab(3);">刷新</button>
										</form>
										<div class="row">
											</br>
										</div>
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover">
												<thead>
												<tr>
													<th style="text-align:center;">序号</th>
													<th style="width:5%;">项目编号</th>
			                                        <th style="width:10%;">项目名称</th>
			                                        <th style="width:10%;">项目录入时间</th>
			                                        <th style="width:8%;">跟进状态</th>
			                                        <th style="width:8%;">项目状态</th>
			                                        <th style="width:8%;">审核状态</th>
			                                        <th style="text-align:center;">当前流程</th>
			                                        <th style="width:15%;text-align:center;">操作</th>
												</tr>
												</thead>
												<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty itemList}">
														 <c:if test="${QX.cha == 1 }"> 
															<c:forEach items="${itemList}" var="var" varStatus="vs2">
													<tr>
														<td style="text-align:center;" class='center' style="width: 30px;">${vs2.index+1}</td>
														<td>${var.item_no}</td>
														<td>${var.item_name}</td>
														<th>${var.HTLRSJ}</th>
														<td>${var.ZL_TYPE}</td>
														<td>
															${var.item_status==""?"未选择":""}
															${var.item_status=="1"?"信息":""}
															${var.item_status=="2"?"报价":""}
															${var.item_status=="3"?"投标":""}
															${var.item_status=="4"?"洽谈":""}
															${var.item_status=="5"?"合同":""}
															${var.item_status=="6"?"中标":""}
															${var.item_status=="7"?"失标":""}
															${var.item_status=="8"?"取消":""}
															${var.item_status=="9"?"生效":""}
															${var.item_status=="11"?"关闭":""}
														</td>
														
														<!-- 审核状态 -->
														<td>
															<c:if test="${var.item_approval eq 1}">新建</c:if>
															<c:if test="${var.item_approval eq 2}">待审核</c:if>
															<c:if test="${var.item_approval eq 3}">审核中</c:if>
															<c:if test="${var.item_approval eq 4}">已通过</c:if>
															<c:if test="${var.item_approval eq 5}">被驳回</c:if>
															
														</td>
														<td style="text-align:center;">
														<c:if test="${var.isRuning == 1}"><a onclick="viewDiagram('${var.item_instance_id}');">${var.task_name}</a></c:if>
														<c:if test="${var.isRuning != 1}">已完成</c:if>
														</td>
														<td style="text-align:center;">
															<button class="btn  btn-success btn-sm" title="查看" type="button" onclick="edit('${var.item_id}','sel');" >查看</button>
															<button class="btn  btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('${var.item_instance_id}');">记录</button>
														</td>

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
										</br>
										<div class="col-lg-12" style="padding-left:0px;padding-right:0px;margin:10px -10px 10px -10px">
											${page.pageStrForActiviti}
										</div>
									</div>
								</div>
							</div>
							
							
							
						</div>
					</div>
				</div>
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">

	                </div>
	            </div>
	        </div>
	    </div>
	    <!--返回顶部开始-->
        <div id="back-to-top">
            <a class="btn btn-warning btn-back-to-top" id="top" >
                <i class="fa fa-chevron-up"></i>
            </a>
        </div>
        <!--返回顶部结束-->
	<!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <!-- Sweet alert -->
	<script src="static/js/sweetalert2/sweetalert2.js"></script>
    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
    
	<script type="text/javascript">
	 $(document).ready(function () {
		 //loading end
		 parent.layer.closeAll('loading');
     	/* checkbox */
         $('.i-checks').iCheck({
             checkboxClass: 'icheckbox_square-green',
             radioClass: 'iradio_square-green',
         });
     });

	 //设置tab显示
	 var isActive1 = "${pd.isActive1}";
	 var isActive2 = "${pd.isActive2}";
	 var isActive3 = "${pd.isActive3}";
	 if(isActive1=="1"){
		 $("#nav-tab-1").addClass("active");
		 $("#tab-1").addClass("active");
	 }else if(isActive2=="1"){
		 $("#nav-tab-2").addClass("active");
		 $("#tab-2").addClass("active");
	 }else if(isActive3=="1"){
		 $("#nav-tab-3").addClass("active");
		 $("#tab-3").addClass("active");
	 }
	 //tab切换
	 function tabChange(id){
		$("#leaveForm"+id).submit();
	 }
     /* checkbox全选 */
     $("#zcheckbox").on('ifChecked', function(event){
     	$('input').iCheck('check');
   	});
     /* checkbox取消全选 */
     $("#zcheckbox").on('ifUnchecked', function(event){
     	
     	$('input').iCheck('uncheck');
   	});
    
    	//刷新iframe
        function refreshCurrentTab(id) {
        	$("#leaveForm"+id).submit();
        }
		//检索
		function search(id){
			$("#leaveForm"+id).submit();
		}
		
		 //签收任务
		 function claimstra(task_id){
			 swal({
				 title: "您确定要签收这条任务吗？",
				 text: "签收后将请对该任务进行处理！",
				 type: "warning",
				 showCancelButton: true,
				 confirmButtonColor: "#DD6B55",
				 confirmButtonText: "签收",
				 cancelButtonText: "取消"
			 }).then(function (isConfirm) {
				 if (isConfirm === true) {
					 var url = "<%=basePath%>contractNew/claim.do?task_id="+task_id+"&tm="+new Date().getTime();
					 $.get(url, function (data) {
						 console.log(data.msg);
						 if (data.msg == "success") {
							 swal({
								 title: "签收成功！",
								 text: "您已经成功签收了这个任务,请对该任务进行处理。",
								 type: "success",
							 }).then(function(){
								 refreshCurrentTab(2);
							 });
						 } else {
							 swal({
								 title: "签收失败！",
								 text:  data.err,
								 type: "error",
								 showConfirmButton: false,
								 timer: 1000
							 });
						 }
					 });

				 } else if (isConfirm === false) {
					 swal({
						 title: "取消签收！",
						 text: "您已经取消签收操作了！",
						 type: "error",
						 showConfirmButton: false,
						 timer: 1000
					 });
				 }
			 });
		 }
	 //办理任务
	 function goHandlestra(task_id,item_id){
		 $("#handleLeave").kendoWindow({
			 width: "600px",
			 height: "400px",
			 title: "办理任务",
			 actions: ["Close"],
			 content: '<%=basePath%>item/goHandStra.do?task_id='+task_id+'&item_id='+item_id,
			 modal : true,
			 visible : false,
			 resizable : true
		 }).data("kendoWindow").center().open();
	 }
	 //查看流程定义图片
	 function viewDiagram(processInstanceId){
		 $("#viewDiagram").kendoWindow({
			 width: "1400px",
			 height: "600px",
			 title: "查看流程图",
			 actions: ["Close"],
			 content: '<%=basePath%>workflow/goViewDiagramWithPid?pid='+processInstanceId+'&type=image',
			 modal : true,
			 visible : false,
			 resizable : true
		 }).data("kendoWindow").center().open();
	 }
	 //查看历史
	 function viewHistory(item_instance_id){
		 $("#viewHistory").kendoWindow({
			 width: "900px",
			 height: "500px",
			 title: "查看历史记录",
			 actions: ["Close"],
			 content: '<%=basePath%>workflow/goViewHistory?pid='+item_instance_id,
			 modal : true,
			 visible : false,
			 resizable : true
		 }).data("kendoWindow").center().open();
	 }
	//修改/查看
		function edit(id,operateType){
			$("#EditItem").kendoWindow({
		        width: "1000px",
		        height: "800px",
		        title: "编辑项目信息",
		        actions: ["Close"],
		        content: '<%=basePath%>item/goEditItem.do?item_id='+id+'&operateType='+operateType,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}

	 
		/* back to top */
		function setWindowScrollTop(win, topHeight){
		    if(win.document.documentElement){
		        win.document.documentElement.scrollTop = topHeight;
		    }
		    if(win.document.body){
		        win.document.body.scrollTop = topHeight;
		    }
		}

		$("#top").click(function(){
			
			$("html,body").animate({scrollTop : 0},500);
		});
      	
		</script>
</body>
</html>


