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
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg" >
	<div id="EditItem" class="animated fadeIn"></div>
	<div id="viewHistory" class="animated fadeIn"></div>
	<div id="EditDiscount" class="animated fadeIn"></div>
	<div id="HandleTask" class="animated fadeIn"></div>
	<input type="hidden" id="active" value="${active}">
    <div class="wrapper wrapper-content">
        <div class="row">
        	<div class="panel blank-panel">
					<div class="panel-heading">
						<div class="panel-options">
							<ul class="nav nav-tabs">
								<li id="nav-tab-1">
									<a class="count-info-sm" data-toggle="tab" href="#tab-1" onclick="tabChange(1)">
										<i class="fa fa-hourglass-2"></i>
										我的申请
									</a>
								</li>
								<li id="nav-tab-2">
									<a data-toggle="tab" href="#tab-2" onclick="tabChange(2)">
										<i class="fa fa-hourglass"></i>
										待我办理
										<c:if test="${pd.count>0}">
											<span class="label label-warning">${pd.count}</span>
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
									<div class="ibox-content">
										<form role="form" class="form-inline" action="discount/listItem.do" method="post" name="DiscountForm1" id="DiscountForm1">
											<div class="form-group" style="width:100%">
				                        		<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;float:right" onclick="refreshCurrentTab(1);">刷新</button>
				                        	</div>
			                        	</form>
			                        	<div class="table-responsive">
			                            <table class="table table-striped table-bordered table-hover">
			                                <thead>
			                                    <tr>
			                                        <th style="width:20%;">项目编号</th>
			                                        <th style="width:30%;">项目名称</th>
			                                        <th style="width:30%;">项目状态</th>
			                                        <th style="width:20%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty itemList}">
													<c:forEach items="${itemList}" var="item" >
															<tr onclick="showTr('${item.item_id}');">
																<td>${item.item_no}</td>
																<td>${item.item_name}</td>
																<td>
																	${item.item_status==""?"未选择":""}
																	${item.item_status=="1"?"信息":""}
																	${item.item_status=="2"?"报价":""}
																	${item.item_status=="3"?"投标":""}
																	${item.item_status=="4"?"洽谈":""}
																	${item.item_status=="5"?"合同":""}
																	${item.item_status=="6"?"中标":""}
																	${item.item_status=="7"?"失标":""}
																	${item.item_status=="8"?"取消":""}
																	${item.item_status=="9"?"生效":""}
																</td>
																<td>
																	<button class="btn btn-sm btn-info btn-sm" title="查看" type="button" onclick="selItem('${item.item_id}')">查看</button>
																</td>
															</tr>
							                                <!-- 开始循环 -->
							                                		<tr name="${item.item_id}" style="display: none">
								                                        <th style="width:5%;">电梯类型</th>
								                                        <th style="width:5%;">申请折扣</th>
								                                        <th style="width:5%;">申请人</th>
								                                        <th style="width:10%;">操作</th>
							                                		</tr>
																	<c:forEach items="${item.resultDiscountList}" var="var" >
																		<tr name="${item.item_id}" style="display: none">
																			<td>${var.elevator_name}</td>
																			<td>${var.discount}</td>
																			<td>${var.username}</td>
																			<td>
																				<div>
																					<c:if test="${var.status == 0 }">
																						<button class="btn btn-sm btn-warning btn-sm" title="提交" type="button" onclick="start('${var.id}','${var.elevator_id}')">提交</button>
																					</c:if>
																					<c:if test="${var.status == 3 }">
																						<button class="btn btn-sm btn-warning btn-sm" title="重新提交" type="button" onclick="start('${var.id}','${var.elevator_id}')">重新提交</button>
																					</c:if>
																					<button class="btn btn-sm btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('${var.discount_instance}')">历史记录</button>
																				</div>
																			</td>
																		</tr>
																	</c:forEach>
																</div>
													</c:forEach>
													</div>
												</c:when>
											</c:choose>
											</tbody>
										</table>
										</div>
										<div class="col-lg-12" style="padding-left:0px;padding-right:0px">
											<c:if test="${QX.add == 1 }">
												<button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button>
											</c:if>
												${page.pageStr}
										</div>
										</div>

								</div>
							</div>


							<div id="tab-2" class="tab-pane">
								<div class="ibox float-e-margins">
									
									<div class="ibox-content">
										<form role="form" class="form-inline" action="discount/listPend.do" method="post" name="DiscountForm2" id="DiscountForm2">
											<div class="form-group" style="width:100%">
				                        		<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;float:right" onclick="refreshCurrentTab(2);">刷新</button>
				                        	</div>
			                        	</form>
			                        	<div class="table-responsive">
			                            <table class="table table-striped table-bordered table-hover">
			                                <thead>
			                                    <tr>
			                                        <th style="width:20%;">项目编号</th>
			                                        <th style="width:30%;">项目名称</th>
			                                        <th style="width:30%;">项目状态</th>
			                                        <th style="width:20%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty itemApplyList}">
													<c:forEach items="${itemApplyList}" var="item" >
															<tr onclick="showTr('${item.item_id}');">
																<td>${item.item_no}</td>
																<td>${item.item_name}</td>
																<td>
																	${item.item_status==""?"未选择":""}
																	${item.item_status=="1"?"信息":""}
																	${item.item_status=="2"?"报价":""}
																	${item.item_status=="3"?"投标":""}
																	${item.item_status=="4"?"洽谈":""}
																	${item.item_status=="5"?"合同":""}
																	${item.item_status=="6"?"中标":""}
																	${item.item_status=="7"?"失标":""}
																	${item.item_status=="8"?"取消":""}
																	${item.item_status=="9"?"生效":""}
																</td>
																<td><button class="btn btn-sm btn-info btn-sm" title="查看" type="button" onclick="selItem('${item.item_id}');">查看</button></td>
															</tr>
							                                <!-- 开始循环 -->
					                                		<tr name="${item.item_id}" style="display: none">
						                                        <th style="width:5%;">电梯类型</th>
						                                        <th style="width:5%;">申请折扣</th>
						                                        <th style="width:5%;">申请人</th>
						                                        <th style="width:10%;">操作</th>
					                                		</tr>
															<c:forEach items="${item.resultDiscountList}" var="var" >
																<tr name="${item.item_id}" style="display: none">
																	<td>${var.elevator_name}</td>
																	<td>${var.discount}折</td>
																	<td>${var.username}</td>
																	<td>
																		<c:if test="${var.operateStatus == 0 }">
																			<!-- <span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span> -->
																		</c:if>
																		<div>
																		<c:if test="${var.operateStatus == 1 }">
																			<c:if test="${var.type == 1 }">
																				<button class="btn btn-sm btn-success btn-sm" title="办理" type="button" onclick="handle('${var.task_id}','${var.id}')">办理</button>
																			</c:if>
																			<c:if test="${var.type == 0 }">
																				<button class="btn btn-sm btn-warning btn-sm" title="签收" type="button" onclick="claim('${var.task_id}')">签收</button>
																			</c:if>
																		</c:if>
																		<button class="btn btn-sm btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('${var.discount_instance}')">历史记录</button>
																		</div>
																	</td>
																</tr>
															</c:forEach>
													</c:forEach>
												</c:when>
											</c:choose>
											</tbody>
										</table>
										</div>
										<div class="col-lg-12" style="padding-left:0px;padding-right:0px">
											<!-- <c:if test="${QX.add == 1 }">
												<button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button>
											</c:if> -->
											<!-- <c:if test="${QX.del == 1 }">
												<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>						
											</c:if> -->
												${page.pageStr}
										</div>
										</div>

									</div>
								</div>
							</div>

						</div>
					</div>
			</div>





		</div>
 </div>
 <!--返回顶部开始-->
        <div id="back-to-top">
            <a class="btn btn-warning btn-back-to-top" href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
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
	 $(document).ready(function () {
		 //loading end
		 parent.layer.closeAll('loading');
     	/* checkbox */
         $('.i-checks').iCheck({
             checkboxClass: 'icheckbox_square-green',
             radioClass: 'iradio_square-green',
         });
     	/* 图片 */
         $('.fancybox').fancybox({
             openEffect: 'none',
             closeEffect: 'none'
         });
         /* tab */
         var active = $("#active").val();
         if(active==""||active=="1"){
			 $("#nav-tab-1").addClass("active");
			 $("#tab-1").addClass("active");
         }else if(active=="2"){
			 $("#nav-tab-2").addClass("active");
			 $("#tab-2").addClass("active");
         }


     });
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
     	$("#DiscountForm"+id).submit();
     }
	//检索
	function search(id){
		$("#DiscountForm"+id).submit();
	}
	//新增
	function add(){
		$("#EditDiscount").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "新增折扣申请",
	        actions: ["Close"],
	        content: '<%=basePath%>discount/goAddDiscount.do',
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}

	//提交流程
	function start(id,elevator_id){
		/*$.post("<%=basePath%>discount/startApply.do",
				{
					"id": id,
					"elevator_id": elevator_id
				},
				function(data){
					if(data.msg=="success"){
						alert("提交成功");
						refreshCurrentTab(1);

					}else if(data.msg=="err"){
						alert("操作失败");
					}
				}
			);*/
		swal({
                title: "您确定要提交这条任务吗？",
                text: "提交后将会上报进行审核！",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "提交",
                cancelButtonText: "取消"
            },
            function (isConfirm) {
                if (isConfirm) {
                	var url = "<%=basePath%>discount/startApply.do?id="+id+"&elevator_id="+elevator_id+"&tm="+new Date().getTime();;
    				$.get(url,function(data){
    					if(data.msg=='success'){
    						swal({   
    				        	title: "提交成功！",
    				        	text: "您已经成功提交了这个任务,请等待该任务办理。",
    				        	type: "success",  
    				        	 }, 
    				        	function(){   
    				        		 refreshCurrentTab(2); 
    				        	 });
    					}else{
    						swal("提交失败", "您的提交操作失败了！", "error");
    					}
    				});
                } else {
                    swal("已取消", "您取消了提交操作！", "error");
                }
            });

	}

	//重新提交
	function restart(id,elevator_id){
		/*$.post("<%=basePath%>discount/restartApply.do",
				{
					"id": id,
					"elevator_id": elevator_id
				},
				function(data){					
					if(data.msg=="success"){
						alert("提交成功");
						refreshCurrentTab(1);

					}else if(data.msg=="err"){
						alert("操作失败");
					}
				}
			);*/
		swal({
                title: "您确定要重新提交这条任务吗？",
                text: "重新提交后将会上报进行审核！",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "提交",
                cancelButtonText: "取消"
            },
            function (isConfirm) {
                if (isConfirm) {
                	var url = "<%=basePath%>discount/restartApply.do?id="+id+"&elevator_id="+elevator_id+"&tm="+new Date().getTime();;
    				$.get(url,function(data){
    					if(data.msg=='success'){
    						swal({   
    				        	title: "提交成功！",
    				        	text: "您已经成功提交了这个任务,请等待该任务办理。",
    				        	type: "success",  
    				        	 }, 
    				        	function(){   
    				        		 refreshCurrentTab(2); 
    				        	 });
    					}else{
    						swal("提交失败", "您的重新提交操作失败了！", "error");
    					}
    				});
                } else {
                    swal("已取消", "您取消了重新提交操作！", "error");
                }
            });
	}

	//签收任务
	function claim(task_id){
		swal({
                    title: "您确定要签收这条任务吗？",
                    text: "签收后请对该任务进行处理！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "签收",
                    cancelButtonText: "取消"
                },
                function (isConfirm) {
                    if (isConfirm) {
                    	var url = "<%=basePath%>discount/claim.do?task_id="+task_id+"&tm="+new Date().getTime();;
        				$.get(url,function(data){
        					if(data.msg=='success'){
        						swal({   
        				        	title: "签收成功！",
        				        	text: "您已经成功签收了这个任务,请对该任务进行处理。",
        				        	type: "success",  
        				        	 }, 
        				        	function(){   
        				        		 refreshCurrentTab(2); 
        				        	 });
        					}else{
        						swal("签收失败", "您的签收操作失败了！", "error");
        					}
        				});
                    } else {
                        swal("已取消", "您取消了签收操作！", "error");
                    }
                });

	}

	//办理任务
	function handle(task_id,id){
		$("#HandleTask").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "办理意见",
	        actions: ["Close"],
	        content: '<%=basePath%>discount/goHandleTask.do?task_id='+task_id+'&id='+id,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}

	//修改tab
	function tabChange(id){
		$("#DiscountForm"+id).submit();
	}

	//查看历史
		 function viewHistory(id){
			 $("#viewHistory").kendoWindow({
				 width: "900px",
				 height: "500px",
				 title: "查看历史记录",
				 actions: ["Close"],
				 content: '<%=basePath%>workflow/goViewHistory?pid='+id,
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").center().open();
		 }

	//查看项目
	function selItem(id){
		$("#EditItem").kendoWindow({
	        width: "1000px",
	        height: "800px",
	        title: "编辑项目信息",
	        actions: ["Close"],
	        content: '<%=basePath%>item/goEditItem.do?item_id='+id+'&operateType=sel',
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}

	//显示
	function showTr(id){
		var isHidden = $("tr[name='"+id+"']").is(':hidden');
		if(isHidden){
			$("tr[name='"+id+"']").show();
		}else{
			$("tr[name='"+id+"']").hide();
		}
	}


	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
