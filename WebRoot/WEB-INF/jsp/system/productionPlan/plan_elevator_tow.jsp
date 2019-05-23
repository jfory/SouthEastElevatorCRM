<%@ page language="java" contentType="text/html; charset=UTF-8"
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
						<form role="form" class="form-inline" action="productionPlan/addelevatorTow.do"
							method="post" name="shopForm" id="shopForm">
							<%-- <div class="form-group ">
								<input class="form-control" id="item_name" type="text"
									name="item_name" value="${pd.item_name}" placeholder="这里输入项目名称">
							</div>
							<div class="form-group">
								<button type="submit" class="btn  btn-primary "
									style="margin-bottom: 0px;" title="搜索">
									<i style="font-size: 18px;" class="fa fa-search"></i>
								</button>
							</div> --%>
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
									        <th><input type="checkbox" name="zcheckbox"
											id="zcheckbox" class="i-checks"></th>
										    <th>序号</th>
	                                        <th>项目编号</th>
	                                        <th>项目名称</th>
	                                        <th>电梯工号</th>
	                                        <th>电梯种类</th>
	                                        <th>电梯产品线</th>
	                                        <th>电梯单价</th>
	                                        <th>是否是特批电梯</th>                      
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty productionList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${productionList}" var="var" varStatus="vs">
													<tr>
														<td class='center' style="width: 30px;">
														<label>
														<input
																class="i-checks" type='checkbox' name='ids'
																value="${var.elevator_no}" id="${var.elevator_no}"
																alt="${var.elevator_no}" />
																<span class="lbl"></span>
																</label>
																</td>
														<td class='center' style="width: 30px;">${vs.index+1}</td>
														<td>${var.item_no}</td>
														<td>${var.item_name}</td>
														<td>${var.elevator_no}</td>
														<td>${var.elevator_name}</td>
														<td>${var.product_name}</td>
														<td>${var.total}</td>
														<td>
														    <c:if test="${var.special_state eq 0}">否</c:if>
														    <c:if test="${var.special_state eq 1}">是</c:if>
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
							<div class="col-lg-12"
								style="padding-left: 0px; padding-right: 0px">
								<c:if test="${QX.add == 1 }">
									<button class="btn  btn-primary" title="新增" type="button"
										onclick="add('${pd.pro_no}');">添加到排产计划</button>
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
    //跳转到天梯页面
    function addelevator()
    {
    	 $("#EditItem").kendoWindow({
             width: "1000px",
             height: "600px",
             title: "创建排产计划",
             actions: ["Close"],
             content: '<%=basePath%>productionPlan/addelevator.do',
             modal: true,
             visible: false,
             resizable: true
         }).data("kendoWindow").center().open();
    }
	<%-- //创建排产计划
    function add(con_item_no,item_name,no,item_id) {
        $("#EditItem").kendoWindow({
            width: "800px",
            height: "400px",
            title: "创建排产计划",
            actions: ["Close"],
            content: '<%=basePath%>productionPlan/insertPlan.do',
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").center().open();
    } --%>
   //批量操作
    function add(pro_no) {
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
                        title: "您确定要添加选中的电梯到排产计划吗？",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确认",
                        cancelButtonText: "取消",
                        closeOnConfirm: false,
                        closeOnCancel: false
                        }).then(function (isConfirm) {
                        if (isConfirm) {
                        	 $.ajax({
                                 type: "POST",
                                 url: '<%=basePath%>productionPlan/addelevatortow.do?pro_no='+pro_no,
 							data : {
 								stra_nos : str
 							},
 							dataType : 'json',
 							cache : false,
 							success : function(data) {
 								if (data.msg == 'success') {
 									swal({
 										title : "添加成功！",
 										text : "您已经成功添加这些电梯到排产计划！",
 										type : "success",
 									}).then(function() {
 										refreshCurrentTab();
 									});
 								} 
 								else 
 								{
 									swal("添加失败", "您的操作失败了！", "error");
 								}
 							}
 						});      
					} 
                     else
					{
						swal("已取消", "您取消了添加操作！", "error");
					}
				});
			}
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


