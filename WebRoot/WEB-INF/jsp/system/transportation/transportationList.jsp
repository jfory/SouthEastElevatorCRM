<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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
        <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
        <!-- 日期控件-->
        <script src="static/js/layer/laydate/laydate.js"></script>
        <title>${pd.SYSNAME}</title>
    </head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div id="zhjView" class="animated fadeIn"></div>
    <!-- 选择项目页面 -->
    <div id="xinjian" class="animated fadeIn"></div>
    <!-- 报价录入界面 -->
    <div id="addOffer" class="animated fadeIn"></div>

    <div id="EditShops" class="animated fadeIn"></div>
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-content">
                    <div id="top" ,name="top"></div>
                    <form role="form" class="form-inline" action="transportation/transportationList.do" method="post" name="shopForm" id="shopForm">

                        <div class="form-group ">
                            <input class="form-control" type="text"
                                   type="text" name="province_name" value="${pd.province_name}"
                                   placeholder="区域">
                        </div>
                        <div class="form-group ">
                            <input class="form-control" type="text"
                                   name="city_name" value="${pd.city_name}" style="margin-left:5px;"
                                   placeholder="目的地">
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn  btn-primary" title="查询"
                                    style="margin-left: 10px; height:32px;margin-top:3px;">查询</button>
                        </div>
                        <button class="btn  btn-success" title="刷新" type="button"
                                style="float: right" onclick="refreshCurrentTab();">刷新
                        </button>
                    </form>
                    <form role="form" class="form-inline" action="houseType/cell.do" method="post" name="houseType" id="houseType">
                        <input type="hidden" id="houses_no" name="houses_no" value="${pd.houses_no}"/>
                        <input type="hidden" id="hou_id" name="hou_id" value="${pd.hou_id}"/>
                    </form>
                    <div class="row">
                        </br>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th><input type="checkbox" name="zcheckbox"
                                           id="zcheckbox" class="i-checks"></th>
                                <th style="text-align:center;">区域</th>
                                <th style="text-align:center;">目的地</th>
                                <th style="text-align:center;">整车到货时间<br>(天)</th>
                                <th style="text-align:center;">5T车&nbsp;(元/车)<br>6.2-7.2米</th>
                                <th style="text-align:center;">8T车&nbsp;(元/车)<br>8.2-9.6米</th>
                                <th style="text-align:center;">10T车&nbsp;(元/车)<br>12.5米</th>
                                <th style="text-align:center;">20T车&nbsp;(元/车)<br>17.5米</th>
                                <th style="text-align:center;">零担<br>(元/每吨)</th>
                                <th style="text-align:center;">零担到货时间<br>(天)</th>
                                <th style="text-align:center;">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 开始循环 -->
                            <c:choose>
                                <c:when test="${not empty nonstandradList}">
                                    <c:if test="${QX.cha == 1 }">
                                        <c:forEach items="${nonstandradList}" var="e" varStatus="vs">

                                            <tr>
                                                <td class='center' style="width: 30px;">
                                                    <label>
                                                        <input
                                                                class="i-checks" type='checkbox' name='ids'
                                                                value="${e.id}" id="${e.id}"
                                                                alt="${e.id}" />
                                                        <span class="lbl"></span>
                                                    </label>
                                                </td>

                                                <td style="text-align:center;"> ${e.province_name}</td>
                                                <td style="text-align:center;">${e.city_name}</td>
                                                <td style="text-align:center;">${e.more_carLoad_time}</td>
                                                <td style="text-align:center;">${e.five_t}</td>
                                                <td style="text-align:center;">${e.eight_t}</td>
                                                <td style="text-align:center;">${e.ten_t}</td>
                                                <td style="text-align:center;">${e.twenty_t}</td>
                                                <td style="text-align:center;">${e.less_carLoad}</td>
                                                <td style="text-align:center;">
                                                        ${e.less_carLoad_time}
                                                </td>
                                                <td style="text-align:center;">
                                                    <c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in">
																<i class="icon-lock" title="无权限">无权限</i></span>
                                                    </c:if>
                                                    <!-- 1.待启动 -->
                                                        <c:if test="${QX.edit == 1 }">
                                                            <button class="btn  btn-primary btn-sm" title="编辑"
                                                                    type="button" onclick="edit('${e.id}','edit');">编辑
                                                            </button>
                                                            <button class="btn  btn-danger btn-sm" title="删除"
                                                                    type="button" onclick="delE_offer('${e.id}');">删除
                                                            </button>
                                                        </c:if>
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
                                        <td colspan="100" class="center">没有相关数据</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                        <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px">
                            <c:if test="${QX.del == 1 }">
                                <button class="btn  btn-danger" title="批量删除" type="button"
                                        onclick="makeAll('del');">批量删除</button>
                            </c:if>
                            <button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile()">导入</button>
                            <input style="display: none" class="form-control" type="file"  title="导入" id="importFile" onchange="importExcel(this)" accept="application/vnd.ms-excel"/>
                            <button class="btn  btn-success" title="下载数据模板" type="button" onclick="downFile()">下载模板</button>
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
    <a class="btn btn-warning btn-back-to-top"
       href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
        <i class="fa fa-chevron-up"></i>
    </a>
