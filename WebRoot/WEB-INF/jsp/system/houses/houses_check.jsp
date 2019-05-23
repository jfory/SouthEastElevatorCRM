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
            //查看时加载楼盘交付信息
            var deliveryJSON = $("#deliveryJSON").val();
            if (deliveryJSON != "") {
                setDeliveryJSON(deliveryJSON);
            }
            //查看时加载楼盘效果图信息
            var housesJSON = $("#houses_img_json").val();
            if (housesJSON != "") {
                setHousesJSON(housesJSON);
            }
        });

        function CloseSUWin(id) {
            window.parent.$("#" + id).data("kendoWindow").close();
        }


        //文件异步上传   e代表当前File对象,v代表对应路径值
        function upload(e, v) {
            var filePath = $(e).val();
            var arr = filePath.split("\\");
            var fileName = arr[arr.length - 1];
            var suffix = filePath.substring(filePath.lastIndexOf("."))
                .toLowerCase();
            var fileType = ".xls|.xlsx|.doc|.docx|.txt|.pdf|";
            if (filePath == null || filePath == "") {
                $(v).val("");
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
                        $(v).val(result.filePath);

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
    </script>
</head>

<body>
<form action="houses/${msg}.do" name="housesForm" id="housesForm" method="post">
    <input type="hidden" name="housesName" id="housesName" value="${pd.houses_name}"/>
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
                                <label style="width: 9%">楼盘编号:</label> <input
                                    style="width: 21%" type="text" name="houses_no" disabled="disabled"
                                    readonly="readonly" id="houses_no" value="${pd.houses_no}"
                                    placeholder="楼盘编号由系统自动生成" title="楼盘编号" class="form-control"/>
                                <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
                                <label style="width: 9%;">楼盘名称:</label>

                                <input style="width: 21%" type="text" name="houses_name" disabled="disabled"
                                       id="houses_name" value="${pd.houses_name}"
                                       placeholder="这里输入楼盘名称" title="楼盘名称" onblur="UpHousesName()"
                                       class="form-control"/>


                                <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span> <label
                                    style="width: 9%">楼盘所属区域:</label>
                                <input type="text" readonly="readonly" style="width:21%" disabled="disabled"
                                       name="customer_area_text_ordinary" id="customer_area_text_ordinary"
                                       value="${pd.customer_area_text }" placeholder="请选择区域" title="所属区域"
                                       class="form-control" onclick="showAreaMenuOrdinary();"/>
                                <input style="width:170px" type="hidden" name="customer_area_ordinary"
                                       id="customer_area_ordinary" value="${pd.customer_area}" title="所属区域"
                                       class="form-control">
                            </div>
                            <div class="form-group form-inline">
                                <label style="width: 9%">楼盘地址:</label>
                                <select style="width:21.5%" class="form-control" disabled="disabled" name="province_id"
                                        id="province_id" title="区域">
                                    <option value="">请选择</option>
                                    <c:forEach var="province" items="${provinceList}">
                                        <option value="${province.id }"
                                                <c:if test="${pd.province_id eq province.id }">selected</c:if>  >${province.name }</option>
                                    </c:forEach>
                                </select>
                                <select style="width: 21.5%" id="city_id" disabled="disabled" name="city_id"
                                        class="form-control" disabled="disabled" title="城市">
                                    <option value="">请选择</option>
                                    <c:forEach var="city" items="${cityList}">
                                        <option value="${city.id }"
                                                <c:if test="${pd.city_id eq city.id }">selected</c:if>  >${city.name }</option>
                                    </c:forEach>
                                </select>
                                <select style="width:21.5%" class="form-control" disabled="disabled" name="county_id"
                                        id="county_id" title="郡/县" disabled="disabled">
                                    <option value="">请选择</option>
                                    <c:forEach var="coundty" items="${coundtyList}">
                                        <option value="${coundty.id }"
                                                <c:if test="${pd.county_id eq coundty.id }">selected</c:if>  >${coundty.name }</option>
                                    </c:forEach>
                                </select>
                                <input style="width:22%" class="form-control" disabled="disabled" type="text"
                                       name="agent_address" id="agent_address" placeholder="这里输入地址"
                                       value="${pd.address_name}"/>
                            </div>
                            <div class="form-group form-inline">
                                <label
                                        style="width: 9%">楼盘类型:</label> <select style="width: 21%" disabled="disabled"
                                                                                class="form-control" name="type_name"
                                                                                id="type_name">
                                <option value="">请选择</option>
                                <c:forEach items="${typeList}" var="type">
                                    <option value="${type.id}"
                                            <c:if test="${type.id eq pd.houses_type_id && pd.houses_type_id != ''}">selected</c:if>>${type.type_name }</option>
                                </c:forEach>
                            </select> <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
                                <label style="width: 9%">楼盘状态:</label> <select disabled="disabled"
                                                                               style="width: 21%" class="form-control"
                                                                               name="status_name"
                                                                               id="status_name">
                                <option value="">请选择</option>
                                <c:forEach items="${statusList}" var="status">
                                    <option value="${status.id}"
                                            <c:if test="${status.id eq pd.houses_status_id && pd.houses_status_id != ''}">selected</c:if>>${status.status_name }</option>
                                </c:forEach>
                            </select>
                                <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
                                <label style="width: 9%">别墅数量:</label> <input disabled="disabled"
                                                                              style="width: 21%" type="text" type="text"
                                                                              name="villadom_num" id="villadom_num"
                                                                              value="${pd.villadom_num}"
                                                                              placeholder="这里输入别墅数量"
                                                                              title="别墅数量" class="form-control">
                            </div>
                            <div class="form-group form-inline">
                                <label style="width: 9%">楼盘相关项目:</label> <input disabled="disabled"
                                                                                style="width: 21%" type="text"
                                                                                type="text"
                                                                                name="houses_relevantProject"
                                                                                id="houses_relevantProject"
                                                                                value="${pd.houses_relevantProject}"
                                                                                placeholder="这里输入楼盘相关项目"
                                                                                title="楼盘相关项目" class="form-control">
                                <label style="width: 9%;margin-left:30px;">楼盘风格:</label>
                                <select style="width: 21%" class="form-control" disabled="disabled" name="houses_style"
                                        id="houses_style">
                                    <option value="0">请选择</option>
                                    <option value="1" <c:if test="${pd.houses_style =='1'}"> selected</c:if>>法式</option>
                                    <option value="2" <c:if test="${pd.houses_style =='2'}"> selected</c:if>>中式</option>
                                    <option value="3" <c:if test="${pd.houses_style =='3'}"> selected</c:if>>欧式</option>
                                    <option value="4" <c:if test="${pd.houses_style =='4'}"> selected</c:if>>现代</option>
                                    <option value="5" <c:if test="${pd.houses_style =='5'}"> selected</c:if>>美式</option>
                                </select>
                                <label style="width: 9%;margin-left:30px;">是否有样板梯:</label>
                                <select style="width: 21%" class="form-control" name="is_templet" id="is_templet"
                                        disabled="disabled">
                                    <option value="">请选择</option>
                                    <option value="0" <c:if test="${pd.is_templet =='0'}"> selected</c:if>>否</option>
                                    <option value="1" <c:if test="${pd.is_templet =='1'}"> selected</c:if>>是</option>
                                </select>
                            </div>
                            <div class="form-group form-inline">
                                <label style="width: 9% ">录入人:</label>
                                <input style="width: 21%" disabled="disabled" type="text" value="${pd.modified_by}"
                                       class="form-control">
                                <label style="width: 9%;margin-left:30px;">录入时间:</label>
                                <input style="width: 21%" disabled="disabled" type="text" value="${pd.entering_time}"
                                       class="form-control">
                                <label style="width: 9%;margin-left:30px;">最后修改人:</label>
                                <input style="width: 21%" disabled="disabled" type="text" value="${pd.modified_name}"
                                       class="form-control">
                            </div>
                            <div id="housesT">
                                <div class="form-group form-inline">
                                    <label style="width: 9%;">楼盘效果图附件:</label>
                                    <input class="form-control" type="hidden" name="house_type_img"
                                           placeholder="这里输入安装队保险"
                                           value="" title="安装队保险"/>
                                    <input style="width: 21%" class="form-control" type="file" disabled="disabled"
                                           name="houseimg" id="houseimg" placeholder="这里输入安装队保险"
                                           title="安装队保险" onchange="upload(this)"/>
                                    <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm"
                                            disabled="disabled"
                                            title="添加" type="button" onclick="addHousesImg();">加
                                    </button>
                                    <c:if test="${pd ne null and pd.house_type_img ne null and pd.house_type_img ne '' }">
                                        <button style="margin-left:3px;margin-top:3px;"
                                                class="btn btn-sm btn-info btn-sm"
                                                title="查看" type="button" onclick="imgChack(this);">查看
                                        </button>
                                        <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
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
                                       disabled="disabled" value="${pd.delivery_id}" class="form-control">
                            </div>
                            <div id="delivery">
                                <div class="form-group form-inline">
                                    <span style="color: red;">*</span>
                                    <label style="width: 9%;">楼盘交房日期:</label>
                                    <input style="width: 21%" type="text" id="delivery_time" name="delivery_time"
                                           disabled="disabled" value="${pd.delivery_time}" onclick="laydate()"
                                           class="form-control">
                                    <label style="width: 9%;margin-left:30px;">楼盘交房备注:</label>
                                    <input style="width: 21%" type="text" id="delivery_remark" name="delivery_remark"
                                           disabled="disabled" value="${pd.delivery_remark}" class="form-control">
                                    <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm"
                                            title="添加"
                                            disabled="disabled" type="button" onclick="addDelivery();">加
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
                                              id="installation_status" disabled readonly
                                              placeholder="在此输入我司安装电梯情况">${pd.installation_status}</textarea>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-primary">
                        <div class="panel-heading">物业基本信息</div>
                        <div class="panel-body">
                            <div class="form-group form-inline">
                                <label style="width: 9%">物业公司名称:</label> <input disabled="disabled"
                                                                                style="width: 21%" type="text"
                                                                                name="houses_phone"
                                                                                id="houses_phone"
                                                                                value="${pd.houses_phone}"
                                                                                placeholder="这里输入楼盘联系电话" title="楼盘联系电话"
                                                                                class="form-control">
                                <label style="width: 9%;margin-left: 30px;">物业联系人:</label> <input disabled="disabled"
                                                                                                  style="width: 21%"
                                                                                                  type="text"
                                                                                                  name="houses_contacts"
                                                                                                  id="houses_contacts"
                                                                                                  value="${pd.houses_contacts}"
                                                                                                  placeholder="这里输入楼盘联系人"
                                                                                                  title="楼盘联系人"
                                                                                                  class="form-control">
                                <label style="width: 9%;margin-left: 30px;">物业联系人电话:</label> <input disabled="disabled"
                                                                                                    style="width: 21%"
                                                                                                    type="text"
                                                                                                    name="houses_con_phone"
                                                                                                    id="houses_con_phone"
                                                                                                    value="${pd.houses_con_phone}"
                                                                                                    placeholder="这里输入楼盘联系人电话"
                                                                                                    title="楼盘联系人电话"
                                                                                                    class="form-control">

                            </div>
                            <div class="form-group form-inline">
                                <label style="width: 9%">物业传真:</label> <input style="width: 21%" disabled="disabled"
                                                                              type="text" type="text"
                                                                              name="houses_faxes" id="houses_faxes"
                                                                              value="${pd.houses_faxes}"
                                                                              placeholder="这里输入楼盘传真" title="传真"
                                                                              class="form-control">
                                <label style="width: 9%;margin-left: 30px;">物业邮箱:</label> <input style="width: 21%"
                                                                                                 disabled="disabled"
                                                                                                 type="text"
                                                                                                 name="houses_email"
                                                                                                 id="houses_email"
                                                                                                 value="${pd.houses_email}"
                                                                                                 placeholder="这里输入楼盘邮箱"
                                                                                                 title="邮箱"
                                                                                                 class="form-control">
                                <label style="width: 9%;margin-left: 30px;">物业邮编:</label> <input style="width: 21%"
                                                                                                 disabled="disabled"
                                                                                                 type="text" type="text"
                                                                                                 name="houses_postcode"
                                                                                                 id="houses_postcode"
                                                                                                 value="${pd.houses_postcode}"
                                                                                                 placeholder="这里输入楼盘所在地邮编"
                                                                                                 title="邮编"
                                                                                                 class="form-control">
                            </div>

                            <div class="form-group form-inline">

                                <label style="width: 9%">服务网点:</label> <input disabled="disabled"
                                                                              style="width: 21%" type="text"
                                                                              name="sales_point"
                                                                              id="sales_point" value="${pd.sales_point}"
                                                                              placeholder="这里输入服务网点地址" title="服务网点"
                                                                              class="form-control">
                                <label style="width: 9%;margin-left: 30px;">备注:</label> <input style="width: 21%"
                                                                                               disabled="disabled"
                                                                                               type="text"
                                                                                               name="remarks"
                                                                                               id="remarks"
                                                                                               value="${pd.remarks}"
                                                                                               placeholder="这里输入备注"
                                                                                               title="备注"
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
                                <label style="width: 9%">开发商公司名称:</label> <input disabled="disabled"
                                                                                 style="width: 21%" type="text"
                                                                                 type="text"
                                                                                 name="houses_dev_name"
                                                                                 id="houses_dev_name"
                                                                                 value="${pd.customer_name}"
                                                                                 placeholder="这里输入开发商公司名称"
                                                                                 title="开发商公司名称" class="form-control">
                                <label style="width: 9%;margin-left: 30px;">开发商公司地址:</label> <input disabled="disabled"
                                                                                                    style="width: 21%"
                                                                                                    type="text"
                                                                                                    name="houses_dev_address"
                                                                                                    id="houses_dev_address"
                                                                                                    value="${pd.houses_dev_address}"
                                                                                                    placeholder="这里输入开发商公司地址"
                                                                                                    title="开发商公司地址"
                                                                                                    class="form-control">
                                <label style="width: 9%;margin-left: 30px;">开发商联系电话:</label> <input disabled="disabled"
                                                                                                    style="width: 21%"
                                                                                                    type="text"
                                                                                                    type="text"
                                                                                                    name="houses_dev_phone"
                                                                                                    id="houses_dev_phone"
                                                                                                    value="${pd.houses_dev_phone}"
                                                                                                    placeholder="这里输入开发商联系电话"
                                                                                                    title="开发商联系电话"
                                                                                                    class="form-control">

                            </div>
                            <div class="form-group form-inline">
                                <label style="width: 9%">开发商公司邮箱:</label> <input disabled="disabled"
                                                                                 style="width: 21%" type="text"
                                                                                 name="houses_dev_email"
                                                                                 id="houses_dev_email"
                                                                                 value="${pd.houses_dev_email}"
                                                                                 placeholder="这里输入开发商公司邮箱"
                                                                                 title="开发商公司邮箱" class="form-control">
                                <label style="width: 9%;margin-left: 30px;">开发商公司传真:</label> <input disabled="disabled"
                                                                                                    style="width: 21%"
                                                                                                    type="text"
                                                                                                    type="text"
                                                                                                    name="houses_dev_faxes"
                                                                                                    id="houses_dev_faxes"
                                                                                                    value="${pd.houses_dev_faxes}"
                                                                                                    placeholder="这里输入开发商公司传真"
                                                                                                    title="开发商公司传真"
                                                                                                    class="form-control">
                                <label style="width: 9%;margin-left: 30px;">开发商联系人:</label> <input disabled="disabled"
                                                                                                   style="width: 21%"
                                                                                                   type="text"
                                                                                                   name="houses_dev_contacts"
                                                                                                   id="houses_dev_contacts"
                                                                                                   value="${pd.houses_dev_contacts}"
                                                                                                   placeholder="这里输入开发商联系人"
                                                                                                   title="开发商联系人"
                                                                                                   class="form-control">
                            </div>
                            <div class="form-group form-inline">
                                <label style="width: 9%">开发商联系人电话:</label> <input disabled="disabled"
                                                                                  style="width: 21%" type="text"
                                                                                  type="text"
                                                                                  name="houses_dev_con_phone"
                                                                                  id="houses_dev_con_phone"
                                                                                  value="${pd.houses_dev_con_phone}"
                                                                                  placeholder="这里输入开发商联系人电话"
                                                                                  title="开发商联系电话" class="form-control">
                            </div>
                        </div>
                    </div>

                </div>
                <tr>
                    <td><a class="btn btn-danger"
                           style="width: 150px; height: 34px; float: right;"
                           onclick="javascript:CloseSUWin('EditShops');">关闭</a></td>
                </tr>
            </div>
        </div>
    </div>
</form>
</body>
<script type="text/javascript"
        src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
        src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
        src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript">
    //查看时加载楼盘交付信息
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

    //查看时加载楼盘效果图信息
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

    //实现多个供应商
    var i = 0;

    function addDelivery() {
        i = i + 1;
        $("#delivery").append(
            '<div id="delivery' + i + '" class="form-group form-inline">' +
            '<span style="color: red;">*</span>' +
            ' <label style="width: 9%;">楼盘交房日期:</label> ' +
            '<input style="width: 21%" type="text" id="delivery_time" name="delivery_time" disabled="disabled"' +
            ' readonly="readonly" value="${pd.delivery_time}" onclick="laydate()" class="form-control">' +
            '<label style="width: 9%;margin-left:33px;">楼盘交房备注:</label> ' +
            '<input style="width: 21%" type="text" id="delivery_remark" name="delivery_remark" disabled="disabled"' +
            'value="${pd.delivery_remark}" class="form-control">' +
            '<button style="margin-left:6px;margin-top:4px;" class="btn  btn-danger btn-sm" title="删除" disabled="disabled" type="button"onclick="delDelivery(' + i + ');">减</button>' +
            '</div>'
        );
    }

    //实现多个楼盘效果图
    var j = 0;

    function addHousesImg() {
        j = j + 1;
        $("#housesT").append('<div id="housesT' + j + '" class="form-group form-inline">' +
            '<label style="width:9%;">楼盘效果图附件:</label>' +
            '<input class="form-control" type="hidden" name="house_type_img"' +
            ' placeholder="这里输入安装队保险"' +
            'value="" title="安装队保险" />' +
            '<input style="width: 21%" class="form-control" type="file" disabled="disabled"' +
            'name="houseimg" id="houseimg" placeholder="这里输入安装队保险"' +
            'title="安装队保险" onchange="upload(this)" />' +
            '<button style="margin-left:6px;margin-top:4px;" class="btn  btn-danger btn-sm" disabled="disabled"' +
            'title="删除" type="button"onclick="delHouses(' + j + ');">减</button>' +
            '<button style="margin-left:6px;margin-top:3px;" class="btn btn-sm btn-info btn-sm"' +
            '	title="查看" type="button" onclick="imgChack(this);">查看</button>' +
            '<c:if test="${pd ne null and pd.house_type_img ne null and pd.house_type_img ne '' }">' +
            '  <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>' +
            '</c:if>' +
            '</div>'
        );
    }
</script>
</html>
