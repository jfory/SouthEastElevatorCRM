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

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div id="EditForecast" class="animated fadeIn"></div>
        <div id="historyForecast" class="animated fadeIn"></div>
        <div id="setTopForecast" class="animated fadeIn"></div>
        <input type="hidden" name="active" id="active" value="${active}"/>
	        <div class="row">
				<div class="panel blank-panel">
					<div class="panel-heading">
						<div class="panel-options">
							<ul class="nav nav-tabs">
								<li id="nav-tab-1">
									<a data-toggle="tab" href="#tab-1" onclick="tabChange(1)">
										<i class="fa fa-hourglass"></i>
										我的申请
									</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="panel-body">
						<div class="tab-content">
						<%--我的申请--%>
						<div id="tab-1" class="tab-pane">
							<div class="ibox float-e-margins">
								<div class="ibox-content">
									<form role="form" class="form-inline" action="forecast/listForecast.do" method="post" name="ForecastForm" id="ForecastForm">
			                            <button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;margin-bottom:0px;float: right" onclick="refreshCurrentTab();">刷新</button>
			                        </form>
									<div class="row">
										</br>
									</div>
									<div class="table-responsive">
										<table class="table table-striped table-bordered table-hover">
											<thead>
											<tr>
	                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
	                                        <th style="width:5%;">编号</th>
	                                        <th style="width:10%;">提交人</th>
	                                        <th style="width:10%;">上报状态</th>
	                                        <th style="width:10%;">是否跨区</th>
	                                        <th style="width:10%;">当月总台量</th>
	                                        <th style="width:10%;">月份编号</th>
	                                        <th style="width:15%;">操作</th>
											</tr>
											</thead>
											<tbody>
											<!-- 开始循环 -->
											<c:choose>
												<c:when test="${not empty forecastList}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${forecastList}" var="var" >
															<tr>
																<td><input type="checkbox" class="i-checks" name='ids' id='${var.id}' value='${var.id}' ></td>
																<td>${var.id}</td>
																<td>${var.user_name}</td>
																<td>
																	<c:if test="${var.status==0}">
																		未提交
																	</c:if>
																	<c:if test="${var.status==1}">
																		销售人员提交
																	</c:if>
																	<c:if test="${var.status==2}">
																		分公司经理汇总
																	</c:if>
																	<c:if test="${var.status==3}">
																		分公司经理提交
																	</c:if>
																	<c:if test="${var.status==4}">
																		区域经理汇总
																	</c:if>
																	<c:if test="${var.status==5}">
																		区域经理提交
																	</c:if>
																	<c:if test="${var.status==6}">
																		股份公司审阅
																	</c:if>
																</td>
																<td>${var.more_region==0?'否':'是'}</td>
																<td>${var.now_count}台</td>
																<td>${var.month_no}</td>
																<td>
																	<c:if test="${QX.edit != 1 && QX.del != 1 }">
																		<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																	</c:if>
																	<div>
																		<c:if test="${QX.edit == 1 and var.selFlag == 1}">
																			<button class="btn btn-sm btn-info btn-sm" title="查看" type="button" onclick="edit('${var.id}','sel');">查看</button>
																		</c:if>
																		<c:if test="${QX.edit == 1 and var.editFlag== 1}">
																			<button class="btn btn-sm btn-primary btn-sm" title="编辑" type="button" onclick="edit('${var.id}','edit');">编辑</button>
																		</c:if>
																		<c:if test="${var.setTopFlag == 1}">
																				<button class="btn  btn-success btn-sm" title="标注" type="button" onclick="goSetTop('${var.id}');" >标注</button>
																		</c:if>
																		<c:if test="${var.submitFlag == 1}">
																				<button class="btn  btn-warning btn-sm" title="提交" type="button" onclick="submitForecast('${var.id}');" >提交</button>
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
											<c:if test="${QX.add == 1 && addTextFlag == 1}">
												<button class="btn  btn-primary" title="${addText}" type="button" onclick="add();">${addText}</button>
											</c:if>
											<c:if test="${QX.del == 1 && selHistory == 1}">
												<button class="btn  btn-success" title="查看历史" type="button" onclick="selHistory();">查看历史</button>						
											</c:if>
											<c:if test="${QX.del == 1 }">
												<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>						
											</c:if>
												${page.pageStr}
										</div>
									</div>
									</br>
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
            /*设置tab显示*/
            var activeId = $("#active").val();
            $("#nav-tab-"+activeId).addClass("active");
		 	$("#tab-"+activeId).addClass("active");
        });
        /* checkbox全选 */
        $("#zcheckbox").on('ifChecked', function(event){
        	
        	$('input').iCheck('check');
      	});
        /* checkbox取消全选 */
        $("#zcheckbox").on('ifUnchecked', function(event){
        	
        	$('input').iCheck('uncheck');
      	});

      	//改变tab活动状态
      	function tabChange(id){
            $("#nav-tab-"+id).addClass("active");
		 	$("#tab-"+id).addClass("active");
      	}


      	//新增
      	function add(){
			$("#EditForecast").kendoWindow({
		        width: "1000px",
		        height: "800px",
		        title: "编辑预测",
		        actions: ["Close"],
		        content: '<%=basePath%>forecast/goAddForecast.do?&operateType=add',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
      	}

		//修改/查看
		function edit(id,operateType){
			$("#EditForecast").kendoWindow({
		        width: "1000px",
		        height: "800px",
		        title: "编辑预测",
		        actions: ["Close"],
		        content: '<%=basePath%>forecast/goEditForecast.do?id='+id+'&operateType='+operateType,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}

		//查看历史
		function selHistory(){
			$("#historyForecast").kendoWindow({
		        width: "1000px",
		        height: "800px",
		        title: "编辑预测",
		        actions: ["Close"],
		        content: '<%=basePath%>forecast/selHistory.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
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
	            },
	            function (isConfirm) {
	                if (isConfirm) {
	                	$.ajax({
							type: "POST",
							url: '<%=basePath%>forecast/delAllForecast.do',
					    	data: {ids:str},
							dataType:'json',
							cache: false,
							success: function(data){
								if(data.msg=='success'){
									swal({   
	        				        	title: "删除成功！",
	        				        	text: "您已经成功删除了这些数据。",
	        				        	type: "success",  
	        				        	 }, 
	        				        	function(){   
	        				        		 refreshCurrentTab(); 
	        				        	 });
		    					}else{
		    						swal("删除失败", "您的删除操作失败了！", "error");
		    					}
								
							}
						});
	                } else {
	                    swal("已取消", "您取消了删除操作！", "error");
	                }
	            });
			}
		}


	//提交
	function submitForecast(id){
	 	/*if(confirm("确定要提交此预测信息？")){
			var url = "<%=basePath%>forecast/submitForecast.do?id="+id+"&tm="+new Date().getTime();
				$.get(url, function (data) {
					if (data.msg == "success") {
						alert("success!  提交成功");
						refreshCurrentTab();
					}else if(data.msg=="err"){
						alert("提交失败");
					} else {
						alert("错误");
					}
				});
		}*/

		swal({
            title: "您确定要提交此条预测信息吗？",
            text: "提交后将会提交给上级部门进行汇总！",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "提交",
            cancelButtonText: "取消",
            closeOnConfirm: false,
            closeOnCancel: false
        },
        function (isConfirm) {
            if (isConfirm) {
            	$.ajax({
					type: "POST",
					url: '<%=basePath%>forecast/submitForecast.do',
			    	data: {"id":id},
					dataType:'json',
					cache: false,
					success: function(data){
						if(data.msg=='success'){
							swal({   
    				        	title: "提交成功！",
    				        	text: "您已经成功提交了此条数据。",
    				        	type: "success",  
    				        	 }, 
    				        	function(){   
    				        		 refreshCurrentTab(); 
    				        	 });
    					}else{
    						swal("提交失败", "您的提交操作失败了！", "error");
    					}
						
					}
				});
            } else {
                swal("已取消", "您取消了提交操作！", "error");
            }
        });
	}


	//标注top10项目
	function goSetTop(id){
		$("#setTopForecast").kendoWindow({
			width: "600px",
			height: "300px",
			title: "办理任务",
			actions: ["Close"],
			content: '<%=basePath%>forecast/goSetTop?id='+id,
			modal : true,
			visible : false,
			resizable : true
		}).data("kendoWindow").maximize().open();
	}


  	//刷新iframe
    function refreshCurrentTab() {
    	$("#ForecastForm").submit();
    }
	//检索
	function search(){
		$("#ForecastForm").submit();
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


