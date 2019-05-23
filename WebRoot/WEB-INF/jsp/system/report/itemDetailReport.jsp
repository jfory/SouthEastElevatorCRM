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
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp" %>
    <base href="http://localhost:8080/DNCRM/">
    <!-- jsp文件头和头部 -->
    ﻿
    <meta charset="utf-8"/>
    <title></title>
    <meta name="description" content="overview & stats"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <!-- 全局js -->
    <!--     <script src="static/js/jquery.min.js"></script> -->
    <script src="static/js/jquery-1.12.4.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <!-- dropdown-list  下拉框搜索插件 -->
    <script src="static/js/bootstrap-select.min.js"></script>
    <script src="static/js/metisMenu/jquery.metisMenu.js"></script>
    <script src="static/js/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="static/js/layer/layer.min.js"></script>
    <!-- 自定义js -->
    <script src="static/js/common.js?v=4.1.0"></script>
    <script type="text/javascript" src="static/js/contabs.js"></script>
    <!--提示框-->
    <script type="text/javascript" src="static/js/jquery.tips.js"></script>
    <!-- 第三方插件 -->
    <link rel="shortcut icon" href="favicon.ico">
    <link href="static/css/bootstrap.min.css" rel="stylesheet">
    <!-- dropdown-list  下拉框搜索插件 -->
    <link href="static/css/bootstrap-select.min.css" rel="stylesheet">
    <link href="static/css/font-awesome.min.css" rel="stylesheet">
    <link href="static/css/animate.css" rel="stylesheet">
    <link href="static/css/style.css" rel="stylesheet">
    <!-- 引入kendoui组件 -->
    <script src="static/js/kendoui/js/kendo.web.min.js"></script>
    <link href="static/js/kendoui/styles/kendo.common.min.css" rel="stylesheet">
    <link href="static/js/kendoui/styles/kendo.metro.min.css" rel="stylesheet">
    <!-- GITTER -->
    <script src="static/js/gritter/jquery.gritter.min.js"></script>
    <!-- Gritter -->
    <link href="static/js/gritter/jquery.gritter.css" rel="stylesheet">

    <link href="static/js/layer/skin/layer.css" rel="stylesheet">
    <script type="text/javascript" src="static/js/layer/layer.min.js"></script>
    <!-- jquery-ui-->
    <script src="static/js/jquery-ui-1.10.4.min.js"></script>
    <link href="static/css/jquery-1.10.4-ui.css" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css"/>
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
    <%--zTree--%>
    <script type="text/javascript"
            src="plugins/zTree/3.5.24/js/jquery.ztree.all.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert2/sweetalert2.js"></script>
    <style type="text/css">
        .ztree li span.button.defaultSkin_ico_open {
            margin-right: 2px;
            background-position: -110px -16px;
            vertical-align: top;
        }

        .ztree li span.button.defaultSkin_ico_close {
            margin-right: 2px;
            background-position: -110px -16px;
            vertical-align: top;
        }

        .ztree li span.button.defaultSkin_ico_docu {
            margin-right: 2px;
            background-position: -110px -16px;
            vertical-align: top;
        }

    </style>

    <!-- loading start-->
    <style>
        html {
            overflow: auto;
        }

        body {
            overflow-y: auto
        }

        .loading {
            position: absolute;
            left: 50%;
            top: 50%;
            margin-left: -150PX;
            margin-top: -150PX;
            z-index: 55555555;
            display: none;
        }

        .position-relative {
            position: relative;
        }
    </style>

    <!-- loading end-->

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
    <script>
        function setOrderOrg() {
            var sale_type = $("select[name='sale_type']").val();
            if (sale_type != "") {
                $.post("<%=basePath%>item/getOrderOrg.do?sale_type=" + sale_type,
                    function (data) {
                        var obj = eval("(" + data.orderOrgs + ")");
                        var optStr = "";
                        for (var i = 0; i < obj.length; i++) {
                            optStr += "<option value='" + obj[i].id + "'";
                            optStr += ">" + obj[i].name + "</option>";
                            $("#order_org").empty();
                            $("#order_org").append(optStr);
                        }
                    }
                );
            }
        }
    </script>
</head>

<body class="gray-bg">
<input type="hidden" name="type" id="type">

