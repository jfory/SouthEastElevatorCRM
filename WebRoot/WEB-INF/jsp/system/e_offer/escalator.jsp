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
                                                <li class=""><a data-toggle="tab" href="#tab-5">半室外/室外环境配置</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div id="tab-1" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computeBase(this)">
                                                    <!-- 基本参数 -->
                                                    <table width="718" height="326" border="1">
  <tr>
    <td colspan="2">1.倾斜角度</td>
    <td width="227">
        <select>
            <option>30°</option>
            <option>35°</option>
        </select>   </td>
    <td width="77">&nbsp;</td>
    <td width="66">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">2.梯级宽度(A)/水平梯级[当H&gt;6000mm时必须选择3个]</td>
    <td>
        <select>
            <option>1000</option>
            <option>800</option>
            <option>600</option>
        </select>mm/
        <select name="select">
          <option>2</option>
          <option>3</option>
        </select>个  
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">3.提升高度(H)</td>
    <td>
        <select name="select2">
            <option>4500</option>
        </select>mm
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">4.水平跨距(DBE)</td>
    <td>
        <select name="select3">
          <option>10800</option>
        </select>mm 
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">5.运行速度</td>
    <td>0.5m/s</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">6.电源-三相电压/照明电压/频率</td>
    <td>380±5%V/220±10%V/50±2%Hz</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">7.安装环境</td>
    <td>
        <select name="select4">
          <option>室内</option>
          <option>半室外配置A</option>
          <option>半室外配置B</option>
          <option>全室外配置C</option>
          <option>全室外配置D</option>
        </select>
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="117" rowspan="2">8.扶手装置</td>
    <td width="197">扶手类型</td>
    <td>苗条型玻璃扶手</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>扶手高度</td>
    <td>
        <select name="select5">
          <option>900</option>
          <option>1000</option>
        </select>mm
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">9.中间支撑数量[水平跨距DBE&gt;15m时至少一个]</td>
    <td>
        <select name="select6">
          <option>无</option>
          <option>1个</option>
          <option>2个</option>
          <option>3个</option>
        </select>
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">10.布置形式</td>
    <td>
        <select name="select7">
          <option>单梯</option>
          <option>交叉</option>
          <option>连续</option>
          <option>平行</option>
          <option>根据土建图</option>
        </select>
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">11.运输方式/交货形态(分段数)</td>
    <td>
        卡车/<select name="select8">
          <option>整梯</option>
          <option>分2段</option>
          <option>分3段</option>
        </select>
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td rowspan="2">12.土建尺寸</td>
    <td><p>上端加长(0~1000mm)[A-600时必须加长417]</p>    </td>
    <td>
        <input type="text" />mm
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>下端加长(0~1000mm)</td>
    <td>
        <input name="text" type="text" />mm
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
                                                    <!-- 基本参数 -->
                                                </div>
                                                <div id="tab-2" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computePart(this)">
                                                    <!-- 部件参数-->
                                                    <table width="897" height="211" border="1" cellspacing="0">
  <tr>
    <td width="355">1.减速机</td>
    <td width="280">涡轮蜗杆</td>
    <td width="130">&nbsp;</td>
    <td width="104">&nbsp;</td>
  </tr>
  <tr>
    <td>2.梯级-梯级类型/颜色[自然色仅用于铝梯级]</td>
    <td>
        <select>
            <option>不锈钢梯级</option>
            <option>铝梯级(三边塑料边框)</option>
        </select>/
        <select>
            <option>自然色</option>
            <option>银灰色</option>
            <option>黑色</option>
        </select>   </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>3.梯级-梯级中分线[仅用于铝合金梯级]</td>
    <td>
        <input type="checkbox" />   </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>4.梯级-梯级边框材质</td>
    <td>三边塑料边框</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>5.扶手导轨材质</td>
    <td>
        <select name="select">
          <option>发纹不锈钢</option>
          <option>发纹不锈钢SUS304</option>
        </select>   </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>6.扶手带规格/颜色</td>
    <td><select name="select6">
      <option>国内品牌</option>
      <option>外资品牌</option>
    </select>
      /
          <select name="select2">
            <option>黑色</option>
            <option>其他(非标项中指明)</option>
          </select> </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>7.围裙版材质</td>
    <td>
        <select name="select3">
          <option>钢板黑色喷漆</option>
          <option>发纹不锈钢TTS443</option>
          <option>发纹不锈钢SUS304</option>
        </select>   </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>8.内外盖板材质</td>
    <td>
        <select name="select4">
          <option>发纹不锈钢</option>
          <option>发纹不锈钢SUS304</option>
        </select>   </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>9.梳齿踏板及活动盖板</td>
    <td>
        <select name="select5">
          <option>压纹不锈钢,方形花纹</option>
          <option>压纹不锈钢,矩形花纹</option>
          <option>蚀刻不锈钢,菱形花纹</option>
          <option>铝合金防滑条纹</option>
        </select>   </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>10.梳齿板</td>
    <td>
        <select name="select7">
          <option>PVC黄色</option>
          <option>铝合金自然色</option>
        </select>   </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>11.启动方式</td>
    <td><select name="select8">
      <option>Y-△,正常运行</option>
      <option>Y-△,快、停节能运行</option>
      <option>变频,快、慢节能运行</option>
      <option>变频,快、慢、停节能运行</option>
    </select></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
                                                    <!-- 部件参数 -->
                                                </div>
                                                <div id="tab-3" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computeStd(this)">
                                                    <!-- 标准功能 -->
                                                    <table width="769" height="196" border="1" cellspacing="0">
  <tr>
    <td>1.急停按钮</td>
    <td>2.钥匙开关</td>
    <td>3.扶手进出口保护开关</td>
    <td>4.梯级链断链保护开关</td>
  </tr>
  <tr>
    <td>5.梯级下陷保护</td>
    <td>6.缺相及错相保护</td>
    <td>7.点击护罩保护</td>
    <td>8.机房护板</td>
  </tr>
  <tr>
    <td>9.点击过载保护</td>
    <td>10.电机过热保护</td>
    <td>11.梳齿保护开关</td>
    <td>12.维修锁定装置</td>
  </tr>
  <tr>
    <td>13.启动警铃</td>
    <td>14.防逆转保护</td>
    <td>15.扶手带防静电轮</td>
    <td>16.工作制动器监控开关</td>
  </tr>
  <tr>
    <td>17.梯级防静电刷</td>
    <td>18.驱动链断链保护</td>
    <td>19.手动检修插座</td>
    <td>20.手动盘车装置</td>
  </tr>
  <tr>
    <td>21.盖板检修开关</td>
    <td>22.围裙毛刷</td>
    <td>23.扶手带速度监控</td>
    <td>24.梯级遗失保护</td>
  </tr>
  <tr>
    <td>25.梯级超速保护</td>
    <td>26.制动距离超限报警</td>
    <td>27.故障显示[控制柜上]</td>
    <td>28.梯级间隙照明</td>
  </tr>
  <tr>
    <td>29.上下机房踏板</td>
    <td>30.附加制动器[仅H&gt;6m时为标配]</td>
    <td>31.检修手柄[每个项目配一件]</td>
    <td>32.检修行灯[每个项目配1件]</td>
  </tr>
