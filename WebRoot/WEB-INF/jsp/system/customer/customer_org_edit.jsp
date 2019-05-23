<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<%@ include file="../../system/admin/top.jsp"%>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>${pd.SYSNAME}</title>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css"/>
	<!-- Sweet Alert -->
	<link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
	<style type="text/css">
		.ztree li span.button.defaultSkin_ico_open {
			margin-right: 2px;
			background-position: -110px -16px;
			vertical-align: top;
		}
		.ztree li span.button.defaultSkin_ico_close {
			margin-right: 2px;
			background-position: -110px -16px;
			vertical-align: top;
		}
		.ztree li span.button.defaultSkin_ico_docu {
			margin-right: 2px;
			background-position: -110px -16px;
			vertical-align: top;
		}

	</style>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins" id="menuContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
					<div class="ibox-content">
						<div>
							<input class="form-control" style="height: 30px" type="text" placeholder="搜索" id="keyWord" onkeyup="searchTreeNodesByKeyWord()">
							<ul id="myzTree" class="ztree" style="margin-top:0; width:160px;"></ul>
						</div>
					</div>
				</div>
				<%--用户ID--%>
				<form action="customerOrg/${msg }.do" name="customerOrg" id="customerOrg" method="post">
				<input type="hidden" name="pId" id="pId" value="${pd.pId}"/>
				<input type="hidden" name="id" id="id" value="${pd.id}"/>
				<input type="hidden" name="operateType" id="operateType" value="${operateType}"/>
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div class="row">
							<div class="col-lg-12">
								<c:choose>
									<c:when test="${isEmpty =='empty'}">
										<div class="form-group ">
											<input type="hidden" id="add_pId2" type="number" name="add_pId" value="0"
												   style="max-width:150px;">
										</div>
									</c:when>
									<c:otherwise>
										<div class="form-group form-inline" style="margin-top: 15px;">
											<c:if test="${isParent!='true'}">
												<label>上级公司:</label>
												<c:choose>
													<c:when test="${not empty pd.pId}">
														<input type="text" value="${pd.pName}" readonly id="customerOrgSelect" class="form-control" placeholder="请点击选择所属公司" onclick="showMenu();">
													</c:when>
													<c:otherwise>
														<input type="text" value="" readonly id="customerOrgSelect" class="form-control" placeholder="请点击选择所属公司" onclick="showMenu();">
													</c:otherwise>
												</c:choose>
											</c:if>
										</div>

										<c:if test="${operateType=='add'}">
											<div class="form-group ">
												<label>上级公司ID:</label>
												<input autocomplete="off" id="add_pId" type="number" name="add_pId"
													   placeholder="第一级的父类ID为0" class="form-control" style="max-width:150px;">
											</div>
										</c:if>
									</c:otherwise>
								</c:choose>
                            <div class="form-group ">
                                <label>公司名称:</label>
                                <input autocomplete="off" id="name" type="text" name="name"
                                       placeholder="这里输入名称" value="${pd.name}" class="form-control" style="max-width:200px;">
                            </div>
                            <div class="form-group ">
                                <label>类型:</label>
                                <select id="type" name="type" class="form-control m-b">
                                <option value="Developer" ${pd.type=='Developer'?'selected':''}>开发商</option>
                                <option value="Core" ${pd.type=='Core'?'selected':''}>战略客户</option>
                                <option value="Merchant" ${pd.type=='Merchant'?'selected':''}>业主/经销商</option>
                                </select>
                            </div>
							</div>
						</div>
						</div>
					</div>
					<div style="height: 20px;"></div>
					<tr>
						<td><button type="submit" class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="return funcsave();">保存</button></td>
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('editCustomerOrg');">关闭</a></td>
						
					</tr>
				</div>
			</form>
			</div>

		</div>
	</div>
<%--zTree--%>
<script type="text/javascript"
		src="plugins/zTree/3.5.24/js/jquery.ztree.all.js"></script>
<!-- Sweet alert -->
<script src="static/js/sweetalert2/sweetalert2.js"></script>
<script type="text/javascript">

	//保存
	function funcsave() {
		$("#add_pId").focus();
		if (zNodes!=""&&$("#pId").val() == ""&&$("#operateType").val()=="add"&&$("#add_pId").val()!=0) {
			$("#add_pId").tips({
				side: 3,
				msg: "请选择所属公司",
				bg: '#AE81FF',
				time: 2
			});
			return false;
		}
		$("#name").focus();
		if ($("#name").val() == "") {
			$("#name").tips({
				side: 3,
				msg: "请输入名称",
				bg: '#AE81FF',
				time: 2
			});
			return false;
		}
	}
	//关闭页面
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();

	}
	//ztree
	var setting = {
		view: {
			dblClickExpand: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onClick: onClick
		}
	};

	var zNodes =${companys};

	function beforeClick(treeId, treeNode) {
		var check = (treeNode && treeNode.parentId!=0);
		if (!check) {
			swal({
				title: "不能选择["+treeNode.name+"]！",
				text: "请重新选择",
				type: "error",
				showConfirmButton: false,
				timer: 1500
			});
		}
		return check;
	}

	function onClick(e, treeId, treeNode) {
		var orgObj = $("#customerOrgSelect");
		orgObj.attr("value", treeNode.name);
		/*
		var pId = $("#pId");
		alert(pId);
		pId.attr("value", treeNode.id);*/
		$("#pId").val(treeNode.id);
		$("#add_pId").val(treeNode.id);

	}
	function showMenu() {
		var orgObj = $("#customerOrgSelect");
		var orgOffset = $("#customerOrgSelect").offset();
		$("#menuContent").css({left:(orgOffset.left+6) + "px", top:orgOffset.top + orgObj.outerHeight() + "px"}).slideDown("fast");

		$("body").bind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
			hideMenu();
		}
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	
	$(document).ready(function(){
		$.fn.zTree.init($("#myzTree"), setting, zNodes);
		$.fn.zTree.getZTreeObj("myzTree").expandAll(true);
	});
</script>
</body>

</html>