</div>
<!--返回顶部结束-->
<!-- Fancy box -->
<script src="static/js/fancybox/jquery.fancybox.js"></script>
<!-- iCheck -->
<script src="static/js/iCheck/icheck.min.js"></script>
<!-- Sweet alert -->
<script src="static/js/sweetalert2/sweetalert2.js"></script>
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
    $("#zcheckbox").on('ifChecked', function (event) {
        $('input').iCheck('check');
    });
    /* checkbox取消全选 */
    $("#zcheckbox").on('ifUnchecked', function (event) {
        $('input').iCheck('uncheck');
    });
    //刷新iframe
    function refreshCurrentTab() {
        $("#shopForm").submit();
    }


    //检索
    function search() {
        $("#shopForm").submit();
    }

    // 下载文件   e代表当前路径值
    function downFile() {
        var url="uploadFiles/file/DataModel/transportation/运输价格.xls";
        var name = window.encodeURI(window.encodeURI(url));
        window.open("customer/DataModel?url=" + name,"_blank");
    }
    //选择导入文件
    function inputFile(){
        $("#importFile").click();
    }

    //导入Excel
    function importExcel(e){
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
            alert(ErrMsg);
            return false;
        }
        var data = new FormData();
        data.append("file", $(e)[0].files[0]);
        console.log($(e)[0].files[0]);
        $.ajax({
            url:"<%=basePath%>transportation/importExcel.do",
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
                    }).then(function(){
                        refreshCurrentTab();
                    });
                }else if(result.msg=="allErr"){
                    swal({
                        title:"导入失败!",
                        text:"导入数据失败!"+result.errorUpload,
                        type:"error"
                    }).then(function(){
                        refreshCurrentTab();
                    });
                }else if(result.msg=="error"){
                    swal({
                        title:"部分数据导入失败!",
                        text:"错误信息："+result.errorUpload,
                        type:"warning"
                    }).then(function(){
                        refreshCurrentTab();
                    });
                }else if(result.msg=="exception"){
                    swal({
                        title:"导入失败!",
                        text:"导入数据失败!"+result.errorUpload,
                        type:"error"
                    }).then(function(){
                        refreshCurrentTab();
                    });
                }
            }
        });
    }

    //删除
    function delE_offer(tr_id) {
        swal({
                title: "您确定要删除该条数据吗？",
                text: "删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                cancelButtonText: "取消",
                closeOnConfirm: false,
                closeOnCancel: false
            }
            ).then(function (isConfirm) {
            if (isConfirm) {
                console.log("shit");
                $.ajax({
                    type: "POST",
                    url: '<%=basePath%>transportation/delTransportation.do',
                    data: {ids: tr_id},
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        if (data.msg == 'success') {
                            swal({
                                    title: "删除成功！",
                                    text: "您已经成功删除了该数据",
                                    type: "success",
                                }).then(function(){
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
            }
        }
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
                }).then(function (isConfirm) {
                    if (isConfirm) {
                        $.ajax({
                            type: "POST",
                            url: '<%=basePath%>transportation/delTransportation.do',
                            data: {ids: str},
                            dataType: 'json',
                            cache: false,
                            success: function (data) {
                                if (data.msg == 'success') {
                                    swal({
                                            title: "删除成功！",
                                            text: "您已经成功删除了这些数据",
                                            type: "success",
                                        }).then(function () {
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
        }
    }

    //导出到Excel
    function toExcel(){
        $.post("<%=basePath%>cell/toExcel.do");
    }


    //修改/查看
    function edit(id,operateType){
        $("#EditShops").kendoWindow({
            width: "800px",
            height: "500px",
            title: "编辑运输价格",
            actions: ["Close"],
            content: '<%=basePath%>transportation/preTransportation.do?id='+id+'&operateType='+operateType,
            modal : true,
            visible : false,
            resizable : true
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


