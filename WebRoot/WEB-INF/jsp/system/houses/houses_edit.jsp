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
<html>

<head>

    <base href="<%=basePath%>">


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>${pd.SYSNAME}</title>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp" %>
    <!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>

    <link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
    <link type="text/css" rel="stylesheet"
          href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript"
            src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
    <script type="text/javascript"
            src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
    <script type="text/javascript"
            src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>


    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            /* 图片 */
            $('.fancybox').fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });
            //编辑时加载楼盘交付信息
            var deliveryJSON = $("#deliveryJSON").val();
            if (deliveryJSON != "") {
                setDeliveryJSON(deliveryJSON);
            }
            //编辑时加载楼盘效果图信息
            var housesJSON = $("#houses_img_json").val();
            if (housesJSON != "") {
                setHousesJSON(housesJSON);
            }
        });

        function save1() {
            //如果楼盘名称被修改 验证是否重复
            if ($("#houses_name").val() != $("#housesName").val()) {
                var name = $("#houses_name").val();
                var url = "<%=basePath%>houses/HousesName.do?houses_name=" + name + "&tm="
                    + new Date().getTime();
                $.get(url, function (data) {
                    if (data.msg == "error") {
                        $("#houses_name").focus();
                        $("#houses_name").tips({
                            side: 3,
                            msg: '楼盘名称已存在',
                            bg: '#AE81FF',
                            time: 3
                        });
                        setTimeout("$('#houses_name').val('')", 2000);
                    }
                    else {
                        save();
                    }
                });
            }
            else {
                save();
            }
        }

        //保存
        function save() {

            if ($("#houses_name").val() == "" && $("#houses_name").val() == "") {
                $("#houses_name").focus();
                $("#houses_name").tips({
                    side: 3,
                    msg: "请输入楼盘名称",
                    bg: '#AE81FF',
                    time: 3
                });

                return false;
            }

            if ($("#customer_area_text_ordinary").val() == "" && $("#customer_area_text_ordinary").val() == "") {
                $("#customer_area_text_ordinary").focus();
                $("#customer_area_text_ordinary").tips({
                    side: 3,
                    msg: "请选择楼盘所属区域",
                    bg: '#AE81FF',
                    time: 3
                });

                return false;
            }


            if ($("#province_id").val() == "" && $("#province_id").val() == "") {
                $("#province_id").focus();
                $("#province_id").tips({
                    side: 3,
                    msg: "请选择省份",
                    bg: '#AE81FF',
                    time: 3
                });

                return false;
            }

            if ($("#city_id").val() == "" && $("#city_id").val() == "") {
                $("#city_id").focus();
                $("#city_id").tips({
                    side: 3,
                    msg: "请选择城市",
                    bg: '#AE81FF',
                    time: 3
                });

                return false;
            }

            if ($("#county_id").val() == "" && $("#county_id").val() == "") {
                $("#county_id").focus();
                $("#county_id").tips({
                    side: 3,
                    msg: "请选择区域",
                    bg: '#AE81FF',
                    time: 3
                });

                return false;
            }


            if ($("#agent_address").val() == "" && $("#agent_address").val() == "") {
                $("#agent_address").focus();
                $("#agent_address").tips({
                    side: 3,
                    msg: "详细地址不能为空",
                    bg: '#AE81FF',
                    time: 3
                });

                return false;
            }

            if ($("#status_name").val() == "" && $("#status_name").val() == "") {
                $("#status_name").focus();
                $("#status_name").tips({
                    side: 3,
                    msg: "请选择楼盘状态",
                    bg: '#AE81FF',
                    time: 3
                });

                return false;
            }
            if ($("#villadom_num").val() == "" && $("#villadom_num").val() == "") {
                $("#villadom_num").focus();
                $("#villadom_num").tips({
                    side: 3,
                    msg: "请输入别墅数量",
                    bg: '#AE81FF',
                    time: 3
                });

                return false;
            }
            if ($("#delivery_time").val() == "" && $("#delivery_time").val() == "") {
                $("#delivery_time").focus();
                $("#delivery_time").tips({
                    side: 3,
                    msg: "请输入楼盘交付日期",
                    bg: '#AE81FF',
                    time: 3
                });
                return false;
            }

            if ($("#houses_phone").val() == "" && $("#houses_phone").val() == "") {
                $("#houses_phone").focus();
                $("#houses_phone").tips({
                    side: 3,
                    msg: "请输入物业公司名称",
                    bg: '#AE81FF',
                    time: 3
                });

                return false;
            }

            if ($("#houses_contacts").val() == "" && $("#houses_contacts").val() == "") {
                $("#houses_contacts").focus();
                $("#houses_contacts").tips({
                    side: 3,
                    msg: "请输入物业联系人",
                    bg: '#AE81FF',
                    time: 3
                });

                return false;
            }

            if ($("#houses_con_phone").val() == "" && $("#houses_con_phone").val() == "") {
                $("#houses_con_phone").focus();
                $("#houses_con_phone").tips({
                    side: 3,
                    msg: "请输入物业联系人电话",
                    bg: '#AE81FF',
                    time: 3
                });

                return false;
            }
            if ($("#houses_dev_name").val() == "" && $("#houses_dev_name").val() == "") {
                $("#houses_dev_name").focus();
                $("#houses_dev_name").tips({
                    side: 3,
                    msg: "请输入开发商公司名称",
                    bg: '#AE81FF',
                    time: 3
                });

                return false;
            }
            if ($("#houses_dev_address").val() == "" && $("#houses_dev_address").val() == "") {
                $("#houses_dev_address").focus();
                $("#houses_dev_address").tips({
                    side: 3,
                    msg: "请输入开发商公司地址",
                    bg: '#AE81FF',
                    time: 3
                });

                return false;
            }


            //交房日期拼接为json格式保存
            var time = true;
            var a = "";
            var b = "";
            var jsonStr = "[";
            $("#delivery").find("div").each(function () {
                var a = $(this).find("input").eq(0).val();
                if (a == "" && a == "") {
                    $(this).find("input").eq(0).focus();
                    $(this).find("input").eq(0).tips({
                        side: 3,
                        msg: "请输入楼盘交付日期",
                        bg: '#AE81FF',
                        time: 3
                    });
                    time = false
                    return time;
                }
                var b = $(this).find("input").eq(1).val();
                jsonStr += "{\'delivery_time\':\'" + a + "\',\'delivery_remark\':\'" + b + "\'},";
            });
            jsonStr = jsonStr.substring(0, jsonStr.length - 1) + "]";
            $("#deliveryJSON").val(jsonStr);
            if (!time) {
                return false;
            }


            var h = "";
            var json = "[";
            //楼盘效果图（效果图文件地址）拼接为json格式保存
            $("#housesT").find("div").each(function () {
                h = $(this).find("input").eq(0).val();
                json += "{\'house_type_img\':\'" + h + "\'},";
            });
            json = json.substring(0, json.length - 1) + "]";
            if (h == "" || h == null) {
                $("#houses_img_json").val("");
            }
            else {
                $("#houses_img_json").val(json);
            }

            $("#houses_address").val(provinceName + cityName + countyName + agentAddressName);
            $("#housesForm").submit();
        }

        //判断楼盘名称是否已存在
        function HousesName() {
            var name = $("#houses_name").val();
            var url = "<%=basePath%>houses/HousesName.do?houses_name=" + name + "&tm="
                + new Date().getTime();
            $.get(url, function (data) {
                if (data.msg == "error") {
                    $("#houses_name").focus();
                    $("#houses_name").tips({
                        side: 3,
                        msg: '楼盘名称已存在',
                        bg: '#AE81FF',
                        time: 3
                    });
                    setTimeout("$('#houses_name').val('')", 2000);
                }
            });
        }

        function CloseSUWin(id) {
            window.parent.$("#" + id).data("kendoWindow").close();
        }


        //日期范围限制
        var start = {
            elem: '#start_time',
            format: 'YYYY/MM/DD hh:mm:ss',
            max: '2099-06-16 23:59:59', //最大日期
            istime: true,
            istoday: false,
            choose: function (datas) {
                end.min = datas; //开始日选好后，重置结束日的最小日期
                end.start = datas //将结束日的初始值设定为开始日
            }
        };
        var end = {
            elem: '#end_time',
            format: 'YYYY/MM/DD hh:mm:ss',
            max: '2099-06-16 23:59:59',
            istime: true,
            istoday: false,
            choose: function (datas) {
                start.max = datas; //结束日选好后，重置开始日的最大日期
            }
        };
        laydate(start);
        laydate(end);


        //文件异步上传   e代表当前File对象,v代表对应路径值
        function upload(e) {
            var v = $(e).prev().val();
            var filePath = $(e).val();
            var arr = filePath.split("\\");
            var fileName = arr[arr.length - 1];
            var suffix = filePath.substring(filePath.lastIndexOf("."))
                .toLowerCase();
            var fileType = ".xls|.xlsx|.doc|.docx|.txt|.pdf|";
            if (filePath == null || filePath == "") {
                $(e).prev().val("");
                return false;
            }

            //var data = new FormData($("#agentForm")[0]);
            var data = new FormData();

            data.append("file", $(e)[0].files[0]);

            $.ajax({
                url: "houses/upload.do",
                type: "POST",
                data: data,
                cache: false,
                processData: false,
                contentType: false,
                success: function (result) {
                    if (result.success) {
                        $(e).prev().val(result.filePath);
                        alert("上传成功！");
                        $(e).next().next().show();
                    } else {
                        alert(result.errorMsg);
                    }
                }
            });
        }

        // 下载文件   e代表当前路径值
        function downFile(e) {
            var downFile = $(e).prev().prev().prev().prev().val();
            window.location.href = "cell/down?downFile=" + downFile;
        }

        //查看效果图
        function imgChack(a) {
            var src = $(a).prev().prev().prev().val();
            window.open("uploadFiles/file/" + src, "_blank");
        }


        //编辑时加载楼盘交付信息
        function setDeliveryJSON(supp) {
            var obj = eval("(" + supp + ")");
            for (var j = 0; j < obj.length - 1; j++) {
                addDelivery();
            }
            for (var i = 0; i < obj.length; i++) {
                $("#delivery").find("div").eq(i).each(function () {
                    $(this).find("input").eq(0).val(obj[i].delivery_time);
                    $(this).find("input").eq(1).val(obj[i].delivery_remark);
                });
            }
        }

        //编辑时加载楼盘效果图信息
        function setHousesJSON(supp) {
            var obj = eval("(" + supp + ")");
            for (var j = 0; j < obj.length - 1; j++) {
                addHousesImg();
            }
            for (var i = 0; i < obj.length; i++) {
                $("#housesT").find("div").eq(i).each(function () {
                    $(this).find("input").eq(0).val(obj[i].house_type_img);
                });
            }
        }
    </script>
