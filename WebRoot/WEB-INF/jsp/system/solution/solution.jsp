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
						<form role="form" class="form-inline" action="solution/solution.do" method="post" name="shopForm" id="shopForm">
							 
							  <c:if test="${msg == 'solution'}">
							<div class="form-group ">
							     <input class="form-control" id="nav-search-input" type="text"
									name="houses_name" value="${pd.houses_name}" placeholder="这里输入所属楼盘名称">
								<input class="form-control" id="nav-search-input" type="text"
									name="hou_name" value="${pd.hou_name}" placeholder="这里输入所属户型名称">
									<input class="form-control" id="nav-search-input" type="text"
									name="so_name" value="${pd.so_name}" placeholder="这里输入方案名称">
							</div>
							<div class="form-group">
								<button type="submit" class="btn  btn-primary "
									style="margin-bottom: 0px;" title="搜索">
									<i style="font-size: 18px;" class="fa fa-search"></i>
								</button>
							</div>
							</c:if>
							<button class="btn  btn-success" title="刷新" type="button"
								style="float: right" onclick="refreshCurrentTab();">刷新
							</button>
						</form>
						<form role="form" class="form-inline" action="houseType/solution.do" method="post" name="houseType" id="houseType">
						  <input type="hidden" id="hou_id" name="hou_id" value="${pd.hou_id}"/>
						  <input type="hidden" id="houses_no" name="houses_no" value="${pd.houses_no}"/>
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
										<th >序号</th>
										<th style="width:15%;">编号</th>
										<th>方案名称</th>
	                                    <th>建议价格</th>
	                                    <th>所属楼盘</th>
	                                    <th>所属户型</th>
										<th style="width:25%;">方案描述</th>
										<th style="width:10%;">操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty solutionList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${solutionList}" var="so" varStatus="vs">

													<tr>
														<td class='center' style="width: 30px;">
														<label>
														<input
																class="i-checks" type='checkbox' name='ids'
																value="${so.so_id}" id="${so.so_id}"
																alt="${so.so_id}" />
																<span class="lbl"></span>
																</label>
																</td>
														<td class='center' style="width: 30px;">${vs.index+1}</td>
														
														<td>${so.so_id}</td>
														<td>${so.so_name}</td>
														<td>${so.so_price}</td>
														<td>${so.houses_name}</td>
														<td>${so.hou_name}</td>
														<td>${so.so_describe}</td>
														<td><c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span
																	class="label label-large label-grey arrowed-in-right arrowed-in"><i
																	class="icon-lock" title="无权限">无权限</i></span>
															</c:if> 
															 <c:if test="${QX.edit == 1 }">
																<button class="btn  btn-primary btn-sm" title="编辑"
																	type="button" onclick="editShop('${so.so_id}');">编辑
																</button>
															</c:if> 
															<c:choose>
																<c:when test="${user.USERNAME=='admin'}"></c:when>
																<c:otherwise>
																	<c:if test="${QX.del == 1 }">
																		<button class="btn  btn-danger btn-sm" title="删除" type="button" 
																			onclick="delHouseType('${so.so_id}','${so.so_name}');">删除
																		</button>
																	</c:if>
																</c:otherwise>
															</c:choose>
															</ul>
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
												<td colspan="100" class="center">没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
							<div class="col-lg-12"
								style="padding-left: 0px; padding-right: 0px">
								<%-- <c:if test="${QX.add == 1 }"> --%>
								  <c:if test="${msg == 'houseType'}">
									<button class="btn  btn-primary" title="新增" type="button"
										onclick="add2('${pd.hou_id}','${pd.houses_no}');">新增</button>
								  </c:if>
								  <%-- <c:if test="${msg == 'solution'}">
									<button class="btn  btn-primary" title="新增" type="button"
										onclick="add();">新增</button>
								  </c:if> --%>
								<%-- </c:if> --%>
								<c:if test="${QX.del == 1 }">
									<button class="btn  btn-danger" title="批量删除" type="button"
										onclick="delHouseTypes('del');">批量删除</button>
								</c:if>
								<c:if test="${msg == 'solution'}">
								     <a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>solution/toExcel.do">导出</a>
									<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile()">导入</button>
									<input style="display: none" class="form-control" type="file"  title="导入" id="importFile" onchange="importExcel(this)"/>
								</c:if>
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
    	var msg='${msg}';
    	if(msg=="houseType")
    	{
    		$("#houseType").submit();
    	}
    	else
    	{
            $("#shopForm").submit();
    	}
    }
    //检索
    function search() {
        $("#shopForm").submit();
    }
    //(从户型发来请求)的新增
    function add2(hou_id,houses_no) {
        $("#EditShops").kendoWindow({
            width: "800px",
            height: "500px",
            title: "新增户型解决方案",
            actions: ["Close"],
            content: '<%=basePath%>solution/goAddS.do?houseType_id='+hou_id+'&houses_no='+houses_no,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").center().open();
    }
    <%-- 新增
    function add() {
        $("#EditShops").kendoWindow({
            width: "800px",
            height: "500px",
            title: "新增户型解决方案",
            actions: ["Close"],
            content: '<%=basePath%>solution/goAddS.do',
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").center().open();
    } --%>
    //修改
    function editShop(id) {
        $("#EditShops").kendoWindow({
            width: "800px",
            height: "600px",
            title: "修改户型信息",
            actions: ["Close"],
            content: '<%=basePath%>solution/goEditS.do?so_id=' + id,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").center().open();
    }
    //删除
    function delHouseType(id,name) {
        swal({
                    title: "您确定要删除[" + name + "]吗？",
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
                        var url = "<%=basePath%>solution/delSolution.do?so_id=" + id + "&tm=" + new Date().getTime();
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
    function delHouseTypes(msg) {
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
                                url: '<%=basePath%>solution/delSolutions.do',
                                data: {ids: str},
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
	function toExcel(){
		$.post("<%=basePath%>solution/toExcel.do");
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
            url:"<%=basePath%>solution/importExcel.do",
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
		var url="uploadFiles/file/DataModel/Houses/户型解决方案.xls";
		var name = window.encodeURI(window.encodeURI(url));
		window.open("customer/DataModel?url=" + name,"_blank");
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


