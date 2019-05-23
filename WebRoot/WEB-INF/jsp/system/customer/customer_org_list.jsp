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
                selectedMulti: false
            },
            edit: {
                enable: true,
                editNameSelectAll: true,
                showRemoveBtn: showRemoveBtn,
                showRenameBtn: showRenameBtn
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

        var zNodes =${companys};

        var className = "dark";
        //编辑按钮被点击,该分部会被调用
        function beforeEditName(treeId, treeNode) {
//            editByzTree(treeNode);
            edit(treeNode.pId,treeNode.id);
            return false;
        }

        //修改
        function edit(pId,id){
            $("#editCustomerOrg").kendoWindow({
                width: "250px",
                height: "300",
                title: "修改",
                actions: ["Close"],
                content: '<%=basePath%>customerOrg/goEditCustomerOrg.do?pId='+pId+"&id="+id,
                modal : true,
                visible : false,
                resizable : true
            }).data("kendoWindow").center().open();
        }

        //删除按钮点击,该方法会被调用
        function beforeRemove(treeId, treeNode) {
        	<%--if(confirm("您确定要删除[" + treeNode.name + "]和其子节点吗？")){--%>
        		<%--$.post("<%=basePath%>customerOrg/delCustomerOrg.do?id="+treeNode.id,--%>
        				<%--function(){--%>
        					<%--return true;--%>
        				<%--}--%>
        		<%--);--%>
        	<%--}--%>
        	swal({
                        title: "您确定要删除[" + treeNode.name + "]和其子节点吗？",
                        text: "删除后将无法恢复，请谨慎操作！",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "删除",
                        cancelButtonText: "取消",
                        closeOnConfirm: false,
                        closeOnCancel: false
                    }).then(function (isConfirm) {
                        if(isConfirm==true){
                            var url = "<%=basePath%>customerOrg/delCustomerOrg.do?id="+treeNode.id;
                            $.get(url,function(data){
                                if(data.msg=='success'){
                                    swal({
                                        title: "删除成功！",
                                        text: "您已经成功删除了这条信息。",
                                        type: "success",
                                    }).then(function () {
                                        refreshCurrentTab();
                                    });
                                }else{
                                    swal("删除失败", "您的删除操作失败了！", "error").then(function () {
                                        refreshCurrentTab();
                                    });
                                }
                            });
                        }else if (isConfirm==false){
                            swal("取消删除", "您取消了删除的操作！", "warning").then(function () {
                                refreshCurrentTab();
                            });
                        }
                    });
                    
            
        }
        //删除权限
        var canRemove = (${QX.del} == 1)? true : false;

        //显示删除按钮
        function showRemoveBtn(treeId, treeNode) {
//            return !treeNode.isParent && canRemove;
                return true;
        }
        //修改权限
        var canRename = (${QX.edit} == 1)? true : false;
        //显示修改按钮
        function showRenameBtn(treeId, treeNode) {
//            return canRename;
                return true;
        }
        //节点被点中
        function beforeClick(treeId, treeNode, clickFlag) {
            $("#rightdiv").css("display", "block");
            $("#right_id").text(treeNode.id);
            $("#right_name").text(treeNode.name);
            $("#right_pId").text(treeNode.pId==null?'0':treeNode.pId);
            var type = treeNode.type;
            if(type=="Dveloper"){
                $("#right_type").text("开发商");
            }else if(type=="Core"){
                $("#right_type").text("战略客户");
            }else if(type=="Merchant"){
                $("#right_type").text("业主/经销商");
            }

        }

        $(document).ready(function () {
            //loading end
            parent.layer.closeAll('loading');
            $.fn.zTree.init($("#myzTree"), setting, zNodes);
            var zTree = $.fn.zTree.getZTreeObj("myzTree");
            zTree.expandAll(true);
        });

        //跳转新增
        function add(){
        	$("#editCustomerOrg").kendoWindow({
                width: "550px",
                height: "600px",
                title: "编辑",
                actions: ["Close"],
                content: '<%=basePath%>customerOrg/goAddCustomerOrg.do',
                modal : true,
                visible : false,
                resizable : true
            }).data("kendoWindow").center().open();
        }
        function collapseAll() {
            var zTree = $.fn.zTree.getZTreeObj("myzTree");
            zTree.expandAll(false);
        }
        //展开全部
        function expandAll() {
            var zTree = $.fn.zTree.getZTreeObj("myzTree");
            zTree.expandAll(true);
        }
        function refreshCurrentTab(){
        	window.location.reload();	
        }
    </script>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div id="editCustomerOrg" class="animated fadeIn"></div>
    <div class="row">
        <div class="col-sm-12">
        	<!-- 上方新增、按钮视图 -->
            <c:choose>
                <c:when test="${QX.add == 1}">
                    <div class="ibox float-e-margins">
                        <div class="ibox-content" style="padding: 10px 10px 10px 10px;">
                            <form role="form" class="form-inline"
                                  action="department/listDepartments.do" method="post" name="customerOrgForm"
                                  id="customerOrgForm">
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
            <c:when test='${not empty companys}'>display:block;</c:when>
            <c:otherwise>display:block;</c:otherwise>
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
                                        <th>类型</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td id="right_id" name="right_id"></td>
                                        <td id="right_pId" name="right_pId"></td>
                                        <td id="right_name" name="right_name"></td>
                                        <td id="right_type" name="right_type"></td>
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


