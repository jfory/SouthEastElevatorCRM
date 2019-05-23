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
<form action="role/edit.do" name="EditRoleForm" id="EditRoleForm" method="post" >
<input type="hidden" name="ROLE_ID" id="id" value="${pd.ROLE_ID}"/>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
	                              
                                    <div class="form-group">
                                        <label>名称</label>
                                        <input type="text" name="ROLE_NAME" id="roleName" value="${pd.ROLE_NAME}" class="form-control">
                                    </div>
                                    <div class="form-group form-inline">
                                        <label>类型</label>
                                        <select class="form-control" name="TYPE" id="TYPE">
                                        	<option value="">请选择类型</option>
                                        	<option value="1" ${pd.TYPE=='1'?'selected':''}>个人</option>
                                        	<option value="2" ${pd.TYPE=='2'?'selected':''}>分子公司</option>
                                        	<option value="3" ${pd.TYPE=='3'?'selected':''}>区域</option>
                                        	<option value="4" ${pd.TYPE=='4'?'selected':''}>管理员</option>
                                        	<option value="5" ${pd.TYPE=='5'?'selected':''}>小业主加盟商</option>
                                        	<option value="6" ${pd.TYPE=='6'?'selected':''}>家用梯加盟商A</option>
                                        	<option value="7" ${pd.TYPE=='7'?'selected':''}>家用梯加盟商B</option>
                                        	<option value="8" ${pd.TYPE=='8'?'selected':''}>家用梯加盟商C</option>
                                        	<option value="9" ${pd.TYPE=='9'?'selected':''}>家用梯加盟商D</option>
                                        </select>
                                    </div>
                            </div>
                        </div>
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditRole');">关闭</a></td>
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
			$("#EditRoleForm").submit();
	}
	//关闭页面
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* window.location.reload();  */
	}
</script>
</body>

</html>
