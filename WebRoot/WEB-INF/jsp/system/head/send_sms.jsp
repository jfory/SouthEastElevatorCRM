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
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
</head>

<body class="gray-bg">
<form>
	<input type="hidden" name="isAll" id="isAll" value="no"/>
	<input type="hidden" name="TYPE" id="TYPE" value="1"/>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content1">
                        <div class="row">
                        <div class="social-comment">
                             <label>手机号码:</label>
                            <div class="media-body">
                                <textarea class="form-control" name="PHONE" id="PHONE" rows="1" cols="50"  placeholder="请选输入对方手机号,多个请用(;)分号隔开" title="请选输入对方手机号,多个请用(;)分号隔开">${pd.PHONE}</textarea>
                            </div>
                        </div>
                        </div>
                         <div class="row">
                        <div class="social-comment">
                             <label>短信内容:</label>
                            <div class="media-body">
                                <textarea style="height:250px" class="form-control" name="CONTENT" id="CONTENT" style="width:98%;height:165px;" rows="7" cols="50" title="此处为短信内容">您的验证码是：12358 。请不要把验证码泄露给其他人。</textarea>
                            </div>
                        </div>
                        </div>
                        </br>
                        <div class="row form-inline">
                        <input type="radio" name="form-field-radio" id="form-field-radio1" onclick="setType('1');" value="icon-edit" checked="checked" class="i-checks" >短信接口1
                        <input type="radio" name="form-field-radio" id="form-field-radio2" onclick="setType('2');" value="icon-edit" class="i-checks" >短信接口2
                        <input type="checkbox" name="form-field-checkbox" id="allusers" onclick="isAll();" class="i-checks" >全体用户
                        </div>
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="sendSms();">发送</a></td>
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditUsers');">关闭</a></td>
						</tr>
					</div>
            </div>
            
        </div>
 </div>
 </form>
 <!--引入属于此页面的js -->
		<script type="text/javascript" src="static/js/myjs/sms.js"></script>
<!-- Sweet alert -->
 <script src="static/js/sweetalert/sweetalert.min.js"></script>
 <!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
 <script type="text/javascript">
 $(document).ready(function () {
 	/* checkbox */
     $('.i-checks').iCheck({
         checkboxClass: 'icheckbox_square-green',
         radioClass: 'iradio_square-green',
     });
 });
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
