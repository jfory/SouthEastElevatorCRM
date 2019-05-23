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
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
 <!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content form-inline">
                        ${htmlStr}
                    </div>
                </div>
            </div>
        </div>
        <tr>
		<td><a class="btn btn-primary btn-sm" style="width: 150px; height:34px;float:left;"  onclick="sub();">确定</a></td>
        <td><a class="btn btn-danger btn-sm" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('SetElevNo');">关闭</a></td>
		</tr>
    </div>
    <script type="text/javascript">
	    function sub(){
	    	var rowIndex = parseInt("${rowIndex}");
	    	var eNoStr = "";
	    	$("input[name='eNo']").each(function(){
	    		eNoStr += $(this).val()+",";
	    	});
	    	window.parent.$("#elevatorTable").find("tr").eq(rowIndex).find("td").eq(2).find("input").eq(1).val(eNoStr);
			window.parent.$("#SetElevNo").data("kendoWindow").close();
	    }

	    function CloseSUWin(id) {	
			window.parent.$("#" + id).data("kendoWindow").close();
			/* 	window.parent.location.reload(); */
		}
	</script>
</body>
</html>


