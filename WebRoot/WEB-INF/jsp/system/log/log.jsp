<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
        <div id="AddLog" class="animated fadeIn"></div>
        <div id="EditLog" class="animated fadeIn"></div>
        <div id="ViewLog" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top",name="top"></div>
	                        <form role="form" class="form-inline" action="sysLog/logList.do" method="post" name="menuForm" id="menuForm">
	                            <div class="form-group ">
	                                <input type="text" name="log_title" value="${log_title}" placeholder="这里输入菜单路径" class="form-control">
	                                 <input type="text" name="log_create_by" value="${log_create_by}" placeholder="这里输入操作人" class="form-control">
	                                 <input type="text" name="log_create_role" value="${log_create_role}" placeholder="这里输入操作人角色" class="form-control">
	                                 <select  name="log_type">
	                                 	<option value="">请选择类型</option>
	                                 	<option value="add" <c:if test="${log_type eq 'add' }">selected</c:if> >添加</option>
	                                 	<option value="edit" <c:if test="${log_type eq 'edit' }">selected</c:if> >修改</option>
	                                 	<option value="delete" <c:if test="${log_type eq 'delete' }">selected</c:if> >删除</option>
	                                 </select>
	                            </div>
	                           
	                            <div class="form-group">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div>
	                            <button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab();">刷新</button>
	                        </form>
	                            <div class="row">
	                            </br>
	                             </div>
	                        <div class="table-responsive" >
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                   		
	                                        <th style="width:5%;">序号</th>
	                                        <th style="width:15%;">菜单路径</th>
	                                        <th style="width:8%;">类型</th>
	                                        <th style="width:12%;">操作ID</th>
	                                        <th style="width:12%;">操作信息</th>
	                                        <th style="width:10%;">操作人</th>
	                                        <th style="width:10%;">操作人角色</th>
	                                        <th style="width:10%;">操作时间</th>
	                                        <th style="width:10%;">请求URI</th>
	                                        <th style="width:10%;">操作IP地址</th>
	                                        <th style="width:10%;">浏览器</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty logList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${logList}" var="var" varStatus="vs">
													<tr id="${var.autoid }">
														
														
														<td>${vs.index+1}</td>
														<td>${var.title}</td>
														<td>
															<c:if test="${var.type eq 'add'}">添加</c:if>
															<c:if test="${var.type eq 'edit'}">修改</c:if>
															<c:if test="${var.type eq 'delete'}">删除</c:if>
														</td>
														<td style="width:12%;">${var.loggingId }</td>
														<td style="width:12%;"> <c:if test="${fn:length(var.logging)>200}"> ${fn:substring(var.logging, 0, 200)} ...</c:if><c:if test="${fn:length(var.logging)<=200}">${var.logging}
										                  </c:if>
														</td>
														<td>${var.create_by }</td>
														<td>${var.create_role }</td>
														<td>
															<fmt:formatDate value="${var.create_date }" pattern="yyyy-MM-dd HH:mm:ss" />
														</td>
														<td>${var.request_uri }</td>
														<td>${var.remote_addr }</td>
														
														<td>${var.user_agent }</td>
														<!--  
														<td>
															<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
															</c:if>
															<div>
																<c:if test="${QX.cha == 1 }">
																<button class="btn  btn-success btn-sm" title="查看" type="button" onclick="viewLog('${var.log_no }');" >查看</button>
																</c:if>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn  btn-primary btn-sm" title="编辑" type="button"onclick="edit('${var.log_no }');">编辑</button>
																</c:if>
																<c:if test="${QX.del == 1 }">
																	<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="del('${var.log_no }','${var.log_name }');">删除</button>
																</c:if>
															</div>
														</td>
														-->
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
									<!--  
									<c:if test="${QX.add == 1 }">
										<button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button>
									</c:if>
									<c:if test="${QX.del == 1 }">
										<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>						
									</c:if>
									-->
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
			$("#AddLog").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "新增代理商",
		        actions: ["Close"],
		        content: '<%=basePath%>sysLog/toAdd.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		//删除
		function del(log_no,log_name){
                swal({
                        title: "您确定要删除["+log_name+"]吗？",
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
                        	var url = "<%=basePath%>sysLog/del.do?log_no="+log_no+"&guid="+new Date().getTime();
            				$.get(url,function(data){
            					if(data=='success'){
            						swal({   
            				        	title: "删除成功！",
            				        	text: "您已经成功删除了这条信息。",
            				        	type: "success",  
            				        	 }, 
            				        	function(){   
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
		function viewLog(log_no){
			$("#ViewLog").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "查看代理商",
		        actions: ["Close"],
		        content: '<%=basePath%>sysLog/toView.do?log_no='+log_no,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		//修改
		function edit(log_no){
			$("#EditLog").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "编辑代理商",
		        actions: ["Close"],
		        content: '<%=basePath%>sysLog/toEdit.do?log_no='+log_no,
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
	            },
	            function (isConfirm) {
	                if (isConfirm) {
	                	$.ajax({
							type: "POST",
							url: '<%=basePath%>sysLog/delAll.do',
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
		        				        	 }, 
		        				        	function(){   
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


