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
     	$("#CustomerVisitForm").submit();
     }
		//检索
		function search(){
			$("#CustomerVisitForm").submit();
		}
	//新增
	function add(){
		var id=$("#add_customer_id").val();
		var name = $("#add_customer_name").val();
		var type = $("#add_customer_type").val();
		var goway = $("#goway").val();
		$("#EditCustomerVisit").kendoWindow({
	        width: "900px",
	        height: "510px",
	        title: "新增拜访信息",
	        actions: ["Close"],
	        content: '<%=basePath%>customer/goAddCustomerVisit.do?add_customer_id='+id+"&add_customer_type="+type+'&add_customer_name='+name+'&goway='+goway,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").center().open();
	}
	//修改
	function edit(id,name,type,customerId){
		$("#EditCustomerVisit").kendoWindow({
	        width: "1000px",
	        height: "800px",
	        title: "编辑拜访信息",
	        actions: ["Close"],
	        content: '<%=basePath%>customer/goEditCustomerVisit.do?visit_id='+id+"&visit_customer_type="+type+"&visit_customer_name="+name+"&customer_id="+customerId,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").center().open();
	}
	//删除
	function del(id){
            swal({
                    title: "您确定要删除此条拜访记录吗？",
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
                    	var url = "<%=basePath%>customer/delCustomerVisit.do?visit_id="+id+"&tm="+new Date().getTime();;
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
						url: '<%=basePath%>customer/delAllCustomerVisit.do',
				    	data: {visit_ids:str},
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

	/*------------------导入导出---------------------*/


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
	            url:"<%=basePath%>customer/importExcelVisit.do",
	            type:"POST",
	            data:data,
	            cache: false,
	            processData:false,
	            contentType:false,
	            success:function(result){
	            	if(result.msg=="success"){
	                	swal({
	                		title:"导入成功!",
	                		text:"导入数据成功。",
	                		type:"success"
	                	},
						 function(){
							 refreshCurrentTab();
						 });
	                }else{
	                	 swal({
		                    	title:"导入失败!",
		                    	text:"导入数据失败,"+result.errorMsg,
		                    	type:"error"
		                    },
							 function(){
								 refreshCurrentTab();
							 });
	                }
	            }
	        });
		}
	</script>
</head>

<body class="gray-bg" >
	<div id="EditCustomerVisit" class="animated fadeIn"></div>
    <div class="wrapper wrapper-content">
        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top",name="top"></div>
	                    	<input type="hidden" name="add_customer_id" id="add_customer_id" value="${add_customer_id }"/>
	                    	<input type="hidden" name="add_customer_type" id="add_customer_type" value="${add_customer_type }"/>
	                    	<input type="hidden" name="goway" id="goway" value="${goway }"/>
	                    	<input type="hidden" name="add_customer_name" id="add_customer_name" value="${add_customer_name }"/>
	                       <form role="form" class="form-inline" action="customer/visitCustomer.do" method="post" name="CustomerVisitForm" id="CustomerVisitForm">
	                            <div class="form-group form-inline ">
	                                <input type="text" name="search_visit_id"  id="search_visit_id"  value="${pd.search_visit_id}" placeholder="这里输入拜访编号" class="form-control">
			                    	<input type="hidden" name="customer_id" id="customer_id" value="${add_customer_id }"/>
			                    	<input type="hidden" name="customer_name" id="customer_name" value="${add_customer_name }"/>
			                    	<input type="hidden" name="customer_type" id="customer_type" value="${add_customer_type }"/>
	                            </div>
	                            <div class="form-group form-inline">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div>
	                        	<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;margin-left: 752px" onclick="refreshCurrentTab();">刷新</button>
	                        </form>
	                        <div class="table-responsive">
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
	                                        <th style="width:10%;">拜访编号</th>
	                                        <th style="width:10%;">拜访客户</th>
	                                        <th style="width:10%;">拜访时间</th>
	                                        <th style="width:20%;">拜访目的</th>
	                                        <th style="width:20%;">拜访反馈</th>
	                                        <th style="width:15%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty customerVisitList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${customerVisitList}" var="var" >
													<tr>
														<td><input type="checkbox" class="i-checks" name='ids' id='${var.visit_id }' value='${var.visit_id }' ></td>
														<td>${var.visit_id}</td>
														<td>${var.customer_name}</td>
														<td>${var.visit_date}</td>
														<td>${var.visit_aims }</td>
														<td>${var.visit_feedback }</td>
														<td>
															<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
															</c:if>
															<div>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn btn-sm btn-primary btn-sm" title="编辑" type="button" onclick="edit('${var.visit_id}','${var.customer_name }','${var.visit_customer_type}','${var.visit_customer_id }');">编辑</button>
																</c:if>
																<c:if test="${QX.del == 1 }">
																	<button class="btn btn-sm btn-danger btn-sm" title="删除" type="button" onclick="del('${var.visit_id}')">删除</button>
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
										<button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button>
									</c:if>
									<c:if test="${QX.del == 1 }">
										<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>						
									</c:if>
									<a class="btn btn-warning btn-outline" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>customer/toExcelVisit.do?customer_id=${add_customer_id}">导出</a>
									<!-- <button class="btn btn-warning" title="导出到Excel" type="button" onclick="toExcel()">导出</button> -->
									<button class="btn btn-info btn-outline" title="导入到Excel" type="button" onclick="inputFile()">导入</button>
									<input style="display: none" class="form-control" type="file"  title="导入" id="importFile" onchange="importExcel(this)"/>
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
</body>

</html>
