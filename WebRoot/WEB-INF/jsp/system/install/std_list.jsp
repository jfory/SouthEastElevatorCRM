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
    <!-- 图片插件 -->
    <link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
    <title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg" >
    <div id="EditStandard" class="animated fadeIn"></div>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div id="top" name="top">
                        <form role="form" class="form-inline" action="install/listStandard.do" method="post" name="StandardForm" id="StandardForm">
                            <button class="btn  btn-success" title="刷新" type="button" style="float:right;margin-left: 752px" onclick="refreshCurrentTab();">刷新</button>
                        </form>
                        </div>
                        <div class="table-responsive" style="width:100%">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
                                        <th style="width:15%;">编号</th>
                                        <th style="width:15%;">型号</th>
                                        <th style="width:10%;">型号类型</th>
                                        <th style="width:15%;">操作</th>  
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty stdList}">
                                            <c:if test="${QX.cha == 1 }">
                                                <c:forEach items="${stdList}" var="var" >
                                                    <tr>
                                                        <td><input type="checkbox" class="i-checks" name='ids' id='${var.id }' value='${var.id }' ></td>
                                                        <td>${var.id}</td>
                                                        <td>${var.models_id}</td>
                                                        <td>${var.flag}</td>
                                                        <td>
                                                            <c:if test="${QX.edit != 1 && QX.del != 1 }">
                                                                <span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
                                                            </c:if>
                                                            <div>
                                                                <c:if test="${QX.edit == 1 }">
                                                                    <button class="btn btn-sm btn-primary btn-sm" title="编辑" type="button" onclick="edit('${var.id}');">编辑</button>
                                                                </c:if>
                                                                <c:if test="${QX.del == 1 }">
                                                                    <button class="btn btn-sm btn-danger btn-sm" title="删除" type="button" onclick="del('${var.id}')">删除</button>
                                                                </c:if>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${QX.cha == 0 }">
                                                <tr>
                                                    <td colspan="100" class="center">您无权查看</td>
                                                </tr>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <tr class="main_info">
                                                <td colspan="100" class="center" >没有相关数据</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                            <div class="col-lg-12" style="padding-left:0px;padding-right:0px">
                                <c:if test="${QX.add == 1 }">
                                    <button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button>
                                </c:if>
                                <!-- <c:if test="${QX.del == 1 }">
                                    <button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>                       
                                </c:if> -->
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
     });

     /* checkbox全选 */
     $("#zcheckbox").on('ifChecked', function(event){
        
        $('input').iCheck('check');
    });
     /* checkbox取消全选 */
     $("#zcheckbox").on('ifUnchecked', function(event){
        
        $('input').iCheck('uncheck');
    });


     //新增
     function add(){
        $("#EditStandard").kendoWindow({
            width: "550px",
            height: "300px",
            title: "规格设置",
            actions: ["Close"],
            content: '<%=basePath%>install/goAddStandard.do',
            modal : true,
            visible : false,
            resizable : true
        }).data("kendoWindow").maximize().open();
     }
     
    //检索
    function search(){
        $("#SelfcheckForm").submit();
    }
    //刷新iframe
    function refreshCurrentTab() {
        $("#SelfcheckForm").submit();
    }

    function CloseSUWin() {
        window.parent.$("#SelfcheckReport").data("kendoWindow").close();
        /*  window.parent.location.reload(); */
    }
    </script>
</body>

</html>
