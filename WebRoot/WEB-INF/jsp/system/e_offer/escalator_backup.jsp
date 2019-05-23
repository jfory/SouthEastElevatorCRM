<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

<head>

<base href="<%=basePath%>">


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>${pd.SYSNAME}</title>
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
    <style type="text/css">
        .ztree li span.button.add {
            margin-left: 2px;
            margin-right: -1px;
            background-position: -144px 0;
            vertical-align: top;
            *vertical-align: middle
        }
    </style>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp"%> 
    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
    <script type="text/javascript">

    </script>
</head>

<body class="gray-bg">
    <form action="e_offer/${msg}.do" name="escalatorForm" id="escalatorForm" method="post">
    <input type="hidden" id="rowIndex" name="rowIndex" value="${basePd.rowIndex}">
    <input type="hidden" id="elev_ids" name="elev_ids" value="${basePd.elev_ids}">
    <input type="hidden" id="models_id" name="models_id" value="${basePd.models_id}">
    <input type="hidden" id="floor" name="floor">
    <input type="hidden" id="eqpt_price" name="eqpt_price">
    <input type="hidden" id="disc_price" name="disc_price">
    <!-- <input type="hidden" id="install_price" name="install_price">
    <input type="hidden" id="trans_price" name="trans_price"> -->
    <input type="hidden" id="last_offer" name="last_offer">
    <input type="hidden" id="elevator_id" name="elevator_id">
    <div class="wrapper wrapper-content" style="z-index: -1">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        报价信息
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>型号(倾斜角度):</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="esca_angle" name="esca_angle">
                                                <option value="1" ${stdPd.escalator_model_id eq 1 ? "selected":"" }>30°</option>
                                                <option value="2" ${stdPd.escalator_model_id eq 2 ? "selected":"" }>35°</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>规格:</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="esca_spec" name="esca_spec">
                                                <option value="1" ${stdPd.escalator_standard_id eq 1 ? "selected":"" }>3.0</option>
                                                <option value="2" ${stdPd.escalator_standard_id eq 2 ? "selected":"" }>3.1</option>
                                                <option value="3" ${stdPd.escalator_standard_id eq 3 ? "selected":"" }>3.2</option>
                                                <option value="4" ${stdPd.escalator_standard_id eq 4 ? "selected":"" }>3.3</option>
                                                <option value="5" ${stdPd.escalator_standard_id eq 5 ? "selected":"" }>3.4</option>
                                                <option value="6" ${stdPd.escalator_standard_id eq 6 ? "selected":"" }>3.5</option>
                                                <option value="7" ${stdPd.escalator_standard_id eq 7 ? "selected":"" }>3.6</option>
                                                <option value="8" ${stdPd.escalator_standard_id eq 8 ? "selected":"" }>3.7</option>
                                                <option value="9" ${stdPd.escalator_standard_id eq 9 ? "selected":"" }>3.8</option>
                                                <option value="10" ${stdPd.escalator_standard_id eq 10 ? "selected":"" }>3.9</option>
                                                
                                                <option value="11" ${stdPd.escalator_standard_id eq 11 ? "selected":"" }>4.0</option>
                                                <option value="12" ${stdPd.escalator_standard_id eq 12 ? "selected":"" }>4.1</option>
                                                <option value="13" ${stdPd.escalator_standard_id eq 13 ? "selected":"" }>4.2</option>
                                                <option value="14" ${stdPd.escalator_standard_id eq 14 ? "selected":"" }>4.3</option>
                                                <option value="15" ${stdPd.escalator_standard_id eq 15 ? "selected":"" }>4.4</option>
                                                <option value="16" ${stdPd.escalator_standard_id eq 16 ? "selected":"" }>4.5</option>
                                                <option value="17" ${stdPd.escalator_standard_id eq 17 ? "selected":"" }>4.6</option>
                                                <option value="18" ${stdPd.escalator_standard_id eq 18 ? "selected":"" }>4.7</option>
                                                <option value="19" ${stdPd.escalator_standard_id eq 19 ? "selected":"" }>4.8</option>
                                                <option value="20" ${stdPd.escalator_standard_id eq 20 ? "selected":"" }>4.9</option>
                                                
                                                <option value="21" ${stdPd.escalator_standard_id eq 21 ? "selected":"" }>5.0</option>
                                                <option value="22" ${stdPd.escalator_standard_id eq 22 ? "selected":"" }>5.1</option>
                                                <option value="23" ${stdPd.escalator_standard_id eq 23 ? "selected":"" }>5.2</option>
                                                <option value="24" ${stdPd.escalator_standard_id eq 24 ? "selected":"" }>5.3</option>
                                                <option value="25" ${stdPd.escalator_standard_id eq 25 ? "selected":"" }>5.4</option>
                                                <option value="26" ${stdPd.escalator_standard_id eq 26 ? "selected":"" }>5.5</option>
                                                <option value="27" ${stdPd.escalator_standard_id eq 27 ? "selected":"" }>5.6</option>
                                                <option value="28" ${stdPd.escalator_standard_id eq 28 ? "selected":"" }>5.7</option>
                                                <option value="29" ${stdPd.escalator_standard_id eq 29 ? "selected":"" }>5.8</option>
                                                <option value="30" ${stdPd.escalator_standard_id eq 30 ? "selected":"" }>5.9</option>
                                                
                                                <option value="31" ${stdPd.escalator_standard_id eq 31 ? "selected":"" }>6.0</option>
                                                <option value="32" ${stdPd.escalator_standard_id eq 32 ? "selected":"" }>6.1</option>
                                                <option value="33" ${stdPd.escalator_standard_id eq 33 ? "selected":"" }>6.2</option>
                                                <option value="34" ${stdPd.escalator_standard_id eq 34 ? "selected":"" }>6.3</option>
                                                <option value="35" ${stdPd.escalator_standard_id eq 35 ? "selected":"" }>6.4</option>
                                                <option value="36" ${stdPd.escalator_standard_id eq 36 ? "selected":"" }>6.5</option>
                                                <option value="37" ${stdPd.escalator_standard_id eq 37 ? "selected":"" }>6.6</option>
                                                <option value="38" ${stdPd.escalator_standard_id eq 38 ? "selected":"" }>6.7</option>
                                                <option value="39" ${stdPd.escalator_standard_id eq 39 ? "selected":"" }>6.8</option>
                                                <option value="40" ${stdPd.escalator_standard_id eq 40 ? "selected":"" }>6.9</option>
                                                
                                                <option value="41" ${stdPd.escalator_standard_id eq 41 ? "selected":"" }>7.0</option>
                                                <option value="42" ${stdPd.escalator_standard_id eq 42 ? "selected":"" }>7.1</option>
                                                <option value="43" ${stdPd.escalator_standard_id eq 43 ? "selected":"" }>7.2</option>
                                                <option value="44" ${stdPd.escalator_standard_id eq 44 ? "selected":"" }>7.3</option>
                                                <option value="45" ${stdPd.escalator_standard_id eq 45 ? "selected":"" }>7.4</option>
                                                <option value="46" ${stdPd.escalator_standard_id eq 46 ? "selected":"" }>7.5</option>
                                            </select>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px">宽度(mm):</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="esca_width" name="esca_width">
                                                <option value="1" ${stdPd.escalator_width_id eq 1 ? "selected":"" }>1000MM</option>
                                                <option value="2" ${stdPd.escalator_width_id eq 2 ? "selected":"" }>800MM</option>
                                                <option value="3" ${stdPd.escalator_width_id eq 3 ? "selected":"" }>600MM</option>
                                            </select>
                                        </div>
                                        <div class="form-group form-inline">
                                            <label style="width:5%;margin-top: 25px;margin-bottom: 10px">数量:</label>
                                            <label style="width:20%;"><input type="text" class="form-control m-b" id="esca_num" name="esca_num" value="${basePd.offer_num}"></label>

                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px">折扣申请:</label>
                                            <select  class="form-control m-b" onchange="setDiscount();" id="discount" name="discount">
                                                <option value="1">请选择折扣</option>
                                                <option value="0.9">90%</option>
                                            </select>
                                        </div>
                                        <div class="form-group form-inline">
                                            <table class="table table-striped table-bordered table-hover" id="tab" name="tab">
                                                <tr bgcolor="#CCCCCC">
                                                    <th>产品名称</th>
                                                    <th>数量</th>
                                                    <th>层/站</th>
                                                    <th>装潢价</th>
                                                    <th>设备价</th>
                                                    <th>折扣</th>
                                                    <th>折后设备价</th>
                                                    <th>安装费</th>
                                                    <th>运输费</th>
                                                    <th>实际报价</th>
                                                </tr>
                                                <tr>
                                                    <td>${basePd.name}</td>
                                                    <td>${basePd.offer_num}</td>
                                                    <td><font color="red">10/10</font></td>
                                                    <td><font color="red">--</font></td>
                                                    <td>${basePd.countBasePrice}</td>
                                                    <td><font color="red">--</font></td>
                                                    <td><font color="red">--</font></td>
                                                    <td><font color="red">--</font></td>
                                                    <td><font color="red">--</font></td>
                                                    <td>${basePd.countBasePrice}</td>
                                                </tr>
                                            </table>
                                        </div>

                                        <div class="form-group form-inline">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#tab-1">基本参数</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-2">部件参数</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-3">标准功能</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-4">选配功能</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-5">半室外/室外环境配置参数</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div id="tab-1" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computeBase(this)">
                                                    <table cellspacing="0" style="width: 100%">
                                                        <!-- <tr>
                                                            <td style="font-weight:bold;width: 25%"><input type="checkbox" class="i-checks">倾斜角度</td>
                                                            <td style="width: 20%">
                                                                <select>
                                                                    <option>30°</option>
                                                                    <option>35°</option>
                                                                </select>
                                                            </td>
                                                            <td style="font-weight:bold;width: 15%">加价(元):</td>
                                                            <td style="font-weight:bold;width: 20%">备注:</td>
                                                            <td style="font-weight:bold;width: 20%">交货期:</td>
                                                        </tr> -->
                                                        <!-- <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">梯级宽度(A)/水平梯级</td>
                                                            <td>
                                                                <select>
                                                                    <option>1000</option>
                                                                    <option>800</option>
                                                                    <option>600</option>
                                                                </select>mm / 
                                                                <select>
                                                                    <option>2</option>
                                                                    <option>3</option>
                                                                </select>个
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr> -->
                                                        <tr>
                                                            <td style="font-weight:bold;width: 25%"><input type="checkbox" class="i-checks">水平梯级</td>
                                                            <td style="width: 20%">
                                                                <select id="BASE_SPTJ" name="BASE_SPTJ" onchange="setPrice('BASE_SPTJ')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="2">2</option>
                                                                    <option value="3">3</option>
                                                                </select>个
                                                                <input type="hidden" name="BASE_SPEJ_P" id="BASE_SPTJ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold;width: 15%">加价(元):</td>
                                                            <td style="font-weight:bold;width: 20%">备注:</td>
                                                            <td style="font-weight:bold;width: 20%">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">提升高度(H)</td>
                                                            <td>
                                                                <input type="text" id="BASE_TSGD" name="BASE_TSGD" onkeyup="setPrice('BASE_TSGD')" />mm
                                                                <input type="hidden" id="BASE_TSGD_P" name="BASE_TSGD_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">水平跨距(DBE)</td>
                                                            <td>
                                                                <input type="text" id="BASE_SPKJ" name="BASE_SPKJ" onkeyup="setPrice('BASE_SPKJ')">mm
                                                                <input type="hidden" id="BASE_SPKJ_P" name="BASE_SPKJ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">运行速度</td>
                                                            <td>
                                                                <select id="BASE_YXSD" name="BASE_YXSD" onchange="setPrice('BASE_YXSD')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="0.5">0.5</option>
                                                                    <option value="1">1</option>
                                                                </select>m/s
                                                                <input type="hidden" name="BASE_YXSD_P" id="BASE_YXSD_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">电源-三相电压</td>
                                                            <td>
                                                                <select id="BASE_SXDY" name="BASE_SXDY" onchange="setPrice('BASE_SXDY')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="380/5%V">380/5%V</option>
                                                                    <option value="400/5%V">400/5%V</option>
                                                                </select>
                                                                <input type="hidden" id="BASE_SXDY_P" name="BASE_SXDY_P" value="0"/>
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">电源-照明电压</td>
                                                            <td>
                                                                <select id="BASE_ZMDY" name="BASE_ZMDY" onchange="setPrice('BASE_ZMDY')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="220/10%">220/10%</option>
                                                                    <option value="230/10%">230/10%</option>
                                                                </select>
                                                                <input type="hidden" id="BASE_ZMDY_P" name="BASE_ZMDY_P" value="0"/>
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">电源-频率</td>
                                                            <td>
                                                                <select id="BASE_PL" name="BASE_PL" onchange="setPrice('BASE_PL')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="50/2%Hz">50/2%Hz</option>
                                                                    <option value="100/2%Hz">100/2%Hz</option>
                                                                </select>
                                                                <input type="hidden" id="BASE_PL_P" name="BASE_PL_P" value="0"/>
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">安装环境</td>
                                                            <td>
                                                                <select id="BASE_AZHJ" name="BASE_AZHJ" onchange="setPrice('BASE_AZHJ')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="室内">室内</option>
                                                                    <option value="半室外配置A">半室外配置A</option>
                                                                    <option value="半室外配置B">半室外配置B</option>
                                                                    <option value="全室外配置C">全室外配置C</option>
                                                                    <option value="全室外配置D">全室外配置D</option>
                                                                </select>
                                                                <input type="hidden" name="BASE_AZHJ_P" id="BASE_AZHJ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">扶手类型</td>
                                                            <td>
                                                                <select id="BASE_FSLX" name="BASE_FSLX" onchange="setPrice('BASE_FSLX')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="苗条型玻璃扶手">苗条型玻璃扶手</option>
                                                                    <option value="苗条型玻璃扶手2">肥胖型玻璃扶手</option>
                                                                </select>
                                                                <input type="hidden" id="BASE_FSLX_P" name="BASE_FSLX_P" value="0"/>
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">扶手高度</td>
                                                            <td>
                                                                <select id="BASE_FSGD" name="BASE_FSGD" onchange="setPrice('BASE_FSGD')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="900">900</option>
                                                                    <option value="1000">1000</option>
                                                                </select>mm
                                                                <input type="hidden" id="BASE_FSGD_P" name="BASE_FSGD_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">中间支撑数量</td>
                                                            <td>
                                                                <select id="BASE_ZJZCSL" name="BASE_ZJZCSL" onchange="setPrice('BASE_ZJZCSL')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="无">无</option>
                                                                    <option value="1个">1个</option>
                                                                    <option value="2个">2个</option>
                                                                    <option value="3个">3个</option>
                                                                </select>
                                                                <input type="hidden" name="BASE_ZJZCSL_P" id="BASE_ZJZCSL_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">布置形式</td>
                                                            <td>
                                                                <select id="BASE_BZXS" name="BASE_BZXS" onchange="setPrice('BASE_BZXS')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="单梯">单梯</option>
                                                                    <option value="交叉">交叉</option>
                                                                    <option value="连续">连续</option>
                                                                    <option value="平行">平行</option>
                                                                    <option value="根据土建图">根据土建图</option>
                                                                </select>
                                                                <input type="hidden" name="BASE_BZXS_P" id="BASE_BZXS_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">运输方式</td>
                                                            <td>
                                                                <select id="BASE_YSFS" name="BASE_YSFS" onchange="setPrice('BASE_YSFS')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="飞机">飞机</option>
                                                                    <option value="卡车">卡车</option>
                                                                </select>
                                                                <input type="hidden" id="BASE_YSFS_P" name="BASE_YSFS_P" value="0"/>
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">交货形态(分段数)</td>
                                                            <td>
                                                                <select id="BASE_JHXT" name="BASE_JHXT" onchange="setPrice('BASE_JHXT')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="整梯">整梯</option>
                                                                    <option value="分2段">分2段</option>
                                                                    <option value="分3段">分3段</option>
                                                                </select>
                                                                <input type="hidden" id="BASE_JHXT_P" name="BASE_JHXT_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">土建尺寸-上端加长(0~1000mm)</td>
                                                            <td>
                                                                <input type="text" id="BASE_TJSDJC" name="BASE_TJSDJC" onkeyup="setPrice('BASE_TJSDJC')">mm
                                                                <input type="hidden" name="BASE_TJSDJC_P" id="BASE_TJSDJC_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold;"><input type="checkbox" class="i-checks">土建尺寸-下端加长(0~1000mm)</td>
                                                            <td>
                                                                <input type="text" id="BASE_TJXDJC" name="BASE_TJXDJC" onkeyup="setPrice('BASE_TJXDJC')">mm
                                                                <input type="hidden" name="BASE_TJXDJC_P" id="BASE_TJXDJC_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="tab-2" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computePart(this)">
                                                    <table cellspacing="0" style="width: 100%">
                                                        <tr>
                                                            <td style="width: 20%;font-weight:bold"><input type="checkbox">减速机</td>
                                                            <td style="width: 20%">
                                                                <select name="PART_JSJ" id="PART_JSJ" onchange="setPrice('PART_JSJ')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="涡轮蜗杆">涡轮蜗杆</option>
                                                                    <option value="涡轮蜗杆1">涡轮蜗杆1</option>
                                                                </select>
                                                                <input type="hidden" id="PART_JSJ_P" name="PART_JSJ_P" value="0"/>
                                                            </td>
                                                            <td style="width: 20%;font-weight:bold">加价(元):</td>
                                                            <td style="width: 20%;font-weight:bold">备注:</td>
                                                            <td style="width: 20%;font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold"><input type="checkbox">梯级-梯级类型</td>
                                                            <td>
                                                                <select id="PART_TJLX" name="PART_TJLX" onchange="setPrice('PART_TJLX')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="铝合金梯级">铝合金梯级</option>
                                                                    <option value="铝合金梯级">不锈钢梯级</option>
                                                                </select>
                                                                <input type="hidden" name="PART_TJLX_P" id="PART_TJLX_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold"><input type="checkbox">梯级-颜色</td>
                                                            <td>
                                                                <select id="PART_TJYS" name="PART_TJYS" onchange="setPrice('PART_TJYS')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="自然色">自然色</option>
                                                                    <option value="银灰色">银灰色</option>
                                                                    <option value="黑色">黑色</option>
                                                                </select>
                                                                <input type="hidden" name="PART_TJYS_P" id="PART_TJYS_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold"><input type="checkbox">梯级-梯级中分线</td>
                                                            <td>
                                                                <input type="checkbox" id="PART_TJZFX" name="PART_TJZFX" onclick="setPriceCheck('PART_TJZFX')" value="1">
                                                                <input type="hidden" id="PART_TJZFX_P" name="PART_TJZFX_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold"><input type="checkbox">梯级-梯级边框材质</td>
                                                            <td>
                                                                <select id="PART_TJBKCZ" name="PART_TJBKCZ" onchange="setPrice('PART_TJBKCZ')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="铝合金梯级">三遍黄色喷漆警戒线-铝合金梯级</option>
                                                                    <option value="不锈钢梯级">三遍黄色塑料边框-不锈钢梯级</option>
                                                                </select>
                                                                <input type="hidden" name="PART_TJBKCZ_P" id="PART_TJBKCZ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold"><input type="checkbox">扶手导轨材质</td>
                                                            <td>
                                                                <select id="PART_FSDGCZ" name="PART_FSDGCZ" onchange="setPrice('PART_FSDGCZ')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="发纹不锈钢">发纹不锈钢</option>
                                                                    <option value="发纹不锈钢SUS304">发纹不锈钢SUS304</option>
                                                                </select>
                                                                <input type="hidden" name="PART_FSDGCZ_P" id="PART_FSDGCZ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold"><input type="checkbox">扶手带规格</td>
                                                            <td>
                                                                <select id="PART_FSDGG" name="PART_FSDGG" onchange="setPrice('PART_FSDGG')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="国内品牌">国内品牌</option>
                                                                    <option value="外资品牌">外资品牌</option>
                                                                </select>
                                                                <input type="hidden" name="PART_FSDGG_P" id="PART_FSDGG_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold"><input type="checkbox">扶手带颜色</td>
                                                            <td>
                                                                <select id="PART_FSDYS" name="PART_FSDYS" onchange="setPrice('PART_FSDYS')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="黑色">黑色</option>
                                                                    <option value="其他">其他</option>
                                                                </select>
                                                                <input type="hidden" name="PART_FSDYS_P" id="PART_FSDYS_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold"><input type="checkbox">围裙板材质</td>
                                                            <td>
                                                                <select id="PART_WQBCZ" name="PART_WQBCZ" onchange="setPrice('PART_WQBCZ')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="发纹不锈钢">发纹不锈钢</option>
                                                                    <option value="发纹不锈钢SUS304">发纹不锈钢SUS304</option>
                                                                </select>
                                                                <input type="hidden" name="PART_WQBCZ_P" id="PART_WQBCZ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold"><input type="checkbox">内外盖板材质</td>
                                                            <td>
                                                                <select id="PART_NWGBCZ" name="PART_NWGBCZ" onchange="setPrice('PART_NWGBCZ')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="发纹不锈钢">发纹不锈钢</option>
                                                                    <option value="发纹不锈钢SUS304">发纹不锈钢SUS304</option>
                                                                </select>
                                                                <input type="hidden" name="PART_NWGBCZ_P" id="PART_NWGBCZ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold"><input type="checkbox">梳齿踏板及活动盖板</td>
                                                            <td>
                                                                <select id="PART_SCTBJHDGB" name="PART_SCTBJHDGB" onchange="setPrice('PART_SCTBJHDGB')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="方形花纹">压纹不锈钢,方形花纹</option>
                                                                    <option value="矩形花纹">压纹不锈钢,矩形花纹</option>
                                                                    <option value="防滑条纹">铝合金防滑条纹</option>
                                                                </select>
                                                                <input type="hidden" name="PART_SCTBJHDGB_P" id="PART_SCTBJHDGB_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold"><input type="checkbox">梳齿板</td>
                                                            <td>
                                                                <select id="PART_SCB" name="PART_SCB" onchange="setPrice('PART_SCB')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="PVC黄色">PVC黄色</option>
                                                                    <option value="铝合金自然色">铝合金自然色</option>
                                                                    <option value="铝合金黄色">铝合金黄色</option>
                                                                </select>
                                                                <input type="hidden" name="PART_SCB_P" id="PART_SCB_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold"><input type="checkbox">启动方式</td>
                                                            <td>
                                                                <select id="PART_QDFS" name="PART_QDFS" onchange="setPrice('PART_QDFS')">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="慢节能运行">变频,快 慢节能运行</option>
                                                                    <option value="停节能运行">变频,快 慢 停节能运行</option>
                                                                    <option value="正常运行">Y-△,正常运行</option>
                                                                </select>
                                                                <input type="hidden" name="PART_QDFS_P" id="PART_QDFS_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="tab-3" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computeStd(this)">
                                                    <table cellspacing="0" style="width: 100%">
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_JTAN" name="STD_JTAN" onclick="setPriceCheck('STD_JTAN')" value="1"><font style="font-weight:bold">急停按钮</font>
                                                                <input type="hidden" name="STD_JTAN_P" id="STD_JTAN_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_YSKG" name="STD_YSKG" onclick="setPriceCheck('STD_YSKG')" value="1"><font style="font-weight:bold">钥匙开关</font>
                                                                <input type="hidden" name="STD_YSKG_P" id="STD_YSKG_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_FSJCKBHKG" name="STD_FSJCKBHKG" onclick="setPriceCheck('STD_FSJCKBHKG')" value="1"><font style="font-weight:bold">扶手进出口保护开关</font>
                                                                <input type="hidden" name="STD_FSJCKBHKG_P" id="STD_FSJCKBHKG_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_TJLDLBHKG" name="STD_TJLDLBHKG" onclick="setPriceCheck('STD_TJLDLBHKG')" value="1"><font style="font-weight:bold">梯级链断链保护开关</font>
                                                                <input type="hidden" name="STD_TJLDLBHKG_P" id="STD_TJLDLBHKG_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_TJXXBH" name="STD_TJXXBH" onclick="setPriceCheck('STD_TJXXBH')" value="1"><font style="font-weight:bold">梯级下陷保护</font>
                                                                <input type="hidden" name="STD_TJXXBH_P" id="STD_TJXXBH_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_QXJCXBH" name="STD_QXJCXBH" onclick="setPriceCheck('STD_QXJCXBH')" value="1"><font style="font-weight:bold">缺相及错相保护</font>
                                                                <input type="hidden" name="STD_QXJCXBH_P" id="STD_QXJCXBH_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_DJHZBH" name="STD_DJHZBH" onclick="setPriceCheck('STD_DJHZBH')" value="1"><font style="font-weight:bold">电机护罩保护</font>
                                                                <input type="hidden" name="STD_DJHZBH_P" id="STD_DJHZBH_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_JFHB" name="STD_JFHB" onclick="setPriceCheck('STD_JFHB')" value="1"><font style="font-weight:bold">机房护板</font>
                                                                <input type="hidden" name="STD_JFHB_P" id="STD_JFHB_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_DJGZBH" name="STD_DJGZBH" onclick="setPriceCheck('STD_DJGZBH')" value="1"><font style="font-weight:bold">电机过载保护</font>
                                                                <input type="hidden" name="STD_DJGZBH_P" id="STD_DJGZBH_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_DJGRBH" name="STD_DJGRBH" onclick="setPriceCheck('STD_DJGRBH')" value="1"><font style="font-weight:bold">电机过热保护</font>
                                                                <input type="hidden" name="STD_DJGRBH_P" id="STD_DJGRBH_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_SCBHKG" name="STD_SCBHKG" onclick="setPriceCheck('STD_SCBHKG')" value="1"><font style="font-weight:bold">梳齿保护开关</font>
                                                                <input type="hidden" name="STD_SCBHKG_P" id="STD_SCBHKG_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_WXSDZZ" name="STD_WXSDZZ" onclick="setPriceCheck('STD_WXSDZZ')" value="1"><font style="font-weight:bold">维修锁定装置</font>
                                                                <input type="hidden" name="STD_WXSDZZ_P" id="STD_WXSDZZ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_QDJL" name="STD_QDJL" onclick="setPriceCheck('STD_QDJL')" value="1"><font style="font-weight:bold">启动警铃</font>
                                                                <input type="hidden" name="STD_QDJL_P" id="STD_QDJL_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_FNZBH" name="STD_FNZBH" onclick="setPriceCheck('STD_FNZBH')" value="1"><font style="font-weight:bold">防逆转保护</font>
                                                                <input type="hidden" name="STD_FNZBH_P" id="STD_FNZBH_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_FSDFJDL" name="STD_FSDFJDL" onclick="setPriceCheck('STD_FSDFJDL')" value="1"><font style="font-weight:bold">扶手带防静电轮</font>
                                                                <input type="hidden" name="STD_FSDFJDL_P" id="STD_FSDFJDL_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_GZZDQJKKG" name="STD_GZZDQJKKG" onclick="setPriceCheck('STD_GZZDQJKKG')" value="1"><font style="font-weight:bold">工作制动器监控开关</font>
                                                                <input type="hidden" name="STD_GZZDQJKKG_P" id="STD_GZZDQJKKG_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_TJFJDS" name="STD_TJFJDS" onclick="setPriceCheck('STD_TJFJDS')" value="1"><font style="font-weight:bold">梯级防静电刷</font>
                                                                <input type="hidden" name="STD_TJFJDS_P" id="STD_TJFJDS_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_QDLDLBH" name="STD_QDLDLBH" onclick="setPriceCheck('STD_QDLDLBH')" value="1"><font style="font-weight:bold">驱动链断链保护</font>
                                                                <input type="hidden" name="STD_QDLDLBH_P" id="STD_QDLDLBH_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_SDJXCZ" name="STD_SDJXCZ" onclick="setPriceCheck('STD_SDJXCZ')" value="1"><font style="font-weight:bold">手动检修插座</font>
                                                                <input type="hidden" name="STD_SDJXCZ_P" id="STD_SDJXCZ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_SDPCZZ" name="STD_SDPCZZ" onclick="setPriceCheck('STD_SDPCZZ')" value="1"><font style="font-weight:bold">手动盘车装置</font>
                                                                <input type="hidden" name="STD_SDPCZZ_P" id="STD_SDPCZZ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_GBJXKG" name="STD_GBJXKG" onclick="setPriceCheck('STD_GBJXKG')" value="1"><font style="font-weight:bold">盖板检修开关</font>
                                                                <input type="hidden" name="STD_GBJXKG_P" id="STD_GBJXKG_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_WQMS" name="STD_WQMS" onclick="setPriceCheck('STD_WQMS')" value="1"><font style="font-weight:bold">围裙毛刷</font>
                                                                <input type="hidden" name="STD_WQMS_P" id="STD_WQMS_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_FSDSDJK" name="STD_FSDSDJK" onclick="setPriceCheck('STD_FSDSDJK')" value="1"><font style="font-weight:bold">扶手带速度监控</font>
                                                                <input type="hidden" name="STD_FSDSDJK_P" id="STD_FSDSDJK_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_TJYSBH" name="STD_TJYSBH" onclick="setPriceCheck('STD_TJYSBH')" value="1"><font style="font-weight:bold">梯级遗失保护</font>
                                                                <input type="hidden" name="STD_TJYSBH_P" id="STD_TJYSBH_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold" style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold" style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold" style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_TJCSBH" name="STD_TJCSBH" onclick="setPriceCheck('STD_TJCSBH')" value="1"><font style="font-weight:bold">梯级超速保护</font>
                                                                <input type="hidden" name="STD_TJCSBH_P" id="STD_TJCSBH_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold" style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold" style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold" style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_ZDJLCXBJ" name="STD_ZDJLCXBJ" onclick="setPriceCheck('STD_ZDJLCXBJ')" value="1"><font style="font-weight:bold">制动距离超限报警</font>
                                                                <input type="hidden" name="STD_ZDJLCXBJ_P" id="STD_ZDJLCXBJ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_GZXS" name="STD_GZXS" onclick="setPriceCheck('STD_GZXS')" value="1"><font style="font-weight:bold">故障显示</font>
                                                                <input type="hidden" name="STD_GZXS_P" id="STD_GZXS_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_TJJXZM" name="STD_TJJXZM" onclick="setPriceCheck('STD_TJJXZM')" value="1"><font style="font-weight:bold">梯级间隙照明</font>
                                                                <input type="hidden" name="STD_TJJXZM_P" id="STD_TJJXZM_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_SXJFTB" name="STD_SXJFTB" onclick="setPriceCheck('STD_SXJFTB')" value="1"><font style="font-weight:bold">上下机房踏板</font>
                                                                <input type="hidden" name="STD_SXJFTB_P" id="STD_SXJFTB_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_FJZDQ" name="STD_FJZDQ" onclick="setPriceCheck('STD_FJZDQ')" value="1"><font style="font-weight:bold">附加制动器</font>
                                                                <input type="hidden" name="STD_FJZDQ_P" id="STD_FJZDQ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_JXSB" name="STD_JXSB" onclick="setPriceCheck('STD_JXSB')" value="1"><font style="font-weight:bold">检修手柄</font>
                                                                <input type="hidden" name="STD_JXSB_P" id="STD_JXSB_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_JXXD" name="STD_JXXD" onclick="setPriceCheck('STD_JXXD')" value="1"><font style="font-weight:bold">检修行灯</font>
                                                                <input type="hidden" name="STD_JXXD_P" id="STD_JXXD_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_WQAQZZ" name="STD_WQAQZZ" onclick="setPriceCheck('STD_WQAQZZ')" value="1"><font style="font-weight:bold">围裙安全装置</font>
                                                                <input type="hidden" name="STD_WQAQZZ_P" id="STD_WQAQZZ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_FSDDDBH" name="STD_FSDDDBH" onclick="setPriceCheck('STD_FSDDDBH')" value="1"><font style="font-weight:bold">扶手带断带保护</font>
                                                                <input type="hidden" name="STD_FSDDDBH_P" id="STD_FSDDDBH_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <input type="checkbox" id="STD_DLFDLJQ" name="STD_DLFDLJQ" onclick="setPriceCheck('STD_DLFDLJQ')" value="1"><font style="font-weight:bold">电缆分段连接器</font>
                                                                <input type="hidden" name="STD_DLFDLJQ_P" id="STD_DLFDLJQ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="tab-4" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computeOpt(this)">
                                                    <table cellspacing="0" style="width: 100%">
                                                        <tr>
                                                            <td style="font-weight:bold">安全制动器</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_AQZDQ" name="OPT_AQZDQ" onclick="setPriceCheck('OPT_AQZDQ');" value="1">
                                                                <input type="hidden" name="OPT_AQZDQ_P" id="OPT_AQZDQ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">5个干触点</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_GCD" name="OPT_GCD" onclick="setPriceCheck('OPT_GCD');" value="1">
                                                                <input type="hidden" name="OPT_GCD_P" id="OPT_GCD_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">交通流向灯</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_JTLXD" name="OPT_JTLXD" onclick="setPriceCheck('OPT_JTLXD');" value="1">
                                                                <input type="hidden" name="OPT_JTLXD_P" id="OPT_JTLXD_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">制动器磨损监控</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_ZDQMSJK" name="OPT_ZDQMSJK" onclick="setPriceCheck('OPT_ZDQMSJK');" value="1">
                                                                <input type="hidden" name="OPT_ZDQMSJK_P" id="OPT_ZDQMSJK_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">自动加油</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_ZDJY" name="OPT_ZDJY" onclick="setPriceCheck('OPT_ZDJY');" value="1">
                                                                <input type="hidden" name="OPT_ZDJY_P" id="OPT_ZDJY_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">驱动链链罩</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_QDLLZ" name="OPT_QDLLZ" onclick="setPriceCheck('OPT_QDLLZ');" value="1">
                                                                <input type="hidden" name="OPT_QDLLZ_P" id="OPT_QDLLZ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">围裙照明</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_WQZM" name="OPT_WQZM" onclick="setPriceCheck('OPT_WQZM');" value="1">
                                                                <input type="hidden" name="OPT_WQZM_P" id="OPT_WQZM_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">梯级防跳保护</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_TJFTBH" name="OPT_TJFTBH" onclick="setPriceCheck('OPT_TJFTBH');" value="1">
                                                                <input type="hidden" name="OPT_TJFTBH_P" id="OPT_TJFTBH_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">扶手带断带保护装置</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_FSDDDBHZZ" name="OPT_FSDDDBHZZ" onclick="setPriceCheck('OPT_FSDDDBHZZ');" value="1">
                                                                <input type="hidden" name="OPT_FSDDDBHZZ_P" id="OPT_FSDDDBHZZ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">中段围裙间隙开关</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_ZDWQJXKG" name="OPT_ZDWQJXKG" onclick="setPriceCheck('OPT_ZDWQJXKG');" value="1">
                                                                <input type="hidden" name="OPT_ZDWQJXKG_P" id="OPT_ZDWQJXKG_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">梳齿照明</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_SCZM" name="OPT_SCZM" onclick="setPriceCheck('OPT_SCZM');" value="1">
                                                                <input type="hidden" name="OPT_SCZM_P" id="OPT_SCZM_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">油水分离器</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_YSFLQ" name="OPT_YSFLQ" onclick="setPriceCheck('OPT_YSFLQ');" value="1">
                                                                <input type="hidden" name="OPT_YSFLQ_P" id="OPT_YSFLQ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">防洪保护</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_FHBH" name="OPT_FHBH" onclick="setPriceCheck('OPT_FHBH');" value="1">
                                                                <input type="hidden" name="OPT_FHBH_P" id="OPT_FHBH_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">梯级链防护罩</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_TJLFHZ" name="OPT_TJLFHZ" onclick="setPriceCheck('OPT_TJLFHZ');" value="1">
                                                                <input type="hidden" name="OPT_TJLFHZ_P" id="OPT_TJLFHZ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">外装饰位置</td>
                                                            <td>
                                                                <select id="OPT_WZSWZ" name="OPT_WZSWZ" onchange="setPrice('OPT_WZSWZ');">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="左侧">左侧</option>
                                                                    <option value="右侧">右侧</option>
                                                                    <option value="底侧">底侧</option>
                                                                </select>
                                                                <input type="hidden" name="OPT_WZSWZ_P" id="OPT_WZSWZ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">装饰板材料</td>
                                                            <td>
                                                                <select id="OPT_ZSBCL" name="OPT_ZSBCL" onchange="setPrice('OPT_ZSBCL');">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="发纹">发纹</option>
                                                                    <option value="发纹不锈钢">发纹不锈钢</option>
                                                                    <option value="发纹不锈钢SUS304">发纹不锈钢SUS304</option>
                                                                </select>
                                                                <input type="hidden" name="OPT_ZSBCL_P" id="OPT_ZSBCL_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">装饰板厚度</td>
                                                            <td>
                                                                <select id="OPT_ZSBHD" name="OPT_ZSBHD" onchange="setPrice('OPT_ZSBHD');">
                                                                    <option value="">--请选择--</option>
                                                                    <option value="0.8">0.8</option>
                                                                    <option value="1.0">1.0</option>
                                                                    <option value="1.2">1.2</option>
                                                                </select>
                                                                <input type="hidden" name="OPT_ZSBHD_P" id="OPT_ZSBHD_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">维修护栏</td>
                                                            <td>
                                                                <input type="radio" name="OPT_WXHL_RADIO" value="1" onclick="setPriceRadio(this,'OPT_WXHL');">每台一套
                                                                <input type="radio" name="OPT_WXHL_RADIO" value="2" onclick="setPriceRadio(this,'OPT_WXHL');">每项目<input type="text" id="OPT_WXHL" name="OPT_WXHL" onkeyup="setPrice('OPT_WXHL')">套
                                                                <input type="hidden" name="OPT_WXHL_P" id="OPT_WXHL_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">吊装钢丝绳</td>
                                                            <td>
                                                                <input type="radio" name="OPT_DZGSS_RADIO" value="1" onclick="setPriceRadio(this,'OPT_DZGSS');">每台一套
                                                                <input type="radio" name="OPT_DZGSS_RADIO" value="2" onclick="setPriceRadio(this,'OPT_DZGSS');">每项目<input type="text" id="OPT_DZGSS" name="OPT_DZGSS" onkeyup="setPrice('OPT_DZGSS')">套
                                                                <input type="hidden" name="OPT_DZGSS_P" id="OPT_DZGSS_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">防爬装置</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_FPZZ" name="OPT_FPZZ" onclick="setPriceCheck('OPT_FPZZ');" value="1">
                                                                <input type="hidden" name="OPT_FPZZ_P" id="OPT_FPZZ_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">桁架加热</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_HJJR" name="OPT_HJJR" onclick="setPriceCheck('OPT_HJJR');" value="1">
                                                                <input type="hidden" name="OPT_HJJR_P" id="OPT_HJJR_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">梳齿加热</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_SCJR" name="OPT_SCJR" onclick="setPriceCheck('OPT_SCJR');" value="1">
                                                                <input type="hidden" name="OPT_SCJR_P" id="OPT_SCJR_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">扶手加热</td>
                                                            <td>
                                                                <input type="checkbox" id="OPT_FSJR" name="OPT_FSJR" onclick="setPriceCheck('OPT_FSJR');" value="1">
                                                                <input type="hidden" name="OPT_FSJR_P" id="OPT_FSJR_P" value="0">
                                                            </td>
                                                            <td style="font-weight:bold">加价(元):</td>
                                                            <td style="font-weight:bold">备注:</td>
                                                            <td style="font-weight:bold">交货期:</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="tab-5" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computeEnv(this)">
                                                    <table cellspacing="0" style="width: 100%">
                                                        <tr>
                                                            <td style="width: 26%;font-weight:bold">安装环境类型</td>
                                                            <td style="width: 8%;font-weight:bold">半室外配置A</td>
                                                            <td style="width: 8%;font-weight:bold">半室外配置B</td>
                                                            <td style="width: 8%;font-weight:bold">全室外配置C</td>
                                                            <td style="width: 8%;font-weight:bold">全室外配置D</td>
                                                            <td style="width: 50%">
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">自动加油</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_ZDJY_BOX" value="半室外配置A" onclick="setPriceBox('ENV_ZDJY');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_ZDJY_BOX" value="半室外配置B" onclick="setPriceBox('ENV_ZDJY');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_ZDJY_BOX" value="全室外配置C" onclick="setPriceBox('ENV_ZDJY');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_ZDJY_BOX" value="全室外配置D" onclick="setPriceBox('ENV_ZDJY');">
                                                            </td>
                                                                <input type="hidden" id="ENV_ZDJY_P" name="ENV_ZDJY_P" value="0">
                                                                <input type="hidden" id="ENV_ZDJY_VAL" name="ENV_ZDJY_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">IP55电机</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_DJ_BOX" value="半室外配置A" onclick="setPriceBox('ENV_DJ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_DJ_BOX" value="半室外配置B" onclick="setPriceBox('ENV_DJ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_DJ_BOX" value="全室外配置C" onclick="setPriceBox('ENV_DJ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_DJ_BOX" value="全室外配置D" onclick="setPriceBox('ENV_DJ');">
                                                            </td>
                                                                <input type="hidden" id="ENV_DJ_P" name="ENV_DJ_P" value="0">
                                                                <input type="hidden" id="ENV_DJ_VAL" name="ENV_DJ_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">IP54控制系统</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_KZXT_BOX" value="半室外配置A" onclick="setPriceBox('ENV_KZXT');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_KZXT_BOX" value="半室外配置B" onclick="setPriceBox('ENV_KZXT');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_KZXT_BOX" value="全室外配置C" onclick="setPriceBox('ENV_KZXT');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_KZXT_BOX" value="全室外配置D" onclick="setPriceBox('ENV_KZXT');">
                                                            </td>
                                                                <input type="hidden" id="ENV_KZXT_P" name="ENV_KZXT_P" value="0">
                                                                <input type="hidden" id="ENV_KZXT_VAL" name="ENV_KZXT_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">活动盖板铝基材</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_HDGBLJC_BOX" value="半室外配置A" onclick="setPriceBox('ENV_HDGBLJC');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_HDGBLJC_BOX" value="半室外配置B" onclick="setPriceBox('ENV_HDGBLJC');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_HDGBLJC_BOX" value="全室外配置C" onclick="setPriceBox('ENV_HDGBLJC');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_HDGBLJC_BOX" value="全室外配置D" onclick="setPriceBox('ENV_HDGBLJC');">
                                                            </td>
                                                                <input type="hidden" id="ENV_HDGBLJC_P" name="ENV_HDGBLJC_P" value="0">
                                                                <input type="hidden" id="ENV_HDGBLJC_VAL" name="ENV_HDGBLJC_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">室外型扶手带</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_SWXFSD_BOX" value="半室外配置A" onclick="setPriceBox('ENV_SWXFSD');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_SWXFSD_BOX" value="半室外配置B" onclick="setPriceBox('ENV_SWXFSD');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_SWXFSD_BOX" value="全室外配置C" onclick="setPriceBox('ENV_SWXFSD');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_SWXFSD_BOX" value="全室外配置D" onclick="setPriceBox('ENV_SWXFSD');">
                                                            </td>
                                                                <input type="hidden" id="ENV_SWXFSD_P" name="ENV_SWXFSD_P" value="0">
                                                                <input type="hidden" id="ENV_SWXFSD_VAL" name="ENV_SWXFSD_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">内外盖板不锈钢SUS304材质</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_NWGBBXG_BOX" value="半室外配置A" onclick="setPriceBox('ENV_NWGBBXG');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_NWGBBXG_BOX" value="半室外配置B" onclick="setPriceBox('ENV_NWGBBXG');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_NWGBBXG_BOX" value="全室外配置C" onclick="setPriceBox('ENV_NWGBBXG');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_NWGBBXG_BOX" value="全室外配置D" onclick="setPriceBox('ENV_NWGBBXG');">
                                                            </td>
                                                                <input type="hidden" id="ENV_NWGBBXG_P" name="ENV_NWGBBXG_P" value="0">
                                                                <input type="hidden" id="ENV_NWGBBXG_VAL" name="ENV_NWGBBXG_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">围裙不锈钢SUS304材质</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_WQBXG_BOX" value="半室外配置A" onclick="setPriceBox('ENV_WQBXG');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_WQBXG_BOX" value="半室外配置B" onclick="setPriceBox('ENV_WQBXG');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_WQBXG_BOX" value="全室外配置C" onclick="setPriceBox('ENV_WQBXG');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_WQBXG_BOX" value="全室外配置D" onclick="setPriceBox('ENV_WQBXG');">
                                                            </td>
                                                                <input type="hidden" id="ENV_WQBXG_P" name="ENV_WQBXG_P" value="0">
                                                                <input type="hidden" id="ENV_WQBXG_VAL" name="ENV_WQBXG_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">外装饰板不锈钢SUS304材质</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_WZSBBXG_BOX" value="半室外配置A" onclick="setPriceBox('ENV_WZSBBXG');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_WZSBBXG_BOX" value="半室外配置B" onclick="setPriceBox('ENV_WZSBBXG');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_WZSBBXG_BOX" value="全室外配置C" onclick="setPriceBox('ENV_WZSBBXG');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_WZSBBXG_BOX" value="全室外配置D" onclick="setPriceBox('ENV_WZSBBXG');">
                                                            </td>
                                                                <input type="hidden" id="ENV_WZSBBXG_P" name="ENV_WZSBBXG_P" value="0">
                                                                <input type="hidden" id="ENV_WZSBBXG_VAL" name="ENV_WZSBBXG_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">扶手导轨不锈钢SUS304材质</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FSDGBXG_BOX" value="半室外配置A" onclick="setPriceBox('ENV_FSDGBXG');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FSDGBXG_BOX" value="半室外配置B" onclick="setPriceBox('ENV_FSDGBXG');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FSDGBXG_BOX" value="全室外配置C" onclick="setPriceBox('ENV_FSDGBXG');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FSDGBXG_BOX" value="全室外配置D" onclick="setPriceBox('ENV_FSDGBXG');">
                                                            </td>
                                                                <input type="hidden" id="ENV_FSDGBXG_P" name="ENV_FSDGBXG_P" value="0">
                                                                <input type="hidden" id="ENV_FSDGBXG_VAL" name="ENV_FSDGBXG_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">金属骨架喷三遍油漆</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_JSGJPSBYQ_BOX" value="半室外配置A" onclick="setPriceBox('ENV_JSGJPSBYQ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_JSGJPSBYQ_BOX" value="半室外配置B" onclick="setPriceBox('ENV_JSGJPSBYQ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_JSGJPSBYQ_BOX" value="全室外配置C" onclick="setPriceBox('ENV_JSGJPSBYQ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_JSGJPSBYQ_BOX" value="全室外配置D" onclick="setPriceBox('ENV_JSGJPSBYQ');">
                                                            </td>
                                                                <input type="hidden" id="ENV_JSGJPSBYQ_P" name="ENV_JSGJPSBYQ_P" value="0">
                                                                <input type="hidden" id="ENV_JSGJPSBYQ_VAL" name="ENV_JSGJPSBYQ_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">金属骨架热浸镀锌</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_JSGJRJDX_BOX" value="半室外配置A" onclick="setPriceBox('ENV_JSGJRJDX');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_JSGJRJDX_BOX" value="半室外配置B" onclick="setPriceBox('ENV_JSGJRJDX');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_JSGJRJDX_BOX" value="全室外配置C" onclick="setPriceBox('ENV_JSGJRJDX');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_JSGJRJDX_BOX" value="全室外配置D" onclick="setPriceBox('ENV_JSGJRJDX');">
                                                            </td>
                                                                <input type="hidden" id="ENV_JSGJRJDX_P" name="ENV_JSGJRJDX_P" value="0">
                                                                <input type="hidden" id="ENV_JSGJRJDX_VAL" name="ENV_JSGJRJDX_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">导轨系统和主传动轴特殊防锈处理</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FXCL_BOX" value="半室外配置A" onclick="setPriceBox('ENV_FXCL');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FXCL_BOX" value="半室外配置B" onclick="setPriceBox('ENV_FXCL');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FXCL_BOX" value="全室外配置C" onclick="setPriceBox('ENV_FXCL');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FXCL_BOX" value="全室外配置D" onclick="setPriceBox('ENV_FXCL');">
                                                            </td>
                                                                <input type="hidden" id="ENV_FXCL_P" name="ENV_FXCL_P" value="0">
                                                                <input type="hidden" id="ENV_FXCL_VAL" name="ENV_FXCL_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">主要部件螺栓螺母达克罗处理</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_DKLCL_BOX" value="半室外配置A" onclick="setPriceBox('ENV_DKLCL');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_DKLCL_BOX" value="半室外配置B" onclick="setPriceBox('ENV_DKLCL');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_DKLCL_BOX" value="全室外配置C" onclick="setPriceBox('ENV_DKLCL');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_DKLCL_BOX" value="全室外配置D" onclick="setPriceBox('ENV_DKLCL');">
                                                            </td>
                                                                <input type="hidden" id="ENV_DKLCL_P" name="ENV_DKLCL_P" value="0">
                                                                <input type="hidden" id="ENV_DKLCL_VAL" name="ENV_DKLCL_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">表面特殊处理梯级轴,驱动链和梯级链链板表面<br>进行特殊防锈处理,主副轮双重密封</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_BQZ_BOX" value="半室外配置A" onclick="setPriceBox('ENV_BQZ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_BQZ_BOX" value="半室外配置B" onclick="setPriceBox('ENV_BQZ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_BQZ_BOX" value="全室外配置C" onclick="setPriceBox('ENV_BQZ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_BQZ_BOX" value="全室外配置D" onclick="setPriceBox('ENV_BQZ');">
                                                            </td>
                                                                <input type="hidden" id="ENV_BQZ_P" name="ENV_BQZ_P" value="0">
                                                                <input type="hidden" id="ENV_BQZ_VAL" name="ENV_BQZ_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">油水分离器装置</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_YSFLQZZ_BOX" value="半室外配置A" onclick="setPriceBox('ENV_YSFLQZZ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_YSFLQZZ_BOX" value="半室外配置B" onclick="setPriceBox('ENV_YSFLQZZ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_YSFLQZZ_BOX" value="全室外配置C" onclick="setPriceBox('ENV_YSFLQZZ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_YSFLQZZ_BOX" value="全室外配置D" onclick="setPriceBox('ENV_YSFLQZZ');">
                                                            </td>
                                                                <input type="hidden" id="ENV_YSFLQZZ_P" name="ENV_YSFLQZZ_P" value="0">
                                                                <input type="hidden" id="ENV_YSFLQZZ_VAL" name="ENV_YSFLQZZ_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">防洪保护</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FHBH_BOX" value="半室外配置A" onclick="setPriceBox('ENV_FHBH');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FHBH_BOX" value="半室外配置B" onclick="setPriceBox('ENV_FHBH');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FHBH_BOX" value="全室外配置C" onclick="setPriceBox('ENV_FHBH');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FHBH_BOX" value="全室外配置D" onclick="setPriceBox('ENV_FHBH');">
                                                            </td>
                                                                <input type="hidden" id="ENV_FHBH_P" name="ENV_FHBH_P" value="0">
                                                                <input type="hidden" id="ENV_FHBH_VAL" name="ENV_FHBH_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">梯级链防护罩</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_TJLFHZ_BOX" value="半室外配置A" onclick="setPriceBox('ENV_TJLFHZ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_TJLFHZ_BOX" value="半室外配置B" onclick="setPriceBox('ENV_TJLFHZ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_TJLFHZ_BOX" value="全室外配置C" onclick="setPriceBox('ENV_TJLFHZ');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_TJLFHZ_BOX" value="全室外配置D" onclick="setPriceBox('ENV_TJLFHZ');">
                                                            </td>
                                                                <input type="hidden" id="ENV_TJLFHZ_P" name="ENV_TJLFHZ_P" value="0">
                                                                <input type="hidden" id="ENV_TJLFHZ_VAL" name="ENV_TJLFHZ_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">桁架加热</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_HJJR_BOX" value="半室外配置A" onclick="setPriceBox('ENV_HJJR');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_HJJR_BOX" value="半室外配置B" onclick="setPriceBox('ENV_HJJR');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_HJJR_BOX" value="全室外配置C" onclick="setPriceBox('ENV_HJJR');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_HJJR_BOX" value="全室外配置D" onclick="setPriceBox('ENV_HJJR');">
                                                            </td>
                                                                <input type="hidden" id="ENV_HJJR_P" name="ENV_HJJR_P" value="0">
                                                                <input type="hidden" id="ENV_HJJR_VAL" name="ENV_HJJR_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">梳齿加热</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_SCJR_BOX" value="半室外配置A" onclick="setPriceBox('ENV_SCJR');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_SCJR_BOX" value="半室外配置B" onclick="setPriceBox('ENV_SCJR');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_SCJR_BOX" value="全室外配置C" onclick="setPriceBox('ENV_SCJR');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_SCJR_BOX" value="全室外配置D" onclick="setPriceBox('ENV_SCJR');">
                                                            </td>
                                                                <input type="hidden" id="ENV_SCJR_P" name="ENV_SCJR_P" value="0">
                                                                <input type="hidden" id="ENV_SCJR_VAL" name="ENV_SCJR_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-weight:bold">扶手加热</td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FSJR_BOX" value="半室外配置A" onclick="setPriceBox('ENV_FSJR');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FSJR_BOX" value="半室外配置B" onclick="setPriceBox('ENV_FSJR');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FSJR_BOX" value="全室外配置C" onclick="setPriceBox('ENV_FSJR');">
                                                            </td>
                                                            <td align="center">
                                                                <input type="checkbox" name="ENV_FSJR_BOX" value="全室外配置D" onclick="setPriceBox('ENV_FSJR');">
                                                            </td>
                                                                <input type="hidden" id="ENV_FSJR_P" name="ENV_FSJR_P" value="0">
                                                                <input type="hidden" id="ENV_FSJR_VAL" name="ENV_FSJR_VAL">
                                                            <td align="center" style="font-weight:bold">加价(元):</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        安装价格
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group form-inline">
                                            <label>安装价格:</label>
                                            <input type="text" class="form-control" id="install_price" name="install_price" onkeyup="setPriceInstall();">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        运输价格
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group form-inline">
                                            <label>运输方式:</label>
                                            <select id="trans_type" class="form-control m-b" name="trans_type" onchange="hideDiv();">
                                                <option value="1">整车</option>
                                                <option value="2">零担</option>
                                            </select>
                                        </div>
                                        <div class="form-group form-inline">
                                            <label>请选择区域:</label>
                                            <select id="province_id" name="province_id" class="form-control m-b" onchange="setCity();">
                                                <option>请选择区域</option>
                                                <c:forEach var="province" items="${provinceList}">
                                                    <option value="${province.id }">${province.name }</option>
                                                </c:forEach>
                                            </select>

                                            <label>请选择目的地:</label>
                                            <select id="destin_id" name="destin_id" class="form-control m-b">
                                                <option>请选择目的地</option>
                                            </select>
                                        </div>
                                        <div class="form-group form-inline" id="zc">
                                            <table id="transTable">
                                                <tr>
                                                    <td>
                                                        <label>车型:</label>
                                                        <select class="form-control m-b">
                                                            <option value="">请选择车型</option>
                                                            <option value="5">5T车(6.2-7.2米)</option>
                                                            <option value="8">8T车(8.2-9.6米)</option>
                                                            <option value="10">10T车(12.5米)</option>
                                                            <option value="20">20T车(17.5米)</option>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <label>数量:</label>
                                                        <input type="text" class="form-control">
                                                    </td>
                                                    <td>
                                                        <input type="button" value="添加" onclick="addRow();">
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="form-group form-inline" id="ld">
                                            吨数:<input type="text" id="less_num" name="less_num" class="form-control">
                                        </div>
                                        <div class="form-group form-inline">
                                            <input type="button" value="确定" onclick="setPriceTrans();">
                                            运输价格:
                                            <input type="text" id="trans_price" name="trans_price" class="form-control">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>   
    </div>
    </form>

    <tr>
        <td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
        <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('ElevatorParam');">关闭</a></td>
    </tr>

<script src="static/js/sweetalert/sweetalert.min.js"></script>
<script src="static/js/iCheck/icheck.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });

        //隐藏零担选项
        $("#ld").hide();
    });

    //设置安装价格(暂定)
    function setPriceInstall(){
        var discount = $("#discount").val();
        var installPrice = parseFloat($("#install_price").val());
        //判断是否已选折扣
        if(discount=="1"){//未选折扣
            //当前设备总价
            var basePrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("4").text());
            var lastOffer = basePrice+installPrice;
            $("#tab").find("tr").eq("1").find("td").eq("7").text(installPrice);
            $("#tab").find("tr").eq("1").find("td").eq("9").text(lastOffer);
        }else{
            //当前设备总价
            var dcPrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("6").text());
            var lastOffer = dcPrice+installPrice;
            $("#tab").find("tr").eq("1").find("td").eq("7").text(installPrice);
            $("#tab").find("tr").eq("1").find("td").eq("9").text(lastOffer);
        }
    }

    //隐藏DIV
    function hideDiv(){
        var trans_type = $("#trans_type").val();
        if(trans_type=="1"){
            $("#ld").hide();
            $("#zc").show();
        }else{
            $("#zc").hide();
            $("#ld").show();
        }
    }

    //计算运输价格
    function setPriceTrans(){
        var transType = $("#trans_type").val();
        var province_id = $("#province_id").val();
        var destin_id = $("#destin_id").val();
        if(transType=="1"){//整车
            var zcStr = "[";
            $("#transTable tr").each(function(){
                var carType = $(this).find("td").eq("0").find("select").eq("0").val();
                var num = $(this).find("td").eq("1").find("input").eq("0").val();
                zcStr += "{\'carType\':\'"+carType+"\',\'num\':\'"+num+"\'},"
            });
            zcStr = zcStr.substring(0,zcStr.length-1)+"]";
            $.post("<%=basePath%>e_offer/setPriceTrans",
                    {
                        "zcStr": zcStr,
                        "province_id": province_id,
                        "city_id": destin_id,
                        "transType": transType
                    },
                    function(data){
                        $("#trans_price").val(data.countPrice);
                        var discount = $("#discount").val();
                        var transPrice = parseFloat(data.countPrice);
                        //判断是否已选折扣
                        if(discount=="1"){//未选折扣
                            //当前设备总价
                            var basePrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("4").text());
                            var lastOffer = basePrice+transPrice;
                            $("#tab").find("tr").eq("1").find("td").eq("8").text(transPrice);
                            $("#tab").find("tr").eq("1").find("td").eq("9").text(lastOffer);
                        }else{
                            //当前设备总价
                            var dcPrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("6").text());
                            var lastOffer = dcPrice+transPrice;
                            $("#tab").find("tr").eq("1").find("td").eq("8").text(transPrice);
                            $("#tab").find("tr").eq("1").find("td").eq("9").text(lastOffer);
                        }
                    }
                );
        }else if(transType=="2"){//零担
            var less_num = $("#less_num").val();
            $.post("<%=basePath%>e_offer/setPriceTrans",
                    {
                        "province_id": province_id,
                        "city_id": destin_id,
                        "transType": transType,
                        "less_num": less_num
                    },
                    function(data){
                        $("#trans_price").val(data.countPrice);
                        var discount = $("#discount").val();
                        var transPrice = parseFloat(data.countPrice);
                        //判断是否已选折扣
                        if(discount=="1"){//未选折扣
                            //当前设备总价
                            var basePrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("4").text());
                            var lastOffer = basePrice+transPrice;
                            $("#tab").find("tr").eq("1").find("td").eq("8").text(transPrice);
                            $("#tab").find("tr").eq("1").find("td").eq("9").text(lastOffer);
                        }else{
                            //当前设备总价
                            var dcPrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("6").text());
                            var lastOffer = dcPrice+transPrice;
                            $("#tab").find("tr").eq("1").find("td").eq("8").text(transPrice);
                            $("#tab").find("tr").eq("1").find("td").eq("9").text(lastOffer);
                        }
                    }
                );
        }

    }

    //添加行,录入电梯信息
    function addRow(){
        var tr = $("#transTable tr").eq(0).clone();
        $(tr).find("td").eq(0).find("select").eq(0).val("");
        $(tr).find("td").eq(1).find("input").eq(0).val("");
        $(tr).find("td:last").html("").append("<td><input type='button' value='删除' onclick='delRow(this)'></td>");
        $("#transTable").append(tr);
    }
    //删除行
    function delRow(obj){
        $(obj).parent().parent().parent().remove();
    }

    //设置城市
    function setCity(){
        var province_id = $("#province_id").val();
        if(province_id==""){
            
        }else{
            $.post("<%=basePath%>e_offer/setCity",
                    {
                        "province_id":province_id
                    },
                    function(data){
                        $("#destin_id").empty();
                        $("#destin_id").append("<option value=''>请选择城市</option>");
                        $.each(data,function(key,value){
                            $("#destin_id").append("<option value='"+value.id+"'>"+value.name+"</option>");
                        });
                    }
                );
        }
    }

    //计算折扣
    function setDiscount(){
        var basePrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("4").text());
        var transPrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("8").text());
        var installPrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("7").text());
        var dc = parseFloat($("#discount").val());
        var dcPrice;
        dcPrice = basePrice*dc;
        var lastOffer = dcPrice;
        if(!isNaN(transPrice)){
            lastOffer += transPrice;
        }
        if(!isNaN(installPrice)){
            lastOffer += installPrice;
        }
        $("#tab").find("tr").eq("1").find("td").eq("5").text(dc);
        $("#tab").find("tr").eq("1").find("td").eq("6").text(dcPrice);
        $("#tab").find("tr").eq("1").find("td").eq("9").text(lastOffer);
    }


    //加载价格
    function setPrice(keyword){
        var param = $("#"+keyword).val();
        if(param!=""){
            $.post("<%=basePath%>e_offer/setPrice",
                {
                    "keyword":keyword,
                    "param":param
                },
                function(data){
                    $("#"+keyword).parent().parent().find("td").eq("2").text("加价(元):"+data.price);
                    $("#"+keyword).parent().parent().find("td").eq("3").text("备注:"+data.remark);
                    $("#"+keyword).parent().parent().find("td").eq("4").text("交货期:"+data.dlvr_date);
                    $("#"+keyword+"_P").val(data.price);
                }
            );
        }else{
            $("#"+keyword).parent().parent().find("td").eq("2").text("加价(元):");
            $("#"+keyword).parent().parent().find("td").eq("3").text("备注:");
            $("#"+keyword).parent().parent().find("td").eq("4").text("交货期:");
            $("#"+keyword+"_P").val("0");
        }
    }

    //加载价格,checkbox用
    function setPriceCheck(keyword){
        var flag = $("#"+keyword).is(":checked");
        if(flag){
            $("#"+keyword).val("1");
            $.post("<%=basePath%>e_offer/setPrice",
                {
                    "keyword":keyword
                },
                function(data){
                    $("#"+keyword).parent().parent().find("td").eq("2").text("加价(元):"+data.price);
                    $("#"+keyword).parent().parent().find("td").eq("3").text("备注:"+data.remark);
                    $("#"+keyword).parent().parent().find("td").eq("4").text("交货期:"+data.dlvr_date);
                    $("#"+keyword+"_P").val(data.price);
                }
            );
        }else{
            $("#"+keyword).val("0");
            $("#"+keyword).parent().parent().find("td").eq("2").text("加价(元):--");
            $("#"+keyword).parent().parent().find("td").eq("3").text("备注:--");
            $("#"+keyword).parent().parent().find("td").eq("4").text("交货期:--");
            $("#"+keyword+"_P").val("0");
        }
    }

    //加载价格,radio用
    function setPriceRadio(obj,keyword){
        var param = 0;
        if($(obj).val()=="1"){
            var offer_num = parseFloat($("#tab").find("tr").eq("1").find("td").eq("1").text());
            param = offer_num;
            $.post("<%=basePath%>e_offer/setPrice",
                {
                    "keyword":keyword,
                    "param":param
                },
                function(data){
                    $("#"+keyword).parent().parent().find("td").eq("2").text("加价(元):"+data.price);
                    $("#"+keyword).parent().parent().find("td").eq("3").text("备注:"+data.remark);
                    $("#"+keyword).parent().parent().find("td").eq("4").text("交货期:"+data.dlvr_date);
                    $("#"+keyword+"_P").val(data.price);
                }
            );
        }else{
            $("#"+keyword).parent().parent().find("td").eq("2").text("加价(元):--");
            $("#"+keyword).parent().parent().find("td").eq("3").text("备注:--");
            $("#"+keyword).parent().parent().find("td").eq("4").text("交货期:--");
            $("#"+keyword+"_P").val("0");
        }
    }

    //加载价格,多选checkBox用
    function setPriceBox(keyword){
        var param = "";
        $('input:checkbox[name='+keyword+'_BOX'+']:checked').each(function(){
            param = param+$(this).val()+",";
            $("#"+keyword+"_VAL").val(param);
        });
        param = param.substring(0,param.length-1);
        $.post("<%=basePath%>e_offer/setPrice",
                {
                    "keyword":keyword,
                    "param":param
                },
                function(data){
                    /*$("#"+keyword+"_P").parent().parent().find("td").eq("2").text("加价(元):"+data.price);
                    $("#"+keyword+"_P").val(data.price);*/
                    $("#"+keyword+"_P").parent().find("td").eq("5").text("加价(元):"+data.price);
                    $("#"+keyword+"_P").val(data.price);
                }
            );

    }

    //填充实际报价
    function setLastOffer(){
        //填充实际报价
        var discount = $("#discount").val();
        if(discount=="1"){//未选折扣
            //当前设备总价
            var basePrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("4").text());
            var transPrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("8").text());
            var installPrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("7").text());
            var lastOffer = basePrice;
            if(!isNaN(transPrice)){
                lastOffer += transPrice;
            }
            if(!isNaN(installPrice)){
                lastOffer += installPrice;
            }
            $("#tab").find("tr").eq("1").find("td").eq("9").text(lastOffer);
        }else{
            //当前设备总价
            var dcPrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("6").text());
            var transPrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("8").text());
            var installPrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("7").text());
            var lastOffer = dcPrice;
            if(!isNaN(transPrice)){
                lastOffer += transPrice;
            }
            if(!isNaN(installPrice)){
                lastOffer += installPrice;
            }
            $("#tab").find("tr").eq("1").find("td").eq("9").text(lastOffer);
        }
    }

    //计算基础参数价格
    function computeBase(obj){
        var BASE_SPTJ_P = parseFloat($("#BASE_SPTJ_P").val());
        var BASE_TSGD_P = parseFloat($("#BASE_TSGD_P").val());
        var BASE_SPKJ_P = parseFloat($("#BASE_SPKJ_P").val());
        var BASE_YXSD_P = parseFloat($("#BASE_YXSD_P").val());
        var BASE_SXDY_P = parseFloat($("#BASE_SXDY_P").val());
        var BASE_ZMDY_P = parseFloat($("#BASE_ZMDY_P").val());
        var BASE_PL_P = parseFloat($("#BASE_PL_P").val());
        var BASE_AZHJ_P = parseFloat($("#BASE_AZHJ_P").val());
        var BASE_FSLX_P = parseFloat($("#BASE_FSLX_P").val());
        var BASE_FSGD_P = parseFloat($("#BASE_FSGD_P").val());
        var BASE_ZJZCSL_P = parseFloat($("#BASE_ZJZCSL_P").val());
        var BASE_BZXS_P = parseFloat($("#BASE_BZXS_P").val());
        var BASE_YSFS_P = parseFloat($("#BASE_YSFS_P").val());
        var BASE_JHXT_P = parseFloat($("#BASE_JHXT_P").val());
        var BASE_TJSDJC_P = parseFloat($("#BASE_TJSDJC_P").val());
        var BASE_TJXDJC_P = parseFloat($("#BASE_TJXDJC_P").val());

        //当前设备总价
        var basePrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("4").text());
        //数量
        var offer_num = parseFloat($("#tab").find("tr").eq("1").find("td").eq("1").text());
        var lastBasePrice = parseFloat(((BASE_SPTJ_P+BASE_TSGD_P+BASE_SPKJ_P+BASE_YXSD_P+BASE_SXDY_P+BASE_ZMDY_P+BASE_PL_P+BASE_AZHJ_P+BASE_FSLX_P+BASE_FSGD_P+BASE_ZJZCSL_P+BASE_BZXS_P+BASE_YSFS_P+BASE_JHXT_P+BASE_TJSDJC_P+BASE_TJXDJC_P)*offer_num)+basePrice);
        $("#tab").find("tr").eq("1").find("td").eq("4").text(lastBasePrice);

        //填充折后设备价格
        var discount = $("#discount").val();
        if(discount!="1"){
            //折扣
            var dc = parseFloat($("#discount").val());
            var dcPrice = lastBasePrice*dc;
            $("#tab").find("tr").eq("1").find("td").eq("6").text(dcPrice);
        }

        //填充实际报价
        setLastOffer();
        $(obj).attr("disabled", true);
    }

    //计算部件参数价格
    function computePart(obj){
        var PART_JSJ_P = parseFloat($("#PART_JSJ_P").val());
        var PART_TJLX_P = parseFloat($("#PART_TJLX_P").val());
        var PART_TJYS_P = parseFloat($("#PART_TJYS_P").val());
        var PART_TJZFX_P = parseFloat($("#PART_TJZFX_P").val());
        var PART_TJBKCZ_P = parseFloat($("#PART_TJBKCZ_P").val());
        var PART_FSDGCZ_P = parseFloat($("#PART_FSDGCZ_P").val());
        var PART_FSDGG_P = parseFloat($("#PART_FSDGG_P").val());
        var PART_FSDYS_P = parseFloat($("#PART_FSDYS_P").val());
        var PART_WQBCZ_P = parseFloat($("#PART_WQBCZ_P").val());
        var PART_NWGBCZ_P = parseFloat($("#PART_NWGBCZ_P").val());
        var PART_SCTBJHDGB_P = parseFloat($("#PART_SCTBJHDGB_P").val());
        var PART_SCB_P = parseFloat($("#PART_SCB_P").val());
        var PART_QDFS_P = parseFloat($("#PART_QDFS_P").val());

        //当前设备总价
        var basePrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("4").text());
        //数量
        var offer_num = parseFloat($("#tab").find("tr").eq("1").find("td").eq("1").text());
        var lastBasePrice = parseFloat(((PART_JSJ_P+PART_TJLX_P+PART_TJYS_P+PART_TJZFX_P+PART_TJBKCZ_P+PART_FSDGCZ_P+PART_FSDGG_P+PART_FSDYS_P+PART_WQBCZ_P+PART_NWGBCZ_P+PART_SCTBJHDGB_P+PART_SCB_P+PART_QDFS_P)*offer_num)+basePrice);
        $("#tab").find("tr").eq("1").find("td").eq("4").text(lastBasePrice);

        //填充折后设备价格
        var discount = $("#discount").val();
        if(discount!="1"){
            //折扣
            var dc = parseFloat($("#discount").val());
            var dcPrice = lastBasePrice*dc;
            $("#tab").find("tr").eq("1").find("td").eq("6").text(dcPrice);
        }
        
        //填充实际报价
        setLastOffer();
        $(obj).attr("disabled", true);
    }

    //计算标准参数价格
    function computeStd(obj){
        var STD_JTAN_P = parseFloat($("#STD_JTAN_P").val());
        var STD_YSKG_P = parseFloat($("#STD_YSKG_P").val());
        var STD_FSJCKBHKG_P = parseFloat($("#STD_FSJCKBHKG_P").val());
        var STD_TJLDLBHKG_P = parseFloat($("#STD_TJLDLBHKG_P").val());
        var STD_TJXXBH_P = parseFloat($("#STD_TJXXBH_P").val());
        var STD_QXJCXBH_P = parseFloat($("#STD_QXJCXBH_P").val());
        var STD_DJHZBH_P = parseFloat($("#STD_DJHZBH_P").val());
        var STD_JFHB_P = parseFloat($("#STD_JFHB_P").val());
        var STD_DJGZBH_P = parseFloat($("#STD_DJGZBH_P").val());
        var STD_DJGRBH_P = parseFloat($("#STD_DJGRBH_P").val());
        var STD_SCBHKG_P = parseFloat($("#STD_SCBHKG_P").val());
        var STD_WXSDZZ_P = parseFloat($("#STD_WXSDZZ_P").val());
        var STD_QDJL_P = parseFloat($("#STD_QDJL_P").val());
        var STD_FNZBH_P = parseFloat($("#STD_FNZBH_P").val());
        var STD_FSDFJDL_P = parseFloat($("#STD_FSDFJDL_P").val());
        var STD_GZZDQJKKG_P = parseFloat($("#STD_GZZDQJKKG_P").val());
        var STD_TJFJDS_P = parseFloat($("#STD_TJFJDS_P").val());
        var STD_QDLDLBH_P = parseFloat($("#STD_QDLDLBH_P").val());
        var STD_SDJXCZ_P = parseFloat($("#STD_SDJXCZ_P").val());
        var STD_SDPCZZ_P = parseFloat($("#STD_SDPCZZ_P").val());
        var STD_GBJXKG_P = parseFloat($("#STD_GBJXKG_P").val());
        var STD_WQMS_P = parseFloat($("#STD_WQMS_P").val());
        var STD_FSDSDJK_P = parseFloat($("#STD_FSDSDJK_P").val());
        var STD_TJYSBH_P = parseFloat($("#STD_TJYSBH_P").val());
        var STD_TJCSBH_P = parseFloat($("#STD_TJCSBH_P").val());
        var STD_ZDJLCXBJ_P = parseFloat($("#STD_ZDJLCXBJ_P").val());
        var STD_GZXS_P = parseFloat($("#STD_GZXS_P").val());
        var STD_TJJXZM_P = parseFloat($("#STD_TJJXZM_P").val());
        var STD_SXJFTB_P = parseFloat($("#STD_SXJFTB_P").val());
        var STD_FJZDQ_P = parseFloat($("#STD_FJZDQ_P").val());
        var STD_JXSB_P = parseFloat($("#STD_JXSB_P").val());
        var STD_JXXD_P = parseFloat($("#STD_JXXD_P").val());
        var STD_WQAQZZ_P = parseFloat($("#STD_WQAQZZ_P").val());
        var STD_FSDDDBH_P = parseFloat($("#STD_FSDDDBH_P").val());
        var STD_DLFDLJQ_P = parseFloat($("#STD_DLFDLJQ_P").val());

        //当前设备总价
        var basePrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("4").text());
        //数量
        var offer_num = parseFloat($("#tab").find("tr").eq("1").find("td").eq("1").text());
        var lastBasePrice = parseFloat(((STD_JTAN_P+STD_YSKG_P+STD_FSJCKBHKG_P+STD_TJLDLBHKG_P+STD_TJXXBH_P+STD_QXJCXBH_P+STD_DJHZBH_P+STD_JFHB_P+STD_DJGZBH_P+STD_DJGRBH_P+STD_SCBHKG_P+STD_WXSDZZ_P+STD_QDJL_P+STD_FNZBH_P+STD_FSDFJDL_P+STD_GZZDQJKKG_P+STD_TJFJDS_P+STD_QDLDLBH_P+STD_SDJXCZ_P+STD_SDPCZZ_P+STD_GBJXKG_P+STD_WQMS_P+STD_FSDSDJK_P+STD_TJYSBH_P+STD_TJCSBH_P+STD_ZDJLCXBJ_P+STD_GZXS_P+STD_TJJXZM_P+STD_SXJFTB_P+STD_FJZDQ_P+STD_JXSB_P+STD_JXXD_P+STD_WQAQZZ_P+STD_FSDDDBH_P+STD_DLFDLJQ_P)*offer_num)+basePrice);
        $("#tab").find("tr").eq("1").find("td").eq("4").text(lastBasePrice);

        //填充折后设备价格
        var discount = $("#discount").val();
        if(discount!="1"){
            //折扣
            var dc = parseFloat($("#discount").val());
            var dcPrice = lastBasePrice*dc;
            $("#tab").find("tr").eq("1").find("td").eq("6").text(dcPrice);
        }

        //填充实际报价
        setLastOffer();
        $(obj).attr("disabled", true);
    }

    //计算选配参数价格
    function computeOpt(obj){
        var OPT_AQZDQ_P = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_GCD = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_JTLXD = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_ZDQMSJK = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_ZDJY = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_QDLLZ = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_WQZM = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_TJFTBH = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_FSDDDBHZZ = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_ZDWQJXKG = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_SCZM = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_YSFLQ = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_FHBH = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_TJLFHZ = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_WZSWZ = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_ZSBCL = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_ZSBHD = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_WXHL = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_DZGSS = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_FPZZ = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_HJJR = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_SCJR = parseFloat($("#OPT_AQZDQ_P").val());
        var OPT_FSJR = parseFloat($("#OPT_AQZDQ_P").val());


        //当前设备总价
        var basePrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("4").text());
        //数量
        var offer_num = parseFloat($("#tab").find("tr").eq("1").find("td").eq("1").text());
        var lastBasePrice = parseFloat(((OPT_AQZDQ_P+OPT_GCD+OPT_JTLXD+OPT_ZDQMSJK+OPT_ZDJY+OPT_QDLLZ+OPT_WQZM+OPT_TJFTBH+OPT_FSDDDBHZZ+OPT_ZDWQJXKG+OPT_SCZM+OPT_YSFLQ+OPT_FHBH+OPT_TJLFHZ+OPT_WZSWZ+OPT_ZSBCL+OPT_ZSBHD+OPT_WXHL+OPT_DZGSS+OPT_FPZZ+OPT_HJJR+OPT_SCJR+OPT_FSJR)*offer_num)+basePrice);
        $("#tab").find("tr").eq("1").find("td").eq("4").text(lastBasePrice);

        //填充折后设备价格
        var discount = $("#discount").val();
        if(discount!="1"){
            //折扣
            var dc = parseFloat($("#discount").val());
            var dcPrice = lastBasePrice*dc;
            $("#tab").find("tr").eq("1").find("td").eq("6").text(dcPrice);
        }

        //填充实际报价
        setLastOffer();
        $(obj).attr("disabled", true);
    }

    //计算环境配置价格
    function computeEnv(obj){
        var ENV_ZDJY_P = parseFloat($("#ENV_ZDJY_P").val());
        var ENV_DJ_P = parseFloat($("#ENV_DJ_P").val());
        var ENV_KZXT_P = parseFloat($("#ENV_KZXT_P").val());
        var ENV_HDGBLJC_P = parseFloat($("#ENV_HDGBLJC_P").val());
        var ENV_SWXFSD_P = parseFloat($("#ENV_SWXFSD_P").val());
        var ENV_NWGBBXG_P = parseFloat($("#ENV_NWGBBXG_P").val());
        var ENV_WQBXG_P = parseFloat($("#ENV_WQBXG_P").val());
        var ENV_WZSBBXG_P = parseFloat($("#ENV_WZSBBXG_P").val());
        var ENV_FSDGBXG_P = parseFloat($("#ENV_FSDGBXG_P").val());
        var ENV_JSGJPSBYQ_P = parseFloat($("#ENV_JSGJPSBYQ_P").val());
        var ENV_JSGJRJDX_P = parseFloat($("#ENV_JSGJRJDX_P").val());
        var ENV_FXCL_P = parseFloat($("#ENV_FXCL_P").val());
        var ENV_DKLCL_P = parseFloat($("#ENV_DKLCL_P").val());
        var ENV_BQZ_P = parseFloat($("#ENV_BQZ_P").val());
        var ENV_YSFLQZZ_P = parseFloat($("#ENV_YSFLQZZ_P").val());
        var ENV_FHBH_P = parseFloat($("#ENV_FHBH_P").val());
        var ENV_TJLFHZ_P = parseFloat($("#ENV_TJLFHZ_P").val());
        var ENV_HJJR_P = parseFloat($("#ENV_HJJR_P").val());
        var ENV_SCJR_P = parseFloat($("#ENV_SCJR_P").val());
        var ENV_FSJR_P = parseFloat($("#ENV_FSJR_P").val());

        //当前设备总价
        var basePrice = parseFloat($("#tab").find("tr").eq("1").find("td").eq("4").text());
        //数量
        var offer_num = parseFloat($("#tab").find("tr").eq("1").find("td").eq("1").text());
        var lastBasePrice = parseFloat(((ENV_ZDJY_P+ENV_DJ_P+ENV_KZXT_P+ENV_HDGBLJC_P+ENV_SWXFSD_P+ENV_NWGBBXG_P+ENV_WQBXG_P+ENV_WZSBBXG_P+ENV_FSDGBXG_P+ENV_JSGJPSBYQ_P+ENV_JSGJRJDX_P+ENV_FXCL_P+ENV_DKLCL_P+ENV_BQZ_P+ENV_YSFLQZZ_P+ENV_FHBH_P+ENV_TJLFHZ_P+ENV_HJJR_P+ENV_SCJR_P+ENV_FSJR_P)*offer_num)+basePrice);
        $("#tab").find("tr").eq("1").find("td").eq("4").text(lastBasePrice);

        //填充折后设备价格
        var discount = $("#discount").val();
        if(discount!="1"){
            //折扣
            var dc = parseFloat($("#discount").val());
            var dcPrice = lastBasePrice*dc;
            $("#tab").find("tr").eq("1").find("td").eq("6").text(dcPrice);
        }

        //填充实际报价
        setLastOffer();
        $(obj).attr("disabled", true);
    }


    function CloseSUWin(id) {
        window.parent.$("#" + id).data("kendoWindow").close();
    }

    function save(){
        $("#floor").val($("#tab").find("tr").eq("1").find("td").eq("2").text());
        $("#eqpt_price").val($("#tab").find("tr").eq("1").find("td").eq("4").text());
        $("#disc_price").val($("#tab").find("tr").eq("1").find("td").eq("6").text());
        /*$("#install_price").val($("#tab").find("tr").eq("1").find("td").eq("7").text());
        $("#trans_price").val($("#tab").find("tr").eq("1").find("td").eq("8").text());*/
        $("#last_offer").val($("#tab").find("tr").eq("1").find("td").eq("9").text());
        $("#elevator_id").val("");


        $("#escalatorForm").submit();
    }
</script>
</body>

</html>
