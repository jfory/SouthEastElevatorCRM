<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld"%>
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
	<link href="static/css/select2/select2.min.css" rel="stylesheet">
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
	<script src="static/js/select2/select2.min.js"></script>
    <script src="static/js/installioncount.js?v=1.2"></script>
    <script type="text/javascript">
        var basePath="<%=basePath%>";
        var itemelecount="${itemelecount}";
        var basisDate = {
        		'fbdj':null
        }
    </script>
</head>

<body class="gray-bg">
    <div id="cbjView" class="animated fadeIn"></div>
    <div id="zhjView" class="animated fadeIn"></div>
    <form action="e_offer/${msg}.do" name="feiyangxfForm" id="feiyangxfForm" method="post">
        <input type="hidden" name="ele_type" id="ele_type" value="DT6">
    <input type="hidden" name="view" id="view" value="${pd.view}">
    <input type="hidden" name="BJC_ID" id="BJC_ID" value="${pd.BJC_ID}">
    <input type="hidden" name="offer_version" id="offer_version" value="${pd.offer_version}">
    <input type="hidden" name="FEIYANGXF_ID" id="FEIYANGXF_ID" value="${pd.FEIYANGXF_ID}">
    <input type="hidden" name="FLAG" id="FLAG" value="${FLAG}">
    <input type="hidden" name="rowIndex" id="rowIndex" value="${pd.rowIndex}">
    <input type="hidden" name="UNSTD" id="UNSTD" value="${pd.UNSTD}">
    <input type="hidden" name="MODELS_ID" id="MODELS_ID" value="${pd.MODELS_ID}">
    <input type="hidden" name="ITEM_ID" id="ITEM_ID" value="${pd.ITEM_ID}">
    <input type="hidden" name="ELEV_IDS" id="ELEV_IDS" value="${pd.ELEV_IDS}">
