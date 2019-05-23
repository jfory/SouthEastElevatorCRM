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
	<div id="EditInstall" class="animated fadeIn"></div>
	<div id="ReceiveList" class="animated fadeIn"></div>
	<div id="InstallList" class="animated fadeIn"></div>
    <div class="wrapper wrapper-content">
        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top" name="top"></div>
	                       <form role="form" class="form-inline" action="install/installList.do" method="post" name="InstallForm" id="InstallForm">
	                            <div class="form-group form-inline" style="display:none">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div>
	                        	<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;margin-left: 752px" onclick="refreshCurrentTab();">刷新</button>
	                        </form>
	                        <div class="table-responsive">
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
	                                        <th style="width:15%;">项目编号</th>
	                                        <th style="width:15%;">项目名称</th>
	                                        <th style="width:10%;">是否买断</th>
	                                        <th style="width:15%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty installList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${installList}" var="var" >
													<tr>
														<td><input type="checkbox" class="i-checks" name='ids' id='${var.id }' value='${var.id }' ></td>
														<td>${var.item_no}</td>
														<td>${var.item_name}</td>
														<td>${var.buyout=='1'?'是':'否'}</td>
														<td>
															<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
															</c:if>
															<div>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn btn-sm btn-primary btn-sm" title="编辑" type="button" onclick="edit('${var.id}');">编辑</button>
																</c:if>
																<c:if test="${QX.del == 1 }">
																	<button class="btn btn-sm btn-danger btn-sm" title="删除" type="button" onclick="del('${var.id}')">删除</button>
																</c:if>
																<button class="btn btn-sm btn-info btn-sm" title="收货" type="button" onclick="receive('${var.item_id}')">收货</button>
																<button class="btn btn-sm btn-info btn-sm" title="安装" type="button" onclick="install('${var.item_id}')">安装</button>
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
									<c:if test="${QX.add == 1 }">
										<button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button>
									</c:if>
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
     	$("#InstallForm").submit();
     }
	//检索
	function search(){
		$("#InstallForm").submit();
	}
	//收货
	function receive(item_id){
		$("#ReceiveList").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "收货信息",
	        actions: ["Close"],
	        content: '<%=basePath%>install/shipmentsList.do?item_id='+item_id,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}

	//安装
	function install(item_id){
		$("#InstallList").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "安装信息",
	        actions: ["Close"],
	        content: '<%=basePath%>install/installElevatorList.do?item_id='+item_id,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}

	//新增
	function add(){
		$("#EditInstall").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "新增安装信息",
	        actions: ["Close"],
	        content: '<%=basePath%>install/goAddInstall.do',
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}
	//修改
	function edit(id){
		$("#EditInstall").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "编辑安装信息",
	        actions: ["Close"],
	        content: '<%=basePath%>install/goEditInstall.do?id='+id,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}
	//删除
	function del(id){
            swal({
                    title: "您确定要删除此条安装信息吗？",
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
                    	var url = "<%=basePath%>install/delInstall.do?id="+id+"&tm="+new Date().getTime();;
        				$.get(url,function(data){
        					if(data.msg=='success'){
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
						url: '<%=basePath%>install/delAllInstall.do',
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


	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
