<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
        <link href="static/js/sweetalert2/sweetalert2.min.css" rel="stylesheet">
        <title>${pd.SYSNAME}</title>
    </head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div id="EditShops" class="animated fadeIn"></div>
    <!-- 选择项目页面 -->
    <div id="xinjian" class="animated fadeIn"></div>
    <!-- 报价录入界面 -->
    <div id="addOffer" class="animated fadeIn"></div>

    <div id="ImportExcel" class="animated fadeIn"></div>
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-content">
                    <div id="top" ,name="top"></div>
                    <form role="form" class="form-inline" action="e_offer/e_offerList.do" method="post" name="shopForm"
                          id="shopForm">

                        <div class="form-group ">
                            <input class="form-control" type="text" id="nav-search-input"
                                   type="text" name="item_name" value="${pd.item_name}"
                                   placeholder="项目名称">
                        </div>
                        <div class="form-group ">
                            <input class="form-control" id="nav-search-input" type="text"
                                   name="user_name" value="${pd.user_name}" style="margin-left:5px;"
                                   placeholder="业务员">
                        </div>
                        <div class="form-group ">
                            <input class="form-control" type="text" id="nav-search-input"
                                   type="text" name="seloffer_no" value="${pd.seloffer_no}" placeholder="报价编号">
                        </div>
                        <div class="form-group ">
                            <select class="form-control" id="nav-search-input" name="instance_status"
                                    style="margin-left:5px;">
                                <option value="">审核状态</option>
                                <option value="1" ${pd.instance_status=="1"?"selected='selected'":""}>待启动</option>
                                <option value="2" ${pd.instance_status=="2"?"selected='selected'":""}>待审核</option>
                                <option value="3" ${pd.instance_status=="3"?"selected='selected'":""}>审核中</option>
                                <option value="4" ${pd.instance_status=="4"?"selected='selected'":""}>已通过</option>
                                <option value="5" ${pd.instance_status=="5"?"selected='selected'":""}>被驳回</option>
                            </select>

                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn  btn-primary" title="查询"
                                    style="margin-left: 10px; margin-top:3px;">查询
                            </button>

                            <button type="button" class="btn  btn-primary" title="新建"
                                    style="margin-left: 10px; margin-top:3px;" onclick="addEoffer()">新建
                            </button>
                            <a class="btn btn-warning btn-outline"
                               style="margin-top:3px;"
                               title="导出到Excel" type="button" target="_blank" onclick="toExcel(this);"
                               href="javascript:;">导出</a>
                            <div class="btn-group" style="margin-top:3px;">
							  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							    工具 <span class="caret"></span>
							  </button>
							  <ul class="dropdown-menu dropdown-menu-right">
							  	<c:if test="${QX.del == 1 }"><li><a href="Javascript:;" onclick="makeAll('del');">删除</a></li></c:if>
							  	<li><a href="Javascript:;" onclick="copyOffer();">复制报价</a></li>
							  </ul>
							</div>
                        </div>
                        <button class="btn  btn-success" title="刷新" type="button"
                                style="float: right" onclick="refreshCurrentTab();">刷新
                        </button>
                    </form>
                    <form role="form" class="form-inline" action="houseType/cell.do" method="post" name="houseType"
                          id="houseType">
                        <input type="hidden" id="houses_no" name="houses_no" value="${pd.houses_no}"/>
                        <input type="hidden" id="hou_id" name="hou_id" value="${pd.hou_id}"/>
                    </form>
                    <div class="row">
                        </br>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover" style="table-layout:fixed">
                            <thead>
                            <tr>
                                <th width="3%"><input type="checkbox" name="zcheckbox"
                                                      id="zcheckbox" class="i-checks"></th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="10%">报价编号
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="15%">项目名称
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="5%">版本
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="15%">最终用户
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="10%">电梯台数
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="10%">业务员
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="10%">总价格
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="10%">审核状态
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="12%">操作
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 开始循环 -->
                            <c:choose>
                                <c:when test="${not empty e_offerList}">
                                    <c:if test="${QX.cha == 1 }">
                                        <c:forEach items="${e_offerList}" var="e" varStatus="vs">

                                            <tr>
                                                <td class='center' style="width: 30px;">
                                                    <label>
                                                        <input
                                                                class="i-checks" type='checkbox' name='ids'
                                                                value="${e.offer_no}" id="${e.offer_no}"
                                                                alt="${e.offer_no}"/>
                                                        <span class="lbl"></span>
                                                    </label>
                                                </td>

                                                <td style="text-align:center;">
                                                    <a herf="#"
                                                       onclick="See('${e.offer_no}','${e.item_id}');">${e.offer_no}</a>
                                                </td>
                                                <td nowrap="nowrap" title="${e.item_name}"
                                                    style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${e.item_name}</td>
                                                <td title="${e.offer_version}"
                                                    style="text-align:center;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${e.offer_version}</td>
                                                <td nowrap="nowrap" title="${e.customer_name}"
                                                    style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${e.customer_name}</td>
                                                <td title="${e.YNum}"
                                                    style="text-align:center;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${e.YNum}</td>
                                                <td title="${e.USERNAME}"
                                                    style="text-align:center;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${e.USERNAME}</td>
                                                <td title="${e.xstotal}.00"
                                                    style="text-align:center;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${e.xstotal}.00
                                                </td>
                                                <td style="text-align:center;">
                                                        ${e.instance_status=="1"?"待启动":""}
                                                        ${e.instance_status=="2"?"待审核":""}
                                                        ${e.instance_status=="3"?"审核中":""}
                                                        ${e.instance_status=="4"?"已通过":""}
                                                        ${e.instance_status=="5"?"被驳回":""}
                                                        ${e.instance_status=="6"?"已通过":""}
                                                </td>
                                                <td><input name="h-instance-status" type="hidden" value="${e.instance_status }" /><input name="h-item-id" type="hidden" value="${e.item_id}" />
                                                    <c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in">
																<i class="icon-lock" title="无权限">无权限</i></span>
                                                    </c:if>
                                                        <%-- <!-- cod打印 -->
                                                        <button class="btn  btn-info btn-sm" title="打印" type="button" onclick="DaYin('${e.item_id}');">打印</button> --%>


                                                    <!-- 1.待启动 -->
                                                    <c:if test="${e.instance_status == 1 }">
                                                        <c:if test="${QX.edit == 1 }">
                                                            <button class="btn  btn-primary btn-sm" title="编辑"
                                                                    type="button"
                                                                    onclick="edit('${e.offer_no}','${e.item_id}');">编辑
                                                            </button>
                                                            <%-- <button class="btn  btn-danger btn-sm" title="删除"
                                                                    type="button"
                                                                    onclick="delE_offer('${e.offer_no}');">删除
                                                            </button> --%>
                                                        </c:if>
                                                        <c:if test="${e.offer_user==userpds.USER_ID||userpds.USER_ID=='1'}">
                                                            <button class="btn  btn-warning btn-sm" title="启动流程"
                                                                    type="button"
                                                                    onclick="startLeave('${e.offer_id}','${e.instance_id}')">
                                                                启动
                                                            </button>
                                                        </c:if>

                                                    </c:if>
                                                    <!-- 2.待审核 3.审核中 -->
                                                    <c:if test="${e.instance_status == 2 || e.instance_status == 3 }">
                                                        <button class="btn  btn-info btn-sm" title="审核记录" type="button"
                                                                onclick="viewHistory('${e.instance_id}');">审核记录
                                                        </button>
                                                    </c:if>
                                                    <!-- 5.被驳回 -->
                                                    <c:if test="${e.instance_status == 5}">
                                                        <button class="btn  btn-info btn-sm" title="历史记录" type="button"
                                                                onclick="viewHistory('${e.instance_id}');">审核记录
                                                        </button>
                                                        <button class="btn  btn-warning btn-sm" title="重新申请"
                                                                type="button"
                                                                onclick="restartAgent('${e.task_id }','${e.offer_id}');">
                                                            重新提交
                                                        </button>
                                                        <button class="btn  btn-primary btn-sm" title="编辑" type="button"
                                                                onclick="edit('${e.offer_no}','${e.item_id}');">编辑
                                                        </button>
                                                        <%-- <button class="btn  btn-danger btn-sm" title="删除"
                                                                type="button" onclick="delE_offer('${e.offer_no}');">删除
                                                        </button> --%>
                                                    </c:if>
                                                    <!-- 4.已通过 -->
                                                    <c:if test="${e.instance_status == 4}">
                                                        <button class="btn  btn-info btn-sm" title="历史记录" type="button"
                                                                onclick="viewHistory('${e.instance_id}');">审核记录
                                                        </button>
                                                        <!-- 价格表输出 -->
                                                        <a class="btn btn-sm btn-warning" title="价格表输出" type="button"
                                                           target="_blank"
                                                           href="<%=basePath%>contractNew/toPriceList.do?OFFER_ID=${e.offer_id}">价格表输出</a>
                                                    </c:if>

                                                    <!-- 6.已通过 -->
                                                    <c:if test="${e.instance_status == 6}">

                                                    </c:if>
                                                    <!--新功能----复制新建报价 -->
                                                    <%-- <button class="btn  btn-info btn-sm" title="复制报价" type="button"
                                                            onclick="Copy('${e.offer_no}','${e.item_id}','${e.item_name}');">复制报价
                                                    </button> --%>

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
                            <%-- <c:if test="${QX.del == 1 }">
                              <button class="btn  btn-danger" title="批量删除" type="button"
                                     onclick="makeAll('del');">批量删除</button>
                            </c:if> --%>
                            <%--  <a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>cell/toExcel.do">导出</a>
                                  <button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile()">导入</button>
                                  <input style="display: none" class="form-control" type="file"  title="导入" id="importFile" onchange="importExcel(this)"/>

                              <button class="btn  btn-success" title="下载数据模板" type="button" onclick="downFile()">下载</button> --%>
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
<!-- 兼容IE10 11 -->
<script src="static/js/sweetalert2/es6-promise.auto.min.js"></script>
<script src="static/js/sweetalert2/sweetalert2.min.js"></script>
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

    //打印cod
    function DaYin(id) {
        $("#EditShops").kendoWindow({
            width: "800px",
            height: "700px",
            title: "COD打印",
            actions: ["Close"],
            content: '<%=basePath%>e_offer/offer_count.do?item_id=' + id,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();
    }

    //新建报价
    function addEoffer() {

        $("#xinjian").kendoWindow({
            width: "800px",
            height: "700px",
            title: "选择项目",
            actions: ["Close"],
            content: '<%=basePath%>e_offer/itemList.do',
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();
    }

    //查看报价信息
    function See(offer_no, item_id) {
        $("#EditShops").kendoWindow({
            width: "800px",
            height: "700px",
            title: "查看报价",
            actions: ["Close"],
            content: '<%=basePath%>e_offer/SeeEoffer.do?offer_no=' + offer_no + '&item_id=' + item_id,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();
    }

    //编辑报价信息
    function edit(offer_no, item_id) {
        $("#addOffer").kendoWindow({
            width: "800px",
            height: "700px",
            title: "编辑报价",
            actions: ["Close"],
            content: '<%=basePath%>e_offer/editEoffer.do?offer_no=' + offer_no + '&item_id=' + item_id,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();
    }

    //新功能----复制新建报价信息
    //     function Copy(offer_no,item_id)
    //     {
    //     	$("#addOffer").kendoWindow({
    //             width: "800px",
    //             height: "700px",
    //             title: "编辑报价",
    //             actions: ["Close"],
    <%--             content: '<%=basePath%>e_offer/copyEoffer.do?offer_no='+offer_no+'&item_id='+item_id, --%>
    //             modal: true,
    //             visible: false,
    //             resizable: true
    //         }).data("kendoWindow").maximize().open();
    //     }

    function Copy(offer_no, item_id, item_name) {
        swal({
            title: "您确定要复制新增项目["+item_name+"]的报价吗？",
            text: "该操作会新增并保存一条报价记录，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            closeOnConfirm: true,
            closeOnCancel: false,
            showLoaderOnConfirm: true,
            allowOutsideClick: false,
            preConfirm: function () {
                return new Promise(function (resolve, reject) {
                    $("#addOffer").kendoWindow({
                        width: "800px",
                        height: "700px",
                        title: "编辑报价",
                        actions: ["Close"],
                        content: '<%=basePath%>e_offer/copyEoffer.do?offer_no=' + offer_no + '&item_id=' + item_id,
                        modal: true,
                        visible: false,
                        resizable: true
                    }).data("kendoWindow").maximize().open();

                    resolve();
                })
            }
        }).then(function (isConfirm) {
            if (!isConfirm) {
                swal("已取消", "您取消了删除操作！", "error");
            }
        });
    }


    //检索
    function search() {
        $("#shopForm").submit();
    }

    //删除
    function delE_offer(offer_no) {
        swal({
            title: "您确定要删除该条数据吗？",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            cancelButtonText: "取消",
            closeOnConfirm: false,
            closeOnCancel: false,
            showLoaderOnConfirm: true,
            allowOutsideClick: false,
            preConfirm: function () {
                return new Promise(function (resolve, reject) {
                    var url = "<%=basePath%>e_offer/delE_offer.do?offer_no=" + offer_no + "&tm=" + new Date().getTime();
                    $.get(url, function (data) {
                        if (data.msg == 'success') {
                            swal({
                                title: "删除成功！",
                                text: "您已经成功删除了这条信息。",
                                type: "success",
                            }).then(function () {
                                refreshCurrentTab();
                                resolve();
                            });
                        } else {
                            swal("删除失败", "您的删除操作失败了！", "error");
                        }
                    });

                })
            }
        }).then(function (isConfirm) {
            if (!isConfirm) {
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
            	
            	var sTr = $(document.getElementsByName('ids')[i]).parents("tr");
				var is = sTr.find('input[name=h-instance-status]').val();
				
				if(is != 1 && is != 5){
					var _xm = sTr.find("td").eq(2).text();
					var _version = sTr.find("td").eq(3).text();
					var text = "您所选的项目"+_version+"版本["+_xm+"]在审核中，不能删除！";
					if(is == 4){
						text = "您所选的项目"+_version+"版本["+_xm+"]审核已通过，不能删除！";
					}
					swal({
			            title: "您不能删除项目["+_xm+"]",
			            text: text,
			            type: "error",
			            showCancelButton: false
			        });
					return;
				}
            	
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
                closeOnCancel: false,
                showLoaderOnConfirm: true,
                allowOutsideClick: false,
                preConfirm: function () {
                    return new Promise(function (resolve, reject) {
                        $.ajax({
                            type: "POST",
                            url: '<%=basePath%>e_offer/deleteAllS.do',
                            data: {offer_nos: str},
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
                                        resolve();
                                    });
                                } else {
                                    swal("删除失败", "您的删除操作失败了！", "error");
                                }
                            }
                        });

                    })
                }
            }).then(function (isConfirm) {
                if (isConfirm) {

                } else {
                    swal("已取消", "您取消了删除操作！", "error");
                }
            });
        }
    }

    //导出到Excel
    function toExcel(ele) {
        var item_name = $("input[name='item_name']").val();
        var user_name = $("input[name='user_name']").val();
        var instance_status = $("select[name='instance_status']").val();
        $(ele).attr("href", "<%=basePath%>e_offer/toExcel.do?item_name="
            + item_name + "&user_name="
            + user_name + "&instance_status="
            + instance_status);
    }

    //选择导入文件
    function inputFile() {
        $("#importFile").click();
    }

    //导入Excel
    function importExcel(e) {
        var filePath = $(e).val();
        console.log(filePath);
        var suffix = filePath.substring(filePath.lastIndexOf(".")).toLowerCase();
        var fileType = ".xls|.xlsx|";
        if (filePath == null || filePath == "") {
            return false;
        }
        if (fileType.indexOf(suffix + "|") == -1) {
            var ErrMsg = "该文件类型不允许上传。请上传 " + fileType + " 类型的文件，当前文件类型为" + suffix;
            $(e).val("");
            alert(ErrMsg);
            return false;
        }
        var data = new FormData();
        data.append("file", $(e)[0].files[0]);
        console.log($(e)[0].files[0]);
        $.ajax({
            url: "<%=basePath%>cell/importExcel.do",
            type: "POST",
            data: data,
            cache: false,
            processData: false,
            contentType: false,
            success: function (result) {
                if (result.msg == "success") {
                    swal({
                        title: "导入成功!",
                        text: "导入数据成功。",
                        type: "success"
                    }).then(function () {
                        refreshCurrentTab();
                    });
                }
                else if (result.msg2 == "error") {
                    swal({
                        title: "导入失败!",
                        text: "导入数据失败," + result.error,
                        type: "error"
                    }).then(
                        function () {
                            refreshCurrentTab();
                        });
                }
                else {
                    swal({
                        title: "导入失败!",
                        text: "导入数据失败," + result.errorMsg,
                        type: "error"
                    }).then(
                        function () {
                            refreshCurrentTab();
                        });
                }
            }
        });
    }


    // 下载文件   e代表当前路径值
    function downFile() {
        var Type = "Cell";
        window.location.href = "cell/DataModel?Type=" + Type;

    }

    //启动流程
    function startLeave(offer_id, instance_id) {
        swal({
            title: "您确定要启动流程吗？",
            text: "点击确定将会启动该流程，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "启动",
            cancelButtonText: "取消",
            closeOnConfirm: false,
            closeOnCancel: false,
            showLoaderOnConfirm: true,
            allowOutsideClick: false,
            preConfirm: function () {
                return new Promise(function (resolve, reject) {

                    var url = '<%=basePath%>e_offer/apply.do?offer_id=' + offer_id + '&instance_id=' + instance_id;
                    $.get(url, function (data) {
                        if (data.msg == "success") {
                            swal({
                                title: "启动成功！",
                                text: "您已经成功启动该流程。\n该流程实例ID为：" + instance_id + ",下一个任务为：" + data.task_name,
                                type: "success",
                            }).then(function () {
                                refreshCurrentTab();
                                resolve();
                            });

                        } else if (data.msg == "numerror") {
                            swal({
                                title: "启动失败",
                                html: "<table border=1><tr><th width='17%'>客户类型</th><th width='33%'>付款方式</th><th width='17%'>客户类型</th><th width='33%'>付款方式</th></tr>" +
                                    "<tr><td rowspan=4>直销、代理类</td><td>定金≥5%<br>发货前款≥70%<br>质保金≤5%</td><td rowspan=4>经销类</td><td rowspan=2>定金≥5%<br>排产款≥20%<br>定金+排产款+发货款=100%</td></tr>" +
                                    "<tr><td>定金＜5%<br>发货前款＜70%<br>质保金＞5%</td></tr>" +
                                    "<tr><td>安装款开工前≥50%<br>安装款验收后≥50%</td><td rowspan=2>定金<5%<br>排产款<20%<br>定金+排产款+发货款<100%</td></tr>" +
                                    "<tr><td>安装款开工前＜50%<br>安装款验收后＜50%</td></tr></table>",
                                confirmButtonText: '确认',
                                showCloseButton: true,
                            })
                        } else {
                            swal("启动失败", "error");
                        }
                    });

                })
            }
        }).then(function (isConfirm) {
            if (isConfirm) {

            }
            else {
                swal("已取消", "您已经取消启动操作了！", "error");
            }
        });
    }

    //审核记录
    function viewHistory(instance_id) {
        $("#EditShops").kendoWindow({
            width: "1200px",
            height: "600px",
            title: "查看历史记录",
            actions: ["Close"],
            content: '<%=basePath%>workflow/goViewHistory.do?pid=' + instance_id,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").center().open();
    }

    //重新提交流程
    function restartAgent(task_id, offer_id) {
        swal({
            title: "您确定要重新提交吗？",
            text: "重新提交流程进行审核！",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "提交",
            cancelButtonText: "取消",
            showLoaderOnConfirm: true,
            allowOutsideClick: false,
            preConfirm: function () {
                return new Promise(function (resolve, reject) {
                    var url = "<%=basePath%>e_offer/restartAgent.do?task_id=" + task_id + "&offer_id=" + offer_id + "&tm=" + new Date().getTime();
                    $.get(url, function (data) {
                        console.log(data.msg);
                        if (data.msg == "success") {
                            swal({
                                title: "重新提交成功！",
                                text: "您已经成功重新提交了该流程！",
                                type: "success"
                            }).then(function () {
                                refreshCurrentTab();
                                resolve();
                            });
                        } else {
                            swal({
                                title: "重新提交失败！",
                                text: data.err,
                                type: "error",
                                showConfirmButton: false,
                                timer: 1000
                            });
                        }
                    });

                })
            }
        }).then(function (isConfirm) {
            if (isConfirm === true) {

            } else if (isConfirm == false) {
                swal({
                    title: "取消重新提交！",
                    text: "您已经取消重新提交操作了！",
                    type: "error",
                    showConfirmButton: false,
                    timer: 1000
                });
            }
        });
    }

	function copyOffer() {
		var str = '';
		var item_id = '';
		var _xm = '';
		for (var i = 0; i < document.getElementsByName('ids').length; i++) {
			if (document.getElementsByName('ids')[i].checked) {
             	
				var sTr = $(document.getElementsByName('ids')[i]).parents("tr");
             	_xm = sTr.find("td").eq(2).text();
             	
 				str = document.getElementsByName('ids')[i].value;
 				item_id = sTr.find("input[name=h-item-id]").val();
				break;
 				
 				
             }
         }
         if (str == '' || item_id == '') {
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
        	 Copy(str,item_id,_xm);
         }
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


