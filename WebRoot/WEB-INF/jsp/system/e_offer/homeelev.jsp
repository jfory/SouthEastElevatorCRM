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
                                                <li class="active"><a data-toggle="tab" href="#tab-1">整机规格</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-2">轿厢规格</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-3">机能</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-4">层站规格</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div id="tab-1" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computeBase(this)">
                                                    <!-- 整机规格 -->
                                                    <table width="918" height="344" border="1" cellspacing="0">
  <tr>
    <td colspan="2">整机规格</td>
  </tr>
  <tr>
    <td width="446">001 产品系列:
      <input type="checkbox" />
      DELCO-C3 龙门架自动门 主机上置AS380串行系统 
      <input name="checkbox" type="checkbox" /> 
      T 特殊</td>
    <td width="462">019 开门方式:
    <input name="checkbox2" type="checkbox" />
    C0 两扇中分(标准) 
    <input name="checkbox3" type="checkbox" />
    2S 两扇旁开(选项) 
    <input name="checkbox4" type="checkbox" />
    2C0 四扇中分 
    <input name="checkbox5" type="checkbox" />
    3S 三扇旁开</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>020 开门方向(由厅外超朝轿内看开门时门的运动方向):
    <input name="checkbox8" type="checkbox" />
    C 中分门 
    <input name="checkbox9" type="checkbox" />
    L左开门</td>
  </tr>
  <tr>
    <td>002 执行标准:
      <input name="checkbox6" type="checkbox" />