<div class="col-sm-12" style="width: 100%;height: 100%;">

    <div class="form-control form-inline" style="margin-bottom: 15px;height:100%;padding:10px;">
        <!-- 搜索条件 -->

        <div class="col-sm-12">
            <div class="ibox float-e-margins" id="menuContent" class="menuContent"
                 style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
                <div class="ibox-content">
                    <div>
                        <input class="form-control" style="height: 30px" type="text" placeholder="搜索" id="keyWord"
                               onkeyup="searchTreeNodesByKeyWord()">
                        <ul id="myzTree" class="ztree" style="margin-top:0; width:160px;"></ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="ibox float-e-margins">
            <div class="ibox-content">

                <div class="col-lg-12">
                    <div class="form-group form-inline" style="margin-top: 15px;">
                        <label>审核条件:</label>
                        <select class="form-control" name="genjinstatus">
                            <option value="">请选择</option>
                            <option value="1">丢失</option>
                            <option value="2">延迟</option>
                            <option value="3">考察入围</option>
                            <option value="4">最终入围</option>
                            <option value="5">中标通知书</option>
                            <option value="6">合同谈判</option>
                            <option value="7">合同评审</option>
                            <option value="8">等待定金</option>
                            <option value="9">定金付出</option>
                            <option value="10">定金收到</option>
                        </select>
                    </div>
                </div>
                <br>
                <div class="col-lg-12">
                    <div class="form-group form-inline" style="margin-top: 15px;">
                        <label>梯种分类:</label>
                        <input id="model_id" name="model_id" type="hidden" value="">
                        <input id="model_name" name="model_name" type="hidden" value="">
                        <input id="modelSelect" name="modelSelect" type="text" value="" readonly
                               class="form-control" placeholder="请点击选择梯种分类" onclick="showMenu();">

                    </div>
                </div>
                <br><br>
                <div class="col-lg-12">
                    <label>销售类型:</label>
                    <select name="sale_type" class="form-control"
                            onchange="setOrderOrg();">
                        <option value="">请选择</option>
                        <option value="1">经销</option>
                        <option value="2">直销</option>
                        <option value="3">代销</option>
                    </select>
                </div>
                <br><br>
                <div class="col-lg-12">
                    <label>订购单位:</label>
                    <select name="order_org" id="order_org" class="form-control">
                        <option value="">请选择</option>
                    </select>
                </div>
                <br><br>
                <div class="col-lg-12" style="margin-top: 10px;margin-left: -10px;">
                    <a class="btn btn-warning btn-outline" style="margin-left: 10px; height:32px;" title="导出到Excel"
                       type="button"
                       target="_blank" onclick="toExcel(this);" href="javascript:;">导出</a>

                    <a class="btn btn-warning btn-outline" style="margin-left: 10px; height:32px;" title="下载指标模板"
                       type="button"
                       target="_blank" onclick="DownloadIndicatorTemplate(this);" href="javascript:;">下载指标模板</a>
                </div>
                <br><br>
                <div class="col-lg-12">
                    <label>导入指标:</label>
                    <form action="/report/importIndicator" id="indicatorForm" name="indicatorForm" method="post"
                          enctype="multipart/form-data">
                        <input type="file" id="excel" name="excel" onchange="importIndicator()"/>
                    </form>
                </div>
            </div>
            <div style="height: 20px;"></div>
        </div>

    </div>

