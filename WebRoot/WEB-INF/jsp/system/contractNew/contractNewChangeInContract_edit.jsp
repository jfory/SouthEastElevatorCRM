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
	<!-- 选择报价页面 -->
	<div id="ChangeTheAgreement" class="animated fadeIn"></div>
	
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div id="top" ,name="top"></div>
						
						<form role="form" class="form-inline" action=""
							method="post" name="DeviceForm" id="DeviceForm">
							<div class="form-group">
								<button type="button" class="btn  btn-primary"
									style="margin-bottom: 0px;" title="新建" 
									onclick="CNadd();">新建
								</button>
								项目名称:${htbgxx.XMMC}&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp客户名称:${htbgxx.KHMC}
							</div>
						</form>
						<div class="row">
							</br>
						</div>
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>变更协议号</th>
										<th>次第</th>
										<th>业务员</th>
										<th>总价格</th>
										<th>申请日期</th>
										<th>状态</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty contractNewList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${contractNewList}" var="con" varStatus="vs">
													<tr>
														<td>${con.BGXYH}</td>
														<td>${con.CD}</td>
														<td>${con.YWY}</td>
														<td>${con.ZJG}</td>
														<td>${con.SQRQ}</td>
														<td>${con.ZT}</td>
														<td>
															<!-- 公共 -->
															<button class="btn btn-sm btn-info" title="查看"
																type="button" onclick="CNselect();">查看
															</button>
															
															<c:if test="${con.ZT == '新建'}">
																<button class="btn btn-sm btn-primary" title="编辑"
																	type="button" onclick="CNedit('${hou.houses_no}');">编辑
																</button>
															</c:if>
														
															<c:if test="${con.ZT == '新建'}">
																<button class="btn btn-sm btn-danger" title="删除"
																		type="button" onclick="CNdelte();">删除
																</button>
															</c:if>
															
															<c:if test="${con.ZT == '审批中'}">
																<button class="btn btn-sm btn-success" title="审批"
																		type="button" onclick="CNapproved();">审批
																</button>
															</c:if>
														
														</td>
													</tr>
												</c:forEach>
											</c:if>
											<!-- 权限设置 -->
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
	//---------------------------xcx-------------------------Start
	
	//新建
	function CNadd(){
		$("#ChangeTheAgreement").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "变更协议",
	        actions: ["Close"],
	        content: '<%=basePath%>contractNew/goChangeTheAgreement.do',
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	};
	
	//查看
	function CNselect(){
		
	}
	
	//编辑
	function CNedit(){
		$("#ChangeTheAgreement").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "变更协议",
	        actions: ["Close"],
	        content: '<%=basePath%>contractNew/goChangeTheAgreement.do',
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}
	
	//删除
	function CNdelte(){
		swal({
            title: "您确定要删除此条变更协议号的信息吗？",
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
            	var url = "";
				$.get(url,function(data){
					if(data.msg=='success'){
						swal({   
				        	title: "删除成功！",
				        	text: "您已经成功删除了这条信息。",
				        	type: "success",  
				        	 }, 
				        	function(){   
				        		//
				        		 
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
	
	//审核
	function CNapproved(){
		
	}
	
	//---------------------------xcx-------------------------End
	
	//新建
	<%-- function CNadd(){
		$("#QuoteSelectHTML").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "报价列表",
	        actions: ["Close"],
	        content: '<%=basePath%>contractNew/goAddContract.do',
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}; --%>
	
	//查看
	<%-- function CNselect(data){
		$("#EditDiscount").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "新增折扣申请",
	        actions: ["Close"],
	        content: '<%=basePath%>discount/goAddDiscount.do',
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}; --%>
	

    <%-- //刷新iframe
    function refreshCurrentTab() {
        $("#shopForm").submit();
    }
    //检索
    function search() {
        $("#shopForm").submit();
    }
    //新增
    function add() {
        $("#EditShops").kendoWindow({
            width: "800px",
            height: "500px",
            title: "新增楼盘信息",
            actions: ["Close"],
            content: '<%=basePath%>houses/goAddS.do',
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();
    }
    //修改
    function editShop(houses_no) {
        $("#EditShops").kendoWindow({
            width: "800px",
            height: "600px",
            title: "修改楼盘信息",
            actions: ["Close"],
            content: '<%=basePath%>houses/goEditS.do?houses_no=' + houses_no,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();
    }
    
    //查看 
    function editShopa(houses_no) {
        $("#EditShops").kendoWindow({
            width: "800px",
            height: "600px",
            title: "楼盘信息",
            actions: ["Close"],
            content: '<%=basePath%>houses/goEditSa.do?houses_no=' + houses_no,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();
    }
    
    //查看户型信息
    function houseType(houses_no) {
        $("#EditShops").kendoWindow({
            width: "800px",
            height: "600px",
            title: "户型信息",
            actions: ["Close"],
            content: '<%=basePath%>houses/houseType.do?houses_id=' + houses_no,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();
    }
    
   //查看单元信息
    function  cell(houses_no) {
        $("#EditShops").kendoWindow({
            width: "800px",
            height: "600px",
            title: "单元信息",
            actions: ["Close"],
            content: '<%=basePath%>houses/cell.do?houses_id='+ houses_no,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();
    }
    //删除
    function delShop(houses_no,msg) {
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
                        var url = "<%=basePath%>houses/delShop.do?houses_no=" + houses_no + "&tm=" 
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
                                url: '<%=basePath%>houses/deleteAllS.do',
							data : {
								houses_nos : str
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

    
  //导出到Excel
	function toExcel(){
		$.post("<%=basePath%>houses/toExcel.do");
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
            url:"<%=basePath%>houses/importExcel.do",
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
		var url="uploadFiles/file/DataModel/Houses/楼盘信息.xls";
		var name = window.encodeURI(window.encodeURI(url));
		window.open("customer/DataModel?url=" + name,"_blank");
	} --%>
    
    
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


