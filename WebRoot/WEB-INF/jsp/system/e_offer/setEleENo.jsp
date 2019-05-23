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
        <form action="e_offer/editEleENo.do" name="setENoForm" id="setENoForm" method="post">
        <input type="hidden" name="bjc_id" id="bjc_id" value="${pd.bjc_id}" />
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content form-inline">
<%--                     	<input type="hidden" name="bjc_id" id="bjc_id" value="${bjc_id}"> --%>
                        <c:if test="${not empty elelist}">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>序号</th>
                                <th>梯号</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${elelist}" var="item" varStatus="vs">
                                <tr>

                                    <td><input type="hidden" name="ele_id" value="${item.id}">${vs.index+1}</td>
                                    <td><input type="text" name="eno" value="${item.eno}" class="form-control"></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <tr>
		<td><a class="btn btn-primary btn-sm" style="width: 150px; height:34px;float:left;"  onclick="sub();">确定</a></td>
        <td><a class="btn btn-danger btn-sm" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('SetElevNo');">关闭</a></td>
		</tr>
        </form>
    </div>
    <script type="text/javascript">
	    function sub(){
	    	console.log($("#bjc_id").val());
	    	$("#setENoForm").submit();
	    }

	    function CloseSUWin(id) {	
			window.parent.$("#" + id).data("kendoWindow").close();
			/* 	window.parent.location.reload(); */
		}
	</script>
</body>
</html>