</div>


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
    });

    function DownloadIndicatorTemplate(ele) {
        var url = "<%=basePath%>report/toIndicatorTemplate.do";
        $(ele).attr("href", url);
    }

    function onClick(e, treeId, treeNode) {
        $("#modelSelect").attr("value", treeNode.name);
        $("#model_name").attr("value", treeNode.name);
        $("#model_id").attr("value", treeNode.id);
    }

    function importIndicator() {
        var data = new FormData();
        data.append('excel', $("#excel").prop("files")[0]);
        $.ajax({
            type: 'post',
            url: '<%=basePath%>report/importIndicator.do',
            data: data,
            cache: false,
            processData: false,
            contentType: false,
            success: function (result) {
                $("#excel").val("");
                if (result.result == 'success') {
                    alert("导入指标成功");
                }
                else {
                    alert(result.msg);
                }
            },
            error: function () {
                $("#excel").val("");
                alert("网络异常");
            }
        })
    }

    function toExcel(ele) {
        var url = "<%=basePath%>report/toItemDetailReportExcel.do?";
        if ($("select[name='genjinstatus']").val() != '') {
            var genjinstatus = $("select[name='genjinstatus']").val();
            url = url + "&genjinstatus=" + genjinstatus
                + "&genjinstatus_text=" + $("select[name='genjinstatus'] option[value='"
                    + genjinstatus + "']").text();
        }
        if ($("#model_id").val() != '') {
            var model_id = $("#model_id").val();
            url = url + "&model_id=" + model_id + "&elevator_text="
                + $("#model_name").val();
        }
        if ($("select[name='sale_type']").val() != '') {
            var sale_type = $("select[name='sale_type']").val();
            url = url + "&sale_type=" + sale_type + "&sale_type_text="
                + $("select[name='sale_type'] option[value='" + sale_type + "']").text();
        }
        if ($("select[name='order_org']").val() != '') {
            var order_org = $("select[name='order_org']").val();
            url = url + "&order_org=" + order_org + "&order_org_text="
                + $("select[name='order_org'] option[value='" + order_org + "']").text();
        }
        $(ele).attr("href", url);
    }

    //ztree
    var setting = {
        view: {
            dblClickExpand: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClick,
            onClick: onClick
        }
    };

    var zNodes =${models};

    function beforeClick(treeId, treeNode) {
        return true;
    }

    function showMenu() {
        var orgObj = $("#modelSelect");
        var orgOffset = $("#modelSelect").offset();
        $("#menuContent").css({
            left: (orgOffset.left + 6) + "px",
            top: orgOffset.top + orgObj.outerHeight() + "px"
        }).slideDown("fast");

        $("body").bind("mousedown", onBodyDown);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
            hideMenu();
        }
    }

    function hideMenu() {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }

    // 树形结构搜索
    function searchTreeNodesByKeyWord() {

        if (zNodes.id == null) {
            return false;
        }
        // 将原树形结构恢复默认状态
        // 声明一个新的树对象
        var newZNodes = null;
        var zNode = orderSiblingsByUid(zNodes);
        // 将原树对象复制出一个副本，并将这个副本JSON字符串转换成新的树对象
        var treeJSON = cloneTreeNodes(zNode);
        newZNodes = eval('(' + '[' + treeJSON + ']' + ')');
        var root = newZNodes[0];
        // 对新树对象建立反向引用关系（在子节点中增加父节点的引用）
        var nodeMap = {};
        // 构造节点映射表（下面借助该映射表建立反向引用关系）
        nodeMap = buildNodeMap(root, nodeMap);
        // 建立子节点对父节点的引用
        nodeMap = buildParentRef(root, nodeMap);
        // 设置树节点为“不可见”状态
        setTreeNotVisible(root);
        // 搜索包含关键字的树节点，将包含关键字的节点所在路径设置为“可见”，例如：如果某一节点包含搜索关键字，
        // 那么它的所有上级节点和所有下级节点都设置为“可见”
        searchTreeNode(root, root, nodeMap, document.getElementById('keyWord').value);
        // 对树形结构数据进行搜索过滤后，根据JavaScript树状对象，重新生成JSON字符串
        treeJSON = reBuildTreeJSON(root);
        newZNodes = eval('(' + '[' + treeJSON + ']' + ')');
        $.fn.zTree.init($("#myzTree"), setting, newZNodes);
        $.fn.zTree.getZTreeObj("myzTree").expandAll(true);
    }

    // 将原树形结构数据复制出一个副本，以备对副本进行搜索过滤，而不破坏原始数据（原始数据用来恢复原状用）【先序遍历法】
    function cloneTreeNodes(root) {
        if (root.iconSkin != null && root.iconSkin != undefined) {
            var treeJSON = '{' + '\'name\' : \'' + root.name + '\', \'id\' : \'' + root.id + '\',' + '\'parent_id\' : \'' + root.parent_id + '\',' + ' \'orderNo\' : ' + root.orderNo + ', \'iconSkin\' : \'' + root.iconSkin + '\', \'nodeType\' : \'' + root.nodeType + '\'';
        } else {
            var treeJSON = '{' + '\'name\' : \'' + root.name + '\', \'id\' : \'' + root.id + '\',' + '\'parent_id\' : \'' + root.parent_id + '\',' + ' \'orderNo\' : ' + root.orderNo + ', \'iconSkin\' : ' + root.iconSkin + ', \'nodeType\' : \'' + root.nodeType + '\'';
        }
        if (root.children && root.children.length != 0) {
            treeJSON += ', \'children\' : [';
            for (var i = 0; i < root.children.length; i++) {
                treeJSON += cloneTreeNodes((root.children)[i]) + ',';
            }
            treeJSON = treeJSON.substring(0, treeJSON.length - 1);
            treeJSON += "]";
        }
        return treeJSON + '}';
    }

    // 构造节点映射表【先序遍历法】
    // 这里特殊说明一下：
    // 构造节点映射表的目的，是为了下面建立子节点对父节点的引用，这是一个中间步骤，但是有个小问题：
    // 在javascript中，如果是在原树状对象上建立子节点对父节点的引用，会发生『Stack overflow』错误，
    // 我估计是由于循环引用造成的，因为原树状对象已经存在父节点对子节点的引用，此时再建立子节点对
    // 父节点的引用，造成循环引用，这在Java中是没有问题的，但是在JavaScript中却有问题，所以为了避免
    // 这个问题，我创建了一批新的节点，这些节点的内容和原树状结构节点内容一致，但是没有children属性，
    // 也就是没有父节点对子节点的引用，然后对这批新节点建立子节点对父节点的引用关系，这个方法会被buildParentRef()方法调用，来完成这个目的。
    function buildNodeMap(node, nodeMap) {
        var newObj = new Object();
        newObj.name = node.name;
        newObj.id = node.id;
        newObj.parent_id = node.parent_id;
        newObj.orderNo = node.orderNo;
        newObj.ex_visible = node.ex_visible;
        nodeMap['_' + node.id] = newObj;
        if (node.children && node.children.length != 0) {
            for (var i = 0; i < node.children.length; i++) {
                buildNodeMap((node.children)[i], nodeMap);
            }
        }
        return nodeMap; // 这里需要将nodeMap返回去，然后传给buildParentRef()函数使用，这和Java中的引用传递不一样，怪异！！
    }

    // 建立子节点对父节点的引用
    function buildParentRef(node, nodeMap) {
        for (id in nodeMap) {
            if ((nodeMap[id]).parent_id == '') {
                (nodeMap[id]).ex_parentNode = null;
            } else {
                (nodeMap[id]).ex_parentNode = nodeMap['_' + (nodeMap[id]).parent_id];
            }
        }
        return nodeMap;
    }

    // 对树形结构数据进行搜索过滤后，根据JavaScript树状对象，重新生成JSON字符串【先序遍历法】
    function reBuildTreeJSON(node) {
        if (node.ex_visible) {
            if (node.iconSkin != null && node.iconSkin != undefined) {
                var treeJSON = '{' + '\'name\' : \'' + node.name + '\', \'id\': \'' + node.id + '\',' + '\'parent_id\' : \'' + node.parent_id + '\',' + ' \'orderNo\' : ' + node.orderNo + ', \'iconSkin\' : \'' + node.iconSkin + '\', \'nodeType\' : \'' + node.nodeType + '\', \'ex_visible\' : ' + node.ex_visible + ', \'ex_parentNode\' : null';
            } else {
                var treeJSON = '{' + '\'name\' : \'' + node.name + '\', \'id\': \'' + node.id + '\',' + '\'parent_id\' : \'' + node.parent_id + '\',' + ' \'orderNo\' : ' + node.orderNo + ', \'iconSkin\' : ' + node.iconSkin + ', \'nodeType\' : \'' + node.nodeType + '\', \'ex_visible\' : ' + node.ex_visible + ', \'ex_parentNode\' : null';
            }
            if (node.children && node.children.length != 0) {
                treeJSON += ', \'children\' : [';
                for (var i = 0; i < node.children.length; i++) {
                    if ((node.children)[i].ex_visible) {
                        treeJSON += reBuildTreeJSON((node.children)[i]) + ',';
                    } else {
                        treeJSON += reBuildTreeJSON((node.children)[i]);
                    }
                }
                treeJSON = treeJSON.substring(0, treeJSON.length - 1);
                treeJSON += "]";
            }
            return treeJSON + '}';
        } else {
            return '';
        }
    }

    // 搜索包含关键字的树节点，将包含关键字的节点所在路径设置为“可见”，例如：如果某一节点包含搜索关键字，
    // 那么它的所有上级节点和所有下级节点都设置为“可见”【先序遍历法】
    function searchTreeNode(root1, root2, nodeMap, keyWord) {
        if (root2.name.toLowerCase().indexOf(keyWord.toLowerCase()) > -1) {//大小写不敏感
//            if (root2.name.indexOf(keyWord) > -1) {//大小写敏感
            setTreeVisible(root2);
            setRouteVisible(root1, root2, nodeMap);
        } else {
            if (root2.children && root2.children.length != 0) {
                for (var i = 0; i < root2.children.length; i++) {
                    searchTreeNode(root1, (root2.children)[i], nodeMap, keyWord);
                }
            }
        }
    }

    // 设置树节点为“不可见”状态【先序遍历法】
    function setTreeNotVisible(root) {
        root.ex_visible = false;
        if (root.children && root.children.length != 0) {
            for (var i = 0; i < root.children.length; i++) {
                setTreeNotVisible((root.children)[i]);
            }
        }
    }

    // 设置树节点为“可见”状态【先序遍历法】
    function setTreeVisible(root) {
        root.ex_visible = true;
        if (root.children && root.children.length != 0) {
            for (var i = 0; i < root.children.length; i++) {
                setTreeVisible((root.children)[i]);
            }
        }
    }

    // 设置当前节点及其所有上级节点为“可见”状态
    function setRouteVisible(root, node, nodeMap) {
        node.ex_visible = true;
        var parentNodes = [];
        var currentNode = nodeMap['_' + node.id];
        var parentNode = currentNode.ex_parentNode;
        while (parentNode != null) {
            parentNodes.push(parentNode);
            parentNode = parentNode.ex_parentNode;
        }
        // 如果没有上级节点，说明当前节点就是根节点，直接返回即可
        if (parentNodes.length == 0) {
            return;
        }
        setParentNodesVisible(root, parentNodes);
    }

    // 设置所有上级节点为“可见”，
    // 这是由于在JavaScript中无法建立像Java中的那种带有双向引用的多叉树结构（即父节点
    // 引用子节点，子节点引用父节点），在JavaScript中如果做这种双向引用的话，会造成『Stack overflow』异常，所以只能分别建立
    // 两棵多叉树对象，一棵是原始树形结构对象，另一棵是利用nodeMap建立的多叉树对象，专门用于反向引用，即子节点对父节点的引用。
    // 而在Java中，直接可以根据一个节点的父节点引用，找到它所有的父节点。但是在这里，只能采用一种笨办法，先从反向引用的多叉树
    // 中找到某一节点的所有父节点，存在一个数组里，然后在原始树形结构对象中使用先序遍历方法，从顶向下依次查找，把某一节点的所有
    // 父节点设置为可见，效率较低，但与利用反向引用查找父节点的方法目的是一样的。
    function setParentNodesVisible(node, parentNodes) {
        if (containNode(node, parentNodes)) {
            node.ex_visible = true;
        }
        if (node.children && node.children.length != 0) {
            var i = 0;
            for (; i < node.children.length; i++) {
                if (containNode(node, parentNodes)) {
                    setParentNodesVisible((node.children)[i], parentNodes);
                }
            }
            // 如果在本层节点中没有找到要设置“可见性”的节点，说明需要设置“可见性”的节点都已经找完了，不需要再向下一层节点中寻找了，
            // 直接退出递归函数
            if (i == node.children.length - 1) {
                return;
            }
        }
    }

    // 检查数组中是否包含与指定节点编号相同的节点
    function containNode(node, parentNodes) {
        for (var i = 0; i < parentNodes.length; i++) {
            if (parentNodes[i].id == node.id) {
                return true;
            }
        }
        return false;
    }

    // 按照节点编号对树形结构进行兄弟节点排序【递归排序】
    function orderSiblingsByUid(node) {
        if (node.children && node.children.length != 0) {
            bubbleSortByUid(node.children);
            for (var i = 0; i < node.children.length; i++) {
                orderSiblingsByUid((node.children)[i]);
            }
        }
        return node;
    }

    // 排序方法：按照排序编号排序，排序编号小的排在前面，重复的按名称【冒泡法排序】
    function bubbleSortByUid(theArray) {
        var temp;
        for (var i = 0; i < theArray.length - 1; i++) {
            for (var j = theArray.length - 1; j > i; j--) {
                if (theArray[j].orderNo < theArray[j - 1].orderNo) {
                    temp = theArray[j];
                    theArray[j] = theArray[j - 1];
                    theArray[j - 1] = temp;
                }
            }
        }
        return theArray;
    }

    $(document).ready(function () {
        $.fn.zTree.init($("#myzTree"), setting, zNodes);
        $.fn.zTree.getZTreeObj("myzTree").expandAll(true);
    });

</script>
</body>

</html>
