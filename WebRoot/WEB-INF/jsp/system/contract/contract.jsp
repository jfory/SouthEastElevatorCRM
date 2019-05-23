<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
		<div id="EditShops" class="animated fadeIn"></div>
		<div id="ImportExcel" class="animated fadeIn"></div>
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div id="top" ,name="top"></div>
						<form role="form" class="form-inline"
							action="contract/contract.do" method="post" name="shopForm"
							id="shopForm">
							<div class="form-group ">
								 <input style="width:170px" type="text" name="search_item_name" id="search_item_name" placeholder="输入项目名称查询"  class="form-control">
							</div>
							<div class="form-group">
								<button type="submit" class="btn  btn-primary "
									style="margin-bottom: 0px;" title="搜索">
									<i style="font-size: 18px;" class="fa fa-search"></i>
								</button>
							</div>
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
	                                        <th style="width:5%;">项目编号</th>
	                                        <th style="width:10%;">项目名称</th>
	                                        <th style="width:10%;">联系人</th>
	                                        <th style="width:10%;">联系人电话</th>
	                                        <th style="width:10%;">项目状态</th>
	                                        <th style="width:10%;">项目报价</th>
	                                        <th style="width:8%;">流程状态</th>	                                        
	                                        <th style="width:10%;">操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty ContractList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${ContractList}" var="cl" varStatus="vs">
													<tr>
														<td class='center' style="width: 30px;">${vs.index+1}</td>
														<td>${cl.item_no}</td>
														<td>${cl.item_name}</td>
														<td>${cl.order_org_contact==""?"未填":cl.order_org_contact}</td>
														<td>${cl.order_org_phone==""?"未填":cl.order_org_phone}</td>
														<td>
															${cl.item_status==""?"未选择":""}
															${cl.item_status=="1"?"信息":""}
															${cl.item_status=="2"?"报价":""}
															${cl.item_status=="3"?"投标":""}
															${cl.item_status=="4"?"洽谈":""}
															${cl.item_status=="5"?"合同":""}
															${cl.item_status=="6"?"中标":""}
															${cl.item_status=="7"?"失标":""}
															${cl.item_status=="8"?"取消":""}
															${cl.item_status=="9"?"生效":""}
														</td>
														<td>${cl.item_total}</td>
														<td>
															<c:if test="${cl.con_approval eq 0 }">待启动</c:if>
															<c:if test="${cl.con_approval eq 1 }">审核中</c:if>
															<c:if test="${cl.con_approval eq 2 }">已完成</c:if>
															<c:if test="${cl.con_approval eq 3 }">已取消</c:if>
															<c:if test="${cl.con_approval eq 4 }">被驳回</c:if>
														</td>
														
														
														<td><c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span
																	class="label label-large label-grey arrowed-in-right arrowed-in">
																	<i class="icon-lock" title="无权限">无权限</i>
																</span>
															</c:if>
															<!-- 待提交 -->
															 <c:if test="${cl.con_approval eq 0}">
																<c:if test="${QX.edit == 1 }">
																	<button class="btn  btn-primary btn-sm" title="提交"
																		type="button"
																		onclick="startLeave('${cl.con_id}','${cl.con_process_key}','${cl.con_special_key}');">提交
																	</button>
																</c:if>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn  btn-primary btn-sm" title="编辑"
																		type="button" onclick="editShop('${cl.con_id}');">编辑
																	</button>
																</c:if>
																<c:choose>
																	<c:when test="${user.USERNAME=='admin'}"></c:when>
																	<c:otherwise>
																		<c:if test="${QX.del == 1 }">
																			<button class="btn  btn-danger btn-sm" title="删除"
																				type="button"
																				onclick="delShop('${cl.con_id}','${cl.con_name}');">删除
																			</button>
																		</c:if>
																	</c:otherwise>
																</c:choose>
															</c:if>
															 <!-- 待审核 -->
															<c:if test="${cl.con_approval eq 1}">
																<c:if test="${QX.edit == 1 }">
																	<button class="btn  btn-success btn-sm" title="查看" type="button" onclick="viewAgent('${cl.con_id }');" >查看</button>
																</c:if>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn  btn-primary btn-sm" title="审核记录" type="button"
																		onclick="viewHistory('${cl.con_special_key}','${cl.con_process_key}');">审核记录
																	</button>
																</c:if>
															</c:if>
															 <!-- 审核中-->
															<c:if test="${cl.con_approval eq 2}">
															 
																<c:if test="${QX.edit == 1 }">
																	<button class="btn  btn-success btn-sm" title="查看" type="button" onclick="viewAgent('${cl.con_id }');" >查看</button>
																</c:if>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn  btn-primary btn-sm" title="审核记录" type="button"
																		onclick="viewHistory('${cl.con_special_key}','${cl.con_process_key}');">审核记录
																	</button>
																</c:if>
															</c:if>
															<!-- 被驳回-->
																<c:if test="${cl.con_approval eq 4}">
																	<c:if test="${QX.cha == 1 }">
																	    <button class="btn  btn-primary btn-sm" title="编辑" type="button"onclick="editShop('${cl.con_id }');">编辑</button>
																	    <button class="btn  btn-warning btn-sm" title="重新申请" type="button" onclick="restartAgent('${cl.task_id}','${cl.con_id }');">重新申请</button>
																	</c:if>
																</c:if>
															</ul>
															</div></td>
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
							<div class="col-lg-12"
								style="padding-left: 0px; padding-right: 0px">
								<c:if test="${QX.add == 1 }">
									<button class="btn  btn-primary" title="新增" type="button"
										onclick="add();">新增</button>
								</c:if>
								<c:if test="${QX.del == 1 }">
									<button class="btn  btn-danger" title="批量删除" type="button"
										onclick="makeAll('del');">批量删除</button>
								</c:if>
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
  //查看 详细信息 
	function viewAgent(con_id){
		$("#EditShops").kendoWindow({
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
    //新增
    function add() {
        $("#EditShops").kendoWindow({
            width: "800px",
            height: "800px",
            title: "新增",
            actions: ["Close"],
            content: '<%=basePath%>contract/goAddS.do',
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").center().open();
    }
   //查看历史
	 function viewHistory(id,id1){
	  var a;
	  if(id!=null && id!="")
	  {
		  a=id;
		  }
	  if(id1!=null && id1!="")
	  {
		  a=id1;
	  }
		 $("#EditShops").kendoWindow({
			 width: "900px",
			 height: "500px",
			 title: "查看历史记录",
			 actions: ["Close"],
			 content:"<%=basePath%>workflow/goViewHistory.do?pid="+a,
			 modal : true,
			 visible : false,
			 resizable : true
		 }).data("kendoWindow").center().open();
	 }
	
    
    //修改
    function editShop(con_id) {
        $("#EditShops").kendoWindow({
            width: "800px",
            height: "800px",
            title: "修改单元信息",
            actions: ["Close"],
            content: '<%=basePath%>contract/goEditS.do?con_id=' + con_id,
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
		},
		function (isConfirm) {
			if (isConfirm) {
				var url = "<%=basePath%>contract/apply.do?con_id="+con_id+'&con_process_key='+con_process_key+'&con_special_key='+con_special_key;
				$.get(url, function (data) {
					console.log(data.msg);
					if (data.msg == "success") {
						swal({   
							title: "启动成功！",
							text: "您已经成功启动该流程。\n该流程实例ID为："+con_process_key+",下一个任务为："+data.task_name,
				        	type: "success",  
				        	 }, 
				        	function(){   
				        		 refreshCurrentTab(); 
				        	 });
					} else {
						swal({
							title: "启动失败！",
							text:  data.err,
							type: "error",
							showConfirmButton: false,
							timer: 1000
						});
					}
				});

			} else if (isConfirm) {
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
   
	
    //删除
    function delShop(con_id,msg) {
        swal({
                    title: "您确定要删除[" + msg + "]吗？",
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
                        var url = "<%=basePath%>contract/delContract.do?con_id=" + con_id + "&tm="
                        		+ new Date().getTime();
                        $.get(url, function (data) {
                            if (data.msg == 'success') {
                            	swal({   
        				        	title: "删除成功！",
        				        	text: "您已经成功删除了这条信息。",
        				        	type: "success",  
        				        	 }, 
        				        	function(){   
        				        		 refreshCurrentTab(); 
        				        	 });
                            } else {
                                swal("删除失败", "您的删除操作失败了！", "error");
                            }
                        });
                    } else {
                        swal("已取消", "您取消了删除操作！", "error");
                    }
                });
    }
    //批量操作
    function makeAll(msg) {
        var str = '';
        var emstr = '';
        var phones = '';
        for (var i = 0; i < document.getElementsByName('ids').length; i++) {
            if (document.getElementsByName('ids')[i].checked) {
                if (str == '') str += document.getElementsByName('ids')[i].value;
                else str += ',' + document.getElementsByName('ids')[i].value;
            }
        }
        if (str == '') {
            swal({
                title: "您未选择任何数据",
                text: "请选择你需要操作的数据！",
                type: "error",
                showCancelButton: false,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "OK",
                closeOnConfirm: true,
                timer: 1500
            });
        } else {
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
                                url: '<%=basePath%>contract/deleteAllS.do',
							data : {
								con_ids : str
							},
							dataType : 'json',
							cache : false,
							success : function(data) {
								if (data.msg == 'success') {
									swal({
										title : "删除成功！",
										text : "您已经成功删除了这些数据",
										type : "success",
									}, function() {
										refreshCurrentTab();
									});
								} else {
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

  //重新提交审核
	 function restartAgent(task_id,con_id){
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
			},
		function (isConfirm) {
			 if (isConfirm == true) {
				 var url = "<%=basePath%>contract/restartAgent.do?task_id="+task_id+"&con_id="+con_id+"&tm="+new Date().getTime();
				 $.get(url, function (data) {
					 console.log(data.msg);
					 if (data.msg == "success") {
						 swal({
							 title: "重新提交成功！",
							 text: "您已经成功重新提交了该流程",
							 type: "success",
						 }, 
						 function(){
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
    
 
		/* back to top */
		function setWindowScrollTop(win, topHeight) {
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


