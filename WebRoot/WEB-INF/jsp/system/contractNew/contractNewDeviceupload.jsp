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
        <!-- 图片插件 -->
        <link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
        <!-- Check Box -->
        <link href="static/js/iCheck/custom.css" rel="stylesheet">
        <!-- Sweet Alert -->
        <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
        <title>${pd.SYSNAME}</title>
    </head>

<body class="gray-bg">
<!-- 选择报价页面 -->
<div id="QuoteSelectHTML" class="animated fadeIn"></div>
<!-- 合同录入界面 -->
<div id="InformationHTML" class="animated fadeIn"></div>
<!-- 合同变更 -->
<div id="ChangeIncontractHTML" class="animated fadeIn"></div>
<!-- COD -->
<div id="ChangeCODHTML" class="animated fadeIn"></div>

<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-content">
                    <div id="top" ,name="top"></div>

                    <form role="form" class="form-inline" action="contractNew/contractNewUpload.do"
                          method="post" name="ContractNewForm" id="ContractNewForm">

                        <div class="form-group ">
                            <input class="form-control" id="item_name" type="text"
                                   name="item_name" value="${pd.item_name}" placeholder="项目名称">
                        </div>
                        <div class="form-group ">
                            <input class="form-control" type="text" id="HT_NO" name="HT_NO"
                                   value="${pd.HT_NO}" placeholder="合同编号">
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn  btn-primary"
                                    style="margin-left: 10px; height:32px;margin-top:3px;" title="查询">查询
                            </button>
                        </div>

                        <button class="btn  btn-success" title="刷新" type="button"
                                style="float: right" onclick="refreshCurrentTab();">刷新
                        </button>
                    </form>

                    <div class="row">
                        </br>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover" style="table-layout:fixed">
                            <thead>
                            <tr>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="10%">合同编号
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="20%">项目名称
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="6%">报价版本
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="15%">客户名称
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="7%">电梯台数
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="7%">业务员
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="10%">合同总价格
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="10%">合同状态
                                </th>
                                <th style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                    width="10%">操作
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 开始循环 -->
                            <c:choose>
                                <c:when test="${not empty contractNewList}">
                                    <c:if test="${QX.cha == 1 }">
                                        <c:forEach items="${contractNewList}" var="con" varStatus="vs">
                                            <tr>
                                                <td title="${con.HT_NO}"
                                                    style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"
                                                    onclick="CNselect('${con.HT_UUID}');">
                                                    <a href="javascript:;">${con.HT_NO}</a></td>
                                                <td nowrap="nowrap" title="${con.item_name}"
                                                    style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${con.item_name}</td>
                                                <td nowrap="nowrap" title="${con.offer_version}"
                                                    style="text-align:center;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${con.offer_version}</td>
                                                <td nowrap="nowrap" title="${con.customer_name}"
                                                    style="text-align:center;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${con.customer_name}</td>
                                                <td title="${con.DT_NUM}"
                                                    style="text-align:center;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${con.DT_NUM}</td>
                                                <td title="${con.USER_NAME}"
                                                    style="text-align:center;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${con.USER_NAME}</td>
                                                <td title="${con.PRICE}"
                                                    style="text-align:center;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${con.PRICE}</td>
												<td style="text-align:center;">
                                                         <c:if test="${con.CONTRACT_STATUS != '1' }"><span class="label label-important arrowed-in">未生效</span></c:if>
                                                    	<c:if test="${con.CONTRACT_STATUS == '1' }"><span class="label label-info arrowed">生效</span></c:if>
                                                 </td>
                                                <td>
                                                    <!-- 公共 -->
													<c:if test="${con.ACT_STATUS == '4'}">
                                                        <c:if test="${QX.edit != 1 && QX.del != 1 }">
														  		<span class="label label-large label-grey arrowed-in-right arrowed-in">
																<i class="icon-lock" title="无权限">无权限</i></span>
                                                        </c:if>
                                                        <c:if test="${QX.edit == 1 || QX.del == 1}">
                                                            <button class="btn btn-sm btn-primary" title="合同上传"
                                                              type="button" onclick="CNUpdatePage('${con.HT_UUID}','${con.HT_ITEM_ID}');">合同上传
                                                      		</button>
                                                        </c:if>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                    <!-- 权限设置 -->
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
<script src="static/js/sweetalert/sweetalert.min.js"></script>

<script type="text/javascript">
    //---------------------------xcx-------------------------Start
    //刷新iframe
    function refreshCurrentTab() {
        $("#ContractNewForm").submit();
    }

    //查看
    function CNselect(HT_UUID) {
        $("#InformationHTML").kendoWindow({
            width: "550px",
            height: "300px",
            title: "合同信息",
            actions: ["Close"],
            content: '<%=basePath%>contractNew/goView.do?HT_UUID=' + HT_UUID,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();
    };

    $(document).ready(function () {
        //loading end
        parent.layer.closeAll('loading');
    });

    //刷新iframe
    function refreshCurrentTab() {
        $("#ContractNewForm").submit();
    }

    function CNUpdatePage(HT_UUID,HT_ITEM_ID) {
    	$("#InformationHTML").kendoWindow({
            width: "550px",
            height: "300px",
            title: "合同上传",
            actions: ["Close"],
            content: '<%=basePath%>contractNew/goView.do?HT_UUID=' + HT_UUID+'&CNUpdate=1',
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();
	}

    //---------------------------xcx-------------------------End

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


