﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp" %>
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
<div class="wrapper wrapper-content animated fadeInRight">
    <div id="AddUsers" class="animated fadeIn"></div>
    <div id="EditUsers" class="animated fadeIn"></div>
    <div id="ImportExcel" class="animated fadeIn"></div>
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-content">
                    <div id="top" ,name="top"></div>
                    <form role="form" class="form-inline" action="sysUser/listUsers.do" method="post" name="userForm" id="userForm">
                        <div class="form-group ">
                            <input type="text" id="nav-search-input" name="USERNAME" value="${pd.USERNAME }" placeholder="这里输入关键词" class="form-control">
                        </div>
                        <div class="form-group ">
                            <input type="text" id="nav-search-input" name="ROLENAME" value="${pd.ROLENAME }" placeholder="这里输入角色名称" class="form-control">
                        </div>
                        <!-- 搜索角色改为输入框模糊查询 -->
                        <%-- <div class="form-group">
                            <select class="form-control" name="ROLE_ID" id="role_id" data-placeholder="全部角色" style="vertical-align:top;width:100%" title="角色">
                                <option value="">全部角色</option>
                                <c:forEach items="${roleList}" var="role">
                                    <option value="${role.ROLE_ID }" <c:if test="${pd.ROLE_ID==role.ROLE_ID}">selected</c:if>>${role.ROLE_NAME }</option>
                                </c:forEach>
                            </select>
                        </div> --%>
                        
                        <div class="form-group">
                            <button type="submit" class="btn  btn-primary " style="margin-bottom:0px;" title="搜索"><i style="font-size:18px;" class="fa fa-search"></i></button>
                        </div>
                        <button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab();">刷新</button>

                    </form>
                    <div class="row">
                        </br>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th style="width:3%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks"></th>
                                <th style="width:4%;">序号</th>
                                <th style="width:5%;">编号</th>
                                <th style="width:7%;">用户名</th>
                                <th style="width:7%;">姓名</th>
                                <th style="width:10%;">角色</th>
                                <th style="width:12%;">岗位</th>
                                <th style="width:7%;">邮箱</th>
                                <th style="width:7%;">电话号码</th>
                                <th style="width:10%;">最近登录</th>
                                <th style="width:10%;">上次登录IP</th>
                                <th style="width:3%;">状态</th>
                                <th style="width:20%;">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 开始循环 -->
                            <c:choose>
                                <c:when test="${not empty userList}">
                                    <c:if test="${QX.cha == 1 }">
                                        <c:forEach items="${userList}" var="user" varStatus="vs">

                                            <tr>
                                                <td>

                                                    <c:if test="${user.USERNAME != 'admin'}">
                                                        <input type="checkbox" class="i-checks" name='ids' value="${user.USER_ID}" id="${user.EMAIL }" alt="${user.PHONE }">
                                                    </c:if>
                                                    <c:if test="${user.USERNAME == 'admin'}">
                                                        <input type="checkbox" disabled="disabled" class="i-checks">
                                                    </c:if>
                                                </td>
                                                <td>${vs.index+1}</td>
                                                <td>${user.NUMBER }</td>
                                                <td><a>${user.USERNAME }</a></td>
                                                <td>${user.NAME }</td>
                                                <td>${user.ROLE_NAME }</td>
                                                <td>${user.deptname }</td>
                                                <td>${user.EMAIL }</td>
                                                <td>${user.PHONE}</td>
                                                <td>${user.LAST_LOGIN}</td>
                                                <td>${user.IP}</td>
                                                <td style="width: 60px;" class="center">
                                                    <c:if test="${user.STATUS == '0' }"><span class="label label-important arrowed-in">已冻结</span></c:if>
                                                    <c:if test="${user.STATUS == '1' }"><span class="label label-info arrowed">已激活</span></c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${QX.edit != 1 && QX.del != 1 }">
                                                        <span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
                                                    </c:if>
                                                    <div>
                                                        <c:if test="${QX.edit == 1 }">
                                                            <c:if test="${user.USERNAME != 'admin'}">
                                                                <button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editUser('${user.USER_ID }');">编辑</button>
                                                            </c:if>
                                                            <c:if test="${user.USERNAME == 'admin'}">
                                                                <button class="btn  btn-primary btn-sm" title="您不能编辑" type="button" disabled>编辑</button>
                                                            </c:if>
                                                        </c:if>
                                                        <c:choose>
                                                            <c:when test="${user.USERNAME=='admin'}">
                                                                <button class="btn  btn-danger btn-sm" title="不能删除" type="button" diabled>删除</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:if test="${QX.del == 1 }">
                                                                    <button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delUser('${user.USER_ID }','${user.USERNAME }');">删除
                                                                    </button>
                                                                </c:if>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </td>
                                            </tr>

                                        </c:forEach>
                                    </c:if>

                                    <c:if test="${QX.cha == 0 }">
                                        <tr>
                                            <td colspan="10" class="center">您无权查看</td>
                                        </tr>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <tr class="main_info">
                                        <td colspan="10" class="center">没有相关数据</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                        <div class="col-lg-12" style="padding-left:0px;padding-right:0px">
                            <c:if test="${QX.add == 1 }">
                                <button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button>
                            </c:if>
                            <c:if test="${QX.del == 1 }">
                                <button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll('del');">批量删除</button>
                            </c:if>
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
    <a class="btn btn-warning btn-back-to-top" href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
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
    $(document).ready(function () {
        //loading end
        parent.layer.closeAll('loading');
        /* checkbox */
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });
        /* 图片 */
        $('.fancybox').fancybox({
            openEffect: 'none',
            closeEffect: 'none'
        });
    });
    /* checkbox全选 */
    $("#zcheckbox").on('ifChecked', function (event) {

        $('input').iCheck('check');
    });
    /* checkbox取消全选 */
    $("#zcheckbox").on('ifUnchecked', function (event) {

        $('input').iCheck('uncheck');
    });

    //刷新iframe
    function refreshCurrentTab() {
        $("#userForm").submit();
    }
    //检索
    function search() {
        $("#userForm").submit();
    }
    //去发送电子邮件页面
    function sendEmail(EMAIL) {
        $("#EditUsers").kendoWindow({
            width: "800px",
            height: "500px",
            title: "发送邮件",
            actions: ["Close"],
            content: '<%=basePath%>head/goSendEmail.do?EMAIL=' + EMAIL,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").center().open();
    }

    //去发送短信页面
    function sendSms(phone) {
        $("#EditUsers").kendoWindow({
            width: "800px",
            height: "500px",
            title: "发送短信",
            actions: ["Close"],
            content: '<%=basePath%>head/goSendSms.do?PHONE=' + phone + '&msg=appuser',
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").center().open();
    }
    //新增
    function add() {
        $("#AddUsers").kendoWindow({
            width: "800px",
            height: "600px",
            title: "新增",
            actions: ["Close"],
            content: '<%=basePath%>sysUser/goAddU.do',
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").center().open();
    }
    //修改
    function editUser(user_id) {
        $("#EditUsers").kendoWindow({
            width: "800px",
            height: "600px",
            title: "修改资料",
            actions: ["Close"],
            content: '<%=basePath%>sysUser/goEditU.do?USER_ID=' + user_id,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").center().open();
    }
    //删除
    function delUser(userId, msg) {
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
                        var url = "<%=basePath%>sysUser/deleteU.do?USER_ID=" + userId + "&tm=" + new Date().getTime();
                        $.get(url, function (data) {
                            if (data == 'success') {
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

                if (emstr == '') emstr += document.getElementsByName('ids')[i].id;
                else emstr += ';' + document.getElementsByName('ids')[i].id;

                if (phones == '') phones += document.getElementsByName('ids')[i].alt;
                else phones += ';' + document.getElementsByName('ids')[i].alt;
            }
        }
        1
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

            if (msg == 'del') {
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
                                layer.load(1);
                                $.ajax({
                                    type: "POST",
                                    url: '<%=basePath%>sysUser/deleteAllU.do?tm=' + new Date().getTime(),
                                    data: {USER_IDS: str},
                                    dataType: 'json',
                                    cache: false,
                                    success: function (data) {
                                        layer.closeAll('loading');
                                        if (data.msg == 'success') {
                                            swal({
                                                        title: "删除成功！",
                                                        text: "您已经成功删除了这些数据。",
                                                        type: "success",
                                                    },
                                                    function(){
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
            } else if (msg == 'sendEmail') {
                swal({
                            title: "您确定要给选中的用户发送邮件吗？",
                            text: "请谨慎操作！",
                            type: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "发送",
                            cancelButtonText: "取消",
                            closeOnConfirm: true,
                            closeOnCancel: false
                        },
                        function (isConfirm) {
                            if (isConfirm) {
                                sendEmail(emstr);
                            } else {
                                swal("已取消", "您取消了发送邮件的操作！", "error");
                            }
                        });

            } else if (msg == 'sendSms') {
                swal({
                            title: "您确定要给选中的用户发送短信吗？",
                            text: "请谨慎操作！",
                            type: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "发送",
                            cancelButtonText: "取消",
                            closeOnConfirm: true,
                            closeOnCancel: false
                        },
                        function (isConfirm) {
                            if (isConfirm) {
                                sendSms(phones);
                            } else {
                                swal("已取消", "您取消了发送短信的操作！", "error");
                            }
                        });

            }
        }
    }
    //导出excel
    function toExcel() {
        var USERNAME = $("#nav-search-input").val();
        var lastLoginStart = $("#lastLoginStart").val();
        var lastLoginEnd = $("#lastLoginEnd").val();
        var ROLE_ID = $("#role_id").val();
        window.location.href = '<%=basePath%>sysUser/excel.do?USERNAME=' + USERNAME + '&lastLoginStart=' + lastLoginStart + '&lastLoginEnd=' + lastLoginEnd + '&ROLE_ID=' + ROLE_ID;
    }
    //打开上传excel页面
    function importExcel() {

        $("#ImportExcel").kendoWindow({
            width: "600px",
            height: "400px",
            title: "从EXCEL导入到数据库",
            actions: ["Close"],
            content: '<%=basePath%>sysUser/goUploadExcel.do',
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").center().open();
    }
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


