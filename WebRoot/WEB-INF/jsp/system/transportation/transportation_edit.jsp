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
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
      <title>${pd.SYSNAME}</title>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp" %>

    <%--zTree--%>
    <script type="text/javascript"
            src="plugins/zTree/3.5.24/js/jquery.ztree.all.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert2/sweetalert2.js"></script>
    <script type="text/javascript">
          //保存
        function save() {
            if ($("#more_carLoad_time").val()!=null&&$("#more_carLoad_time").val() != ""&&isNaN($("#more_carLoad_time").val())) {

                $("#more_carLoad_time").focus().blur();
                $("#more_carLoad_time").tips({
                    side: 3,
                    msg: '请填写正确数字',
                    bg: '#AE81FF',
                    time: 2
                });
                return false;
            }
            if ($("#five_t").val()!=null&&$("#five_t").val() != ""&&isNaN($("#five_t").val())) {

                $("#five_t").focus().blur();
                $("#five_t").tips({
                    side: 3,
                    msg: '请填写正确数字',
                    bg: '#AE81FF',
                    time: 2
                });
                return false;
            }
            if ($("#eight_t").val()!=null&&$("#eight_t").val() != ""&&isNaN($("#eight_t").val())) {

                $("#eight_t").focus().blur();
                $("#eight_t").tips({
                    side: 3,
                    msg: '请填写正确数字',
                    bg: '#AE81FF',
                    time: 2
                });
                return false;
            }
            if ($("#ten_t").val()!=null&&$("#ten_t").val() != ""&&isNaN($("#ten_t").val())) {

                $("#ten_t").focus().blur();
                $("#ten_t").tips({
                    side: 3,
                    msg: '请填写正确数字',
                    bg: '#AE81FF',
                    time: 2
                });
                return false;
            }
            if ($("#twenty_t").val()!=null&&$("#twenty_t").val() != ""&&isNaN($("#twenty_t").val())) {

                $("#twenty_t").focus().blur();
                $("#twenty_t").tips({
                    side: 3,
                    msg: '请填写正确数字',
                    bg: '#AE81FF',
                    time: 2
                });
                return false;
            }
            if ($("#less_carLoad").val()!=null&&$("#less_carLoad").val() != ""&&isNaN($("#less_carLoad").val())) {

                $("#less_carLoad").focus().blur();
                $("#less_carLoad").tips({
                    side: 3,
                    msg: '请填写正确数字',
                    bg: '#AE81FF',
                    time: 2
                });
                return false;
            }
            if ($("#less_carLoad_time").val()!=null&&$("#less_carLoad_time").val() != ""&&isNaN($("#less_carLoad_time").val())) {

                $("#less_carLoad_time").focus().blur();
                $("#less_carLoad_time").tips({
                    side: 3,
                    msg: '请填写正确数字',
                    bg: '#AE81FF',
                    time: 2
                });
                return false;
            }

            $("#transportationForm").submit();
        }

        function CloseSUWin(id) {
            window.parent.$("#" + id).data("kendoWindow").close();
            /* 	window.parent.location.reload(); */
        }


    </script>
</head>

<body class="gray-bg">
<form action="transportation/${msg }.do" name="transportationForm" id="transportationForm" method="post">
    <input type="hidden" name="USER_ID" id="user_id" value="${pd.USER_ID }"/>
    <input type="hidden" name="id" id="id" value="${pd.id}"/>
    <div class="wrapper wrapper-content">

                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">

                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 20%">区域:</label>
                                    <input style="width: 60%" type="text" name="province_name" id="province_name" value="${pd.province_name }"class="form-control" readonly>
                                </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 20%">目的地:</label>
                                    <input style="width: 60%" type="text" name="city_name" id="city_name" value="${pd.city_name }" class="form-control" readonly>
                                </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 20%">整车到货时间:</label>
                                    <input style="width: 60%" type="text" name="more_carLoad_time" id="more_carLoad_time" value="${pd.more_carLoad_time}" class="form-control">
                                    <span>&nbsp;(天)</span>
                                </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 20%">5T车&nbsp;6.2-7.2米:</label>
                                    <input style="width: 60%" type="text" name="five_t" id="five_t" value="${pd.five_t}" class="form-control">
                                    <span>&nbsp;(元/车)</span>
                                </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 20%">8T车&nbsp;8.2-9.6米:</label>
                                    <input style="width: 60%" type="text" name="eight_t" id="eight_t" value="${pd.eight_t }" class="form-control">
                                    <span>&nbsp;(元/车)</span>
                                </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 20%">10T车&nbsp;12.5米:</label>
                                    <input style="width: 60%" type="text" name="ten_t" id="ten_t" value="${pd.ten_t }" class="form-control">
                                    <span>&nbsp;(元/车)</span>
                                </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 20%">20T车&nbsp;17.5米:</label>
                                    <input style="width: 60%" type="text" name="twenty_t" id="twenty_t" value="${pd.twenty_t }" class="form-control">
                                    <span>&nbsp;(元/车)</span>
                                </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 20%">零担:</label>
                                    <input style="width: 60%" type="text" name="less_carLoad" id="less_carLoad" value="${pd.less_carLoad }" class="form-control">
                                    <span>&nbsp;(元/每吨)</span>
                                </div>
                                <div class="form-group form-inline" style="margin-bottom: 8px;">
                                    <label style="width: 20%">零担到货时间:</label>
                                    <input style="width: 60%" type="text" name="less_carLoad_time" id="less_carLoad_time" value="${pd.less_carLoad_time }" class="form-control">
                                    <span>&nbsp;(天)</span>
                                </div>

                            </div>

                        </div>

                    </div>
                    <div style="height: 10px;"></div>
                    <tr>
                        <td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;" onclick="save();">保存</a></td>

                        <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditShops');">关闭</a></td>
                    </tr>
                </div>

    </div>
</form>
</body>

</html>