</head>

<body>
<form action="houses/${msg}.do" name="housesForm" id="housesForm"
      method="post">
    <input type="hidden" name="housesName" id="housesName"
           value="${pd.houses_name}"/>
    <input type="hidden" name="houses_address" id="houses_address" value="${pd.houses_address}"/>
    <input type="hidden" name="deliveryJSON" id="deliveryJSON" value="${pd.delivery}"/>
    <input type="hidden" name="houses_img_json" id="houses_img_json" value="${pd.house_type_img}"/>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="ibox float-e-margins">
                <div class="ibox-content1">
                    <div class="panel panel-primary">
                        <div class="panel-heading">楼盘基本信息</div>
                        <div class="panel-body">
                            <div class="form-group form-inline">
                                <c:if test="${msg== 'editS' }">
                                    <span type="hidden">&nbsp&nbsp</span>
                                    <label style="width: 9%">楼盘编号:</label> <input
                                        style="width: 21%" type="text" name="houses_no"
                                        readonly="readonly" id="houses_no" value="${pd.houses_no}"
                                        placeholder="楼盘编号由系统自动生成" title="楼盘编号" class="form-control"/>
                                    <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
                                </c:if>
                                <span style="color: red;">*</span>
                                <label style="width: 9%;">楼盘名称:</label>
                                <c:if test="${msg== 'saveS' }">
                                    <input style="width: 21%" type="text" name="houses_name"
                                           id="houses_name" value="${pd.houses_name}"
                                           placeholder="这里输入楼盘名称" title="楼盘名称" onblur="HousesName()"
                                           class="form-control"/>

                                </c:if>
                                <c:if test="${msg== 'editS' }">
                                    <input style="width: 21%" type="text" name="houses_name"
                                           id="houses_name" value="${pd.houses_name}"
                                           placeholder="这里输入楼盘名称" title="楼盘名称" onblur="UpHousesName()"
                                           class="form-control"/>
                                </c:if>
                                <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp</span>
                                <span style="color: red;">*</span>
                                <label
                                        style="width: 9%">楼盘所属区域:</label>
                                <input type="text" readonly="readonly" style="width:21%"
                                       name="customer_area_text_ordinary" id="customer_area_text_ordinary"
                                       value="${pd.customer_area_text }" placeholder="请选择区域" title="所属区域"
                                       class="form-control" onclick="showAreaMenuOrdinary();"/>
                                <input style="width:170px" type="hidden" name="customer_area_ordinary"
                                       id="customer_area_ordinary" value="${pd.customer_area}" title="所属区域"
                                       class="form-control">

                            </div>
                            <div class="form-group form-inline">
                                <span style="color: red;">*</span>
                                <label style="width: 9%">楼盘地址:</label>
                                <select style="width:21.5%" class="form-control" name="province_id" id="province_id"
                                        title="区域">
                                    <option value="">请选择</option>
                                    <c:forEach var="province" items="${provinceList}">
                                        <option value="${province.id }"
                                                <c:if test="${pd.province_id eq province.id }">selected</c:if>  >${province.name }</option>
                                    </c:forEach>
                                </select>
                                <select style="width: 21.5%" id="city_id" name="city_id" class="form-control"
                                        disabled="disabled" title="城市">
                                    <option value="">请选择</option>
                                    <c:forEach var="city" items="${cityList}">
                                        <option value="${city.id }"
                                                <c:if test="${pd.city_id eq city.id }">selected</c:if>  >${city.name }</option>
                                    </c:forEach>
                                </select>
                                <select style="width:21.5%" class="form-control" name="county_id" id="county_id"
                                        title="郡/县" disabled="disabled">
                                    <option value="">请选择</option>
                                    <c:forEach var="coundty" items="${coundtyList}">
                                        <option value="${coundty.id }"
                                                <c:if test="${pd.county_id eq coundty.id }">selected</c:if>  >${coundty.name }</option>
                                    </c:forEach>
                                </select>
                                <input style="width:22%" class="form-control" type="text" name="agent_address"
                                       id="agent_address" placeholder="这里输入地址" value="${pd.address_name}"/>
                            </div>
                            <div class="form-group form-inline">
                                <span type="hidden">&nbsp&nbsp</span>
                                <label
                                        style="width: 9%">楼盘类型:</label> <select style="width: 21%"
                                                                                class="form-control" name="type_name"
                                                                                id="type_name">
                                <option value="">请选择</option>
                                <c:forEach items="${typeList}" var="type">
                                    <option value="${type.id}"
                                            <c:if test="${type.id eq pd.houses_type_id && pd.houses_type_id != ''}">selected</c:if>>${type.type_name }</option>
                                </c:forEach>
                            </select> <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
                                <span style="color: red;">*</span>
                                <label style="width: 9%">楼盘状态:</label> <select
                                    style="width: 21%" class="form-control" name="status_name"
                                    id="status_name">
                                <option value="">请选择</option>
                                <c:forEach items="${statusList}" var="status">
                                    <option value="${status.id}"
                                            <c:if test="${status.id eq pd.houses_status_id && pd.houses_status_id != ''}">selected</c:if>>${status.status_name }</option>
                                </c:forEach>
                            </select>
                                <span style="color: red;margin-left:18px;">*</span>
                                <label style="width: 9%;">别墅数量:</label>
                                <input style="width: 21%" type="text" type="text" name="villadom_num" id="villadom_num"
                                       value="${pd.villadom_num}" placeholder="这里输入别墅数量" title="别墅数量"
                                       class="form-control">
                            </div>
                            <c:if test="${msg== 'editS' }">
                                <div class="form-group form-inline">
                                    <label style="width:9%;margin-left:10px;">录入人:</label>
                                    <input style="width: 21%" type="text" readonly="readonly" value="${pd.modified_by}"
                                           class="form-control">
                                    <label style="width: 9%;margin-left:40px;">录入时间:</label>
                                    <input style="width: 21%" type="text" readonly="readonly"
                                           value="${pd.entering_time}" class="form-control">
                                    <label style="width: 9%;margin-left:29px;">最后修改人:</label>
                                    <input style="width: 21%" type="text" readonly="readonly"
                                           value="${pd.modified_name}" class="form-control">
                                </div>
                            </c:if>
                            <div class="form-group form-inline">
                                <label style="width: 9%;margin-left:10px;">楼盘风格:</label>
                                <select style="width: 21%" class="form-control" name="houses_style" id="houses_style">
                                    <option value="">请选择</option>
                                    <option value="1" <c:if test="${pd.houses_style =='1'}"> selected</c:if>>法式</option>
                                    <option value="2" <c:if test="${pd.houses_style =='2'}"> selected</c:if>>中式</option>
                                    <option value="3" <c:if test="${pd.houses_style =='3'}"> selected</c:if>>欧式</option>
                                    <option value="4" <c:if test="${pd.houses_style =='4'}"> selected</c:if>>现代</option>
                                    <option value="5" <c:if test="${pd.houses_style =='5'}"> selected</c:if>>美式</option>
                                </select>
                                <label style="width: 9%;margin-left:41px;">是否有样板梯:</label>
                                <select style="width: 21%" class="form-control" name="is_templet" id="is_templet">
                                    <option value="">请选择</option>
                                    <option value="0" <c:if test="${pd.is_templet =='0'}"> selected</c:if>>否</option>
                                    <option value="1" <c:if test="${pd.is_templet =='1'}"> selected</c:if>>是</option>
                                </select>
                                <label style="width: 9%;margin-left:28px;">户型数:</label>
                                <input style="width: 21%" type="text" id="households" name="households"
                                       value="${pd.households}" placeholder="这里输入楼盘户型数" title="楼盘户型数"
                                       class="form-control">
                            </div>
                            <div class="form-group form-inline">
                                <label style="width: 9%;margin-left:10px;">楼盘相关项目:</label> <input
                                    style="width: 21%" type="text" type="text"
                                    name="houses_relevantProject" id="houses_relevantProject"
                                    value="${pd.houses_relevantProject}" placeholder="这里输入楼盘相关项目"
                                    title="楼盘相关项目" class="form-control">

                            </div>
                            <div id="housesT">
                                <div class="form-group form-inline">
                                    <label style="width: 9%;margin-left: 10px;">楼盘效果图附件:</label>
                                    <input class="form-control" type="hidden" name="house_type_img"
                                           placeholder="这里输入安装队保险" value="" title="安装队保险"/>
                                    <input style="width: 21%" class="form-control" type="file"
                                           name="houseimg" id="houseimg" placeholder="这里输入安装队保险"
                                           title="安装队保险" onchange="upload(this)"/>
                                    <c:if test="${msg== 'saveS' }">
                                        <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm"
                                                title="添加" type="button" onclick="addHousesImg();">加
                                        </button>
                                        <button style="margin-left:3px;margin-top:3px;display:none;"
                                                class="btn btn-sm btn-info btn-sm"
                                                title="查看" type="button" onclick="imgChack(this);">查看
                                        </button>
                                    </c:if>
                                    <c:if test="${msg== 'editS' }">
                                        <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm"
                                                title="添加" type="button" onclick="addHousesImg1();">加
                                        </button>
                                        <c:if test="${pd.house_type_img==null || pd.house_type_img=='' }">
                                            <button style="margin-left:3px;margin-top:3px;display:none;"
                                                    class="btn btn-sm btn-info btn-sm"
                                                    title="查看" type="button" onclick="imgChack(this);">查看
                                            </button>
                                        </c:if>
                                        <c:if test="${pd ne null and pd.house_type_img ne null and pd.house_type_img ne '' }">
                                            <button style="margin-left:3px;margin-top:3px;"
                                                    class="btn btn-sm btn-info btn-sm"
                                                    title="查看" type="button" onclick="imgChack(this);">查看
                                            </button>
                                            <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
                                        </c:if>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-primary">
                        <div class="panel-heading">楼盘交付信息</div>
                        <div class="panel-body">
                            <div class="form-group form-inline">
                                <label style="width: 9%;margin-left:10px;">楼盘交房序号:</label>
                                <input style="width: 21%" type="text" id="delivery_id" name="delivery_id"
                                       readonly="readonly"
                                       value="${pd.delivery_id}" class="form-control">
                            </div>
                            <div id="delivery">
                                <div class="form-group form-inline">
                                    <span style="color: red;">*</span>
                                    <label style="width: 9%;">楼盘交房日期:</label>
                                    <input style="width: 21%" type="text" id="delivery_time" name="delivery_time"
                                           readonly="readonly" value="${pd.delivery_time}" onclick="laydate()"
                                           class="form-control">
                                    <label style="width: 9%;margin-left:30px;">楼盘交房备注:</label>
                                    <input style="width: 21%" type="text" id="delivery_remark" name="delivery_remark"
                                           value="${pd.delivery_remark}" class="form-control">
                                    <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm"
                                            title="添加" type="button" onclick="addDelivery();">加
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-primary">
                        <div class="panel-heading">我司安装电梯情况</div>
                        <div class="panel-body">
                            <div class="form-group form-inline" style="margin-top: 10px">
                                    <textarea style="width:100%" rows="3" cols="1" name="installation_status"
                                              id="installation_status"
                                              placeholder="在此输入我司安装电梯情况">${pd.installation_status}</textarea>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-primary">
                        <div class="panel-heading">物业基本信息</div>
                        <div class="panel-body">

                            <div class="form-group form-inline">
                                <span style="color: red;">*</span>
                                <label style="width: 9%">物业公司名称:</label>
                                <div style="display: inline" class=" ui-widget">
                                    <input
                                            style="width: 21%" type="text" name="houses_phone"
                                            id="houses_phone" value="${pd.houses_phone}"
                                            placeholder="这里输入物业公司名称" title="物业公司名称" class="form-control">
                                </div>
                                <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp</span>
                                <span style="color: red;">*</span>
                                <label style="width: 9%">物业联系人:</label> <input
                                    style="width: 21%" type="text" name="houses_contacts"
                                    id="houses_contacts" value="${pd.houses_contacts}"
                                    placeholder="这里输入物业联系人" title="物业联系人" class="form-control">
                                <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp</span>
                                <span style="color: red;">*</span>
                                <label style="width: 9%">物业联系人电话:</label> <input
                                    style="width: 21%" type="text" name="houses_con_phone"
                                    id="houses_con_phone" value="${pd.houses_con_phone}"
                                    placeholder="这里输入物业联系人电话" title="物业联系人电话" class="form-control">

                            </div>
                            <div class="form-group form-inline">
                                <span type="hidden">&nbsp&nbsp</span>
                                <label style="width: 9%">物业传真:</label> <input style="width: 21%"
                                                                              type="text" type="text"
                                                                              name="houses_faxes" id="houses_faxes"
                                                                              value="${pd.houses_faxes}"
                                                                              placeholder="这里输入物业传真" title="传真"
                                                                              class="form-control"> <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
                                <label style="width: 9%">物业邮箱:</label> <input style="width: 21%"
                                                                              type="text" name="houses_email"
                                                                              id="houses_email"
                                                                              value="${pd.houses_email}"
                                                                              placeholder="这里输入物业邮箱" title="邮箱"
                                                                              class="form-control"> <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
                                <label style="width: 9%">物业邮编:</label> <input style="width: 21%"
                                                                              type="text" type="text"
                                                                              name="houses_postcode"
                                                                              id="houses_postcode"
                                                                              value="${pd.houses_postcode}"
                                                                              placeholder="这里输入物业所在地邮编" title="邮编"
                                                                              class="form-control">
                            </div>

                            <div class="form-group form-inline">
                                <span type="hidden">&nbsp&nbsp</span>
                                <label style="width: 9%">服务网点:</label> <input
                                    style="width: 21%" type="text" name="sales_point"
                                    id="sales_point" value="${pd.sales_point}"
                                    placeholder="这里输入服务网点地址" title="服务网点" class="form-control">
                                <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>

                                <label style="width: 9%">备注:</label> <input style="width: 21%"
                                                                            type="text" name="remarks" id="remarks"
                                                                            value="${pd.remarks}"
                                                                            placeholder="这里输入备注" title="备注"
                                                                            class="form-control">
                            </div>
                            <!--
                             ztree地区显示模块-->
                            <div class="ibox float-e-margins" id="menuContent"
                                 class="menuContent"
                                 style="display: none; position: absolute; z-index: 99; border: solid 1px #18a689; max-height: 300px; overflow-y: scroll; overflow-x: auto">
                                <div class="ibox-content">
                                    <div>
                                        <ul id="myzTree" class="ztree"
                                            style="margin-top: 0; width: 170px;"></ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-4" style="width: 100%; margin-top: -18px;">
                    <div class="panel panel-primary">
                        <div class="panel-heading">开发商基本信息</div>
                        <div class="panel-body">
                            <div class="form-group form-inline" style="margin-top: 10px">
                                <span style="color: red;">*</span>
                                <label style="width: 9%">开发商公司名称:</label>
                                <select class="selectpicker" data-live-search="true" data-width="16.5%"
                                        name="houses_dev_name" id="houses_dev_name">
                                    <option value="">请选择</option>
                                    <c:forEach items="${ordinaryList}" var="ord">
                                        <option value="${ord.customer_id}"
                                                <c:if test="${ord.customer_id eq pd.houses_dev_name && pd.houses_dev_name != ''}">selected</c:if>>${ord.customer_name}</option>
                                    </c:forEach>
                                </select>
                                <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm"
                                        title="刷新" type="button" onclick="comp();">刷新
                                </button>
                                <span type="hidden">&nbsp&nbsp&nbsp</span>
                                <span style="color: red;margin-left: 5px">*</span>
                                <label style="width: 9%">开发商公司地址:</label> <input
                                    style="width: 21%" type="text" name="houses_dev_address"
                                    id="houses_dev_address" value="${pd.houses_dev_address}"
                                    placeholder="这里输入开发商公司地址" title="开发商公司地址" class="form-control">

                                <label style="width: 9%;margin-left: 30px">开发商联系电话:</label> <input
                                    style="width: 21%" type="text" type="text"
                                    name="houses_dev_phone" id="houses_dev_phone"
                                    value="${pd.houses_dev_phone}" placeholder="这里输入开发商联系电话"
                                    title="开发商联系电话" class="form-control">

                            </div>
                            <div class="form-group form-inline">
                                <span type="hidden">&nbsp&nbsp</span>
                                <label style="width: 9%">开发商公司邮箱:</label> <input
                                    style="width: 21%" type="text" name="houses_dev_email"
                                    id="houses_dev_email" value="${pd.houses_dev_email}"
                                    placeholder="这里输入开发商公司邮箱" title="开发商公司邮箱" class="form-control">
                                <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
                                <label style="width: 9%">开发商公司传真:</label> <input
                                    style="width: 21%" type="text" type="text"
                                    name="houses_dev_faxes" id="houses_dev_faxes"
                                    value="${pd.houses_dev_faxes}" placeholder="这里输入开发商公司传真"
                                    title="开发商公司传真" class="form-control"> <span
                                    type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
                                <label style="width: 9%">开发商联系人:</label> <input
                                    style="width: 21%" type="text" name="houses_dev_contacts"
                                    id="houses_dev_contacts" value="${pd.houses_dev_contacts}"
                                    placeholder="这里输入开发商联系人" title="开发商联系人" class="form-control">
                            </div>
                            <div class="form-group form-inline">
                                <span type="hidden">&nbsp&nbsp</span>
                                <label style="width: 9%">开发商联系人电话:</label> <input
                                    style="width: 21%" type="text" type="text"
                                    name="houses_dev_con_phone" id="houses_dev_con_phone"
                                    value="${pd.houses_dev_con_phone}" placeholder="这里输入开发商联系人电话"
                                    title="开发商联系电话" class="form-control">
                            </div>
                        </div>
                    </div>
                </div>
                <tr>
                    <td><a class="btn btn-primary"
                           style="width: 150px; height: 34px; float: left;"
                           onclick="save1();">保存</a></td>
                    <td><a class="btn btn-danger"
                           style="width: 150px; height: 34px; float: right;"
                           onclick="javascript:CloseSUWin('EditShops');">关闭</a></td>
                </tr>
            </div>
        </div>
    </div>
