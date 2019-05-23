﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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
		<div id="ImportExcel" class="animated fadeIn"></div>
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div id="top" ,name="top"></div>
						<form role="form" class="form-inline" action="production/productionOne.do"
							method="post" name="shopForm" id="shopForm">
							<div class="form-group ">
								<input class="form-control" id="item_name" type="text"
									name="item_name" value="${pd.item_name}" placeholder="这里输入项目名称">
							</div>
							<div class="form-group">
								<button type="submit" class="btn  btn-primary"
									style="margin-bottom: 0px;" title="搜索">
									<i style="font-size: 18px;" class="fa fa-search"></i>
								</button>
							</div>
							<button style="margin-left:810px;" class="btn  btn-success" 
							       title="特批排产"  type="button" onclick="special();">特批排产
							</button>
							<button class="btn  btn-success" title="刷新" type="button"
								style="float: right" onclick="refreshCurrentTab();">刷新
							</button>
						</form>
						<div class="row">
							</br>
						</div>
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										    <th style="width:3%;">序号</th>
	                                        <th style="width:5%;">所属项目编号</th>
	                                        <th style="width:10%;">所属项目名称</th>
	                                        <th style="width:10%;">电梯工号</th>
	                                        <th style="width:10%;">电梯类型</th>
	                                        <th style="width:10%;">电梯产品线</th>
	                                        <th style="width:10%;">电梯单价</th>
	                                        <th style="width:10%;">流程状态</th>                                    
	                                        <th style="width:15%;">操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty productionList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${productionList}" var="var" varStatus="vs">
													<tr>
														<td class='center' style="width: 30px;">${vs.index+1}</td>
														<td>${var.con_item_no}</td>
														<td>${var.item_name}</td>
														<td>${var.no}</td>
														<td>${var.elevator_name}</td>
														<td>${var.product_name}</td>
														<td>${var.total}</td>
														<td>
														    <c:if test="${var.approval eq null || var.con_approval eq ''}">未创建流程</c:if>
															<c:if test="${var.approval eq 0 }">待启动</c:if>
															<c:if test="${var.approval eq 1 }">审核中</c:if>
															<c:if test="${var.approval eq 2 }">已完成</c:if>
															<c:if test="${var.approval eq 3 }">已取消</c:if>
															<c:if test="${var.approval eq 4 }">被驳回</c:if>
														</td>
														<td>
														    <c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
															</c:if>  
														       <!-- 未创建排产 -->
															   <c:if test="${var.approval eq null || var.con_approval eq ''}">
																   <button class="btn  btn-success btn-sm" title="查看项目" type="button" onclick="edit('${var.item_id}','sel');">查看项目</button>
																   <button class="btn  btn-warning btn-sm" title="创建一排" type="button" onclick="add('${var.con_item_no}','${var.item_name}','${var.no}','${var.item_id}','${var.elevator_id}')">创建一排</button>
															   </c:if>
														       <!-- 待提交 -->
															   <c:if test="${var.approval eq 0}">
															       <button class="btn  btn-success btn-sm" title="查看项目" type="button" onclick="edit('${var.item_id}','sel');">查看项目</button>
																   <button class="btn  btn-warning btn-sm" title="提交流程" type="button" onclick="startLeave('${var.pro_no}','${var.production_key}');">提交流程</button>
																   <button class="btn  btn-primary btn-sm" title="编辑一排" type="button" onclick="editShop('${var.pro_no}');">编辑一排</button>
															   </c:if>
															   <!-- 已提交  审核中-->
															   <c:if test="${var.approval eq 1 ||var.approval eq 2}">
															       <button class="btn  btn-success btn-sm" title="查看项目" type="button" onclick="edit('${var.item_id}','sel');">查看项目</button>
																   <button class="btn btn-sm btn-info btn-sm" title="审核记录" type="button"
																		onclick="viewHistory('${var.production_key}');">审核记录</button>
															   </c:if>
															   <!-- 被驳回-->
																<c:if test="${var.approval eq 4}">
																	<c:if test="${QX.cha == 1 }">
																	    <button class="btn  btn-success btn-sm" title="查看项目" type="button" onclick="edit('${var.item_id}','sel');">查看项目</button>
																	    <button class="btn  btn-primary btn-sm" title="编辑一排" type="button" onclick="editShop('${var.pro_no}');">编辑一排</button>
																	    <button class="btn  btn-warning btn-sm" title="重新申请" type="button" onclick="restartAgent('${var.task_id}','${var.pro_no}');">重新申请</button>
																	</c:if>
																</c:if>
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
												<td colspan="100" class="center">没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
							<div class="col-lg-12" style="padding-left: 0px; padding-right: 0px">
								<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>production/toExcel.do">导出</a>
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
	<!--返回顶部开始-->
	<div id="back-to-top">
		<a class="btn btn-warning btn-back-to-top"
			href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
			<i class="fa fa-chevron-up"></i>
		</a>
	</div>
	<!--返回顶部结束-->
	<!-- Fancy box -->
	<script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
	<script src="static/js/iCheck/icheck.min.js"></script>
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
    });
    /* checkbox全选 */
    $("#zcheckbox").on('ifChecked', function (event) {

        $('input').iCheck('check');
    });
    /* checkbox取消全选 */
    $("#zcheckbox").on('ifUnchecked', function (event) {

        $('input').iCheck('uncheck');
    });

    //刷新iframe
    function refreshCurrentTab() {
        $("#shopForm").submit();
    }
    //检索
    function search() {
        $("#shopForm").submit();
    }
  //打开特批排产页面
	function special(){
		$("#EditItem").kendoWindow({
	        width: "1000px",
	        height: "800px",
	        title: "项目信息",
	        actions: ["Close"],
	        content: '<%=basePath%>production/special.do',
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
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
	//创建一排单
    function add(con_item_no,item_name,no,item_id,elevator_id) {
        $("#EditItem").kendoWindow({
            width: "800px",
            height: "400px",
            title: "创建一排单",
            actions: ["Close"],
            content: '<%=basePath%>production/goAddS.do?con_item_no='+con_item_no+'&item_name='+item_name+'&no='+no+'&item_id='+item_id+'&elevator_id='+elevator_id,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").center().open();
    }
    //修改一排信息
    function editShop(pro_no) {
        $("#EditItem").kendoWindow({
            width: "800px",
            height: "400px",
            title: "编辑合同信息",
            actions: ["Close"],
            content: '<%=basePath%>production/goEditS.do?pro_no=' + pro_no,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").center().open();
    }
  //启动流程
	function startLeave(pro_no,production_key){
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
				var url = "<%=basePath%>production/apply.do?pro_no="+pro_no+'&production_key='+production_key;
				$.get(url, function (data) {
					console.log(data.msg);
					if (data.msg == "success") {
						swal({
							title: "启动成功！",
							text: "您已经成功启动该流程。\n该流程实例ID为："+production_key+",下一个任务为："+data.task_name,
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
  	//重新提交审核
	 function restartAgent(task_id,pro_no){
		 swal({
			 title: "您确定要重新提交吗？",
			 text: "重新提交将会再次启动流程！",
			 type: "warning",
			 showCancelButton: true,
			 confirmButtonColor: "#DD6B55",
			 confirmButtonText: "重新提交",
			 cancelButtonText: "取消",
			 closeOnConfirm: false,
	         closeOnCancel: false
	        }).then(function (isConfirm) {
			 if (isConfirm == true) {
				 var url = "<%=basePath%>production/restartAgent.do?task_id="+task_id+"&pro_no="+pro_no+"&tm="+new Date().getTime();
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
			$.post("<%=basePath%>production/toExcel.do");
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
	            url:"<%=basePath%>production/importExcel.do",
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
	            }
	        });
		}
  	
  	
		// 下载文件   e代表当前路径值 
		function downFile() {
			var url="uploadFiles/file/DataModel/Production/一排排产信息.xls";
			var name = window.encodeURI(window.encodeURI(url));
			window.open("customer/DataModel?url=" + name,"_blank");
		}
		
    /* back to top */
    function setWindowScrollTop(win, topHeight)
    {
        if (win.document.documentElement) {
            win.document.documentElement.scrollTop = topHeight;
        }
        if (win.document.body) {
            win.document.body.scrollTop = topHeight;
        }
    }
</script>
</body>
</html>


