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
    <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css"/>
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
    <%--岗位选择zTree图标--%>
    <style type="text/css">
        .ztree li span.button.parentSkin_ico_open {
            margin-right: 2px;
            background-position: -110px -16px;
            vertical-align: top;
        }
        .ztree li span.button.parentSkin_ico_close {
            margin-right: 2px;
            background-position: -110px -16px;
            vertical-align: top;
        }
        .ztree li span.button.parentSkin_ico_docu {
            margin-right: 2px;
            background-position: -110px -16px;
            vertical-align: top;
        }
        .ztree li span.button.leafSkin_ico_open {
            margin-right: 2px;
            background: url(<%=basePath%>plugins/zTree/3.5.24//css/zTreeStyle/img/diy/greenStar.png) no-repeat scroll 0 0 transparent;
            vertical-align: top;
            *vertical-align: middle
        }
        .ztree li span.button.leafSkin_ico_close {
            margin-right: 2px;
            background: url(<%=basePath%>plugins/zTree/3.5.24//css/zTreeStyle/img/diy/greenStar.png) no-repeat scroll 0 0 transparent;
            vertical-align: top;
            *vertical-align: middle
        }
        .ztree li span.button.leafSkin_ico_docu {
            margin-right: 2px;
            background: url(<%=basePath%>plugins/zTree/3.5.24//css/zTreeStyle/img/diy/greenStar.png) no-repeat scroll 0 0 transparent;
            vertical-align: top;
            *vertical-align: middle
        }
        .ibox .open > .dropdown-menu {
		    left: 0 !important;
		    right: auto !important;
		}
    </style>

    <title>${pd.SYSNAME}</title>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp" %>

    <%--zTree--%>
    <script type="text/javascript"
            src="plugins/zTree/3.5.24/js/jquery.ztree.all.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert2/sweetalert2.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            if ($("#user_id").val() != "") {
                $("#loginname").attr("readonly", "readonly");
                $("#loginname").css("color", "gray");
            }
        });

        //保存
        function save() {
            var role = $("#ROLE_ID").val();
            $("#ROLE_ID_SELECTED").val(role);
            $("#ROLE_ID").val(role);
            if ($("#ROLE_ID").val()==null||$("#ROLE_ID").val() == "") {

                $("[data-id='ROLE_ID']").focus().blur();
                $("[data-id='ROLE_ID']").tips({
                    side: 3,
                    msg: '选择角色',
                    bg: '#AE81FF',
                    time: 2
                });
                return false;
            }
            if ($("#loginname").val() == "" || $("#loginname").val() == "此用户名已存在!") {

                $("#loginname").tips({
                    side: 3,
                    msg: '输入用户名',
                    bg: '#AE81FF',
                    time: 2
                });

                $("#loginname").focus();
                $("#loginname").val('');
                return false;
            } else {
                $("#loginname").val(jQuery.trim($('#loginname').val()));
            }
            if ($("#NUMBER").val() == "") {

                $("#NUMBER").tips({
                    side: 3,
                    msg: '输入编号',
                    bg: '#AE81FF',
                    time: 3
                });
                $("#NUMBER").focus();
                return false;
            }
            if ($("#user_id").val() == "" && $("#password").val() == "") {

                $("#password").tips({
                    side: 3,
                    msg: '输入密码',
                    bg: '#AE81FF',
                    time: 2
                });

                $("#password").focus();
                return false;
            }
            if ($("#password").val() != $("#chkpwd").val()) {

                $("#chkpwd").tips({
                    side: 3,
                    msg: '两次密码不相同',
                    bg: '#AE81FF',
                    time: 3
                });

                $("#chkpwd").focus();
                return false;
            }
            /*if ($("#POSITION_ID").val() == "") {

                $("#POSITION").tips({
                    side: 3,
                    msg: '输入岗位',
                    bg: '#AE81FF',
                    time: 2
                });
                $("#POSITION").focus();
                return false;
            }*/
            if ($("#name").val() == "") {

                $("#name").tips({
                    side: 3,
                    msg: '输入姓名',
                    bg: '#AE81FF',
                    time: 3
                });
                $("#name").focus();
                return false;
            }
            var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;
            if($("#PHONE").val()!=""){
                if ($("#PHONE").val().length != 11 && !myreg.test($("#PHONE").val())) {
                    $("#PHONE").tips({
                        side: 3,
                        msg: '手机号格式不正确',
                        bg: '#AE81FF',
                        time: 3
                    });
                    $("#PHONE").focus();
                    return false;
                }
            }
            if($("#EMAIL").val()!=""){
                if (!ismail($("#EMAIL").val())) {
                    $("#EMAIL").tips({
                        side: 3,
                        msg: '邮箱格式不正确',
                        bg: '#AE81FF',
                        time: 3
                    });
                    $("#EMAIL").focus();
                    return false;
                }
            }
            $("#userForm").submit();
        }

        function ismail(mail) {
            return (new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
        }

        //判断用户名是否存在
        function hasU() {
            var USERNAME = $("#loginname").val();
            var url = "<%=basePath%>sysUser/hasU.do?USERNAME=" + USERNAME + "&tm=" + new Date().getTime();
            $.get(url, function (data) {
                if (data == "error") {
                    $("#loginname").tips({
                        side: 3,
                        msg: '此用户名已存在!',
                        bg: '#AE81FF',
                        time: 1
                    });
                    $("#loginname").focus();
                }
            });
        }

        //判断邮箱是否存在
        function hasE(USERNAME) {
            var EMAIL = $("#EMAIL").val();
            var url = "<%=basePath%>sysUser/hasE.do?EMAIL=" + EMAIL + "&USERNAME=" + USERNAME + "&tm=" + new Date().getTime();
            $.get(url, function (data) {
                if (data == "error") {

                    $("#EMAIL").tips({
                        side: 3,
                        msg: '邮箱已存在',
                        bg: '#AE81FF',
                        time: 3
                    });

                    setTimeout("$('#EMAIL').val('')", 2000);

                }
            });
        }

        //判断编码是否存在
        function hasN(USERNAME) {
            var NUMBER = $("#NUMBER").val();
            var url = "<%=basePath%>sysUser/hasN.do?NUMBER=" + NUMBER + "&USERNAME=" + USERNAME + "&tm=" + new Date().getTime();
            $.get(url, function (data) {
                if (data == "error") {

                    $("#NUMBER").tips({
                        side: 3,
                        msg: '编号已存在',
                        bg: '#AE81FF',
                        time: 3
                    });
                    $("#NUMBER").focus();
                    setTimeout("$('#NUMBER').val('')", 2000);

                }
            });
        }

        function CloseSUWin(id) {
            window.parent.$("#" + id).data("kendoWindow").close();
            /* 	window.parent.location.reload(); */
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

        var zNodes =${positions};

        function beforeClick(treeId, treeNode) {
            var check = (treeNode && treeNode.nodeType=="position");
//            if (!check) {
//                swal({
//                    title: "不能选择["+treeNode.name+"]！",
//                    text: "请重新选择",
//                    type: "error",
//                    showConfirmButton: false,
//                    timer: 1500
//                });
//            }
            return check;
        }

        function onClick(e, treeId, treeNode) {
            var positionObj = $("#POSITION");
            positionObj.attr("value", treeNode.name+" ("+treeNode.getParentNode().name+")");
            var positionId = $("#POSITION_ID");
            positionId.attr("value", treeNode.id);

        }
        function showMenu() {
            var deptObj = $("#POSITION");
            var deptOffset = $("#POSITION").offset();
//            $("#menuContent").css({left:(deptOffset.left+6) + "px", top:deptOffset.top + deptObj.outerHeight() + "px"}).slideDown("fast");
            $("#menuContent").slideDown("fast");

            $("body").bind("mousedown", onBodyDown);
        }
        function onBodyDown(event) {
            if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
                hideMenu();
            }
        }
        function hideMenu() {
            $("#menuContent").fadeOut("fast");
            $("body").unbind("mousedown", onBodyDown);
        }
        // 树形结构搜索
        function searchTreeNodesByKeyWord() {

            if(zNodes.id == null){
                return false;
            }
            // 将原树形结构恢复默认状态
            // 声明一个新的树对象
            var newZNodes = null;
            var zNode= orderSiblingsByUid(zNodes);
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
            if(root.iconSkin!=null&&root.iconSkin!=undefined){
                var treeJSON = '{' + '\'name\' : \'' + root.name + '\', \'id\' : \'' + root.id + '\',' + '\'parentId\' : \'' + root.parentId + '\',' + ' \'orderNo\' : ' + root.orderNo+ ', \'iconSkin\' : \'' + root.iconSkin+ '\', \'nodeType\' : \'' + root.nodeType+'\'';
            }else{
                var treeJSON = '{' + '\'name\' : \'' + root.name + '\', \'id\' : \'' + root.id + '\',' + '\'parentId\' : \'' + root.parentId + '\',' + ' \'orderNo\' : ' + root.orderNo+ ', \'iconSkin\' : ' + root.iconSkin+ ', \'nodeType\' : \'' + root.nodeType+'\'';
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
            newObj.parentId = node.parentId;
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
                if ((nodeMap[id]).parentId == '') {
                    (nodeMap[id]).ex_parentNode = null;
                } else {
                    (nodeMap[id]).ex_parentNode = nodeMap['_' + (nodeMap[id]).parentId];
                }
            }
            return nodeMap;
        }
        // 对树形结构数据进行搜索过滤后，根据JavaScript树状对象，重新生成JSON字符串【先序遍历法】
        function reBuildTreeJSON(node) {
            if (node.ex_visible) {
                if(node.iconSkin!=null&&node.iconSkin!=undefined){
                    var treeJSON = '{' + '\'name\' : \'' + node.name + '\', \'id\': \'' + node.id + '\',' + '\'parentId\' : \'' + node.parentId + '\',' + ' \'orderNo\' : ' + node.orderNo + ', \'iconSkin\' : \'' + node.iconSkin + '\', \'nodeType\' : \'' + node.nodeType + '\', \'ex_visible\' : '  + node.ex_visible + ', \'ex_parentNode\' : null';
                }else{
                    var treeJSON = '{' + '\'name\' : \'' + node.name + '\', \'id\': \'' + node.id + '\',' + '\'parentId\' : \'' + node.parentId + '\',' + ' \'orderNo\' : ' + node.orderNo + ', \'iconSkin\' : ' + node.iconSkin + ', \'nodeType\' : \'' + node.nodeType + '\', \'ex_visible\' : ' + node.ex_visible +', \'ex_parentNode\' : null';
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

        $(document).ready(function(){
            $.fn.zTree.init($("#myzTree"), setting, zNodes);
            $.fn.zTree.getZTreeObj("myzTree").expandAll(true);
        });
    </script>
</head>

<body class="gray-bg">
<form action="sysUser/${msg }.do" name="userForm" id="userForm" method="post">
    <input type="hidden" name="USER_ID" id="user_id" value="${pd.USER_ID }"/>
    <input type="hidden" name="POSITION_ID" id="POSITION_ID" value="${pd.POSITION_ID}"/>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">

                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
                                <c:if test="${fx != 'head'}">
                                    <c:if test="${pd.ROLE_ID != '1'}">
                                        <div class="form-group" style="margin-bottom: 8px;">
                                            <label style="width: 10%">角色&nbsp;&nbsp;</label>

                                            <select  name="ROLE_ID" id="ROLE_ID"  class="selectpicker" multiple data-live-search="true" data-live-search-placeholder="查找" data-actions-box="true">
                                                <c:forEach items="${roleList}" var="roleL">
                                                	<c:if test="${roleL.PARENT_ID=='0' }">
	                                                	<optgroup label="${roleL.ROLE_NAME }">
		                                                	<c:forEach items="${roleList}" var="role">
			                                                	<c:if test="${roleL.ROLE_ID==role.PARENT_ID }">
			                                                		<option value="${role.ROLE_ID }"
			                                                            <c:forEach items="${roleIdList}" var="roleId">
			                                                                ${role.ROLE_ID==roleId?'selected':''}
			                                                            </c:forEach>
			                                                        >
			                                                            ${role.ROLE_NAME }
			                                                        </option>
			                                                     
			                                                	</c:if>
		                                                	</c:forEach>
	                                                	</optgroup>
                                                	</c:if>
                                                </c:forEach>
                                                
                                                  <!-- <optgroup label="角色列表">
                                                    <c:forEach items="${roleList}" var="role">
                                                        <option value="${role.ROLE_ID }"
                                                            <c:forEach items="${roleIdList}" var="roleId">
                                                                ${role.ROLE_ID==roleId?'selected':''}
                                                            </c:forEach>
                                                        >
                                                            ${role.ROLE_NAME }
                                                        </option>
                                                    </c:forEach>
                                                </optgroup>
                                              <option value="">请选择角色</option>
                                                <c:forEach items="${roleList}" var="role">
                                                    <option value="${role.ROLE_ID }" <c:if test="${role.ROLE_ID == pd.ROLE_ID }">selected</c:if>>${role.ROLE_NAME }</option>
                                                </c:forEach> -->
                                            </select>

                                            <input type="hidden" id="ROLE_ID_SELECTED" name="ROLE_ID_SELECTED"> 
                                        </div>

                                    </c:if>
                                    <%--系统管理员--%>
                                    <c:if test="${pd.ROLE_ID == '1'}">
                                        <input name="ROLE_ID" id="ROLE_ID" value="1" type="hidden"/>
                                    </c:if>
                                </c:if>

                                <c:if test="${fx == 'head'}">
                                    <input name="ROLE_ID" id="ROLE_ID" value="${pd.ROLE_ID }" type="hidden"/>
                                </c:if>

                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                        <label style="width: 10%">用户名:</label>
                                        <input style="width: 80%" type="text" name="USERNAME" id="loginname" value="${pd.USERNAME }" <c:if test="${msg == 'saveU'}">onblur="hasU()"</c:if>  placeholder="这里输入用户名" class="form-control">
                                    </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 10%">编号</label>
                                    <input style="width: 80%" type="text" name="NUMBER" id="NUMBER" value="${pd.NUMBER }" maxlength="32" onblur="hasN('${pd.USERNAME }')" placeholder="这里输入编号" class="form-control">
                                </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 10%">密码</label>
                                    <input style="width: 80%" type="password" name="PASSWORD" id="password" maxlength="32" placeholder="输入密码" class="form-control">
                                </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 10%">确认密码</label>
                                    <input style="width: 80%" type="password" name="chkpwd" id="chkpwd" maxlength="32" placeholder="确认密码" class="form-control">
                                </div>
                                 <c:choose>
                                <c:when test="${pd.ROLE_ID=='06e6e74a24674ae2ac65e66667261911' && fx=='head'}">
                                    <input type="hidden" value="${pd.POSITION }" name="POSITION" id="POSITION"/>
                                </c:when>
                                <c:otherwise>


                                <div class="form-group form-inline" style="margin-bottom: 8px;position: relative;">
                                    <label style="width: 10%">岗位</label>
                                    <c:choose>
                                        <c:when test="${not empty pd.POSITION_ID}">
                                            <input style="width: 80%" type="text" value="${pd.POSITION}" readonly name="POSITION" id="POSITION" class="form-control" placeholder="请点击选择岗位" onclick="showMenu();">
                                        </c:when>
                                        <c:otherwise>
                                            <input style="width: 80%" type="text" value="" readonly name = "POSITION" id="POSITION" class="form-control" placeholder="请点击选择岗位" onclick="showMenu();">
                                        </c:otherwise>
                                    </c:choose>

                                        <%--岗位选择start--%>
                                    <div class="ibox float-e-margins" id="menuContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto;left: 10%">
                                        <div class="ibox-content">
                                            <div>
                                                <input class="form-control" style="height: 30px" type="text" placeholder="搜索" id="keyWord" onkeyup="searchTreeNodesByKeyWord()">
                                                <ul id="myzTree" class="ztree" style="margin-top:0; width:160px;"></ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                </c:otherwise>
                                </c:choose>
                                <%--岗位选择end--%>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 10%">姓名</label>
                                    <input style="width: 80%" type="text" name="NAME" id="name" value="${pd.NAME }" maxlength="32" placeholder="这里输入姓名" class="form-control">
                                </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 10%">手机号</label>
                                    <input style="width: 80%" type="number" name="PHONE" id="PHONE" value="${pd.PHONE }" maxlength="32" placeholder="这里输入手机号" class="form-control">
                                </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 10%">邮箱</label>
                                    <input style="width: 80%" type="email" name="EMAIL" id="EMAIL" value="${pd.EMAIL }" maxlength="32" placeholder="这里输入邮箱" class="form-control">
                                </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 10%">备注</label>
                                    <input style="width: 80%" type="text" name="BZ" id="BZ" value="${pd.BZ }" placeholder="这里输入备注" maxlength="64" class="form-control">
                                </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                <c:choose>
                                <c:when test="${pd.ROLE_ID=='06e6e74a24674ae2ac65e66667261911' && fx=='head'}">
                                    <input type="hidden" value="${pd.STATUS }" name="STATUS" id="STATUS"/>
                                    </c:when>
                                <c:otherwise>
                                    <label style="width: 10%">状态</label>
                                    <select style="width: 80%" class="form-control m-b" name="STATUS" id="STATUS">
                                        <option value="1" <c:if test="${pd.STATUS == 1 }">selected</c:if>>正常</option>
                                        <option value="0" <c:if test="${pd.STATUS == 0 }">selected</c:if>>冻结</option>
                                    </select>
                                </c:otherwise>
                                </c:choose>
                                </div>

                            </div>

                        </div>

                    </div>
                    <div style="height: 10px;"></div>
                    <tr>
                        <td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;" onclick="save();">保存</a></td>
                        <c:if test="${msg eq 'saveU'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddUsers');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'editU'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditUsers');">关闭</a></td>
                        </c:if>

                    </tr>
                </div>
            </div>

        </div>
    </div>
</form>
</body>

</html>
