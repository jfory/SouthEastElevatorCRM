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
        <div id="EditCustomer" class="animated fadeIn"></div>
        <div id="VisitCustomer" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top" name="top"></div>
	                        <form role="form" class="form-inline" action="customer/listAllCustomer.do" method="post" name="CustomerForm" id="CustomerForm">
	                            <div class="form-group  form-inline ">
	                                <input type="text" name="search_customer_name"  id="search_customer_name"  value="${pd.search_customer_name}" placeholder="这里输入客户名称" class="form-control">
	                                <input type="text" name="search_customer_area"  id="search_customer_area"  value="${pd.search_customer_area}" placeholder="这里输入区域" class="form-control">
	                                <input type="text" name="search_customer_sub_company"  id="search_customer_sub_company"  value="${pd.search_customer_sub_company}" placeholder="这里输入分公司" class="form-control">
	                                <input type="text" name="search_user_name"  id="search_user_name"  value="${pd.search_user_name}" placeholder="这里输入录入人" class="form-control">
	                            	<select style="margin-top:16px" class="form-control m-b" name="search_customer_type" id="search_customer_type">
	                            		<option value="" ${pd.search_customer_type==''?'selected':'' }>全部</option>
	                            		<option value="Ordinary" ${pd.search_customer_type=='Ordinary'?'selected':'' }>普通客户</option>
	                            		<%-- <option value="Core" ${pd.search_customer_type=='Core'?'selected':'' }>战略客户</option> --%>
	                            		<option value="Merchant" ${pd.search_customer_type=='Merchant'?'selected':'' }>小业主</option>
	                            	</select>
	                                <%-- <input type="text" name="search_customer_type" id="search_customer_type"   value="${pd.search_customer_type}" placeholder="这里输入客户类别" class="form-control"> --%>
	                            </div>
	                            <div class="form-group form-inline ">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div>
	                            <div class="form-group form-inline " style="margin-top: 5px;margin-left: 10px;">
	                            <c:if test="${QX.add == 1 }">
								<button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button>
								</c:if>
								<%-- <c:if test="${QX.del == 1 }">
									<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>						
								</c:if> --%>
								<input type="button" class="btn btn-outline btn-warning" onclick="toExcelView()" id="toExcel" name="toExcel" value="导出">
								<input type="button" class="btn btn-outline btn-primary" onclick="importExcelView()" id="importExcel" name="importExcel" value="导入">
								<input type="hidden" id="importType" name="importType">
								<input style="display: none" class="form-control" type="file"  title="导入" id="importFile" onchange="importExcel(this)"/>
								<button class="btn  btn-success" id="xiazai" title="下载数据模板" type="button" onclick="downFile()">下载模板</button>
								</div>
	                            <button class="btn  btn-success" title="刷新" type="button" style="margin-top: 15px;float: right" onclick="refreshCurrentTab();">刷新</button>
	                        </form>
	                            <div class="row">
	                            </br>
	                             </div>
	                        <div class="table-responsive">
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
	                                        <th style="width:5%;">客户编号</th>
	                                        <th style="width:10%;">客户名称</th>
	                                        <th style="width:10%;">客户类别</th>
	                                        <th style="width:10%;">联系人</th>
	                                        <th style="width:10%;">联系人电话</th>
	                                        <th style="width:10%;">区域</th>
	                                        <th style="width:10%;">分公司</th>
	                                        <th style="width:10%;">录入人</th>
	                                        <th style="width:15%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty customerList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${customerList}" var="var" >
													<tr>
														<td><input type="checkbox" class="i-checks" name='ids' id='${var.customer_type }_${var.customer_id}' value='${var.customer_type }_${var.customer_id}' ></td>
														<td>${var.customer_no}</td>
														<td>${var.customer_name}</td>
														<td>
															${var.customer_type=='Ordinary'?'普通客户':'' }
															${var.customer_type=='Merchant'?'小业主':'' }
															${var.customer_type=='Core'?'战略客户':'' }
														</td>
														<td>${var.customer_contact}</td>
														<td>${var.contact_phone}</td>
														<td>${var.customer_area_text}</td>
														<td>${var.customer_branch_text}</td>
														<td>${var.user_name}</td>
														<td>
															<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
															</c:if>
															<div>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn btn-sm btn-info btn-sm" title="查看" type="button" onclick="edit('${var.customer_id}','${var.customer_type}','sel');">查看</button>
																</c:if>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn btn-sm btn-primary btn-sm" title="编辑" type="button" onclick="edit('${var.customer_id}','${var.customer_type}','edit');">编辑</button>
																</c:if>
																<c:if test="${QX.del == 1 }">
																	<button class="btn btn-sm btn-danger btn-sm" title="删除" type="button" onclick="del('${var.customer_id}','${var.customer_type}','${var.customer_name}');">删除</button>
																</c:if>
																<!-- <button class="btn btn-sm btn-success btn-sm" title="拜访记录" type="button" onclick="visit('${var.customer_id}','${var.customer_type}','${var.customer_name }');">拜访记录</button> -->
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
									<%-- <c:if test="${QX.add == 1 }">
										<button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button>
									</c:if>
									<c:if test="${QX.del == 1 }">
										<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>						
									</c:if>
										<input type="button" class="btn btn-outline btn-warning" onclick="toExcelView()" id="toExcel" name="toExcel" value="导出">
										<input type="button" class="btn btn-outline btn-primary" onclick="importExcelView()" id="importExcel" name="importExcel" value="导入">
										<!-- <a class="btn btn-warning" title="导出到Excel" type="button" onclick="toExcel(this)" id="toExcel">导出</a> -->
										<!-- <a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>customer/toExcelOrdinary.do">导出普通客户</a>
										<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>customer/toExcelMerchant.do">导出小业主</a>
										<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>customer/toExcelCore.do">导出战略客户</a>
										<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile()">导入</button> -->
										<input type="hidden" id="importType" name="importType">
										<input style="display: none" class="form-control" type="file"  title="导入" id="importFile" onchange="importExcel(this)"/>
										<button class="btn  btn-success" id="xiazai" title="下载数据模板" type="button" onclick="downFile()">下载模板</button> --%>
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
        <div class="ibox float-e-margins" id="toExcelContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
			<div class="ibox-content">
				<div>
					<h5><a target="_blank" href="<%=basePath%>customer/toExcelOrdinary.do">普通客户</a></h5><br>
					<h5><a target="_blank" href="<%=basePath%>customer/toExcelMerchant.do">小业主/开发商</a></h5><br>
					<!-- <h5><a target="_blank" href="<%=basePath%>customer/toExcelCore.do">战略客户</a></h5><br> -->
				</div>
			</div>
		</div>
		<div class="ibox float-e-margins" id="importExcelContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
			<div class="ibox-content">
				<div>
					<h5><a href="javascript:inputFile('ordinary')">普通客户</a></h5><br>
					<h5><a href="javascript:inputFile('merchant')">小业主/开发商</a></h5><br>
					<!-- <h5><a href="javascript:inputFile('core')">战略客户</a></h5><br> -->
				</div>
			</div>
		</div>
		
		<!-- 下载客户数据模板 -->
		<div class="ibox float-e-margins" id="Data" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
			<div class="ibox-content">
				<div>
					<h5><a target="_blank" onclick="xiazai1()">普通客户</a></h5><br>
					<h5><a target="_blank" onclick="xiazai2()">小业主/开发商</a></h5><br>
				</div>
			</div>
		</div>
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

            $("body").click(function(event){
				event  =  event  ||  window.event; // 事件 
		        var  target    =  event.target  ||  ev.srcElement; // 获得事件源 
		        var  obj  =  target.getAttribute('id');
		        if(obj!='toExcel'){
					$("#toExcelContent").hide();
		        }
		        if(obj!='importExcel'){
		        	$("#importExcelContent").hide();
		        }
		        if(obj!='xiazai'){
		        	$("#Data").hide();
		        }
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
        	$("#CustomerForm").submit();
        }
		//检索
		function search(){
			$("#CustomerForm").submit();
		}
		//新增
		function add(){
			$("#EditCustomer").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "编辑客户信息",
		        actions: ["Close"],
		        content: '<%=basePath%>customer/goAddCustomer.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		//拜访记录
		function visit(id,type,name){
			$("#VisitCustomer").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "客户拜访记录",
		        actions: ["Close"],
		        content: '<%=basePath%>customer/visitCustomer.do?customer_id='+id+'&customer_type='+type+'&customer_name='+name,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		//删除
		function del(id,type,title){
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
                        	var url = "<%=basePath%>customer/delCustomer.do?customer_id="+id+"&customer_delete_type="+type+"&tm="+new Date().getTime();;
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
		//修改
		function edit(id,type,operateType){
			$("#EditCustomer").kendoWindow({
		        width: "1000px",
		        height: "800px",
		        title: "编辑客户信息",
		        actions: ["Close"],
		        content: '<%=basePath%>customer/goEditCustomer.do?customer_id='+id+"&customer_type="+type+"&operateType="+operateType,
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
							url: '<%=basePath%>customer/delAllCustomer.do',
					    	data: {customer_ids:str},
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

		//弹出导出框
		function toExcelView(){
			var toExcelObj = $("#toExcel");
			var toExcelOffset = $("#toExcel").offset();
			$("#toExcelContent").css({left:(toExcelOffset.left+6) + "px", top:toExcelOffset.top + toExcelObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
		}
		//弹出导入框
		function importExcelView(){
			var importExcelObj = $("#importExcel");
			var importExcelOffset = $("#importExcel").offset();
			$("#importExcelContent").css({left:(importExcelOffset.left+6) + "px", top:importExcelOffset.top + importExcelObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
		}

		//
		function clickToExcel(){

		}

		//选择导入文件
		function inputFile(str){
			$("#importType").val(str);
			$("#importFile").click();
		}

		//导入Excel
		function importExcel(e){
			var url;
			var importType = $("#importType").val();
			if(importType=="ordinary"){
				url = "<%=basePath%>customer/importExcelOrdinary.do";
			}else if(importType=="merchant"){
				url = "<%=basePath%>customer/importExcelMerchant.do";
			}else if(importType=="core"){
				url = "<%=basePath%>customer/importExcelCore.do";
			}
        	var filePath = $(e).val();
        	var suffix = filePath.substring(filePath.lastIndexOf(".")).toLowerCase();
        	var fileType = ".xls|.xlsx|";
        	if(filePath == null || filePath == ""){
	            return false;
	        }
	        if(fileType.indexOf(suffix+"|")==-1){
	            var ErrMsg = "该文件类型不允许上传。请上传 "+fileType+" 类型的文件，当前文件类型为"+suffix; 
	            $(e).val("");
	            return false;
	        }
	        var data = new FormData();
        	data.append("file", $(e)[0].files[0]);
        	console.log($(e)[0].files[0]);
        	$.ajax({
	            url: url,
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
	                }else if(result.msg=="allErr"){
	                    swal({
	                    	title:"导入失败!",
	                    	text:"导入数据失败!"+result.errorUpload,
	                    	type:"error"
	                    },
						 function(){
							 refreshCurrentTab();
						 });
	                }else if(result.msg=="error"){
	                    swal({
	                    	title:"部分数据导入失败!",
	                    	text:"导入数据失败!"+result.errorUpload,
	                    	type:"warning"
	                    },
						 function(){
							 refreshCurrentTab();
						 });
	                }else if(result.msg=="exception"){
	                    swal({
	                    	title:"导入失败!",
	                    	text:"导入数据失败!"+result.errorUpload,
	                    	type:"error"
	                    },
						 function(){
							 refreshCurrentTab();
						 });
	                }
	            }
	        });
		}

		// 下载文件   e代表当前路径值 
		function downFile() {
			$("#Data").show();
			var importExcelObj = $("#xiazai");
			var importExcelOffset = $("#xiazai").offset();
			$("#Data").css({left:(importExcelOffset.left+6) + "px", top:importExcelOffset.top + importExcelObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
		}
		function xiazai1() //普通客户 
		{
			var url="uploadFiles/file/DataModel/Customer/普通客户.xls";
			var name = window.encodeURI(window.encodeURI(url));
			window.open("customer/DataModel?url=" + name,"_blank");
		}
		function xiazai2() {//小业主或开发商
			var url="uploadFiles/file/DataModel/Customer/小业主或开发商.xls";
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

		/*function hideMenu(event){
			event  =  event  ||  window.event; // 事件 
	        var  target    =  event.target  ||  ev.srcElement; // 获得事件源 
	        var  obj  =  target.getAttribute('id');
	        if(obj!='toExcel'){
				$("#toExcelContent").hide();
	        }
	        if(obj!='importExcel'){
	        	$("#importExcelContent").hide();
	        }
		}*/
		</script>
</body>
</html>


