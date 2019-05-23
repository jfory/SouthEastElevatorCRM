<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>

<head>

    <base href="<%=basePath%>">


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
    <title>${pd.SYSNAME}</title>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp" %>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert2/sweetalert2.js"></script>
    <script type="text/javascript">

        //保存
        function save() {
            if ($("#PASSWORD").val() != $("#chkpwd").val()) {

                $("#chkpwd").tips({
                    side: 3,
                    msg: '两次密码不相同',
                    bg: '#AE81FF',
                    time: 3
                });
                $("#chkpwd").focus();
                return false;
            }

            $("#userForm").submit();
        }
        function CloseSUWin(id) {
            window.parent.$("#" + id).data("kendoWindow").close();
        }
    </script>
</head>

<body class="gray-bg">
<form action="sysUser/${msg }.do" name="userForm" id="userForm" method="post">
    <input type="hidden" name="USER_ID" id="USER_ID" value="${pd.USER_ID }"/>
    <input type="hidden" name="POSITION_ID" id="POSITION_ID" value="${pd.POSITION_ID}"/>
    <input type="hidden" name="USERNAME" id="USERNAME" value="${pd.USERNAME}"/>
    <input type="hidden" name="NAME" id="NAME" value="${pd.NAME}"/>
    <input type="hidden" name="ROLE_ID" id="ROLE_ID" value="${pd.ROLE_ID}"/>
    <input type="hidden" name="BZ" id="BZ" value="${pd.BZ}"/>
    <input type="hidden" name="EMAIL" id="EMAIL" value="${pd.EMAIL}"/>
    <input type="hidden" name="NUMBER" id="NUMBER" value="${pd.NUMBER}"/>
    <input type="hidden" name="PHONE" id="PHONE" value="${pd.PHONE}"/>
    <input type="hidden" name="STATUS" id="STATUS" value="${pd.STATUS}"/>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">

                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">

                                <div class="form-group">
                                        <label>用户名:</label>
                                        <input readonly type="text" value="${pd.USERNAME }" class="form-control">
                                    </div>
                                <div class="form-group">
                                    <label>编号</label>
                                    <input type="text" readonly value="${pd.NUMBER }" maxlength="32"  class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>姓名</label>
                                    <input type="text" readonly value="${pd.NAME}" maxlength="32"  class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>密码</label>
                                    <input type="password" name="PASSWORD" id="PASSWORD" maxlength="32" placeholder="输入密码" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>确认密码</label>
                                    <input type="password" name="chkpwd" id="chkpwd" maxlength="32" placeholder="确认密码" class="form-control">
                                </div>
                            </div>

                        </div>

                    </div>
                    <div style="height: 20px;"></div>
                    <tr>
                        <td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;" onclick="save();">保存</a></td>
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditUsers');">关闭</a></td>
                    </tr>
                </div>
            </div>

        </div>
    </div>
</form>
</body>

</html>
