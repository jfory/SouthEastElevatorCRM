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
     <!-- Sweet Alert -->
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
</head>

<body class="gray-bg">
<form action="role/add.do" name="AddRoleForm" id="AddRoleForm" method="post" >
	<input name="PARENT_ID" id="parent_id" value="${pd.parent_id }" type="hidden">
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
	                              
                                    <div class="form-group form-inline">
                                        <label>名称</label>
                                        <input input type="text" name="ROLE_NAME" id="roleName" placeholder="这里输入名称" title="名称" class="form-control">
                                    </div>
                                    <div class="form-group form-inline">
                                        <label>类型</label>
                                        <select class="form-control" name="TYPE" id="TYPE">
                                        	<option value="">请选择类型</option>
                                        	<option value="1">个人</option>
                                        	<option value="2">分子公司</option>
                                        	<option value="3">区域</option>
                                        	<option value="4">管理员</option>
                                        	<option value="5"}>小业主加盟商</option>
                                        	<option value="6"}>家用梯加盟商A</option>
                                        	<option value="7"}>家用梯加盟商B</option>
                                        	<option value="8"}>家用梯加盟商C</option>
                                        	<option value="9"}>家用梯加盟商D</option>
                                        </select>
                                    </div>
                            </div>
                        </div>
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddRole');">关闭</a></td>
						</tr>
					</div>
            </div>
            
        </div>
 </div>
 </form>
<!-- Sweet alert -->
 <script src="static/js/sweetalert/sweetalert.min.js"></script>
 <script type="text/javascript">
//保存
	function save(){
		if($("#roleName").val()==""){
			$("#roleName").tips({
				side:3,
	            msg:"请输入名称",
	            bg:'#AE81FF',
	            time:2
	        });
			$("#roleName").focus();
			return false;
		}
		if($("#TYPE").val()==""){
			$("#TYPE").tips({
				side:3,
	            msg:"请选择类型",
	            bg:'#AE81FF',
	            time:2
	        });
			$("#TYPE").focus();
			return false;
		}
			$("#AddRoleForm").submit();
	}
	//关闭页面
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* window.location.reload();  */
	}
</script>
</body>

</html>
