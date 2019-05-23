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
                *vertical-align: middle;
            }


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


        </style>
    </head>
    <%--zTree--%>
    <script type="text/javascript" src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
    <!-- <script type="text/javascript" src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
    <script type="text/javascript" src="plugins/zTree/3.5.24/js/jquery.ztree.exhide.js"></script>
    <script type="text/javascript" src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script> -->
    <script type="text/javascript"
            src="plugins/zTree/3.5.24/js/jquery.ztree.all.js"></script>
    <!-- Sweet alert -->
    <!-- <script src="static/js/sweetalert2/sweetalert2.js"></script> -->

    <script type="text/javascript">
        var selectArray = new Array();
        var disselectArray = new Array();

		var setting = {
			    data:{
			    	enable:true
			    },
			    check:{
			    	enable:true,
                    chkStyle:"checkbox",
                    chkboxType:{"Y":"p","N":"p"}
			    },
                callback:{
                    onCheck:zTreeOnCheck
                }
			};
		var zTreeNodes = ${users};
        var zTree;


		$(document).ready(function () {
            //loading end
            parent.layer.closeAll('loading');
            zTree = $.fn.zTree.init($("#myzTree"), setting, zTreeNodes);
            zTree.expandAll(true);
        });

        function checkAllNode(flag){
            var index = layer.load(1);
            var operateType = flag;
            var roleId = $("#ROLE_ID").val();
            var treeObj = $.fn.zTree.getZTreeObj("myzTree");
            var treeNode = treeObj.getNodesByFilter(function(node){return node.level == 0},true);
            var userId = treeNode.id;
            var userIds = "";
            url = "<%=basePath%>role/checkRoleUser.do";
            for(var i = 0;i<treeNode.children.length;i++){
                userIds += treeNode.children[i].id+",";
            }
            $.post(url,
                {
                    "roleId":roleId,
                    "userId":userId,
                    "userIds":userIds,
                    "operateType":operateType
                },
                function(data){
                if(data.msg=='error'){
                    alert('操作错误,请稍后重试');
                    layer.close(index);
                }else if(data.msg=='success'){
                    /*treeObj.refresh();*/
                    refreshZtree(roleId);
                    layer.close(index);
                }
            });
        }

        function refreshZtree(roleId){
            $.post("<%=basePath%>role/refreshTreeJson?ROLE_ID="+roleId,
                    function(data){
                        var jsonObj = eval('('+data.users+')');
                        zTreeNodes = jsonObj;
                        zTree = $.fn.zTree.init($("#myzTree"), setting, zTreeNodes);
                        zTree.expandAll(true);
                    }
                );
        }

        function zTreeOnCheck(event, treeId, treeNode) {
            var index = layer.load(1);
            var roleId = $("#ROLE_ID").val();
            var userId = treeNode.id;
            var userIds = "";
            var operateType;
            var url;
            if(treeNode.id!=0){
                if(treeNode.checked){
                    operateType="add";
                }else{
                    operateType="delete";
                }
                url = "<%=basePath%>role/checkRoleUser.do?roleId="+roleId+"&userId="+userId+"&operateType="+operateType+"&userIds="+userIds;
                $.post(url,function(data){
                    if(data.msg=='error'){
                        layer.close(index);
                        alert('操作错误,请稍后重试');
                    }else if(data.msg=='success'){
                        layer.close(index);
                        zTree.refresh();
                    }
                    refreshZtree(roleId);
                });
            }
        }


        // 树形结构搜索
        function searchTreeNodesByKeyWord() {
        if(zTreeNodes.id == null){
            return false;
        }
        /*var ROLE_ID = $("#ROLE_ID").val();
        var NAME = $("#keyWord").val();
        alert(NAME);*/
        var url = "<%=basePath%>role/getUserListByName.do";
        var zTreeJSON;
        // 声明一个新的树对象
        var newZNodes = null;
        $.post(url,
                {
                    ROLE_ID:$("#ROLE_ID").val(),
                    NAME:$("#keyWord").val()

                },
            function(data){
            if(data.msg=="success"){
                zTreeJSON = eval('('+ data.searchUsers+ ')');
                // 将原树对象复制出一个副本，并将这个副本JSON字符串转换成新的树对象
                var treeJSON = cloneTreeNodes(zTreeJSON);
                var zNode= orderSiblingsByUid(treeJSON);
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
                treeJSON = '{ \'nocheck\':\'true\','+treeJSON.substring(1,treeJSON.length);
                console.log(treeJSON);
                newZNodes = eval('(' + '[' + treeJSON + ']' + ')');
                zTree = $.fn.zTree.init($("#myzTree"), setting, newZNodes);
                zTree = $.fn.zTree.getZTreeObj("myzTree").expandAll(true);
            }else{
                alert("操作错误,请稍后重试");
            }
        });

        
    }
    // 将原树形结构数据复制出一个副本，以备对副本进行搜索过滤，而不破坏原始数据（原始数据用来恢复原状用）【先序遍历法】
    function cloneTreeNodes(root) {
        var treeJSON = '{' + '\'name\' : \'' + root.name + '\', \'id\' : \'' + root.id + '\',' + '\'pId\' : \'' + root.pId + '\', \'checked\' : \'' + root.checked+'\','+'\'orderNo\' : \'' + root.orderNo + '\'';
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
            var treeJSON = '{' + '\'name\' : \'' + node.name + '\', \'id\': \'' + node.id + '\',' + '\'pId\' : \'' + node.pId + '\', \'checked\' : \'' + node.checked + '\', \'orderNo\' : \''+node.orderNo+'\',\'ex_visible\' : '  + node.ex_visible + ', \'ex_parentNode\' : null';
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
        if (root2.children && root2.children.length != 0) {
            for(var i = 0;i<root2.children.length;i++){
                if(root2.children[i].name.indexOf(keyWord) > -1){
                    setTreeVisible(root2.children[i]);
                    setRouteVisible(root1, root2, nodeMap);
                }
            }
        }
    }
    // 设置树节点为“不可见”状态【先序遍历法】
    function setTreeNotVisible(root) {
        root.ex_visible = true;
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

        //保存
		function save(){
			var zTree = $.fn.zTree.getZTreeObj("myzTree");
			/*var nodes = zTree.getCheckedNodes(true);*/
			var changeNodes = zTree.getChangeCheckedNodes();
			var ROLE_ID = $("#ROLE_ID").val();
			/*var ids = "";*/
			var selectIds = "";
			var disselectIds = "";
			/*for(var i = 0;i<nodes.length;i++){
				ids += nodes[i].id+","
			}*/
			for(var j = 0;j<changeNodes.length;j++){
				if(changeNodes[j].checked){
					selectIds += changeNodes[j].id+",";
				}else{
					disselectIds += changeNodes[j].id+",";
				}
			}
			selectIds = selectIds.substr(0,selectIds.length-1);
			disselectIds = disselectIds.substr(0,disselectIds.length-1);
			/*$.post("<%=basePath%>role/editRoleUser.do?selectIds="+selectIds+"&disselectIds="+disselectIds+"&ROLE_ID="+ROLE_ID,function(data){
					CloseSUWin('EditRoleUser');
			});*/
		}
		//关闭页面
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
			/* window.location.reload();  */
		}


</script>


<body class="gray-bg">
<div id="leftdiv" name="zTreeDiv" class="col-sm-6" style="height:95%;overflow-y:scroll;overflow-x:auto;">
<input type="hidden" value="${pd.ROLE_ID}" name="ROLE_ID" id="ROLE_ID">
    <div class="form-group form-inline">
            <input autocomplete="off" id="keyWord" type="text" name="keyWord" style="max-width:150px;display: inline-block;margin-top: 10px"
                       placeholder="这里输入搜索关键字" class="form-control" onkeyup="searchTreeNodesByKeyWord()">
            <button type="button" class="btn  btn-primary " style="margin-top:-4px" onclick="searchTreeNodesByKeyWord();"
                title="搜索"><i style="font-size:18px;" class="fa fa-search"></i>
            </button>
            <input type="button" style="margin-bottom:4px" class="btn btn-primary" value="全部设置" onclick="checkAllNode('addAll');">
            <input type="button" style="margin-bottom:4px" class="btn btn-primary" value="全部取消" onclick="checkAllNode('deleteAll');">
    </div>
    <div class="ibox float-e-margins">
        <div class="ibox-content">
            <div id="myzTree" class="ztree"></div>
        </div>
    </div>
</div>
</div>
</div>
</body>

</html>
