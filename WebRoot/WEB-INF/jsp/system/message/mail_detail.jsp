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
        <link href="static/js/iCheck/custom.css" rel="stylesheet">
        <title>${pd.SYSNAME}</title>
    </head>
<body class="gray-bg">
                <div class="mail-box-header" style="width: 100%;height: 25%">
                    <div class="pull-right tooltip-demo">
                        <c:if test="${recv!='false'}">
                            <a href="javascript:window.parent.mailRecv('${detailPd.id}','${detailPd.send_id}');" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="回复"><i class="fa fa-reply"></i> 回复</a>
                        </c:if>
                        <a href="mailbox.html" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="移动到回收站"><i class="fa fa-trash-o"></i> </a>
                    </div>
                    <h2>
                    查看邮件
                </h2>
                    <div class="mail-tools tooltip-demo m-t-md">


                        <h3>
                        <span class="font-noraml">主题： </span>${detailPd.title}
                    </h3>
                        <h5>
                        <span class="pull-right font-noraml">${detailPd.send_date}</span>
                        <span class="font-noraml">发件人： </span>${detailPd.send_name}
                    </h5>
                    </div>
                </div>
                <div class="mail-box">


                    <div class="mail-body">
                        <h4>${detailPd.title}：</h4>
                        <p>
                            ${detailPd.mes_text}
                        </p>

                        <p class="text-right">
                            发送者:${detailPd.send_name}
                        </p>
                    </div>
                    <div class="mail-body text-right tooltip-demo">
                        <c:if test="${recv!='false'}">
                            <a class="btn btn-sm btn-white" href="javascript:window.parent.mailRecv('${detailPd.id}','${detailPd.send_id}');"><i class="fa fa-reply"></i> 回复</a>
                        </c:if>
                        <!-- <a class="btn btn-sm btn-white" href="mail_compose.html"><i class="fa fa-arrow-right"></i> 下一封</a>
                        <button title="" data-placement="top" data-toggle="tooltip" type="button" data-original-title="打印这封邮件" class="btn btn-sm btn-white"><i class="fa fa-print"></i> 打印</button> -->
                        <button title="" data-placement="top" data-toggle="tooltip" data-original-title="删除邮件" class="btn btn-sm btn-white"><i class="fa fa-trash-o"></i> 删除</button>
                    </div>
                    <div class="clearfix"></div>


                </div>


    <!-- 自定义js -->
    <script src="static/js/content.js"></script>
    <!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });

             //loading end
             parent.layer.closeAll('loading');
        });
    </script>
</body>

</html>