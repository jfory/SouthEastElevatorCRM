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
        <link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
        <link href="static/js/qtip/jquery.qtip.min.css" type="text/css" rel="stylesheet" />
        <title>${pd.SYSNAME}</title>
    </head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div id="setUpView" class="animated fadeIn"></div>
    <div id="setContractTechUpView" class="animated fadeIn"></div>
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-content">
                    <label  style="color: red;padding:6px 12px;">注意:点击任务节点可以进行节点配置。</label>
                    <div id="diagramImage">
                        <img id="workFlowImg" alt="image" class="img"  src="<%=basePath%>workflow/getProcessResourceWithDefID?pdid=${pd.pdid}&type=image" />
                    </div>
                    <%--<!-- 2.根据当前活动的坐标，动态绘制DIV -->--%>
                    <%--<div style="position: absolute;border:1px solid red;top:${activityInfos.y}"px;left:${activityInfos.x}"px;width: ${activityInfos.width}px;height:${activityInfos.height}px;   "></div>--%>

                </div>
            </div>
        </div>
    </div>
</div>
<script src="static/js/qtip/jquery.qtip.min.js" type="text/javascript"></script>
<script src="static/js/outerHtml/jquery.outerhtml.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function(){

        /*var screen_width = window.screen.width-400;
        $("#workFlowImg").css("max-width",screen_width);*/

        var positionHtml = "<div id='processImageBorder'>";
        var pdid = "${pd.pdid}";
        var varsArray = new Array();
        $.getJSON('<%=basePath%>workflow/traceProcessWithPdidInCh?pdid=' + pdid, function(infos) {
            // 生成图片

            $.each(infos, function (i, v) {
                var $positionDiv = $('<div/>', {
                    'class': 'activity-attr'
                }).css({
                    position: 'absolute',
                    left: (v.x + 25),
                    top: (v.y + 11),
                    width: (v.width ),
                    height: (v.height),
                    backgroundColor: 'black',
                    opacity: 0,
                    zIndex: $.fn.qtip.zindex - 1
                });

                // 节点边框
                var $border = $('<div/>', {
                    'class': 'activity-attr-border'
                }).css({
                    position: 'absolute',
                    left: (v.x + 25),
                    top: (v.y + 11),
                    width: (v.width),
                    height: (v.height),
                    zIndex: $.fn.qtip.zindex - 2
                });

                if (v.currentActiviti) {
                    $border.addClass('ui-corner-all-12').css({
                        border: '3px solid red'
                    });
                }
                positionHtml += $positionDiv.outerHTML() + $border.outerHTML();

                varsArray[varsArray.length] = v.vars;
            });
            positionHtml = positionHtml +"</div>";
            $("#diagramImage").append(positionHtml);
            // 设置每个节点的data
            $('.activity-attr').each(function(i, v) {
                $(this).data('vars', varsArray[i]);
            });
            // 此处用于显示每个节点的信息，如果不需要可以删除
            $('.activity-attr').qtip({
                content: function() {
                    var vars = $(this).data('vars');
                    var table = "<table  class='table table-striped table-bordered table-hover'>";
                    var tbody="<tbody>";
                    var tr = "";
                    $.each(vars, function(varKey, varValue) {
                        if (varValue) {
                            var td ="";
                            td ="<tr><td>"+varKey+"</td><td>"+varValue+"</td></tr>";
                            tr= tr+td;
                        }

                    });
                    tbody = tbody+tr+"</tbody>";
                    table = table+tbody+"</table>";

                    return table;
                },
                position: {
                    at: 'bottom left',
                    adjust: {
                        x: 3
                    }
                }
            });
            // end qtip
            // 设置每个节点的点击事件
            $('.activity-attr').click(function () {
                var vars = $(this).data('vars');
                var activityId = "";
                var activityName = "";
                var priority = "";
                var workName = "";
                $.each(vars, function(varKey, varValue) {
                    if (varKey=="节点ID") {
                        activityId = varValue
                    }

                });
                $.each(vars, function(varKey, varValue) {
                    if (varKey=="节点名称") {
                        activityName = varValue
                    }

                });
                $.each(vars, function(varKey, varValue) {
                    if (varKey=="优先级") {
                        priority = varValue
                    }

                });
                $.each(vars, function(varKey, varValue) {
                    if (varKey=="流程名称") {
                    	workName = varValue
                    }

                });
                $.each(vars, function(varKey, varValue) {
                    if (varKey=="任务类型"&&varValue=="用户任务"&&priority!="0") {//优先级为0的则不进行流程设置
                    	if(workName=="合同审核流程" && activityId=="techtask" && activityName=="技术评审"){//处理合同技术评审
                    		//用户任务则设置点击操作
                            $("#setContractTechUpView").kendoWindow({
                                width: "800px",
                                height: "550px",
                                title: "设置合同技术评审",
                                actions: ["Close"],
                                content: '<%=basePath%>workflow/goContractTechWorkFlowSetUpView',
                                modal : true,
                                visible : false,
                                resizable : true
                            }).data("kendoWindow").center().open();
                    	} else {
                    		//用户任务则设置点击操作
                            $("#setUpView").kendoWindow({
                                width: "400px",
                                height: "500px",
                                title: "设置",
                                actions: ["Close"],
                                content: '<%=basePath%>workflow/goWorkFlowSetUpEdit?pdid='+pdid+'&activityId='+activityId+'&activityName='+activityName,
                                modal : true,
                                visible : false,
                                resizable : true
                            }).data("kendoWindow").center().open();
                    	}
                    }

                });

            });
        });

    });

</script>
</body>
</html>