</table>
                                                    <!-- 标准功能 -->
                                                </div>
                                                <div id="tab-4" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computeOpt(this)">
                                                    <!-- 选配功能 -->
                                                    <table width="729" border="1" cellspacing="0">
  <tr>
    <td colspan="2">1.安全制动器[提升高度&gt;6m必选]</td>
    <td width="335">
        <input type="checkbox" />   </td>
    <td width="36">&nbsp;</td>
    <td width="8">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">2.5个干触点</td>
    <td><input name="checkbox" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">3.故障显示[在外盖板上]</td>
    <td><input name="checkbox2" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">4.交通流向灯[自启动时为必选]</td>
    <td><input name="checkbox3" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">5.制动器磨损监控</td>
    <td><input name="checkbox32" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">6.自动加油</td>
    <td><input name="checkbox33" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">7.驱动链链罩</td>
    <td><input name="checkbox34" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">8.围裙照明</td>
    <td><input name="checkbox35" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">9.梯级防跳保护</td>
    <td><input name="checkbox36" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">10.围裙安全装置</td>
    <td><input name="checkbox37" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">11.扶手带缎带保护装置</td>
    <td><input name="checkbox38" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">12.中段围裙间隙开关</td>
    <td><input name="checkbox39" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">13.梳齿照明</td>
    <td><input name="checkbox310" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">14.扶手照明</td>
    <td><input name="checkbox311" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">15.电缆分段连接器[桁架分段时选用]</td>
    <td><input name="checkbox312" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">16.油水分离器[户外是必选]</td>
    <td><input name="checkbox313" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">17.防洪保护[户外是必选]</td>
    <td><input name="checkbox314" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">18.梯级链防护罩[户外是必选]</td>
    <td><input name="checkbox315" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="110" rowspan="3">19.外装饰</td>
    <td width="218">外装饰位置[桁架分段时选用]</td>
    <td>
        <input type="radio" />左侧
        <input type="radio" />右侧
        <input type="radio" />底侧
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>装饰板材料</td>
    <td>
        <select>
            <option>钢板</option>
            <option>发纹不锈钢</option>
            <option>发纹不锈钢SUS304</option>
        </select>
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>装饰板厚度</td>
    <td>
        <select>
            <option>0.8</option>
            <option>1.0</option>
            <option>1.2</option>
        </select>
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">20.维修护栏</td>
    <td>
        <input type="radio" />每台一套
        <input type="radio" />每项目<input type="input" />套
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">21.检修手柄[至少每项目一台]</td>
    <td>
        <input type="radio" />每台一件
        <input type="radio" />每项目<input type="input" />件
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">22.检修行灯[至少每项目一台]</td>
    <td>
        <input type="radio" />每台一件
        <input type="radio" />每项目<input type="input" />件
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">23.吊装钢丝绳</td>
    <td>
        <input type="radio" />每台一套
        <input type="radio" />每项目<input name="input" type="input" />套
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">24.防爬装置</td>
    <td><input name="checkbox3152" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">25.桁架加热</td>
    <td><input name="checkbox3153" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">26.梳齿加热</td>
    <td><input name="checkbox3154" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">27.扶手加热</td>
    <td><input name="checkbox3155" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
                                                    <!-- 选配功能 -->
                                                </div>
                                                <div id="tab-5" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computeOpt(this)">
                                                    <!-- 半室外/室外环境配置 -->
                                                    <table width="931" height="431" border="1" cellspacing="0">
  <tr>
    <td colspan="2">安装环境类型</td>
    <td width="117">半室外配置A</td>
    <td width="117">半室外配置B</td>
    <td width="117">全室外配置C</td>
    <td width="117">全室外配置D</td>
    <td width="12">&nbsp;</td>
    <td width="17">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">自动加油</td>
    <td><input type="checkbox" /></td>
    <td><input name="checkbox" type="checkbox" /></td>
    <td><input name="checkbox2" type="checkbox" /></td>
    <td><input name="checkbox3" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">IP55电机</td>
    <td><input name="checkbox7" type="checkbox" /></td>
    <td><input name="checkbox6" type="checkbox" /></td>
    <td><input name="checkbox5" type="checkbox" /></td>
    <td><input name="checkbox4" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">IP54控制系统</td>
    <td><input name="checkbox8" type="checkbox" /></td>
    <td><input name="checkbox44" type="checkbox" /></td>
    <td><input name="checkbox45" type="checkbox" /></td>
    <td><input name="checkbox79" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">活动盖板铝基材</td>
    <td><input name="checkbox9" type="checkbox" /></td>
    <td><input name="checkbox43" type="checkbox" /></td>
    <td><input name="checkbox46" type="checkbox" /></td>
    <td><input name="checkbox78" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">室外型扶手带</td>
    <td><input name="checkbox10" type="checkbox" /></td>
    <td><input name="checkbox42" type="checkbox" /></td>
    <td><input name="checkbox47" type="checkbox" /></td>
    <td><input name="checkbox77" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">内外盖板不锈钢SUS304材质</td>
    <td><input name="checkbox11" type="checkbox" /></td>
    <td><input name="checkbox41" type="checkbox" /></td>
    <td><input name="checkbox48" type="checkbox" /></td>
    <td><input name="checkbox76" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">围裙不锈钢SUS304材质</td>
    <td><input name="checkbox12" type="checkbox" /></td>
    <td><input name="checkbox40" type="checkbox" /></td>
    <td><input name="checkbox49" type="checkbox" /></td>
    <td><input name="checkbox75" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">外装饰板不锈钢SUS304材质(若选择外装饰)</td>
    <td><input name="checkbox13" type="checkbox" /></td>
    <td><input name="checkbox39" type="checkbox" /></td>
    <td><input name="checkbox50" type="checkbox" /></td>
    <td><input name="checkbox74" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">扶手导轨不锈钢SUS304材质</td>
    <td><input name="checkbox14" type="checkbox" /></td>
    <td><input name="checkbox38" type="checkbox" /></td>
    <td><input name="checkbox51" type="checkbox" /></td>
    <td><input name="checkbox73" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="202" rowspan="2">金属骨架腐蚀保护</td>
    <td width="198">金属骨架喷三遍油漆</td>
    <td><input name="checkbox15" type="checkbox" /></td>
    <td><input name="checkbox37" type="checkbox" /></td>
    <td><input name="checkbox52" type="checkbox" /></td>
    <td><input name="checkbox72" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="198">金属骨架热浸镀锌</td>
    <td><input name="checkbox16" type="checkbox" /></td>
    <td><input name="checkbox36" type="checkbox" /></td>
    <td><input name="checkbox53" type="checkbox" /></td>
    <td><input name="checkbox71" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">导轨系统和主传动轴特殊防锈处理</td>
    <td><input name="checkbox17" type="checkbox" /></td>
    <td><input name="checkbox35" type="checkbox" /></td>
    <td><input name="checkbox54" type="checkbox" /></td>
    <td><input name="checkbox70" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">主要部件螺栓螺母达克罗处理</td>
    <td><input name="checkbox18" type="checkbox" /></td>
    <td><input name="checkbox34" type="checkbox" /></td>
    <td><input name="checkbox55" type="checkbox" /></td>
    <td><input name="checkbox69" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2"><p>表面特殊处理梯级轴</p>
    <p>驱动链和梯级链链板表面进行特殊防锈处理</p>
    <p>主副轮双重密封</p></td>
    <td><input name="checkbox19" type="checkbox" /></td>
    <td><input name="checkbox32" type="checkbox" /></td>
    <td><input name="checkbox33" type="checkbox" /></td>
    <td><input name="checkbox68" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">油水分离器装置</td>
    <td><input name="checkbox20" type="checkbox" /></td>
    <td><input name="checkbox31" type="checkbox" /></td>
    <td><input name="checkbox56" type="checkbox" /></td>
    <td><input name="checkbox67" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">防洪保护</td>
    <td><input name="checkbox21" type="checkbox" /></td>
    <td><input name="checkbox30" type="checkbox" /></td>
    <td><input name="checkbox57" type="checkbox" /></td>
    <td><input name="checkbox66" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">梯级链防护罩</td>
    <td><input name="checkbox22" type="checkbox" /></td>
    <td><input name="checkbox29" type="checkbox" /></td>
    <td><input name="checkbox58" type="checkbox" /></td>
    <td><input name="checkbox65" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">桁架加热</td>
    <td><input name="checkbox23" type="checkbox" /></td>
    <td><input name="checkbox28" type="checkbox" /></td>
    <td><input name="checkbox59" type="checkbox" /></td>
    <td><input name="checkbox64" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">梳齿加热</td>
    <td><input name="checkbox24" type="checkbox" /></td>
    <td><input name="checkbox27" type="checkbox" /></td>
    <td><input name="checkbox60" type="checkbox" /></td>
    <td><input name="checkbox63" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">扶手加热</td>
    <td><input name="checkbox25" type="checkbox" /></td>
    <td><input name="checkbox26" type="checkbox" /></td>
    <td><input name="checkbox61" type="checkbox" /></td>
    <td><input name="checkbox62" type="checkbox" /></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
                                                    <!-- 半室外/室外环境配置 -->
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