A 参考标准GB/T 21739
<input name="checkbox7" type="checkbox" />
T 特殊</td>
    <td><input name="checkbox10" type="checkbox" />
      R 右开门
      <input name="checkbox11" type="checkbox" />
      T 特殊</td>
  </tr>
  <tr>
    <td>008 额定载重(人份):
    <input name="checkbox12" type="checkbox" />
    320kg(P4) 
    <input name="checkbox13" type="checkbox" />
    400kg(P5) 
    <input name="checkbox14" type="checkbox" />
    450kg(P6) 
    <input name="checkbox15" type="checkbox" />
    T特殊</td>
    <td>021 控制柜位置:
    <input name="checkbox16" type="checkbox" />
    STD 顶层门口旁 
    <input name="checkbox17" type="checkbox" />
    T 特殊</td>
  </tr>
  <tr>
    <td>010 额定速度(m/s):
    <input name="checkbox18" type="checkbox" />
    0.4 
    <input name="checkbox19" type="checkbox" />
    0.5
    <input name="checkbox20" type="checkbox" />
    1.0
    <input name="checkbox21" type="checkbox" />
    T 特殊</td>
    <td>022 井道结构形式:
    <input name="checkbox22" type="checkbox" />
    RC 钢筋混凝土 
    <input name="checkbox23" type="checkbox" />
    RCB 圈梁结构 
    <input name="checkbox24" type="checkbox" />
    SF 钢结构 
    <input name="checkbox25" type="checkbox" />
    T 特殊</td>
  </tr>
  <tr>
    <td>011 楼层数F:
    <input name="checkbox26" type="checkbox" />
    2 
    <input name="checkbox27" type="checkbox" />
    3 
    <input name="checkbox28" type="checkbox" />
    4
    <input name="checkbox29" type="checkbox" />
    5
    <input name="checkbox30" type="checkbox" />
    6
    <input name="checkbox31" type="checkbox" />
    7
    <input name="checkbox32" type="checkbox" />
    8
    <input name="checkbox33" type="checkbox" />
    T 特殊</td>
    <td>023 井道净宽(mm):1600</td>
  </tr>
  <tr>
    <td>012 停站数S: 
    <input name="checkbox34" type="checkbox" />
    2
    <input name="checkbox35" type="checkbox" />
    3
    <input name="checkbox36" type="checkbox" />
    4
    <input name="checkbox37" type="checkbox" />
    5
    <input name="checkbox38" type="checkbox" />
    6
    <input name="checkbox39" type="checkbox" />
    7
    <input name="checkbox40" type="checkbox" />
    8
    <input name="checkbox41" type="checkbox" />
    T特殊</td>
    <td>024 井道净深(mm):1600</td>
  </tr>
  <tr>
    <td>013轿厢宽(mm):
    <input name="checkbox42" type="checkbox" />
    800(320kg)
    <input name="checkbox43" type="checkbox" />
    950(320kg\400kg)
    <input name="checkbox44" type="checkbox" />
    1000(400kg)</td>
    <td>025 电梯行程(mm):12000</td>
  </tr>
  <tr>
    <td><input name="checkbox45" type="checkbox" />
      1100(400kg\450kg)
      <input name="checkbox46" type="checkbox" />
      T 特殊</td>
    <td>026 底坑深度(mm):300</td>
  </tr>
  <tr>
    <td>014 轿厢深(mm):
    <input name="checkbox47" type="checkbox" />
    1000(320kg)
    <input name="checkbox48" type="checkbox" />
    1200(320\400kg\450kg)
    <input name="checkbox49" type="checkbox" />
    1250(400kg)</td>
    <td>027 顶层高度(mm):2900</td>
  </tr>
  <tr>
    <td><input name="checkbox50" type="checkbox" />
      1400(400kg)
      <input name="checkbox51" type="checkbox" />
      1050(320kg)
      <input name="checkbox52" type="checkbox" />
      T 特殊 </td>
    <td>028 井道全高(mm):15200</td>
  </tr>
  <tr>
    <td>015 轿厢总高(mm):
    <input name="checkbox53" type="checkbox" />
    标准2200 
    <input name="checkbox54" type="checkbox" />
    选项2100
    <input name="checkbox55" type="checkbox" />
    选项2300 
    <input name="checkbox56" type="checkbox" />
    T 特殊</td>
    <td>029 动力电源(V):
    <input name="checkbox57" type="checkbox" />
    380(三相)
    <input name="checkbox58" type="checkbox" />
    220(单相)
    <input name="checkbox59" type="checkbox" />
    T 特殊</td>
  </tr>
  <tr>
    <td>016 出入口宽(mm):
    <input name="checkbox60" type="checkbox" />
    700
    <input name="checkbox61" type="checkbox" />
    800
    <input name="checkbox62" type="checkbox" />
    T 特殊</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>017 出入口高(mm):
    <input name="checkbox63" type="checkbox" />
    标准2000
    <input name="checkbox633" type="checkbox" />
    选项2100
    <input name="checkbox634" type="checkbox" />
    T 特殊</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>018 门口配置型式:    
      <input name="checkbox632" type="checkbox" />
S 单出入口
<input name="checkbox642" type="checkbox" />
D 双出入口
<input name="checkbox652" type="checkbox" />
TH 贯通门
<input name="checkbox662" type="checkbox" />
T 特殊</td>
    <td>&nbsp;</td>
  </tr>