<%--     <input type="hidden" name="YJSYZKL" id="YJSYZKL" value="${pd.YJSYZKL}"> --%>
    <input type="hidden" name="ZGYJ" id="ZGYJ" value="${pd.ZGYJ}">
    <div class="" style="z-index: -1;margin-top: -20px;">
        <div class="row">
            <div class="col-sm-12" >
                <div class="">
                    <div class="">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                                                                                                      报价信息
                                        <c:if test="${forwardMsg!='view'}">
                                            <input type="button" value="装潢价格" onclick="selZhj();" class="btn-sm btn-success">
                                            <input type="button" value="调用参考报价" onclick="selCbj();" class="btn-sm btn-success">
                                        </c:if>
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>梯种</label>
                                            <input style="width:20%;" class="form-control" id="tz_" type="text"
									        name="tz_" value="${modelsPd.models_name }" placeholder="这里输入型号名称" required="required">
                                            <!-- <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="tz_" name="tz_">
                                                <option value="飞扬消防梯">飞扬消防梯</option>
                                            </select> -->
                                          
                                          <!-- 新增显示 -->  
                                          <c:if test="${pd.view== 'save' }">
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>载重(kg):</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_ZZ" name="BZ_ZZ" onchange="editZz()" required="required">
                                                <option value="">请选择</option>
                                                <option value="800" ${regelevStandardPd.ZZ=='800'?'selected':''}>800</option>
                                                <option value="1000" ${regelevStandardPd.ZZ=='1000'?'selected':''}>1000</option>
                                                <option value="1150" ${regelevStandardPd.ZZ=='1150'?'selected':''}>1150</option>
                                                <option value="1350" ${regelevStandardPd.ZZ=='1350'?'selected':''}>1350</option>
                                                <option value="1600" ${regelevStandardPd.ZZ=='1600'?'selected':''}>1600</option>
                                                <option value="2000" ${regelevStandardPd.ZZ=='2000'?'selected':''}>2000</option>
                                            </select>
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>速度(m/s):</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_SD" name="BZ_SD" onchange="editSd();" required="required">
                                                <option value="">请选择</option>
                                                <option value="1.0" ${regelevStandardPd.SD=='1.0'?'selected':''}>1.0</option>
                                                <option value="1.5" ${regelevStandardPd.SD=='1.5'?'selected':''}>1.5</option>
                                                <option value="1.75" ${regelevStandardPd.SD=='1.75'?'selected':''}>1.75</option>
                                                <option value="2.0" ${regelevStandardPd.SD=='2.0'?'selected':''}>2.0</option>
                                                <option value="2.5" ${regelevStandardPd.SD=='2.5'?'selected':''}>2.5</option>
                                            </select>
                                        </div>

                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>开门形式</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_KMXS" name="BZ_KMXS" onchange="SetKMXS()" required="required">
                                                <option value="中分" ${regelevStandardPd.KMXS=='中分'?'selected':''}>中分</option>
                                                <option value="左旁开" ${regelevStandardPd.KMXS=='左旁开'?'selected':''}>左旁开</option>
                                                <option value="右旁开" ${regelevStandardPd.KMXS=='右旁开'?'selected':''}>右旁开</option>
                                                <option value="中分双折" ${regelevStandardPd.KMXS=='中分双折'?'selected':''}>中分双折</option>
                                                <option value="中分三折" ${regelevStandardPd.KMXS=='中分三折'?'selected':''}>中分三折</option>
                                                <option value="其他" ${regelevStandardPd.KMXS=='其他'?'selected':''}>其他</option>
                                            </select>

                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>开门宽度:</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_KMKD" name="BZ_KMKD" onchange="setMPrice();" required="required">
                                                <option value="">请选择</option>
                                                <option value="其他">其他</option>
                                                <option value="800">800</option>
                                                <option value="900">900</option>
                                                <option value="1100">1100</option>
                                            </select>
                                            <label style="width:11%;margin-bottom: 10px">层站门:</label>
                                            <select class="form-control" style="width:7%" name="BZ_C" id="BZ_C" onchange="editC();$('#ELE_C').html(this.value);$('#BZ_Z').change();$('#BZ_M').change()">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control" style="width:7%" name="BZ_Z" id="BZ_Z" onchange="setSbj();$('#ELE_Z').html(this.value)">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control" style="width:7%" name="BZ_M" id="BZ_M" onchange="setMPrice();$('#ELE_M').html(this.value)">
                                                <option value="">请选择</option>
                                            </select>
                                            
                                          </c:if>
                                          <input type="hidden" name="BZ_M_TEMP" id="BZ_M_TEMP">
                                          <!-- 编辑显示 -->  
                                          <c:if test="${pd.view== 'edit' }">
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>载重(kg):</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_ZZ" name="BZ_ZZ" onchange="editZz()" required="required">
                                                <option value="">请选择</option>
                                                <option value="800" ${pd.BZ_ZZ=='800'?'selected':''}>800</option>
                                                <option value="1000" ${pd.BZ_ZZ=='1000'?'selected':''}>1000</option>
                                                <option value="1150" ${pd.BZ_ZZ=='1150'?'selected':''}>1150</option>
                                                <option value="1350" ${pd.BZ_ZZ=='1350'?'selected':''}>1350</option>
                                                <option value="1600" ${pd.BZ_ZZ=='1600'?'selected':''}>1600</option>
                                                <option value="2000" ${pd.BZ_ZZ=='2000'?'selected':''}>2000</option>
                                            </select>
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>速度(m/s):</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_SD" name="BZ_SD" onchange="editSd();" required="required">
                                                <option value="">请选择</option>
                                                <option value="1.0" ${pd.BZ_SD=='1.0'?'selected':''}>1.0</option>
                                                <option value="1.5" ${pd.BZ_SD=='1.5'?'selected':''}>1.5</option>
                                                <option value="1.75" ${pd.BZ_SD=='1.75'?'selected':''}>1.75</option>
                                                <option value="2.0" ${pd.BZ_SD=='2.0'?'selected':''}>2.0</option>
                                                <option value="2.5" ${pd.BZ_SD=='2.5'?'selected':''}>2.5</option>
                                            </select>
                                        </div>

                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>开门形式</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_KMXS" name="BZ_KMXS" onchange="SetKMXS()" required="required">
                                                <option value="中分" ${pd.BZ_KMXS=='中分'?'selected':''}>中分</option>
                                                <option value="左旁开" ${pd.BZ_KMXS=='左旁开'?'selected':''}>左旁开</option>
                                                <option value="右旁开" ${pd.BZ_KMXS=='右旁开'?'selected':''}>右旁开</option>
                                                <option value="中分双折" ${pd.BZ_KMXS=='中分双折'?'selected':''}>中分双折</option>
                                                <option value="中分三折" ${pd.BZ_KMXS=='中分三折'?'selected':''}>中分三折</option>
                                                <option value="其他" ${pd.BZ_KMXS=='其他'?'selected':''}>其他</option>
                                            </select>

                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>开门宽度:</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_KMKD" name="BZ_KMKD" onchange="setMPrice();" required="required">
                                                <option value="">请选择</option>
                                                <option value="其他" ${pd.BZ_KMKD=='其他'?'selected':''}>其他</option>
                                                <option value="800" ${pd.BZ_KMKD=='800'?'selected':''}>800</option>
                                                <option value="900" ${pd.BZ_KMKD=='900'?'selected':''}>900</option>
                                                <option value="1100" ${pd.BZ_KMKD=='1100'?'selected':''}>1100</option>
                                            </select>
                                            <label style="width:11%;margin-bottom: 10px">层站门:</label>
                                            <select class="form-control" style="width:7%" name="BZ_C" id="BZ_C" onchange="editC();$('#ELE_C').html(this.value);$('#BZ_Z').change();$('#BZ_M').change()">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control" style="width:7%" name="BZ_Z" id="BZ_Z" onchange="setSbj();$('#ELE_Z').html(this.value)">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control" style="width:7%" name="BZ_M" id="BZ_M" onchange="setMPrice();$('#ELE_M').html(this.value)">
                                                <option value="">请选择</option>
                                            </select>
                                          </c:if>
                                          
                                        </div>
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px">数量:</label>
                                            <input type="text" class="form-control" id="FEIYANGXF_SL" name="FEIYANGXF_SL" value="${pd.FEIYANGXF_SL}" readonly="readonly" style="width:20%;">
                                            <input type="hidden" class="form-control" id="DT_SL" name="DT_SL" value="${pd.FEIYANGXF_SL}" readonly="readonly" style="width:20%;"> 
                                            <label style="width:11%;margin-bottom: 10px">单价:</label>
                                            <input type="text" class="form-control" id="DANJIA" name="DANJIA" value="${regelevStandardPd.PRICE}" readonly="readonly" style="width:20%;">

                                            <input type="hidden" class="form-control" id="FEIYANGXF_ZK" name="FEIYANGXF_ZK" value="${pd.FEIYANGXF_ZK}" onkeyup="countZhj();">
                                            
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>土建图图号:</label>
											<input type="text" class="form-control" id="TJTTH" name="TJTTH" required="required" value="${pd.TJTTH}" style="width:20%;">
                                           
                                        </div>
                                        <div class="form-group form-inline">
											<label style="width:11%;margin-bottom: 10px">佣金使用折扣率:</label>
											<input style="width: 20%;" type="text" class="form-control" name="YJSYZKL" id="YJSYZKL" readonly="readonly" value="${pd.YJSYZKL}">
											<label class="intro" style="color: red;display: none;" id="DANJIA_Label">开门宽度非标,减门价格请非标询价</label>
											
										</div>
                                        
                                        <div class="form-group form-inline">
                                            <table class="table table-striped table-bordered table-hover" id="tab" name="tab">
                                                <tr bgcolor="#CCCCCC">
                                                    <th>基价</th>
                                                    <th>选项加价</th>
                                                    <th>折前价</th>
                                                    <th>非标价</th>
                                                    <th>其他费用</th>
                                                    <th>佣金总额</th>
                                                    <!-- <th>是否超标</th> -->
                                                    <th>折扣率(%)</th>
                                                    <th>草签实际单价</th>
                                                    <th>设备实际总价</th>
                                                    <!-- <th>比例(%)</th> -->
                                                    <th>安装费</th>
                                                    <th>运输费</th>
                                                    <th>总报价</th>
                                                </tr>
                                                <tr>
                                                   <!-- 基价 -->
                                                    <td>
                                                      <%-- <input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEISHANG_SBJ" id="FEISHANG_SBJ" value="${regelevStandardPd.PRICE}"> --%>
                                                      <input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px" 
                                                          name="SBJ_TEMP" id="SBJ_TEMP" readonly="readonly" value="${regelevStandardPd.PRICE*pd.FEIYANGXF_SL}">
                                                    </td>
                                                    <!-- 选项加价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="FEIYANG_XF_XXJJ" id="FEIYANG_XF_XXJJ" readonly="readonly" value="${pd.FEIYANG_XF_XXJJ}"></td>
                                                    <!-- 折前价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="FEIYANG_XF_ZQJ" id="FEIYANG_XF_ZQJ" readonly="readonly" value="${pd.FEIYANG_XF_ZQJ}"></td>
                                                    <!-- 非标价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="FEIYANG_XF_FBJ" id="FEIYANG_XF_FBJ" readonly="readonly" value="${pd.FEIYANG_XF_FBJ}">
                                                    </td>
                                                    <!-- 其他费用 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;background-color:yellow;"
                                                         name="FEIYANG_XF_QTFY" id="FEIYANG_XF_QTFY" onkeyup="JS_SJBJ();" value="${pd.FEIYANG_XF_QTFY}">
                                                    </td>
                                                    <!-- 佣金总额 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;background-color:yellow;"
                                                         name="FEIYANG_XF_YJZE" id="FEIYANG_XF_YJZE" onkeyup="JS_SJBJ();" value="${pd.FEIYANG_XF_YJZE}">
                                                    </td>
                                                    <!-- 是否超标 -->
                                                    <input type="hidden" style="width:45px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="FEIYANG_XF_SFCB" id="FEIYANG_XF_SFCB" value="${pd.FEIYANG_XF_SFCB}" readonly="readonly">
                                                   <%--  <td><input type="text" style="width:45px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="FEIYANG_XF_SFCB" id="FEIYANG_XF_SFCB" value="${pd.FEIYANG_XF_SFCB}" readonly="readonly">
                                                    </td> --%>
                                                    <!-- 折扣率 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="FEIYANG_XF_ZKL" id="FEIYANG_XF_ZKL" value="${pd.FEIYANG_XF_ZKL}" readonly="readonly">
                                                    </td>
                                                    <!-- 草签实际单价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;background-color:yellow;"
                                                     name="FEIYANG_XF_CQSJDJ" id="FEIYANG_XF_CQSJDJ" onkeyup="JS_SJBJ();" value="${pd.FEIYANG_XF_CQSJDJ}"></td>
                                                    <!-- 设备实际报价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="FEIYANG_XF_SBSJBJ" id="FEIYANG_XF_SBSJBJ" readonly="readonly" value="${pd.FEIYANG_XF_SBSJBJ}"></td>
                                                    <!-- 比例 -->
                                                    <input type="hidden" style="width:45px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="FEIYANG_XF_YJBL" id="FEIYANG_XF_YJBL" value="${pd.FEIYANG_XF_YJBL}" readonly="readonly">
                                                   <%--  <td><input type="text" style="width:45px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="FEIYANG_XF_YJBL" id="FEIYANG_XF_YJBL" value="${pd.FEIYANG_XF_YJBL}" readonly="readonly">
                                                    </td> --%>
                                                    <!-- 安装费 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="FEIYANG_XF_AZJ" id="FEIYANG_XF_AZJ" value="${pd.FEIYANG_XF_AZJ}" readonly="readonly">
                                                    </td>
                                                    <!-- 运输费 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="FEIYANG_XF_YSJ" id="FEIYANG_XF_YSJ" value="${pd.FEIYANG_XF_YSJ}" readonly="readonly">
                                                    </td>
                                                    <!-- 总报价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="FEIYANG_XF_TATOL" id="FEIYANG_XF_TATOL" value="${pd.FEIYANG_XF_TATOL}" readonly="readonly">
                                                    </td>
                                                </tr>
                                            </table>
                                              <input type="hidden" name="FEIYANGXF_ZHJ" id="FEIYANGXF_ZHJ" value="${pd.FEIYANGXF_ZHJ}">
                                              <input type="hidden" name="FEIYANGXF_SBJ" id="FEIYANGXF_SBJ" value="${regelevStandardPd.PRICE}">
                                              <%-- <input type="hidden" name="SBJ_TEMP" id="SBJ_TEMP" value="${regelevStandardPd.PRICE}"> --%>
                                              <span id="zk_">${pd.FEIYANGXF_ZK}</span>
                                              <input type="hidden" name="FEIYANGXF_ZHSBJ" id="FEIYANGXF_ZHSBJ" value="${pd.FEIYANGXF_ZHSBJ}">
                                              <input type="hidden" name="FEIYANGXF_AZF" id="FEIYANGXF_AZF" value="${pd.FEIYANGXF_AZF}"/>
                                              <input type="hidden" name="FEIYANGXF_YSF" id="FEIYANGXF_YSF" value="${pd.FEIYANGXF_YSF}">
                                              <input type="hidden" name="FEIYANGXF_SJBJ" id="FEIYANGXF_SJBJ" value="${pd.FEIYANGXF_SJBJ}">
                                        </div>

                                        <div class="form-group form-inline">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#tab-1" class="active">基本参数</a></li> 
                                                <li class=""><a data-toggle="tab" href="#tab-2">标准功能</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-3">可选功能</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-4">单组监控室对讲系统</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-5">轿厢装潢</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-6">厅门门套</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-7">操纵盘</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-8">厅门信号装置</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-9">非标</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-10">常规非标</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div id="tab-1" class="tab-pane">
                                                    <!-- 基本参数 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td width="173">控制系统</td>
                                                            <td colspan="2">
                                                                <select name="BASE_KZXT" id="BASE_KZXT" class="form-control" >
                                                                    <option value="STEP">STEP</option>
                                                                </select>
                                                            </td>
                                                            <td width="180">加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>控制方式</td>
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_KZFS" value="单台(G1C)" onclick="KZFS_TEMP('1');" ${pd.BASE_KZFS=='单台(G1C)'?'checked':''}/>
                                                                单台(G1C)
                                                                <input type="radio" name="BASE_KZFS" value="两台并联(G2C)" onclick="KZFS_TEMP('2');" ${pd.BASE_KZFS=='两台并联(G2C)'?'checked':''}/>
                                                                两台并联(G2C)
                                                                <input type="radio" name="BASE_KZFS" value="三台群控(G3C)" onclick="KZFS_TEMP('3');" ${pd.BASE_KZFS=='三台群控(G3C)'?'checked':''}/>
                                                                三台群控(G3C)
                                                                <input type="radio" name="BASE_KZFS" value="四台群控(G4C)" onclick="KZFS_TEMP('4');" ${pd.BASE_KZFS=='四台群控(G4C)'?'checked':''}/>
                                                                四台群控(G4C)&nbsp;&nbsp;<label style="color: red;">四台以上请非标询价</label>   
                                                            </td>
                                                            <td><input type="text" name="BASE_KZFS_TEMP" id="BASE_KZFS_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>曳引主机</td>
                                                            <td colspan="2">
                                                                <select name="BASE_YYZJ" id="BASE_YYZJ" class="form-control" >
                                                                    <option value="">请选择</option>
                                                                    <option value="西子富沃德(800-1600标准)" ${pd.BASE_YYZJ=='西子富沃德(800-1600标准)'||pd.view== 'save'?'selected':''}>西子富沃德(800-1600标准)</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道结构</td>
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_JDJG" value="全混凝土" ${pd.BASE_JDJG=='全混凝土'?'checked':''}/>
                                                                全混凝土
                                                                <input type="radio" name="BASE_JDJG" value="框架结构(圈梁)" ${pd.BASE_JDJG=='框架结构(圈梁)'?'checked':''}/>
                                                                框架结构(圈梁)
                                                                <input type="radio" name="BASE_JDJG" value="钢结构" ${pd.BASE_JDJG=='钢结构'?'checked':''}/>
                                                                钢结构
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>圈/钢梁间距</td>
                                                            <td colspan="2">
                                                                <input type="text" name="BASE_QGLJJ" id="BASE_QGLJJ" onkeyup="setDgzj();" class="form-control"  value="${pd.BASE_QGLJJ}"/>mm </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td><font color="red">*</font>轿厢规格CW*CD(mm)</td>
                                                            <td colspan="2">
                                                                <select name="BASE_JXGG" id="BASE_JXGG" class="form-control" required="required" >
                                                                    <option value=''>请选择</option>
                                                                    <option value="800W-1350×1400" ${pd.BASE_JXGG=='800W-1350×1400'?'selected':''}>800W-1350×1400</option>
                                                                    <option value="1000W-1600×1400" ${pd.BASE_JXGG=='1000W-1600×1400'?'selected':''}>1000W-1600×1400</option>
                                                                    <option value="1000D-1100×2100担架梯" ${pd.BASE_JXGG=='1000D-1100×2100担架梯'?'selected':''}>1000D-1100×2100担架梯</option>
                                                                    <option value="1150W-2000×1350" ${pd.BASE_JXGG=='1150W-2000×1350'?'selected':''}>1150W-2000×1350</option>
                                                                    <option value="1350W-2000×1500" ${pd.BASE_JXGG=='1350W-2000×1500'?'selected':''}>1350W-2000×1500</option>
                                                                    <option value="1600W-2000×1700" ${pd.BASE_JXGG=='1600W-2000×1700'?'selected':''}>1600W-2000×1700</option>
                                                                </select>   
																<div style="margin-top: 5px;">
																<font color="red" id="BASE_JXGG_FBTEXT" style="display:none;">国标允许的轿厢面积对应的载重下轿厢尺寸的变化时非标加价，超出国标时请非标询价</font>
																</div>
                                                            </td>
                                                            <td>
																<input type="hidden" name=CGFB_JXCC id="CGFB_JXCC" value="${pd.CGFB_JXCC }">
																<input type="text" name="CGFB_JXCC_TEMP" id="CGFB_JXCC_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="2">轿厢高度(非净高)</td>
                                                            <td>
                                                                <input type="radio" name="BASE_JXGD" value="2400" ${pd.BASE_JXGD=='2400'?'checked':''}/>2400mm(800-1000 标准)
                                                                <input type="radio" name="BASE_JXGD" value="2500" ${pd.BASE_JXGD=='2500'?'checked':''}/>2500mm(1150-1600 标准)
                                                                
                                                            </td>
                                                            <td rowspan="2">可选:
                                                                <input type="radio" name="BASE_JXGD" value="2300" ${pd.BASE_JXGD=='2300'?'checked':''}/>
                                                                2300mm
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td><!-- <input type="radio" name="BASE_JXGD" value="2500"/>2500mm -->
                                                                <!-- <select name="select" name="BASE_JXGD_SELECT">
                                                                    <option value="2500(V=1.0m/s时,K≥4100)">2500(V=1.0m/s时,K≥4100)</option>
                                                                    <option value="2500(V=1.5m/s时,K≥4200)">2500(V=1.5m/s时,K≥4200)</option>
                                                                    <option value="2500(V=1.75m/s时,K≥4300)">2500(V=1.75m/s时,K≥4300)</option>
                                                                </select>
                                                                mm(1350-1600kg) -->
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>开门尺寸OP*OPH </td>
                                                            <td colspan="2">
                                                                <select name="BASE_KMCC" id="BASE_KMCC" class="form-control" >
                                                                  <option value=''>请选择</option>
                                                                  <option value="800mm×2100mm(800kg)" ${pd.BASE_KMCC=='800mm×2100mm(800kg)'?'selected':''}>800mm×2100mm(800kg)</option>
                                                                  <option value="900mm×2100mm(1000kg)" ${pd.BASE_KMCC=='900mm×2100mm(1000kg)'?'selected':''}>900mm×2100mm(1000kg)</option>
                                                                  <option value="1100mm×2100mm(1150kg-1600kg)" ${pd.BASE_KMCC=='1100mm×2100mm(1150kg-1600kg)'?'selected':''}>1100mm×2100mm(1150kg-1600kg)</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>门类型/门保护</td>
                                                            <td>
                                                                <input type="radio" name="BASE_MLXMBH" value="PM门机/2D光幕" onclick="setMlxmbhDisable('1');" ${pd.BASE_MLXMBH=='PM门机/2D光幕'?'checked':''}/>
                                                                PM门机/2D光幕
                                                            </td>
                                                            <td>
                                                                可选:
                                                                <input type="radio" name="BASE_MLXMBH" value="" onclick="setMlxmbhDisable('0');" ${pd.BASE_MLXMBH=='PM门机/2D光幕'?'':'checked'}/>
                                                                <select name="BASE_MLXMBH_TEXT" id="BASE_MLXMBH_TEXT" class="form-control" >
                                                                    <option value=''>请选择</option>
                                                                    <option value="VVVF申菱门机/2D光幕" ${pd.BASE_MLXMBH=='VVVF申菱门机/2D光幕'?'selected':''}>VVVF申菱门机</option>
                                                                </select>
                                                                /2D光幕
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道承重墙厚度</td>
                                                            <td width="317">
                                                                <input type="radio" name="BASE_JDCZQHD" value="250" onclick="setJdczqhdDisable('1');"  ${pd.BASE_JDCZQHD=='250'?'checked':''}/>
                                                                WT=250mm
                                                            </td>
                                                            <td width="424">
                                                                <input type="radio" name="BASE_JDCZQHD" value="" onclick="setJdczqhdDisable('0')" ${pd.BASE_JDCZQHD=='250'?'':'checked'}/>
                                                                WT=
                                                                <input name="BASE_JDCZQHD_TEXT" id="BASE_JDCZQHD_TEXT" type="text" class="form-control"  value="${pd.BASE_JDCZQHD}"/>
                                                                mm
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>提升高度RISE</td>
                                                            <td>
                                                                <font color="red">*</font><input name="BASE_TSGD" id="BASE_TSGD" onkeyup="setJdzg();" type="text" class="form-control" value="${pd.BASE_TSGD}" placeholder="必填" required="required"/>mm
                                                            </td>
                                                            <td>
                                                                                                                                                                                           超出:
                                                              <input name="BASE_CCGD" id="BASE_CCGD" type="text" style="width:30%" class="form-control" value="${pd.BASE_CCGD}" readonly="readonly"/>mm
                                                               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                                                                                                     
                                                                                                                                                                                           加价:
                                                              <input name="BASE_CCJG" id="BASE_CCJG" type="text" style="width:30%" class="form-control" value="${pd.BASE_CCJG}" readonly="readonly"/>元
                                                            </td>
                                                            <td><label class="intro" style="color: red;display: none;" id="CGJJ_Label">请非标询价</label></td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道尺寸HW*HD</td>
                                                            <td colspan="2">
                                                                <input name="BASE_JDK" id="BASE_JDK" type="text" class="form-control" style="width: 10%" value="${pd.BASE_JDK}"/>
                                                                mm宽×
                                                                <input name="BASE_JDS" id="BASE_JDS" type="text" class="form-control" style="width: 10%" value="${pd.BASE_JDS}"/>
                                                                mm深
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>底坑S顶层K</td>
                                                            <td colspan="2">
                                                                <p>
                                                                    <font color="red">*</font>底坑深度:
                                                                    <input name="BASE_DKSD" id="BASE_DKSD" type="text"  onkeyup="setJdzg();" class="form-control" value="${pd.BASE_DKSD}" placeholder="必填" required="required"/>mm
                                                                </p>
                                                                <p>
                                                                    <font color="red">*</font>顶层高度:
                                                                    <input name="BASE_DCGD" id="BASE_DCGD" type="text"  onkeyup="setJdzg();" class="form-control" value="${pd.BASE_DCGD}" placeholder="必填" required="required"/>mm
                                                                </p>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>基站驻停</td>
                                                            <td colspan="2">
                                                                在
                                                                <input name="BASE_JZZT" type="text" class="form-control" value="${pd.BASE_JZZT}"/>
                                                                层
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>楼层标记</td>
                                                            <td colspan="2">
                                                                <input name="BASE_LCBJ" type="text" class="form-control" value="${pd.BASE_LCBJ}"/>
                                                            </td>
                                                            <td></td>
                                                          </tr><tr>
                                                            <td>井道总高</td>
                                                            <td colspan="2">
                                                                <input name="BASE_JDZG" id="BASE_JDZG" type="text" class="form-control" value="${pd.BASE_JDZG}" readonly="readonly"/>
                                                            </td>
                                                            <td>
                                                                <input type="hidden" name="BASE_JDZG_TEMP" id="BASE_JDZG_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr><tr>
                                                            <td>导轨支架</td>
                                                            <td colspan="2">
                                                                <input name="BASE_DGZJ" id="BASE_DGZJ" type="text" class="form-control"  value="${pd.BASE_DGZJ}" onkeyup="setDgzj();" />
                                                            </td>
                                                            <td>
                                                                <input type="text" name="BASE_DGZJ_TEMP" id="BASE_DGZJ_TEMP" class="form-control" readonly="readonly">
                                                            	<label class="intro" style="color: red;display: none;width: 50%;" id="DGZJ_Label">请非标询价</label>    
                                                            </td>
                                                          </tr>
                                                        </table>
                                                    <!-- 基本参数 -->
                                                </div>
                                                <div id="tab-2" class="tab-pane">
                                                    <!-- 标准功能 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>序号</td>
                                                            <td>功能</td>
                                                            <td>简称</td>
                                                            <td>序号</td>
                                                            <td>功能</td>
                                                            <td>简称</td>
                                                            <td>序号</td>
                                                            <td>功能</td>
                                                            <td>简称</td>
                                                          </tr>
                                                          <tr>
                                                            <td>1</td>
                                                            <td>全集选控制</td>
                                                            <td>FCL</td>
                                                            <td>9</td>
                                                            <td>轿内通风手动及照明自动控制</td>
                                                            <td>FLP</td>
                                                            <td>17</td>
                                                            <td>厅及轿厢运行方向显示</td>
                                                            <td>HDI&amp;CDI</td>
                                                          </tr>
                                                          <tr>
                                                            <td>2</td>
                                                            <td>轿顶与机房紧急电动运行</td>
                                                            <td>TCI ERO </td>
                                                            <td>10</td>
                                                            <td>故障自动检测</td>
                                                            <td>FAN</td>
                                                            <td>18</td>
                                                            <td>2D光幕门保护装置</td>
                                                            <td>LRD</td>
                                                          </tr>
                                                          <tr>
                                                            <td>3</td>
                                                            <td>轿内应急照明</td>
                                                            <td>ECU</td>
                                                            <td>11</td>
                                                            <td>关门时间保护</td>
                                                            <td>DTP</td>
                                                            <td>19</td>
                                                            <td>火警自动返回基站</td>
                                                            <td>FL</td>
                                                          </tr>
                                                          <tr>
                                                            <td>4</td>
                                                            <td>设置厅、轿门时间</td>
                                                            <td>CHT</td>
                                                            <td>12</td>
                                                            <td>超载不启动(警示灯及蜂鸣器)</td>
                                                            <td>OLD</td>
                                                            <td rowspan="2">20</td>
                                                            <td rowspan="2">监控室与机房、轿厢对讲(不含机房到监控室连线)</td>
                                                            <td rowspan="2">ICU</td>
                                                          </tr>
                                                          <tr>
                                                            <td>5</td>
                                                            <td>满载不停梯</td>
                                                            <td>LNS</td>
                                                            <td>13</td>
                                                            <td>运行次数显示</td>
                                                            <td>TRIC</td>
                                                          </tr>
                                                          <tr>
                                                            <td>6</td>
                                                            <td>无呼自动返基站</td>
                                                            <td>ARTL</td>
                                                            <td>14</td>
                                                            <td>警铃</td>
                                                            <td>ALM</td>
                                                            <td>21</td>
                                                            <td>开、关门按钮</td>
                                                            <td>DOB DCB </td>
                                                          </tr>
                                                          <tr>
                                                            <td>7</td>
                                                            <td>驻停</td>
                                                            <td>PKS</td>
                                                            <td>15</td>
                                                            <td>厅和轿厢数字位置指示器</td>
                                                            <td>HPI</td>
                                                            <td>22</td>
                                                            <td>错误指令删除</td>
                                                            <td>DCC</td>
                                                          </tr>
                                                          <tr>
                                                            <td>8</td>
                                                            <td>司机操作</td>
                                                            <td>ATT</td>
                                                            <td>16</td>
                                                            <td>厅外和轿厢呼梯/登记</td>
                                                            <td>DTTL</td>
                                                            <td>23</td>
                                                            <td>消防员运行</td>
                                                            <td>EFS</td>
                                                          </tr>
                                                        </table>
                                                    <!-- 标准功能 -->
                                                </div>
                                                <div id="tab-3" class="tab-pane">
                                                    <!-- 可选功能 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>序号</td>
                                                            <td>功能</td>
                                                            <td>简称</td>
                                                            <td>有</td>
                                                            <td>加价</td>
                                                            <td>序号</td>
                                                            <td>功能</td>
                                                            <td>简称</td>
                                                            <td>有</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>1</td>
                                                            <td>盲文按钮(无偿选配)</td>
                                                            <td>BRAILLEB</td>
                                                            <td>
                                                                <input name="OPT_MWAN_TEXT" id="OPT_MWAN_TEXT" type="checkbox" onlcick="editOpt('OPT_MWAN');" ${pd.OPT_MWAN=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_MWAN" id="OPT_MWAN">
                                                            </td>
                                                            <td><input type="text" name="OPT_MWAN_TEMP" id="OPT_MWAN_TEMP" class="form-control" readonly="readonly"></td>
                                                            <td>15</td>
                                                            <td>防捣乱操作</td>
                                                            <td>ANS</td>
                                                            <td>
                                                                <input name="OPT_FDLCZ_TEXT" id="OPT_FDLCZ_TEXT" type="checkbox" onclick="editOpt('OPT_FDLCZ');"  ${pd.OPT_FDLCZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_FDLCZ" id="OPT_FDLCZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_FDLCZ_TEMP" id="OPT_FDLCZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <%-- <td>2</td>
                                                            <td>火警自动返回基站</td>
                                                            <td>FL</td>
                                                            <td>
                                                                <input name="OPT_HJZDFHJZ_TEXT" id="OPT_HJZDFHJZ_TEXT" type="checkbox" onclick="editOpt('OPT_HJZDFHJZ');"  ${pd.OPT_HJZDFHJZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_HJZDFHJZ" id="OPT_HJZDFHJZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_HJZDFHJZ_TEMP" id="OPT_HJZDFHJZ_TEMP" class="form-control" readonly="readonly"></td> --%>
                                                            <td>2</td>
                                                            <td>独立服务</td>
                                                            <td>ISC</td>
                                                            <td>
                                                                <input name="OPT_DLFW_TEXT" id="OPT_DLFW_TEXT" type="checkbox" onclick="editOpt('OPT_DLFW');"  ${pd.OPT_DLFW=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_DLFW" id="OPT_DLFW">
                                                            </td>
                                                            <td><input type="text" name="OPT_DLFW_TEMP" id="OPT_DLFW_TEMP" class="form-control" readonly="readonly"></td>
                                                            
                                                            <td>16</td>
                                                            <td>再平层</td>
                                                            <td>RLEV</td>
                                                            <td>
                                                                <input name="OPT_ZPC_TEXT" id="OPT_ZPC_TEXT" type="checkbox" checked="checked" onclick="editOpt('OPT_ZPC')"  ${pd.OPT_ZPC=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_ZPC" id="OPT_ZPC">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZPC_TEMP" id="OPT_ZPC_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>3</td>
                                                            <td>消防员运行</td>
                                                            <td>EFS</td>
                                                            <td>
                                                                <input name="OPT_XFYYX_TEXT" id="OPT_XFYYX_TEXT" type="checkbox" onclick="editOpt('OPT_XFYYX');"  ${pd.OPT_XFYYX=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_XFYYX" id="OPT_XFYYX">
                                                            </td>
                                                            <td><input type="text" name="OPT_XFYYX_TEMP" id="OPT_XFYYX_TEMP" class="form-control" readonly="readonly"></td>
                                                            <td>17</td>
                                                            <td>BA接口</td>
                                                            <td>BA</td>
                                                            <td>
                                                                <input name="OPT_BAJK_TEXT" id="OPT_BAJK_TEXT" type="checkbox" onclick="editOpt('OPT_BAJK');"  ${pd.OPT_BAJK=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_BAJK" id="OPT_BAJK">
                                                            </td>
                                                            <td><input type="text" name="OPT_BAJK_TEMP" id="OPT_BAJK_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>4</td>
                                                            <td>轿厢到站钟</td>
                                                            <td>GNC</td>
                                                            <td>
                                                                <input name="OPT_JXDZZ_TEXT" id="OPT_JXDZZ_TEXT" type="checkbox" onclick="editOpt('OPT_JXDZZ');"  ${pd.OPT_JXDZZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JXDZZ" id="OPT_JXDZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_JXDZZ_TEMP" id="OPT_JXDZZ_TEMP" class="form-control" readonly="readonly"></td>
                                                            <td>18</td>
                                                            <td>语音报站</td>
                                                            <td>SR</td>
                                                            <td>
                                                                <input name="OPT_YXBZ_TEXT" id="OPT_YXBZ_TEXT" type="checkbox" onclick="editOpt('OPT_YYBZ');"  ${pd.OPT_YYBZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_YYBZ" id="OPT_YYBZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_YYBZ_TEMP" id="OPT_YYBZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>5</td>
                                                            <td>CCTV电缆(轿厢到机房)</td>
                                                            <td>CCTVC</td>
                                                            <td>
                                                                <input name="OPT_CCTVDL_TEXT" id="OPT_CCTVDL_TEXT" type="checkbox" onclick="editOpt('OPT_CCTVDL');"  ${pd.OPT_CCTVDL=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_CCTVDL" id="OPT_CCTVDL">
                                                            </td>
                                                            <td><input type="text" name="OPT_CCTVDL_TEMP" id="OPT_CCTVDL_TEMP" class="form-control" readonly="readonly"></td>
                                                            <td>19</td>
                                                            <td>强迫关门</td>
                                                            <td>NDG</td>
                                                            <td>
                                                                <input name="OPT_QPGM_TEXT" id="OPT_QPGM_TEXT" type="checkbox" onclick="editOpt('OPT_QPGM');"  ${pd.OPT_QPGM=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_QPGM" id="OPT_QPGM">
                                                            </td>
                                                            <td><input type="text" name="OPT_QPGM_TEMP" id="OPT_QPGM_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          
                                                            <%-- <td>6</td>
                                                            <td>停电紧急救援</td>
                                                            <td>ARD</td>
                                                            <td>
                                                                <input name="OPT_TDJJJY_TEXT" id="OPT_TDJJJY_TEXT" type="checkbox" onclick="editOpt('OPT_TDJJJY');"  ${pd.OPT_TDJJJY=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_TDJJJY" id="OPT_TDJJJY">
                                                            </td>
                                                            <td><input type="text" name="OPT_TDJJJY_TEMP" id="OPT_TDJJJY_TEMP" class="form-control"></td> --%>
                                                            
                                                            
                                                          
                                                          <tr>
                                                            <td>6</td>
                                                            <td>电机过热保护</td>
                                                            <td>THB</td>
                                                            <td>
                                                                <input name="OPT_DJGRBH_TEXT" id="OPT_DJGRBH_TEXT" type="checkbox" onclick="editOpt('OPT_DJGRBH');"  ${pd.OPT_DJGRBH=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_DJGRBH" id="OPT_DJGRBH">
                                                            </td>
                                                            <td><input type="text" name="OPT_DJGRBH_TEMP" id="OPT_DJGRBH_TEMP" class="form-control" readonly="readonly"></td>
                                                            <td>20</td>
                                                            <td>开门保持</td>
                                                            <td>DHB</td>
                                                            <td>
                                                                <input name="OPT_KMBC_TEXT" id="OPT_KMBC_TEXT" type="checkbox" onclick="editOpt('OPT_KMBC');"  ${pd.OPT_KMBC=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_KMBC" id="OPT_KMBC">
                                                            </td>
                                                            <td><input type="text" name="OPT_KMBC_TEMP" id="OPT_KMBC_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>7</td>
                                                            <td>空气净化装置</td>
                                                            <td>ANION</td>
                                                            <td>
                                                                <input name="OPT_KQJHZZ_TEXT" id="OPT_KQJHZZ_TEXT" type="checkbox" onclick="editOpt('OPT_KQJHZZ');"  ${pd.OPT_KQJHZZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_KQJHZZ" id="OPT_KQJHZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_KQJHZZ_TEMP" id="OPT_KQJHZZ_TEMP" class="form-control" readonly="readonly"></td>
                                                            <td>21</td>
                                                            <td>地震运行</td>
                                                            <td>EQO</td>
                                                            <td>
                                                                <input name="OPT_DZYX_TEXT" id="OPT_DZYX_TEXT" type="checkbox" onclick="editOpt('OPT_DZYX');"  ${pd.OPT_DZYX=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_DZYX" id="OPT_DZYX">
                                                            </td>
                                                            <td><input type="text" name="OPT_DZYX_TEMP" id="OPT_DZYX_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>8</td>
                                                            <td>纳米银抗菌按钮</td>
                                                            <td>NANOAGB</td>
                                                            <td>
                                                                <input name="OPT_NMYKJAN" id="OPT_NMYKJAN" type="text" onkeyup="editOpt('OPT_NMYKJAN');" class="form-control" style="width: 100%" value="${pd.OPT_NMYKJAN}"/>
                                                                <!-- <input name="OPT_NMYKJAN_TEXT" id="OPT_NMYKJAN_TEXT" type="checkbox" onclick="editOpt('OPT_NMYKJAN');"  ${pd.OPT_NMYKJAN=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_NMYKJAN" id="OPT_NMYKJAN"> -->
                                                            </td>
                                                            <td><input type="text" name="OPT_NMYKJAN_TEMP" id="OPT_NMYKJAN_TEMP" class="form-control" readonly="readonly"></td>
                                                            <td>22</td>
                                                            <td>能量回馈</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <input name="OPT_NLHK_TEXT" id="OPT_NLHK_TEXT" type="checkbox" onclick="editOpt('OPT_NLHK');"  ${pd.OPT_NLHK=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_NLHK" id="OPT_NLHK">
                                                            </td>
                                                            <td><input type="text" name="OPT_NLHK_TEMP" id="OPT_NLHK_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr><%-- <tr>
                                                            <td>10</td>
                                                            <td>远程监控(物联网系统)</td>
                                                            <td></td>
                                                            <td>
                                                                <input name="OPT_YCJK_TEXT" id="OPT_YCJK_TEXT" type="checkbox" onclick="editOpt('OPT_YCJK');"  ${pd.OPT_YCJK=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_YCJK" id="OPT_YCJK">
                                                            </td>
                                                            <td><input type="text" name="OPT_YCJK_TEMP" id="OPT_YCJK_TEMP" class="form-control"></td>
                                                            
                                                          </tr> --%>
                                                          
                                                          <tr>
                                                            <td>9</td>
                                                            <td>普通电梯空调</td>
                                                            <td></td>
                                                            <td>
                                                                <select name="OPT_PTDTKT" id="OPT_PTDTKT" onchange="editOpt('OPT_PTDTKT');" class="form-control" style="width: 100%">
                                                                    <option value=''>请选择</option>
                                                                    <option value='单冷型2200W' ${pd.OPT_PTDTKT=='单冷型2200W'?'selected':''}>单冷型2200W</option>
                                                                    <option value='冷暖型1500W' ${pd.OPT_PTDTKT=='冷暖型1500W'?'selected':''}>冷暖型1500W</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_PTDTKT_TEMP" id="OPT_PTDTKT_TEMP" class="form-control" readonly="readonly"></td>
                                                            <td>23</td>
                                                            <td>专用分体式电梯空调</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <select name="OPT_ZYFTSDTKT" id="OPT_ZYFTSDTKT" onchange="editOpt('OPT_ZYFTSDTKT');" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value='单冷型2200W' ${pd.OPT_ZYFTSDTKT=='单冷型2200W'?'selected':''}>单冷型2200W</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_ZYFTSDTKT_TEMP" id="OPT_ZYFTSDTKT_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>10</td>
                                                            <td>进口光幕</td>
                                                            <td></td>
                                                            <td>
                                                                <input name="OPT_JKGM_TEXT" id="OPT_JKGM_TEXT" type="checkbox" onclick="editOpt('OPT_JKGM');"  ${pd.OPT_JKGM=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JKGM" id="OPT_JKGM">
                                                            </td>
                                                            <td><input type="text" name="OPT_JKGM_TEMP" id="OPT_JKGM_TEMP" class="form-control" readonly="readonly"></td>
                                                            <td>24</td>
                                                            <td>进口曳引机</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <input name="OPT_JKYYJ_TEXT" id="OPT_JKYYJ_TEXT" type="checkbox" onclick="editOpt('OPT_JKYYJ');"  ${pd.OPT_JKYYJ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JKYYJ" id="OPT_JKYYJ">
                                                            </td>
                                                            <td><input type="text" name="OPT_JKYYJ_TEMP" id="OPT_JKYYJ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>11</td>
                                                            <td>贯通门(轿厢、轿门部分)</td>
                                                            <td></td>
                                                            <td>
                                                                <input name="OPT_GTMJXJMBF_TEXT" id="OPT_GTMJXJMBF_TEXT" type="checkbox" onclick="editOpt('OPT_GTMJXJMBF');"  ${pd.OPT_GTMJXJMBF=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_GTMJXJMBF" id="OPT_GTMJXJMBF">
                                                            </td>
                                                            <td><input type="text" name="OPT_GTMJXJMBF_TEMP" id="OPT_GTMJXJMBF_TEMP" class="form-control" readonly="readonly">
                                                            	<label class="intro" style="color: red;display: none;" id="GTMJX_Label">请非标询价</label>
                                                            </td>
                                                            <td>25</td>
                                                            <td>贯通门(厅门部分)</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <select name="OPT_GTMTMBF_TEXT" id="OPT_GTMTMBF_TEXT" onchange="editOpt('OPT_GTMTMBF');" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value='发纹不锈钢' ${pd.OPT_GTMTMBF=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value='喷涂' ${pd.OPT_GTMTMBF=='喷涂'?'selected':''}>喷涂</option>
                                                                </select>
                                                                <input type="hidden" name="OPT_GTMTMBF" id="OPT_GTMTMBF">
                                                            </td>
                                                            <td>
                                                              <input type="text" name="OPT_GTMTMBF_TEMP" id="OPT_GTMTMBF_TEMP" class="form-control" readonly="readonly">
                                                              <label class="intro" style="color: red;display: none;" id="GTMTM_Label">请非标询价</label>
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>12</td>
                                                            <td>贯通门数</td>
                                                            <td></td>
                                                            <td>
                                                                <!--  -->
                                                                <input name="OPT_GTMS_TEXT" id="OPT_GTMS_TEXT" type="text" readonly="readonly" class="form-control" style="width: 100%" value="${pd.OPT_GTMS}"/>
                                                                <input type="hidden" name="OPT_GTMS" id="OPT_GTMS">
                                                            </td>
                                                            <td><input type="text" name="OPT_GTMS_TEMP" id="OPT_GTMS_TEMP" class="form-control" readonly="readonly">
                                                            	<label class="intro" style="color: red;display: none;" id="GTMMS_Label">请非标询价</label>
                                                            </td>
                                                            <td>26</td>
                                                            <td>层门装潢</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <select name="OPT_CMZH_TEXT" id="OPT_CMZH_TEXT" onchange="editOpt('OPT_CMZH');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="JF-K-C01" ${pd.OPT_CMZH=='JF-K-C01'?'selected':''}>JF-K-C01</option>
                                                                    <option value="JF-K-C02" ${pd.OPT_CMZH=='JF-K-C02'?'selected':''}>JF-K-C02</option>
                                                                    <option value="JF-K-C03" ${pd.OPT_CMZH=='JF-K-C03'?'selected':''}>JF-K-C03</option>
                                                                    <option value="JF-K-C04" ${pd.OPT_CMZH=='JF-K-C04'?'selected':''}>JF-K-C04</option>
                                                                    <option value="JF-K-C05" ${pd.OPT_CMZH=='JF-K-C05'?'selected':''}>JF-K-C05</option>
                                                                    <option value="JF-K-C06" ${pd.OPT_CMZH=='JF-K-C06'?'selected':''}>JF-K-C06</option>
                                                                    <option value="JF-K-C07" ${pd.OPT_CMZH=='JF-K-C07'?'selected':''}>JF-K-C07</option>
                                                                </select>
                                                                <input type="hidden" name="OPT_CMZH" id="OPT_CMZH">
                                                            <td><input type="text" name="OPT_CMZH_TEMP" id="OPT_CMZH_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          
                                                          <tr>
                                                            <td>13</td>
                                                            <td>IC卡制卡设备</td>
                                                            <td></td>
                                                            <td>
                                                                <input name="OPT_ICKZKSB_TEXT" id="OPT_ICKZKSB_TEXT" type="checkbox" onclick="editOpt('OPT_ICKZKSB');"  ${pd.OPT_ICKZKSB=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_ICKZKSB" id="OPT_ICKZKSB">
                                                            </td>
                                                            <td><input type="text" name="OPT_ICKZKSB_TEMP" id="OPT_ICKZKSB_TEMP" class="form-control" readonly="readonly"></td>
                                                            <td>27</td>
                                                            <td>IC卡卡片(张)</td>
                                                            <td>REG</td>
                                                            <td>
                                                                <input name="OPT_ICKKP" id="OPT_ICKKP" type="text" onkeyup="editOpt('OPT_ICKKP');" class="form-control" style="width: 100%" value="${pd.OPT_ICKKP}"/>
                                                            </td>
                                                            <td><input type="text" name="OPT_ICKKP_TEMP" id="OPT_ICKKP_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>14</td>
                                                            <td>IC卡(轿内控制)</td>
                                                            <td></td>
                                                            <td>
                                                                <select name="OPT_ICK" id="OPT_ICK" onchange="editOpt('OPT_ICK');" class="form-control" style="width: 100%">
                                                                    <option value="">请选择</option>
                                                                    <option value="刷卡后手动选择到达楼层" ${pd.OPT_ICK=='刷卡后手动选择到达楼层'?'selected':''}>刷卡后手动选择到达楼层</option>
                                                                    <option value="刷卡后自动选择到达楼层" ${pd.OPT_ICK=='刷卡后自动选择到达楼层'?'selected':''}>刷卡后自动选择到达楼层</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_ICK_TEMP" id="OPT_ICK_TEMP" class="form-control" readonly="readonly"></td>
                                                            
                                                          </tr>
                                                          
                                                        </table>
                                                    <!-- 可选功能 -->
                                                </div>
                                                <div id="tab-4" class="tab-pane">
                                                    <!-- 单组监控室对讲系统 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td width="197">对讲通讯方式</td>
                                                            <td width="326">
                                                                <input name="DZJKSDJXT_DJTXFS" type="radio" value="一对一" ${pd.DZJKSDJXT_DJTXFS=='一对一'?'checked':''}/>
                                                                一对一
                                                                <input name="DZJKSDJXT_DJTXFS" type="radio" value="一对多" ${pd.DZJKSDJXT_DJTXFS=='一对多'?'checked':''}/>
                                                                一对多
                                                            </td>
                                                            <td width="326">对讲的电梯台数:    
                                                            <input name="DZJKSDJXT_DJTS" id="DZJKSDJXT_DJTS" type="text" class="form-control" value="${pd.DZJKSDJXT_DJTS}"/>
                                                            台</td>
                                                          </tr>
                                                          <!-- <tr>
                                                            <td>关联电梯合同号</td>
                                                            <td colspan="2"><input type="text" class="form-control"/></td>
                                                          </tr> -->
                                                          <tr>
                                                            <td>备注</td>
                                                            <td colspan="2">标配五方对讲:轿厢、轿顶、底坑,控制柜,监控室;选择一对多时,10台以下项目标配为分线制多局对讲;10台以上项目标配为总线制对局对讲,对局对讲系统单个监控室主机的最大控制台数为64台</td>
                                                          </tr>
                                                          <!-- <tr>
                                                            <td>加价</td>
                                                            <td colspan="2"><input type="text" name="DZJKSDJXT_DJTS_TEMP" id="DZJKSDJXT_DJTS_TEMP" class="form-control"/></td>
                                                          </tr> -->
                                                        </table>
                                                    <!-- 单组监控室对讲系统 -->
                                                </div>
                                                <div id="tab-5" class="tab-pane">
                                                    <!-- 轿厢装潢 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="2">轿厢装潢</td>
                                                            <td>标准</td>
                                                            <td>可选&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;取消选择
                                                            	<input name="JXZH_JM" type="radio" value="" onclick="editJxzh('JXZH_JM_quxiao');"/>
                                                            </td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="4">轿厢</td>
                                                            <td>轿门</td>
                                                            <td>
                                                                <select name="JXZH_JMZH" id="JXZH_JMZH" onclick="editJxzh('JXZH_JMZH');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="JF-K-C01" ${pd.JXZH_JMZH=='JF-K-C01'?'selected':''}>JF-K-C01</option>
                                                                    <option value="JF-K-C02" ${pd.JXZH_JMZH=='JF-K-C02'?'selected':''}>JF-K-C02</option>
                                                                    <option value="JF-K-C03" ${pd.JXZH_JMZH=='JF-K-C03'?'selected':''}>JF-K-C03</option>
                                                                    <option value="JF-K-C04" ${pd.JXZH_JMZH=='JF-K-C04'?'selected':''}>JF-K-C04</option>
                                                                    <option value="JF-K-C05" ${pd.JXZH_JMZH=='JF-K-C05'?'selected':''}>JF-K-C05</option>
                                                                    <option value="JF-K-C06" ${pd.JXZH_JMZH=='JF-K-C06'?'selected':''}>JF-K-C06</option>
                                                                    <option value="JF-K-C07" ${pd.JXZH_JMZH=='JF-K-C07'?'selected':''}>JF-K-C07</option>
                                                                    <option value="SUS304发纹不锈钢" ${pd.JXZH_JMZH=='SUS304发纹不锈钢'?'selected':''}>SUS304发纹不锈钢</option>
                                                                    <option value="镜面不锈钢" ${pd.JXZH_JMZH=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                    <option value="喷涂" ${pd.JXZH_JMZH=='喷涂'?'selected':''}>喷涂</option>
                                                                </select>
                                                                <%-- <input name="JXZH_JM" type="radio" value="SUS304发纹不锈钢" onclick="setJmsbhDisable('1');" ${pd.JXZH_JM=='SUS304发纹不锈钢'?'checked':''}/>
                                                                SUS304发纹不锈钢 --%>
                                                            </td>
                                                            <td>
                                                               <%--  <input name="JXZH_JM" type="radio" value="镜面不锈钢" onclick="setJmsbhDisable('1');" ${pd.JXZH_JM=='镜面不锈钢'?'checked':''}/>
                                                                镜面不锈钢
                                                                <input name="JXZH_JM" type="radio" value="喷涂" onclick="setJmsbhDisable('0');" ${pd.JXZH_JM=='喷涂'?'checked':''}/>
                                                                喷涂  --%>
                                                                                                                                                                                                色标号:
                                                                <select name="JXZH_JMSBH" id="JXZH_JMSBH" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value="P-01" ${pd.JXZH_JMSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.JXZH_JMSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.JXZH_JMSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.JXZH_JMSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.JXZH_JMSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.JXZH_JMSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.JXZH_JMSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="JXZH_JM_TEMP" id="JXZH_JM_TEMP" class="form-control" readonly="readonly">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>前围壁</td>
                                                            <td>
                                                                <input name="JXZH_QWB" id="JXZH_QWB_FW" type="radio" value="SUS304发纹不锈钢" onclick="setQwbsbhDisable('1');" ${pd.JXZH_QWB=='SUS304发纹不锈钢'?'checked':''}/>
                                                                SUS304发纹不锈钢
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_QWB" id="JXZH_QWB_JM" type="radio" value="镜面不锈钢" onclick="setQwbsbhDisable('1');" ${pd.JXZH_QWB=='镜面不锈钢'?'checked':''}/>
                                                                镜面不锈钢
                                                                <input name="JXZH_QWB" id="JXZH_QWB_PT" type="radio" value="喷涂" onclick="setQwbsbhDisable('0');" ${pd.JXZH_QWB=='喷涂'?'checked':''}/>
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_QWBSBH" id="JXZH_QWBSBH" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value="P-01" ${pd.JXZH_QWBSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.JXZH_QWBSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.JXZH_QWBSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.JXZH_QWBSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.JXZH_QWBSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.JXZH_QWBSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.JXZH_QWBSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td rowspan="3">
                                                              <input type="text" name="JXZH_QWB_TEMP" id="JXZH_QWB_TEMP" class="form-control" readonly="readonly">
                                                              <br>
                                                              <font color="red">如果三侧配置不一致，请非标询价!</font>
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>侧围壁</td>
                                                            <td>
                                                                <input name="JXZH_CWB" id="JXZH_CWB_FW" type="radio" value="SUS304发纹不锈钢" onclick="setCwbsbhDisable('1');" ${pd.JXZH_CWB=='SUS304发纹不锈钢'?'checked':''}/>
                                                                SUS304发纹不锈钢
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_CWB" id="JXZH_CWB_JM" type="radio" value="镜面不锈钢" onclick="setCwbsbhDisable('1');" ${pd.JXZH_CWB=='镜面不锈钢'?'checked':''}/>
                                                                镜面不锈钢
                                                                <input name="JXZH_CWB" id="JXZH_CWB_PT" type="radio" value="喷涂" onclick="setCwbsbhDisable('0');" ${pd.JXZH_CWB=='喷涂'?'checked':''}/>
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_CWBSBH" id="JXZH_CWBSBH" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value="P-01" ${pd.JXZH_CWBSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.JXZH_CWBSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.JXZH_CWBSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.JXZH_CWBSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.JXZH_CWBSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.JXZH_CWBSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.JXZH_CWBSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <!-- <td><input type="text" name="JXZH_CWB_TEMP" id="JXZH_CWB_TEMP" class="form-control"></td> -->
                                                          </tr>
                                                          <tr>
                                                            <td>后围壁</td>
                                                            <td>
                                                                <input name="JXZH_HWB" id="JXZH_HWB_FW" type="radio" value="SUS304发纹不锈钢" onclick="setHwbsbhDisable('1');" ${pd.JXZH_HWB=='SUS304发纹不锈钢'?'checked':''}/>
                                                                SUS304发纹不锈钢
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_HWB" id="JXZH_HWB_JM" type="radio" value="镜面不锈钢" onclick="setHwbsbhDisable('1');" ${pd.JXZH_HWB=='镜面不锈钢'?'checked':''}/>
                                                                镜面不锈钢
                                                                <input name="JXZH_HWB" id="JXZH_HWB_PT" type="radio" value="喷涂" onclick="setHwbsbhDisable('0');" ${pd.JXZH_HWB=='喷涂'?'checked':''}/>
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_HWBSBH" id="JXZH_HWBSBH" class="form-control">
                                                                  <option value=''>请选择</option>
                                                                  <option value="P-01" ${pd.JXZH_HWBSBH=='P-01'?'selected':''}>P-01</option>
                                                                  <option value="P-02" ${pd.JXZH_HWBSBH=='P-02'?'selected':''}>P-02</option>
                                                                  <option value="P-03" ${pd.JXZH_HWBSBH=='P-03'?'selected':''}>P-03</option>
                                                                  <option value="P-04" ${pd.JXZH_HWBSBH=='P-04'?'selected':''}>P-04</option>
                                                                  <option value="P-05" ${pd.JXZH_HWBSBH=='P-05'?'selected':''}>P-05</option>
                                                                  <option value="P-06" ${pd.JXZH_HWBSBH=='P-06'?'selected':''}>P-06</option>
                                                                  <option value="P-07" ${pd.JXZH_HWBSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <!-- <td><input type="text" name="JXZH_HWB_TEMP" id="JXZH_HWB_TEMP" class="form-control"></td> -->
                                                          </tr>
                                                         <!--  <tr>
                                                            <td colspan="2">轿门装潢</td>
                                                            <td colspan="2">
                                                                
                                                            </td>
                                                             <td><input type="text" name="JXZH_JMZH_TEMP" id="JXZH_JMZH_TEMP" class="form-control"></td>
                                                          </tr> -->
                                                          <tr>
                                                            <td colspan="2">轿厢装潢</td>
                                                            <td colspan="2">
                                                                <select name="JXZH_JXZH" id="JXZH_JXZH" onclick="editJxzh('JXZH_JXZH');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="JF-K-JX-01" ${pd.JXZH_JXZH=='JF-K-JX-01'?'selected':''}>JF-K-JX-01</option>
                                                                    <option value="JF-K-JX-02" ${pd.JXZH_JXZH=='JF-K-JX-02'?'selected':''}>JF-K-JX-02</option>
                                                                    <option value="JF-K-JX-03" ${pd.JXZH_JXZH=='JF-K-JX-03'?'selected':''}>JF-K-JX-03</option>
                                                                    <option value="JF-K-JX-04" ${pd.JXZH_JXZH=='JF-K-JX-04'?'selected':''}>JF-K-JX-04</option>
                                                                    <option value="JF-K-JX-05" ${pd.JXZH_JXZH=='JF-K-JX-05'?'selected':''}>JF-K-JX-05</option>
                                                                    <option value="JF-K-JX-06" ${pd.JXZH_JXZH=='JF-K-JX-06'?'selected':''}>JF-K-JX-06</option>
                                                                    <option value="JF-K-JX-07" ${pd.JXZH_JXZH=='JF-K-JX-07'?'selected':''}>JF-K-JX-07</option>
                                                                    <option value="JF-K-JX-08" ${pd.JXZH_JXZH=='JF-K-JX-08'?'selected':''}>JF-K-JX-08</option>
                                                                    <option value="JF-K-JX-09" ${pd.JXZH_JXZH=='JF-K-JX-09'?'selected':''}>JF-K-JX-09</option>
                                                                    <option value="JF-K-JX-10" ${pd.JXZH_JXZH=='JF-K-JX-10'?'selected':''}>JF-K-JX-10</option>
                                                                    <option value="JF-K-JX-11" ${pd.JXZH_JXZH=='JF-K-JX-11'?'selected':''}>JF-K-JX-11</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="JXZH_JXZH_TEMP" id="JXZH_JXZH_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">轿顶装潢</td>
                                                            <td>
                                                              <%--   <input name="JXZH_JDZH" type="radio" value="悬吊式:JF-CL20(450-2000kg标准)" onclick="setJdzhDisable('0');"  ${pd.JXZH_JDZH=='悬吊式:JF-CL20(450-2000kg标准)'?'checked':''}/>
                                                                悬吊式:JF-CL20(450-2000kg标准) --%>
                                                                <input name="JXZH_JDZH" type="radio" value="集成式" onclick="setJdzhDisable('1');"  ${pd.JXZH_JDZH=='集成式'?'checked':''}/>
                                                                                                                                                                                                 集成式:
                                                                <select name="JXZH_ZSDD" onchange="editJxzh('JXZH_ZSDD');" id="ZSDD_1" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value="JF-Inte-CL01" ${pd.JXZH_ZSDD=='JF-Inte-CL01'?'selected':''}>JF-Inte-CL01</option>
                                                                    <option value="JF-Inte-CL02" ${pd.JXZH_ZSDD=='JF-Inte-CL02'?'selected':''}>JF-Inte-CL02</option>
                                                                    <option value="JF-Inte-CL03" ${pd.JXZH_ZSDD=='JF-Inte-CL03'?'selected':''}>JF-Inte-CL03</option>
                                                                    <option value="JF-Inte-CL04" ${pd.JXZH_ZSDD=='JF-Inte-CL04'?'selected':''}>JF-Inte-CL04</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_JDZH" type="radio" value="悬吊式" onclick="setJdzhDisable('2');" ${pd.JXZH_JDZH=='悬吊式'?'checked':''} />
                                                                                                                                                                                                 悬吊式:
                                                                <select name="JXZH_ZSDD" onchange="editJxzh('JXZH_ZSDD');" id="ZSDD_2" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value="JF-CL-02" ${pd.JXZH_ZSDD=='JF-CL-02'?'selected':''}>JF-CL-02</option>
                                                                    <option value="JF-CL-03" ${pd.JXZH_ZSDD=='JF-CL-03'?'selected':''}>JF-CL-03</option>
                                                                    <option value="JF-CL-04" ${pd.JXZH_ZSDD=='JF-CL-04'?'selected':''}>JF-CL-04</option>
                                                                    <option value="JF-CL-05" ${pd.JXZH_ZSDD=='JF-CL-05'?'selected':''}>JF-CL-05</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="JXZH_ZSDD_TEMP" id="JXZH_ZSDD_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">半高镜</td>
                                                            <td>
                                                                <input name="JXZH_BGJ" type="radio" value="无" onclick="editJxzh('JXZH_BGJ');" ${pd.JXZH_BGJ=='无'?'checked':''}/>
                                                                无
                                                            </td>
                                                            <td>
                                                                <input name="JXZH_BGJ" type="radio" value="有" onclick="editJxzh('JXZH_BGJ');" ${pd.JXZH_BGJ=='有'?'checked':''}/>
                                                                有
                                                            </td>
                                                            <td><input type="text" name="JXZH_BGJ_TEMP" id="JXZH_BGJ_TEMP" class="form-control" readonly="readonly">
                                                            	<label class="intro" style="color: red;display: none;" id="JXZH_BGJ_Label">请非标询价</label>
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">地板型号</td>
                                                            <td>
                                                                <input type="radio" name="JXZH_DBXH" value="JD-05" onclick="setDbxhDisable('1');" ${pd.JXZH_DBXH=='JD-05'?'checked':''}>
                                                                JD-05
                                                            </td>
                                                            <td>
                                                                可选:
                                                                <input name="JXZH_DBXH" type="radio" value="" onclick="setDbxhDisable('0');" ${pd.JXZH_DBXH=='JD-05'?'':'checked'}/>
                                                                <select name="JXZH_DBXH_SELECT" id="JXZH_DBXH_SELECT" class="form-control">
                                                                  <option value="无">请选择</option>
                                                                  <option value="JD-01" ${pd.JXZH_DBXH=='JD-01'?'selected':''}>JD-01</option>
                                                                  <option value="JD-02" ${pd.JXZH_DBXH=='JD-02'?'selected':''}>JD-02</option>
                                                                  <option value="JD-03" ${pd.JXZH_DBXH=='JD-03'?'selected':''}>JD-03</option>
                                                                  <option value="JD-04" ${pd.JXZH_DBXH=='JD-04'?'selected':''}>JD-04</option>
                                                                </select>
                                                                <input name="JXZH_DBXH" type="radio" value="大理石预留" onclick="setDbxhDisable('1');"${pd.JXZH_DBXH=='大理石预留'?'checked':''}/>
                                                                大理石预留
                                                            </td>
                                                            <td><input type="text" name="JXZH_DBXH_TEMP" id="JXZH_DBXH_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">地板装修厚度mm</td>
                                                            <td><input type="text" value="${pd.JXZH_DBZXHD}" name="JXZH_DBZXHD" id="JXZH_DBZXHD" class="form-control"></td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2" rowspan="2">预留装潢重量kg</td>
                                                            <td colspan="2">
                                                                <input name="JXZH_YLZHZL" id="JXZH_YLZHZL" type="text" onkeyup="editJxzh('JXZH_YLZHZL');" class="form-control" value="${pd.JXZH_YLZHZL}"/>
                                                            </td>
                                                            <td><input type="text" name="JXZH_YLZHZL_TEMP" id="JXZH_YLZHZL_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">
                                                                备注:当客户自主装修或选择大理石预留时必须填写预留装潢重量,当载重为450-1000/1150-1600/2000kg时,最大允许装潢重量分别为200/300/400kg,如装潢重量超出最大允许装潢重量时,需非标处理.
                                                            </td>
                                                            <td><label class="intro" style="color: red;display: none;" id="JXZH_YLDB_Label">请非标询价</label></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">扶手型号</td>
                                                            <td>
                                                                <input name="JXZH_FSXH" type="radio" value="无" onclick="setFsxhDisable('1');" ${pd.JXZH_FSXH=='无'?'checked':''}/>
                                                                                                                                                                                                无
                                                            </td>
                                                            <td><input name="JXZH_FSXH" type="radio" value="" onclick="setFsxhDisable('0');" ${pd.JXZH_FSXH=='无'?'':'checked'}/>
                                                              <select name="JXZH_FSXH_SELECT" id="JXZH_FSXH_SELECT" onchange="editJxzh('JXZH_FSXH');" class="form-control">
                                                                <option value="无">请选择</option>
                                                                <option value="JF-FS-01" ${pd.JXZH_FSXH=='JF-FS-01'?'selected':''}>JF-FS-01</option>
                                                                <option value="JF-FS-02" ${pd.JXZH_FSXH=='JF-FS-02'?'selected':''}>JF-FS-02</option>
                                                                <option value="JF-FS-03" ${pd.JXZH_FSXH=='JF-FS-03'?'selected':''}>JF-FS-03</option>
                                                                <option value="JF-FS-04" ${pd.JXZH_FSXH=='JF-FS-04'?'selected':''}>JF-FS-04</option>
                                                              </select>
                                                            </td>
                                                            <td><input type="hidden" name="JXZH_FSXH_TEMP" id="JXZH_FSXH_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">扶手安装位置</td>
                                                            <td colspan="2">
                                                                <input name="JXZH_FSAZWZ" id="JXZH_FSAZWZ_HWB" type="checkbox" value="后围壁" onclick="editJxzh('JXZH_FSAZWZ');" ${pd.JXZH_FSAZWZ_H=='1'?'checked':''}/>
                                                                                                                                                                                                 后围壁 轿厢外向内看:
                                                                <input name="JXZH_FSAZWZ" id="JXZH_FSAZWZ_ZWB" type="checkbox" value="左围壁" onclick="editJxzh('JXZH_FSAZWZ');" ${pd.JXZH_FSAZWZ_Z=='1'?'checked':''}/>
                                                                                                                                                                                                 左围壁
                                                                <input name="JXZH_FSAZWZ" id="JXZH_FSAZWZ_YWB" type="checkbox" value="右围壁" onclick="editJxzh('JXZH_FSAZWZ');" ${pd.JXZH_FSAZWZ_Y=='1'?'checked':''}/>
                                                                                                                                                                                                 右围壁
                                                                <input type="hidden" name="JXZH_FSAZWZ_H" id="JXZH_FSAZWZ_H">
                                                                <input type="hidden" name="JXZH_FSAZWZ_Z" id="JXZH_FSAZWZ_Z">
                                                                <input type="hidden" name="JXZH_FSAZWZ_Y" id="JXZH_FSAZWZ_Y">
                                                            </td>
                                                            <td><input type="text" name="JXZH_FSAZWZ_TEMP" id="JXZH_FSAZWZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                        	<td colspan="4" class="intro" style="color: red;display: none;" id="TMMT_Label"><label style="font-size: 16px;">由于开门宽度非标,厅门门套模块请非标询价</label></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 轿厢装潢 -->
                                                </div>
                                                <div id="tab-6" class="tab-pane">
                                                    <!-- 厅门门套 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <%-- <tr>
                                                            <td>发纹不锈钢小门套</td>
                                                            <td colspan="2"><input type="checkbox" name="TMMT_FWBXGXMT_TEXT" id="TMMT_FWBXGXMT_TEXT" onclick="editTmmt('TMMT_FWBXGXMT');" ${pd.TMMT_FWBXGXMT=='1'?'checked':''}></td>
                                                            <input type="hidden" name="TMMT_FWBXGXMT" id="TMMT_FWBXGXMT">
                                                            <td><input type="text" name="TMMT_FWBXGXMT_TEMP" id="TMMT_FWBXGXMT_TEMP" class="form-control"></td>
                                                          </tr> --%>
                                                          <%-- <tr>
                                                            <td>喷涂→大门套(墙厚+装饰层)≤350mm</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_PTDMT" name="TMMT_PTDMT" onchange="editTmmt('TMMT_PTDMT');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="喷涂" ${pd.TMMT_PTDMT=='喷涂'?'selected':''}>喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_PTDMT=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="镜面不锈钢" ${pd.TMMT_PTDMT=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                </select>
                                                            <td><input type="text" name="TMMT_PTDMT_TEMP" id="TMMT_PTDMT_TEMP" class="form-control"></td>
                                                          </tr> --%>
                                                          <%-- <tr>
                                                            <td>喷涂→镜面不锈钢厅门、小门套</td>
                                                            <td colspan="2">
                                                                <input type="checkbox" name="TMMT_PTJMBXGTM_TEXT" id="TMMT_PTJMBXGTM_TEXT" onclick="editTmmt('TMMT_PTJMBXGTM');" ${pd.TMMT_PTJMBXGTM=='1'?'checked':''}>
                                                                <input type="hidden" name="TMMT_PTJMBXGTM" id="TMMT_PTJMBXGTM">
                                                            <td><input type="text" name="TMMT_PTJMBXGTM_TEMP" id="TMMT_PTJMBXGTM_TEMP" class="form-control"></td>
                                                          </tr> --%>
                                                          
                                                          <tr>
                                                            <td width="41" rowspan="5">首层厅门门套</td>
                                                            <td width="125">厅门材质</td>
                                                            <td width="198">数量</td>
                                                            <td width="50">加价</td>
                                                          </tr>
                                                          
                                                          <tr>
                                                            <td width="125">大门套:
                                                                <select id="TMMT_PTDMT" name="TMMT_PTDMT" onchange="editTmmt('TMMT_PTDMT');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="喷涂" ${pd.TMMT_PTDMT=='喷涂'?'selected':''}>喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_PTDMT=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="镜面不锈钢" ${pd.TMMT_PTDMT=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                </select>
                                                            </td>
                                                            <td width="198">
                                                                                                                                                                                              各
                                                                <input name="DMT_SL" id="DMT_SL" type="text" onkeyup="setSctmmt('DMT_SL');" class="form-control" value="${pd.DMT_SL}"/>
                                                                                                                                                                                              套
                                                            </td>
                                                            <td width="50">
                                                              <input type="text" name="TMMT_PTDMT_TEMP" id="TMMT_PTDMT_TEMP" class="form-control" readonly="readonly">
                                                              <input type="hidden" name="TMMT_PTDMT_TEMP2" id="TMMT_PTDMT_TEMP2" class="form-control">
                                                            </td>
                                                          </tr>
                                                          
                                                          
                                                          <tr>
                                                            <td>
                                                                                                                                                                                              标准:
                                                                <input type="radio" name="TMMT_SCTMMT" id="TMMT_SCTMMT1" checked="checked" value="SUS304发纹不锈钢" onclick="setScsbhDisable('0');" ${pd.TMMT_SCTMMT=='SUS304发纹不锈钢'?'checked':''}/>
                                                                SUS304发纹不锈钢
                                                            </td>
                                                            <td rowspan="3">
                                                                                                                                                                                              各
                                                                <input name="FDMT_SL" id="scmmt1" onkeyup="setSctmmt('scmmt1');" type="text" class="form-control" value="${pd.FDMT_SL}" />
                                                                                                                                                                                              套
                                                            </td>
                                                            <td rowspan="3">
                                                              <input type="text" name="TMMT_SCTMMT_TEMP" id="TMMT_SCTMMT_TEMP" class="form-control" readonly="readonly">
                                                              <input type="hidden" name="TMMT_SCTMMT_TEMP2" id="TMMT_SCTMMT_TEMP2">
                                                              </td>
                                                           </tr>
                                                           <tr>
                                                            <td>
                                                                                                                                                                                              可选1:
                                                                <input name="TMMT_SCTMMT" id="TMMT_SCTMMT2" type="radio" value="镜面不锈钢" onclick="setScsbhDisable('1');" ${pd.TMMT_SCTMMT=='镜面不锈钢'?'checked':''}/>
                                                                                                                                                                                              镜面不锈钢
                                                            </td>
                                                            <!-- <td>
                                                                                                                                                                                              各
                                                                <input name="text3" id="scmmt2" onkeyup="setSctmmt('scmmt2');" type="text" class="form-control"/>
                                                                                                                                                                                              套
                                                            </td> -->
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                                                                                                                                              可选2:
                                                                <input name="TMMT_SCTMMT" id="TMMT_SCTMMT3" type="radio" value="喷涂" onclick="setScsbhDisable('2');" ${pd.TMMT_SCTMMT=='喷涂'?'checked':''}/>
                                                                                                                                                                                              喷涂
                                                                                                                                                                                              色标号:
                                                                <select name="TMMT_SCSBH" id="TMMT_SCSBH" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.TMMT_SCSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.TMMT_SCSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.TMMT_SCSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.TMMT_SCSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.TMMT_SCSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.TMMT_SCSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.TMMT_SCSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>   
                                                            </td>
                                                            <!-- <td>
                                                                                                                                                                                              各
                                                                <input name="text5" id="scmmt3" onkeyup="setSctmmt('scmmt3');" type="text" class="form-control"/>
                                                                                                                                                                                              套
                                                            </td> -->
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="4">非首层厅门门套</td>
                                                            <td>
                                                                                                                                                                                              标准:
                                                                <input name="TMMT_FSCTMMT" id="TMMT_FSCTMMT1" checked="checked" type="radio" value="喷涂" onclick="setFscsbhDisable('0');" ${pd.TMMT_FSCTMMT=='喷涂'?'checked':''}/>
                                                                                                                                                                                              喷涂
                                                                                                                                                                                              色标号:
                                                                <select name="TMMT_FSCSBH" name="TMMT_FSCSBH" id="TMMT_FSCSBH" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.TMMT_FSCSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.TMMT_FSCSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.TMMT_FSCSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.TMMT_FSCSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.TMMT_FSCSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.TMMT_FSCSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.TMMT_FSCSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td rowspan="3">各
                                                                <input name="FSCFDMT_SL" id="scmmt4" onkeyup="setFsctmmt('scmmt4');" type="text" class="form-control"  value="${pd.FSCFDMT_SL}"/>
                                                                                                                                                                                                套                                                                                                                            
                                                            </td>
                                                            <td rowspan="3">
                                                              <input type="text" name="TMMT_FSCTMMT_TEMP" id="TMMT_FSCTMMT_TEMP" class="form-control" readonly="readonly">
                                                              <input type="hidden" name="TMMT_FSCTMMT_TEMP2" id="TMMT_FSCTMMT_TEMP2">
                                                            </td>
                                                           </tr>
                                                           <tr>
                                                            <td>
                                                                                                                                                                                              可选1:
                                                                <input name="TMMT_FSCTMMT" id="TMMT_FSCTMMT2" type="radio" value="镜面不锈钢" onclick="setFscsbhDisable('1');" ${pd.TMMT_FSCTMMT=='镜面不锈钢'?'checked':''}/>
                                                                                                                                                                                              镜面不锈钢
                                                            </td>
                                                            <!-- <td>各
                                                                <input name="text32" id="scmmt5" onkeyup="setFsctmmt('scmmt5');" type="text" class="form-control"/>
                                                                                                                                                                                                套                                                                                                                             
                                                            </td> -->
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                                                                                                                                              可选2:
                                                                <input name="TMMT_FSCTMMT" id="TMMT_FSCTMMT3" type="radio" value="SUS304发纹不锈钢" onclick="setFscsbhDisable('2');" ${pd.TMMT_FSCTMMT=='SUS304发纹不锈钢'?'checked':''}/>
                                                                SUS304发纹不锈钢
                                                            </td>
                                                            <!-- <td>各
                                                                <input name="text7" type="text" id="scmmt6" onkeyup="setFsctmmt('scmmt6');" class="form-control"/>
                                                                                                                                                                                                 套                                                                                                                             
                                                            </td> -->
                                                          </tr>
                                                          
                                                          <tr>
                                                            <td width="125">大门套:
                                                                <select id="FSC_DMT" name="FSC_DMT" onchange="editTmmt('FSC_DMT');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="喷涂" ${pd.FSC_DMT=='喷涂'?'selected':''}>喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.FSC_DMT=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="镜面不锈钢" ${pd.FSC_DMT=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                </select>
                                                            </td>
                                                            <td width="198">
                                                                                                                                                                                              各
                                                                <input name="FSCDMT_SL" id="FSC_DMT_SL" type="text" onkeyup="setFsctmmt('FSC_DMT_SL');" class="form-control" value="${pd.FSCDMT_SL}"/>
                                                                                                                                                                                              套
                                                            </td>
                                                            <td width="50">
                                                              <input type="text" name="FSC_DMT_TEMP" id="FSC_DMT_TEMP" class="form-control" readonly="readonly">
                                                              <input type="hidden" name="FSC_DMT_TEMP2" id="FSC_DMT_TEMP2" class="form-control">
                                                            </td>
                                                          </tr>
                                                          
                                                          <tr>
                                                            <td colspan="2">备注</td>
                                                            <td colspan="5">
                                                                                                                                                                                              厅门和门套的数量,不管单台还是并联或多台群控,必须按单台计算,并注明合同号,多台可连写
                                                            </td>
                                                          </tr>
                                                        </table>
                                                    <!-- 厅门门套 -->
                                                </div>
                                                <div id="tab-7" class="tab-pane">
                                                    <!-- 操纵盘 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>操纵盘类型</td>
                                                            <td>
                                                                <select name="CZP_CZPLX" id="CZP_CZPLX" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value='IPX3' ${pd.CZP_CZPLX=='IPX3'?'selected':''}>IPX3</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td>
                                                                加价
                                                                <input type="hidden" name="CZP_XS_TEMP" id="CZP_XS_TEMP">
                                                                <input type="hidden" name="CZP_AN_TEMP" id="CZP_AN_TEMP">
                                                                <input type="hidden" name="CZP_CZ_TEMP" id="CZP_CZ_TEMP">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>操纵盘型号</td>
                                                            <td>
                                                                <p>
                                                                    <input type="radio" name="CZP_CZPXH" value="JFCOP09H-C1" onclick="setCzpxhDisable('2');" ${pd.CZP_CZPXH=='JFCOP09H-C1'?'checked':''}/>
                                                                    JFCOP09H-C1(标配只勾选本行,下列不必选)
                                                                </p>
                                                                <p>
                                                                    显示
                                                                    <select name="CZP_XS" id="CZP_XS_1" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="LCD(标配)" ${pd.CZP_XS=='LCD(标配)'?'selected':''}>LCD(标配)</option>
                                                                        <option value="LED(无偿选配)" ${pd.CZP_XS=='LED(无偿选配)'?'selected':''}>LED(无偿选配)</option>
                                                                        <option value="TFT(彩色液晶)" ${pd.CZP_XS=='TFT(彩色液晶)'?'selected':''}>TFT(彩色液晶)</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                    <select name="CZP_XS_SUB" id="CZP_XS_SUB" onchange="editCzp('CZP_CZPXH');" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="真彩液晶图片显示7寸" ${pd.CZP_XS_SUB=='真彩液晶图片显示7寸'?'selected':''}>真彩液晶图片显示7寸</option>
                                                                        <option value="真彩液晶图片显示10寸" ${pd.CZP_XS_SUB=='真彩液晶图片显示10寸'?'selected':''}>真彩液晶图片显示10寸</option>
                                                                        <option value="真彩液晶多媒体显示10.4寸" ${pd.CZP_XS_SUB=='真彩液晶多媒体显示10.4寸'?'selected':''}>真彩液晶多媒体显示10.4寸</option>
                                                                    </select>
                                                                </p>
                                                                <p>
                                                                    按钮
                                                                    <select name="CZP_AN" onchange="editCzp('CZP_CZPXH');" id="CZP_AN_1" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="金属红光带字牌按钮" ${pd.CZP_AN=='金属红光带字牌按钮'?'selected':''}>金属红光带字牌按钮</option>
                                                                        <option value="金属红光方按钮" ${pd.CZP_AN=='金属红光方按钮'?'selected':''}>金属红光方按钮</option>
                                                                        <option value="亚克力红光白字圆按钮" ${pd.CZP_AN=='亚克力红光白字圆按钮'?'selected':''}>亚克力红光白字圆按钮</option>
                                                                        <option value="亚克力红光白字方按钮" ${pd.CZP_AN=='亚克力红光白字方按钮'?'selected':''}>亚克力红光白字方按钮</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                                <p>
                                                                    材质
                                                                    <select name="CZP_CZ" onchange="editCzp('CZP_CZPXH');" id="CZP_CZ_1" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value='发纹不锈钢(标准)' ${pd.CZP_CZ=='发纹不锈钢(标准)'?'selected':''}>发纹不锈钢(标准)</option>
                                                                        <option value="镜面不锈钢" ${pd.CZP_CZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                        <option value="钛金不锈钢" ${pd.CZP_CZ=='钛金不锈钢'?'selected':''}>钛金不锈钢</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <p>
                                                                    <input name="CZP_CZPXH" type="radio" value="XFCOP01H-C" onclick="setCzpxhDisable('1');" ${pd.CZP_CZPXH=='XFCOP01H-C'?'checked':''}/>
                                                                    XFCOP01H-C
                                                                </p>
                                                                <p>
                                                                    显示
                                                                    <select name="CZP_XS" id="CZP_XS_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="LCD(标配)" ${pd.CZP_XS=='LCD(标配)'?'selected':''}>LCD(标配)</option>
                                                                        <option value="LED(无偿选配)" ${pd.CZP_XS=='LED(无偿选配)'?'selected':''}>LED(无偿选配)</option>
                                                                        <option value="TFT(有偿选配)" ${pd.CZP_XS=='TFT(有偿选配)'?'selected':''}>TFT(有偿选配)</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                                <p>
                                                                    按钮
                                                                    <select name="CZP_AN" id="CZP_AN_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="BAS241(标配)" ${pd.CZP_AN=='BAS241(标配)'?'selected':''}>BAS241(标配)</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                                <p>
                                                                    材质
                                                                    <select name="CZP_CZ" id="CZP_CZ_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="发纹不锈钢" ${pd.CZP_CZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                        <option value="镜面不锈钢" ${pd.CZP_CZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                            </td>
                                                            <td><input type="text" name="CZP_CZPXH_TEMP" id="CZP_CZPXH_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>操纵盘位置</td>
                                                            <td>
                                                                <select name="CZP_CZPWZ" id="CZP_CZPWZ" onchange="editCzp('CZP_CZPWZ');" class="form-control">
                                                                    <option value="右前(站在层站面向轿厢)" ${pd.CZP_CZPWZ=='右前(站在层站面向轿厢)'?'selected':''}>右前(站在层站面向轿厢)</option>
                                                                    <option value="左前(站在层站面向轿厢)" ${pd.CZP_CZPWZ=='左前(站在层站面向轿厢)'?'selected':''}>左前(站在层站面向轿厢)</option>
                                                                    <option value="右侧围壁(站在层站面向轿厢)" ${pd.CZP_CZPWZ=='右侧围壁(站在层站面向轿厢)'?'selected':''}>右侧围壁(站在层站面向轿厢)</option>
                                                                    <option value="左侧围壁(站在层站面向轿厢)" ${pd.CZP_CZPWZ=='左侧围壁(站在层站面向轿厢)'?'selected':''}>左侧围壁(站在层站面向轿厢)</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <%-- <tr>
                                                            <td rowspan="2">
                                                                <input name="CZP_CZPWZ" type="radio" value="左前" ${pd.CZP_CZPWZ=='左前'?'checked':''}/>
                                                                左前
                                                            </td>
                                                            <td>
                                                                <input name="CZP_CZPWZ" type="radio" value="左侧" ${pd.CZP_CZPWZ=='左侧'?'checked':''}/>
                                                                左侧(窄/深轿厢可选,担架梯标配)
                                                            </td>
                                                            <td rowspan="2"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>
                                                                <input name="CZP_CZPWZ" type="radio" value="右前" ${pd.CZP_CZPWZ=='右前'?'checked':''}/>
                                                                右前
                                                            </td>
                                                          </tr> --%>
                                                        </table>
                                                    <!-- 操纵盘 -->
                                                </div>
                                                <div id="tab-8" class="tab-pane">
                                                    <!-- 厅门信号装置 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>厅外召唤类型</td>
                                                            <td colspan="2">标准:无底盒</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>厅外召唤型号</td>
                                                            <td colspan="2">
                                                                <p>
                                                                    <input name="TMXHZZ_TWZHXH" type="radio" value="JFHB09H-D1" onclick="setTwzhxhDisable('2');"  ${pd.TMXHZZ_TWZHXH=='JFHB09H-D1'?'checked':''}/>
                                                                    XFHB01H-C(标配只勾选本行,下列不必选)
                                                                </p>
                                                                <p>
                                                                    显示
                                                                    <select name="TMXHZZ_XS" id="TMXHZZ_XS_1" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="LCD(标配)" ${pd.TMXHZZ_XS=='LCD(标配)'?'selected':''}>LCD(标配)</option>
                                                                        <option value="LED(无偿选配)" ${pd.TMXHZZ_XS=='LED(无偿选配)'?'selected':''}>LED(无偿选配)</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                                <p>
                                                                    按钮
                                                                    <select name="TMXHZZ_AN" id="TMXHZZ_AN_1" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="BAS241(标准)" ${pd.TMXHZZ_AN=='BAS241(标准)'?'selected':''}>BAS241(标准)</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                                <p>
                                                                    材质
                                                                    <select name="TMXHZZ_CZ" onchange="editTmxhzz('TMXHZZ_CZ');" id="TMXHZZ_CZ_1" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="发纹不锈钢(标准)" ${pd.TMXHZZ_CZ=='发纹不锈钢(标准)'?'selected':''}>发纹不锈钢(标准)</option>
                                                                        <option value="镜面不锈钢" ${pd.TMXHZZ_CZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                        <option value="钛金不锈钢" ${pd.TMXHZZ_CZ=='钛金不锈钢'?'selected':''}>钛金不锈钢</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <%-- <p>
                                                                    <input name="TMXHZZ_TWZHXH" type="radio" value="JFHB09H-D" onclick="setTwzhxhDisable('1');"/>
                                                                    JFHB09H-D
                                                                </p>
                                                                <p>
                                                                    显示 
                                                                    <select name="TMXHZZ_XS" id="TMXHZZ_XS_2" class="form-control">
                                                                      <option value="">请选择</option>
                                                                      <option value="LCD" ${pd.TMXHZZ_XS=='LCD'?'selected':''}>LCD</option>
                                                                      <option value="LED" ${pd.TMXHZZ_XS=='LED'?'selected':''}>LED</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                                <p>
                                                                    按钮
                                                                    <select name="TMXHZZ_AN" id="TMXHZZ_AN_2" class="form-control">
                                                                      <option value="">请选择</option>
                                                                      <option value="BAS241" ${pd.TMXHZZ_AN=='BAS241'?'selected':''}>BAS241</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p>
                                                                <p>
                                                                    材质
                                                                    <select name="TMXHZZ_CZ" onchange="editTmxhzz('TMXHZZ_CZ_2');" id="TMXHZZ_CZ_2" class="form-control">
                                                                        <option value="">请选择</option>
                                                                        <option value="发纹不锈钢" ${pd.TMXHZZ_CZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                        <option value="镜面不锈钢" ${pd.TMXHZZ_CZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option>
                                                                        <option value="钛金不锈钢" ${pd.TMXHZZ_CZ=='钛金不锈钢'?'selected':''}>钛金不锈钢</option>
                                                                    </select>
                                                                    (选配时填写)
                                                                </p> --%>
                                                                <input type="text" name="TMXHZZ_CZ_TEMP" id="TMXHZZ_CZ_TEMP" class="form-control" readonly="readonly">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="2">厅外召唤形式</td>
                                                            <td colspan="2">
                                                                <select name="TMXHZZ_TWZHXS_XX" id="TMXHZZ_TWZHXS_XX" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="单个" ${pd.TMXHZZ_TWZHXS_XX=='单个'?'selected':''}>单个</option>
                                                                    <option value="两台合用一个" ${pd.TMXHZZ_TWZHXS_XX=='两台合用一个'?'selected':''}>两台合用一个</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">
                                                                <p>
                                                                    在
                                                                    <input name="TMXHZZ_ZDJC" type="text"  id="TMXHZZ_ZDJC_1" class="form-control" style="width: 80px" value="${pd.TMXHZZ_ZDJC}"/>
                                                                    层、每层
                                                                    <input name="TMXHZZ_MCGS" type="text" id="TMXHZZ_MCGS_1" class="form-control" style="width: 80px" value="${pd.TMXHZZ_MCGS}"/>
                                                                    个
                                                                </p>
                                                                <p>
                                                                    附加说明:
                                                                    <input name="TMXHZZ_FJSM" type="text" id="TMXHZZ_FJSM_1" class="form-control" value="${pd.TMXHZZ_FJSM}"/>
                                                                </p>
                                                            </td>
                                                           <%--  <td>
                                                                <p>
                                                                    在
                                                                    <input name="TMXHZZ_ZDJC" type="text" id="TMXHZZ_ZDJC_2" class="form-control" style="width: 80px" value="${pd.TMXHZZ_ZDJC}"/>
                                                                    层、每层
                                                                    <input name="TMXHZZ_MCGS" type="text" id="TMXHZZ_MCGS_2" class="form-control" style="width: 80px" value="${pd.TMXHZZ_MCGS}"/>
                                                                    个
                                                                </p>
                                                                <p>
                                                                    附加说明:
                                                                    <input name="TMXHZZ_FJSM" type="text" id="TMXHZZ_FJSM_2" class="form-control" value="${pd.TMXHZZ_FJSM}"/>
                                                                </p>
                                                            </td> --%>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>挂壁式残疾人操纵箱:</td>
                                                            <td colspan="2">
                                                                <input type="checkbox" name="TMXHZZ_WZYCOPMWAN_TEXT" id="TMXHZZ_WZYCOPMWAN_TEXT" onclick="editTmxhzz('TMXHZZ_WZYCOPMWAN');" ${pd.TMXHZZ_WZYCOPMWAN=='1'?'checked':''}>
                                                                <input type="hidden" name="TMXHZZ_WZYCOPMWAN" id="TMXHZZ_WZYCOPMWAN">
                                                            </td>
                                                            <td><input type="text" name="TMXHZZ_WZYCOPMWAN_TEMP" id="TMXHZZ_WZYCOPMWAN_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>外召与COP盲文按钮:</td>
                                                            <td colspan="2">
                                                                <input type="checkbox" name="TMXHZZ_GBSCJRCZX_TEXT" id="TMXHZZ_GBSCJRCZX_TEXT" ${pd.TMXHZZ_GBSCJRCZX=='1'?'checked':''}>
                                                                <input type="hidden" name="TMXHZZ_GBSCJRCZX" id="TMXHZZ_GBSCJRCZX">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>备注:</td>
                                                            <td colspan="3">
                                                                1.填写厅外召唤所在层时,请用实际楼层标记填写;2.厅外召唤形式图例仅作示意,当楼层标记为一位数时,数字显示为一位数,在顶层只有一个向下按钮,在底层只有一个向上按钮;3.驻停楼层的厅外召唤带钥匙开关;4.厅外召唤样式(HBtype)有单个(Single)和两台合用一个(Duplex)两种
                                                            </td>
                                                          </tr>
                                                        </table>
                                                    <!-- 厅门信号装置 -->
                                                </div>
                                                <div id="tab-9" class="tab-pane">
                                                	<input type="hidden" id="OPT_FB_TEMP" class="form-control">
                                                    <!-- 非标 -->
                                                    <%@include file="nonstanard_detail.jsp" %>
                                                    <!-- 非标 -->
                                                </div>
                                                
                                                
                                                <div id="tab-10" class="tab-pane">
                                                    <!-- 常规非标 -->
                                                    <%@include file="conventional_nonstandard.jsp" %>
                                                    <!-- 常规非标 -->
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
                                        备注
                                    </div>
                                    <div class="panel-body">
                                        <textarea style="width:100%" rows="3" cols="1" name="DT_REMARK">${pd.DT_REMARK}</textarea>
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
                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
	                                      <!-- 基准价 -->
	                                      <tr>
	                                        <td>安装费（基准价）（元/台）</td>
	                                        <td>
	                                            <input type="text" name="JZJ_DTJZJ" id="JZJ_DTJZJ" class="form-control" readonly="readonly" value="${pd.JZJ_DTJZJ }">
	                                            <input type="hidden" id="initFloor" value="${regelevStandardPd.C}"> 
	                                        </td>
	                                        <td>
	                                        是否设备安装一体合同
	                                        </td>
	                                        <td><input type="checkbox" id="JZJ_IS_YTHT" name="JZJ_IS_YTHT" onclick="changeSSCount()" ${pd.JZJ_IS_YTHT=='1'?'checked':'' }>
	                                        	<input type="hidden" name="JZJ_IS_YTHT_VAL" id="JZJ_IS_YTHT_VAL" value="${pd.JZJ_IS_YTHT}">
	                                        </td>
	                                        <td>单台专用税收补偿（元/台）</td>
	                                        <td>
	                                          <input type="text" name="JZJ_SSBC" id="JZJ_SSBC" class="form-control" readonly="readonly" value="${pd.JZJ_SSBC }">    
	                                        </td>
	                                      </tr>
	                                      <tr>
	                                        <td>单台安装费（最终基准价）（元/台）</td>
	                                        <td>
	                                        	<input type="text" name="JZJ_DTZJ" id="JZJ_DTZJ" class="form-control" readonly="readonly" value="${pd.JZJ_DTZJ }">
	                                        </td>
	                                        <td>总价（元）</td>
	                                        <td >
	                                            <input type="text" name="JZJ_AZF" id="JZJ_AZF" class="form-control"  readonly="readonly" value="${pd.JZJ_AZF }">
	                                        </td>
	                                        <td colspan="2"></td>
	                                      </tr>
	                                      <tr>
	                                      	<td colspan="6"></td>
	                                      </tr>
	                                      <!-- 手填价格 -->
	                                      <tr>
	                                        <td>安装费（元/台）</td>
	                                        <td>
	                                            <input type="text" name="ELE_DTAZF" id="ELE_DTAZF" value="${pd.ELE_DTAZF }" 
	                                            onkeyup="value=value.replace(/[^\-?\d.]/g,'')" oninput="countSDPrice();" class="form-control">
	                                        </td>
	                                        <td>政府验收费（元/台）</td>
	                                        <td><input type="text" id="ELE_ZFYSF" NAME="ELE_ZFYSF"  value="${pd.ELE_ZFYSF }"  
	                                        onkeyup="value=value.replace(/[^\-?\d.]/g,'')" oninput="countSDPrice();" class="form-control"></td>
	                                        <td>免保期超出1年计费（元/台）</td>
	                                        <td>
	                                          <input type="text" name="ELE_MBJF" id="ELE_MBJF" value="${pd.ELE_MBJF }" 
	                                          onkeyup="value=value.replace(/[^\-?\d.]/g,'')" oninput="countSDPrice();" class="form-control">    
	                                        </td>
	                                      </tr>
	                                      <tr>
	                                        <td>合同约定其他费用（元/台）</td>
	                                        <td><input type="text" name="ELE_QTSF" id="ELE_QTSF" value="${pd.ELE_QTSF }"
	                                         onkeyup="value=value.replace(/[^\-?\d.]/g,'')" oninput="countSDPrice();" class="form-control"></td>
	                                        <td>安装总价（元/台）</td>
	                                        <td>
	                                            <input type="text" name="ELE_DTZJ" id="ELE_DTZJ" class="form-control" readonly="readonly" value="${pd.ELE_DTZJ }">
	                                        </td>
	                                        <td>安装总价（元）</td>
	                                        <td>
	                                            <input type="text" name="ELE_AZF" id="ELE_AZF" class="form-control" readonly="readonly" value="${pd.ELE_AZF }">
	                                        </td>
	                                      </tr>
	                                      <tr>
	                                      	<td colspan="6"></td>
	                                      </tr>
	                                      <!-- 其它价格 -->
	                                       <tr>
	                                        <td>工程类型</td>
	                                        <td>
	                                            <select id="OTHP_GCLX" name="OTHP_GCLX" onchange="changeCJPrice();" class="form-control">
                                                	<option value="买断" ${pd.OTHP_GCLX=='买断'?'selected':'' }>买断</option>
                                                	<option value="厂检" ${pd.OTHP_GCLX=='厂检'?'selected':'' }>厂检</option>
                                                	<option value="验收" ${pd.OTHP_GCLX=='验收'?'selected':'' }>验收</option>
                                            	</select>
	                                        </td>
	                                        <td>厂检费（元）</td>
	                                        <td><input type="text" name="OTHP_CJF" id="OTHP_CJF" class="form-control" readonly="readonly" value="${pd.OTHP_CJF }"> </td>
	                                        <td rowspan="2">调试/厂检总价（元）</td>
	                                        <td rowspan="2">
	                                          <input type="text" name="OTHP_ZJ" id="OTHP_ZJ" class="form-control" readonly="readonly" value="${pd.OTHP_ZJ }">    
	                                        </td>
	                                      </tr>
	                                      <tr>
	                                        <td>调试费</td>
	                                        <td>
	                                        	<input type="checkbox" id="OTHP_ISTSF" name="OTHP_ISTSF"  onclick="changeCJPrice();" ${pd.OTHP_ISTSF=='1'?'checked':'' }> 
	                                        	<input type="hidden" id="OTHP_ISTSF_VAL" name="OTHP_ISTSF_VAL" value="${pd.OTHP_ISTSF }">
	                                        </td>
	                                        <td>调试费（元）</td>
	                                        <td><input type="text" name="OTHP_TSF" id="OTHP_TSF" class="form-control" readonly="readonly" value="${pd.OTHP_TSF }"></td>
	                                      </tr>
	                                      <tr>
	                                      	<td colspan="6"></td>
	                                      </tr>
	                                      <tr>
	                                        <td>总价（元）</td>
	                                        <td >
	                                            <input type="text" name="FEIYANGXF_AZF_TEMP" id="FEIYANGXF_AZF_TEMP" class="form-control" readonly="readonly" value="${pd.FEIYUE_AZF }">
	                                        </td>
	                                        <td colspan="4"></td>
	                                      </tr>
	                                    </table> 
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
                                                <option value="1" ${pd.trans_type=="1"?"selected":""}>整车</option>
                                                <option value="2" ${pd.trans_type=="2"?"selected":""}>零担</option>
                                                <option value="3" ${pd.trans_type=="3"?"selected":""}>自提</option>
                                            </select>
                                            <span id="qy">
                                            <label>请选择区域:</label>
                                            <select id="province_id" name="province_id" class="form-control m-b" onchange="setCity();">
                                                <option value="">请选择区域</option>
                                                <c:forEach var="province" items="${provinceList}">
                                                    <option value="${province.id }"${pd.province_id==province.id?"selected":""}>${province.name }</option>
                                                </c:forEach>
                                            </select>

                                            <label>请选择目的地:</label>
                                            <select id="destin_id" name="destin_id" class="form-control m-b">
                                                <option value="">请选择目的地</option>
                                                <c:if test="${not empty cityList}">
                                                    <c:forEach var="city" items="${cityList}">
                                                        <option value="${city.id }" ${pd.destin_id==city.id?"selected":""}>${city.name }</option>
                                                    </c:forEach>
                                                </c:if>
                                            </select>
                                             <span id="ld"  ${pd.trans_type!="2"?"style='display:none;'":""}>
                                            <label>吨数:</label>
                                            <input type="text" id="less_num" name="less_num" class="form-control m-b" value="${pd.less_num}">
                                             </span>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="form-group form-inline" id="zc"  ${pd.trans_type!=null&&pd.trans_type!="1"?"style='display:none;'":""}>
                                        <input type="hidden" name="trans_more_car" id="trans_more_car">
                                        <table id="transTable">
                                            <c:if test="${not empty tmc_list}">
                                                <c:forEach var="tmc" items="${tmc_list}" varStatus="vs">
                                                    <tr>
                                                        <td>
                                                            <label>&nbsp;&nbsp;&nbsp;车型:&nbsp;</label>
                                                            <select class="form-control m-b"name="car_type">
                                                                <option value="" ${tmc.car_type==""?"selected":""}>请选择车型</option>
                                                                <option value="5" ${tmc.car_type=="5"?"selected":""}>5T车(6.2-7.2米)</option>
                                                                <option value="8" ${tmc.car_type=="8"?"selected":""}>8T车(8.2-9.6米)</option>
                                                                <option value="10" ${tmc.car_type=="10"?"selected":""}>10T车(12.5米)</option>
                                                                <option value="20" ${tmc.car_type=="20"?"selected":""}>20T车(17.5米)</option>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <label>&nbsp;&nbsp;&nbsp;数量:&nbsp;</label>
                                                            <input type="text" class="form-control m-b"name="car_num" value="${tmc.car_num}">
                                                        </td>
                                                        <td>
                                                            <c:if test="${vs.index==0}">
                                                                <input type="button" value="添加" onclick="addRow();" class="btn-sm btn-success m-b">
                                                            </c:if>
                                                            <c:if test="${vs.index!=0}">
                                                                <input type="button" value="删除" onclick="delRow(this)" class="btn-sm btn-danger m-b">
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${empty tmc_list}">
                                                <tr>
                                                    <td>
                                                        <label>&nbsp;&nbsp;&nbsp;车型:&nbsp;</label>
                                                        <select class="form-control m-b"name="car_type">
                                                            <option value="">请选择车型</option>
                                                            <option value="5">5T车(6.2-7.2米)</option>
                                                            <option value="8">8T车(8.2-9.6米)</option>
                                                            <option value="10">10T车(12.5米)</option>
                                                            <option value="20">20T车(17.5米)</option>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <label>&nbsp;&nbsp;&nbsp;数量:&nbsp;</label>
                                                        <input type="text" class="form-control m-b"name="car_num">
                                                    </td>
                                                    <td>
                                                        <input type="button" value="添加" onclick="addRow();" class="btn-sm btn-success m-b">
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </table>
                                    </div>
                                    <div class="form-group form-inline">
                                        &nbsp;&nbsp;&nbsp;
                                        <input type="button" value="确定" id="setPriceButton" onclick="setPriceTrans();" class="btn-sm btn-warning m-b">
                                        运输价格(元):
                                        <input type="text" id="trans_price" name="trans_price" class="form-control" oninput="countTransPrice()" value="${pd.FEIYANG_XF_YSJ}">
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
        <td>
            <c:if test="${forwardMsg!='view'}">
                <a class="btn btn-primary" style="width: 150px; height:34px;float:left;margin:0px 10px 30px 10px;"  onclick="save();">保存</a>
            </c:if>
        </td>
        <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;margin:0px 10px 30px 10px;" onclick="javascript:CloseSUWin('ElevatorParam');">关闭</a></td>
    </tr>

<script src="static/js/sweetalert/sweetalert.min.js"></script>
<script src="static/js/iCheck/icheck.min.js"></script>
<script type="text/javascript">

    $(document).ready(function(){
        $("#tab-1").addClass("active");
        
        
        //加载标准价格,初始化关联选项
        editZz();
        editSd();
        setSbj();
        $("#BZ_C").val("${regelevStandardPd.C}");
        $("#BZ_Z").val("${regelevStandardPd.Z}");
        $("#BZ_M").val("${regelevStandardPd.M}");

        if("${pd.view}"=="edit")
		{
			$("#BZ_C").val("${pd.BZ_C}");
	        $("#BZ_Z").val("${pd.BZ_Z}");
	        $("#BZ_M").val("${pd.BZ_M}");
		}
        
        if("${cbjFlag}"=="1")
		{
        	
	        $("#BZ_ZZ").val("${pd.BZ_ZZ}");
	        
	        $("#BZ_SD").val("${pd.BZ_SD}");
	        $("#BZ_SD").change();
			$("#BZ_C").val("${pd.BZ_C}");
	        $("#BZ_Z").val("${pd.BZ_Z}");
	        $("#BZ_M").val("${pd.BZ_M}");
	        $("#BZ_KMKD").val("${pd.BZ_KMKD}");
		}
        
        bindSelect2AndInitDate($('#BZ_C'), "${pd.BZ_C}");
        bindSelect2AndInitDate($('#BZ_Z'), "${pd.BZ_Z}");
        bindSelect2AndInitDate($('#BZ_M'), "${pd.BZ_M}");
        bindSelect2AndInitDate($('#BZ_ZZ'), "${pd.BZ_ZZ}");
        bindSelect2AndInitDate($('#BZ_SD'), "${pd.BZ_SD}");
        bindSelect2AndInitDate($('#BZ_KMKD'), "${pd.BZ_KMKD}");
        initBindSelect("${pd.BASE_JXGG}");
        
        if("${pd.CZP_CZPXH}"=='JFCOP09H-C'){
        	setCzpxhDisable('1');
        }else{
        	setCzpxhDisable('2');
        }
        
        if("${pd.view}"=="edit")
		{
        	$("#DMT_SL").val("${pd.DMT_SL}");
	        $("#scmmt1").val("${pd.FDMT_SL}");
	        $("#FSC_DMT_SL").val("${pd.FSCDMT_SL}");
	        $("#scmmt4").val("${pd.FSCFDMT_SL}");
		}else{
			//赋默认值
	        $("#DMT_SL").val(1);
	        $("#scmmt1").val(1);
	        var bz_m = $("#BZ_M").val();
	        if (bz_m>0) {
	        	$("#FSC_DMT_SL").val($("#BZ_M").val()-1);
		        $("#scmmt4").val($("#BZ_M").val()-1);
			}else{
				$("#FSC_DMT_SL").val("0");
		        $("#scmmt4").val("0");
			}
		}

        //调用初始化贯通门
        Jsgtms();
        
        var FLAG = $("#FLAG").val();
        if(FLAG=="CBJ"||FLAG=="ZHJ"){
            cbjPrice();
        }
        if("${pd.view}"=="edit"){
            cbjPrice();
        }

        var forwardMsg = "${forwardMsg}";
        if(forwardMsg=='view'){
            //查看页面设置disable
            var inputs = document.getElementsByTagName("input");
            for(var i = 0;i<inputs.length;i++){
                inputs[i].setAttribute("disabled","true");
            }
            var textareas = document.getElementsByTagName("textarea");
            for(var i = 0;i<textareas.length;i++){
                textareas[i].setAttribute("disabled","true");
            }
            var selects = document.getElementsByTagName("select");
            for(var i = 0;i<selects.length;i++){
                selects[i].setAttribute("disabled","true");
            }
        }
        setTimeout(function(){
            cbjPrice();
            setSbj();
        },500);
        countInstallPrice();
        
        //加载运输模块显示 
        if("${pd.trans_type}"!=null && "${pd.trans_type}"!=""){
        	$("#trans_type").val("${pd.trans_type}");
            hideDiv();
        }else{
        	$("#trans_type").val(1);
        }
        
        updateFbX();
    });

    //根据门数和站数计算贯通门数
    function Jsgtms()
    {
    	var bz_m=parseInt_DN($("#BZ_M").val());
    	var bz_z=parseInt_DN($("#BZ_Z").val());
    	if (bz_m>0 && bz_z>0) {
    		if(bz_z>bz_m)
        	{
        		$("#OPT_GTMS_TEXT").val(0);
        	}else{
        		var gtms=bz_m-bz_z;
        		$("#OPT_GTMS_TEXT").val(gtms);
        	}
		}
    }
    
    //关闭当前页面
    function CloseSUWin(id) {
      window.parent.$("#" + id).data("kendoWindow").close();
    }

    //修改层时修改站和门
    function editC(){
        var c_ = $("#BZ_C").val();
        $("#BZ_Z").val(c_);
        $("#BZ_M").val(c_);
        setSbj();
        setMPrice();
        editTmxhzz('TMXHZZ_WZYCOPMWAN');

      	//超高和加价
        setJdzg();
    }

    //添加行,录入运输
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

  //计算基础价
    function setSbj(){
    	//调用初始化贯通门
        Jsgtms();
    	var sl_ = $("#FEIYANGXF_SL").val()==""?0:parseInt_DN($("#FEIYANGXF_SL").val());
        var sd_ = $("#BZ_SD").val();  //速度
        if(sd_=="1.0"){var sd=1;}
        else if(sd_=="2.0"){var sd=2;}
        else{var sd=sd_;}
        var c_ = $("#BZ_C").val();     //层站
        var zz_ = $("#BZ_ZZ").val();  //载重
        var models_name = $("#tz_").val();  //型号名称
        var price = 0;
        $.post("<%=basePath%>e_offer/setBascPrice",
                {
                    "SD": sd,
                    "ZZ": zz_,
                    "C": c_,
                    "NAME": models_name
                },function(result)
                {
                	if(basisDate.fbdj == null){
                		if(result.msg=="success")
                        {
                            if(result.pd!=null){
                                $("#SBJ_TEMP").val(result.pd.PRICE*sl_);
                                $("#DANJIA").val(result.pd.PRICE);
                            }else{
                                $("#SBJ_TEMP").val(0);
                                $("#DANJIA").val(0);
                            }
                            
                            setMPrice();
                            
                            countZhj();
                            
                            //调用计算折扣
                            JS_SJBJ();
                        }
                	} else {
                		$("#SBJ_TEMP").val(basisDate.fbdj*sl_);
        	            $("#DANJIA").val(basisDate.fbdj);
                        setMPrice();
                        countZhj();
                        //调用计算折扣
                        JS_SJBJ();
                	}
                });
    }
    
   

    function cbjPrice(){
        //井道总高
        setJdzg();
        //导轨支架
        setDgzj();
        //可选项
        editOpt('OPT_FDLCZ');
        editOpt('OPT_HJZDFHJZ');
        editOpt('OPT_JXDZZ');
        editOpt('OPT_CCTVDL');
        editOpt('OPT_TDJJJY');
        editOpt('OPT_DJGRBH');
        editOpt('OPT_KQJHZZ');
        editOpt('OPT_NMYKJAN');
        editOpt('OPT_ZPC');
        editOpt('OPT_BAJK');
        editOpt('OPT_YYBZ');
        editOpt('OPT_DZYX');
        editOpt('OPT_NLHK');
        editOpt('OPT_YCJK');
        editOpt('OPT_ICK');
        editOpt('OPT_ICKZKSB');
        editOpt('OPT_ICKKP');
        editOpt('OPT_PTDTKT');
        editOpt('OPT_ZYFTSDTKT');
        editOpt('OPT_JKGM');
        editOpt('OPT_JKYYJ');
        editOpt('OPT_GTMJXJMBF');
        editOpt('OPT_GTMTMBF');
        editOpt('OPT_CMZH');
        //轿厢装潢
        editJxzh('JXZH_JM');
        editJxzh('JXZH_JMZH');
        editJxzh('JXZH_JXZH');
        editJxzh('JXZH_QWB');
        editJxzh('JXZH_CWB');
        editJxzh('JXZH_HWB');
        editJxzh('JXZH_ZSDD');
        editJxzh('JXZH_BGJ');
        editJxzh('JXZH_DBXH');
        editJxzh('JXZH_YLZHZL');
        editJxzh('JXZH_FSXH');
        editJxzh('JXZH_FSAZWZ');
        //厅门门套
        editTmmt('TMMT_JZBXGXMT');
        editTmmt('TMMT_PTDMT');
        editTmmt('TMMT_PTJMBXGTM');
        editTmmt('TMMT_SCTMMT');
        editTmmt('TMMT_FSCTMMT');
        editTmmt('FSC_DMT');
        //厅门信号装置
        editTmxhzz('TMXHZZ_CZ');
        editTmxhzz('TMXHZZ_WZYCOPMWAN');
        
        //加载页面初始化常规非标加价
        editMTBH('CGFB_MTBH443');
        editMTBH('CGFB_MTBHSUS304');
        editMTBH('CGFB_MTBH15SUS304');
        editMTBH('CGFB_MTBH1215');
        editMTBH('CGFB_JXHL');
        editMTBH('CGFB_DLSB');
        editMTBH('CGFB_DZCZ');
        editMTBH('CGFB_KMGD');
        editMTBH('CGFB_DKIP65');
        editMTBH('CGFB_PKM');
        editMTBH('CGFB_ZFSZ2000');
        editMTBH('CGFB_ZFSZ3000');
        editMTBH('CGFB_ZFSZAQB');
        editMTBH('CGFB_JXCC');
        editMTBH('CGFB_TDYJ');
        editMTBH('CGFB_JJFAJMK');
        editMTBH('CGFB_JJFACXK');
        
        if("${pd.CGFB_JXCLBH}"=='由减振复合不锈钢变更为443发纹不锈钢'){
        	CGFBJXCLBH('1');
        }else if("${pd.CGFB_JXCLBH}"=='由减震复合不锈钢变更为1.5mmSUS304发纹不锈钢'){
        	CGFBJXCLBH('2');
        }else if("${pd.CGFB_JXCLBH}"=='减震复合不锈钢厚度由1.2mm增加到1.5mm'){
        	CGFBJXCLBH('3');
        }else if("${pd.CGFB_JXCLBH}"=='由减振复合不锈钢变更为SUS304发纹不锈钢'){
        	CGFBJXCLBH('4')
        }else if("${pd.CGFB_JXCLBH}"=='轿厢后壁中间一块采用镜面不锈钢，宽度约600mm'){
        	CGFBJXCLBH('5');
        }
        
        if("${pd.CGFB_GTJX}"=='JFCOPO9H-C1'){
        	CGFBGTJX('1');
        }else if("${pd.CGFB_GTJX}"=='JFCOPO5P-E'){
        	CGFBGTJX('2');
        }
    }


    //调用参考报价
    function selCbj(){
        var modelsId = $("#MODELS_ID").val();
        //获取当前数量
        var sl_ = $("#FEIYANGXF_SL").val();
        var item_id = $("#ITEM_ID").val();
        var offer_version = $("#offer_version").val();
        $("#cbjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selCbj.do?models=feiyangxf&FEIYANGXF_SL="+sl_+
    		"&item_id="+item_id+"&offer_version="+offer_version,
            modal : true,
            visible : false,
            resizable : true
        }).data("kendoWindow").maximize().open();
    }

    //调用装潢价格
    function selZhj(){
        var modelsId = $("#MODELS_ID").val();
        //获取当前基础设备价格
        var zz_ = $("#BZ_ZZ").val();
        var sd_ = $("#BZ_SD").val();
        var kmxs_ = $("#BZ_KMXS").val();
        var kmkd_ = $("#BZ_KMKD").val();
        var c_ = $("#BZ_C").val();
        var z_ = $("#BZ_Z").val();
        var m_ = $("#BZ_M").val();
        var sl_ = $("#FEIYANGXF_SL").val();
        var zk_ = $("#FEIYANGXF_ZK").val();
        $("#zhjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selZhj.do?models=feiyangxf&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&FEIYANGXF_SL="+sl_+"&FEIYANGXF_ZK="+zk_,
            modal : true,
            visible : false,
            resizable : true
        }).data("kendoWindow").maximize().open();
    }

    //非标,点击添加行
    function addFbRow(){
        var tr = $("#fbTable tr").eq(1).clone();
        $(tr).find("td").eq(0).find("input").eq(0).val("");
        $(tr).find("td").eq(1).find("input").eq(0).val("");
        $(tr).find("td").eq(2).find("input").eq(0).val("");
        $(tr).find("td:last").html("").append("<td><input type='button' value='删除' onclick='delFbRow(this)'></td>");
        $("#fbTable").append(tr);
    }


    //设置disable--
    //井道承重墙厚度
    function setJdczqhdDisable(flag){
        if(flag=='1'){
            $("#BASE_JDCZQHD_TEXT").val("");
            $("#BASE_JDCZQHD_TEXT").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#BASE_JDCZQHD_TEXT').removeAttr("disabled"); 
        }
    }
    //门类型门保护
    function setMlxmbhDisable(flag){
        if(flag=='1'){
            $("#BASE_MLXMBH_TEXT").val("");
            $("#BASE_MLXMBH_TEXT").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#BASE_MLXMBH_TEXT').removeAttr("disabled"); 
        }
    }
    //轿厢装潢-轿门色标号
    function setJmsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_JMSBH").val("");
            $("#JXZH_JMSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_JMSBH').removeAttr("disabled"); 
            
        }
        editJxzh('JXZH_JM');
    }
    //轿厢装潢-前围壁色标号
    function setQwbsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_QWBSBH").val("");
            $("#JXZH_QWBSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_QWBSBH').removeAttr("disabled"); 
        }
        editJxzh('JXZH_QWB');
    }
    //轿厢装潢-侧围壁色标号
    function setCwbsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_CWBSBH").val("");
            $("#JXZH_CWBSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_CWBSBH').removeAttr("disabled"); 
        }
        editJxzh('JXZH_CWB');
    }
    //轿厢装潢-后围壁色标号
    function setHwbsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_HWBSBH").val("");
            $("#JXZH_HWBSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_HWBSBH').removeAttr("disabled"); 
        }
        editJxzh('JXZH_HWB');
    }
    //轿厢装潢-轿顶装潢
    function setJdzhDisable(flag){
        if(flag=="1"){
            $("#ZSDD_2").val("");
            $("#ZSDD_2").attr("disabled","disabled");
            $('#ZSDD_1').removeAttr("disabled"); 
        }else if(flag=="2"){
            $("#ZSDD_1").val("");
            $("#ZSDD_1").attr("disabled","disabled");
            $('#ZSDD_2').removeAttr("disabled"); 
        }else{
            $("#ZSDD_2").val("");
            $("#ZSDD_2").attr("disabled","disabled");
            $("#ZSDD_1").val("");
            $("#ZSDD_1").attr("disabled","disabled");
        }
    }
    //轿厢装潢-地板型号
    function setDbxhDisable(flag){
        if(flag=='1'){
            $("#JXZH_DBXH_SELECT").val("");
            $("#JXZH_DBXH_SELECT").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_DBXH_SELECT').removeAttr("disabled"); 
        }
    }
    //轿厢装潢-扶手型号
    function setFsxhDisable(flag){
        if(flag=='1'){
            $("#JXZH_FSXH_SELECT").val("无");
            $("#JXZH_FSXH_TEMP").val("");
            $("#JXZH_FSXH_SELECT").attr("disabled","disabled");
			$("#JXZH_FSAZWZ_TEMP").val("");
        }else if(flag=='0'){
            $('#JXZH_FSXH_SELECT').removeAttr("disabled"); 
            $("#JXZH_FSXH_TEMP").val("");
			$("#JXZH_FSAZWZ_TEMP").val("");
        }
    }
    //厅门门套-首层色标号
    function setScsbhDisable(flag)
    {
    	if(flag=='0'){
            $("#TMMT_SCSBH").val("");
            $("#TMMT_SCSBH").attr("disabled","disabled");
            $("#TMMT_SCTMMT_TEMP").val("");
            $("#TMMT_SCTMMT_TEMP2").val("");
        }else if(flag=='1'){
            $("#TMMT_SCSBH").val("");
            $("#TMMT_SCSBH").attr("disabled","disabled");
            $("#TMMT_SCTMMT_TEMP").val("");
            $("#TMMT_SCTMMT_TEMP2").val("");
        }
        else if(flag=='2')
        {
            $("#TMMT_SCSBH").val("");
            $("#TMMT_SCSBH").removeAttr("disabled");
            $("#TMMT_SCTMMT_TEMP").val("");
            $("#TMMT_SCTMMT_TEMP2").val("");
        }
    	
        editTmmt('TMMT_SCTMMT');
	  
    }
  //厅门门套-非首层色标号
    function setFscsbhDisable(flag)
    {
    	var m_=parseInt_DN($("#BZ_M").val());//门数
    	var scts_=parseInt_DN($("#DMT_SL").val());//首层套数
    	if (m_>0) {
    		if(flag=='0'){
        		$("#scmmt4").val(m_-scts_);
            	$('#TMMT_FSCSBH').removeAttr("disabled");
            	$("#TMMT_FSCSBH").val("");
            	$("#TMMT_FSCTMMT_TEMP").val("");
                $("#TMMT_FSCTMMT_TEMP2").val("");
            }else if(flag=='1'){
            	$("#scmmt4").val(m_-scts_);
            	$("#TMMT_FSCSBH").val("");
                $("#TMMT_FSCSBH").attr("disabled","disabled");
                $("#TMMT_FSCTMMT_TEMP").val("");
                $("#TMMT_FSCTMMT_TEMP2").val("");
            }
            else if(flag=='2'){
            	$("#scmmt4").val(m_-scts_);
                $("#TMMT_FSCTMMT_TEMP").val("");
                $("#TMMT_FSCTMMT_TEMP2").val("");
            }
            editTmmt('TMMT_FSCTMMT');
		}
    	
    }
    
  //首层厅门门套   根据套数 计算价格
    function setSctmmt(flag)
    {
    	if(flag=='scmmt1')
    	{
    		var sl1=parseInt_DN($("#scmmt1").val());
    		if(isNaN(sl1))
    		{
    			$("#TMMT_SCTMMT_TEMP").val($("#TMMT_SCTMMT_TEMP2").val());
    		}
    		else
    		{
    			var a1=parseInt_DN($("#TMMT_SCTMMT_TEMP2").val());
        		$("#TMMT_SCTMMT_TEMP").val(sl1*a1)
    		}
    	}
    	else if(flag=='DMT_SL')
    	{
    		var dmt_sl=parseInt_DN($("#DMT_SL").val());
    		if(isNaN(dmt_sl))
    		{
    			$("#TMMT_PTDMT_TEMP").val($("#TMMT_PTDMT_TEMP2").val());
    		}
    		else
    		{
    			var a4=parseInt_DN($("#TMMT_PTDMT_TEMP2").val());
        		$("#TMMT_PTDMT_TEMP").val(dmt_sl*a4)
    		}
    		
    	}
    	editTmmt('TMMT_FSCTMMT');
    }
    
    //非首层厅门门套   根据套数 计算价格
    function setFsctmmt(flag)
    {
    	if(flag=='scmmt4')
    	{
    		var sl1=parseInt_DN($("#scmmt4").val());
    		if(isNaN(sl1))
    		{
    			$("#TMMT_FSCTMMT_TEMP").val($("#TMMT_FSCTMMT_TEMP2").val());
    		}
    		else
    		{
    			var a1=parseInt_DN($("#TMMT_FSCTMMT_TEMP2").val());
        		$("#TMMT_FSCTMMT_TEMP").val(sl1*a1)
    		}
    	}else if(flag=='FSC_DMT_SL')
    	{
    		var sl4=parseInt_DN($("#FSC_DMT_SL").val());
    		if(isNaN(sl4))
    		{
    			$("#FSC_DMT_TEMP").val($("#FSC_DMT_TEMP2").val());
    		}
    		else
    		{
    			var a4=parseInt_DN($("#FSC_DMT_TEMP2").val());
        		$("#FSC_DMT_TEMP").val(sl4*a4)
    		}
    		
    	}
    	//更新价格
    	countZhj();
    }
    
    //操纵盘-操纵盘型号
    function setCzpxhDisable(flag){
        if(flag=='1'){
            $("#CZP_XS_1").val("");
            $("#CZP_XS_1").attr("disabled","disabled");
            $("#CZP_AN_1").val("");
            $("#CZP_AN_1").attr("disabled","disabled");
            $("#CZP_CZ_1").val("");
            $("#CZP_CZ_1").attr("disabled","disabled");
            $("#CZP_XS_SUB").val("");
            $("#CZP_XS_SUB").attr("disabled","disabled");
            $('#CZP_XS_2').removeAttr("disabled"); 
            $('#CZP_AN_2').removeAttr("disabled"); 
            $('#CZP_CZ_2').removeAttr("disabled");
            $("#CZP_CZPXH_TEMP").val("");
        }else if(flag=='2'){
            $("#CZP_XS_2").val("");
            $("#CZP_XS_2").attr("disabled","disabled");
            $("#CZP_AN_2").val("");
            $("#CZP_AN_2").attr("disabled","disabled");
            $("#CZP_CZ_2").val("");
            $("#CZP_CZ_2").attr("disabled","disabled");
            $('#CZP_XS_1').removeAttr("disabled"); 
            $('#CZP_AN_1').removeAttr("disabled"); 
            $('#CZP_CZ_1').removeAttr("disabled"); 
            $('#CZP_XS_SUB').removeAttr("disabled"); 
            $("#CZP_CZPXH_TEMP").val("");
        }
        editCzp('CZP_CZPXH');
    }
    //厅门信号装置-厅外召唤型号
    function setTwzhxhDisable(flag){
        if(flag=="1"){
            $("#TMXHZZ_XS_1").val("");
            $("#TMXHZZ_XS_1").attr("disabled","disabled");
            $("#TMXHZZ_AN_1").val("");
            $("#TMXHZZ_AN_1").attr("disabled","disabled");
            $("#TMXHZZ_CZ_1").val("");
            $("#TMXHZZ_CZ_1").attr("disabled","disabled");
            $("#TMXHZZ_ZDJC_1").val("");
            $("#TMXHZZ_ZDJC_1").attr("disabled","disabled");
            $("#TMXHZZ_MCGS_1").val("");
            $("#TMXHZZ_MCGS_1").attr("disabled","disabled");
            $("#TMXHZZ_FJSM_1").val("");
            $("#TMXHZZ_FJSM_1").attr("disabled","disabled");
            $('#TMXHZZ_XS_2').removeAttr("disabled"); 
            $('#TMXHZZ_AN_2').removeAttr("disabled"); 
            $('#TMXHZZ_CZ_2').removeAttr("disabled"); 
            $('#TMXHZZ_ZDJC_2').removeAttr("disabled"); 
            $('#TMXHZZ_MCGS_2').removeAttr("disabled"); 
            $('#TMXHZZ_FJSM_2').removeAttr("disabled"); 
            $("#TMXHZZ_CZ_TEMP").val("");
        }else if(flag=="2"){
            $("#TMXHZZ_XS_2").val("");
            $("#TMXHZZ_XS_2").attr("disabled","disabled");
            $("#TMXHZZ_AN_2").val("");
            $("#TMXHZZ_AN_2").attr("disabled","disabled");
            $("#TMXHZZ_CZ_2").val("");
            $("#TMXHZZ_CZ_2").attr("disabled","disabled");
            $("#TMXHZZ_ZDJC_2").val("");
            $("#TMXHZZ_ZDJC_2").attr("disabled","disabled");
            $("#TMXHZZ_MCGS_2").val("");
            $("#TMXHZZ_MCGS_2").attr("disabled","disabled");
            $("#TMXHZZ_FJSM_2").val("");
            $("#TMXHZZ_FJSM_2").attr("disabled","disabled");
            $('#TMXHZZ_XS_1').removeAttr("disabled"); 
            $('#TMXHZZ_AN_1').removeAttr("disabled"); 
            $('#TMXHZZ_CZ_1').removeAttr("disabled"); 
            $('#TMXHZZ_ZDJC_1').removeAttr("disabled"); 
            $('#TMXHZZ_MCGS_1').removeAttr("disabled"); 
            $('#TMXHZZ_FJSM_1').removeAttr("disabled");
            $("#TMXHZZ_CZ_TEMP").val("");
        }
    }


    //修改载重时
    function editZz(){
        var zz_ = $("#BZ_ZZ").val();
        var kmkd_ = $("#BZ_KMKD").val();

        if(zz_=="800"){
            //修改轿厢规格
            /* $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='800W-1350×1400'>800W-1350×1400</option>"); */
            
            //修改开门尺寸
            /* $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value=''>请选择</option>"+"<option value='800mm×2100mm(800kg)'>800mm×2100mm(800kg)</option>"); */
            //修改轿厢总高
             /* $(":radio[name='BASE_JXGD'][value='2400']").prop("checked", "checked"); */
            
//             if (kmxs_ == "中分") {
//             	$("#BZ_KMKD").val("800");
//             	bindSelect2AndInitDate($('#BZ_KMKD'), "800");
// 			}
             
            $("#IS_FEIBIAO").val("false");
        	$("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#OPT_GTMJXJMBF_TEMP").show();
        	$("#OPT_GTMTMBF_TEMP").show();
        	$("#OPT_GTMTMBF_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$(".intro").hide();
            //圈钢梁间距
            $("#BASE_QGLJJ").val("2500");
        }else if(zz_=="1000"){
            //修改轿厢规格
            /* $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1000W-1600×1400'>1000W-1600×1400</option>"); */
            
            //修改开门尺寸
           /*  $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value=''>请选择</option>"+"<option value='900mm×2100mm(1000kg)'>900mm×2100mm(1000kg)</option>"); */
            //修改轿厢总高
            /*  $(":radio[name='BASE_JXGD'][value='2400']").prop("checked", "checked"); */
            
//             if (kmxs_ == "中分") {
//             	$("#BZ_KMKD").val("900");
//             	bindSelect2AndInitDate($('#BZ_KMKD'), "900");
// 			}
            $("#IS_FEIBIAO").val("false");
        	$("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#OPT_GTMJXJMBF_TEMP").show();
        	$("#OPT_GTMTMBF_TEMP").show();
        	$("#OPT_GTMTMBF_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$(".intro").hide();
            //圈钢梁间距
            $("#BASE_QGLJJ").val("2500");
        }else if(zz_=="1150"){
            //修改轿厢规格
            /* $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1150W-2000×1350'>1150W-2000×1350</option>"); */
            
            //修改开门尺寸
            /* $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value=''>请选择</option>"+"<option value='1100mm×2100mm(1150kg-1600kg)'>1100mm×2100mm(1150kg-1600kg)</option>"); */
            //修改轿厢总高
             /* $(":radio[name='BASE_JXGD'][value='2500']").prop("checked", "checked"); */
            
//             if (kmxs_ == "中分") {
//             	$("#BZ_KMKD").val("1100");
//             	bindSelect2AndInitDate($('#BZ_KMKD'), "1100");
// 			}
            $("#IS_FEIBIAO").val("false");
        	$("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#OPT_GTMJXJMBF_TEMP").show();
        	$("#OPT_GTMTMBF_TEMP").show();
        	$("#OPT_GTMTMBF_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$(".intro").hide();
            //圈钢梁间距
            $("#BASE_QGLJJ").val("2000");
        }else if(zz_=="1350"){
            //修改轿厢规格
            /* $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1350W-2000×1500'>1350W-2000×1500</option>"); */
            
            //修改开门尺寸
           /*  $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value=''>请选择</option>"+"<option value='1100mm×2100mm(1150kg-1600kg)'>1100mm×2100mm(1150kg-1600kg)</option>"); */
            //修改轿厢总高
             /* $(":radio[name='BASE_JXGD'][value='2500']").prop("checked", "checked"); */
            
//             if (kmxs_ == "中分") {
//             	$("#BZ_KMKD").val("1100");
//             	bindSelect2AndInitDate($('#BZ_KMKD'), "1100");
// 			}
            $("#IS_FEIBIAO").val("false");
        	$("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#OPT_GTMJXJMBF_TEMP").show();
        	$("#OPT_GTMTMBF_TEMP").show();
        	$("#OPT_GTMTMBF_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$(".intro").hide();
            //圈钢梁间距
            $("#BASE_QGLJJ").val("2000");
        }else if(zz_=="1600"){
            //修改轿厢规格
            /* $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1600W-2000×1700'>1600W-2000×1700</option><option value='1000D-1100×2100担架梯'>1000D-1100×2100担架梯</option>"); */
            
            //修改开门尺寸
           /*  $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value=''>请选择</option>"+"<option value='1100mm×2100mm(1150kg-1600kg)'>1100mm×2100mm(1150kg-1600kg)</option>"); */
            //修改轿厢总高
            /*  $(":radio[name='BASE_JXGD'][value='2500']").prop("checked", "checked"); */
            
//             if (kmxs_ == "中分") {
//             	$("#BZ_KMKD").val("1100");
//             	bindSelect2AndInitDate($('#BZ_KMKD'), "1100");
// 			}
            $("#IS_FEIBIAO").val("false");
        	$("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#OPT_GTMJXJMBF_TEMP").show();
        	$("#OPT_GTMTMBF_TEMP").show();
        	$("#OPT_GTMTMBF_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$(".intro").hide();
            //圈钢梁间距
            $("#BASE_QGLJJ").val("2000");
        }else if(zz_=="2000"){
            //修改轿厢规格
            /* $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1600W-2000×1700'>1600W-2000×1700</option><option value='1000D-1100×2100担架梯'>1000D-1100×2100担架梯</option>"); */
            
            //修改开门尺寸
           /*  $("#BASE_KMCC").empty();
            $("#BASE_KMCC").append("<option value=''>请选择</option>"+"<option value='1100mm×2100mm(1150kg-1600kg)'>1100mm×2100mm(1150kg-1600kg)</option>"); */
            //修改轿厢总高
            /*  $(":radio[name='BASE_JXGD'][value='2500']").prop("checked", "checked"); */
            
            $("#IS_FEIBIAO").val("false");
        	$("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#OPT_GTMJXJMBF_TEMP").show();
        	$("#OPT_GTMTMBF_TEMP").show();
        	$("#OPT_GTMTMBF_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$(".intro").hide();
            //圈钢梁间距
            $("#BASE_QGLJJ").val("2000");
        }else if(zz_==""){
			$("#IS_FEIBIAO").val("true");
        	$("#JXZH_QWB_TEMP").hide();
        	$("#BASE_DGZJ_TEMP").hide();
        	$("#OPT_GTMJXJMBF_TEMP").hide();
        	$("#OPT_GTMTMBF_TEMP").hide();
        	$("#OPT_GTMTMBF_TEMP").hide();
        	$("#JXZH_BGJ_TEMP").hide();
        	$("#BASE_DGZJ_TEMP").val(0);
        	$("#BASE_CCJG").val(0);
        	$(".intro").show();	
        }
        else {
        	$("#IS_FEIBIAO").val("true");
        	$("#JXZH_QWB_TEMP").hide();
        	$("#BASE_DGZJ_TEMP").hide();
        	$("#OPT_GTMJXJMBF_TEMP").hide();
        	$("#OPT_GTMTMBF_TEMP").hide();
        	$("#OPT_GTMTMBF_TEMP").hide();
        	$("#JXZH_BGJ_TEMP").hide();
        	$("#BASE_DGZJ_TEMP").val(0);
        	$("#BASE_CCJG").val(0);
        	$(".intro").show();	
		}
        
        //获取基价
        setSbj();
        //贯通门（厅门部分） 联动
        editOpt('OPT_GTMTMBF');
        //支架 价格 联动
        setJdzg();
        //轿厢装潢 联动
        editJxzh('JXZH_JM');
        editJxzh('JXZH_JMZH');
        editJxzh('JXZH_JXZH');
        editJxzh('JXZH_QWB');
        editJxzh('JXZH_CWB');
        editJxzh('JXZH_HWB');
        editJxzh('JXZH_ZSDD');
        editJxzh('JXZH_BGJ');
        editJxzh('JXZH_DBXH');
        editJxzh('JXZH_YLZHZL');
        editJxzh('JXZH_FSXH');
        editJxzh('JXZH_FSAZWZ');

      	//超高和加价
        setJdzg();
    }

    //修改速度时
    function editSd(){
        var sd_ = $("#BZ_SD").val();
        if(sd_=="1.0"){
            var appendStr = "<option value=''>请选择</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        }else if(sd_=="1.5"){
            var appendStr = "<option value=''>请选择</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        }else if(sd_=="1.75"){
            var appendStr = "<option value=''>请选择</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        }else if(sd_=="2.0"){
            var appendStr = "<option value=''>请选择</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option><option value='31'>31</option><option value='32'>32</option><option value='33'>33</option><option value='34'>34</option><option value='35'>35</option><option value='36'>36</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        }else if(sd_=="2.5"){
            var appendStr = "<option value=''>请选择</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option><option value='31'>31</option><option value='32'>32</option><option value='33'>33</option><option value='34'>34</option><option value='35'>35</option><option value='36'>36</option><option value='37'>37</option><option value='38'>38</option><option value='39'>39</option><option value='40'>40</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        } else {
        	var appendStr = "<option value=''>请选择</option>";
			$("#BZ_C").empty();
			$("#BZ_Z").empty();
			$("#BZ_M").empty();
			$("#BZ_C").append(appendStr);
			$("#BZ_Z").append(appendStr);
			$("#BZ_M").append(appendStr);
        }
        //获取基价
        setSbj();
        //支架 价格 联动
        setJdzg();
    }

    //修改门数量时修改标准价格
    function setMPrice(){
    	//调用初始化贯通门
        Jsgtms();
        //数量
        var sl_ = $("#FEIYANGXF_SL").val()==""?0:parseInt_DN($("#FEIYANGXF_SL").val());
        var sbj_jj = parseInt_DN($("#DANJIA").val());
        var m_ = parseInt_DN($("#BZ_M").val());
        var c_ = parseInt_DN($("#BZ_C").val());
        var z_ = parseInt_DN($("#BZ_Z").val());//站
        var price = 0;
        var kmkd_ = parseInt_DN($("#BZ_KMKD").val());
        if(!isNaN(m_)&&!isNaN(c_)&&!isNaN(z_)){
        	
        	if (kmkd_=="800"||kmkd_=="900"||kmkd_=="1000"||kmkd_=="1100"||kmkd_=="1200") {
        		var _jj = 0;
            	if(kmkd_=="800"){
            		_jj = -2100;
                }else if(kmkd_=="900"){
                	_jj = -2400;
                }else if(kmkd_=="1100"){
                	_jj = -2800;
                }else if(kmkd_=="1200"){
                	_jj = -3000;
                }
            	
    			price = subDoor(sbj_jj, c_ , z_, m_, _jj);
    			
    			$("#SBJ_TEMP").val(price * sl_);
    			$("#DANJIA").val(price);
            	$("#BZ_M_TEMP").val(0);
            	
            	$("#DANJIA_Label").hide();
				$("#TMMT_Label").hide();
        	}else{
				//开门宽度非标
				$("#DANJIA_Label").show();
				$("#TMMT_Label").show();
			}
        	
        	
            /* var jm = c_-m_;
            if(jm>0){
                if(kmkd_=="800"){
                    price = -2100*jm*sl_;
                }else if(kmkd_=="900"){
                    price = -2400*jm*sl_;
                }else if(kmkd_=="1100"){
                    price = -2800*jm*sl_;
                }else if(kmkd_=="1200"){
                    price = -3000*jm*sl_;
                }
            }
            $("#BZ_M_TEMP").val(price); */
            countZhj();
        }
      //贯通门（厅门部分联动）
      editOpt('OPT_GTMTMBF');
      if ($("#BZ_M").val()>0 && $("#BZ_Z").val()>0) {
    	  if($("#BZ_M").val()>$("#BZ_Z").val())
          {
        	  //赋默认值
              $("#DMT_SL").val(2);
              $("#scmmt1").val(2);
              $("#FSC_DMT_SL").val($("#BZ_M").val()-2);
              $("#scmmt4").val($("#BZ_M").val()-2);
          }else
          {
        	  $("#DMT_SL").val(1);
              $("#scmmt1").val(1);
              $("#FSC_DMT_SL").val($("#BZ_M").val()-1);
              $("#scmmt4").val($("#BZ_M").val()-1);
          }
	  }

    }

    //控制方式加价 
    function KZFS_TEMP(flag)
    {
    	//数量
        var sl_ = $("#FEIYANGXF_SL").val()==""?0:parseInt_DN($("#FEIYANGXF_SL").val());
    	var price=0;
    	if(flag=='1')
    	{
    		price=0;
    	}else if(flag=='2')
    	{
    		price=240*sl_;
    	}
    	else if(flag=='3')
    	{
    		price=2400*sl_;
    	}
    	else if(flag=='4')
    	{
    		price=2000*sl_;
    	}
    	$("#BASE_KZFS_TEMP").val(price);
    	//计算价格
    	countZhj();
    }
    
    function countZhj(){
        var zhj_count = 0;
        var sbj_count = 0;
        
        var bz_m_temp = $("#BZ_M_TEMP").val()==""?0:parseInt_DN($("#BZ_M_TEMP").val());
        var base_jdzg_temp = $("#BASE_JDZG_TEMP").val()==""?0:parseInt_DN($("#BASE_JDZG_TEMP").val());
        var base_dgzj_temp = $("#BASE_DGZJ_TEMP").val()==""?0:parseInt_DN($("#BASE_DGZJ_TEMP").val());
        /* var opt_hjzdfhjz_temp = $("#OPT_HJZDFHJZ_TEMP").val()==""?0:parseInt_DN($("#OPT_HJZDFHJZ_TEMP").val()); */
        var opt_jxdzz_temp = $("#OPT_JXDZZ_TEMP").val()==""?0:parseInt_DN($("#OPT_JXDZZ_TEMP").val());
        var opt_cctvdl_temp = $("#OPT_CCTVDL_TEMP").val()==""?0:parseInt_DN($("#OPT_CCTVDL_TEMP").val());
        /* var opt_tdjjjy_temp = $("#OPT_TDJJJY_TEMP").val()==""?0:parseInt_DN($("#OPT_TDJJJY_TEMP").val()); */
        var opt_djgrbh_temp = $("#OPT_DJGRBH_TEMP").val()==""?0:parseInt_DN($("#OPT_DJGRBH_TEMP").val());
        var opt_kqjhzz_temp = $("#OPT_KQJHZZ_TEMP").val()==""?0:parseInt_DN($("#OPT_KQJHZZ_TEMP").val());
        var opt_nmykjan_temp = $("#OPT_NMYKJAN_TEMP").val()==""?0:parseInt_DN($("#OPT_NMYKJAN_TEMP").val());
        var opt_zpc_temp = $("#OPT_ZPC_TEMP").val()==""?0:parseInt_DN($("#OPT_ZPC_TEMP").val());
        var opt_bajk_temp = $("#OPT_BAJK_TEMP").val()==""?0:parseInt_DN($("#OPT_BAJK_TEMP").val());
        var opt_yybz_temp = $("#OPT_YYBZ_TEMP").val()==""?0:parseInt_DN($("#OPT_YYBZ_TEMP").val());
        var opt_dzyx_temp = $("#OPT_DZYX_TEMP").val()==""?0:parseInt_DN($("#OPT_DZYX_TEMP").val());
        var opt_nlhk_temp = $("#OPT_NLHK_TEMP").val()==""?0:parseInt_DN($("#OPT_NLHK_TEMP").val());
        /* var opt_ycjk_temp = $("#OPT_YCJK_TEMP").val()==""?0:parseInt_DN($("#OPT_YCJK_TEMP").val()); */
        var opt_ick_temp = $("#OPT_ICK_TEMP").val()==""?0:parseInt_DN($("#OPT_ICK_TEMP").val());
        var opt_ickzksb_temp = $("#OPT_ICKZKSB_TEMP").val()==""?0:parseInt_DN($("#OPT_ICKZKSB_TEMP").val());
        var opt_ickkp_temp = $("#OPT_ICKKP_TEMP").val()==""?0:parseInt_DN($("#OPT_ICKKP_TEMP").val());
        var opt_ptdtkt_temp = $("#OPT_PTDTKT_TEMP").val()==""?0:parseInt_DN($("#OPT_PTDTKT_TEMP").val());
        var opt_zyftsdtkt_temp = $("#OPT_ZYFTSDTKT_TEMP").val()==""?0:parseInt_DN($("#OPT_ZYFTSDTKT_TEMP").val());
        var opt_jkgm_temp = $("#OPT_JKGM_TEMP").val()==""?0:parseInt_DN($("#OPT_JKGM_TEMP").val());
        var opt_jkyyj_temp = $("#OPT_JKYYJ_TEMP").val()==""?0:parseInt_DN($("#OPT_JKYYJ_TEMP").val());
        var opt_gtmjxjmbf_temp = $("#OPT_GTMJXJMBF_TEMP").val()==""?0:parseInt_DN($("#OPT_GTMJXJMBF_TEMP").val());
        var opt_gtmtmbf = $("#OPT_GTMTMBF_TEMP").val()==""?0:parseInt_DN($("#OPT_GTMTMBF_TEMP").val());
        var opt_cmzh_temp = $("#OPT_CMZH_TEMP").val()==""?0:parseInt_DN($("#OPT_CMZH_TEMP").val());
        var jxzh_jm_temp = $("#JXZH_JM_TEMP").val()==""?0:parseInt_DN($("#JXZH_JM_TEMP").val());
        /* var jxzh_jmzh_temp = $("#JXZH_JMZH_TEMP").val()==""?0:parseInt_DN($("#JXZH_JMZH_TEMP").val()); */
        var jxzh_jxzh_temp = $("#JXZH_JXZH_TEMP").val()==""?0:parseInt_DN($("#JXZH_JXZH_TEMP").val());
        var jxzh_qwb_temp = $("#JXZH_QWB_TEMP").val()==""?0:parseInt_DN($("#JXZH_QWB_TEMP").val());
        /* var jxzh_cwb_temp = $("#JXZH_CWB_TEMP").val()==""?0:parseInt_DN($("#JXZH_CWB_TEMP").val());
        var jxzh_hwb_temp = $("#JXZH_HWB_TEMP").val()==""?0:parseInt_DN($("#JXZH_HWB_TEMP").val()); */
        var jxzh_zsdd_temp = $("#JXZH_ZSDD_TEMP").val()==""?0:parseInt_DN($("#JXZH_ZSDD_TEMP").val());
        var jxzh_bgj_temp = $("#JXZH_BGJ_TEMP").val()==""?0:parseInt_DN($("#JXZH_BGJ_TEMP").val());
        var jxzh_dbxh_temp = $("#JXZH_DBXH_TEMP").val()==""?0:parseInt_DN($("#JXZH_DBXH_TEMP").val());
        var jxzh_ylzhzl_temp = $("#JXZH_YLZHZL_TEMP").val()==""?0:parseInt_DN($("#JXZH_YLZHZL_TEMP").val());
        var jxzh_fsxh_temp = $("#JXZH_FSXH_TEMP").val()==""?0:parseInt_DN($("#JXZH_FSXH_TEMP").val());
        var jxzh_fsazwz_temp = $("#JXZH_FSAZWZ_TEMP").val()==""?0:parseInt_DN($("#JXZH_FSAZWZ_TEMP").val());
       /*  var tmmt_jzbxgxmt_temp = $("#TMMT_JZBXGXMT_TEMP").val()==""?0:parseInt_DN($("#TMMT_JZBXGXMT_TEMP").val()); */
        var tmmt_ptdmt_temp = $("#TMMT_PTDMT_TEMP").val()==""?0:parseInt_DN($("#TMMT_PTDMT_TEMP").val());
       /*  var tmmt_ptjmbxgtm_temp = $("#TMMT_PTJMBXGTM_TEMP").val()==""?0:parseInt_DN($("#TMMT_PTJMBXGTM_TEMP").val()); */
        var tmmt_sctmmt_temp = $("#TMMT_SCTMMT_TEMP").val()==""?0:parseInt_DN($("#TMMT_SCTMMT_TEMP").val());
        var tmmt_fsctmmt_temp = $("#TMMT_FSCTMMT_TEMP").val()==""?0:parseInt_DN($("#TMMT_FSCTMMT_TEMP").val());
        var czp_czpxh_temp = $("#CZP_CZPXH_TEMP").val()==""?0:parseInt_DN($("#CZP_CZPXH_TEMP").val());
        var tmxhzz_cz_temp = $("#TMXHZZ_CZ_TEMP").val()==""?0:parseInt_DN($("#TMXHZZ_CZ_TEMP").val());
        var tmxhzz_wzycopmwan_temp = $("#TMXHZZ_WZYCOPMWAN_TEMP").val()==""?0:parseInt_DN($("#TMXHZZ_WZYCOPMWAN_TEMP").val());
        var base_ccjg = $("#BASE_CCJG").val()==""?0:parseInt_DN($("#BASE_CCJG").val());
        var base_kzfs_temp = $("#BASE_KZFS_TEMP").val()==""?0:parseInt_DN($("#BASE_KZFS_TEMP").val());
        var fsc_dmt_temp = $("#FSC_DMT_TEMP").val()==""?0:parseInt_DN($("#FSC_DMT_TEMP").val());
        var opt_fdlcz_temp = $("#OPT_FDLCZ_TEMP").val()==""?0:parseInt_DN($("#OPT_FDLCZ_TEMP").val());
        
      	//非标选项加价
        var opt_fb_temp = $("#OPT_FB_TEMP").val()==""?0:parseInt_DN($("#OPT_FB_TEMP").val());
        
        zhj_count = opt_fdlcz_temp+fsc_dmt_temp+jxzh_jm_temp+jxzh_jxzh_temp+jxzh_qwb_temp+jxzh_zsdd_temp+jxzh_bgj_temp+jxzh_dbxh_temp+jxzh_ylzhzl_temp+jxzh_fsazwz_temp;
        /* $("#FEIYANGXF_ZHJ").val(zhj_count); */
		
        sbj_count = bz_m_temp+base_kzfs_temp+base_ccjg+base_jdzg_temp+base_dgzj_temp+opt_jxdzz_temp+opt_cctvdl_temp+opt_djgrbh_temp+opt_kqjhzz_temp+opt_nmykjan_temp+opt_zpc_temp+opt_bajk_temp+opt_yybz_temp+opt_dzyx_temp+opt_nlhk_temp+opt_ick_temp+opt_ickzksb_temp+opt_ickkp_temp+opt_ptdtkt_temp+opt_zyftsdtkt_temp+opt_jkgm_temp+opt_jkyyj_temp+opt_gtmjxjmbf_temp+opt_gtmtmbf+opt_cmzh_temp+tmmt_ptdmt_temp+tmmt_sctmmt_temp+tmmt_fsctmmt_temp+czp_czpxh_temp+tmxhzz_cz_temp+tmxhzz_wzycopmwan_temp+opt_fb_temp;
        
        //设备标准价格 (选项加价)
        var sbj_temp = parseInt_DN($("#SBJ_TEMP").val());
        $("#FEIYANG_XF_XXJJ").val(sbj_count+zhj_count);
        //折前价 =基价+选项加价 
        $("#FEIYANG_XF_ZQJ").val(sbj_count+zhj_count+sbj_temp);

        //运输费
        var feiyangxf_ysf = $("#FEIYANGXF_YSF").val()==""?0:parseInt_DN($("#FEIYANGXF_YSF").val());
        $("#FEIYANGXF_YSF").val(feiyangxf_ysf);
        //安装费
        var feiyangxf_azf = $("#FEIYANGXF_AZF_TEMP").val()==""?0:parseInt_DN($("#FEIYANGXF_AZF_TEMP").val());
        $("#FEIYANGXF_AZF").val(feiyangxf_azf);

        
      //非标加价
        setFBPrice();
        
        var feiyangxf_zk = parseFloat($("#FEIYANGXF_ZK").val())/100;
        if(!isNaN(feiyangxf_zk)){
            var feiyangxf_sbj = parseInt_DN($("#SBJ_TEMP").val());
            var feiyangxf_sjbj = (feiyangxf_sbj+zhj_count+sbj_count+feiyangxf_azf+feiyangxf_ysf)*feiyangxf_zk;
            var feiyangxf_zhsbj = feiyangxf_sbj*feiyangxf_zk;
            $("#FEIYANGXF_SJBJ").val(feiyangxf_sjbj);
            $("#FEIYANGXF_ZHSBJ").val(feiyangxf_zhsbj);
            $("#zk_").text($("#FEIYANGXF_ZK").val()+"%");
        }
        countInstallPrice();
    }

    //计算井道总高-加价
    function setJdzg(){
    	var dtsl_ = parseInt_DN($("#DT_SL").val());
        var tsgd_ = parseInt_DN($("#BASE_TSGD").val());    //提升高度
        var dksd_ = parseInt_DN($("#BASE_DKSD").val());     //底坑深度
        var dcgd_ = parseInt_DN($("#BASE_DCGD").val());    //顶层高度
        if(!isNaN(tsgd_)&&!isNaN(dksd_)&&!isNaN(dcgd_))
        {
            var jdzg_ = tsgd_+dksd_+dcgd_;  //实际井道总高
            $("#BASE_JDZG").val(jdzg_);
            
          //根据基本参数 获取提升高度 以及加价 
            var sd_ = $("#BZ_SD").val();  //速度
            if(sd_=="1.0"){var sd=1;}
            else if(sd_=="2.0"){var sd=2;}
            else{var sd=sd_;}
            var c_ = $("#BZ_C").val();     //层站
            var zz_ = $("#BZ_ZZ").val();  //载重
            var models_name = $("#tz_").val();  //型号名称
            $.post("<%=basePath%>e_offer/setBascPrice",
                    {
                        "SD": sd,
                        "ZZ": zz_,
                        "C": c_,
                        "NAME": models_name
                    },function(result){
                        if(result.msg=="success"){
                        	if(isNaN(tsgd_) && isNaN(dksd_) && isNaN(dcgd_)){
                        		$("#BASE_CCGD").val("");
                            	$("#BASE_CCJG").val("");
                            	$("#BASE_JDZG_TEMP").val("");
                            	$("#BASE_JDZG").val("");
                        	}else{
                        		var BZJDG = 0;
                            	var JJ = 0;
                            	if(result.pd != null){
                            		BZJDG = result.pd.BZJDG;
                            		JJ = result.pd.JJ;
                            	}
                        		var jdzg=$("#BASE_JDZG").val();
                            	var ccgd=jdzg-parseInt_DN(BZJDG*1000);//超出高度
                            	 //超出高度加价
                            	var ccjg=(((ccgd/1000)*JJ))*dtsl_;
                            	$("#BASE_CCGD").val(ccgd);
                            	if(parseInt_DN(ccjg)>0){
                               		$("#BASE_CCJG").val(parseInt_DN(ccjg));
                               	}else{
                               		$("#BASE_CCJG").val(0);
                               	}
                            	
                            	$("#BASE_JDZG_TEMP").val("0");
                                //放入价格
                                countZhj();
                        	}
                        }
                    });
            
            setDgzj();
        }else{
        	$("#BASE_CCGD").val("");
        	$("#BASE_CCJG").val("");
        	$("#BASE_JDZG").val("");
        }
        
    }

    //计算导轨支架-加价
    function setDgzj(){
    	//数量
        var sl_ = $("#FEIYANGXF_SL").val()==""?0:parseInt_DN($("#FEIYANGXF_SL").val());
        var sd_ = $("#BZ_SD").val();  //速度
        var c_ = $("#BZ_C").val();     //层站
        var zz_ = $("#BZ_ZZ").val();  //载重
        var models_name = $("#tz_").val();  //型号名称
        if(sd_=="1.0"){var sd=1;}
        else if(sd_=="2.0"){var sd=2;}
        else{var sd=sd_;}
        $.post("<%=basePath%>e_offer/setBascPrice",
                {
                    "SD": sd,
                    "ZZ": zz_,
                    "C": c_,
                    "NAME": models_name
                },function(result)
                {
                    if(result.msg=="success")
                    {
                    	//井道总高(标准)
                        //var jdzg_std=result.pd.BZJDG*1000;
                        var jdzg_std=$("#BASE_JDZG").val();
                    	
                        var dgzj_std;//计算标准导轨支架数量
                        if(zz_=="800" || zz_=="1000"){
                            dgzj_std = Math.ceil((jdzg_std/2500)+1);
                        }else if(zz_=="1150"||zz_=="1350"||zz_=="1600"){
                            dgzj_std = Math.ceil((jdzg_std/2000)+1);
                        }
                        var price;
                        
                        var jdzg_sj=$("#BASE_JDZG").val();  //实际井道总高
                        var qgljj_sj=$("#BASE_QGLJJ").val();//实际圈钢梁间距
                        if(jdzg_sj=="" || isNaN(jdzg_sj)){
                        	$("#BASE_DGZJ").val(0);
                          	$("#BASE_DGZJ_TEMP").val(0);
                        }else{
                        	//计算出实际导轨支架
                            var dgzj_sj=Math.ceil((jdzg_sj/qgljj_sj)+1); 
                            price=(dgzj_sj-dgzj_std)*310;
                          	if(dgzj_sj>dgzj_std)
                            {
                            	$("#BASE_DGZJ").val(dgzj_sj);
                            	if(price>0){
                            		$("#BASE_DGZJ_TEMP").val(price*sl_);
                            	}else{
                            		$("#BASE_DGZJ_TEMP").val(0);
                            	}
                            }else{
                            	$("#BASE_DGZJ").val(dgzj_std);
                            	if(price>0){
                            		$("#BASE_DGZJ_TEMP").val(price*sl_);
                            	}else{
                            		$("#BASE_DGZJ_TEMP").val(0);
                            	}
                            }
                        }
                        
                    }
                    
                });
        //放入价格
        countZhj();
    }

    //可选功能部分加价
    function editOpt(option){
        //数量
        var sl_ = $("#FEIYANGXF_SL").val()==""?0:parseInt_DN($("#FEIYANGXF_SL").val());
        //价格
        var price = 0;
        if(option=="OPT_FDLCZ"){
            //防捣乱操作
            if($("#OPT_FDLCZ_TEXT").is(":checked")){
                price = 130*sl_;
            }else{
                price = 0;
            }
            $("#OPT_FDLCZ_TEMP").val(price);
        }else if(option=="OPT_JXDZZ"){
            //轿厢到站钟
            if($("#OPT_JXDZZ_TEXT").is(":checked")){
                price = 200*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JXDZZ_TEMP").val(price);
        }else if(option=="OPT_CCTVDL"){
            //CCTV电缆
            var tsgd_ = parseInt_DN($("#BASE_TSGD").val());
            if($("#OPT_CCTVDL_TEXT").is(":checked"))
            {
            	if(!tsgd_>0)
                {
                	alert("请填写基础参数的提升高度!");
                }else
                {
                	price = 17*(tsgd_/1000+15)*sl_;
                }
            }else{
                price = 0;
            }
            
            $("#OPT_CCTVDL_TEMP").val(price);
        }else if(option=="OPT_TDJJJY"){
            //停电紧急救援
            if($("#OPT_TDJJJY_TEXT").is(":checked")){
                price = 7300*sl_;
            }else{
                price = 0;
            }
            $("#OPT_TDJJJY_TEMP").val(price);
        }else if(option=="OPT_DJGRBH"){
            //电机过热保护
            if($("#OPT_DJGRBH_TEXT").is(":checked")){
                price = 650*sl_;
            }else{
                price = 0;
            }
            $("#OPT_DJGRBH_TEMP").val(price);
        }else if(option=="OPT_KQJHZZ"){
            //空气净化装置
            if($("#OPT_KQJHZZ_TEXT").is(":checked")){
                price = 2400*sl_;
            }else{
                price = 0;
            }
            $("#OPT_KQJHZZ_TEMP").val(price);
        }else if(option=="OPT_NMYKJAN"){
            //纳米银抗菌按钮
            if($("#OPT_NMYKJAN").val()!=""&&!isNaN($("#OPT_NMYKJAN").val())){
                price = 84*parseInt_DN($("#OPT_NMYKJAN").val());
            }else{
                price = 0;
            }
            $("#OPT_NMYKJAN_TEMP").val(price*sl_);
        }else if(option=="OPT_ZPC"){
            //再平层
            if($("#OPT_ZPC_TEXT").is(":checked")){
                price = 0;//1600
            }else{
                price = 0;
            }
            $("#OPT_ZPC_TEMP").val(price);
        }else if(option=="OPT_BAJK"){
            //BA接口
            if($("#OPT_BAJK_TEXT").is(":checked")){
                price = 650*sl_;
            }else{
                price = 0;
            }
            $("#OPT_BAJK_TEMP").val(price);
        }else if(option=="OPT_YYBZ")
        {
            //语音报站
            if($("#OPT_YXBZ_TEXT").is(":checked")){
                price = 1300*sl_;
            }else{
                price = 0;
            }
            $("#OPT_YYBZ_TEMP").val(price);
        }else if(option=="OPT_DZYX"){
            //地震运行
            if($("#OPT_DZYX_TEXT").is(":checked")){
                price = 4320*sl_;
            }else{
                price = 0;
            }
            $("#OPT_DZYX_TEMP").val(price);
        }else if(option=="OPT_NLHK"){
            //能量回馈
            if($("#OPT_NLHK_TEXT").is(":checked")){
                price = 11520*sl_;
            }else{
                price = 0;
            }
            $("#OPT_NLHK_TEMP").val(price);
        }else if(option=="OPT_YCJK"){
            //远程监控(物联网系统)
            if($("#OPT_YCJK_TEXT").is(":checked")){
                price = 0;
            }else{
                price = 0;
            }
            $("#OPT_YCJK_TEMP").val(price);
        }else if(option=="OPT_ICK"){
            //IC卡(轿内控制)
            if($("#OPT_ICK").val()=="刷卡后手动选择到达楼层"){
                price = 1920*sl_;
            }else if($("#OPT_ICK").val()=="刷卡后自动选择到达楼层"){
                price = 4040*sl_;
            }else{
                price = 0;
            }
            $("#OPT_ICK_TEMP").val(price);
        }else if(option=="OPT_ICKZKSB"){
            //IC卡制卡设备
            if($("#OPT_ICKZKSB_TEXT").is(":checked"))
            {
            	var itemId=$("#ITEM_ID").val();
            	$.post("<%=basePath%>e_offer/zksbjj",
                        {
                            "item_id":itemId
                        },function(result)
                        {
                            if(result.msg=="yes")
                            {
                            	$("#OPT_ICKZKSB_TEMP").val(1400);
                            	countZhj();
                            }
                            else
                            {
                            	$("#OPT_ICKZKSB_TEMP").val(0);
                            	countZhj();
                            }
                        });      
            }else{
            	$("#OPT_ICKZKSB_TEMP").val(0);
            	countZhj();
            }
        }else if(option=="OPT_ICKKP"){
            //IC卡卡片
            if(!isNaN(parseInt_DN($("#OPT_ICKKP").val()))){
                price = parseInt_DN($("#OPT_ICKKP").val())*12;
            }else{
                price = 0;
            }
            $("#OPT_ICKKP_TEMP").val(price*sl_);
        }else if(option=="OPT_PTDTKT"){
            //普通电梯空调
            if($("#OPT_PTDTKT").val()=="单冷型2200W"){
                price = 12000*sl_;
            }else if($("#OPT_PTDTKT").val()=="冷暖型1500W"){
                price = 13200*sl_;
            }else{
                price = 0;
            }
            $("#OPT_PTDTKT_TEMP").val(price);
        }else if(option=="OPT_ZYFTSDTKT"){
            //专用分体式电梯空调
            if($("#OPT_ZYFTSDTKT").val()=="单冷型2200W"){
                price = 15120*sl_;
            }else{
                price = 0;
            }
            $("#OPT_ZYFTSDTKT_TEMP").val(price);
        }else if(option=="OPT_JKGM"){
            //进口光幕
            if($("#OPT_JKGM_TEXT").is(":checked")){
                price = 960*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JKGM_TEMP").val(price);
        }else if(option=="OPT_JKYYJ"){
            //进口曳引机
            if($("#OPT_JKYYJ_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();
                if(zz_=="800"||zz_=="1000"||zz_=="1150"){
                    price = 12000*sl_;
                }else if(zz_=="1350"||zz_=="1600"){
                    price = 14400*sl_
                }else{
                    price = 0;
                }
            }else{
                price = 0;
            }
            $("#OPT_JKYYJ_TEMP").val(price);
        }else if(option=="OPT_GTMJXJMBF"){
            //贯通门(轿厢轿门部分)
            if($("#OPT_GTMJXJMBF_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();
                if(zz_=="800"){
                    price = 13000*sl_;
                }else if(zz_=="1000"){
                    price = 13900*sl_;
                }else if(zz_=="1150"||zz_=="1350"||zz_=="1600"){
                    price = 14700*sl_
                }else{
                    price = 0;
                }
            }else{
                price = 0;
            }
            $("#OPT_GTMJXJMBF_TEMP").val(price);
        }else if(option=="OPT_GTMTMBF"){
            //贯通门(厅门部分)
            var zz_ = $("#BZ_ZZ").val();
            var gtms=$("#OPT_GTMS_TEXT").val();
            if($("#OPT_GTMTMBF_TEXT").val()=="发纹不锈钢"){
                if(zz_=="800"){
                    price = 3250*sl_;
                }else if(zz_=="1000"){
                    price = 3800*sl_;
                }else if(zz_=="1150"||zz_=="1350"||zz_=="1600"){
                    price = 4500*sl_
                }else{
                    price = 0;
                }    
            }else if($("#OPT_GTMTMBF_TEXT").val()=="喷涂"){
                if(zz_=="800"){
                    price = 2100*sl_;
                }else if(zz_=="1000"){
                    price = 2400*sl_;
                }else if(zz_=="1150"||zz_=="1350"||zz_=="1600"){
                    price = 2770*sl_
                }else{
                    price = 0;
                }    
            }else{
                price = 0;
            }
            if(!isNaN(gtms))
            {
            	$("#OPT_GTMTMBF_TEMP").val(price*gtms);
            }else
            {
            	$("#OPT_GTMTMBF_TEMP").val(price*0);
            }
            
        }else if(option=="OPT_CMZH"){
            //层门装潢
            var m_ = parseInt_DN($("#BZ_M").val()); 
            if($("#OPT_CMZH_TEXT").val()=="JF-K-C01"){
                price = 0;
            }else if($("#OPT_CMZH_TEXT").val()=="JF-K-C02"){
                price = 3400*sl_;
            }else if($("#OPT_CMZH_TEXT").val()=="JF-K-C03"){
                price = 3400*sl_;
            }else if($("#OPT_CMZH_TEXT").val()=="JF-K-C04"){
                price = 4100*sl_;
            }else if($("#OPT_CMZH_TEXT").val()=="JF-K-C05"){
                price = 3900*sl_;
            }else if($("#OPT_CMZH_TEXT").val()=="JF-K-C06"){
                price = 3900*sl_;
            }else if($("#OPT_CMZH_TEXT").val()=="JF-K-C07"){
                price = 3900*sl_;
            }else{
                price = 0;
            }
            $("#OPT_CMZH_TEMP").val(price*m_);
        }
        //放入价格
        countZhj();
    }


    //单组监控室对讲系统-加价
    /*function editDzjksdjxt(){
        var sl_ = parseInt_DN($("#FEIYANGXF_SL").val());
        var price = 0;
        if(sl_<10){
            var djts_ = parseInt_DN($("#DZJKSDJXT_DJTS").val());
            if($("#DZJKSDJXT_DJTXFS").val()=="分线制"){
                price = 2330*djts_+3570;
            }else if($("#DZJKSDJXT_DJTXFS").val()=="总线制"){
                price = 720*djts_+4080;
            }
        }
        $("#DZJKSDJXT_DJTS_TEMP").val(price);
        //放入价格
        countZhj();
    }*/


    //轿厢装潢部分-加价
    function editJxzh(option){
        //数量
        var sl_ = $("#FEIYANGXF_SL").val()==""?0:parseInt_DN($("#FEIYANGXF_SL").val());
        //价格
        var price = 0;
        if(option=="JXZH_JMZH"){
            //轿门装潢
            var jmzh_ = $("#JXZH_JMZH").val();
            if(jmzh_!="喷涂")
            {
            	$("#JXZH_JMSBH").val("");
                $("#JXZH_JMSBH").attr("disabled","disabled");
            }
            else
            {
            	$('#JXZH_JMSBH').removeAttr("disabled"); 
            }
            
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            
            if(jmzh_=="JF-K-C01" || jmzh_=="SUS304发纹不锈钢"){
                price = 0;
            }else if(jmzh_=="JF-K-C02"||jmzh_=="JF-K-C03"){
                price = 2950*sl_;
            }else if(jmzh_=="JF-K-C04"||jmzh_=="JF-K-C05"||jmzh_=="JF-K-C06"||jmzh_=="JF-K-C07"){
                price = 3420*sl_;
            }else if(jmzh_=="喷涂")
            {
            	if(kmkd_=="800"){
                    price = -820*sl_;
                }else if(kmkd_=="900"){
                    price = -980*sl_;
                }else if(kmkd_=="1100"){
                    price = -1300*sl_;
                }
            }else if(jmzh_=="镜面不锈钢")
            {
            	if(kmkd_=="800"){
                    price = 1580*sl_;
                }else if(kmkd_=="900"){
                    price = 1620*sl_;
                }else if(kmkd_=="1100"){
                    price = 2400*sl_;
                }
            }

            if($("#OPT_GTMJXJMBF_TEXT").is(":checked"))
            {
            	$("#JXZH_JM_TEMP").val(price*2);
            }
            else
            {
            	$("#JXZH_JM_TEMP").val(price);
            }

        }else if(option=="JXZH_JXZH"){
            //轿厢装潢
            var jxzh_ = $("#JXZH_JXZH").val();
            if(jxzh_=="JF-K-JX-01"){
                price = 0;
            }else if(jxzh_=="JF-K-JX-02"){
                price = 19100*sl_;
            }else if(jxzh_=="JF-K-JX-03"){
                price = 27500*sl_;
            }else if(jxzh_=="JF-K-JX-04"){
                price = 33200*sl_;
            }else if(jxzh_=="JF-K-JX-05"){
                price = 16000*sl_;
            }else if(jxzh_=="JF-K-JX-06"){
                price = 25100*sl_;
            }else if(jxzh_=="JF-K-JX-07"){
                price = 22700*sl_;
            }else if(jxzh_=="JF-K-JX-08"){
                price = 32700*sl_;
            }else if(jxzh_=="JF-K-JX-09"){
                price = 13200*sl_;
            }else if(jxzh_=="JF-K-JX-10"){
                price = 19600*sl_;
            }else if(jxzh_=="JF-K-JX-11"){
                price = 19600*sl_;
            }
            $("#JXZH_JXZH_TEMP").val(price);
        }else if(option=="JXZH_JM_quxiao"){
        	$("input[name='JXZH_JM']:checked").removeAttr("checked");
        	$("input[name='JXZH_QWB']:checked").removeAttr("checked");
        	$("input[name='JXZH_CWB']:checked").removeAttr("checked");
        	$("input[name='JXZH_HWB']:checked").removeAttr("checked");
        	$("#JXZH_JM_TEMP").val(0);
        	$("#JXZH_QWB_TEMP").val(0);
        }else if(option=="JXZH_QWB"){
            //前围壁
            var qwb_ = $("input[name='JXZH_QWB']:checked").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(qwb_=="喷涂"){
            	var cwb_pt = $("input[id='JXZH_CWB_PT']:checked").val();
            	var hwb_pt = $("input[id='JXZH_HWB_PT']:checked").val();
            	if(cwb_pt=="喷涂" && hwb_pt=="喷涂")
            	{
            		if(zz_=="800"){
                        price = -5400*sl_;
                    }else if(zz_=="1000"){
                        price = -5700*sl_;
                    }else if(zz_=="1150"){
                        price = -6500*sl_;
                    }else if(zz_=="1350"){
                        price = -7300*sl_;
                    }else if(zz_=="1600"){
                        price = -7700*sl_;
                    }
            	}else{price=0;}
                
            }else if(qwb_=="SUS304发纹不锈钢"){
            	var cwb_fw = $("input[id='JXZH_CWB_FW']:checked").val();
            	var hwb_fw = $("input[id='JXZH_HWB_FW']:checked").val();
            	if(cwb_fw=="SUS304发纹不锈钢" && hwb_fw=="SUS304发纹不锈钢")
            	{price=0;}else{price=0;}
            }else if(qwb_=="镜面不锈钢"){
            	var cwb_jm = $("input[id='JXZH_CWB_JM']:checked").val();
            	var hwb_jm = $("input[id='JXZH_HWB_JM']:checked").val();
            	if(cwb_jm=="镜面不锈钢" && hwb_jm=="镜面不锈钢")
            	{
            		if(zz_=="800"){
                        price = 5700*sl_;
                    }else if(zz_=="1000"){
                        price = 5700*sl_;
                    }else if(zz_=="1150"){
                        price = 8200*sl_;
                    }else if(zz_=="1350"){
                        price = 8200*sl_;
                    }else if(zz_=="1600"){
                        price = 8200*sl_;
                    }
            	}else{price=0;}
                
            }
            $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_CWB"){
            //侧围壁
            var cwb_ = $("input[name='JXZH_CWB']:checked").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(cwb_=="喷涂"){
            	var qwb_pt = $("input[id='JXZH_QWB_PT']:checked").val();
            	var hwb_pt = $("input[id='JXZH_HWB_PT']:checked").val();
            	if(qwb_pt=="喷涂" && hwb_pt=="喷涂")
            	{
            		if(zz_=="800"){
                        price = -5400*sl_;
                    }else if(zz_=="1000"){
                        price = -5700*sl_;
                    }else if(zz_=="1150"){
                        price = -6500*sl_;
                    }else if(zz_=="1350"){
                        price = -7300*sl_;
                    }else if(zz_=="1600"){
                        price = -7700*sl_;
                    }
            	}else{price=0;}
                
            }else if(cwb_=="SUS304发纹不锈钢"){
            	var qwb_fw = $("input[id='JXZH_QWB_FW']:checked").val();
            	var hwb_fw = $("input[id='JXZH_HWB_FW']:checked").val();
            	if(qwb_fw=="SUS304发纹不锈钢" && hwb_fw=="SUS304发纹不锈钢")
            	{price=0;}else{price=0;}
            }else if(cwb_=="镜面不锈钢"){
            	var qwb_jm = $("input[id='JXZH_QWB_JM']:checked").val();
            	var hwb_jm = $("input[id='JXZH_HWB_JM']:checked").val();
            	if(qwb_jm=="镜面不锈钢" && hwb_jm=="镜面不锈钢")
            	{
            		if(zz_=="800"){
                        price = 5700*sl_;
                    }else if(zz_=="1000"){
                        price = 5700*sl_;
                    }else if(zz_=="1150"){
                        price = 8200*sl_;
                    }else if(zz_=="1350"){
                        price = 8200*sl_;
                    }else if(zz_=="1600"){
                        price = 8200*sl_;
                    }
            	}else{price=0;}
                
            }
            $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_HWB"){
            //后围壁
            var hwb_ = $("input[name='JXZH_HWB']:checked").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(hwb_=="喷涂"){
            	var qwb_pt = $("input[id='JXZH_QWB_PT']:checked").val();
            	var cwb_pt = $("input[id='JXZH_CWB_PT']:checked").val();
            	if(qwb_pt=="喷涂" && cwb_pt=="喷涂")
            	{
            		if(zz_=="800"){
                        price = -5400*sl_;
                    }else if(zz_=="1000"){
                        price = -5700*sl_;
                    }else if(zz_=="1150"){
                        price = -6500*sl_;
                    }else if(zz_=="1350"){
                        price = -7300*sl_;
                    }else if(zz_=="1600"){
                        price = -7700*sl_;
                    }
            	}else{price=0;}
                
            }else if(hwb_=="SUS304发纹不锈钢"){
            	var qwb_fw = $("input[id='JXZH_QWB_FW']:checked").val();
            	var cwb_fw = $("input[id='JXZH_CWB_FW']:checked").val();
            	if(qwb_fw=="SUS304发纹不锈钢" && cwb_fw=="SUS304发纹不锈钢")
            	{price=0;}else{price=0;}
            }else if(hwb_=="镜面不锈钢"){
            	var qwb_jm = $("input[id='JXZH_QWB_JM']:checked").val();
            	var cwb_jm = $("input[id='JXZH_CWB_JM']:checked").val();
            	if(qwb_jm=="镜面不锈钢" && cwb_jm=="镜面不锈钢")
            	{
            		if(zz_=="800"){
                        price = 5700*sl_;
                    }else if(zz_=="1000"){
                        price = 5700*sl_;
                    }else if(zz_=="1150"){
                        price = 8200*sl_;
                    }else if(zz_=="1350"){
                        price = 8200*sl_;
                    }else if(zz_=="1600"){
                        price = 8200*sl_;
                    }
            	}else{price=0;}
                
            }
            $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_ZSDD"){
            //轿顶装潢-装饰吊顶
            var zsdd_1 = $("#ZSDD_1").val();
            var zsdd_2 = $("#ZSDD_2").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(zsdd_1!="" && zsdd_1!=null)
            {
            	if(zsdd_1=="JF-Inte-CL01")
                {
                	price = 0;
                }else if(zsdd_1=="JF-Inte-CL02"){
                    if(zz_=="800"){
                        price = 410*sl_;
                    }else if(zz_=="1000"){
                        price = 410*sl_;
                    }else if(zz_=="1150"){
                        price = 490*sl_;
                    }else if(zz_=="1350"){
                        price = 530*sl_;
                    }else if(zz_=="1600"){
                        price = 600*sl_;
                    }
                }else if(zsdd_1=="JF-Inte-CL03" || zsdd_1=="JF-Inte-CL04"){
                	if(zz_=="800"){
                        price = 1160*sl_;
                    }else if(zz_=="1000"){
                        price = 1200*sl_;
                    }else if(zz_=="1150"){
                        price = 1440*sl_;
                    }else if(zz_=="1350"){
                        price = 1560*sl_;
                    }else if(zz_=="1600"){
                        price = 1800*sl_;
                    }
                }
            }
            else 
            {
            	if(zsdd_2=="JF-CL-02" || zsdd_2=="JF-CL-05"){//悬吊式
                	if(zz_=="800"){
                        price = 2030*sl_;
                    }else if(zz_=="1000"){
                        price = 2100*sl_;
                    }else if(zz_=="1150"){
                        price = 2520*sl_;
                    }else if(zz_=="1350"){
                        price = 2730*sl_;
                    }else if(zz_=="1600"){
                        price = 3150*sl_;
                    }
                }
                else if(zsdd_2=="JF-CL-03"){
                	if(zz_=="800"){
                        price = 2690*sl_;
                    }else if(zz_=="1000"){
                        price = 2760*sl_;
                    }else if(zz_=="1150"){
                        price = 3310*sl_;
                    }else if(zz_=="1350"){
                        price = 3580*sl_;
                    }else if(zz_=="1600"){
                        price = 4140*sl_;
                    }
                }
                else if(zsdd_2=="JF-CL-04"){
                	if(zz_=="800"){
                        price = 2270*sl_;
                    }else if(zz_=="1000"){
                        price = 2350*sl_;
                    }else if(zz_=="1150"){
                        price = 2820*sl_;
                    }else if(zz_=="1350"){
                        price = 3050*sl_;
                    }else if(zz_=="1600"){
                        price = 3520*sl_;
                    }
                }
            } 
            $("#JXZH_ZSDD_TEMP").val(price);
        }else if(option=="JXZH_BGJ"){
            //半高镜
            var bgj_ = $("input[name='JXZH_BGJ']:checked").val();
            if(bgj_=="有"){
                var zz_ = $("#BZ_ZZ").val();  //载重
                if(zz_=="800"){
                    price = 980*sl_;
                }else if(zz_=="1000"){
                    price = 1300*sl_;
                }else if(zz_=="1150"){
                    price = 1600*sl_;
                }else if(zz_=="1350"){
                    price = 1600*sl_;
                }else if(zz_=="1600"){
                    price = 1600*sl_;
                }
            }else if(bgj_=="无"){
                price = 0;
            }
            $("#JXZH_BGJ_TEMP").val(price);
        }else if(option=="JXZH_DBXH"){
            //地板型号
            var dbxh_ = $("input[name='JXZH_DBXH']:checked").val();
            if(dbxh_=="JD-05"){
                price = 490*sl_;
            }else if(dbxh_==""){
                dbxh_ = $("#JXZH_DBXH_SELECT").val();
                if(dbxh_=="JD-01"||dbxh_=="JD-02"||dbxh_=="JD-03"){
                    price = 0;
                }else if(dbxh_=="JD-04"){
                    price = 490*sl_;
                }
            }
            $("#JXZH_DBXH_TEMP").val(price);
        }else if(option=="JXZH_YLZHZL"){
            //预留装潢重量
            var ylzhzl_ = parseInt_DN($("#JXZH_YLZHZL").val());
            var zz_ = $("#BZ_ZZ").val();  //载重
            if(zz_=="800")
            {
            	if(ylzhzl_<=200)
            	{
            		price = 900*sl_;
            	}
            	else
            	{
            		if(!isNaN(ylzhzl_))
            		{
            			alert("预留装潢重量超出最大允许值，请通过非标询价。");
            			$("#JXZH_YLZHZL").val("");
            		}
            	}
            }else if(zz_=="1000")
            {
            	if(ylzhzl_<=200)
            	{
            		price = 1100*sl_;
            	}
            	else
            	{
            		if(!isNaN(ylzhzl_))
            		{
            			alert("预留装潢重量超出最大允许值，请通过非标询价。");
            			$("#JXZH_YLZHZL").val("");
            		}
            	}
            }else if(zz_=="1150")
            {
            	if(ylzhzl_<=250)
            	{
            		price = 1500*sl_;
            	}
            	else
            	{
            		if(!isNaN(ylzhzl_))
            		{
            			alert("预留装潢重量超出最大允许值，请通过非标询价。");
            			$("#JXZH_YLZHZL").val("");
            		}
            	}
            }else if(zz_=="1350")
            {
            	if(ylzhzl_<=250)
            	{
            		price = 1600*sl_;
            	}
            	else
            	{
            		if(!isNaN(ylzhzl_))
            		{
            			alert("预留装潢重量超出最大允许值，请通过非标询价。");
            			$("#JXZH_YLZHZL").val("");
            		}
            	}
            }else if(zz_=="1600")
            {
            	if(ylzhzl_<=300)
            	{
            		price = 2000*sl_;
            	}
            	else
            	{
            		if(!isNaN(ylzhzl_))
            		{
            			alert("预留装潢重量超出最大允许值，请通过非标询价。");
            			$("#JXZH_YLZHZL").val("");
            		}
            	}
            }
            
            
            $("#JXZH_YLZHZL_TEMP").val(price);
        }else if(option=="JXZH_FSXH"){
            //扶手型号
            var fsxh_ = $("#JXZH_FSXH_SELECT").val();
            if(fsxh_=="JF-FS-01"){
                price = 650*sl_;
                //扶手安装位置 
                var fsazwz_sl = $("input:checkbox[name='JXZH_FSAZWZ']:checked").length;
                var price2 = parseInt_DN(fsazwz_sl)*price;
                $("#JXZH_FSAZWZ_TEMP").val(price2);
            }else if(fsxh_=="JF-FS-02"){
                price = 490*sl_;
                //扶手安装位置 
                var fsazwz_sl = $("input:checkbox[name='JXZH_FSAZWZ']:checked").length;
                var price2 = parseInt_DN(fsazwz_sl)*price;
                $("#JXZH_FSAZWZ_TEMP").val(price2);
            }else if(fsxh_=="JF-FS-03"){
                price = 490*sl_;
                //扶手安装位置 
                var fsazwz_sl = $("input:checkbox[name='JXZH_FSAZWZ']:checked").length;
                var price2 = parseInt_DN(fsazwz_sl)*price;
                $("#JXZH_FSAZWZ_TEMP").val(price2);
            }else if(fsxh_=="JF-FS-04"){
                price = 520*sl_;
                //扶手安装位置 
                var fsazwz_sl = $("input:checkbox[name='JXZH_FSAZWZ']:checked").length;
                var price2 = parseInt_DN(fsazwz_sl)*price;
                $("#JXZH_FSAZWZ_TEMP").val(price2);
            }else{
            	price=0;
            }
            $("#JXZH_FSXH_TEMP").val(price);
        }else if(option=="JXZH_FSAZWZ"){
            //扶手安装位置
            var fsazwz_sl = $("input:checkbox[name='JXZH_FSAZWZ']:checked").length;
            //单价
            var dj_ = parseInt_DN($("#JXZH_FSXH_TEMP").val());
            if(dj_>0)
            {
            	price = parseInt_DN(fsazwz_sl)*dj_;
                $("#JXZH_FSAZWZ_TEMP").val(price);
            }else
            {
            	$("#JXZH_FSAZWZ_TEMP").val(0);
            }
        }
        //放入价格
        countZhj();
    }

    //厅门门套部分-加价
    function editTmmt(option){
        //数量
        var sl_ = $("#FEIYANGXF_SL").val()==""?0:parseInt_DN($("#FEIYANGXF_SL").val());
        //价格
        var price = 0;
        if(option=="TMMT_PTDMT")
        {
        	//首层   大门套
            var ptdmt_ = $("#TMMT_PTDMT").val();
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            var ts = parseInt_DN($("#DMT_SL").val());    //套数
            if(ptdmt_=="喷涂"){
                if(kmkd_=="800"){
                    price = 1300*ts*sl_;
                }else if(kmkd_=="900"){
                    price = 1500*ts*sl_;
                }else if(kmkd_=="1100"){
                    price = 1600*ts*sl_;
                }else if(kmkd_=="1200"){
                    price = 1700*ts*sl_;
                }
            }else if(ptdmt_=="发纹不锈钢"){
                if(kmkd_=="800"){
                    price = 2000*ts*sl_;
                }else if(kmkd_=="900"){
                    price = 2100*ts*sl_;
                }else if(kmkd_=="1100"){
                    price = 2300*ts*sl_;
                }else if(kmkd_=="1200"){
                    price = 2400*ts*sl_;
                }
            }else if(ptdmt_=="镜面不锈钢"){
                if(kmkd_=="800"){
                    price = 2400*ts*sl_;
                }else if(kmkd_=="900"){
                    price = 2600*ts*sl_;
                }else if(kmkd_=="1100"){
                    price = 2800*ts*sl_;
                }else if(kmkd_=="1200"){
                    price = 3000*ts*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_PTDMT_TEMP").val(price);
            $("#TMMT_PTDMT_TEMP2").val(price);
        }else if(option=="TMMT_SCTMMT")
        {
        	//首层厅门门套
            var kmkd_ = $("#BZ_KMKD").val();    //开门宽度
            if($("#TMMT_SCTMMT1").is(":checked"))
            {
            	$("#TMMT_SCTMMT_TEMP").val("");
            	$("#TMMT_SCTMMT_TEMP2").val("");
            }
            else if($("#TMMT_SCTMMT2").is(":checked"))
            {
            	var ts2 = parseInt_DN($("#scmmt1").val());    //套数
            	if(kmkd_=="800"){
                    price = 950*ts2*sl_;
                }else if(kmkd_=="900"){
                    price = 710*ts2*sl_;
                }else if(kmkd_=="1100"){
                    price = 610*ts2*sl_;
                }else if(kmkd_=="1200"){
                    price = 480*ts2*sl_;
                }
            	$("#TMMT_SCTMMT_TEMP").val(price);
            	$("#TMMT_SCTMMT_TEMP2").val(price);
            }
            else if($("#TMMT_SCTMMT3").is(":checked"))
            {
            	var ts3 = parseInt_DN($("#scmmt1").val());    //套数
            	if(kmkd_=="800"){
                    price = -1050*ts3*sl_;
                }else if(kmkd_=="900"){
                    price = -1290*ts3*sl_;
                }else if(kmkd_=="1100"){
                    price = -1690*ts3*sl_;
                }else if(kmkd_=="1200"){
                    price = -1920*ts3*sl_;
                }
            	$("#TMMT_SCTMMT_TEMP").val(price);
            	$("#TMMT_SCTMMT_TEMP2").val(price);
            }
            
        }else if(option=="TMMT_FSCTMMT"){
        	 //非首层厅门门套
            var kmkd_ = $("#BZ_KMKD").val();    //开门宽度
            var c_ = parseInt_DN($("#BZ_C").val()-1);  //层
			
            if($("#TMMT_FSCTMMT1").is(":checked"))
            {
            	$("#TMMT_FSCTMMT_TEMP").val(0);
            	$("#TMMT_FSCTMMT_TEMP2").val(0);
            }
            else if($("#TMMT_FSCTMMT2").is(":checked"))
            {
            	
            	var ts2 = parseInt_DN($("#scmmt4").val());  //套数
            	if(kmkd_=="800"){
                    price = 2000*ts2*sl_;
                }else if(kmkd_=="900"){
                    price = 2000*ts2*sl_;
                }else if(kmkd_=="1100"){
                    price = 2300*ts2*sl_;
                }else if(kmkd_=="1200"){
                    price = 2400*ts2*sl_;
                }
            	$("#TMMT_FSCTMMT_TEMP").val(price);
            	$("#TMMT_FSCTMMT_TEMP2").val(price/ts2);
            }
            else if($("#TMMT_FSCTMMT3").is(":checked"))
            {
            	var ts3 = parseInt_DN($("#scmmt4").val());  //套数
            	if(kmkd_=="800"){
                    price = 1050*ts3*sl_;
                }else if(kmkd_=="900"){
                    price = 1290*ts3*sl_;
                }else if(kmkd_=="1100"){
                    price = 1690*ts3*sl_;
                }else if(kmkd_=="1200"){
                    price = 1920*ts3*sl_;
                }
            	$("#TMMT_FSCTMMT_TEMP").val(price);
            	$("#TMMT_FSCTMMT_TEMP2").val(price/ts3);
            }
            
        }else if(option=="FSC_DMT")
        {
            //非首层   大门套
            var fsc_dmt = $("#FSC_DMT").val();
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            var ts = parseInt_DN($("#FSC_DMT_SL").val());    //套数
            if(fsc_dmt=="喷涂"){
                if(kmkd_=="800"){
                    price = 1300*ts*sl_;
                }else if(kmkd_=="900"){
                    price = 1500*ts*sl_;
                }else if(kmkd_=="1100"){
                    price = 1600*ts*sl_;
                }else if(kmkd_=="1200"){
                    price = 1700*ts*sl_;
                }
            }else if(fsc_dmt=="发纹不锈钢"){
                if(kmkd_=="800"){
                    price = 2000*ts*sl_;
                }else if(kmkd_=="900"){
                    price = 2100*ts*sl_;
                }else if(kmkd_=="1100"){
                    price = 2300*ts*sl_;
                }else if(kmkd_=="1200"){
                    price = 2400*ts*sl_;
                }
            }else if(fsc_dmt=="镜面不锈钢"){
                if(kmkd_=="800"){
                    price = 2400*ts*sl_;
                }else if(kmkd_=="900"){
                    price = 2600*ts*sl_;
                }else if(kmkd_=="1100"){
                    price = 2800*ts*sl_;
                }else if(kmkd_=="1200"){
                    price = 3000*ts*sl_;
                }
            }else{
                price = 0;
            }
            $("#FSC_DMT_TEMP").val(price);
            $("#FSC_DMT_TEMP2").val(price/ts);
        }
        
        //放入价格
        countZhj();
    }
    

    //操纵盘-加价
    function editCzp(option){
        var sl_ = parseInt_DN($("#FEIYANGXF_SL").val());
        var price = 0;
        if(option=="CZP_CZPXH"){
            var xh_ = $("input[name='CZP_CZPXH']:checked").val();
            if(xh_=="JFCOP09H-C1"){
                //操纵盘显示
                var price_xs = 0;
                var xs_ = $("select[name='CZP_XS_SUB']").val();
                if(xs_=="真彩液晶图片显示7寸"){
                    price_xs = 1300*sl_;
                }else if(xs_=="真彩液晶图片显示10寸"){
                    price_xs = 2000*sl_;
                }else if(xs_=="真彩液晶多媒体显示10.4寸"){
                    price_xs = 6580*sl_;
                }else{
                    price_xs = 0;
                }
                $("#CZP_XS_TEMP").val(price_xs);
                //操纵盘按钮
                var price_an = 0;
                var an_ =  $("select[name='CZP_AN']").val();
                if(an_=="金属红光带字牌按钮"){
                    price_an = 31*sl_;
                }else{
                    price_an = 0;
                }
                $("#CZP_AN_TEMP").val(price_an);
                //材质
                var price_cz = 0;
                var cz_ = $("select[name='CZP_CZ']").val();
                if(cz_=="发纹不锈钢"){
                    price_cz = 0;
                }else if(cz_=="镜面不锈钢"){
                    price_cz = 500*sl_;
                }else if(cz_=="钛金不锈钢"){
                    price_cz = 700*sl_;
                }
                price = price_xs+price_an+price_cz;
                $("#CZP_CZPXH_TEMP").val(price);
            }else if(xh_=="XFCOP01H-C"){
                price = -500*sl_;
                $("#CZP_CZPXH_TEMP").val(price);
            }
        }
        //放入价格
        countZhj();
    }

    //厅门信号装置-加价
    function editTmxhzz(option){
        var sl_ = $("#FEIYANGXF_SL").val();
        var price = 0;
        if(option=="TMXHZZ_CZ"){
            //材质
            cz_ = $("select[name='TMXHZZ_CZ']").val();
            if(cz_=="发纹不锈钢"){
                price = 0;
            }else if(cz_=="镜面不锈钢"){
                price = 25*sl_;
            }else if(cz_=="钛金不锈钢"){
                price = 50*sl_;
            }
            $("#TMXHZZ_CZ_TEMP").val(price);
        }else if(option=="TMXHZZ_CZ_2")
        {
            //材质
            cz_ = $("#TMXHZZ_CZ_2").val();
            if(cz_=="发纹不锈钢"){
                price = 0;
            }else if(cz_=="镜面不锈钢"){
                price = 25*sl_;
            }else if(cz_=="钛金不锈钢"){
                price = 50*sl_;
            }
            $("#TMXHZZ_CZ_TEMP").val(price);
        }
        else if(option=="TMXHZZ_WZYCOPMWAN")
        {
            if($("#TMXHZZ_WZYCOPMWAN_TEXT").is(":checked"))
            {
                var c_ = parseInt_DN($("#BZ_C").val());
                if(2<c_ && c_<=16)
                {
                    price = 2900*sl_;
                }else if(16<c_ && c_<=30)
                {
                    price = 4100*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMXHZZ_WZYCOPMWAN_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }

    //--
    //运输价格部分
    //隐藏DIV
    function hideDiv(){
        var trans_type = $("#trans_type").val();
        if(trans_type=="1"){
            $("#ld").hide();
            $("#zc").show();
            $("#qy").show();
            $("#trans_price").attr('disabled',false);
        }else if(trans_type=="2"){
            $("#zc").hide();
            $("#ld").show();
            $("#qy").show();
            $("#trans_price").attr('disabled',false);
        }else if(trans_type=="3"){
            $("#zc").hide();
            $("#ld").hide();
            $("#qy").hide();
            $("#trans_price").val(0);
            $("#FEIYANGXF_YSF").val(0);
            $("#FEIYANG_XF_YSJ").val(0);
            $("#trans_price").attr('disabled',true);
        }
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
                        var transPrice = parseFloat(data.countPrice);
                        $("#FEIYANG_XF_YSJ").val(transPrice);
                        countZhj();
                        //计算总报价
                    	jsTatol();
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
                        var transPrice = parseFloat(data.countPrice);
                        $("#FEIYANGXF_YSF").val(transPrice);
                        $("#FEIYANG_XF_YSJ").val(transPrice);
                        countZhj();
                        //计算总报价
                    	jsTatol();
                    }
                );
        }
        else
        {
            countZhj();
            //计算总报价
        	jsTatol();
        }
        
        
        
    }

    function save(){
        
        if(validateIsInput()){

//         	removeAttrDisabled();
        	
        	var index = layer.load(1);
        	var saveFlag = "1";
			$.ajax({
			    type: 'POST',
			    url: '<%=basePath%>e_offerdt/saveFeiyangXF.do',
			    data: $("#feiyangxfForm").dn2_serialize(getSelectDis())+"&saveFlag="+saveFlag,
			    dataType: "JSON",
			    success: function(data) {
			    	layer.close(index);
			    	if(data.code == 1){
			    		buildofferButton(data);
			    		layer.msg('保存成功', {icon: 1});
			    		CloseSUWin('ElevatorParam');
			    	} else {
			    		layer.msg('保存失败', {icon: 2});
			    	}
			    },
			    error: function(data) {
			    	layer.close(index);
			    	layer.msg('操作失败', {icon: 2});
			    }
			});
        }
    }

    function getFBLXJSON() {
    	return ${fns:getDictListJson('fbtype')};
    }
    
    function validateIsInput(){
    	//非空验证
        if ($("#FEIYANG_XF_QTFY").val() == "" && $("#FEIYANG_XF_QTFY").val() == "") {
			$("#FEIYANG_XF_QTFY").focus();
			$("#FEIYANG_XF_QTFY").tips({
				side : 3,
				msg : "请填写其他费用!",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
        
        if ($("#FEIYANG_XF_YJZE").val() == "" && $("#FEIYANG_XF_YJZE").val() == "") {
			$("#FEIYANG_XF_YJZE").focus();
			$("#FEIYANG_XF_YJZE").tips({
				side : 3,
				msg : "请填写佣金费用!",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
        
        if ($("#FEIYANG_XF_CQSJDJ").val() == "" && $("#FEIYANG_XF_CQSJDJ").val() == "") {
			$("#FEIYANG_XF_CQSJDJ").focus();
			$("#FEIYANG_XF_CQSJDJ").tips({
				side : 3,
				msg : "请填写草签实际单价!",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
        
        if ($("#FEIYANG_XF_YSJ").val() == "" && $("#FEIYANG_XF_YSJ").val() == "") {
			$("#FEIYANG_XF_YSJ").focus();
			$("#FEIYANG_XF_YSJ").tips({
				side : 3,
				msg : "请录入运输价!",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}

        //new 全文NaN判断
       	var ss = true;
        $("input[type='text']").each(function () {
            if ($(this).val()=="NaN") {
            	$(this).focus();
    			$(this).tips({
    				side : 3,
    				msg : "此项为NaN!请复查!",
    				bg : '#AE81FF',
    				time : 3
    			});
    			ss = false;
                return false;
            }
        })
        if(!ss){
        	return false;
        }

        if(!validateRequired()){
        	return false;
        }
        
      	//非标json
        $("#UNSTD").val(getJsonStrfb());
        $("#trans_more_car").val(formatTransJson());
        //设置checkbox选项值
            //可选功能部分
        if($("#OPT_MWAN_TEXT").is(":checked")){
            $("#OPT_MWAN").val("1");
        }else{
            $("#OPT_MWAN").val("0");
        }
        //1
        if($("#OPT_HJZDFHJZ_TEXT").is(":checked")){
            $("#OPT_HJZDFHJZ").val("1");
        }else{
            $("#OPT_HJZDFHJZ").val("0");
        }
        //2
        if($("#OPT_XFYYX_TEXT").is(":checked")){
            $("#OPT_XFYYX").val("1");
        }else{
            $("#OPT_XFYYX").val("0");
        }
        if($("#OPT_JXDZZ_TEXT").is(":checked")){
            $("#OPT_JXDZZ").val("1");
        }else{
            $("#OPT_JXDZZ").val("0");
        }
        if($("#OPT_CCTVDL_TEXT").is(":checked")){
            $("#OPT_CCTVDL").val("1");
        }else{
            $("#OPT_CCTVDL").val("0");
        }
        if($("#OPT_TDJJJY_TEXT").is(":checked")){
            $("#OPT_TDJJJY").val("1");
        }else{
            $("#OPT_TDJJJY").val("0");
        }
        if($("#OPT_DJGRBH_TEXT").is(":checked")){
            $("#OPT_DJGRBH").val("1");
        }else{
            $("#OPT_DJGRBH").val("0");
        }
        if($("#OPT_KQJHZZ_TEXT").is(":checked")){
            $("#OPT_KQJHZZ").val("1");
        }else{
            $("#OPT_KQJHZZ").val("0");
        }
        if($("#OPT_FDLCZ_TEXT").is(":checked")){
            $("#OPT_FDLCZ").val("1");
        }else{
            $("#OPT_FDLCZ").val("0");
        }
        if($("#OPT_ZPC_TEXT").is(":checked")){
            $("#OPT_ZPC").val("1");
        }else{
            $("#OPT_ZPC").val("0");
        }
        if($("#OPT_BAJK_TEXT").is(":checked")){
            $("#OPT_BAJK").val("1");
        }else{
            $("#OPT_BAJK").val("0");
        }
        if($("#OPT_YXBZ_TEXT").is(":checked")){
            $("#OPT_YYBZ").val("1");
        }else{
            $("#OPT_YYBZ").val("0");
        }
        if($("#OPT_QPGM_TEXT").is(":checked")){
            $("#OPT_QPGM").val("1");
        }else{
            $("#OPT_QPGM").val("0");
        }
        if($("#OPT_DLFW_TEXT").is(":checked")){
            $("#OPT_DLFW").val("1");
        }else{
            $("#OPT_DLFW").val("0");
        }
        if($("#OPT_DLFW_TEXT").is(":checked")){
            $("#OPT_DLFW").val("1");
        }else{
            $("#OPT_DLFW").val("0");
        }
        if($("#OPT_KMBC_TEXT").is(":checked")){
            $("#OPT_KMBC").val("1");
        }else{
            $("#OPT_KMBC").val("0");
        }
        if($("#OPT_DZYX_TEXT").is(":checked")){
            $("#OPT_DZYX").val("1");
        }else{
            $("#OPT_DZYX").val("0");
        }
        if($("#OPT_NLHK_TEXT").is(":checked")){
            $("#OPT_NLHK").val("1");
        }else{
            $("#OPT_NLHK").val("0");
        }
        if($("#OPT_YCJK_TEXT").is(":checked")){
            $("#OPT_YCJK").val("1");
        }else{
            $("#OPT_YCJK").val("0");
        }
        if($("#OPT_ICKZKSB_TEXT").is(":checked")){
            $("#OPT_ICKZKSB").val("1");
        }else{
            $("#OPT_ICKZKSB").val("0");
        }
        if($("#OPT_JKGM_TEXT").is(":checked")){
            $("#OPT_JKGM").val("1");
        }else{
            $("#OPT_JKGM").val("0");
        }
        if($("#OPT_JKYYJ_TEXT").is(":checked")){
            $("#OPT_JKYYJ").val("1");
        }else{
            $("#OPT_JKYYJ").val("0");
        }
        if($("#OPT_GTMJXJMBF_TEXT").is(":checked")){
            $("#OPT_GTMJXJMBF").val("1");
        }else{
            $("#OPT_GTMJXJMBF").val("0");
        }
        if($("#OPT_GTMS_TEXT").is(":checked")){
            $("#OPT_GTMS").val("1");
        }else{
            $("#OPT_GTMS").val("0");
        }
        if($("#OPT_JFGT_TEXT").is(":checked")){
            $("#OPT_JFGT").val("1");
        }else{
            $("#OPT_JFGT").val("0");
        }
        
        
        if($("#CGFB_JXHL_TEXT").is(":checked")){
            $("#CGFB_JXHL").val("1");
        }else{
            $("#CGFB_JXHL").val("0");
        }
        if($("#CGFB_DZCZ_TEXT").is(":checked")){
            $("#CGFB_DZCZ").val("1");
        }else{
            $("#CGFB_DZCZ_TEXT").val("0");
        }
        if($("#CGFB_KMGD_TEXT").is(":checked")){
            $("#CGFB_KMGD").val("1");
        }else{
            $("#CGFB_KMGD").val("0");
        }
        
        if($("#CGFB_DKIP65_TEXT").is(":checked")){
            $("#CGFB_DKIP65").val("1");
        }else{
            $("#CGFB_DKIP65").val("0");
        }
        if($("#CGFB_PKM_TEXT").is(":checked")){
            $("#CGFB_PKM").val("1");
        }else{
            $("#CGFB_PKM").val("0");
        }
        if($("#CGFB_ZFSZAQB_TEXT").is(":checked")){
            $("#CGFB_ZFSZAQB").val("1");
        }else{
            $("#CGFB_ZFSZAQB").val("0");
        }
        
        /* if($("#CGFB_JXCC_TEXT").is(":checked")){
            $("#CGFB_JXCC").val("1");
        }else{
            $("#CGFB_JXCC").val("0");
        } */
        if($("#CGFB_JJFAJMK_TEXT").is(":checked")){
            $("#CGFB_JJFAJMK").val("1");
        }else{
            $("#CGFB_JJFAJMK").val("0");
        }
        

        var OPT_GTMTMBF=$("#OPT_GTMTMBF_TEXT").val();
        $("#OPT_GTMTMBF").val(OPT_GTMTMBF);

        var OPT_CMZH=$("#OPT_CMZH_TEXT").val();
        $("#OPT_CMZH").val(OPT_CMZH);

            //厅门门套部分
        if($("#TMMT_FWBXGXMT_TEXT").is(":checked")){
            $("#TMMT_FWBXGXMT").val("1");
        }else{
            $("#TMMT_FWBXGXMT").val("0");
        }
        if($("#TMMT_PTJMBXGTM_TEXT").is(":checked")){
            $("#TMMT_PTJMBXGTM").val("1");
        }else{
            $("#TMMT_PTJMBXGTM").val("0");
        }
            //厅门信号装置部分
        if($("#TMXHZZ_WZYCOPMWAN_TEXT").is(":checked")){
            $("#TMXHZZ_WZYCOPMWAN").val("1");
        }else{
            $("#TMXHZZ_WZYCOPMWAN").val("0");
        }
            
        if($("#TMXHZZ_GBSCJRCZX_TEXT").is(":checked")){
            $("#TMXHZZ_GBSCJRCZX").val("1");
        }else{
            $("#TMXHZZ_GBSCJRCZX").val("0");
        }
            
        //门类型门保护
        if($("input[name='BASE_MLXMBH']:checked").val()==""){
            $("input[name='BASE_MLXMBH']:checked").val($("#BASE_MLXMBH_TEXT").val())
        }
        //井道承重墙厚度
        if($("input[name='BASE_JDCZQHD']:checked").val()==""){
            $("input[name='BASE_JDCZQHD']:checked").val($("#BASE_JDCZQHD_TEXT").val())
        }
        //地板型号
        if($("input[name='JXZH_DBXH']:checked").val()==""){
            $("input[name='JXZH_DBXH']:checked").val($("#JXZH_DBXH_SELECT").val())
        }
        //扶手型号
        if($("input[name='JXZH_FSXH']:checked").val()==""){
            $("input[name='JXZH_FSXH']:checked").val($("#JXZH_FSXH_SELECT").val())
        }
        
        if($("#JXZH_FSAZWZ_HWB").is(":checked")){
            $("#JXZH_FSAZWZ_H").val("1");
        }else{
            $("#JXZH_FSAZWZ_H").val("0");
        }

        if($("#JXZH_FSAZWZ_ZWB").is(":checked")){
            $("#JXZH_FSAZWZ_Z").val("1");
        }else{
            $("#JXZH_FSAZWZ_Z").val("0");
        }

        if($("#JXZH_FSAZWZ_YWB").is(":checked")){
            $("#JXZH_FSAZWZ_Y").val("1");
        }else{
            $("#JXZH_FSAZWZ_Y").val("0");
        }

        return true;
    }
    
    function saveOfAjax() {
    	if(validateIsInput()){
           var index = layer.load(1);
			$.ajax({
			    type: 'POST',
			    url: '<%=basePath%>e_offerdt/${msg}.do',
			    data: $("#feiyangxfForm").dn2_serialize(getSelectDis()),
			    dataType: "JSON",
			    success: function(data) {
			    	layer.close(index);
			    	if(data.code == 1){
			    		updateId(data);
			    		buildofferButton(data);
			    		buildofferInfo(data);
			    		layer.msg('保存成功', {icon: 1});
			    	} else {
			    		layer.msg('保存失败', {icon: 2});
			    	}
			    },
			    error: function(data) {
			    	layer.close(index);
			    	layer.msg('操作失败', {icon: 2});
			    }
			});
    		
    	}
	}
    
    function updateId(data) {
		if($('#view').val() == 'save' && data){
			$('#view').val('edit');
			$('#FEIYANGXF_ID').val(data.dtCodId);
			$('#BJC_ID').val(data.bjc_id);
		}
	}
    
    /**
    * 非标添加基价时更新单价
    **/
    function updateDANJIA(dj) {
    	if(isNaN(dj)){
    		dj = 0;
    	}
    	//setTimeout(function(){
			basisDate.fbdj = dj;
			$("#SBJ_TEMP").val(dj*getEleNum());
	        $("#DANJIA").val(dj);
	        setMPrice();
            countZhj();
            //调用计算折扣
            JS_SJBJ();
	    //},500);
	}
    
   /**
    * 非标删除基价时更新单价
    **/
    function updateDANJIAOfDelete() {
    	basisDate.fbdj = null;
    	setSbj();
 	}
    
    //计算设备实际报价
    function JS_SJBJ()
    {
    	checkForm();
    	 var ShuiLv;//税率
  	    $.post("<%=basePath%>e_offer/getShuiLv",
                  {
                      "id":"1"
                  },function(result)
                  {
                      if(result.msg=="success")
                      {
                      	ShuiLv=result.pd.content;
                        //草签实际单价
                    	var cqsjdj=$("#FEIYANG_XF_CQSJDJ").val();
                    	//数量
                    	var sl=$("#FEIYANGXF_SL").val();
                    	//赋值给设备实际报价
                    	$("#FEIYANG_XF_SBSJBJ").val(cqsjdj*sl);
                    	
                    	//计算折扣并赋值
                    	var zkl;
                    	var qtfy=$("#FEIYANG_XF_QTFY").val()*ShuiLv;//其他费用
                    	var yjze=$("#FEIYANG_XF_YJZE").val()*ShuiLv;//佣金总额
                    	var sjbj=$("#FEIYANG_XF_SBSJBJ").val();//设备实际报价
                    	var fbj=$("#FEIYANG_XF_FBJ").val();//非标价
                    	var jj=parseInt_DN($("#SBJ_TEMP").val());//基价
                    	var xxjj=parseInt_DN($("#FEIYANG_XF_XXJJ").val());//选项加价
                    	var qtfya=getValueToFloat("#XS_QTFY");
                    	var a=sjbj-fbj-qtfy-yjze;
                    	var b=jj+xxjj;
                    	zkl=a/b;
                    	$("#FEIYANG_XF_ZKL").val((zkl*100).toFixed(1));
                    	
                    	//计算佣金比例并赋值
                    	var yjbl;
                    	/* var c=sjbj-fbj-qtfy;
                    	yjbl=c/b;
                    	$("#FEIYANG_XF_YJBL").val((yjbl*100).toFixed(1)); */
                    	yjbl=$("#FEIYANG_XF_YJZE").val()/(sjbj/ShuiLv);
                    	if(isNaN(yjbl)){
                    		$("#FEIYANG_XF_YJBL").val("0.0");
                    	}else{
                    		$("#FEIYANG_XF_YJBL").val((yjbl*100).toFixed(1));
                    	}
                    	
                    	//计算佣金使用折扣率和最高佣金
                    	var yjsyzkl;
                    	var ZGYJ;
                    	var ZGYJA;
                    	// (实际报价-非标费-其他费用*1.16)/(基价+选项)
                    	var c=sjbj-fbj-(qtfya*ShuiLv);
                    	//alert(sjbj+'-'+fbj+'-('+qtfya+'*'+ShuiLv+')'+'/'+b);
                    	yjsyzkl=c/b;
                    	$("#YJSYZKL").val((yjsyzkl*100).toFixed(1));
                    	
                    	var yjsyzkla = $("#YJSYZKL").val()==""?0:parseInt_DN($("#YJSYZKL").val());
                    	if(yjsyzkla<=65){
                    		ZGYJ=sjbj*0.04/ShuiLv;
                    		$("#ZGYJ").val((ZGYJ).toFixed(1));
                    	}else if(yjsyzkla>65 && yjsyzkla<=70){
                    		ZGYJ=sjbj*0.05/ShuiLv;
                    		$("#ZGYJ").val((ZGYJ).toFixed(1));
                    	}else if(yjsyzkla>70 && yjsyzkla<=75){
                    		ZGYJ=sjbj*0.06/ShuiLv;
                    		$("#ZGYJ").val((ZGYJ).toFixed(1));
                    	}else if(yjsyzkla>75){
                    		//((实际报价*6%)/1.16 +( (实际报价-非标-其他费用*1.16-(基价+选项)*85%)*50%)/1.16
                    		ZGYJ=((sjbj*0.06)/ShuiLv+(sjbj-fbj-(qtfya*ShuiLv)-b*0.85)*0.5)/ShuiLv;
                    		$("#ZGYJ").val((ZGYJ).toFixed(1));
                    	} 
                    	
                    	
                    	//判断佣金是否超标并赋值
                    	if(zkl*100<=65)
                    	{
                    		var q=(sjbj*0.4)/ShuiLv;
                    		if(yjze>q)
                    		{
                    			$("#FEIYANG_XF_SFCB").val("Y");
                    		}else{$("#FEIYANG_XF_SFCB").val("N");}
                    	}
                    	else if(66<=zkl*100<=70)
                    	{
                    		var q=(sjbj*0.5)/ShuiLv;
                    		if(yjze>q)
                    		{
                    			$("#FEIYANG_XF_SFCB").val("Y");
                    		}else{$("#FEIYANG_XF_SFCB").val("N");}
                    	}
                    	else if(71<=zkl*100<=75)
                    	{
                    		var q=(sjbj*0.6)/ShuiLv;
                    		if(yjze>q)
                    		{
                    			$("#FEIYANG_XF_SFCB").val("Y");
                    		}else{$("#FEIYANG_XF_SFCB").val("N");}
                    	}
                    	else if(zkl*100>75)
                    	{
                    		var q=(sjbj*0.6)/ShuiLv;
                    		var w=(jj+xxjj)*0.85;
                    		var e=sjbj-fbj-qtfy;
                    		var r=(q+(e-w)*0.5)/ShuiLv;
                    		if(yjze>r)
                    		{
                    			$("#FEIYANG_XF_SFCB").val("Y");
                    		}else{$("#FEIYANG_XF_SFCB").val("N");}
                    	}
                    	
                    	//计算总报价
                    	jsTatol();
                      }
                      else
                      {
                      	alert("存在异常，请联系管理员！");
                      }
                      
                  });
    	
    	
    }
    
    //计算总报价
    function jsTatol()
    {
    	//计算总报价
    	var sbsjzj_=parseInt_DN($("#FEIYANG_XF_SBSJBJ").val()==''?0:$("#FEIYANG_XF_SBSJBJ").val());//设备实际总价
    	var qtfy_=parseInt_DN($("#FEIYANG_XF_QTFY").val()==''?0:$("#FEIYANG_XF_QTFY").val());//其他费用
    	var azf_=parseInt_DN($("#FEIYANG_XF_AZJ").val()==''?0:$("#FEIYANG_XF_AZJ").val());//安装费
    	var ysf_=parseInt_DN($("#FEIYANG_XF_YSJ").val()==''?0:$("#FEIYANG_XF_YSJ").val());//运输费
    	var tatol=sbsjzj_+qtfy_+azf_+ysf_;
    	if(isNaN(tatol)){
    		$("#FEIYANG_XF_TATOL").val("");
    	}else{
    		$("#FEIYANG_XF_TATOL").val(tatol);
    	} 
    }
    
    //开门形式提示
    function SetKMXS(){
    	var kmxs_= $("#BZ_KMXS").val();
    	switch(kmxs_){
	    	case "左旁开":
				alert("旁开、中分双折需非标询价");
				break;
	    	case "右旁开":
				alert("旁开、中分双折需非标询价");
				break;
	    	case "中分双折":
				alert("旁开、中分双折需非标询价");
				break;
	    	default:
	    		break;
    	}
    }
    
    //验证表单输入数字
  	function checkForm(){
    	var checkCq=parseInt_DN($("#FEIYANG_XF_CQSJDJ").val());//草签实际单价
    	var checkQtfy=parseInt_DN($("#FEIYANG_XF_QTFY").val());//其他费用
    	var checkYjze=parseInt_DN($("#FEIYANG_XF_YJZE").val());//佣金总额

    	if(isNaN(checkCq))
    	{
    		document.getElementById('FEIYANG_XF_CQSJDJ').value='';
    	}
    	if(isNaN(checkQtfy))
    	{
    		document.getElementById('FEIYANG_XF_QTFY').value='';
    	}
    	if(isNaN(checkYjze))
    	{
    		document.getElementById('FEIYANG_XF_YJZE').value='';
    	} 
    }
</script>
</body>

</html>
