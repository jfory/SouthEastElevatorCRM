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
        <div id="AddEncasement" class="animated fadeIn"></div>
        <div id="EditEncasement" class="animated fadeIn"></div>
        <div id="ListElevatorDetails" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top",name="top"></div>
	                        <form role="form" class="form-inline" action="encasement/listEncasement.do" method="post" name="EncasementForm" id="EncasementForm">
	                            <div class="form-group  form-inline ">
	                                <!-- <select style="width:170px" name="search_item_name" id="search_item_name"  class="selectpicker" data-live-search="true">
	                                	<option value="">查询所有</option>
	                                	<c:forEach items="${itemList}" var="var">
	                                		<option value="${var.item_name}">${var.item_name}</option>
	                                	</c:forEach>
	                                </select> -->
	                                <input style="width:170px" type="text" name="search_consignee_no" id="search_consignee_no" placeholder="输入编号查询"  class="form-control">
	                            </div>
	                            <div class="form-group form-inline ">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div>
	                            <button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;margin-bottom:0px;float: right" onclick="refreshCurrentTab();">刷新</button>
	                        </form>
	                            <div class="row">
	                            </br>
	                             </div>
	                        <div class="table-responsive">
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                       <th style="width:2%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
	                                        <th style="width:5%;">装箱编号</th>
	                                        <th style="width:5%;">装箱人名称</th>
	                                        <th style="width:15%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty encasementList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${encasementList}" var="var" >
													<tr>
														<td><input type="checkbox" class="i-checks" name='ids' id='${var.encasement_id}' value='${var.encasement_id}' ></td>
														<td>${var.encasement_no}</td>
														<td>${var.encasement_name}</td>
														
														
														<td>
															<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
															</c:if>
															<div>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn btn-sm btn-info btn-sm" title="查看" type="button" onclick="edit('${var.encasement_id}','sel');">查看</button>
																</c:if>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn btn-sm btn-primary btn-sm" title="编辑" type="button" onclick="edit('${pd.elevator_no }','${var.encasement_id}','edit');">编辑</button>
																</c:if>
																<c:if test="${QX.del == 1 }">
																	<button class="btn btn-sm btn-danger btn-sm" title="删除" type="button" onclick="del('${var.encasement_id}','${var.encasement_no}');">删除</button>
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
									<c:if test="${QX.add == 1 }">
										<button class="btn  btn-primary" title="新增" type="button" onclick="add('${pd.elevator_no}');">新增</button>
									</c:if>
									<c:if test="${QX.del == 1 }">
										<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>						
									</c:if>
										${page.pageStr}
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
        });
        /* checkbox全选 */
        $("#zcheckbox").on('ifChecked', function(event){
        	
        	$('input').iCheck('check');
      	});
        /* checkbox取消全选 */
        $("#zcheckbox").on('ifUnchecked', function(event){
        	
        	$('input').iCheck('uncheck');
      	});

      	//新增
		function add(elevator_no){
			$("#AddEncasement").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "新增装箱",
		        actions: ["Close"],
		        content: '<%=basePath%>encasement/goAddEncasement.do?elevator_no='+elevator_no,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}

		//修改/查看
		function edit(encasement_id){
			$("#EditEncasement").kendoWindow({
		        width: "1000px",
		        height: "800px",
		        title: "编辑装箱",
		        actions: ["Close"],
		        content: '<%=basePath%>encasement/goEditEncasement.do?encasement_id='+encasement_id,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		

		//删除
		function del(id,title){
			swal({
                        title: "您确定要删除["+title+"]吗？",
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
                    	if(isConfirm){
                        	var url = "<%=basePath%>encasement/EncasementDelete.do?encasement_id="+id+"&tm="+new Date().getTime();;
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
            			}else{
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
							url: '<%=basePath%>encasement/delAllEncasement.do',
					    	data: {item_ids:str},
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
		function sub(consignee_id){
			swal({
	                title: "您确定将出货单提交到装箱管理吗？",
	                text: "提交后无法编出货单信息，请谨慎操作！",
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
							url: '<%=basePath%>consignee/subBoxManage.do',
					    	data: {consignee_id:consignee_id},
							dataType:'json',
							cache: false,
							success: function(data){
								if(data.msg=='success'){
									swal({   
	        				        	title: "操作成功！",
	        				        	text: "您已经成功提交了这些数据。",
	        				        	type: "success",  
	        				        	 }, 
	        				        	function(){   
	        				        		 refreshCurrentTab(); 
	        				        	 });
		    					}else{
		    						swal("操作失败", "您的提交操作失败了！", "error");
		    					}
								
							}
						});
	                } else {
	                    swal("已取消", "您取消了提交操作！", "error");
	                }
	            });
		}
        
      	//刷新iframe
        function refreshCurrentTab() {
        	$("#EncasementForm").submit();
        }
		//检索
		function search(){
			$("#EncasementForm").submit();
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


