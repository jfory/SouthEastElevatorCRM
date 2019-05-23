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
		
		<meta charset="utf-8" />
		<title>菜单</title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</head>

<script type="text/javascript">
	$(top.hangge());
	$(document).ready(function(){		
		if($("#menuId").val()!=""){
			var parentId = "${menu.parentId}";
			if(parentId==""){
				$("#parentId").attr("disabled",true);
			}else{
				$("#parentId").val(parentId);
			}
		}
		setMUR();
	}); 

	function setMUR(){
		if($("#parentId").val()=="0"){
			$("#menuUrl").attr("readonly",true);
			$("#menuUrl").val("");
			$("#form-field-radio1").attr("disabled",false);
			$("#form-field-radio2").attr("disabled",false);
		}else{
			$("#menuUrl").attr("readonly",false);
			$("#form-field-radio1").attr("disabled",true);
			$("#form-field-radio2").attr("disabled",true);
			$("#form-field-radio1").attr("checked",false);
			$("#form-field-radio2").attr("checked",false);
		}
	}

	//保存
	function save(){
		if($("#menuName").val()==""){
			
			$("#menuName").tips({
				side:3,
	            msg:'请输入菜单名称',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#menuName").focus();
			return false;
		}
		if($("#menuUrl").val()==""){
			$("#menuUrl").val('#');
		}
		if($("#menuOrder").val()==""){
			
			$("#menuOrder").tips({
				side:1,
	            msg:'请输入菜单序号',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#menuOrder").focus();
			return false;
		}
		
		if(isNaN(Number($("#menuOrder").val()))){
			
			$("#menuOrder").tips({
				side:1,
	            msg:'请输入菜单序号',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#menuOrder").focus();
			$("#menuOrder").val(1);
			return false;
		}
		
		$("#menuForm").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
	function setType(value){
		$("#MENU_TYPE").val(value);
	}
	
</script>


<body>
	<form  action="menu/add.do" name="menuForm" id="menuForm" method="post" >
		<input type="hidden" name="MENU_ID" id="menuId" value=""/>
		<input type="hidden" name="MENU_TYPE" id="MENU_TYPE" value=""/>
		<div id="zhongxin">
		<table>
			<tr>
				<td>
					<select name="PARENT_ID" id="parentId" class="input_txt" onchange="setMUR()"  title="菜单">
						<option value="0">顶级菜单</option>
						<c:forEach items="${menuList}" var="menu">
							<option value="${menu.MENU_ID }" onclick="">${menu.MENU_NAME }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td><input type="text" name="MENU_NAME" id="menuName" placeholder="这里输入菜单名称" value="" title="名称"/></td>
			</tr>
			<tr>
				<td><input type="text" name="MENU_URL" id="menuUrl" placeholder="这里输入链接地址" value="" title="地址"/></td>
			</tr>
			<tr>
				<td><input type="number" name="MENU_ORDER" id="menuOrder" placeholder="这里输入序号" value="" title="序号"/></td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label style="float:left;padding-left: 32px;"><input name="form-field-radio" id="form-field-radio1" onclick="setType('1');" type="radio" value="icon-edit"><span class="lbl">系统菜单</span></label>
					<label style="float:left;padding-left: 5px;"><input name="form-field-radio" id="form-field-radio2" onclick="setType('2');" type="radio" value="icon-edit"><span class="lbl">业务菜单</span></label>
				</td>
			</tr>
			<tr>
				<td style="text-align: center; padding-top: 10px;">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"></h4></div>
	</form>
</body>
</html>