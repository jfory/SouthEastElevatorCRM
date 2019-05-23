<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
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
        <title>${pd.SYSNAME}</title>
        <%--zTree--%>
        <link type="text/css" rel="stylesheet"
              href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css"/>
        <!-- Sweet Alert -->
        <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
        <style type="text/css">
            <%--add button for zTree--%>
            .ztree li span.button.add {
                margin-left: 2px;
                margin-right: -1px;
                background-position: -144px 0;
                vertical-align: top;
                *vertical-align: middle
            }
        </style>
    </head>
    <%--zTree--%>
    <script type="text/javascript"
            src="plugins/zTree/3.5.24/js/jquery.ztree.all.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert2/sweetalert2.js"></script>

    <script type="text/javascript">
        <%--zTree 配置--%>
        var setting = {
            view: {
                addHoverDom: addHoverDom,
                removeHoverDom: removeHoverDom,
                selectedMulti: false
            },
            edit: {
                enable: true,
                editNameSelectAll: true,
                showRemoveBtn: showRemoveBtn,
                showRenameBtn: showRenameBtn,
                editNameSelectAll: true
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                beforeEditName: beforeEditName,
                beforeRemove: beforeRemove,
                beforeClick: beforeClick
            }
        };
        //获取后台参数,传给zNodes对象
        var zNodes =${departments};
        var className = "dark";
        //编辑按钮被点击,该分部会被调用
        function beforeEditName(treeId, treeNode) {
            editByzTree(treeNode);
            return false;
        }
        //删除按钮点击,该方法会被调用
        function beforeRemove(treeId, treeNode) {
            var isRemove = delByzTree(treeNode);
            return false;
        }
        //删除权限
        var canRemove = (${QX.del} == 1)? true : false;
        //显示删除按钮
        function showRemoveBtn(treeId, treeNode) {
            return !treeNode.isParent && canRemove;
        }
        //修改权限
        var canRename = (${QX.edit} == 1)? true : false;
        //显示修改按钮
        function showRenameBtn(treeId, treeNode) {
            return canRename;
        }
        //获取系统时间
        function getTime() {
            var now = new Date(),
                    h = now.getHours(),
                    m = now.getMinutes(),
                    s = now.getSeconds(),
                    ms = now.getMilliseconds();
            return (h + ":" + m + ":" + s + " " + ms);
        }

        //新增权限
        var canAdd = (${QX.add} == 1)? true : false;
        //为新增按钮添加样式及事件
        function addHoverDom(treeId, treeNode) {
            if (canAdd) {
                var sObj = $("#" + treeNode.tId + "_span");
                if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
                var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
                        + "' title='add node' onfocus='this.blur();'></span>";
                sObj.after(addStr);
                var btn = $("#addBtn_" + treeNode.tId);
                if (btn) btn.bind("click", function () {
                    addByzTree(treeNode);
                    return false;
                });
            } else {
                return false;
            }
        }
        //移除新增按钮的事件
        function removeHoverDom(treeId, treeNode) {
            $("#addBtn_" + treeNode.tId).unbind().remove();
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
        //zTree新增
        function addByzTree(treeNode) {
            swal({
                title: "您将在[" + treeNode.name + "]下创建子节点\n请在下方填写名称和排序编号",
                type: "info",
                html: '<input id="swal-input1" type = "text" class="swal2-input" placeholder="请在这里输入名称" autofocus>' +
                '<input id="swal-input2" type = "number" class="swal2-input" placeholder="请在这里输入排序编号(数字)，默认为升序">',
                preConfirm: function (result) {
                    return new Promise(function (resolve) {
                        if (result) {
                            resolve([
                                $('#swal-input1').val(),
                                $('#swal-input2').val()
                            ]);
                        }
                    });
                }
            }).then(function (result) {
                if (result != undefined) {
                    var input1 = result[0];
                    var input2 = result[1];
                    if (input1 == "" || input2 == "") {
                        swal({
                            title: "错误！",
                            text: "你没有输入数据,请重新输入。",
                            type: "error",
                            showConfirmButton: false,
                            timer: 1000
                        });
                    } else {
                        var name = input1;
                        var orderNo = parseInt(input2);
                        //处理单引号和双引号
                        var index1 = name.indexOf("'");
                        var index2 = name.indexOf("\"");
                        if (index1>=0||index2>=0){
                            swal({
                                title: "错误！",
                                text: "不能输入英文单引号或双引号。",
                                type: "error",
                                showConfirmButton: false,
                                timer: 1000
                            });
                        }else{
                        var url = "<%=basePath%>department/addDepartment.do?parentId=" + treeNode.id+ "&name=" + name + "&orderNo=" + orderNo + "&tm=" + new Date().getTime();
                        $.get(url, function (data) {
                            if (data.msg == 'success') {
                                swal({
                                            title: "新增成功！",
                                            text: "您已经成功成功新增一条记录。",
                                            type: "success",
                                            timer: 1500
                                        }
                                ).then(function () {
                                    //后台获取最新数据,刷新zTree
                                    var url = "<%=basePath%>department/getAllDepartments.do";
                                    $.get(url, function (data) {
                                        if(data.msg=="success"){
                                            zNodes = JSON.parse(data.departments);
                                            searchTreeNodesByKeyWord();
                                        }else{
                                            swal({
                                                title: "数据更新出错,请刷新!",
                                                text: data.err,
                                                type: "error",
                                                showConfirmButton: false,
                                                timer: 1000
                                            });
                                        }

                                    });
                                });
                            } else {
                                swal({
                                    title: "新增失败!",
                                    text: data.err,
                                    type: "error",
                                    showConfirmButton: false,
                                    timer: 1000
                                });
                            }
                        });
                    }
                    }
                }
            })
        }
        //新增(顶部左上方新增按钮被点击)
        function add() {
            var parentId = $("#parentId").val();
            if (parentId == "" || parentId == null) {
                $("#parentId").tips({
                    side: 3,
                    msg: "请填写父类ID",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#parentId").focus();
                return false;
            }
            var name = $("#name").val();
            if (name == "" || name == null) {
                $("#name").tips({
                    side: 3,
                    msg: "请填写名称",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#name").focus();
                return false;
            }else {
                var index1 = name.indexOf("'");
                var index2 = name.indexOf("\"");
                if (index1>=0||index2>=0){
                    $("#name").tips({
                        side: 3,
                        msg: "不能输入英文单引号或双引号",
                        bg: '#AE81FF',
                        time: 2
                    });
                    $("#name").focus();
                    return false;
                }
            }
            var orderNo = $("#orderNo").val();
            if (orderNo == "" || orderNo == null) {
                $("#orderNo").tips({
                    side: 3,
                    msg: "请填写排序编号",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#orderNo").focus();
                return false;
            }
            var url = "<%=basePath%>department/addDepartment.do?parentId=" + parentId+ "&name=" + name + "&orderNo=" + orderNo + "&tm=" + new Date().getTime();
            $.get(url, function (data) {
                if (data.msg == 'success') {
                    swal({
                        title: "新增成功！",
                        text: "您已经成功新增一条记录。",
                        type: "success",
                        timer: 1500
                    }).then(function () {
                        if(zNodes.id ==null){
                            refreshCurrentTab();
                        }else{
                            //后台获取最新数据,刷新zTree
                            var url = "<%=basePath%>department/getAllDepartments.do";
                            $.get(url, function (data) {
                                if(data.msg=="success"){
                                    zNodes = JSON.parse(data.departments);
                                    searchTreeNodesByKeyWord();
                                }else{
                                    swal({
                                        title: "数据更新出错,请刷新!",
                                        text: data.err,
                                        type: "error",
                                        showConfirmButton: false,
                                        timer: 1000
                                    });
                                }

                            });
                        }
                    });
                } else {
                    $("#parentId").val('');
                    $("#parentId").text('');
                    swal({
                        title: "新增失败!",
                        text: data.err,
                        type: "error",
                        timer: 2000
                    });
                }
            });
        };
        //zTree修改
        function editByzTree(treeNode) {
            var name =treeNode.name.toString();
            swal({
                title: "您确定要修改[" + treeNode.name + "]吗？",
                type: "question",
                html: '名称:<input id="swal-input1" type = "text" class="swal2-input" value=' + treeNode.name + ' placeholder="请在这里输入名称" autofocus>' +
                '排序编号:<input id="swal-input2" type = "number" class="swal2-input" value = ' + treeNode.orderNo + ' placeholder="请在这里输入排序编号(数字)，默认为升序">',
                preConfirm: function (result) {
                    return new Promise(function (resolve) {
                        if (result) {
                            resolve([$('#swal-input1').val(),$('#swal-input2').val()]);
                        }
                    });
                }
            }).then(function (result) {
                if (result != undefined) {
                    var input1 = result[0];
                    var input2 = result[1];
                    if (input1 == "" || input2 == "") {
                        swal({
                            title: "错误！",
                            text: "你没有输入数据,请重新输入。",
                            type: "error",
                            showConfirmButton: false,
                            timer: 1000
                        });
                    } else {
                        var index1 = input1.indexOf("'");
                        var index2 = input1.indexOf("\"");
                        if (index1>=0||index2>=0){
                            swal({
                                title: "错误！",
                                text: "不能输入英文单引号或双引号。",
                                type: "error",
                                showConfirmButton: false,
                                timer: 1000
                            });
                        }else{
                            var id = treeNode.id;
                            var parentId = treeNode.parentId;
                            var newName = input1;
                            var newOrderNo = parseInt(input2);
                            var url = "<%=basePath%>department/editDepartment.do?id=" + id + "&name=" + newName + "&orderNo=" + newOrderNo + "&tm=" + new Date().getTime();
                            $.get(url, function (data) {
                                if (data.msg == 'success') {
                                    swal({
                                        title: "修改成功！",
                                        text: "您已经成功修改该条数据。",
                                        type: "success",
                                        timer: 1500
                                            }
                                    ).then(function () {
                                        //后台获取最新数据,刷新zTree
                                        var url = "<%=basePath%>department/getAllDepartments.do";
                                        $.get(url, function (data) {
                                            if(data.msg=="success"){

                                                zNodes = JSON.parse(data.departments);
                                                searchTreeNodesByKeyWord();
                                                //如果右边视图正在显示，则刷新右边视图
                                                if ($("#right_id").text() == id) {
                                                    $("#right_id").text(id);
                                                    $("#right_name").text(newName);
                                                    $("#right_parentId").text(parentId);
                                                    $("#right_orderNo").text(newOrderNo);
                                                }
                                            }else{
                                                swal({
                                                    title: "数据更新出错,请刷新!",
                                                    text: data.err,
                                                    type: "error",
                                                    showConfirmButton: false,
                                                    timer: 1000
                                                });
                                            }

                                        });
                                    });
                                } else {
                                    swal({
                                        title: "修改失败!",
                                        text: data.err,
                                        type: "error",
                                        showConfirmButton: false,
                                        timer: 1000
                                    });
                                }
                            });
                        }

                    }
                }
            })
        }
        ;
        //确认zTree删除
        function delByzTree(treeNode) {
            swal({
                title: "您确定要删除[" + treeNode.name + "]吗？",
                text: "删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                cancelButtonText: "取消"
            }).then(function (isConfirm) {
                if (isConfirm === true) {
                    var url = "<%=basePath%>department/delDepartment.do?id=" + treeNode.id + "&tm=" + new Date().getTime();
                    $.get(url, function (data) {
                        if (data.msg == "success") {

                            //隐藏右边视图
                            $("#rightdiv").css("display", "none");
                            swal({
                                title: "删除成功！",
                                text: "您已经成功删除了这条数据。",
                                type: "success",
                                showConfirmButton: false,
                                timer: 1000
                            }).then(function(){
                                //后台获取最新数据,刷新zTree
                                var url = "<%=basePath%>department/getAllDepartments.do";
                                $.get(url, function (data) {
                                    if(data.msg=="success"){
                                        zNodes = JSON.parse(data.departments);
                                        searchTreeNodesByKeyWord();
                                    }else{//如果只剩下一条数据被删除,则有可能返回failed,则进行页面刷新
                                        refreshCurrentTab();
                                    }

                                });
                            });

                        } else {
                            swal({
                                title: "删除失败！",
                                text: "您的删除操作失败了！",
                                type: "error",
                                showConfirmButton: false,
                                timer: 1000
                            });
                        }
                    });

                } else if (isConfirm === false) {
                    swal({
                        title: "取消删除！",
                        text: "您已经取消删除操作了！",
                        type: "error",
                        showConfirmButton: false,
                        timer: 1000
                    });
                }
            });
        }
        //节点被点中
        function beforeClick(treeId, treeNode, clickFlag) {
            $("#rightdiv").css("display", "block");
            $("#right_id").text(treeNode.id);
            $("#right_name").text(treeNode.name);
            $("#right_parentId").text(treeNode.parentId);
            $("#right_orderNo").text(treeNode.orderNo);
        }
        //折叠全部
        function collapseAll() {
            var zTree = $.fn.zTree.getZTreeObj("myzTree");
            zTree.expandAll(false);
        }
        //展开全部
        function expandAll() {
            var zTree = $.fn.zTree.getZTreeObj("myzTree");
            zTree.expandAll(true);
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
            var treeJSON = '{' + '\'name\' : \'' + root.name + '\', \'id\' : \'' + root.id + '\',' + '\'parentId\' : \'' + root.parentId + '\',' + ' \'orderNo\' : ' + root.orderNo;
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
                var treeJSON = '{' + '\'name\' : \'' + node.name + '\', \'id\': \'' + node.id + '\',' + '\'parentId\' : \'' + node.parentId + '\',' + ' \'orderNo\' : ' + node.orderNo + ', \'ex_visible\' : ' + node.ex_visible + ', \'ex_parentNode\' : null';
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
            if (root2.name.indexOf(keyWord) > -1) {
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
        //刷新iframe
        function refreshCurrentTab() {
            $("#departmentForm").submit();
        }
        //导出
        function toExcel(){
            /*$("#alink_toExcel").click();*/
            document.getElementById("alink_toExcel").click();
        }
        //触发导入
        function importDepartment(){
            $("#importFile").click();
        }
        function importExcel(e){
            var url = "<%=basePath%>department/importExcelDepartment.do";
            var filePath = $(e).val();
            console.log(filePath);
            var suffix = filePath.substring(filePath.lastIndexOf(".")).toLowerCase();
            var fileType = ".xls|.xlsx|";
            if(filePath == null || filePath == ""){
                return false;
            }
            if(fileType.indexOf(suffix+"|")==-1){
                var ErrMsg = "该文件类型不允许上传。请上传 "+fileType+" 类型的文件，当前文件类型为"+suffix; 
                $(e).val("");
                return false;
            }
            var data = new FormData();
            data.append("file", $(e)[0].files[0]);
            console.log($(e)[0].files[0]);
            $.ajax({
                url: url,
                type:"POST",
                data:data,
                cache: false,
                processData:false,
                contentType:false,
                success:function(result){
                    if(result.msg=="success"){
                        swal({
                            title:"导入成功!",
                            text:"导入数据成功。",
                            type:"success"
                        });
                    }else{
                        swal({
                            title:"导入失败!",
                            text:"导入数据失败,"+result.errorMsg,
                            type:"error"
                        });
                    }
                }
            });
        }

        $(document).ready(function () {
            //loading end
            parent.layer.closeAll('loading');
            $.fn.zTree.init($("#myzTree"), setting, zNodes);
            var zTree = $.fn.zTree.getZTreeObj("myzTree");
            zTree.expandAll(true);
        });
    </script>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div id="editDepartment" class="animated fadeIn"></div>
    <div class="row">
        <div class="col-sm-12">
            <!-- 上方新增、按钮视图 -->
            <c:choose>
                <c:when test="${QX.add == 1}">
                    <div class="ibox float-e-margins">
                        <div class="ibox-content" style="padding: 10px 10px 10px 10px;">
                            <form role="form" class="form-inline"
                                  action="department/listDepartments.do" method="post" name="departmentForm"
                                  id="departmentForm">
                                <div class="form-group ">
                                    <input autocomplete="off" id="keyWord" type="text" name="keyWord" style="max-width:150px;"
                                           placeholder="这里输入搜索关键字" class="form-control" onkeyup="searchTreeNodesByKeyWord()">
                                </div>
                                <div class="form-group">
                                    <button type="button" class="btn  btn-primary " onclick="searchTreeNodesByKeyWord();"
                                            style="margin-bottom: 0px;" title="搜索"><i style="font-size:18px;" class="fa fa-search"></i>
                                    </button>
                                </div>
                                <div class="form-group ">
                                    <label>父类ID:</label>
                                    <input autocomplete="off" id="parentId" type="number" name="parentId"
                                           placeholder="根节点父类ID为0" class="form-control" style="max-width:150px;">
                                </div>
                                <div class="form-group ">
                                    <label>名称:</label>
                                    <input autocomplete="off" id="name" type="text" name="name"
                                           placeholder="这里输入名称" class="form-control" style="max-width:200px;">
                                </div>
                                <div class="form-group ">
                                    <label>排序编号:</label>
                                    <input autocomplete="off" id="orderNo" type="number" name="orderNo"
                                           placeholder="这里输入排序编号" class="form-control" style="max-width:150px;">
                                </div>
                                <div class="form-group">
                                    <button type="button" class="btn  btn-primary " onclick="add();"
                                            style="margin-bottom: 0px;" title="新增">新增
                                    </button>
                                </div>
                                <div class="form-group" style="float: right;margin-right: 10px;">
                                    <button class="btn  btn-success" title="刷新" type="button"
                                            style="margin-bottom: 0px;" onclick="refreshCurrentTab();">刷新
                                    </button>
                                </div>
                                <div class="form-group" style="float: right;margin-right: 10px;">
                                    <button class="btn  btn-warning" title="折叠" type="button"
                                            style="margin-bottom: 0px;" onclick="collapseAll();">折叠
                                    </button>
                                </div>
                                <div class="form-group" style="float: right;margin-right: 10px;">
                                    <button class="btn  btn-info" title="展开" type="button"
                                            style="margin-bottom: 0px;" onclick="expandAll();">展开
                                    </button>
                                </div>
                                <div class="form-group" style="float: right;margin-right: 10px;">
                                    <button class="btn  btn-warning btn-outline" title="导出" type="button"
                                            style="margin-bottom: 0px;" onclick="toExcel();">导出
                                    </button>
                                    <a id="alink_toExcel" target="_blank" href="<%=basePath%>department/toExcelDepartment.do" style="display: none"><span></span></a>
                                </div>
                                <div class="form-group" style="float: right;margin-right: 10px;">
                                    <button class="btn  btn-info btn-outline" title="导入" type="button"
                                            style="margin-bottom: 0px;" onclick="importDepartment();">导入
                                    </button>
                                    <input style="display: none" class="form-control" type="file"  title="导入" id="importFile" onchange="importExcel(this)"/>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="ibox float-e-margins">
                        <div style="padding: 0px 10px 10px 10px;">
                            <form role="form" class="form-inline"
                                  action="department/listDepartments.do" method="post" name="departmentForm"
                                  id="departmentForm">
                                <div class="form-group" style="float: right;margin-right: 10px;">
                                    <button class="btn  btn-success" title="刷新" type="button"
                                            style="margin-bottom: 0px;" onclick="refreshCurrentTab();">刷新
                                    </button>
                                </div>
                                <div class="form-group" style="float: right;margin-right: 10px;">
                                    <button class="btn  btn-warning" title="折叠" type="button"
                                            style="margin-bottom: 0px;" onclick="collapseAll();">折叠
                                    </button>
                                </div>
                                <div class="form-group" style="float: right;margin-right: 10px;">
                                    <button class="btn  btn-info" title="展开" type="button"
                                            style="margin-bottom: 0px;" onclick="expandAll();">展开
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
            <!-- 左边zTree视图 -->
            <div id="leftdiv" name="leftdiv" class="col-sm-6" style="height:700px;overflow-y:scroll;overflow-x:auto;
            <c:choose>
            <c:when test='${not empty departments and (QX.cha == 1|| QX.edit == 1|| QX.del == 1||QX.add == 1)}'>display:block;</c:when>
            <c:otherwise>display:none;</c:otherwise>
            </c:choose>
                    ">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div id="myzTree" class="ztree"></div>
                    </div>
                </div>
            </div>
            <c:if test="${QX.cha == 1|| QX.edit == 1|| QX.del == 1||QX.add == 1}">
                <!-- 右边属性视图 -->
                <div id="rightdiv" name="rightdiv" class="col-sm-6" style="display:none">
                    <div class="ibox float-e-margins">
                        <div class="ibox-content">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>父类ID</th>
                                        <th>名称</th>
                                        <th>排序编号</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td id="right_id" name="right_id"></td>
                                        <td id="right_parentId" name="right_parentId"></td>
                                        <td id="right_name" name="right_name"></td>
                                        <td id="right_orderNo" name="right_orderNo"></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>


