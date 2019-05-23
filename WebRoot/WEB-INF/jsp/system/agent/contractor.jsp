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
        <div id="AddAgent" class="animated fadeIn"></div>
        <div id="EditAgent" class="animated fadeIn"></div>
        <div id="ViewAgent" class="animated fadeIn"></div>
        <div id="viewHistory" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top",name="top"></div>
	                        <form role="form" class="form-inline" action="sysAgent/contractorList.do" method="post" name="menuForm" id="menuForm">
								<div class="form-group ">
	                                <input type="text" style="width: 15%;" name="agent_name" value="${agent_name}" placeholder="名称" class="form-control">
	                                <input type="text" style="width: 10%;" name="agent_area" value="${agent_area}" placeholder="区域" class="form-control">
	                                <input type="text" style="width: 10%;" name="agent_company" value="${agent_company}" placeholder="分公司" class="form-control">
	                                <input type="text" style="width: 10%;" name="agent_applyuser" value="${agent_applyuser}" placeholder="录入人" class="form-control">
	                                <input type="text" style="width: 10%;" name="agent_category" value="${agent_category}" placeholder="类别" class="form-control">
	                                <input type="text" style="width: 10%;" name="agent_constructor" value="${agent_constructor}" placeholder="安装资质" class="form-control">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            
	                            	<c:if test="${QX.add == 1 }">
										<button class="btn  btn-primary" title="新增" type="button" style="margin-left: 5px;margin-bottom:0px" onclick="add();">新增</button>
									</c:if>
	                            	<button class="btn  btn-success" title="刷新" type="button" style="float:right;margin-right: 5px;" onclick="refreshCurrentTab();">刷新</button>
	                            	
	                            </div>
	                        </form>
	                            <div class="row">
	                            </br>
	                             </div>
	                        <div class="table-responsive" >
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                   		<th style="width:2%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
	                                        <th style="width:5%;">序号</th>
	                                        <th style="width:10%;">编号</th>
	                                        <th style="width:10%;">名称</th>
	                                        <th style="width:13%;">地址</th>
	                                        <th style="width:10%;">联系人</th>
	                                        <th style="width:10%;">联系人电话</th>
	                                        <th style="width:9%;">类别</th>
	                                        <th style="width:9%;">安装资质</th>
	                                        <th style="width:8%;">审核状态</th>
	                                        <th style="width:20%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty agentList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${agentList}" var="var" varStatus="vs">
													<tr id="${var.autoid }">
														<c:choose>
															<c:when test="${var.agent_instance_id ne null and (var.agent_approval ne 0 or var.agent_approval ne 4)}">
																<td><input type="checkbox" disabled="disabled" class="i-checks"  name='ids' id='ids' value="${var.agent_id}"></td>
															</c:when>
															
															<c:when test="${var.agent_instance_id eq null and (var.contractor_approval eq 0 or var.contractor_approval eq 4)}">
																<td><input type="checkbox"  class="i-checks"  name='ids' id='ids' value="${var.agent_id}"></td>
															</c:when>
															
															<c:when test="${var.agent_instance_id eq null and (var.contractor_approval ne 0 or var.contractor_approval ne 4)}">
																<td><input type="checkbox" disabled="disabled"  class="i-checks"  name='ids' id='ids' value="${var.agent_id}"></td>
															</c:when>
														</c:choose>
													
													
														<td>${vs.index+1}</td>
														
														<td>
															${var.agent_no}
														
														</td>
														<td>
															${var.agent_name}
														
														</td>
														<td>${var.address_name }</td>
														<td>${var.agent_contact }</td>
														<td>
															${var.contact_phone }
														
														</td>
														<td>
															<!--类别:0,普通、1,核心、2,战略联盟、3,战略联盟二级、4,东南尚升二级 -->
															<c:if test="${var.agent_category  eq 0}">
																普通
															</c:if>
															<c:if test="${var.agent_category  eq 1}">
																核心
															</c:if>
															<c:if test="${var.agent_category  eq 2}">
																战略联盟
															</c:if>
															<c:if test="${var.agent_category  eq 3}">
																战略联盟二级
															</c:if>
															<c:if test="${var.agent_category  eq 4}">
																东南尚升二级
															</c:if>
															<c:if test="${var.agent_category  eq 5}">
																小业主代理商
															</c:if>
														</td>
														<td>
														<!-- 是否有安装资质 -->
															<c:if test="${var.is_constructor eq 1}">
																是
															</c:if>
															<c:if test="${var.is_constructor eq 2}">
																否
															</c:if>
														</td>
														<td>
															<c:if test="${var.contractor_approval eq 0 }">
																待审核
															</c:if>
															<c:if test="${var.contractor_approval eq 1 }">
																审核中
															</c:if>
															<c:if test="${var.contractor_approval eq 2 }">
																已完成
															</c:if>
															<c:if test="${var.contractor_approval eq 3}">
																已取消
															</c:if>
															<c:if test="${var.contractor_approval eq 4 }">
																被驳回
															</c:if>
														</td>
														
														<td>
															<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
															</c:if>
															<div>
																<!-- 待申请 -->
																
																<c:if test="${var.contractor_approval eq 0 }">
																	<c:if test="${QX.cha == 1 }">
																		<button class="btn  btn-success btn-sm" title="查看" type="button" onclick="viewAgent('${var.agent_id }');" >查看</button>
																	</c:if>
																	<c:if test="${QX.edit == 1 }">
																		<button class="btn  btn-primary btn-sm" title="编辑" type="button"onclick="edit('${var.agent_id }');">编辑</button>
																	<c:if test="${var.contractor_instance_id ne null }">
																		<button class="btn  btn-warning btn-sm" title="提交审核" type="button" onclick="startAgent('${var.agent_id }','${var.agent_instance_id}','${var.contractor_instance_id }');">提交审核</button>
																	</c:if>		
																	</c:if>
																	<c:if test="${QX.del == 1 }">
																		<c:choose>
																			<c:when test="${var.agent_instance_id ne null and (var.agent_approval eq 0 or var.agent_approval eq 4)}">
																				<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="del('${var.agent_id }','${var.agent_name }');">删除</button>
																			</c:when>
																			<c:when test="${var.agent_instance_id eq null }">
																				<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="del('${var.agent_id }','${var.agent_name }');">删除</button>
																			</c:when>
																		</c:choose>
																	</c:if>
																</c:if>
																<!-- 待审核 -->
																<c:if test="${var.contractor_approval eq 1 }">
																	<c:if test="${QX.cha == 1 }">
																		<button class="btn  btn-success btn-sm" title="查看" type="button" onclick="viewAgent('${var.agent_id }');" >查看</button>
																		<button class="btn  btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('${var.contractor_instance_id}');">分包商记录</button>
																	</c:if>
																</c:if>
																<!-- 已完成 -->
																<c:if test="${var.contractor_approval eq 2}">
																	<c:if test="${QX.cha == 1 }">
																	<button class="btn  btn-success btn-sm" title="查看" type="button" onclick="viewAgent('${var.agent_id }');" >查看</button>
																	<button class="btn  btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('${var.contractor_instance_id}');">分包商记录</button>
																	</c:if>
																</c:if>
																<!-- 已取消 -->
																<c:if test="${var.contractor_approval eq 3}">
																	
																	<c:if test="${QX.cha == 1 }">
																	<button class="btn  btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('${var.contractor_instance_id}');">分包商记录</button>
																	</c:if>
																</c:if>
																<!-- 代理商被驳回  -->
																<c:if test="${var.contractor_approval eq 4 }">
																	<c:if test="${QX.edit == 1 }">
																		<button class="btn  btn-primary btn-sm" title="编辑" type="button"onclick="edit('${var.agent_id }');">编辑</button>
																		<button class="btn  btn-warning btn-sm" title="重新申请" type="button" onclick="restartContractor('${var.task_id2 }','${var.agent_id }');">重新申请分包商</button>
																	</c:if>
																	<c:if test="${QX.cha == 1 }">
																	<button class="btn  btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('${var.contractor_instance_id}');">分包商记录</button>
																	</c:if>
																	<c:if test="${QX.del == 1 }">
																		<c:choose>
																			<c:when test="${var.agent_instance_id ne null and (var.agent_approval eq 0 or var.agent_approval eq 4)}">
																				<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="del('${var.agent_id }','${var.agent_name }');">删除</button>
																			</c:when>
																			<c:when test="${var.agent_instance_id eq null }">
																				<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="del('${var.agent_id }','${var.agent_name }');">删除</button>
																			</c:when>
																		</c:choose>	
																	</c:if>
																</c:if>	
																
																
															</div>
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
								<div class="col-lg-12" style="padding-left:0px;padding-right:0px">
									<c:if test="${QX.del == 1 }">
										<!-- <button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>	 -->					
									</c:if>
									<a class="btn btn-warning" title="导出到Excel" type="button" style="" target="_blank" href="<%=basePath%>sysAgent/toExcel.do">导出</a>
									<button class="btn btn-info" title="导入到Excel" type="button" style="" onclick="inputFile()">导入</button>
									<input style="display: none" class="form-control" type="file" style="" title="导入" id="importFile" onchange="importExcel(this)"/>
									<button class="btn  btn-success" title="下载数据模板" type="button" style="" onclick="downFile()">下载模板</button>
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
    <script src="static/js/sweetalert2/sweetalert2.js"></script>
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
        function refreshCurrentTab() {
      	/* 	alert("refresh");
      		alert("src=>"+window.location); */
        	window.location.reload();
        }
		//检索
		function search(){
			$("#Form").submit();
		}
		//新增
		function add(){
			$("#AddAgent").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "新增分包商",
		        actions: ["Close"],
		        content: '<%=basePath%>sysAgent/toContractorAdd.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		//启动流程
		function startAgent(agent_id,agent_instance_id,contractor_instance_id){

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
					var url = "<%=basePath%>sysAgent/apply.do?agent_id="+agent_id+'&agent_instance_id='+agent_instance_id + '&contractor_instance_id='+contractor_instance_id;
					$.get(url, function (data) {
						console.log(data.msg);
						if (data.msg == "success") {
							if(data.status == 1){
								swal({
									title: "申请成功！",
									text: "您已经成功启动该流程。\n该流程实例ID为："+agent_instance_id+",下一个任务为："+data.task_name,
									type: "success",
										}).then(function(){
											refreshCurrentTab(1);
										});
							}else if(data.status == 2){
								swal({
									title: "申请成功！",
									text: "您已经成功启动该流程。\n该流程实例ID为："+contractor_instance_id+",下一个任务为："+data.task_name2,
									type: "success",
										}).then(function(){
											refreshCurrentTab(1);
										});
							}else{
								swal({
									title: "申请成功！",
									text: "您已经成功启动代理商和分包商流程。",
									type: "success",
										}).then(function(){
											refreshCurrentTab(1);
										});
							}
							

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
		//删除
		function del(agent_id,agent_name){
                swal({
                        title: "您确定要删除["+agent_name+"]吗？",
                        text: "删除后将无法恢复，请谨慎操作！",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "删除",
                        cancelButtonText: "取消",
                        closeOnConfirm: false,
                        closeOnCancel: false
                    }).then(function (isConfirm) {
                        if (isConfirm) {
                        	var url = "<%=basePath%>sysAgent/del.do?agent_id="+agent_id+"&guid="+new Date().getTime();
            				$.get(url,function(data){
            					if(data=='success'){
            						swal({   
            				        	title: "删除成功！",
            				        	text: "您已经成功删除了这条信息。",
            				        	type: "success",  
            				        	}).then(function(){
            									refreshCurrentTab(1);
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
		
		//查看 
		function viewAgent(agent_id){
			$("#ViewAgent").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "查看详情",
		        actions: ["Close"],
		        content: '<%=basePath%>sysAgent/toView.do?agent_id='+agent_id,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		//修改
		function edit(agent_id){
			$("#EditAgent").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "编辑分包商",
		        actions: ["Close"],
		        content: '<%=basePath%>sysAgent/toContractorEdit.do?agent_id='+agent_id,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		//批量操作
		function makeAll(){
			var str = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++){
			  if(document.getElementsByName('ids')[i].checked){
			  	if(str=='') str += document.getElementsByName('ids')[i].value;
			  	else str += ',' + document.getElementsByName('ids')[i].value;
			  }
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
			}else{
				swal({
	                title: "您确定要删除选中的数据吗？",
	                text: "删除后将无法恢复，请谨慎操作！",
	                type: "warning",
	                showCancelButton: true,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "删除",
	                cancelButtonText: "取消",
	                closeOnConfirm: false,
	                closeOnCancel: false
	            }).then(function (isConfirm) {
	                if (isConfirm) {
	                	$.ajax({
							type: "POST",
							url: '<%=basePath%>sysAgent/delAll.do',
					    	data: {DATA_IDS:str},
							dataType:'json',
							cache: false,
							success: function(data){
								$.each(data.list, function(i, list){
									if(list.msg=='ok'){
										swal({   
		        				        	title: "删除成功！",
		        				        	text: "您已经成功删除了这条信息。",
		        				        	type: "success",  
		        				        	 }).then(function(){   
	        				        		 	refreshCurrentTab(); 
	        				        	 	});
			    					}else{
			    						swal("删除失败", "您的删除操作失败了！", "error");
			    					}
							 	});
								
							}
						});
	                } else {
	                    swal("已取消", "您取消了删除操作！", "error");
	                }
	            });
				
				
				
				
				
				
				
			}
		}
		
		//查看历史
		 function viewHistory(agent_instance_id){
			 $("#viewHistory").kendoWindow({
				 width: "900px",
				 height: "500px",
				 title: "查看历史记录",
				 actions: ["Close"],
				 content: '<%=basePath%>workflow/goViewHistory?pid='+agent_instance_id,
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").center().open();
		 }
		
		
		 
		 //重新申请代理商
		 function restartAgent(task_id,agent_id){

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
					 var url = "<%=basePath%>sysAgent/restartAgent.do?task_id="+task_id+"&agent_id="+agent_id+"&tm="+new Date().getTime();
					 $.get(url, function (data) {
						 console.log(data.msg);
						 if (data.msg == "success") {
							 swal({
								 title: "重新提交成功！",
								 text: "您已经成功重新提交了该代理商审核。",
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
		 
		//重新申请分包商
		 function restartContractor(task_id2,agent_id){

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
					 var url = "<%=basePath%>sysAgent/restartContractor.do?task_id2="+task_id2+"&agent_id="+agent_id+"&tm="+new Date().getTime();
					 $.get(url, function (data) {
						 console.log(data.msg);
						 if (data.msg == "success") {
							 swal({
								 title: "重新提交成功！",
								 text: "您已经成功重新提交了该分包商审核。",
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
		
		//导出到Excel
			function toExcel(){
				$.post("<%=basePath%>sysAgent/toExcel.do");
			}

			//选择导入文件
			function inputFile(){
				$("#importFile").click();
			}

			//导入Excel
			function importExcel(e){
		    	var filePath = $(e).val();
		    	console.log(filePath);
		    	var suffix = filePath.substring(filePath.lastIndexOf(".")).toLowerCase();
		    	var fileType = ".xls|.xlsx|";
		    	if(filePath == null || filePath == ""){
		            return false;
		        }
		        if(fileType.indexOf(suffix+"|")==-1){
		            var ErrMsg = "该文件类型不允许上传。请上传 "+fileType+" 类型的文件，当前文件类型为"+suffix; 
		            $(e).val("");
		            alert(ErrMsg);
		            return false;
		        }
		        var data = new FormData();
		    	data.append("file", $(e)[0].files[0]);
		    	console.log($(e)[0].files[0]);
		    	$.ajax({
		            url:"<%=basePath%>sysAgent/importExcel.do",
		            type:"POST",
		            data:data,
		            cache: false,
		            processData:false,
		            contentType:false,
		            success:function(result){
		                if(result.msg=="success"){
		                	alert("导入成功!");
		                }else if(result.msg2=="error")
		                {
		            		 swal({
			                    	title:"导入失败!",
			                    	text:"导入数据失败,"+result.error,
			                    	type:"error"
			                    },
								 function(){
									 refreshCurrentTab();
								 });
		                }else{
		                    alert(result.errorMsg);
		                }
		            }
		        });
			}
		 
			// 下载文件   e代表当前路径值 
			function downFile() {
				var url="uploadFiles/file/DataModel/Agent/分包商.xls";
				var name = window.encodeURI(window.encodeURI(url));
				window.open("customer/DataModel?url=" + name,"_blank");
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
		</script>
</body>
</html>