</form>
<!-- ztree区域显示模块 -->
<div class="ibox float-e-margins" id="areaContent" class="menuContent"
     style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
    <div class="ibox-content">
        <div>
            <ul id="area_zTree" class="ztree" style="margin-top:0; width:170px;"></ul>
        </div>
    </div>
</div>
</body>
<%--zTree--%>
<script type="text/javascript"
        src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
        src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
        src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript">
    //地区 树形显示
    //ztree
    var setting = {
        view: {
            dblClickExpand: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClick,
            onClick: onClick
        }
    };

    var zNodes =${areas};//数据源

    function beforeClick(treeId, treeNode) {
        var check = (treeNode && treeNode.pid != 0);
        if (!check) {
            swal({
                title: "不能选择[" + treeNode.name + "]！",
                text: "请重新选择",
                type: "error",
                showConfirmButton: false,
                timer: 1500
            });
        }
        return check;
    }

    function onClick(e, treeId, treeNode) {
        var deptObj = $("#houses_region_id");
        deptObj.attr("value", treeNode.name);
        var deptId = $("#parentId");
        deptId.attr("value", treeNode.id);

    }


    //选中开发商后 加载选中的开发商信息
    $("#houses_dev_name").change(function () {
        var customer_id = $(this).find("option:checked").attr("value"); //获取选中值的编号
        $.ajax({
            url: "houses/checkedcomp.do", //请求地址
            type: "POST", //请求方式
            data: {
                'customer_id': customer_id
            }, //请求参数
            success: function (result) {
                $("#houses_dev_address").val(result.ordinary.company_address);
                $("#houses_dev_phone").val(result.ordinary.company_phone);
                $("#houses_dev_email").val(result.ordinary.company_email);
                $("#houses_dev_faxes").val(result.ordinary.company_fax);
                $("#houses_dev_contacts").val(result.ordinary.customer_contact);
                $("#houses_dev_con_phone").val(result.ordinary.contact_phone);
            }
        });
    });


    //刷新   加载最新开发商
    function comp() {
        $.ajax({
            url: "houses/comp.do", //请求地址
            type: "POST", //请求方式
            success: function (result) {
                $("#houses_dev_name").empty();
                $("#houses_dev_address").val("");
                $("#houses_dev_phone").val("");
                $("#houses_dev_email").val("");
                $("#houses_dev_faxes").val("");
                $("#houses_dev_contacts").val("");
                $("#houses_dev_con_phone").val("");
                //↑↑↑以上是清空开发商信息内容↑↑↑
                //↓↓↓以下是给开发商下拉框加载最新开发商↓↓↓
                var jsonObj = result.ordinaryList;
                var str = "<option value=''>请选择</option>";
                for (var i = 0; i < jsonObj.length; i++) {
                    str += "<option value='" + jsonObj[i].customer_id + "'>" + jsonObj[i].customer_name + "</option>";
                }
                $("#houses_dev_name").html(str);
            }
        });
    }


    //修改时候判断楼盘名字
    function UpHousesName() {
        if ($("#houses_name").val() != $("#housesName").val()) {
            var name = $("#houses_name").val();
            var url = "<%=basePath%>houses/HousesName.do?houses_name=" + name + "&tm="
                + new Date().getTime();
            $.get(url, function (data) {
                if (data.msg == "error") {
                    $("#houses_name").tips({
                        side: 3,
                        msg: '楼盘名称已存在',
                        bg: '#AE81FF',
                        time: 3
                    });

                    setTimeout("$('#houses_name').val('')", 2000);
                }
            });
        }
    }


    // 显示城市
    var provinceName = ""; //省份名称
    var cityName = "";     //城市名称
    var countyName = "";	  //群/县
    var agentAddressName = ""; //地址名称
    $(document).ready(function () {
        $.fn.zTree.init($("#myzTree"), setting, zNodes);
        var zTree = $.fn.zTree.getZTreeObj("myzTree");
        zTree.expandAll(true);

        if ($("#is_constructor").val() == 1) {
            $("#confirm_constructor").show();
        } else {
            $("#confirm_constructor").hide();
        }
        var province_id = $("#province_id option:selected").val();

        if (province_id != null && province_id != "") {
            $("#city_id").attr("disabled", false);
        }
        var county_id = $("#county_id option:selected").val();
        if (county_id != null && county_id != "") {
            $("#county_id").attr("disabled", false);
        }
        provinceName = $("#province_id option:selected").text();
        cityName = $("#city_id option:selected").text();
        countyName = $("#county_id option:selected").text();
        agentAddressName = $("#agent_address").val();

        $("#houses_phone").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: "customer/getQixinbaoCompany",
                    dataType: "json",
                    data: {
                        searchKey: request.term
                    },
                    success: function (data) {
                        response($.map(data, function (item) {
                            return {
                                label: item.companyName,
                                value: item.companyName,
                                telephone: item.telephone,
                                companyKind: item.companyKind,
                                operName: item.operName,
                                companyAddress: item.companyAddress,
                                businessLienceNum: item.businessLienceNum,
                            }
                        }));
                    }
                });
            },
            minLength: 2
        });
    });
    $("#province_id").change(function () {
        var province_id = $("#province_id option:selected").val();

        if (province_id != null && province_id != "") {
            provinceName = $("#province_id option:selected").text();
            $.post("city/findAllCityByProvinceId.do", {province_id: province_id}, function (result) {
                $("#city_id").empty();
                $("#county_id").empty();
                if (result.length > 0) {
                    $("#city_id").attr("disabled", false);
                    $("#city_id").append("<option value=''>请选择</option>");
                    $.each(result, function (key, value) {
                        $("#city_id").append("<option value='" + value.id + "'  >" + value.name + "</option>");
                    });
                    $("#county_id").attr("disabled", true);
                } else {
                    $("#city_id").attr("disabled", true);
                }

            });
        } else {
            $("#city_id").empty();
            $("#city_id").attr("disabled", true);
            $("#county_id").empty();
            $("#county_id").attr("disabled", true);
            provinceName = "";
            cityName = "";
            countyName = "";
        }
    });

    //显示 群/县
    $("#city_id").change(function () {
        var city_id = $("#city_id option:selected").val();
        if (city_id != null && city_id != "") {
            cityName = $("#city_id option:selected").text();
            $.post("city/findAllCountyByCityId.do", {city_id: city_id}, function (result) {
                $("#county_id").empty();

                if (result.length > 0) {
                    $("#county_id").attr("disabled", false);
                    $("#county_id").append("<option value=''>请选择</option>");
                    $.each(result, function (key, value) {
                        $("#county_id").append("<option value='" + value.id + "'>" + value.name + "</option>");
                    });
                } else {
                    $("#county_id").attr("disabled", true);
                }
            });
        } else {
            $("#county_id").empty();
            $("#county_id").attr("disabled", true);
            cityName = "";
            countyName = "";
        }
    });

    //获取群/县
    $("#county_id").change(function () {
        var county_id = $("#county_id option:selected").val();
        if (county_id != null && county_id != "") {
            countyName = $("#county_id option:selected").text();
        } else {
            countyName = "";
        }
    });

    //获取输入地址名称
    $("#agent_address").keyup(function () {
        var agent_address = $("#agent_address").val();
        if (agent_address != null && agent_address != "") {
            agentAddressName = agent_address;
        } else {
            agentAddressName = "";
        }

    });


    //所属区域
    var area_setting = {
        view: {
            dblClickExpand: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClickArea,
            onClick: onClickArea
        }
    };

    var AreazNodes =${areas};
    var log, className = "dark";

    function beforeClickArea(treeId, treeNode) {
        var url = "<%=basePath%>houses/checkAreaNode.do?id=" + treeNode.id;
        $.post(
            url,
            function (data) {
                if (data.msg == 'success') {
                    $("#customer_area_ordinary").val(treeNode.id);
                    $("#customer_area_text_ordinary").val(treeNode.name);
                    $("#area_id_merchant").val(treeNode.id);
                    $("#area_id_text_merchant").val(treeNode.name);
                    $("#areaContent").hide();
                    return true;
                }
            }
        );
    }

    function onClickArea(e, treeId, treeNode) {
    }

    function beforeClickCompany(treeId, treeNode, clickFlag) {
        $("#customer_company_ordinary").val(treeNode.id);
        $("#customer_company_text_ordinary").val(treeNode.name);
        $("#customer_company_merchant").val(treeNode.id);
        $("#customer_company_text_merchant").val(treeNode.name);
        $("#customer_company_core").val(treeNode.id);
        $("#customer_company_text_core").val(treeNode.name);
        $("#companyContent").hide();
    }


    $(document).ready(function () {
        $.fn.zTree.init($("#area_zTree"), area_setting, AreazNodes);
        var AreazTree = $.fn.zTree.getZTreeObj("area_zTree");
        AreazTree.expandAll(true);
        $.fn.zTree.init($("#company_zTree"), company_setting, CompanyzNodes);
        var CompanyzTree = $.fn.zTree.getZTreeObj("company_zTree");
        CompanyzTree.expandAll(true);
    });

    function showAreaMenuOrdinary() {
        var areaObj = $("#customer_area_text_ordinary");
        var areaOffset = $("#customer_area_text_ordinary").offset();
        $("#areaContent").css({
            left: (areaOffset.left + 6) + "px",
            top: areaOffset.top + areaObj.outerHeight() + "px"
        }).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }

    //实现多个供应商
    var i = 0;

    function addDelivery() {
        i = i + 1;
        $("#delivery").append('<div id="delivery' + i + '" class="form-group form-inline">' +
            '<span style="color: red;">*</span>' +
            ' <label style="width: 9%;">楼盘交房日期:</label> ' +
            '<input style="width: 21%" type="text" id="delivery_time" name="delivery_time"' +
            ' readonly="readonly" value="${pd.delivery_time}" onclick="laydate()" class="form-control">' +
            '<label style="width: 9%;margin-left:33px;">楼盘交房备注:</label> ' +
            '<input style="width: 21%" type="text" id="delivery_remark" name="delivery_remark"' +
            'value="${pd.delivery_remark}" class="form-control">' +
            '<button style="margin-left:6px;margin-top:4px;" class="btn  btn-danger btn-sm" title="删除" type="button"onclick="delDelivery(' + i + ');">减</button>' +
            '</div>'
        );
    }

    //删除供应商
    function delDelivery(o) {
        document.getElementById("delivery").removeChild(document.getElementById("delivery" + o));
    }

    //实现多个楼盘效果图
    var j = 0;

    function addHousesImg() {
        j = j + 1;
        $("#housesT").append('<div id="housesT' + j + '" class="form-group form-inline">' +
            '<label style="width:9%;margin-left:13px;">楼盘效果图附件:</label>' +
            '<input class="form-control" type="hidden" name="house_type_img"' +
            ' placeholder="这里输入安装队保险"' +
            'value="" title="安装队保险" />' +
            '<input style="width: 21%" class="form-control" type="file"' +
            'name="houseimg" id="houseimg" placeholder="这里输入安装队保险"' +
            'title="安装队保险" onchange="upload(this)" />' +
            '<button style="margin-left:6px;margin-top:4px;" class="btn  btn-danger btn-sm"' +
            'title="删除" type="button"onclick="delHouses(' + j + ');">减</button>' +
            '<c:if test="${msg==\'saveS\'}">' +
            '<button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" ' +
            'title="查看" type="button" onclick="imgChack(this);">查看</button> ' +
            '</c:if>' +
            '<c:if test="${msg==\'editS\'}">' +
            '<button  style="margin-left:6px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" ' +
            'title="查看" type="button" onclick="imgChack(this);">查看</button> ' +
            '</c:if>' +
            '<c:if test="${pd ne null and pd.house_type_img ne null and pd.house_type_img ne '' }">' +
            '  <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>' +
            '</c:if>' +
            '</div>'
        );
    }

    function addHousesImg1() {
        j = j + 1;
        $("#housesT").append('<div id="housesT' + j + '" class="form-group form-inline">' +
            '<label style="width:9%;margin-left:13px;">楼盘效果图附件:</label>' +
            '<input class="form-control" type="hidden" name="house_type_img"' +
            ' placeholder="这里输入安装队保险"' +
            'value="" title="安装队保险" />' +
            '<input style="width: 21%" class="form-control" type="file"' +
            'name="houseimg" id="houseimg" placeholder="这里输入安装队保险"' +
            'title="安装队保险" onchange="upload(this)" />' +
            '<button style="margin-left:6px;margin-top:4px;" class="btn  btn-danger btn-sm"' +
            'title="删除" type="button"onclick="delHouses(' + j + ');">减</button>' +
            '<button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" ' +
            'title="查看" type="button" onclick="imgChack(this);">查看</button> ' +
            '</div>'
        );
    }

    //删除楼盘效果图
    function delHouses(o) {
        document.getElementById("housesT").removeChild(document.getElementById("housesT" + o));
    }
</script>

</html>
