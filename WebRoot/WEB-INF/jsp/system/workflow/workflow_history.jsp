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
        <div id="deployWorkFlow" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top",name="top"></div>
	                        <form role="form" class="form-inline" action="workflow/goViewHistory.do" method="post" name="workflowForm" id="workflowForm">
								<input type="hidden" id="pid" name="pid" value="${pd.pid}">
	                            <button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab();">刷新</button>
	                        </form>
	                            <div class="row">
	                            </br>
	                             </div>
	                        <div class="table-responsive">
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                        <th style="width:3%;">序号</th>
	                                        <th>任务名称</th>
	                                        <th style="width:15%;">签收时间</th>
	                                        <th style="width:15%;">办理时间</th>
	                                        <th style="width:8%;">办理人</th>
	                                        <th style="width:8%;">处理</th>
	                                        <th style="width:35%;">批注</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                               <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty pd.historys}">
											<c:if test="${QX.cha == 1 }">
											<c:forEach items="${pd.historys}" var="history" varStatus="vs">
												<tr>
													<td class='center'>${vs.index+1}</td>
													<td>${history.task_name }
														<c:if test="${not empty history.usejson && history.usejson.length()>2}">
															<i style="float: right" class="fa fa-commenting-o btn-primary btn-outline"
													   onclick='printAudit(${history.usejson})'></i>
														</c:if>
													</td>
													<td>${history.claim_time }</td>
													<td>${history.complete_time}</td>
													<td>${history.user_name}</td>
													<td>${history.action}</td>
													<td>${history.comment}</td>
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
    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
    
	<script type="text/javascript">
	 $(document).ready(function () {
     	/* checkbox */
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
    
    	//刷新iframe
        function refreshCurrentTab() {
        	$("#workflowForm").submit();
        }
		//检索
		function search(){
			$("#workflowForm").submit();
		}
		
		//新增
		function goToDeployWorkFlow(){
			$("#deployWorkFlow").kendoWindow({
		        width: "800px",
		        height: "450px",
		        title: "部署新的流程",
		        actions: ["Close"],
		        content: '<%=basePath%>workflow/goDeployWorkFlow.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		//启动流程
		function startDeployment(deploymentId,msg){
            swal({
                    title: "您确定要启动流程["+msg+"]吗？",
                    text: "点击确定将会启动该流程，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "启动",
                    cancelButtonText: "取消",
                    closeOnConfirm: false,
                    closeOnCancel: false
                },
                function (isConfirm) {
                    if (isConfirm) {
                    	var url = "<%=basePath%>workflow/startDeployment.do?deploymentId="+deploymentId+"&tm="+new Date().getTime();
        				$.get(url,function(data){
        					if(data.msg=='success'){
        						swal({   
        				        	title: "启动成功！",
        				        	text: "您已经成功启动该流程。该流程实例ID为："+data.processInstanceId,
        				        	type: "success",  
        				        	 }, 
        				        	function(){   
        				        		 refreshCurrentTab(); 
        				        	 });
        					}else{
        						swal("启动失败", data.err, "error");
        					}
        				});
                    } else {
                        swal("已取消", "您取消了启动操作！", "error");
                    }
                });
		}
		//删除
		function delDeployment(deploymentId,msg){
            swal({
                    title: "您确定要删除["+msg+"]吗？",
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
                    	var url = "<%=basePath%>workflow/delDeployment.do?deploymentId="+deploymentId+"&tm="+new Date().getTime();
        				$.get(url,function(data){
        					if(data.msg=='success'){
        						swal({   
        				        	title: "删除成功！",
        				        	text: "您已经成功删除了这条数据。",
        				        	type: "success",  
        				        	 }, 
        				        	function(){   
        				        		 refreshCurrentTab(); 
        				        	 });
        					}else{
        						swal("删除失败", data.err, "error");
        					}
        				});
                    } else {
                        swal("已取消", "您取消了删除操作！", "error");
                    }
                });
		}
		//批量操作
		function makeAll(msg){
			var str = '';
			var emstr = '';
			var phones = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
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
							url: '<%=basePath%>workflow/delAllDeployment.do',
					    	data: {deployment_ids:str},
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
		    					}else if(data.msg=='partSuccess'){
		    						swal({   
	        				        	title: "部分删除成功！",
	        				        	text: "您已经成功删除了ID为:"+data.successIds+"的数据，但ID为:"+data.failedIds+"的数据未能成功删除！",
	        				        	type: "success",  
	        				        	 }, 
	        				        	function(){   
	        				        		 refreshCurrentTab(); 
	        				        	 });
		    					}else{
		    						swal("删除失败", data.err, "error");
		    					}
								
							}
						});
	                } else {
	                    swal("已取消", "您取消了删除操作！", "error");
	                }
	            });
			}
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

     function printAudit(jsonstr){
		    if(jsonstr){
		        var phtml='<table class="table table-striped table-bordered table-hover">' +
					'<thead><tr><td>用戶名</td><td>角色</td><td>邮箱</td><td>联系电话</td></tr></thead>';

		        jsonstr.forEach(function (val,index) {
		            if(val.user_id!='1'){
                        phtml+="<tr><td>"+val.user_name+"</td>" +
							"<td>"+val.role_name+"</td>" +
							"<td>"+val.email+"</td>" +
							"<td>"+val.phone+"</td></tr>";
					}
                })
				phtml+='</table>';
                layer.open({
                    type: 1,
                    title: false,
                    closeBtn: 0,
                    shadeClose: true,
                    shade:0.1	,
                    content: phtml,
                    area:'650px'
                });
			}

	 }
		</script>
</body>
</html>


