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
        
	        <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	基础项配置
                                    </div>
                                    <div class="panel-body" >
                                        
                                        
                                        <table class="table table-striped table-bordered table-hover" >
	                                <thead>
	                                    <tr>
	                                        <th style="width:38%;">基础配置名称</th>
	                                        <th style="width:60%;">描述</th>
	                                                                       
	                                        
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty elevatorBaseList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${elevatorBaseList}" var="var" >
													<tr>
														<td>${var.elevator_base_name}</td>
														<td>${var.elevator_base_description}</td>
														
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
                                        
                                        <div class="form-group form-inline">
                                        	<input type="hidden" id="elevator_base_id" name="elevator_base_id" value="${pd.elevator_base_id }">
                                        	<%-- <span style="color: red">*</span>
											<label style="width:6%" >价格:</label>
                                    		<input style="width:25%"  type="text"  placeholder="价格"  id="elevator_base_price" name="elevator_base_price" readonly="readonly" value="${pd.elevator_base_price }"  class="form-control">
                                    		 --%>
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
			$("#AddModels").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "新增型号",
		        actions: ["Close"],
		        content: '<%=basePath%>models/toModelsAdd.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		
		//删除
		function del(models_id,models_name){
                swal({
                        title: "您确定要删除["+models_name+"]吗？",
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
                        	var url = "<%=basePath%>models/modelsDelete.do?models_id="+models_id+"&guid="+new Date().getTime();
            				$.get(url,function(data){
            					if(data=='success'){
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
		function edit(models_id){
			$("#EditModels").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "编辑型号",
		        actions: ["Close"],
		        content: '<%=basePath%>models/toModelsEdit.do?models_id='+models_id,
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
	            }).then(function (isConfirm) {
	                if (isConfirm) {
	                	$.ajax({
							type: "POST",
							url: '<%=basePath%>models/modelsDeleteAll.do',
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


