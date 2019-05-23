<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <meta charset="utf-8"/>
    <title></title>

    <link href="static/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="static/css/font-awesome.min.css"/>
    <!-- 第三方插件 -->
    <link rel="shortcut icon" href="favicon.ico">
    <link href="static/css/bootstrap.min.css" rel="stylesheet">
    <link href="static/css/font-awesome.min.css" rel="stylesheet">
    <link href="static/css/animate.css" rel="stylesheet">
    <link href="static/css/style.css" rel="stylesheet">

    <style type="text/css">
        footer {
            height: 50px;
            position: fixed;
            bottom: 0px;
            left: 0px;
            width: 100%;
            text-align: center;
        }
    </style>
</head>
        <div id="myzTree" class="ztree"></div>
<body>

<!-- 全局js -->
<script src="static/js/jquery.min.js"></script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/metisMenu/jquery.metisMenu.js"></script>
<script src="static/js/slimscroll/jquery.slimscroll.min.js"></script>
<script src="static/js/layer/layer.min.js"></script>
<!-- 自定义js -->
<script src="static/js/common.js?v=4.1.0"></script>
<script type="text/javascript" src="static/js/contabs.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<!-- 引入kendoui组件 -->
<script src="static/js/kendoui/js/kendo.web.min.js"></script>
<link href="static/js/kendoui/styles/kendo.common.min.css" rel="stylesheet">
<link href="static/js/kendoui/styles/kendo.metro.min.css" rel="stylesheet">
<%--zTree--%>
<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css"/>
<script type="text/javascript" src="plugins/zTree/3.5.24/js/jquery.ztree.all.js"></script>
<script type="text/javascript">
    var zTree;
    $(document).ready(function () {

        var setting = {
            check: {
                enable: true
            },
            data: {
                simpleData: {
                    enable: true
                }
            }
        };
        var zn = '${zTreeNodes}';
        var zTreeNodes = eval(zn);
        $.fn.zTree.init($("#myzTree"), setting, zTreeNodes);
        var zTree = $.fn.zTree.getZTreeObj("myzTree");
        zTree.expandAll(true);

    });
</script>
<script type="text/javascript">

    function save() {

        var zTree = $.fn.zTree.getZTreeObj("myzTree");
        var nodes = zTree.getCheckedNodes();
        var nodes_str = JSON.stringify(zTree.getNodes());

        var modelsid = "${pd.models_id}";
        var url = "<%=basePath%>workflow/saveContractTechSetUp.do";
        var postData;

        postData = {"models_id": modelsid, "treeIds": nodes_str};

        $.post(url, postData, function (data) {
            if(data.msg =="sucess"){
                CloseSUWin('setUpView');
            }else{
                CloseSUWin('setUpView');
            }

        });

    }
    //关闭页面
    function CloseSUWin(id) {
        window.parent.$("#" + id).data("kendoWindow").close();
    }
</script>
<footer>
    <div style="height: 20px;">
        <tr>
            <td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;" onclick="save();">保存</a></td>
            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('setUpView');">关闭</a></td>
        </tr>
    </div>
</footer>
</body>
</html>