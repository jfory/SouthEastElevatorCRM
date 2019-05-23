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
    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div id="zhjView" class="animated fadeIn"></div>
		<!-- 选择项目页面 -->
	    <div id="xinjian" class="animated fadeIn"></div>
	    <!-- 报价录入界面 -->
	    <div id="addOffer" class="animated fadeIn"></div>
	    
    	<div id="ElevatorParam" class="animated fadeIn"></div>
		<div id="viewShops" class="animated fadeIn"></div>
	
		<div id="EditShops" class="animated fadeIn"></div>
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div id="top" ,name="top"></div>
						<form role="form" class="form-inline" action="nonStandrad/nonStandradList.do" method="post" name="shopForm" id="shopForm">
						
							<div class="form-group ">
								<input class="form-control" id="nav-search-input" type="text"
									   name="master_id" value="${pd.master_id}" 
									   placeholder="单号">
								<input class="form-control" type="text" id="nav-search-input"
									type="text" name="item_name" value="${pd.item_name}"
									placeholder="项目名称">
								<input class="form-control" id="nav-search-input" type="text"
									   name="project_area" value="${pd.project_area}"
									   placeholder="区域">
								<input class="form-control" id="nav-search-input" type="text"
									   name="subsidiary_company" value="${pd.subsidiary_company}"
									   placeholder="分公司">
								<input class="form-control" id="nav-search-input" type="text"
									name="user_name" value="${pd.user_name}" 
									placeholder="申请人">
							</div>
							<div class="form-group " style="margin-top: 5px;">
								<input class="form-control" id="nav-search-input" type="text"
									name="lift_name" value="${pd.lift_name}" 
									placeholder="梯形">
								
								<input class="form-control" id="nav-search-input" type="text"
									   name="operate_date_start" value="${pd.operate_date_start}"
                                       onclick="laydate()"
									   placeholder="申请日期开始于">
								- <input class="form-control" id="nav-search-input" type="text"
									   name="operate_date_end" value="${pd.operate_date_end}"
                                       onclick="laydate()"
									   placeholder="申请日期结束于">
								<select class="form-control" id="instance_status" name="instance_status" >
								    <option value="">审核状态</option>
								    <option value="1" ${pd.instance_status=="1"?"selected='selected'":""}>待启动</option>
								    <option value="2" ${pd.instance_status=="2"?"selected='selected'":""}>待审核</option>
								    <option value="3" ${pd.instance_status=="3"?"selected='selected'":""}>审核中</option>
								    <option value="4" ${pd.instance_status=="4"?"selected='selected'":""}>已通过</option>
								    <option value="5" ${pd.instance_status=="5"?"selected='selected'":""}>被驳回</option>
								 </select>
							</div>
							<div class="form-group" style="margin-top: 5px;" >
								<button type="submit" class="btn  btn-primary" title="查询" 
								style="margin-left: 10px; height:32px;margin-top:3px;">查询</button>
								<a class="btn btn-warning btn-outline" style="margin-left: 10px; height:32px;margin-top:3px;" title="导出到Excel" type="button" target="_blank" onclick="toExcel(this);" href="javascript:;">导出</a>
							</div>
							<button class="btn  btn-success" title="刷新" type="button"
								style="float: right;" onclick="refreshCurrentTab();">刷新
							</button>
						</form>
						<form role="form" class="form-inline" action="houseType/cell.do" method="post" name="houseType" id="houseType">
						  <input type="hidden" id="houses_no" name="houses_no" value="${pd.houses_no}"/>
						  <input type="hidden" id="hou_id" name="hou_id" value="${pd.hou_id}"/>
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
										<th style="text-align:center;">单号</th>
										<th style="text-align:center;">项目名称</th>
										<th style="text-align:center;">梯型</th>
                                        <!--<th style="text-align:center;">台数</th>-->
										<th style="text-align:center;">价格</th>
										<th style="text-align:center;">申请人</th>
										<th style="text-align:center;">申请日期</th>
										<th style="text-align:center;">分公司</th>
										<th style="text-align:center;">区域</th>
										<th style="text-align:center;">审核状态</th>
										<th style="text-align:center;">操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty nonstandradList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${nonstandradList}" var="e" varStatus="vs">

													<tr>
														<td class='center' style="width: 30px;">
														<label>
														<input
																class="i-checks" type='checkbox' name='ids'
																value="${e.non_standrad_id}" id="${e.non_standrad_id}"
																alt="${e.non_standrad_id}" />
																<span class="lbl"></span>
																</label>
																</td>
														
														<td style="text-align:center;"> ${e.non_standrad_id}</td>
														<td style="text-align:center;">${e.project_name	}</td>
														<td style="text-align:center;">${e.lift_name}</td>
                                                        <!--<td style="text-align:center;">${e.lift_num}</td>-->
														<td style="text-align:center;"><fmt:formatNumber value="${e.nonstand_price}" pattern="#.#"/></td>
														<td style="text-align:center;">${e.operate_name}</td>
														<td style="text-align:center;">${e.operate_date}</td>
														<td style="text-align:center;">${e.subsidiary_company}</td>
														<td style="text-align:center;">${e.project_area}</td>
														<td style="text-align:center;">
														    ${e.instance_status=="1"?"待启动":""}
														    ${e.instance_status=="2"?"待审核":""}
														    ${e.instance_status=="3"?"审核中":""}
														    ${e.instance_status=="4"?"已通过":""}
														    ${e.instance_status=="5"?"被驳回":""}
														    ${e.instance_status=="6"?"已通过":""}
														</td>
														<td style="text-align:center;">
														    <c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in">
																<i class="icon-lock" title="无权限">无权限</i></span>
															</c:if> 
															<%-- <!-- cod打印 -->
															<button class="btn  btn-info btn-sm" title="打印" type="button" onclick="DaYin('${e.item_id}');">打印</button> --%>

                                                            <c:if test="${QX.edit == 1 }">
                                                                <button class="btn btn-sm btn-info btn-sm" title="查看" type="button" onclick="edit('${e.non_standrad_id}','sel');">查看</button>
                                                            </c:if>
															<!-- 1.待启动 -->
															<c:if test="${e.instance_status == 1 }">
																<c:if test="${QX.edit == 1 }">
																	<button class="btn  btn-primary btn-sm" title="编辑"
																		type="button" onclick="edit('${e.non_standrad_id}','edit');">编辑
																	</button>
																	<button class="btn  btn-danger btn-sm" title="删除"
																			type="button" onclick="delE_offer('${e.non_standrad_id}');">删除
																	</button>
																</c:if>
																<c:if test="${e.operate_id==userpds.USER_ID||userpds.USER_ID=='1'}">
																	<button class="btn  btn-warning btn-sm" title="启动流程"
																			type="button" onclick="startLeave('${e.non_standrad_id}','${e.instance_id}')">启动
																	</button>
																</c:if>
															</c:if>
															<!-- 2.待审核 3.审核中 -->
															<c:if test="${e.instance_status == 2 || e.instance_status == 3 }">
																<button class="btn  btn-info btn-sm" title="审核记录" type="button" onclick="viewHistory('${e.instance_id}');">审核记录</button>
															</c:if>
															<!-- 5.被驳回 -->
															<c:if test="${e.instance_status == 5}">
																<button class="btn  btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('${e.instance_id}');">审核记录</button>
																<button class="btn  btn-warning btn-sm" title="重新申请" type="button" onclick="restartAgent('${e.task_id }','${e.non_standrad_id}');">重新提交</button>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="edit('${e.non_standrad_id}','edit');">编辑</button>
																	<button class="btn  btn-danger btn-sm" title="删除"
																			type="button" onclick="delE_offer('${e.non_standrad_id}');">删除
																	</button>
																</c:if>
															</c:if>
															<!-- 4.已通过 -->
															<c:if test="${e.instance_status == 4}">
																<button class="btn  btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('${e.instance_id}');">审核记录</button>
																<c:if test="${iscaiwurole == '1'}">
																	<button class="btn btn-warning btn-sm" title="修改价格" type="button" onclick="caiwuedit('${e.non_standrad_id}');">修改价格</button>
																</c:if>
															</c:if>
															
															<!-- 6.已通过 -->
															<c:if test="${e.instance_status == 6}">
															
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
							   <%-- <c:if test="${QX.del == 1 }">
								 <button class="btn  btn-danger" title="批量删除" type="button"
										onclick="makeAll('del');">批量删除</button>
							   </c:if> --%>
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
    //删除
    function delE_offer(non_standrad_id) {
        swal({
                    title: "您确定要删除该条数据吗？",
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
                        var url = "<%=basePath%>nonStandrad/delNonStandrad.do?non_standrad_id=" + non_standrad_id + "&tm=" + new Date().getTime();
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
                                url: '<%=basePath%>nonStandrad/delNonStandrad.do',
                                data: {non_standrad_id: str},
                                dataType: 'json',
                                cache: false,
                                success: function (data) {
                                    if (data.msg == 'success') {
                                    	swal({   
		        				        	title: "删除成功！",
		        				        	text: "您已经成功删除了这些数据",
		        				        	type: "success",  
		        				        	 }, 
		        				        	function(){   
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
    
  //导出到Excel
	function toExcel(ele){
	  	var master_id = $("input[name='master_id']").val();
	  	var item_name = $("input[name='item_name']").val();
	  	var subsidiary_company = $("input[name='subsidiary_company']").val();
	  	var project_area = $("input[name='project_area']").val();
	  	var user_name = $("input[name='user_name']").val();
	  	var lift_name = $("input[name='lift_name']").val();
	  	var operate_date_start = $("input[name='operate_date_start']").val();
	  	var operate_date_end = $("input[name='operate_date_end']").val();
	  	var instance_status = $("select[name='instance_status']").val();
	  	$(ele).attr("href", "<%=basePath%>nonStandrad/toExcel.do?"
	  			+"master_id="+master_id
	  			+"&item_name="+item_name
	  			+"&project_area="+project_area
	  			+"&subsidiary_company="+subsidiary_company
	  			+"&user_name="+user_name
	  			+"&lift_name="+lift_name
	  			+"&operate_date_start="+operate_date_start
	  			+"&operate_date_end="+operate_date_end
	  			+"&instance_status="+instance_status);
	}


    
	 //启动流程
	function startLeave(non_standrad_id,instance_id){
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
	        },function (isConfirm) {
			if (isConfirm)
			{
				var url = "<%=basePath%>nonStandrad/apply.do?non_standrad_id="+non_standrad_id+'&instance_id='+ instance_id;
				$.get(url, function (data) {
					if (data.msg == "success") {
						swal({   
							title: "启动成功！",
							text: "您已经成功启动该流程。\n该流程实例ID为："+instance_id+",下一个任务为："+data.task_name,
				        	type: "success",  
						    },function(){
							    refreshCurrentTab();
						    });
						
					} else {
						swal("启动失败","error");
					}
				});
			} 
			else
			{
				swal("已取消", "您已经取消启动操作了！", "error");
			}
		});
	}
	//审核记录
	 function viewHistory(instance_id){
		 $("#EditShops").kendoWindow({
			 width: "900px",
			 height: "500px",
			 title: "查看历史记录",
			 actions: ["Close"],
			 content: '<%=basePath%>workflow/goViewHistory.do?pid='+instance_id,
			 modal : true,
			 visible : false,
			 resizable : true
		 }).data("kendoWindow").center().open();
	 }
	//重新提交流程
	 function restartAgent(task_id,non_standrad_id){
		 swal({
			 title: "您确定要重新提交吗？",
			 text: "重新提交流程进行审核！",
			 type: "warning",
			 showCancelButton: true,
			 confirmButtonColor: "#DD6B55",
			 confirmButtonText: "提交",
			 cancelButtonText: "取消"
		 },
		 function (isConfirm) {
			 if (isConfirm === true) {
				 var url = "<%=basePath%>nonStandrad/restartNonStandrad.do?task_id="+task_id+"&non_standrad_id="+non_standrad_id+"&tm="+new Date().getTime();
				 $.get(url, function (data) {
					 console.log(data.msg);
					 if (data.msg == "success") {
						 swal({
							 title: "重新提交成功！",
							 text: "您已经成功重新提交了该流程！",
							 type: "success"
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


    //修改/查看
    function edit(id,operateType){
        $("#zhjView").kendoWindow({
            width: "1000px",
            height: "800px",
            title: "编辑非标信息",
            actions: ["Close"],
            content: '<%=basePath%>nonStandrad/preEditNonStandrad.do?non_standrad_id='+id+'&operateType='+operateType,
            modal : true,
            visible : false,
            resizable : true
        }).data("kendoWindow").maximize().open();
    }
    
  //修改/查看
    function caiwuedit(id){
        $("#zhjView").kendoWindow({
            width: "1000px",
            height: "800px",
            title: "编辑非标信息",
            actions: ["Close"],
            content: '<%=basePath%>nonStandrad/caiwuPreEditNonStandrad.do?non_standrad_id='+id,
            modal : true,
            visible : false,
            resizable : true
        }).data("kendoWindow").maximize().open();
    }
    
</script>
</body>
</html>


