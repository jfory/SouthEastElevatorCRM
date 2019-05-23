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
        <div id="AddRegelevStandard" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                        <form role="form" class="form-inline" action="regelevStandard/goAddStandard.do" method="post" name="modelsListForm" id="modelsListForm">
	                            <div class="form-group ">
	                            	<label>电梯型号:</label>
	                                <select  class="form-control" name="models_name" id="models_name" title="电梯型号">
	                               			<option value="">请选择电梯型号</option>
                                        	<c:forEach items="${modelsList }" var="var">
                                                <option value="${var.ele_type}">${var.models_name}</option>
                                            </c:forEach>
									</select>
	                            </div>
	                        </form>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <tr>
			<td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="sub();">确定</a></td>
            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddRegelevStandard');">关闭</a></td>
			</tr>
	    </div>
    <script type="text/javascript">
    function sub(){
    	$("#modelsListForm").submit();
    }

		//新增
		function add(){
			$("#AddRegelevStandard").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "新增电梯标准价格",
		        actions: ["Close"],
		        content: '<%=basePath%>regelevStandard/goAddRegelevStandard.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
	</script>
</body>
</html>