</table>
                                                    <!-- 整机规格 -->
                                                </div>
                                                <div id="tab-2" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computePart(this)">
                                                    <!-- 轿厢规格-->
                                                    <table width="973" height="340" border="1" cellspacing="0">
                                                      <tr>
                                                        <td colspan="2">轿厢规格</td>
                                                      </tr>
                                                      
                                                      <tr>
                                                        <td colspan="2">300 轿厢地板:
                                                          <input name="checkbox63" type="checkbox" />
                                                    PVC 塑胶地砖(标准)
                                                    <input name="checkbox632" type="checkbox" />
                                                    MBL 20mm大理石(选项规格)
                                                    <input name="checkbox633" type="checkbox" />
                                                    T特殊</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="2">地板样式编码:(1)标准PVC规格:
                                                          <input name="checkbox634" type="checkbox" />
                                                    A DBF-01
                                                    <input name="checkbox635" type="checkbox" />
                                                    B DBF-02
                                                    <input name="checkbox636" type="checkbox" />
                                                    C DBF-05
                                                    <input name="checkbox637" type="checkbox" />
                                                    D DBF-06 (2) 单色大理石选项规格:
                                                    <input name="checkbox638" type="checkbox" />
                                                    E DBF-11
                                                    <input name="checkbox639" type="checkbox" />
                                                    F DBF-12
                                                    <input name="checkbox6310" type="checkbox" />
                                                    G DBF-13
                                                    <input name="checkbox6311" type="checkbox" />
                                                    H DBF-16 </td>
                                                      </tr>
                                                      <tr>
                                                        <td>400 吊顶型号:(1)标配规格(不锈钢镜面):
                                                        <input name="checkbox6352" type="checkbox" />
                                                        A DBD-01
                                                        <input name="checkbox6353" type="checkbox" />
                                                        B DBD-05
                                                        <input name="checkbox6354" type="checkbox" />
                                                        C DBD-82 
                                                        <input name="checkbox6355" type="checkbox" />
                                                        T</td>
                                                        <td>408 明镜型式:
                                                        <input name="checkbox6356" type="checkbox" />
                                                        N 
                                                        <input name="checkbox6357" type="checkbox" />
                                                        A 后侧明镜 
                                                        <input name="checkbox6358" type="checkbox" />
                                                        T</td>
                                                      </tr>
                                                      <tr>
                                                        <td>(2)选项规格(钛金镜面):
                                                        <input name="checkbox6359" type="checkbox" />
                                                        D DBD-09 
                                                        <input name="checkbox63510" type="checkbox" />
                                                        F DBD-16
                                                        <input name="checkbox63511" type="checkbox" />
                                                        G DBD-83 
                                                        <input name="checkbox63512" type="checkbox" />
                                                        T</td>
                                                        <td>明镜规格:
                                                        <input name="checkbox63513" type="checkbox" />
                                                        A 半高明镜
                                                        <input name="checkbox63514" type="checkbox" />
                                                        A 全高明镜 
                                                        <input name="checkbox63515" type="checkbox" />
                                                        T</td>
                                                      </tr>
                                                      <tr>
                                                        <td>401 轿门规格:
                                                        <input name="checkbox63516" type="checkbox" />
                                                        SUS发纹(标准)
                                                        <input name="checkbox63517" type="checkbox" />
                                                        SPP喷漆
                                                        <input name="checkbox63518" type="checkbox" />
                                                        其它选项规格 
                                                        <input name="checkbox63519" type="checkbox" />
                                                        T</td>
                                                        <td>409 观光梯型式:
                                                        <input name="checkbox63520" type="checkbox" />
                                                        A 半圆观光 
                                                        <input name="checkbox63521" type="checkbox" />
                                                        B 一面观光
                                                        <input name="checkbox63522" type="checkbox" />
                                                        C两面观光
                                                        <input name="checkbox63523" type="checkbox" />
                                                        D 三面观光 
                                                        <input name="checkbox63524" type="checkbox" />
                                                        T</td>
                                                      </tr>
                                                      <tr>
                                                        <td>喷漆颜色:
                                                        <input name="checkbox63525" type="checkbox" />
                                                        A RAL7032
                                                        <input name="checkbox63526" type="checkbox" />
                                                        B RAL7035 </td>
                                                        <td>观光轿厢型号:
                                                        <input name="checkbox63527" type="checkbox" />
                                                        N
                                                        <input name="checkbox63528" type="checkbox" />
                                                        T</td>
                                                      </tr>
                                                      <tr>
                                                        <td>选项型号:
                                                        <input name="checkbox63529" type="checkbox" />
                                                        C DBM-108
                                                        <input name="checkbox63530" type="checkbox" />
                                                        D DBM-110
                                                        <input name="checkbox63531" type="checkbox" />
                                                        E DBM-111
                                                        <input name="checkbox63532" type="checkbox" />
                                                        F DBM-112
                                                        <input name="checkbox63533" type="checkbox" />
                                                        G DBM-114 </td>
                                                        <td>观光梯外围部件颜色:
                                                          <input name="checkbox63535" type="checkbox" />
                                                          RAL7039 灰色
                                                        <input name="checkbox63534" type="checkbox" />
                                                        RAL9010 象牙白
                                                        <input name="checkbox63536" type="checkbox" />
                                                        T</td>
                                                      </tr>
                                                      <tr>
                                                        <td><input name="checkbox63537" type="checkbox" />
                                                          H DBM-115 
                                                          <input name="checkbox63538" type="checkbox" />
                                                          I DBM-126
                                                          <input name="checkbox63539" type="checkbox" />
                                                          J DBM-128 </td>
                                                        <td>500 轿厢操纵箱:单独盒式:
                                                        <input name="checkbox63540" type="checkbox" />
                                                        A COP500(标准)
                                                        <input name="checkbox63541" type="checkbox" />
                                                        B COP505ME(镜面独刻) </td>
                                                      </tr>
                                                      <tr>
                                                        <td>402 轿厢规格:
                                                        <input name="checkbox63542" type="checkbox" />
                                                        SUS发纹(标准)
                                                        <input name="checkbox63543" type="checkbox" />
                                                        SPP喷漆
                                                        <input name="checkbox63544" type="checkbox" />
                                                        其它选项规格
                                                        <input name="checkbox63545" type="checkbox" />
                                                        T</td>
                                                        <td><input name="checkbox63546" type="checkbox" />
                                                          C COP505TE(钛金独刻)
                                                          <input name="checkbox63547" type="checkbox" />
                                                          D COP501ME(镜面蚀刻)
                                                          <input name="checkbox63548" type="checkbox" />
                                                          E COP502TE(钛金蚀刻)
                                                          <input name="checkbox63549" type="checkbox" />
                                                          T</td>
                                                      </tr>
                                                      <tr>
                                                        <td>喷漆颜色:
                                                          <input name="checkbox635252" type="checkbox" />
                                                    A RAL7032
                                                    <input name="checkbox635262" type="checkbox" />
                                                    B RAL7035 
                                                    <input name="checkbox6352622" type="checkbox" />
                                                    T</td>
                                                        <td>前壁一体式:
                                                        <input name="checkbox6352623" type="checkbox" />
                                                        FCOP520(喷漆,同前壁)
                                                        <input name="checkbox6352624" type="checkbox" />
                                                        G COP520S(发纹)
                                                        <input name="checkbox6352625" type="checkbox" />
                                                        T</td>
                                                      </tr>
                                                      <tr>
                                                        <td>选项型号:
                                                        <input name="checkbox6352626" type="checkbox" />
                                                        C DLC-43
                                                        <input name="checkbox6352627" type="checkbox" />
                                                        D DLC-97
                                                        <input name="checkbox6352628" type="checkbox" />
                                                        E DLC-99
                                                        <input name="checkbox6352629" type="checkbox" />
                                                        F DLC-100
                                                        <input name="checkbox63526210" type="checkbox" />
                                                        G DLC-102 </td>
                                                        <td>502 轿厢显示:
                                                        <input name="checkbox63526211" type="checkbox" />
                                                        A 点阵显示(标准) 
                                                        <input name="checkbox63526212" type="checkbox" />
                                                        B 蓝液晶显示(选配)
                                                        <input name="checkbox63526213" type="checkbox" />
                                                        T</td>
                                                      </tr>
                                                      <tr>
                                                        <td><input name="checkbox63526214" type="checkbox" />
                                                          H DLC-103
                                                            <input name="checkbox63526215" type="checkbox" />
                                                            I DLC-104
                                                            <input name="checkbox63526216" type="checkbox" />
                                                            J DLC-115
                                                            <input name="checkbox63526217" type="checkbox" />
                                                            K DLC-120
                                                            <input name="checkbox63526218" type="checkbox" />
                                                            L DLC-122 </td>
                                                        <td>600 主要标准功能:1,光木保护; 2,超载保护; 3,超速保护; 4,放打滑保护; </td>
                                                      </tr>
                                                      <tr>
                                                        <td>403 前壁规格:
                                                        <input name="checkbox63526219" type="checkbox" />
                                                        SUS 发纹(标准)
                                                        <input name="checkbox63526220" type="checkbox" />
                                                        啥品牌喷漆
                                                        <input name="checkbox63526221" type="checkbox" />
                                                        MIR不锈钢镜面
                                                        <input name="checkbox63526222" type="checkbox" />
                                                        TM钛金镜面</td>
                                                        <td>6,层门机电联锁保护; 7,门锁异常保护; 8,门区外不开门保护; </td>
                                                      </tr>
                                                      <tr>
                                                        <td><input name="checkbox63526226" type="checkbox" />
                                                          CLST化妆钢板
                                                          <input name="checkbox63526227" type="checkbox" />
                                                          RM玫瑰金镜面
                                                          <input name="checkbox63526228" type="checkbox" />
                                                          T</td>
                                                        <td>9,电机过热保护; 10,运行超时保护; 11,逆向运行保护 </td>
                                                      </tr>
                                                      <tr>
                                                        <td>式样规格:
                                                        <input name="checkbox63526229" type="checkbox" />
                                                        A RAL7032
                                                        <input name="checkbox63526230" type="checkbox" />
                                                        B RAL7035</td>
                                                        <td>12,终端限位保护; 13,主回路故障保护; 14,断/错相保护; </td>
                                                      </tr>
                                                      <tr>
                                                        <td><input name="checkbox63526231" type="checkbox" />
                                                          C B108胡桃木纹 
                                                          <input name="checkbox63526232" type="checkbox" />
                                                          D C108金葱木纹
                                                          <input name="checkbox63526233" type="checkbox" />
                                                          E C127金丝铂 </td>
                                                        <td>15,一键呼叫功能; 16,停电应急照明功能; 17,轿厢节点控制功能; </td>
                                                      </tr>
                                                      <tr>
                                                        <td>405 扶手型式:
                                                        <input name="checkbox63526234" type="checkbox" />
                                                        N
                                                        <input name="checkbox63526236" type="checkbox" />
                                                        A 后侧扶手
                                                        <input name="checkbox63526235" type="checkbox" />
                                                        T</td>
                                                        <td>800 选项功能:
                                                        <input name="checkbox63526223" type="checkbox" />
                                                        A远程服务功能 
                                                        <input name="checkbox63526224" type="checkbox" />
                                                        B 公共层专用控制,公共层()楼</td>
                                                      </tr>
                                                      <tr>
                                                        <td>406 扶手型号:
                                                          <input name="checkbox63526237" type="checkbox" />
                                                    A JF-FS-02
                                                    <input name="checkbox63526238" type="checkbox" />
                                                    B JF-FS-03
                                                    <input name="checkbox63526239" type="checkbox" />
                                                    C JF-FS-04
                                                    <input name="checkbox63526240" type="checkbox" />
                                                    D JF-FS-05
                                                    <input name="checkbox63526241" type="checkbox" />
                                                    T</td>
                                                        <td><input name="checkbox63526225" type="checkbox" />
                                                    C停电自动平层(ARD)功能</td>
                                                      </tr>
                                                      <tr>
                                                        <td>407 轿厢是否预留装修(重量):
                                                          <input name="checkbox6352622532" type="checkbox" />
                                                          Y()kg
                                                          <input name="checkbox635262253" type="checkbox" />
                                                    N</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                    </table>
                                                    <!-- 轿厢规格 -->
                                                </div>
                                                <div id="tab-3" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computeStd(this)">
                                                    <!-- 机能 -->
                                                    <table width="949" border="1" cellspacing="0">
                                                      <tr>
                                                        <td colspan="2">机能</td>
                                                      </tr>
                                                      <tr>
                                                        <td width="463">700 联络设置:
                                                        <input name="checkbox635262253" type="checkbox" />
                                                        A 单台 
                                                        <input name="checkbox6352622532" type="checkbox" />
                                                        B 多台(需提供数量)
                                                        <input name="checkbox6352622533" type="checkbox" />
                                                        C 分组(需具体描述)
                                                        <input name="checkbox6352622534" type="checkbox" />
                                                        T</td>
                                                        <td width="476">703 操作方式:
                                                        <input name="checkbox6352622535" type="checkbox" />
                                                        A自动
                                                        <input name="checkbox6352622536" type="checkbox" />
                                                        B轿内刷卡
                                                        <input name="checkbox6352622537" type="checkbox" />
                                                        C厅外刷卡,刷卡楼层()</td>
                                                      </tr>
                                                      <tr>
                                                        <td>701 对讲系统:
                                                        <input name="checkbox6352622538" type="checkbox" />
                                                        A四方通话
                                                        <input name="checkbox6352622539" type="checkbox" />
                                                        B五方通话
                                                        <input name="checkbox63526225310" type="checkbox" />
                                                        T</td>
                                                        <td><input name="checkbox63526225311" type="checkbox" />
                                                          D轿内指纹识别
                                                          <input name="checkbox63526225312" type="checkbox" />
                                                          E厅外指纹识别,控制楼层:()</td>
                                                      </tr>
                                                      <tr>
                                                        <td>702 基站位置(楼名):
                                                        <input name="checkbox63526225313" type="checkbox" />
                                                        Y(1F)楼
                                                        <input name="checkbox63526225314" type="checkbox" />
                                                        N</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                    </table>
                                                    <!-- 机能 -->
                                                </div>
                                                <div id="tab-4" class="tab-pane">
                                                    <input type="button" value="确定" onclick="computeOpt(this)">
                                                    <!-- 层站规格 -->
                                                    <table width="972" height="419" border="1" cellspacing="0">
                                                      <tr>
                                                        <td colspan="12">层站规格</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="11">200 外呼显示:
                                                          <input name="checkbox635262253" type="checkbox" />
                                                    A点阵显示(标准)
                                                    <input name="checkbox6352622532" type="checkbox" />
                                                    B蓝白液晶显示
                                                    <input name="checkbox6352622533" type="checkbox" />
                                                    T</td>
                                                        <td width="15">&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="12">201 外呼盒型号: 无底盒形式:
                                                          <input name="checkbox6352622534" type="checkbox" />
                                                    A发纹不锈钢HOP520S(标准)
                                                    <input name="checkbox6352622535" type="checkbox" />
                                                    B镜面不锈钢HOP520M
                                                    <input name="checkbox6352622536" type="checkbox" />
                                                    T</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="12">有底盒形式:
                                                          <input name="checkbox6352622537" type="checkbox" />
                                                    C HOP500(发纹)
                                                    <input name="checkbox6352622538" type="checkbox" />
                                                    D HOP505ME(镜面蚀刻)
                                                    <input name="checkbox6352622539" type="checkbox" />
                                                    E HOP505TE(钛金蚀刻)
                                                    <input name="checkbox63526225310" type="checkbox" />
                                                    F HOP501ME(镜面蚀刻)
                                                    <input name="checkbox63526225311" type="checkbox" />
                                                    G HOP502TE(钛金蚀刻)
                                                    <input name="checkbox63526225312" type="checkbox" />
                                                    T</td>
                                                      </tr>
                                                      <tr>
                                                        <td width="95" rowspan="7">层站规格必须填写的项</td>
                                                        <td colspan="2">喷漆颜色可填写项</td>
                                                        <td width="106">小门套材质规格</td>
                                                        <td width="91">小门套式样</td>
                                                        <td width="125">厅门材质规格</td>
                                                        <td colspan="2">厅门式样选项型号</td>
                                                        <td width="244">出入口方向</td>
                                                        <td width="10">&nbsp;</td>
                                                        <td width="10">&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="2">RAL7032:卵石灰</td>
                                                        <td>SUS:发纹(标准)</td>
                                                        <td>B108:胡桃木纹</td>
                                                        <td>SUS:发纹(标准)</td>
                                                        <td width="61">DBM-108</td>
                                                        <td width="56">DBM-126</td>
                                                        <td>F:前方</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="2">RAL7035:浅灰色</td>
                                                        <td>MIR:不锈钢镜面</td>
                                                        <td>C105:金葱木纹</td>
                                                        <td>MIR:不锈钢镜面蚀刻</td>
                                                        <td>DBM-110</td>
                                                        <td>DBM-128</td>
                                                        <td>B:后方</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="2">&nbsp;</td>
                                                        <td>TM:钛金镜面</td>
                                                        <td>&nbsp;</td>
                                                        <td>TM:钛金镜面蚀刻</td>
                                                        <td>DBM-111</td>
                                                        <td>&nbsp;</td>
                                                        <td>L:左侧</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="2">&nbsp;</td>
                                                        <td>RM:玫瑰金镜面</td>
                                                        <td>&nbsp;</td>
                                                        <td>RM:玫瑰金镜面蚀刻</td>
                                                        <td>DBM-112</td>
                                                        <td>&nbsp;</td>
                                                        <td>R:右侧</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td colspan="2">&nbsp;</td>
                                                        <td>CLST:化妆钢板</td>
                                                        <td>&nbsp;</td>
                                                        <td>CLST:化妆钢板</td>
                                                        <td>DBM-114</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td width="56">N:不要</td>
                                                        <td width="53">T:特殊</td>
                                                        <td>SPP:喷漆</td>
                                                        <td>&nbsp;</td>
                                                        <td>SPP:喷漆</td>
                                                        <td>DBM-115</td>
                                                        <td>&nbsp;</td>
                                                        <td>T:特殊</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td rowspan="2">楼名</td>
                                                        <td rowspan="2">楼高参数(mm)</td>
                                                        <td rowspan="2">停站名(显示名)</td>
                                                        <td colspan="2">小门套(202)</td>
                                                        <td colspan="3">厅门(203)</td>
                                                        <td rowspan="2">出入口方向(204)</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>材质</td>
                                                        <td>式样编码</td>
                                                        <td>材质</td>
                                                        <td colspan="2">式样编码</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>-1F</td>
                                                        <td>3000</td>
                                                        <td>B</td>
                                                        <td>SUS</td>
                                                        <td>\</td>
                                                        <td>SUS</td>
                                                        <td colspan="2">\</td>
                                                        <td>F</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>1F</td>
                                                        <td>3000</td>
                                                        <td>1</td>
                                                        <td>SUS</td>
                                                        <td>\</td>
                                                        <td>SUS</td>
                                                        <td colspan="2">\</td>
                                                        <td>F</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>2F</td>
                                                        <td>3000</td>
                                                        <td>2</td>
                                                        <td>SUS</td>
                                                        <td>\</td>
                                                        <td>SUS</td>
                                                        <td colspan="2">\</td>
                                                        <td>F</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>3F</td>
                                                        <td>3000</td>
                                                        <td>3</td>
                                                        <td>SUS</td>
                                                        <td>\</td>
                                                        <td>SUS</td>
                                                        <td colspan="2">\</td>
                                                        <td>F</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>4F</td>
                                                        <td>2900</td>
                                                        <td>4</td>
                                                        <td>SUS</td>
                                                        <td>\</td>
                                                        <td>SUS</td>
                                                        <td colspan="2">\</td>
                                                        <td>F</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td colspan="2">&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td colspan="2">&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                    </table>
                                                    <!-- 选配参数 -->
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
