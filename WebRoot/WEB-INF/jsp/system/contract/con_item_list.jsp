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
    <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div id="EditItem" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <input type="hidden" id="no" name="no" value="${no}">
	                    <div id="top",name="top"></div>
	                        <form role="form" class="form-inline" action="contract/contract.do" method="post" name="ItemForm" id="ItemForm">
	                            <div class="form-group  form-inline ">
	                                <!-- <select style="width:170px" name="search_item_name" id="search_item_name"  class="selectpicker" data-live-search="true">
	                                	<option value="">查询所有</option>
	                                	<c:forEach items="${itemList}" var="var">
	                                		<option value="${var.item_name}">${var.item_name}</option>
	                                	</c:forEach>
	                                </select> -->
	                                <input style="width:170px" type="text" name="search_item_name" id="search_item_name" placeholder="输入项目名称查询"  class="form-control">
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
	                                        <th style="width:3%;">序号</th>
	                                        <th style="width:5%;">项目编号</th>
	                                        <th style="width:10%;">项目名称</th>
	                                        <th style="width:10%;">联系人</th>
	                                        <th style="width:10%;">联系人电话</th>
	                                        <th style="width:10%;">项目状态</th>
	                                        <th style="width:10%;">项目报价</th>
	                                        <th style="width:10%;">流程状态</th>	                                        
	                                        <th style="width:15%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty itemList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${itemList}" var="var" varStatus="vs">
													<tr>
														<td class='center' style="width: 30px;">${vs.index+1}</td>
														<td>${var.item_no}</td>
														<td>${var.item_name}</td>
														<td>${var.order_org_contact==""?"未填":var.order_org_contact}</td>
														<td>${var.order_org_phone==""?"未填":var.order_org_phone}</td>
														<td>
															${var.item_status==""?"未选择":""}
															${var.item_status=="1"?"信息":""}
															${var.item_status=="2"?"报价":""}
															${var.item_status=="3"?"投标":""}
															${var.item_status=="4"?"洽谈":""}
															${var.item_status=="5"?"合同":""}
															${var.item_status=="6"?"中标":""}
															${var.item_status=="7"?"失标":""}
															${var.item_status=="8"?"取消":""}
															${var.item_status=="9"?"生效":""}
														</td>
														<td>${var.item_total}</td>
														<td>
															<c:if test="${var.con_approval eq 0 }">待启动</c:if>
															<c:if test="${var.con_approval eq 1 }">审核中</c:if>
															<c:if test="${var.con_approval eq 2 }">已完成</c:if>
															<c:if test="${var.con_approval eq 3 }">已取消</c:if>
															<c:if test="${var.con_approval eq 4 }">被驳回</c:if>
														</td>
														<td>
															<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
															</c:if>
															<div>
															<!-- 未创建合同 -->
															   <c:if test="${var.con_approval eq null || var.con_approval eq ''}">
																   <button class="btn  btn-success btn-sm" title="查看项目" type="button" onclick="edit('${var.item_id}','sel');">查看项目</button>
																   <button class="btn  btn-warning btn-sm" title="创建合同" type="button" onclick="add('${var.item_name}','${var.item_total}','${var.item_no}')">创建合同</button>
															   </c:if>
														    <!-- 待提交 -->
															 <c:if test="${var.con_approval eq 0}">
															        <button class="btn  btn-success btn-sm" title="查看项目" type="button" onclick="edit('${var.item_id}','sel');">查看项目</button>
																	<button class="btn  btn-warning btn-sm" title="提交合同" type="button" onclick="startLeave('${var.con_id}','${var.con_process_key}','${var.con_special_key}');">提交流程</button>
																	<button class="btn  btn-primary btn-sm" title="编辑合同" type="button" onclick="editShop('${var.con_id}');">编辑合同</button>
															</c:if>
															 <!-- 待审核 -->
															<c:if test="${var.con_approval eq 1}">
																<c:if test="${QX.edit == 1 }">
																    <button class="btn  btn-success btn-sm" title="查看项目" type="button" onclick="edit('${var.item_id}','sel');">查看项目</button>
																	<button class="btn  btn-success btn-sm" title="查看合同" type="button" onclick="viewAgent('${var.con_id }');" >查看合同</button>
																</c:if>
																   <!-- 审核记录 -->
															        <c:if test="${var.con_process_key!=null && var.con_process_key!=''}">
																	<button class="btn btn-sm btn-info btn-sm" title="审核记录" type="button"
																		onclick="viewHistory1('${var.con_process_key}');">常规记录
																	</button>
																</c:if>
																<c:if test="${var.con_special_key!=null && var.con_special_key!=''}">
																	<button class="btn btn-sm btn-info btn-sm" title="审核记录" type="button"
																		onclick="viewHistory('${var.con_special_key}');">特种记录
																	</button>
																</c:if>
															</c:if>
															 <!-- 审核中-->
															<c:if test="${var.con_approval eq 2}">
																<c:if test="${QX.edit == 1 }">
																    <button class="btn  btn-success btn-sm" title="查看项目" type="button" onclick="edit('${var.item_id}','sel');">查看项目</button>
																	<button class="btn  btn-success btn-sm" title="查看合同" type="button" onclick="viewAgent('${var.con_id }');" >查看合同</button>
																</c:if>
																<c:if test="${QX.edit == 1 }">
																	 <!-- 审核记录 -->
															        <c:if test="${var.con_process_key!=null || var.con_process_key!=''}">
																	<button class="btn btn-sm btn-info btn-sm" title="审核记录" type="button"
																		onclick="viewHistory1('${var.con_process_key}');">常规记录
																	</button>
																</c:if>
																<c:if test="${var.con_special_key!=null || var.con_special_key!=''}">
																	<button class="btn btn-sm btn-info btn-sm" title="审核记录" type="button"
																		onclick="viewHistory('${var.con_special_key}');">特种记录
																	</button>
																</c:if>
																</c:if>
																<!-- 打印 -->
																<c:if test="${var.con_approval eq 2 }">
																    <button class="btn  btn-danger btn-sm" onclick="download('${var.con_id}')" title="下载" type="button">下载</button>
																</c:if>
															</c:if>
															<!-- 被驳回-->
																<c:if test="${var.con_approval eq 4}">
																	<c:if test="${QX.cha == 1 }">
																	    <button class="btn btn-sm btn-info btn-sm" title="查看项目" type="button" onclick="edit('${var.item_id}','sel');">查看项目</button>
																	    <button class="btn  btn-primary btn-sm" title="编辑合同" type="button"onclick="editShop('${var.con_id }');">编辑合同</button>
																	    <button class="btn  btn-warning btn-sm" title="重新申请" type="button" onclick="restartAgent('${var.task_id}','${var.task_id1}','${var.con_id }');">重新申请</button>
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
								<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>contract/toExcel.do">导出</a>
									<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile()">导入</button>
									<input style="display: none" class="form-control" type="file"  title="导入" id="importFile" onchange="importExcel(this)"/>
										<button class="btn  btn-success" title="下载数据模板" type="button" onclick="downFile()">下载模板</button>
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

        
        
        
        //显示选择合同模版页面
         function download(con_id){
   		 $("#EditItem").kendoWindow({
   			 width: "800px",
   			 height: "400px",
   			 title: "选择合同模版",
   			 actions: ["Close"],
   			 content:"<%=basePath%>contract/Download.do?con_id="+con_id,
   			 modal : true,
   			 visible : false,
   			 resizable : true
   		 }).data("kendoWindow").maximize().open();
   	 } 
        
 		
        
        //查看审核记录
   	 function viewHistory(id){
   		 $("#EditItem").kendoWindow({
   			 width: "900px",
   			 height: "500px",
   			 title: "查看历史记录",
   			 actions: ["Close"],
   			 content:"<%=basePath%>workflow/goViewHistory.do?pid="+id,
   			 modal : true,
   			 visible : false,
   			 resizable : true
   		 }).data("kendoWindow").center().open();
   	 }
   	 //查看审核记录
   	 function viewHistory1(id){
   		 $("#EditItem").kendoWindow({
   			 width: "900px",
   			 height: "500px",
   			 title: "查看历史记录",
   			 actions: ["Close"],
   			 content:"<%=basePath%>workflow/goViewHistory.do?pid="+id,
   			 modal : true,
   			 visible : false,
   			 resizable : true
   		 }).data("kendoWindow").center().open();
   	 }
      //查看 合同详细信息 
    	function viewAgent(con_id){
    		$("#EditItem").kendoWindow({
    	        width: "800px",
    	        height: "800px",
    	        title: "合同信息",
    	        actions: ["Close"],
    	        content: '<%=basePath%>contract/toView.do?con_id='+con_id,
    	        modal : true,
    			visible : false,
    			resizable : true
    	    }).data("kendoWindow").center().open();
    	}
		//查看项目信息
		function edit(id,operateType){
			$("#EditItem").kendoWindow({
		        width: "1000px",
		        height: "800px",
		        title: "编辑项目信息",
		        actions: ["Close"],
		        content: '<%=basePath%>item/goEditItem.do?item_id='+id+'&operateType='+operateType,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		 //修改合同信息
	    function editShop(con_id) {
	        $("#EditItem").kendoWindow({
	            width: "800px",
	            height: "800px",
	            title: "编辑合同信息",
	            actions: ["Close"],
	            content: '<%=basePath%>contract/goEditS.do?con_id=' + con_id,
	            modal: true,
	            visible: false,
	            resizable: true
	        }).data("kendoWindow").center().open();
	    }
		//创建合同
	    function add(item_name,item_total,item_no) {
	        $("#EditItem").kendoWindow({
	            width: "800px",
	            height: "800px",
	            title: "创建合同",
	            actions: ["Close"],
	            content: '<%=basePath%>contract/goAddS.do?item_name='+item_name+'&item_total='+item_total+'&item_no='+item_no,
	            modal: true,
	            visible: false,
	            resizable: true
	        }).data("kendoWindow").center().open();
	    }
	  //启动流程
		function startLeave(con_id,con_process_key,con_special_key){
			swal({
				title: "您确定要启动流程吗？",
				text: "点击确定将会启动该流程，请谨慎操作！",
				type: "warning",
				showCancelButton: true,
				confirmButtonColor: "#DD6B55",
				confirmButtonText: "启动",
				cancelButtonText: "取消",
				closeOnConfirm: false,
	            closeOnCancel: false
		        }).then(function (isConfirm) {
				if (isConfirm)
				{
					var url = "<%=basePath%>contract/apply.do?con_id="+con_id+'&con_process_key='+con_process_key+'&con_special_key='+con_special_key;
					$.get(url, function (data) {
						console.log(data.msg);
						if (data.msg == "success") {
							swal({   
								title: "启动成功！",
								text: "您已经成功启动该流程。\n该流程实例ID为："+con_process_key+",下一个任务为："+data.task_name,
					        	type: "success",  
							    }).then(function(){
								    refreshCurrentTab();
							    });
							
						} else {
							swal("启动失败","error");
						}
					});
				} 
				else if (isConfirm)
				{
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
		//重新提交审核
		 function restartAgent(task_id,task_id1,con_id){
			if(task_id==""||task_id==null)
			{
				task_id="NO";
			}
			if(task_id1==""||task_id1==null)
			{
				task_id1="NO";
			}
			 swal({
				 title: "您确定要重新提交吗？",
				 text: "重新提交将会把数据提交到下一层任务处理者！",
				 type: "warning",
				 showCancelButton: true,
				 confirmButtonColor: "#DD6B55",
				 confirmButtonText: "重新提交",
				 cancelButtonText: "取消",
				 closeOnConfirm: false,
		         closeOnCancel: false
		        }).then(function (isConfirm) {
				 if (isConfirm == true) {
					 var url = "<%=basePath%>contract/restartAgent.do?task_id="+task_id+"&task_id1="+task_id1+"&con_id="+con_id+"&tm="+new Date().getTime();
					 $.get(url, function (data) {
						 console.log(data.msg);
						 if (data.msg == "success") {
							 swal({
								 title: "重新提交成功！",
								 text: "您已经成功重新提交了该流程",
								 type: "success",
							 }).then(function(){
								 refreshCurrentTab();
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
				 } else if (isConfirm == false) {
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
				$.post("<%=basePath%>contract/toExcel.do");
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
		            url:"<%=basePath%>contract/importExcel.do",
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
		                    	text:"错误信息："+result.errorUpload,
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
		                else{
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
      	//刷新iframe
        function refreshCurrentTab() {
        	$("#ItemForm").submit();
        }
		//检索
		function search(){
			$("#ItemForm").submit();
		}
		
		
		// 下载文件   e代表当前路径值 
		function downFile() {
			var url="uploadFiles/file/DataModel/Contract/合同信息.xls";
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


