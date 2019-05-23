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
                                                    <th>装潢价(元)</th>
                                                    <th>设备价(元)</th>
                                                    <th>折扣</th>
                                                    <th>折后设备价(元)</th>
                                                    <th>安装费(元)</th>
                                                    <th>运输费(元)</th>
                                                    <th>实际报价(元)</th>
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
                                            </ul>
                                            <div class="tab-content">
                                                <div id="tab-1" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computeBase(this)">
                                                    <!-- 基本参数 -->
                                                    <table width="890" height="392" border="1" cellspacing="0">
                                                      <tr>
                                                        <td>序号</td>
                                                        <td colspan="2">参数内容及代码</td>
                                                        <td>标准规格</td>
                                                        <td>选项规格</td>
                                                        <td>非标规格及备注</td>
                                                        <td>加价</td>
                                                        <td>交货期</td>
                                                      </tr>
                                                      <tr>
                                                        <td>1</td>
                                                        <td colspan="2">机房形式</td>
                                                        <td><select><option value="1">有机房</option><option value="0">无机房</option></select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>2</td>
                                                        <td colspan="2">载重(kg)</td>
                                                        <td><select name="select">
                                                          <option value="630">630</option>
                                                          <option value="800">800</option>
                                                          <option value="1000">1000</option>
                                                          <option value="1150">1150</option>
                                                          <option value="-2">非标规格</option>
                                                        </select>    </td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>3</td>
                                                        <td colspan="2">速度(m/s)</td>
                                                        <td><select name="select2">
                                                          <option value="1">1</option>
                                                          <option value="1.5">1.5</option>
                                                          <option value="1.75">1.75</option>
                                                          <option value="2.0">2.0</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td rowspan="2">4</td>
                                                        <td rowspan="2">层站数</td>
                                                        <td>楼层数</td>
                                                        <td><input type="text" /></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>停靠站数</td>
                                                        <td><input name="text" type="text" /></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>5</td>
                                                        <td colspan="2">井道结构</td>
                                                        <td><select name="select3">
                                                          <option value="1">全混凝土</option>
                                                          <option value="2">砖混结构</option>
                                                          <option value="3">钢结构</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>6</td>
                                                        <td colspan="2">圈/钢梁间距(mm)</td>
                                                        <td><select name="select4">
                                                          <option value="1">见合同土建图</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>7</td>
                                                        <td colspan="2">开门方式</td>
                                                        <td><select name="select5">
                                                          <option value="1">中分两扇门</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>8</td>
                                                        <td colspan="2">开门宽度(mm)</td>
                                                        <td><select name="select6">
                                                          <option value="800">800</option>
                                                          <option value="900">900</option>
                                                          <option value="1000">1000</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td><select name="select14">
                                                          <option value="1000">1000</option>
                                                          <option value="1100">1100</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>9</td>
                                                        <td colspan="2">开门高度(mm)</td>
                                                        <td><select name="select7">
                                                          <option value="2100">2100</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>10</td>
                                                        <td colspan="2">控制方式</td>
                                                        <td><select name="select8">
                                                          <option value="1">单台运转(G1C)</option>
                                                          <option value="2">两台联动(G2C)</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td><select name="select15">
                                                          <option value="1">三台群控(G3C)</option>
                                                          <option value="2">四台群控(G4C)</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>11</td>
                                                        <td colspan="2">号梯代码(选择联动或群控功能时)</td>
                                                        <td><select name="select9">
                                                          <option value="1">A</option>
                                                          <option value="2">B</option>
                                                        </select></td>
                                                        <td><select name="select16">
                                                          <option value="1">A</option>
                                                          <option value="2">B</option>
                                                          <option value="3">C</option>
                                                          <option value="4">D</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>12</td>
                                                        <td colspan="2">轿厢规格:[轿厢内宽(CW)*轿厢内深(CD)]</td>
                                                        <td><select name="select10">
                                                          <option value="1">1400*1100(630kg)</option>
                                                          <option value="2">1100*1400(630kg)</option>
                                                          <option value="3">1400*1350(800kg)</option>
                                                          <option value="4">1350*1400(800kg)</option>
                                                          <option value="5">1600*1400(1000kg)</option>
                                                          <option value="6">1100*2100(1000kg担架梯)</option>
                                                          <option value="7">1800*1500(1150kg)</option>
                                                          <option value="-1">选项规格</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>13</td>
                                                        <td colspan="2">轿厢结构高度 CH(mm)(非净高)</td>
                                                        <td><select name="select11">
                                                          <option value="2400">2400</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td><select name="select17">
                                                          <option value="2500">2500</option>
                                                          <option value="2300">2300</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>14</td>
                                                        <td colspan="2">井道承重墙厚度(mm)</td>
                                                        <td><select name="select12">
                                                          <option value="240">240</option>
                                                          <option value="250">250</option>
                                                          <option value="250-300">选项规格(大于250且小于300)</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>15</td>
                                                        <td>提升高度(mm)</td>
                                                        <td>数值(m)</td>
                                                        <td rowspan="5"><select name="select13">
                                                          <option value="0">见合同土建图</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td rowspan="2">16</td>
                                                        <td rowspan="2">井道尺寸(mm)</td>
                                                        <td>井道宽 HW </td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>井道深 HD </td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>17</td>
                                                        <td>顶层高度 K</td>
                                                        <td>数值(mm)</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>18</td>
                                                        <td>底坑深度 S </td>
                                                        <td>数值(mm)</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>19</td>
                                                        <td>楼层标记</td>
                                                        <td>标识</td>
                                                        <td><input type="text" /></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                    </table>
                                                    <!-- 基本参数 -->
                                                </div>
                                                <div id="tab-2" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computePart(this)">
                                                    <!-- 部件参数 -->
                                                    <table width="1095" height="571" border="1" cellspacing="0">
                                                      <tr>
                                                        <td width="41">序号</td>
                                                        <td colspan="4">参数内容及代码</td>
                                                        <td width="176">标准规格</td>
                                                        <td width="232">选项规格</td>
                                                        <td width="128">非标规格及备注</td>
                                                        <td width="43">加价</td>
                                                        <td width="127">交货期</td>
                                                      </tr>
                                                      <tr>
                                                        <td rowspan="15">23</td>
                                                        <td width="50" rowspan="15">轿厢装潢</td>
                                                        <td colspan="2" rowspan="2">轿厢门</td>
                                                        <td width="132">材质</td>
                                                        <td><select><option value="1">发纹不锈钢</option><option value="-1">选项规格</option><option value="-2">非标规格</option></select></td>
                                                        <td><select name="select">
                                                          <option value="1">钢板喷涂</option>
                                                          <option value="2">镜面不锈钢</option>
                                                        </select>    </td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td width="132">钢板色标号</td>
                                                        <td><select name="select2">
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select>    </td>
                                                        <td><select name="select3">
                                                          <option value="1">P-01</option>
                                                          <option value="2">P-02</option>
                                                          <option value="3">P-03</option>
                                                          <option value="4">P-04</option>
                                                          <option value="5">P-05</option>
                                                          <option value="6">P-06</option>
                                                          <option value="7">P-07</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td width="37" rowspan="6">围壁</td>
                                                        <td width="87" rowspan="2">前围壁(包含前门楣)</td>
                                                        <td width="132">材质</td>
                                                        <td><select name="select4">
                                                          <option value="1">发纹不锈钢</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select>    </td>
                                                        <td><select name="select5">
                                                          <option value="1">钢板喷涂</option>
                                                          <option value="2">镜面不锈钢</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td width="132">钢板色标号</td>
                                                        <td><select name="select6">
                                                          <option value="1">P01</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td><select name="select7">
                                                          <option value="1">P-01</option>
                                                          <option value="2">P-02</option>
                                                          <option value="3">P-03</option>
                                                          <option value="4">P-04</option>
                                                          <option value="5">P-05</option>
                                                          <option value="6">P-06</option>
                                                          <option value="7">P-07</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td width="87" rowspan="2">两侧围壁</td>
                                                        <td width="132">材质</td>
                                                        <td><select name="select8">
                                                          <option value="1">发纹不锈钢</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td><select name="select9">
                                                          <option value="1">钢板喷涂</option>
                                                          <option value="2">镜面不锈钢</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td width="132">钢板色标号</td>
                                                        <td><select name="select10">
                                                          <option value="1">P01</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td><select name="select11">
                                                          <option value="1">P-01</option>
                                                          <option value="2">P-02</option>
                                                          <option value="3">P-03</option>
                                                          <option value="4">P-04</option>
                                                          <option value="5">P-05</option>
                                                          <option value="6">P-06</option>
                                                          <option value="7">P-07</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td width="87" rowspan="2">后侧围壁</td>
                                                        <td width="132">材质</td>
                                                        <td><select name="select12">
                                                          <option value="1">发纹不锈钢</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td><select name="select13">
                                                          <option value="1">钢板喷涂</option>
                                                          <option value="2">镜面不锈钢</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td width="132">钢板色标号</td>
                                                        <td><select name="select14">
                                                          <option value="1">P01</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td><select name="select15">
                                                          <option value="1">P-01</option>
                                                          <option value="2">P-02</option>
                                                          <option value="3">P-03</option>
                                                          <option value="4">P-04</option>
                                                          <option value="5">P-05</option>
                                                          <option value="6">P-06</option>
                                                          <option value="7">P-07</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="3">吊顶型号</td>
                                                        <td><select name="select16">
                                                          <option value="1">JF-CL22</option>
                                                          <option value="-2">非标规格</option>
                                                          <option value="-3">无</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="2" rowspan="3">轿厢地板</td>
                                                        <td width="132">轿厢地板型号</td>
                                                        <td><select name="select17">
                                                          <option value="1">JF-JD-08</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td><select name="select18">
                                                          <option value="1">JF-JD-01</option>
                                                          <option value="2">JF-JD-02</option>
                                                          <option value="3">JF-JD-03</option>
                                                          <option value="4">JF-JD-04</option>
                                                          <option value="5">JF-JD-05</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td width="132">地板装修厚度(mm)</td>
                                                        <td><select name="select19">
                                                          <option value="1">3</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td><select name="select20">
                                                          <option value="1">25(必须提供预留轿厢装潢重量)</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td width="132">预留装潢重量(kg)</td>
                                                        <td><select name="select21">
                                                          <option value="1">-----</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="2" rowspan="2">轿厢扶手</td>
                                                        <td width="132">轿厢扶手型号</td>
                                                        <td><select name="select22">
                                                          <option value="1">-----</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td><select name="select23">
                                                          <option value="1">JF-FS-01</option>
                                                          <option value="2">JF-FS-02</option>
                                                          <option value="3">JF-FS-03</option>
                                                          <option value="4">JF-FS-04</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td width="132">扶手安装位置</td>
                                                        <td><select name="select24">
                                                          <option value="1">-----</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td><select name="select25">
                                                          <option value="1">轿厢后侧</option>
                                                          <option value="2">轿厢左侧(站在层站面向轿厢)</option>
                                                          <option value="3">轿厢右侧(站在层站面向轿厢)</option>
                                                          <option value="4">左侧+右侧</option>
                                                          <option value="5">左侧+右侧+后侧</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="3">轿厢镜面</td>
                                                        <td><select name="select26">
                                                          <option value="1">-----</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td><select name="select27">
                                                          <option value="1">轿厢后侧</option>
                                                          <option value="2">轿厢左侧(站在层站面向轿厢)</option>
                                                          <option value="3">轿厢右侧(站在层站面向轿厢)</option>
                                                          <option value="4">左侧+右侧</option>
                                                          <option value="5">左侧+右侧+后侧</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td rowspan="2">24</td>
                                                        <td colspan="3" rowspan="2">电梯对讲系统(不含值班室到电梯井道的配线)</td>
                                                        <td>规格</td>
                                                        <td><select name="select28">
                                                          <option value="-1">选项规格</option>
                                                        </select></td>
                                                        <td><select name="select29">
                                                          <option value="1">分线制(标配)</option>
                                                          <option value="2">总线制(选项)</option>
                                                          <option value="3">无线(非标)</option>
                                                        </select></td>
                                                        <td>10台以上标配总线制</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="2">监控室母机配置</td>
                                                        <td><select name="select30">
                                                          <option value="1">一对一</option>
                                                          <option value="2">一对多</option>
                                                        </select></td>
                                                        <td>一对多时最多64台</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td rowspan="6">25</td>
                                                        <td colspan="3" rowspan="3">轿厢操纵盘</td>
                                                        <td>型号</td>
                                                        <td colspan="2"><select name="select31">
                                                          <option value="1">JFCOP14H-D1(一体式)</option>
                                                          <option value="2">JFCOP14H-D(分体式)</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>操纵盘位置</td>
                                                        <td><select name="select32">
                                                          <option value="1">左前(站在层站面向轿厢)</option>
                                                          <option value="-1">选项规格</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td><select name="select33">
                                                          <option value="1">右前(站在层站面向轿厢)</option>
                                                          <option value="2">左侧围壁(站在层站面向轿厢)</option>
                                                          <option value="3">右侧围壁(站在层站面向轿厢)</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>数量</td>
                                                        <td><select name="select34">
                                                          <option value="1">1</option>
                                                          <option value="2">2</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="3" rowspan="3">残疾人操纵盘</td>
                                                        <td>型号</td>
                                                        <td><select name="select35">
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>操纵盘型式</td>
                                                        <td><select name="select36">
                                                          <option value="1">嵌入式</option>
                                                          <option value="2">壁挂式</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>操纵盘位置</td>
                                                        <td><select name="select37">
                                                          <option value="1">左侧(站在层外向轿厢看)</option>
                                                          <option value="2">右侧(站在层外向轿厢看)</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td rowspan="2">26</td>
                                                        <td colspan="3" rowspan="2">层站呼梯盒</td>
                                                        <td>型号</td>
                                                        <td><select name="select38">
                                                          <option value="1">JF-HB14H-D1</option>
                                                          <option value="-2">非标规格</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>数量</td>
                                                        <td><input name="text" type="text" /></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>27</td>
                                                        <td colspan="4">驻停基站位置</td>
                                                        <td><select name="select39">
                                                          <option value="1">1 FL</option>
                                                          <option value="-1">选配规格</option>
                                                        </select></td>
                                                        <td>&nbsp;</td>
                                                        <td>有地下层时注意填写</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                    </table>
                                                    <!-- 部件参数 -->
                                                </div>
                                                <div id="tab-3" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computeStd(this)">
                                                    <!-- 标准功能 -->
                                                    <table width="679" height="340" border="1" cellspacing="0">
                                                      <tr>
                                                        <td colspan="4">标准功能及代码</td>
                                                      </tr>
                                                      <tr>
                                                        <td>1</td>
                                                        <td>全集选控制</td>
                                                        <td>14</td>
                                                        <td>故障自动检测</td>
                                                      </tr>
                                                      <tr>
                                                        <td>2</td>
                                                        <td>轿顶与机房紧急电动运行</td>
                                                        <td>15</td>
                                                        <td>关门时间保护</td>
                                                      </tr>
                                                      <tr>
                                                        <td>3</td>
                                                        <td>轿内应急照明</td>
                                                        <td>16</td>
                                                        <td>超载不启动(警示灯及蜂鸣器)</td>
                                                      </tr>
                                                      <tr>
                                                        <td>4</td>
                                                        <td>设置厅/轿门时间</td>
                                                        <td>17</td>
                                                        <td>运行次数显示</td>
                                                      </tr>
                                                      <tr>
                                                        <td>5</td>
                                                        <td>满载不停梯</td>
                                                        <td>18</td>
                                                        <td>警铃</td>
                                                      </tr>
                                                      <tr>
                                                        <td>6</td>
                                                        <td>无呼自动返基站</td>
                                                        <td>19</td>
                                                        <td>厅和轿厢数字式位置指示器</td>
                                                      </tr>
                                                      <tr>
                                                        <td>7</td>
                                                        <td>驻停</td>
                                                        <td>20</td>
                                                        <td>厅外和轿厢呼梯/登记</td>
                                                      </tr>
                                                      <tr>
                                                        <td>8</td>
                                                        <td>外呼按钮嵌入自诊断</td>
                                                        <td>21</td>
                                                        <td>厅及轿厢运行方向显示</td>
                                                      </tr>
                                                      <tr>
                                                        <td>9</td>
                                                        <td>防捣乱操作</td>
                                                        <td>22</td>
                                                        <td>轿厢防意外移动功能(UCMP)</td>
                                                      </tr>
                                                      <tr>
                                                        <td>10</td>
                                                        <td>轿内通风手动及照明自动控制</td>
                                                        <td>23</td>
                                                        <td>2D光幕门保护装置</td>
                                                      </tr>
                                                      <tr>
                                                        <td>11</td>
                                                        <td>盲文按钮</td>
                                                        <td>24</td>
                                                        <td>错误指令删除</td>
                                                      </tr>
                                                      <tr>
                                                        <td>12</td>
                                                        <td>轿门防扒门</td>
                                                        <td>25</td>
                                                        <td>开/关门按钮</td>
                                                      </tr>
                                                      <tr>
                                                        <td>13</td>
                                                        <td>监控室与机房/轿厢对讲(不含机房到监控室线)</td>
                                                        <td>26</td>
                                                        <td>开门再平层</td>
                                                      </tr>
                                                    </table>
                                                    <!-- 标准功能 -->
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
                                            <label>安装价格(元):</label>
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
                                            运输价格(元):
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
