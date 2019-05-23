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
    <script src="static/js/installioncount.js?v=1.3"></script>
    <script type="text/javascript">
        var basePath="<%=basePath%>";
        var itemelecount="${itemelecount}";
        var basisDate = {
        		'fbdj':null,
        		'isLoadEnd':2
        }
    </script>
</head>

<body class="gray-bg">
    <div id="cbjView" class="animated fadeIn"></div>
    <div id="zhjView" class="animated fadeIn"></div>
    <form action="e_offer/${msg}.do" name="shinyForm" id="shinyForm" method="post">
        <input type="hidden" name="ele_type" id="ele_type" value="DT9">
    <input type="hidden" name="view" id="view" value="${pd.view}">
    <input type="hidden" name="BJC_ID" id="BJC_ID" value="${pd.BJC_ID}">
    <input type="hidden" name="SHINY_ID" id="SHINY_ID" value="${pd.SHINY_ID}">
    <input type="hidden" name="FLAG" id="FLAG" value="${FLAG}">
    <input type="hidden" name="rowIndex" id="rowIndex" value="${pd.rowIndex}">
    <input type="hidden" name="UNSTD" id="UNSTD" value="${pd.UNSTD}">
    <input type="hidden" name="MODELS_ID" id="MODELS_ID" value="${pd.MODELS_ID}">
    <input type="hidden" name="ITEM_ID" id="ITEM_ID" value="${pd.ITEM_ID}">
    <input type="hidden" name="ELEV_IDS" id="ELEV_IDS" value="${pd.ELEV_IDS}"> 
    <input type="hidden" name="BASE_BZJDZG" id="BASE_BZJDZG" >
<%--     <input type="hidden" name="YJSYZKL" id="YJSYZKL" value="${pd.YJSYZKL}"> --%>
    <input type="hidden" name="ZGYJ" id="ZGYJ" value="${pd.ZGYJ}">
    <input type="hidden" name="offer_version" id="offer_version" value="${pd.offer_version}">
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
                                                <option value="曳引货梯">曳引货梯</option>
                                            </select> -->
                                           <!-- 新增显示 -->  
                                          <c:if test="${pd.view== 'save' }">
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>载重(kg):</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_ZZ" name="BZ_ZZ" onchange="editZz()" required="required">
                                                <!--option value="1000" ${regelevStandardPd.ZZ=='1000'?'selected':''}>1000</option-->
                                                <option value="">请选择</option>
                                                <option value="2000" ${regelevStandardPd.ZZ=='2000'?'selected':''}>2000</option>
                                                <option value="3000" ${regelevStandardPd.ZZ=='3000'?'selected':''}>3000</option>
                                                <option value="4000" ${regelevStandardPd.ZZ=='4000'?'selected':''}>4000</option>
                                                <option value="5000" ${regelevStandardPd.ZZ=='5000'?'selected':''}>5000</option>
                                            </select>

                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>速度(m/s):</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_SD" name="BZ_SD" onchange="editSd();" required="required">
                                                <option value="">请选择</option>
                                                <option value="0.25" ${regelevStandardPd.SD=='0.25'?'selected':''}>0.25</option>
                                                <option value="0.5" ${regelevStandardPd.SD=='0.5'?'selected':''}>0.5</option>
                                                <option value="1.0" ${regelevStandardPd.SD=='1.0'?'selected':''}>1.0</option>
                                            </select>
                                        </div>

                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>开门形式</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_KMXS" name="BZ_KMXS" required="required">
                                                <option value="中分双折" ${regelevStandardPd.KMXS=='中分双折'?'selected':''}>中分双折</option>   
                                                <option value="左旁开" ${regelevStandardPd.KMXS=='左旁开'?'selected':''}>左旁开（请非标询价）</option>
                                                <option value="右旁开" ${regelevStandardPd.KMXS=='右旁开'?'selected':''}>右旁开（请非标询价）</option>
                                                <option value="中分" ${regelevStandardPd.KMXS=='中分'?'selected':''}>中分</option>
                                                <option value="中分三折" ${regelevStandardPd.KMXS=='中分三折'?'selected':''}>中分三折</option>
                                                <option value="其他" ${regelevStandardPd.KMXS=='其他'?'selected':''}>其他</option>
                                            </select>

                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>开门宽度:</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_KMKD" name="BZ_KMKD" onchange="setMPrice();" required="required">
                                                <option value="">请选择</option>
                                                <option value="其他">其他</option>
                                                <option value="1400">1400</option>
                                                <option value="1500">1500</option>
                                                <option value="1700">1700</option>
                                                <option value="2000">2000</option>
                                                <option value="2200">2200</option>
                                            </select>
                                            <label style="width:11%;margin-bottom: 10px">层站门:</label>
                                            <select class="form-control" style="width:7%" name="BZ_C" id="BZ_C" onchange="editC();$('#ELE_C').html(this.value);$('#BZ_Z').change();$('#BZ_M').change();">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control" style="width:7%" name="BZ_Z" id="BZ_Z" onchange="setSbj();$('#ELE_Z').html(this.value);">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control" style="width:7%" name="BZ_M" id="BZ_M" onchange="setMPrice();$('#ELE_M').html(this.value);">
                                                <option value="">请选择</option>
                                            </select>
                                         </c:if>
                                         
                                        <!-- 编辑显示 -->  
                                          <c:if test="${pd.view== 'edit' }">
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>载重(kg):</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_ZZ" name="BZ_ZZ" onchange="editZz()" required="required">
                                                <option value="">请选择</option>
                                                <option value="2000" ${pd.BZ_ZZ=='2000'?'selected':''}>2000</option>
                                                <option value="3000" ${pd.BZ_ZZ=='3000'?'selected':''}>3000</option>
                                                <option value="4000" ${pd.BZ_ZZ=='4000'?'selected':''}>4000</option>
                                                <option value="5000" ${pd.BZ_ZZ=='5000'?'selected':''}>5000</option> 
                                            </select>

                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>速度(m/s):</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_SD" name="BZ_SD" onchange="editSd();" required="required">
                                                <option value="">请选择</option>
                                                <option value="0.25" ${pd.BZ_SD=='0.25'?'selected':''}>0.25</option>
                                                <option value="0.5" ${pd.BZ_SD=='0.5'?'selected':''}>0.5</option>
                                                <option value="1.0" ${pd.BZ_SD=='1.0'?'selected':''}>1.0</option>
                                            </select>
                                        </div>

                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>开门形式</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_KMXS" name="BZ_KMXS">
                                                <option value="中分" ${pd.BZ_KMXS=='中分'?'selected':''}>中分</option>
                                                <option value="左旁开" ${pd.BZ_KMXS=='左旁开'?'selected':''}>左旁开（请非标询价）</option>
                                                <option value="中分双折" ${pd.BZ_KMXS=='中分双折'?'selected':''}>中分双折</option>
                                                <option value="右旁开" ${pd.BZ_KMXS=='右旁开'?'selected':''}>右旁开（请非标询价）</option>
                                                <option value="中分三折" ${pd.BZ_KMXS=='中分三折'?'selected':''}>中分三折</option>
                                                <option value="其他" ${pd.BZ_KMXS=='其他'?'selected':''}>其他</option>
                                            </select>

                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>开门宽度:</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_KMKD" name="BZ_KMKD" onchange="setMPrice();">
                                                <option value="">请选择</option>
                                                <option value="其他" ${pd.BZ_KMKD=='其他'?'selected':''}>其他</option>
                                                <option value="1400" ${pd.BZ_KMKD=='1400'?'selected':''}>1400</option>
                                                <option value="1500" ${pd.BZ_KMKD=='1500'?'selected':''}>1500</option>
                                                <option value="1700" ${pd.BZ_KMKD=='1700'?'selected':''}>1700</option>
                                                <option value="2000" ${pd.BZ_KMKD=='2000'?'selected':''}>2000</option>
                                                <option value="2200" ${pd.BZ_KMKD=='2200'?'selected':''}>2200</option>
                                            </select>
                                            <label style="width:11%;margin-bottom: 10px">层站门:</label>
                                            <select class="form-control" style="width:7%" name="BZ_C" id="BZ_C" onchange="editC();$('#ELE_C').html(this.value);$('#BZ_Z').change();$('#BZ_M').change();">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control" style="width:7%" name="BZ_Z" id="BZ_Z" onchange="setSbj();$('#ELE_Z').html(this.value);">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control" style="width:7%" name="BZ_M" id="BZ_M" onchange="setMPrice();$('#ELE_M').html(this.value);">
                                                <option value="">请选择</option>
                                            </select>
                                         </c:if>
                                              
                                           
                                        </div>
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px">数量:</label>
                                            <input type="text" class="form-control" id="SHINY_SL" name="SHINY_SL" value="${pd.SHINY_SL}" readonly="readonly" style="width:20%;">
                                            <input type="hidden" class="form-control" id="DT_SL" name="DT_SL" value="${pd.SHINY_SL}" readonly="readonly" style="width:20%;">
                                            <label style="width:11%;margin-bottom: 10px">单价:</label>
                                            <input type="text" class="form-control" id="DANJIA" name="DANJIA" value="${regelevStandardPd.PRICE}" readonly="readonly" style="width:20%;">
                                            
                                            <input type="hidden" id="SHINY_ZK" name="SHINY_ZK" value="${pd.SHINY_ZK}">
                                            
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
                                                          name="SBJ_TEMP" id="SBJ_TEMP" readonly="readonly" value="${regelevStandardPd.PRICE*pd.SHINY_SL}">
                                                    </td>
                                                    <!-- 选项加价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_XXJJ" id="XS_XXJJ" readonly="readonly" value="${pd.XS_XXJJ}"></td>
                                                    <!-- 折前价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_ZQJ" id="XS_ZQJ" readonly="readonly" value="${pd.XS_ZQJ}"></td>
                                                    <!-- 非标价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_FBJ" id="XS_FBJ" readonly="readonly" value="${pd.XS_FBJ}">
                                                    </td>
                                                    <!-- 其他费用 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;background-color:yellow;"
                                                         name="XS_QTFY" id="XS_QTFY" onkeyup="JS_SJBJ();" value="${pd.XS_QTFY}">
                                                    </td>
                                                    <!-- 佣金总额 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;background-color:yellow;"
                                                         name="XS_YJZE" id="XS_YJZE" onkeyup="JS_SJBJ();" value="${pd.XS_YJZE}">
                                                    </td>
                                                    <!-- 是否超标 -->
                                                    <input type="hidden" style="width:45px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_SFCB" id="XS_SFCB" value="${pd.XS_SFCB}" readonly="readonly">
                                                    <%-- <td><input type="text" style="width:45px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_SFCB" id="XS_SFCB" value="${pd.XS_SFCB}" readonly="readonly">
                                                    </td> --%>
                                                    <!-- 折扣率 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_ZKL" id="XS_ZKL" value="${pd.XS_ZKL}" readonly="readonly">
                                                    </td>
                                                    <!-- 草签实际单价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;background-color:yellow;"
                                                     name="XS_CQSJDJ" id="XS_CQSJDJ" onkeyup="JS_SJBJ();" value="${pd.XS_CQSJDJ}"></td>
                                                    <!-- 设备实际报价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_SBSJBJ" id="XS_SBSJBJ" readonly="readonly" value="${pd.XS_SBSJBJ}"></td>
                                                    <!-- 比例 -->
                                                    <input type="hidden" style="width:45px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_YJBL" id="XS_YJBL" value="${pd.XS_YJBL}" readonly="readonly">
                                                    <%-- <td><input type="text" style="width:45px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_YJBL" id="XS_YJBL" value="${pd.XS_YJBL}" readonly="readonly">
                                                    </td> --%>
                                                    <!-- 安装费 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_AZJ" id="XS_AZJ" value="${pd.XS_AZJ}" readonly="readonly">
                                                    </td>
                                                    <!-- 运输费 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_YSJ" id="XS_YSJ" value="${pd.XS_YSJ}" readonly="readonly">
                                                    </td>
                                                    <!-- 总报价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_TATOL" id="XS_TATOL" value="${pd.XS_TATOL}" readonly="readonly">
                                                    </td>
                                                    
                                                    
                                                    <input type="hidden"  name="SHINY_ZHJ" id="SHINY_ZHJ" value="${pd.SHINY_ZHJ}">
                                                    <input type="hidden"  name="SHINY_SBJ" id="SHINY_SBJ" value="${regelevStandardPd.PRICE}">
                                                    <input type="hidden"  name="SHINY_SBJBF" id="SHINY_SBJBF" >
                                                    <%-- <input type="hidden" name="SBJ_TEMP" id="SBJ_TEMP" value="${regelevStandardPd.PRICE}"> --%>
                                                    <span id="zk_">${pd.SHINY_ZK}</span>
                                                    <input type="hidden"  name="SHINY_ZHSBJ" id="SHINY_ZHSBJ" value="${pd.SHINY_ZHSBJ}">
                                                    <input type="hidden" name="SHINY_AZF" id="SHINY_AZF" value="${pd.SHINY_AZF}"/>
                                                    <input type="hidden"  name="SHINY_YSF" id="SHINY_YSF" value="${pd.SHINY_YSF}">
                                                    <input type="hidden"  name="SHINY_SJBJ" id="SHINY_SJBJ" value="${pd.SHINY_SJBJ}">
                                                </tr>
                                            </table>
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
                                                                <select name="BASE_KZXT" id="BASE_KZXT" class="form-control">
                                                                    
                                                                    <option value="交流变频调速微机控制" ${pd.BASE_KZXT=='交流变频调速微机控制'?'selected':''}>交流变频调速微机控制</option>
                                                                </select>
                                                            </td>
                                                            <td width="180">加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>控制方式</td>
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_KZFS" value="单台运转(G1C)" onclick="editGbcs('KZFS_JM');"${pd.BASE_KZFS=='单台运转(G1C)'?'checked':''}/>
                                                                单台运转(G1C)
                                                                <input type="radio" name="BASE_KZFS" value="两台联动(G2C)" onclick="editGbcs('KZFS_JM');"${pd.BASE_KZFS=='两台联动(G2C)'?'checked':''}/>
                                                                两台联动(G2C)
                                                            </td>
                                                           <td>
                                                           <!--  OPT_GBSCJRCZXCOP_TEMP -->
                                                            <input type="text" name="BASE_KZFS_TEMP" id="BASE_KZFS_TEMP" class="form-control" readonly="readonly">
                                                            </td>
                                                            
                                                          </tr>
                                                          <tr>
                                                            <td width="173">曳引主机</td>
                                                            <td colspan="2">
                                                                <select name="BASE_YYZJ" id="BASE_YYZJ" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="蜗轮蜗杆曳引机" ${pd.BASE_YYZJ=='蜗轮蜗杆曳引机'||pd.view== 'save'?'selected':''}>蜗轮蜗杆曳引机</option>
                                                                </select>
                                                            </td>
                                                            <td width="180"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>圈/钢梁间距</td>
                                                            <td colspan="2">
                                                                <input type="text" name="BASE_QGLJJ" id="BASE_QGLJJ" class="form-control" value="${pd.BASE_QGLJJ}"/>mm </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td><font color="red">*</font>轿厢规格CW*CD(mm)</td>
                                                            <td colspan="2">
                                                                <select name="BASE_JXGG" id="BASE_JXGG" class="form-control" required="required">
                                                                    <option value=''>请选择</option>
                                                                    <option value="1400×1600(1000kg)" ${pd.BASE_JXGG=='1400×1600(1000kg)'?'selected':''}>1400×1600(1000kg)</option>
                                                                    <option value="1700×2400(2000kg)" ${pd.BASE_JXGG=='1700×2400(2000kg)'?'selected':''}>1700×2400(2000kg)</option>
                                                                    <option value="2000×2800(3000kg)" ${pd.BASE_JXGG=='2000×2800(3000kg)'?'selected':''}>2000×2800(3000kg)</option>
                                                                    <option value="2000×3600(4000kg)" ${pd.BASE_JXGG=='2000×3600(4000kg)'?'selected':''}>2000×3600(4000kg)</option>
                                                                    <option value="2600×3400(5000kg)" ${pd.BASE_JXGG=='2600×3400(5000kg)'?'selected':''}>2600×3400(5000kg)</option>
                                                                    
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
                                                            <td>轿厢高度(非净高)</td>
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_JXGD" value="2100" ${pd.BASE_JXGD=='2100'?'checked':''}/>2100mm
                                                                <input type="radio" name="BASE_JXGD" value="2200" ${pd.BASE_JXGD=='2200'?'checked':''}/>2200mm
                                                                <input type="radio" name="BASE_JXGD" value="2300" ${pd.BASE_JXGD=='2300'?'checked':''}/>2300mm
                                                                <input type="radio" name="BASE_JXGD" value="2400" ${pd.BASE_JXGD=='2400'?'checked':''}/>2400mm
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>号梯代码</td>
                                                            <td colspan="2">
                                                                <input type="text" name="BASE_HTDM" id="BASE_HTDM" class="form-control" value="${pd.BASE_HTDM}">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>门机型号</td>
                                                            <td>
                                                                <select name="BASE_MJXH" id="BASE_MJXH" class="form-control" >
                                                                    <option value="">请选择</option>
                                                                    <option value="变频门机" ${pd.BASE_MJXH=='变频门机'||pd.view== 'save'?'selected':''}>变频门机</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>门保护方式</td>
                                                            <td>
                                                                <select name="BASE_MBHFS" id="BASE_MBHFS" class="form-control" >
                                                                    <option value="">请选择</option>
                                                                    <option value="2D光幕保护" ${pd.BASE_MBHFS=='2D光幕保护'?'selected':''}>2D光幕保护</option>
                                                                    <option value="进口光幕" ${pd.BASE_MBHFS=='进口光幕'?'selected':''}>进口光幕（请非标询价）</option>
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
                                                          </tr>
                                                          <tr>
                                                           <td>井道承重墙厚度</td>
                                                            <td width="300">
                                                                <input name="BASE_JDCZQHD" type="radio" value="250" ${pd.BASE_JDCZQHD=='250'?'checked':''} onclick="setJdczqhdDisable('1');"/>WT=250mm
                                                            </td>
                                                            <td >
                                                                <input name="BASE_JDCZQHD" type="radio" value="" onclick="setJdczqhdDisable('0');" ${pd.BASE_JDCZQHD=='250'?'':'checked'}/>
                                                                WT=<input name="BASE_JDCZQHD_TEXT" id="BASE_JDCZQHD_TEXT" type="text" class="form-control" style="width:100px"  value="${pd.BASE_JDCZQHD=='250'?'':pd.BASE_JDCZQHD}"/>mm
                                                            </td>
                                                            <td>&nbsp;</td>
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
                                                            <td>提升高度RISE</td>
                                                            <td>
                                                                <font color="red">*</font><input name="BASE_TSGD" id="BASE_TSGD" onkeyup="setJdzg();" type="text" class="form-control"  value="${pd.BASE_TSGD}" placeholder="必填" required="required"/>mm
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
                                                            <td>底坑S顶层K</td>
                                                            <td colspan="2">
                                                                <p>
                                                                  <font color="red">*</font>底坑深度:<input name="BASE_DKSD" id="BASE_DKSD" type="text"  onkeyup="setJdzg();" class="form-control" value="${pd.BASE_DKSD}" placeholder="必填" required="required"/>mm
                                                                </p>
                                                                <p>
                                                                  <font color="red">*</font>顶层高度:<input name="BASE_DCGD" id="BASE_DCGD" type="text"  onkeyup="setJdzg();" class="form-control" value="${pd.BASE_DCGD}" placeholder="必填" required="required"/>mm
                                                                </p>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道总高</td>
                                                            <td colspan="2">
                                                                <input name="BASE_JDZG" id="BASE_JDZG" type="text" class="form-control" value="${pd.BASE_JDZG}" readonly="readonly"/>
                                                            </td>
                                                            <td>
                                                                <input type="hidden" name="BASE_JDZG_TEMP" id="BASE_JDZG_TEMP" class="form-control" readonly="readonly">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>基站驻停</td>
                                                            <td colspan="2"> 在
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
                                                          </tr>
                                                          <tr>
                                                            <td>导轨支架</td>
                                                            <td colspan="2">
                                                                <input name="BASE_DGZJ" id="BASE_DGZJ" type="text" class="form-control" value="${pd.BASE_DGZJ}" onkeyup="setDgzj();" />
                                                            </td>
                                                            <td>
                                                                <input type="text" name="BASE_DGZJ_TEMP" id="BASE_DGZJ_TEMP" class="form-control" readonly="readonly">
                                                                <label class="intro" style="color: red;display: none;width: 50%;" id="DGZJ_Label">请非标询价</label>
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>轿厢出入口数量</td>
                                                            <td colspan="2">
                                                                <%-- <input name="BASE_JXCRKSL" id="BASE_JXCRKSL" type="text" class="form-control" value="${pd.BASE_JXCRKSL}" onkeyup="setDgzj();" /> --%>
                                                                <select name="BASE_JXCRKSL" id="BASE_JXCRKSL" onchange="editGbcs('JXCRKSL_JM');" class="form-control">
                                                                    
                                                                    <option value="1" ${pd.BASE_JXCRKSL=='1'?'selected':''}>1</option>
                                                                    <option value="2" ${pd.BASE_JXCRKSL=='2'?'selected':''}>2</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                              <input type="hidden" name="BASE_JXCRKSL_TEMP" id="BASE_JXCRKSL_TEMP" class="form-control" readonly="readonly">
                                                            </td>
                                                          </tr>
                                                        </table>
                                                    <!-- 基本参数 -->
                                                </div>
                                                <div id="tab-2" class="tab-pane">
                                                    <!-- 标准功能 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="4">标准功能及代码</td>
                                                          </tr>
                                                          <tr>
                                                            <td width="62">1</td>
                                                            <td width="224">无呼自返基站功能(LOBBY)</td>
                                                            <td width="42">14</td>
                                                            <td width="241">设置厅、轿门时间(CHT)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>2</td>
                                                            <td>关门时间保护(DTP)</td>
                                                            <td>15</td>
                                                            <td>开、关门按钮(DOB&DCB)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>3</td>
                                                            <td>紧急消防操作(EFO)</td>
                                                            <td>16</td>
                                                            <td>轿内紧急照明(ECU)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>4</td>
                                                            <td>全集选控制(FCL)</td>
                                                            <td>17</td>
                                                            <td>厅和轿厢数字式位置指示器(HPI&CPI)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>5</td>
                                                            <td>厅和轿厢呼梯/登记(HTTL&CTTL)</td>
                                                            <td>18</td>
                                                            <td>厅及轿厢运行方向显示(HDI&CDI)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>6</td>
                                                            <td>监控室与机房、轿厢对讲（不含机房到监控室连线）(ICU-5)</td>
                                                            <td>19</td>
                                                            <td>独立服务(ISC)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>7</td>
                                                            <td>满载不停梯(LNS)</td>
                                                            <td>20</td>
                                                            <td>超载不启动(警示灯及蜂鸣器)(OLD)</td>
                                                          </tr>
                                                          <tr>
                                                            <td>8</td>
                                                            <td>运行次数显示功能(TRIC)</td>
                                                            <td>21</td>
                                                            <td>轿顶与机房紧急电动运行</td>
                                                          </tr>
                                                          <tr>
                                                            <td>9</td>
                                                            <td>轿内通风手动及照明自动控制功能</td>
                                                            <td>22</td>
                                                            <td>故障自动检测功能</td>
                                                          </tr>
                                                          <tr>
                                                            <td>10</td>
                                                            <td>警铃</td>
                                                            <td>23</td>
                                                            <td>光幕门保护装置 </td>
                                                          </tr>
                                                          <tr>
                                                            <td>11</td>
                                                            <td>误登陆取消</td>
                                                            <td>24</td>
                                                            <td>驻停</td>
                                                          </tr>
                                                          <tr>
                                                            <td>12</td>
                                                            <td>门保持按钮</td>
                                                            <td>25</td>
                                                            <td></td>
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
                                                            <td>有</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>1</td>
                                                            <td>机房高台<=2000mm</td>
                                                            <td>
                                                                <input name="OPT_JFGT_TEXT" id="OPT_JFGT_TEXT" type="checkbox" onclick="editOpt('OPT_JFGT');" ${pd.OPT_JFGT=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JFGT" id="OPT_JFGT">
                                                            </td>
                                                            <td><input type="text" name="OPT_JFGT_TEMP" id="OPT_JFGT_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <%-- <tr>
                                                            <td>2</td>
                                                            <td>COP</td>
                                                            <td>
                                                                <select name="OPT_COP" id="OPT_COP" onchange="editOpt('OPT_COP');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="JFHB06H-E" ${pd.OPT_COP=='JFHB06H-E'?'selected':''}>JFHB06H-E</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_COP_TEMP" id="OPT_COP_TEMP" class="form-control"></td>
                                                          </tr> --%>
                                                          <tr>
                                                            <td>3</td>
                                                            <td>外召与COP盲文按钮（只）</td>
                                                            <td>
                                                                <input name="OPT_WZYCOPMWAN" id="OPT_WZYCOPMWAN" type="text" onkeyup="editOpt('OPT_WZYCOPMWAN');"  value="${pd.OPT_WZYCOPMWAN}" class="form-control"/>
                                                            </td>
                                                            <td><input type="text" name="OPT_WZYCOPMWAN_TEMP" id="OPT_WZYCOPMWAN_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>4</td>
                                                            <td>挂壁式残疾人操纵箱COP</td>
                                                            <td>
                                                                <input name="OPT_GBSCJRCZXCOP_TEXT" id="OPT_GBSCJRCZXCOP_TEXT" type="checkbox" onclick="editOpt('OPT_GBSCJRCZXCOP');"  ${pd.OPT_GBSCJRCZXCOP=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_GBSCJRCZXCOP" id="OPT_GBSCJRCZXCOP">
                                                            </td>
                                                            <td><input type="text" name="OPT_GBSCJRCZXCOP_TEMP" id="OPT_GBSCJRCZXCOP_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <%-- <tr>
                                                            <td>5</td>
                                                            <td>LOP（个）</td>
                                                            <td>
                                                                <input name="OPT_LOP" id="OPT_LOP" type="text" onkeyup="editOpt('OPT_LOP');"  value="${pd.OPT_LOP}" class="form-control"/>
                                                            </td>
                                                            <td><input type="text" name="OPT_LOP_TEMP" id="OPT_LOP_TEMP" class="form-control"></td>
                                                          </tr> --%>
                                                          <tr>
                                                            <td>6</td>
                                                            <td>防捣乱操作</td>
                                                            <td>
                                                                <input name="OPT_FDLCZ_TEXT" id="OPT_FDLCZ_TEXT" type="checkbox" onclick="editOpt('OPT_FDLCZ');"  ${pd.OPT_FDLCZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_FDLCZ" id="OPT_FDLCZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_FDLCZ_TEMP" id="OPT_FDLCZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                         <%--  <tr>
                                                            <td>7</td>
                                                            <td>停电应急救援</td>
                                                            <td>
                                                                <input name="OPT_TDJJJY_TEXT" id="OPT_TDJJJY_TEXT" type="checkbox" onclick="editOpt('OPT_TDJJJY');"  ${pd.OPT_TDJJJY=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_TDJJJY" id="OPT_TDJJJY">
                                                            </td>
                                                            <td><input type="text" name="OPT_TDJJJY_TEMP" id="OPT_TDJJJY_TEMP" class="form-control"></td>
                                                          </tr> --%>
                                                          <tr>
                                                            <td>8</td>
                                                            <td>有司机操作</td>
                                                            <td>
                                                                <input name="OPT_YSJCZ_TEXT" id="OPT_YSJCZ_TEXT" type="checkbox" onclick="editOpt('OPT_YSJCZ');"  ${pd.OPT_YSJCZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_YSJCZ" id="OPT_YSJCZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_YSJCZ_TEMP" id="OPT_YSJCZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>9</td>
                                                            <td>CCTV电缆（轿厢到机房）(m)</td>
                                                            <td>
                                                                <input name="OPT_CCTVDL_TEXT" id="OPT_CCTVDL_TEXT" type="checkbox" onclick="editOpt('OPT_CCTVDL');"  ${pd.OPT_CCTVDL=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_CCTVDL" id="OPT_CCTVDL">
                                                                <%-- <input name="OPT_CCTVDL" id="OPT_CCTVDL" type="text" onkeyup="editOpt('OPT_CCTVDL');"  value="${pd.OPT_CCTVDL}" class="form-control"/> --%>
                                                            </td>
                                                            <td><input type="text" name="OPT_CCTVDL_TEMP" id="OPT_CCTVDL_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr><tr>
                                                            <td>10</td>
                                                            <td>紧急备用电源操作装置</td>
                                                            <td>
                                                                <input name="OPT_JJBYDYCZZZ_TEXT" id="OPT_JJBYDYCZZZ_TEXT" type="checkbox" onclick="editOpt('OPT_JJBYDYCZZZ');"  ${pd.OPT_JJBYDYCZZZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JJBYDYCZZZ" id="OPT_JJBYDYCZZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_JJBYDYCZZZ_TEMP" id="OPT_JJBYDYCZZZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>11</td>
                                                            <td>轿厢到站钟</td>
                                                            <td>
                                                                <input name="OPT_JXDZZ_TEXT" id="OPT_JXDZZ_TEXT" type="checkbox" onclick="editOpt('OPT_JXDZZ');"  ${pd.OPT_JXDZZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_JXDZZ" id="OPT_JXDZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_JXDZZ_TEMP" id="OPT_JXDZZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>12</td>
                                                            <td>再平层</td>
                                                            <td>
                                                                <input name="OPT_ZPC_TEXT" id="OPT_ZPC_TEXT" type="checkbox" checked="checked" onclick="editOpt('OPT_ZPC');"  ${pd.OPT_ZPC=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_ZPC" id="OPT_ZPC">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZPC_TEMP" id="OPT_ZPC_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>13</td>
                                                            <td>远程监视接口准备</td>
                                                            <td>
                                                                <input name="OPT_YCJSJKZB_TEXT" id="OPT_YCJSJKZB_TEXT" type="checkbox" onclick="editOpt('OPT_YCJSJKZB');"  ${pd.OPT_YCJSJKZB=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_YCJSJKZB" id="OPT_YCJSJKZB">
                                                            </td>
                                                            <td><input type="text" name="OPT_YCJSJKZB_TEMP" id="OPT_YCJSJKZB_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>14</td>
                                                            <td>语音报站</td>
                                                            <td>
                                                                <input name="OPT_YYBZ_TEXT" id="OPT_YYBZ_TEXT" type="checkbox" onclick="editOpt('OPT_YYBZ');"  ${pd.OPT_YYBZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_YYBZ" id="OPT_YYBZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_YYBZ_TEMP" id="OPT_YYBZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>15</td>
                                                            <td>火警自动返回基站</td>
                                                            <td>
                                                                <input name="OPT_HJZDFHJZ_TEXT" id="OPT_HJZDFHJZ_TEXT" type="checkbox" onclick="editOpt('OPT_HJZDFHJZ');" ${pd.OPT_HJZDFHJZ=='1'?'checked':''} />
                                                                <input type="hidden" name="OPT_HJZDFHJZ" id="OPT_HJZDFHJZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_HJZDFHJZ_TEMP" id="OPT_HJZDFHJZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>16</td>
                                                            <td>BA接口</td>
                                                            <td>
                                                                <input name="OPT_BAJK_TEXT" id="OPT_BAJK_TEXT" type="checkbox" onclick="editOpt('OPT_BAJK');"  ${pd.OPT_BAJK=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_BAJK" id="OPT_BAJK">
                                                            </td>
                                                            <td><input type="text" name="OPT_BAJK_TEMP" id="OPT_BAJK_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>17</td>
                                                            <td>电机过热保护</td>
                                                            <td>
                                                                <input name="OPT_DJGRBH_TEXT" id="OPT_DJGRBH_TEXT" type="checkbox" onclick="editOpt('OPT_DJGRBH');"  ${pd.OPT_DJGRBH=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_DJGRBH" id="OPT_DJGRBH">
                                                            </td>
                                                            <td><input type="text" name="OPT_DJGRBH_TEMP" id="OPT_DJGRBH_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>18</td>
                                                            <td>消防联动</td>
                                                            <td>
                                                                <input name="OPT_XFLD_TEXT" id="OPT_XFLD_TEXT" type="checkbox" onclick="editOpt('OPT_XFLD');"  ${pd.OPT_XFLD=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_XFLD" id="OPT_XFLD">
                                                            </td>
                                                            <td><input type="text" name="OPT_XFLD_TEMP" id="OPT_XFLD_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>19</td>
                                                            <td>厅外消防员服务</td>
                                                            <td>
                                                                <input name="OPT_TWXFYFW_TEXT" id="OPT_TWXFYFW_TEXT" type="checkbox" onclick="editOpt('OPT_TWXFYFW');"  ${pd.OPT_TWXFYFW=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_TWXFYFW" id="OPT_TWXFYFW">
                                                            </td>
                                                            <td><input type="text" name="OPT_TWXFYFW_TEMP" id="OPT_TWXFYFW_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>20</td>
                                                            <td>飞弈货梯有机房新国标<span style="color: red;">（默认非标加价）</span></td>
                                                            <td>
                                                                <input name="OPT_FYHTYJFXGB_TEXT" disabled="disabled" id="OPT_FYHTYJFXGB_TEXT" type="checkbox" onclick="editOpt('OPT_FYHTYJFXGB');"  ${pd.OPT_FYHTYJFXGB=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_FYHTYJFXGB" id="OPT_FYHTYJFXGB">
                                                            </td>
                                                            <td><input type="text" name="OPT_FYHTYJFXGB_TEMP" id="OPT_FYHTYJFXGB_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>21</td>
                                                            <td>贯通轿厢</td>
                                                            <td>
                                                               	<input type="checkbox" name="OPT_GTJX_TEXT" id="OPT_GTJX_TEXT" onclick="editGbcs('OPT_GTJX')" ${pd.OPT_GTJX=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_GTJX" id="OPT_GTJX">
                                                            </td>
                                                            <td>
                                                              <input type="text" name="OPT_GTJX_TEMP" id="OPT_GTJX_TEMP" class="form-control" readonly="readonly">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>22</td>
                                                            <td>贯通门数</td>
                                                            <td>
                                                               <input name="BASE_GTMS" id="BASE_GTMS" type="text" class="form-control" value="${pd.BASE_GTMS}"  />
                                                            </td>
                                                            <td>
                                                              <input type="text" name="BASE_GTMS_TEMP" id="BASE_GTMS_TEMP" class="form-control" readonly="readonly">
                                                              <label class="intro" style="color: red;display: none;" id="GTMMS_Label">请非标询价</label>
                                                            </td>
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
                                                                <select name="DZJKSDJXT_DJTXFS" id="DZJKSDJXT_DJTXFS" class="form-control">
                                                                    <option value="单梯对讲" ${pd.DZJKSDJXT_DJTXFS=='单梯对讲'?'selected':''}>单梯对讲</option>
                                                                    <option value="对讲集中管理(5台以内)" ${pd.DZJKSDJXT_DJTXFS=='对讲集中管理(5台以内)'?'selected':''}>对讲集中管理(5台以内)</option>
                                                                    <option value="对讲集中管理(6~64台)" ${pd.DZJKSDJXT_DJTXFS=='对讲集中管理(6~64台)'?'selected':''}>对讲集中管理(6~64台)</option>
                                                                </select>
                                                            </td>
                                                            <td colspan="2"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>同群组的设备号</td>
                                                            <td colspan="2"><input type="text" name="DZJKSDJXT_TQZDSBH" id="DZJKSDJXT_TQZDSBH" class="form-control" value="${pd.DZJKSDJXT_TQZDSBH}"/></td>
                                                          </tr>
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
                                                                <input name="JXZH_JM" type="radio" value="发纹不锈钢" onclick="editJxzh('JXZH_JM');" ${pd.JXZH_JM=='发纹不锈钢'?'checked':''} />
                                                                发纹不锈钢
                                                            </td>
                                                            <td>
                                                       <%--          <input name="JXZH_JM" type="radio" value="镜面不锈钢" onclick="editJxzh('JXZH_JM');"  ${pd.JXZH_JM=='镜面不锈钢'?'checked':''}/>
                                                                镜面不锈钢 --%>
                                                                <input name="JXZH_JM" type="radio" value="钢板喷涂" onclick="editJxzh('JXZH_JM');"  ${pd.JXZH_JM=='钢板喷涂'?'checked':''}/>
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_JMSBH" id="JXZH_JMSBH" class="form-control" onchange="editJxzh('JXZH_JMSBH');">
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
                                                                <input name="JXZH_QWB" type="radio" value="发纹不锈钢" onclick="editJxzh('JXZH_QWB');"  ${pd.JXZH_QWB=='发纹不锈钢'?'checked':''}/>
                                                                发纹不锈钢
                                                            </td>
                                                            <td>
                                                      <%--           <input name="JXZH_QWB" type="radio" value="镜面不锈钢" onclick="editJxzh('JXZH_QWB');"  ${pd.JXZH_QWB=='镜面不锈钢'?'checked':''}/>
                                                                镜面不锈钢 --%>
                                                                <input name="JXZH_QWB" type="radio" value="钢板喷涂" onclick="editJxzh('JXZH_QWB');"  ${pd.JXZH_QWB=='钢板喷涂'?'checked':''}/>
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_QWBSBH" id="JXZH_QWBSBH" class="form-control" onchange="editJxzh('JXZH_QWBSBH');">
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
                                                                            <br><br><font color="red">注：如三侧不一致请非标询价</font>
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>侧围壁</td>
                                                            <td>
                                                                <input name="JXZH_CWB" type="radio" value="发纹不锈钢" onclick="editJxzh('JXZH_CWB');"  ${pd.JXZH_CWB=='发纹不锈钢'?'checked':''}/>
                                                                发纹不锈钢
                                                            </td>
                                                            <td>
                                      <%--                           <input name="JXZH_CWB" type="radio" value="镜面不锈钢" onclick="editJxzh('JXZH_CWB');"  ${pd.JXZH_CWB=='镜面不锈钢'?'selected':''}/>
                                                                镜面不锈钢 --%>
                                                                <input name="JXZH_CWB" type="radio" value="钢板喷涂" onclick="editJxzh('JXZH_CWB');"  ${pd.JXZH_CWB=='钢板喷涂'?'checked':''}/>
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_CWBSBH" id="JXZH_CWBSBH" class="form-control" onchange="editJxzh('JXZH_CWBSBH');">
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
                                                                <input name="JXZH_HWB" type="radio" value="发纹不锈钢" onclick="editJxzh('JXZH_HWB');" ${pd.JXZH_HWB=='发纹不锈钢'?'checked':''}/>
                                                                发纹不锈钢
                                                            </td>
                                                            <td>
                                        <!--                         <input name="JXZH_HWB" type="radio" value="镜面不锈钢" onclick="editJxzh('JXZH_HWB');" />
                                                                镜面不锈钢 -->
                                                                <input name="JXZH_HWB" type="radio" value="钢板喷涂" onclick="editJxzh('JXZH_HWB');" ${pd.JXZH_HWB=='钢板喷涂'?'checked':''}/>
                                                                喷涂 
                                                                色标号:
                                                                <select name="JXZH_HWBSBH" id="JXZH_HWBSBH" class="form-control" onchange="editJxzh('JXZH_HWBSBH');">
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
                                                           <!--  <td><input type="text" name="JXZH_HWB_TEMP" id="JXZH_HWB_TEMP" class="form-control"></td> -->
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">轿顶装潢</td>
                                                            <td>
                                                                <select name="JXZH_JDZH" onchange="editJxzh('JXZH_JDZH');" id="JXZH_JDZH" class="form-control">
                                                                    <option value=''>请选择</option>
                                                                    <option value="钢板喷涂" ${pd.JXZH_JDZH=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.JXZH_JDZH=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td><input type="text" name="JXZH_JDZH_TEMP" id="JXZH_JDZH_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">轿顶安全窗</td>
                                                            <td>
                                                                <select name="JXZH_JDAQC" id="JXZH_JDAQC" onchange="editJxzh('JXZH_JDAQC');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="带安全窗(536mm*355mm)" ${pd.JXZH_JDAQC=='带安全窗(536mm*355mm)'?'selected':''}>带安全窗(536mm*355mm)</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td>
                                                             <input type="text" name="JXZH_JDAQC_TEMP" id="JXZH_JDAQC_TEMP" class="form-control" readonly="readonly">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">地板型号</td>
                                                            <td>
                                                                <select name="JXZH_DBXH" id="JXZH_DBXH" onchange="editJxzh('JXZH_DBXH');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <%-- <option value="PVC 型号JD-08" ${pd.JXZH_DBXH=='PVC 型号JD-08'?'selected':''}>PVC 型号JD-08</option> --%>
                                                                    <option value="普通花纹钢板" ${pd.JXZH_DBXH=='普通花纹钢板'?'selected':''}>普通花纹钢板</option>
                                                                    <option value="不锈钢花纹钢板" ${pd.JXZH_DBXH=='不锈钢花纹钢板'?'selected':''}>不锈钢花纹钢板</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td><input type="text" name="JXZH_DBXH_TEMP" id="JXZH_DBXH_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">地板装修厚度mm</td>
                                                            <td><input type="text" name="JXZH_DBZXHD" id="JXZH_DBZXHD" class="form-control" onkeyup="editJxzh('JXZH_DBZXHD');" value="${pd.JXZH_DBZXHD}"></td>
                                                            <td></td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">预留装潢重量kg</td>
                                                            <td><input type="text" name="JXZH_YLZHZL" id="JXZH_YLZHZL" class="form-control" onkeyup="editJxzh('JXZH_YLZHZL');" value="${pd.JXZH_YLZHZL}"></td>
                                                            <td></td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">防撞条型号</td>
                                                            <td>
                                                                <select name="JXZH_FZTXH" id="JXZH_FZTXH" onchange="editJxzh('JXZH_FZTXH');" class="form-control">
                                                                    <option value="" ${pd.JXZH_FZTXH==''?'selected':''}>请选择</option>
                                                                    <option value="木条" ${pd.JXZH_FZTXH=='木条'?'selected':''}>木条</option>
                                                                    <option value="橡胶条" ${pd.JXZH_FZTXH=='橡胶条'?'selected':''}>橡胶条</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                            <td><input type="text" name="JXZH_FZTXH_TEMP" id="JXZH_FZTXH_TEMP" class="form-control" readonly="readonly">
                                                            	<label class="intro" style="color: red;display: none;" id="JXZH_FZTXH_Label">请非标询价</label>
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">防撞条安装位置</td>
                                                            <td>
                                                                <input name="JXZH_FZTAZWZ1" type="checkbox" value="后围壁" ${pd.JXZH_FZTAZWZ1=='后围壁'?'checked':''}/>后围壁 
                                                                <input name="JXZH_FZTAZWZ2" type="checkbox" value="左围壁" ${pd.JXZH_FZTAZWZ2=='左围壁'?'checked':''}/>左围壁
                                                                <input name="JXZH_FZTAZWZ3" type="checkbox" value="右围壁" ${pd.JXZH_FZTAZWZ3=='右围壁'?'checked':''}/>右围壁
                                                                <%-- <select name="JXZH_FZTAZWZ" id="JXZH_FZTAZWZ" onchange="editJxzh('JXZH_FZTAZWZ');" class="form-control">
                                                                    <option value="后围壁" ${pd.JXZH_FZTAZWZ=='后围壁'?'selected':''}>后围壁</option>
                                                                    <option value="左围壁" ${pd.JXZH_FZTAZWZ=='左围壁'?'selected':''}>左围壁</option>
                                                                    <option value="右围壁" ${pd.JXZH_FZTAZWZ=='右围壁'?'selected':''}>右围壁</option>
                                                                </select> --%>
                                                            </td>
                                                            <td></td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">半高镜</td>
                                                            <td>
                                                                <input type="checkbox" name="JXZH_BGJ" id="JXZH_BGJ" onclick="editJxzh('JXZH_BGJ');" ${pd.JXZH_BGJ=='1'?'checked':''}>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td><input type="text" name="JXZH_BGJ_TEMP" id="JXZH_BGJ_TEMP" class="form-control" readonly="readonly">
                                                            	<label class="intro" style="color: red;display: none;" id="JXZH_BGJ_Label">请非标询价</label>
                                                            </td>
                                                          </tr>
                                                        </table>
                                                    <!-- 轿厢装潢 -->
                                                </div>
                                                <div id="tab-6" class="tab-pane">
                                                    <!-- 厅门门套 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>首层门套材质（小门框）</td>
                                                            <td colspan="2">
                                                                <select name='TMMT_SCTMMTCZXMK' id="TMMT_SCTMMTCZXMK" onchange="editTmmt('TMMT_SCTMMTCZXMK');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_SCTMMTCZXMK=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_SCTMMTCZXMK=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                   <%--  <option value="镜面不锈钢" ${pd.TMMT_SCTMMTCZXMK=='镜面不锈钢'?'selected':''}>镜面不锈钢</option> --%>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMMT_SCTMMTCZXMK_TEMP" id="TMMT_SCTMMTCZXMK_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>首层门套（小门框）钢板色标号</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_SCTMMTCZXMKSBH" name="TMMT_SCTMMTCZXMKSBH" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.TMMT_SCTMMTCZXMKSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.TMMT_SCTMMTCZXMKSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.TMMT_SCTMMTCZXMKSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.TMMT_SCTMMTCZXMKSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.TMMT_SCTMMTCZXMKSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.TMMT_SCTMMTCZXMKSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.TMMT_SCTMMTCZXMKSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>套数</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_SCTMMTCZXMKTS" id="TMMT_SCTMMTCZXMKTS" value="${pd.TMMT_SCTMMTCZXMKTS}" class="form-control" onkeyup="editTmmt('TMMT_SCTMMTCZXMK');" >
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>非首层门套材质（小门框）</td>
                                                            <td colspan="2">
                                                                <select name='TMMT_FSCTMMTCZXMK' id="TMMT_FSCTMMTCZXMK" onchange="editTmmt('TMMT_FSCTMMTCZXMK');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_FSCTMMTCZXMK=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_FSCTMMTCZXMK=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <%-- <option value="镜面不锈钢" ${pd.TMMT_FSCTMMTCZXMK=='镜面不锈钢'?'selected':''}>镜面不锈钢</option> --%>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMMT_FSCTMMTCZXMK_TEMP" id="TMMT_FSCTMMTCZXMK_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>非首层门套（小门框）钢板色标号</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_FSCTMMTCZXMKSBH" name="TMMT_FSCTMMTCZXMKSBH" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.TMMT_FSCTMMTCZXMKSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.TMMT_FSCTMMTCZXMKSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.TMMT_FSCTMMTCZXMKSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.TMMT_FSCTMMTCZXMKSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.TMMT_FSCTMMTCZXMKSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.TMMT_FSCTMMTCZXMKSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.TMMT_FSCTMMTCZXMKSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>套数</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_XMKCZS" id="TMMT_XMKCZS" value="${pd.TMMT_XMKCZS}" class="form-control" onkeyup="editTmmt('TMMT_FSCTMMTCZXMK');" >
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>楼名</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_XMKLM" id="TMMT_XMKLM" value="${pd.TMMT_XMKLM}" class="form-control">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>首层门套材质（大门框）</td>
                                                            <td colspan="2">
                                                                <select name='TMMT_SCTMMTCZDMK' id="TMMT_SCTMMTCZDMK" onchange="editTmmt('TMMT_SCTMMTCZDMK');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_SCTMMTCZDMK=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_SCTMMTCZDMK=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <%-- <option value="镜面不锈钢" ${pd.TMMT_SCTMMTCZDMK=='镜面不锈钢'?'selected':''}>镜面不锈钢</option> --%>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMMT_SCTMMTCZDMK_TEMP" id="TMMT_SCTMMTCZDMK_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>首层门套（大门框）钢板色标号</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_SCTMMTCZDMKSBH" name="TMMT_SCTMMTCZDMKSBH" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.TMMT_SCTMMTCZDMKSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.TMMT_SCTMMTCZDMKSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.TMMT_SCTMMTCZDMKSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.TMMT_SCTMMTCZDMKSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.TMMT_SCTMMTCZDMKSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.TMMT_SCTMMTCZDMKSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.TMMT_SCTMMTCZDMKSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>套数</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_SCTMMTCZDMKTS" id="TMMT_SCTMMTCZDMKTS" value="${pd.TMMT_SCTMMTCZDMKTS}" class="form-control" onkeyup="editTmmt('TMMT_SCTMMTCZDMK');editTmmt('TMMT_FSCTMMTCZDMK');" >
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>非首层门套材质（大门框）</td>
                                                            <td colspan="2">
                                                                <select name='TMMT_FSCTMMTCZDMK' id="TMMT_FSCTMMTCZDMK" onchange="editTmmt('TMMT_FSCTMMTCZDMK');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_FSCTMMTCZDMK=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_FSCTMMTCZDMK=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <%-- <option value="镜面不锈钢" ${pd.TMMT_FSCTMMTCZDMK=='镜面不锈钢'?'selected':''}>镜面不锈钢</option> --%>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMMT_FSCTMMTCZDMK_TEMP" id="TMMT_FSCTMMTCZDMK_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>非首层门套（大门框）钢板色标号</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_FSCTMMTCZDMKSBH" name="TMMT_FSCTMMTCZDMKSBH" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.TMMT_FSCTMMTCZDMKSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.TMMT_FSCTMMTCZDMKSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.TMMT_FSCTMMTCZDMKSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.TMMT_FSCTMMTCZDMKSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.TMMT_FSCTMMTCZDMKSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.TMMT_FSCTMMTCZDMKSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.TMMT_FSCTMMTCZDMKSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>套数</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_DMKCZS" id="TMMT_DMKCZS" value="${pd.TMMT_DMKCZS}" class="form-control" onkeyup="editTmmt('TMMT_FSCTMMTCZDMK');">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>楼名</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_DMKLM" id="TMMT_DMKLM" value="${pd.TMMT_DMKLM}" class="form-control">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>首层厅门材质</td>
                                                            <td colspan="2">
                                                                <select name='TMMT_TMCZ' id="TMMT_TMCZ" onchange="editTmmt('TMMT_TMCZ');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_TMCZ=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_TMCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <%-- <option value="镜面不锈钢" ${pd.TMMT_TMCZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option> --%>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMMT_TMCZ_TEMP" id="TMMT_TMCZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>首层厅门材质钢板色标号</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_TMCZSBH" name="TMMT_TMCZSBH" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.TMMT_TMCZSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.TMMT_TMCZSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.TMMT_TMCZSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.TMMT_TMCZSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.TMMT_TMCZSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.TMMT_TMCZSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.TMMT_TMCZSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>套数</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_TMCZTS" id="TMMT_TMCZTS" value="${pd.TMMT_TMCZTS}" class="form-control" onkeyup="editTmmt('TMMT_TMCZ');">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>非首层厅门材质</td>
                                                            <td colspan="2">
                                                                <select name='TMMT_FSCTMCZ' id="TMMT_FSCTMCZ" onchange="editTmmt('TMMT_FSCTMCZ');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板喷涂" ${pd.TMMT_FSCTMCZ=='钢板喷涂'?'selected':''}>钢板喷涂</option>
                                                                    <option value="发纹不锈钢" ${pd.TMMT_FSCTMCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <%-- <option value="镜面不锈钢" ${pd.TMMT_FSCTMCZ=='镜面不锈钢'?'selected':''}>镜面不锈钢</option> --%>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMMT_FSCTMCZ_TEMP" id="TMMT_FSCTMCZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>非首层厅门材质钢板色标号</td>
                                                            <td colspan="2">
                                                                <select id="TMMT_FSCTMCZSBH" name="TMMT_FSCTMCZSBH" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="P-01" ${pd.TMMT_FSCTMCZSBH=='P-01'?'selected':''}>P-01</option>
                                                                    <option value="P-02" ${pd.TMMT_FSCTMCZSBH=='P-02'?'selected':''}>P-02</option>
                                                                    <option value="P-03" ${pd.TMMT_FSCTMCZSBH=='P-03'?'selected':''}>P-03</option>
                                                                    <option value="P-04" ${pd.TMMT_FSCTMCZSBH=='P-04'?'selected':''}>P-04</option>
                                                                    <option value="P-05" ${pd.TMMT_FSCTMCZSBH=='P-05'?'selected':''}>P-05</option>
                                                                    <option value="P-06" ${pd.TMMT_FSCTMCZSBH=='P-06'?'selected':''}>P-06</option>
                                                                    <option value="P-07" ${pd.TMMT_FSCTMCZSBH=='P-07'?'selected':''}>P-07</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>套数</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_CZS" id="TMMT_CZS" value="${pd.TMMT_CZS}" class="form-control" onkeyup="editTmmt('TMMT_FSCTMCZ');">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>楼名</td>
                                                            <td colspan="2">
                                                                <input type="text" name="TMMT_LM" id="TMMT_LM" value="${pd.TMMT_LM}" class="form-control">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                        	<td colspan="4" class="intro" style="color: red;display: none;" id="TMMT_Label"><label style="font-size: 16px;">由于开门宽度非标,厅门门套模块请非标询价</label></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 厅门门套 -->
                                                </div>
                                                <div id="tab-7" class="tab-pane">
                                                    <!-- 操纵盘 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>操纵盘类型</td>
                                                            <td>--</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>操纵盘型号</td>
                                                            <td>
                                                                <select name="CZP_CZPXH" id="CZP_CZPXH" onchange="editCzp('CZP_CZPXH');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="JFCOP05P-E" ${pd.CZP_CZPXH=='JFCOP05P-E'?'selected':''}>JFCOP05P-E</option>
                                                                    <option value="JFCOP06H-E" ${pd.CZP_CZPXH=='JFCOP06H-E'?'selected':''}>JFCOP06H-E</option>
                                                                </select>
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
                                                            <td><input type="text" name="CZP_CZPWZ_TEMP" id="CZP_CZPWZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 操纵盘 -->
                                                </div>
                                                <div id="tab-8" class="tab-pane">
                                                    <!-- 厅门信号装置 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td>厅外召唤类型</td>
                                                            <td>--</td>
                                                            <td>加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td>厅外召唤型号</td>
                                                            <td>
                                                                <select name="TMXHZZ_TWZHXH" id="TMXHZZ_TWZHXH" onchange="editTmmt('TMXHZZ_TWZHXH');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="JFHB05P-E" ${pd.TMXHZZ_TWZHXH=='JFHB05P-E'?'selected':''}>JFHB05P-E</option>
                                                                    <option value="JFHB06H-E" ${pd.TMXHZZ_TWZHXH=='JFHB06H-E'?'selected':''}>JFHB06H-E</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="TMXHZZ_TWZHXH_TEMP" id="TMXHZZ_TWZHXH_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>数量</td>
                                                            <td>
                                                                <input type="text" name="TMXHZZ_SL" id="TMXHZZ_SL" onkeyup="editTmxhzz('TMXHZZ_SL');" value="${pd.TMXHZZ_SL}" class="form-control">
                                                            </td>
                                                            <td><input type="text" name="TMXHZZ_SL_TEMP" id="TMXHZZ_SL_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>在第几层</td>
                                                            <td>
                                                                <input type="text" name="TMXHZZ_ZDJC" id="TMXHZZ_ZDJC" onkeyup="editTmmt('TMXHZZ_ZDJC');" value="${pd.TMXHZZ_ZDJC}" class="form-control">
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>附加说明</td>
                                                            <td>
                                                                <input type="text" name="TMXHZZ_FJSM" id="TMXHZZ_FJSM" onkeyup="editTmmt('TMXHZZ_FJSM');" value="${pd.TMXHZZ_FJSM}" class="form-control">
                                                            </td>
                                                            <td></td>
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
                                                <td>备注</td>
                                                <td colspan="3"><input type="text" name="ELE_REMARK" id="ELE_REMARK" value="${pd.ELE_REMARK }"
                                                                       class="form-control"></td>
                                                <td colspan="2">
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
	                                            <input type="text" name="SHINY_AZF_TEMP" id="SHINY_AZF_TEMP" class="form-control" readonly="readonly" value="${pd.FEIYUE_AZF }">
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
                                        <input type="text" id="trans_price" name="trans_price" class="form-control" oninput="countTransPrice()" value="${pd.XS_YSJ}">
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
        
        basisDate.isLoadEnd = 2;
        
        //加载标准价格,初始化关联选项
        editZz();
        
        editSd();
		
        $('#OPT_FYHTYJFXGB_TEXT').prop("checked","checked");
        $("#BZ_C").val("${regelevStandardPd.C}");
        $("#BZ_Z").val("${regelevStandardPd.Z}");
        $("#BZ_M").val("${regelevStandardPd.M}");
        
        if("${pd.view}"=="edit")
		{
			$("#BZ_C").val("${pd.BZ_C}");
	        $("#BZ_Z").val("${pd.BZ_Z}");
	        $("#BZ_M").val("${pd.BZ_M}");
		} else {
	        editOpt('OPT_FYHTYJFXGB');
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
        initBindSelect("${pd.BASE_JXGG}","1");
        
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
        
        setSbj();
        countInstallPrice();
        //加载运输模块显示 
        if("${pd.trans_type}"!=null && "${pd.trans_type}"!=""){
        	$("#trans_type").val("${pd.trans_type}");
            hideDiv();
        }else{
        	$("#trans_type").val(1);
        }

        updateFbX();
        
        basisDate.isLoadEnd = 1;
        JS_SJBJ();
    });

    
    //关闭当前页面
    function CloseSUWin(id) {
      window.parent.$("#" + id).data("kendoWindow").close();
    }

    //修改层时修改站和门
    function editC(){
        var c_ = $("#BZ_C").val();
        $("#BZ_Z").val(c_);
        $("#BZ_M").val(c_);
        setJdzg();
        setSbj();
        
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

    //调用价格时从新计算
    function cbjPrice(){
        //井道总高
        setJdzg();
        //导轨支架
        setDgzj();
        //
        editGbcs("KZFS_JM"); 
        editGbcs("JXCRKSL_JM");        
        editGbcs("GTMS_JM");
        editGbcs('OPT_GTJX')
        
        //可选项
        editOpt('OPT_JFGT');
        editOpt('OPT_COP');
        editOpt('OPT_WZYCOPMWAN');
        editOpt('OPT_GBSCJRCZXCOP');
        editOpt('OPT_LOP');
        editOpt('OPT_FDLCZ');
        editOpt('OPT_TDJJJY');
        editOpt('OPT_YSJCZ');
        editOpt('OPT_CCTVDL');
        editOpt('OPT_JJBYDYCZZZ');
        editOpt('OPT_JXDZZ');
        editOpt('OPT_ZPC');
        editOpt('OPT_YCJSJKZB');
        editOpt('OPT_YYBZ');
        editOpt('OPT_HJZDFHJZ');
        editOpt('OPT_BAJK');
        editOpt('OPT_DJGRBH');
        editOpt('OPT_XFLD');
        editOpt('OPT_TWXFYFW');
        editOpt('OPT_FYHTYJFXGB');
        //轿厢装潢
        editJxzh('JXZH_JM');
        editJxzh('JXZH_QWB');
        editJxzh('JXZH_CWB');
        editJxzh('JXZH_HWB');
        editJxzh('JXZH_JDZH');
        editJxzh('JXZH_DBXH');
        editJxzh('JXZH_FZTXH');
        editJxzh('JXZH_BGJ');
        editJxzh('JXZH_JDAQC');
        //厅门门套
        editTmmt('TMMT_SCTMMTCZXMK');
        editTmmt('TMMT_FSCTMMTCZXMK');
        editTmmt('TMMT_SCTMMTCZDMK');
        editTmmt('TMMT_FSCTMMTCZDMK');
        editTmmt('TMMT_TMCZ');
        editTmmt('TMMT_FSCTMCZ');
        editTmmt('TMXHZZ_TWZHXH');
        //操纵盘
        editCzp('CZP_CZPXH');
        
        
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
        var sl_ = $("#SHINY_SL").val();
        var item_id = $("#ITEM_ID").val();
        var offer_version = $("#offer_version").val();
        $("#cbjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selCbj.do?models=shiny&SHINY_SL="+sl_+
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
        var sl_ = $("#SHINY_SL").val();
        var zk_ = $("#SHINY_ZK").val();
        var sbj_ = $("#SHINY_SBJ").val();
        $("#zhjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selZhj.do?models=shiny&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&SHINY_SL="+sl_+"&SHINY_ZK="+zk_+"&SHINY_SBJ="+sbj_,
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
    

    //计算基础价
    function setSbj(){
    	var sl_ = $("#SHINY_SL").val()==""?0:parseInt($("#SHINY_SL").val());
        var sd_ = $("#BZ_SD").val();  //速度
        if(sd_=="1.0"){var sd=1;}
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
                        }
                	} else {
        				$("#SBJ_TEMP").val(basisDate.fbdj*sl_);
        	            $("#DANJIA").val(basisDate.fbdj);
                        setMPrice();
                        countZhj();
                	}
                });
        
        
        var m_ = parseInt($("#BZ_M").val());
        var c_ = parseInt($("#BZ_C").val());
        var z_ = parseInt($("#BZ_Z").val());
    	 if(!isNaN(m_)&&!isNaN(z_)){
         	if(m_-z_>0){
         		 $("#BASE_GTMS").val(m_-z_);//贯通门数
         	}else{
         		$("#BASE_GTMS").val(0);//贯通门数
         	}
         }
         editGbcs('GTMS_JM');
        
    }


    //修改门数量时修改标准价格
    function setMPrice(){
        var sl_ = parseInt_DN($("#SHINY_SL").val());
        var m_ = parseInt($("#BZ_M").val());
        var c_ = parseInt($("#BZ_C").val());
        var z_ = parseInt($("#BZ_Z").val());
        var dj = parseInt($("#DANJIA").val());
        var price = 0;
        var kmkd_ = parseInt($("#BZ_KMKD").val());
        
        if(!isNaN(m_)&&!isNaN(c_)&&!isNaN(z_)){
        	
        	if (kmkd_=="1400"||kmkd_=="1500"||kmkd_=="1700"||kmkd_=="2000"||kmkd_=="2200") {
        		
        		var _jj = 0;
            	if(kmkd_=="1400"||kmkd_=="1500"){
            		_jj = -4300;
                }else if(kmkd_=="1700"){
                	_jj = -5100;
                }else if(kmkd_=="2000"){
                	_jj = -5800;
                }else if(kmkd_=="2200"){
                	_jj = -6600;
                }
            	
    			price = subDoor(dj, c_ , z_, m_, _jj);
             	$("#DANJIA").val(price);
            	$("#SBJ_TEMP").val(price * sl_);
            	$("#SHINY_SBJBF").val(0);
            	
             	$("#TMMT_Label").hide();
             	$("#DANJIA_Label").hide();
             	
        	}else{
        		//开门宽度非标
				$("#DANJIA_Label").show();
				$("#TMMT_Label").show();
        	}
        	
        	
            /* var jm = c_-m_;
            if(jm>0){
                if(kmkd_=="1400"||kmkd_=="1500"){
                    price = dj-4300*jm;
                }else if(kmkd_=="1700"){
                    price = dj-5100*jm;
                }else if(kmkd_=="2000"){
                    price = dj-5800*jm;
                }else if(kmkd_=="2200"){
                    price = dj-6600*jm;
                }
            }else{
            	price=dj;
            }
            $("#SHINY_SBJBF").val(price-dj); */
            countZhj();
        }
        
        if(!isNaN(m_)&&!isNaN(z_)){
        	if(m_-z_>0){
        		 $("#BASE_GTMS").val(m_-z_);//贯通门数
        	}else{
        		$("#BASE_GTMS").val(0);//贯通门数
        	}
        }
        
        if(!isNaN(m_)){
        	 $("#TMMT_XMKCZS").val(m_-1);//层站数（非首层）
        	 $("#TMMT_DMKCZS").val(m_-1);//层站数（非首层）
        	 $("#TMMT_CZS").val(m_-1);//层站数（非首层）
        	 
        	 $("#TMMT_SCTMMTCZXMKTS").val(m_-1);
        	 $("#TMMT_SCTMMTCZDMKTS").val(m_-1);
        	 $("#TMMT_TMCZTS").val(m_-1);
        }
       

        
        editGbcs('GTMS_JM');
        
        editJxzh('JXZH_JM');
        
        
    }

    //修改载重时
    function editZz(){
    	
        var zz_ = $("#BZ_ZZ").val();
        var kmkd_ = $("#BZ_KMKD").val();
        var HT_QGLJJ= "${pd.BASE_QGLJJ}";
		//alert(HT_QGLJJ);

        if(zz_=="1000"){
            //修改轿厢规格
            /* $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1400×1600(1000kg)'>1400×1600(1000kg)</option>"); */
            
            $("#IS_FEIBIAO").val("false");
        	$("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#BASE_GTMS_TEMP").show();
        	$("#JXZH_FZTXH_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$(".intro").hide();
            //修改圈/钢梁间距
            if(HT_QGLJJ==""){
             $("#BASE_QGLJJ").val("2000");
            }
            //修改轿厢总高
            /*  $(":radio[name='BASE_JXGD'][value='2200']").prop("checked", "checked"); */
        }else if(zz_=="2000"){
            //修改轿厢规格
            /* $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='1700×2400(2000kg)'>1700×2400(2000kg)</option>"); */

            $("#IS_FEIBIAO").val("false");
        	$("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#BASE_GTMS_TEMP").show();
        	$("#JXZH_FZTXH_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$(".intro").hide();
            //修改圈/钢梁间距
            if(HT_QGLJJ==""){
                $("#BASE_QGLJJ").val("2000");
               }
            //修改轿厢总高
             /* $(":radio[name='BASE_JXGD'][value='2200']").prop("checked", "checked"); */
        }else if(zz_=="3000"){
            //修改轿厢规格
            /* $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='2000×2800(3000kg)'>2000×2800(3000kg)</option>"); */
            
            $("#IS_FEIBIAO").val("false");
        	$("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#BASE_GTMS_TEMP").show();
        	$("#JXZH_FZTXH_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$(".intro").hide();
            //修改圈/钢梁间距
            if(HT_QGLJJ==""){
                $("#BASE_QGLJJ").val("2000");
               }
            //修改轿厢总高
            /*  $(":radio[name='BASE_JXGD'][value='2200']").prop("checked", "checked"); */
        }else if(zz_=="4000"){
            //修改轿厢规格
            /* $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='2000×3600(4000kg)'>2000×3600(4000kg)</option>"); */
            
            $("#IS_FEIBIAO").val("false");
        	$("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#BASE_GTMS_TEMP").show();
        	$("#JXZH_FZTXH_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$(".intro").hide();
            //修改圈/钢梁间距
            if(HT_QGLJJ==""){
                $("#BASE_QGLJJ").val("1500");
               }
            //修改轿厢总高
            /*  $(":radio[name='BASE_JXGD'][value='2200']").prop("checked", "checked"); */
        }else if(zz_=="5000"){
            //修改轿厢规格         
            /* $("#BASE_JXGG").empty();
            $("#BASE_JXGG").append("<option value='2600×3400(5000kg)'>2600×3400(5000kg)</option>"); */
            $("#IS_FEIBIAO").val("false");
        	$("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#BASE_GTMS_TEMP").show();
        	$("#JXZH_FZTXH_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$(".intro").hide();
           
            //修改圈/钢梁间距
            if(HT_QGLJJ==""){
                $("#BASE_QGLJJ").val("1500");
               }
            //修改轿厢总高
             /* $(":radio[name='BASE_JXGD'][value='2400']").prop("checked", "checked"); */
        }else if(zz_==""){
        	$("#IS_FEIBIAO").val("true");
        	$("#JXZH_QWB_TEMP").hide();
        	$("#BASE_DGZJ_TEMP").hide();
        	$("#BASE_GTMS_TEMP").hide();
        	$("#JXZH_FZTXH_TEMP").hide();
        	$("#JXZH_BGJ_TEMP").hide();
        	$(".intro").show();
        }else{
        	$("#IS_FEIBIAO").val("true");
        	$("#JXZH_QWB_TEMP").hide();
        	$("#BASE_DGZJ_TEMP").hide();
        	$("#BASE_GTMS_TEMP").hide();
        	$("#JXZH_FZTXH_TEMP").hide();
        	$("#JXZH_BGJ_TEMP").hide();
        	$(".intro").show();
        }
        
        editJxzh('JXZH_FZTXH');
    	editJxzh('JXZH_JDZH');
        editJxzh('JXZH_QWB');
        editGbcs('JXCRKSL_JM');
        editGbcs('GTMS_JM'); 
        editJxzh('JXZH_DBXH');
        //reloadDBXH();
        setJdzg();
        setSbj();

        autoSelectQXGD();
    }

    function autoSelectQXGD() {
		if("${pd.view}" == 'save'){
			var zz_ = parseInt_DN($("#BZ_ZZ").val());
			if(zz_ >= 1000 && zz_ <= 4000){
				$(":radio[name='BASE_JXGD'][value='2200']").prop("checked", "checked");
			} else  if(zz_ == 5000){
				$(":radio[name='BASE_JXGD'][value='2400']").prop("checked", "checked");
			} else  {
				$(":radio[name='BASE_JXGD']").removeAttr('checked');
			}
		}
	}
    
    function reloadDBXH() {
		var zz_ = parseInt_DN($("#BZ_ZZ").val());
        var dbxh_ = $("#JXZH_DBXH").val();
        if(zz_ == 1000){
			var dbxh = "<option value=''>请选择</option><option value='PVC 型号JD-08'>PVC 型号JD-08</option><option value='不锈钢花纹钢板'>不锈钢花纹钢板</option>";
            $("#JXZH_DBXH").empty();
            $("#JXZH_DBXH").append(dbxh); 
            $("#JXZH_DBXH").val(dbxh_);
		} else {
			var dbxh = "<option value=''>请选择</option><option value='普通花纹钢板'>普通花纹钢板</option><option value='不锈钢花纹钢板'>不锈钢花纹钢板</option>";
            $("#JXZH_DBXH").empty();
            $("#JXZH_DBXH").append(dbxh); 
            $("#JXZH_DBXH").val(dbxh_);
		}
	}
    
    //修改速度时
    function editSd(){
        var sd_ = $("#BZ_SD").val();
        var BZ_ZZ=$("#BZ_ZZ").val(); //初始载重
        var JXZH_JDZH_TEMP=$("#JXZH_JDZH_TEMP").val(); 
        var JXZH_JDZH=$("#JXZH_JDZH").val(); 
        var BASE_JXCRKSL_TEMP=$("#BASE_JXCRKSL_TEMP").val(); 
        var BASE_JXCRKSL=$("#BASE_JXCRKSL").val(); 
        var BASE_GTMS_TEMP=$("#BASE_GTMS_TEMP").val(); 
        var BASE_GTMS=$("#BASE_GTMS").val(); 
        
      //2018年8月8日 载重删除1000KG
        if(sd_=="0.25"){
            var appendStr = "<option value=''>请选择</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
            
            
            var zz = "<option value=''>请选择</option><option value='4000'>4000</option><option value='5000'>5000</option>";
            $("#BZ_ZZ").empty();
            $("#BZ_ZZ").append(zz); 
            $("#BZ_ZZ").val(BZ_ZZ);
            
    		
        }else if(sd_=="0.5"){
            var appendStr = "<option value=''>请选择</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
            
            
            var zz = "<option value=''>请选择</option><option value='2000'>2000</option><option value='3000'>3000</option><option value='4000'>4000</option><option value='5000'>5000</option>";
            $("#BZ_ZZ").empty();
            $("#BZ_ZZ").append(zz); 
            $("#BZ_ZZ").val(BZ_ZZ);
            
    		
        }else if(sd_=="1.0"){
            var appendStr = "<option value=''>请选择</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
            
            var zz = "<option value=''>请选择</option><option value='2000'>2000</option><option value='3000'>3000</option>";
            $("#BZ_ZZ").empty();
            $("#BZ_ZZ").append(zz); 
            $("#BZ_ZZ").val(BZ_ZZ);
    		
        }
        //清除载重关联轿顶装潢的选项和价格
        var BZ_ZZH=$("#BZ_ZZ").val(); 
        if(BZ_ZZH!=null){
        $("#JXZH_JDZH_TEMP").val(JXZH_JDZH_TEMP);
        $("#JXZH_JDZH").val(JXZH_JDZH);
        
        $("#BASE_JXCRKSL_TEMP").val(BASE_JXCRKSL_TEMP);
        $("#BASE_JXCRKSL").val(BASE_JXCRKSL);
        
        $("#BASE_GTMS_TEMP").val(BASE_GTMS_TEMP);
        $("#BASE_GTMS").val(BASE_GTMS);  
        }else{
       	$("#JXZH_JDZH_TEMP").val("");
        $("#JXZH_JDZH").val("");
        
        $("#BASE_JXCRKSL_TEMP").val("");
        $("#BASE_JXCRKSL").val("1");
        
        $("#BASE_GTMS_TEMP").val("");
        $("#BASE_GTMS").val("");  
        }
        
        //清除导轨支架
        var BZ_C1=$("#BZ_C").val(); 
        if(BZ_C1==''){
        	 $("#BASE_DGZJ_TEMP").val("");
             $("#BASE_DGZJ").val(""); 
        }
        
    }

    //修改(层站)门
    function editM(){
        var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
        var c_ = parseInt($("#BZ_C").val());    //层
        var m_ = parseInt($("#BZ_M").val());    //门
        var price = 0;
        if(kmkd_=="800"){
            price = (c_-m_)*1680;
        }else if(kmkd_=="1500"){
            price = (c_-m_)*1920;
        }else if(kmkd_=="2000"){
            price = (c_-m_)*2200;
        }
    }

    function countZhj(){
    	if(basisDate.isLoadEnd != 1)return;
    	
        var zhj_count = 0;
        var sbj_count = 0;
        var BASE_KZFS_TEMP = $("#BASE_KZFS_TEMP").val()==""?0:parseInt($("#BASE_KZFS_TEMP").val());
        var base_jdzg_temp = $("#BASE_JDZG_TEMP").val()==""?0:parseInt($("#BASE_JDZG_TEMP").val());
        var base_dgzj_temp = $("#BASE_DGZJ_TEMP").val()==""?0:parseInt($("#BASE_DGZJ_TEMP").val());
        var BASE_JXCRKSL_TEMP = $("#BASE_JXCRKSL_TEMP").val()==""?0:parseInt($("#BASE_JXCRKSL_TEMP").val());
        var BASE_GTMS_TEMP = $("#BASE_GTMS_TEMP").val()==""?0:parseInt($("#BASE_GTMS_TEMP").val());
        
        var opt_jfgt_temp = $("#OPT_JFGT_TEMP").val()==""?0:parseInt($("#OPT_JFGT_TEMP").val());
        var opt_wztcopmwan_temp = $("#OPT_WZYCOPMWAN_TEMP").val()==""?0:parseInt($("#OPT_WZYCOPMWAN_TEMP").val());
        var opt_gbscjrczxcop_temp = $("#OPT_GBSCJRCZXCOP_TEMP").val()==""?0:parseInt($("#OPT_GBSCJRCZXCOP_TEMP").val());
       
        var opt_fdlcz_temp = $("#OPT_FDLCZ_TEMP").val()==""?0:parseInt($("#OPT_FDLCZ_TEMP").val());
        /* var opt_tdjjjy_temp = $("#OPT_TDJJJY_TEMP").val()==""?0:parseInt($("#OPT_TDJJJY_TEMP").val()); */
        var opt_ysjcz_temp = $("#OPT_YSJCZ_TEMP").val()==""?0:parseInt($("#OPT_YSJCZ_TEMP").val());
        var opt_cctvdl_temp = $("#OPT_CCTVDL_TEMP").val()==""?0:parseInt($("#OPT_CCTVDL_TEMP").val());
        var opt_jjbydyczzz_temp = $("#OPT_JJBYDYCZZZ_TEMP").val()==""?0:parseInt($("#OPT_JJBYDYCZZZ_TEMP").val());
        var opt_jxdzz_temp = $("#OPT_JXDZZ_TEMP").val()==""?0:parseInt($("#OPT_JXDZZ_TEMP").val());
        var opt_zpc_temp = $("#OPT_ZPC_TEMP").val()==""?0:parseInt($("#OPT_ZPC_TEMP").val());
        var opt_ycjsjkzb_temp = $("#OPT_YCJSJKZB_TEMP").val()==""?0:parseInt($("#OPT_YCJSJKZB_TEMP").val());
        var opt_yybz_temp = $("#OPT_YYBZ_TEMP").val()==""?0:parseInt($("#OPT_YYBZ_TEMP").val());
        var opt_hjzdfhjz_temp = $("#OPT_HJZDFHJZ_TEMP").val()==""?0:parseInt($("#OPT_HJZDFHJZ_TEMP").val());
        var opt_bajk_temp = $("#OPT_BAJK_TEMP").val()==""?0:parseInt($("#OPT_BAJK_TEMP").val());
        var opt_djgrbh_temp = $("#OPT_DJGRBH_TEMP").val()==""?0:parseInt($("#OPT_DJGRBH_TEMP").val());
        var opt_xfld_temp = $("#OPT_XFLD_TEMP").val()==""?0:parseInt($("#OPT_XFLD_TEMP").val());
        var opt_twfyfw_temp = $("#OPT_TWXFYFW_TEMP").val()==""?0:parseInt($("#OPT_TWXFYFW_TEMP").val());
        var jxzh_jm_temp = $("#JXZH_JM_TEMP").val()==""?0:parseInt($("#JXZH_JM_TEMP").val());
        var jxzh_qwb_temp = $("#JXZH_QWB_TEMP").val()==""?0:parseInt($("#JXZH_QWB_TEMP").val());
        var jxzh_jdzh_temp = $("#JXZH_JDZH_TEMP").val()==""?0:parseInt($("#JXZH_JDZH_TEMP").val());
        var JXZH_JDAQC_TEMP = $("#JXZH_JDAQC_TEMP").val()==""?0:parseInt($("#JXZH_JDAQC_TEMP").val());
        
        var jxzh_dbxh_temp = $("#JXZH_DBXH_TEMP").val()==""?0:parseInt($("#JXZH_DBXH_TEMP").val());
        var jxzh_fztxh_temp = $("#JXZH_FZTXH_TEMP").val()==""?0:parseInt($("#JXZH_FZTXH_TEMP").val());
        var jxzh_bgj_temp = $("#JXZH_BGJ_TEMP").val()==""?0:parseInt($("#JXZH_BGJ_TEMP").val());
        var tmmt_sctmmtczxmk_temp = $("#TMMT_SCTMMTCZXMK_TEMP").val()==""?0:parseInt($("#TMMT_SCTMMTCZXMK_TEMP").val());
        var tmmt_fsctmmtczxmk_temp = $("#TMMT_FSCTMMTCZXMK_TEMP").val()==""?0:parseInt($("#TMMT_FSCTMMTCZXMK_TEMP").val());
        var tmmt_sctmmtczdmk_temp = $("#TMMT_SCTMMTCZDMK_TEMP").val()==""?0:parseInt($("#TMMT_SCTMMTCZDMK_TEMP").val());
        var tmmt_fsctmmtczdmk_temp = $("#TMMT_FSCTMMTCZDMK_TEMP").val()==""?0:parseInt($("#TMMT_FSCTMMTCZDMK_TEMP").val());
        var tmmt_tmcz_temp = $("#TMMT_TMCZ_TEMP").val()==""?0:parseInt($("#TMMT_TMCZ_TEMP").val());
        var tmmt_fsctmcz_temp = $("#TMMT_FSCTMCZ_TEMP").val()==""?0:parseInt($("#TMMT_FSCTMCZ_TEMP").val());
        var czp_czpxh_temp = $("#CZP_CZPXH_TEMP").val()==""?0:parseInt($("#CZP_CZPXH_TEMP").val());
        var tmxhzz_twzhxh_temp = $("#TMXHZZ_TWZHXH_TEMP").val()==""?0:parseInt($("#TMXHZZ_TWZHXH_TEMP").val());
        var base_ccjg = $("#BASE_CCJG").val()==""?0:parseInt($("#BASE_CCJG").val());
        var SHINY_SBJBF = $("#SHINY_SBJBF").val()==""?0:parseInt($("#SHINY_SBJBF").val());
        //var opt_fyhtyjfxgb_temp = $("#OPT_FYHTYJFXGB_TEMP").val()==""?0:parseInt($("#OPT_FYHTYJFXGB_TEMP").val());//飞弈货梯有机房新国标
        var opt_gtjx_temp = $("#OPT_GTJX_TEMP").val()==""?0:parseInt($("#OPT_GTJX_TEMP").val());

      	//非标选项加价
        var opt_fb_temp = $("#OPT_FB_TEMP").val()==""?0:parseInt($("#OPT_FB_TEMP").val());
        
        zhj_count = base_ccjg+jxzh_jm_temp+jxzh_qwb_temp+jxzh_jdzh_temp+jxzh_dbxh_temp+jxzh_fztxh_temp+jxzh_bgj_temp+JXZH_JDAQC_TEMP;
        /* $("#SHINY_ZHJ").val(zhj_count); */
        //sbj_count = base_jdzg_temp+base_dgzj_temp+opt_wztcopmwan_temp+opt_gbscjrczxcop_temp+opt_fdlcz_temp+opt_ysjcz_temp+opt_cctvdl_temp+opt_jjbydyczzz_temp+opt_jxdzz_temp+opt_zpc_temp+opt_ycjsjkzb_temp+opt_yybz_temp+opt_hjzdfhjz_temp+opt_bajk_temp+opt_djgrbh_temp+opt_xfld_temp+opt_twfyfw_temp+tmmt_sctmmtczxmk_temp+tmmt_fsctmmtczxmk_temp+tmmt_sctmmtczdmk_temp+tmmt_fsctmmtczdmk_temp+tmmt_tmcz_temp+tmmt_fsctmcz_temp+czp_czpxh_temp+tmxhzz_twzhxh_temp;
        //去掉井道总高的加价
        sbj_count = base_dgzj_temp+opt_jfgt_temp+opt_wztcopmwan_temp+opt_gbscjrczxcop_temp+opt_fdlcz_temp+opt_ysjcz_temp+opt_cctvdl_temp+opt_jjbydyczzz_temp+opt_jxdzz_temp+opt_zpc_temp+opt_ycjsjkzb_temp+opt_yybz_temp+opt_hjzdfhjz_temp+opt_bajk_temp+opt_djgrbh_temp+opt_xfld_temp+opt_twfyfw_temp+tmmt_sctmmtczxmk_temp+tmmt_fsctmmtczxmk_temp+tmmt_sctmmtczdmk_temp+tmmt_fsctmmtczdmk_temp+tmmt_tmcz_temp+tmmt_fsctmcz_temp+czp_czpxh_temp+tmxhzz_twzhxh_temp+BASE_KZFS_TEMP+BASE_JXCRKSL_TEMP+BASE_GTMS_TEMP+opt_fb_temp+opt_gtjx_temp;
        //设备标准价格 (选项加价)
        var sbj_temp = parseInt($("#SBJ_TEMP").val());
        $("#XS_XXJJ").val(sbj_count+zhj_count+SHINY_SBJBF);
        //折前价 =基价+选项加价 
        $("#XS_ZQJ").val(sbj_count+zhj_count+sbj_temp);
       
        
      //非标加价
        setFBPrice();
        
        //运输费
        var shiny_ysf = $("#SHINY_YSF").val()==""?0:parseInt($("#SHINY_YSF").val());
        $("#SHINY_YSF").val(shiny_ysf);
        //安装费
        var shiny_azf = $("#SHINY_AZF_TEMP").val()==""?0:parseInt($("#SHINY_AZF_TEMP").val());
        $("#SHINY_AZF").val(shiny_azf);

        var shiny_zk = parseFloat($("#SHINY_ZK").val())/100;
        if(!isNaN(shiny_zk)){
            var shiny_sbj = parseInt($("#SBJ_TEMP").val());
            var shiny_sjbj = (shiny_sbj+zhj_count+sbj_count+shiny_azf+shiny_ysf)*shiny_zk;
            var shiny_zhsbj = shiny_sbj*shiny_zk;
            $("#SHINY_SJBJ").val(shiny_sjbj);
            $("#SHINY_ZHSBJ").val(shiny_zhsbj);
            $("#zk_").text($("#SHINY_ZK").val()+"%");
        }
        countInstallPrice();
        
        JS_SJBJ();
    }

    //计算井道总高-加价
    function setJdzg(){
    	var dtsl_ = parseInt($("#DT_SL").val());
        var tsgd_ = parseInt($("#BASE_TSGD").val());    //提升高度
        var dksd_ = parseInt($("#BASE_DKSD").val());     //底坑深度
        var dcgd_ = parseInt($("#BASE_DCGD").val());    //顶层高度
        if(!isNaN(tsgd_)&&!isNaN(dksd_)&&!isNaN(dcgd_))
        {
        	//加价
            var price = 0;
            var jdzg_ = tsgd_+dksd_+dcgd_;  //井道总高
            $("#BASE_JDZG").val(jdzg_);
            var zz_ = $("#BZ_ZZ").val();  //载重
            var sd_ = $("#BZ_SD").val();    //速度
            var jxgd_ = $("#BASE_JXGD").val();  //轿厢高度
            var c_ = parseInt($("#BZ_C").val())   //层数
            var K = 0;
            var S = 0;
            if(zz_=="1000"||zz_=="2000"||zz_=="3000"){
                K = 4300;
                S = 1400;
            }else if(zz_=="4000"||zz_=="5000"){
                K = 4500;
                S = 1500;
            }
            var jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
            if(sd_=="0.25"){
                if(zz_=="4000"){
                    price = 1510*((jdzg_-jdzg_std)/100);
                }else if(zz_=="5000"){
                    price = 1610*((jdzg_-jdzg_std)/100);
                }
            }else if(sd_=="0.5"){
                if(zz_=="1000"){
                    price = 720*((jdzg_-jdzg_std)/100);
                }else if(zz_=="2000"){
                    price = 770*((jdzg_-jdzg_std)/100);
                }else if(zz_=="3000"){
                    price = 890*((jdzg_-jdzg_std)/100);
                }else if(zz_=="4000"){
                    price = 1510*((jdzg_-jdzg_std)/100);
                }else if(zz_=="5000"){
                    price = 1610*((jdzg_-jdzg_std)/100);
                }
            }else if(sd_=="1.0"){
                if(zz_=="1000"){
                    price = 720*((jdzg_-jdzg_std)/100);
                }else if(zz_=="2000"){
                    price = 770*((jdzg_-jdzg_std)/100);
                }else if(zz_=="3000"){
                    price = 890*((jdzg_-jdzg_std)/100);
                }
            }
            
            //计算导轨支架实际档数
            var dgzj_std =0;
            var zz = parseInt($("#BZ_ZZ").val());  //载重
            var gqljj = parseInt($("#BASE_QGLJJ").val());  //钢圈梁间距
            
            //dgzj_std = Math.ceil((jdzg_std/gqljj)+1);
            dgzj_std = Math.ceil((jdzg_/gqljj)+1);
            //alert(jdzg_+'+'+gqljj+'='+dgzj_std); 
            $("#BASE_DGZJ").val(dgzj_std);
            
            //根据基本参数 获取提升高度 以及加价 
            var sd_ = $("#BZ_SD").val();  //速度
            if(sd_=="1.0"){var sd=1;}
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
                    },function(result)
                    {
                        if(result.msg=="success")
                        {
                        	if(isNaN(tsgd_) && isNaN(dksd_) && isNaN(dcgd_))
                        	{
                        		$("#BASE_CCGD").val("");
                            	$("#BASE_CCJG").val("");
                            	$("#BASE_JDZG_TEMP").val("");
                            	$("#BASE_JDZG").val("");
                        	}
                        	else
                        	{
                        		var BZJDG = 0;
                            	var JJ = 0;
                            	if(result.pd != null){
                            		BZJDG = result.pd.BZJDG;
                            		JJ = result.pd.JJ;
                            	}
                        		var jdzg=$("#BASE_JDZG").val();
                            	var ccgd=jdzg-parseInt(BZJDG*1000);//超出高度
                            	var ccjg=(ccgd/1000)*JJ*dtsl_; //超出高度加价
                            	$("#BASE_CCGD").val(ccgd);
                            	if(parseInt(ccjg)>0){
                               		$("#BASE_CCJG").val(parseInt(ccjg));
                               	}else{
                               		$("#BASE_CCJG").val(0);
                               	}
                            	
                            	$("#BASE_BZJDZG").val(BZJDG);
                            	
                            	$("#BASE_JDZG_TEMP").val(price);
                            	//放入价格
                                 countZhj();
                        	}
                        	
                        }
                        else
                        {
                        	$("#BASE_CCGD").val("");
                        	$("#BASE_CCJG").val("");
                        	$("#BASE_JDZG_TEMP").val("");
                        	$("#BASE_JDZG").val("");
                        }

                        //导轨支架加价
                        setDgzj();
                    });
            
        }else
        {
        	$("#BASE_CCGD").val("");
        	$("#BASE_CCJG").val("");
        	$("#BASE_JDZG_TEMP").val("");
        	$("#BASE_JDZG").val("");
        }
        
    }

    //计算导轨支架-加价
    function setDgzj(){
        var dgzj_ = parseInt($("#BASE_DGZJ").val());  //导轨支架
        var sl_ = $("#SHINY_SL").val()==""?0:parseInt($("#SHINY_SL").val()); //台数
        if(!isNaN(dgzj_)){
            var zz_ = $("#BZ_ZZ").val();  //载重
            var sd_ = $("#BZ_SD").val();    //速度
            var jxgd_ = $("#BASE_JXGD").val();  //轿厢高度
            var c_ = parseInt($("#BZ_C").val())   //层数
            var jdzg_std = 0;   //井道总高(标准)
            var dgzj_std = 0;   //导轨支架档数(标准)
            var K = 0;
            var S = 0;
            var price = 0;
            if(zz_=="1000"||zz_=="2000"||zz_=="3000"){
                K = 4300;
                S = 1400;
            }else if(zz_=="4000"||zz_=="5000"){
                K = 4500;
                S = 1500;
            }
            //jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
            //井道总高(标准) 改为从数据库中取
            //jdzg_std = $("#BASE_BZJDZG").val();
            jdzg_std = $("#BASE_JDZG").val();
            var zz = parseInt($("#BZ_ZZ").val());  //载重
            var gqljj = parseInt($("#BASE_QGLJJ").val());  //钢圈梁间距
            
            dgzj_std = Math.ceil((jdzg_std/gqljj)+1);
            
            price = (dgzj_-dgzj_std)*450*sl_;
            if(dgzj_>dgzj_std)
            {
              	$("#BASE_DGZJ").val(dgzj_);
              	if(price>0){
            		$("#BASE_DGZJ_TEMP").val(price);
            	}else{
            		$("#BASE_DGZJ_TEMP").val(0);
            	}
            }
            else
            {
            	$("#BASE_DGZJ").val(dgzj_std); 
            	$("#BASE_DGZJ_TEMP").val("0");
            }
            //放入价格
            countZhj();
        }
    }

  //基本参数部分-加价
    function editGbcs(option){
        //数量
        var sl_ = $("#SHINY_SL").val()==""?0:parseInt($("#SHINY_SL").val());
        //价格
        var price = 0;
        if(option=="KZFS_JM"){
            //控制方式
            var jm_ = $("input[name='BASE_KZFS']:checked").val();
            
            if(jm_=="单台运转(G1C)"){
                price = 0;
            }else if(jm_=="两台联动(G2C)"){
                price = 240*sl_;
            }
            $("#BASE_KZFS_TEMP").val(price);
        }else if(option=="JXCRKSL_JM"){
        	 var jxcrksl_ = $("#BASE_JXCRKSL").val();//轿厢出入口数
        	 var zz_ = $("#BZ_ZZ").val();//载重
             if(jxcrksl_=="1"){
                 price = 0;
             }else if(jxcrksl_=="2"){
                 /* if(zz_=="1000"){
                     price = 12000*sl_;
                 }else if(zz_=="2000"){
                     price = 12000*sl_;
                 }else if(zz_=="3000"){
                     price = 13100*sl_;
                 }else if(zz_=="4000"){
                     price = 15000*sl_;
                 }else if(zz_=="5000"){
                     price = 15000*sl_;
                 } */
             }
             isJXCRK();
             $("#BASE_JXCRKSL_TEMP").val(price);
        }else if(option=="GTMS_JM"){
       	 var GTMS_ = $("#BASE_GTMS").val();//贯通门数
       	 var zz_ = $("#BZ_ZZ").val();//载重
            
                if(zz_=="1000"){
                    price = 4300*GTMS_*sl_;
                }else if(zz_=="2000"){
                    price = 4300*GTMS_*sl_;
                }else if(zz_=="3000"){
                    price = 5100*GTMS_*sl_;
                }else if(zz_=="4000"){
                    price = 5800*GTMS_*sl_;
                }else if(zz_=="5000"){
                    price = 6600*GTMS_*sl_;
                }
            
            $("#BASE_GTMS_TEMP").val(price);
       }else if(option=="OPT_GTJX"){
           //贯通轿厢
			if($("#OPT_GTJX_TEXT").is(":checked")){
				var zz_ = $("#BZ_ZZ").val();  //载重
				var sd_=$("#BZ_SD").val();//速度
				if(zz_=="1000" || zz_=="2000"){
                   	price = 12000*sl_;
				}else if(zz_=="3000"){
					price = 13100*sl_;
				}else if(zz_=="4000" || zz_=="5000"){
					price = 15000*sl_;
				}
				$('#BASE_JXCRKSL').val("2");
           }else{
               	price = 0;
				$('#BASE_JXCRKSL').val("1");
           }
           $("#OPT_GTJX_TEMP").val(price);
       }
        //放入价格
        countZhj();
    }
    //可选功能部分加价
    function editOpt(option){
        //数量
        var sl_ = $("#SHINY_SL").val()==""?0:parseInt($("#SHINY_SL").val());
        //价格
        var price = 0;
        if(option=="OPT_JFGT"){
            //机房高台
            if($("#OPT_JFGT_TEXT").is(":checked")){
                price = 380*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JFGT_TEMP").val(price);
        }else if(option=="OPT_COP"){
            //COP
            var cop_ = $("#OPT_COP").val();
            if(cop_=="JFHB06H-E"){
            	price =150*sl_;
            }else{
                price = 0;
            }
            $("#OPT_COP_TEMP").val(price);
        }else if(option=="OPT_WZYCOPMWAN"){
            //外召与COP盲文按钮（只）
            var wzycopmwan_ = $("#OPT_WZYCOPMWAN").val();
            price = 15*wzycopmwan_*sl_;
            $("#OPT_WZYCOPMWAN_TEMP").val(price);
        }else if(option=="OPT_GBSCJRCZXCOP"){
            //挂壁式残疾人操纵箱COP
            if($("#OPT_GBSCJRCZXCOP_TEXT").is(":checked")){
                var c_ = parseInt($("#BZ_C").val());
                if(c_<=16){
                    price = 2800*sl_;
                }else if(c_<=30){
                    price = 3800*sl_;   
                }
            }else{
                price = 0;
            }
            $("#OPT_GBSCJRCZXCOP_TEMP").val(price);
        }else if(option=="OPT_LOP"){
            //LOP（个）JFHB06H-E
            var lop_ = parseInt($("#OPT_LOP").val());
            price = lop_*31;
            $("#OPT_LOP_TEMP").val(price);
        }else if(option=="OPT_FDLCZ"){
            //防捣乱操作
            if($("#OPT_FDLCZ_TEXT").is(":checked")){
                price = 120*sl_;
            }else{
                price = 0;
            }
            $("#OPT_FDLCZ_TEMP").val(price);
        }else if(option=="OPT_TDJJJY"){
            //停电应急救援
            var zz_ = $("#BZ_ZZ").val();//载重
            var sd_ = $("#BZ_SD").val();//速度
            if(zz_=='3000'&&sd_=='1.0' || zz_=='4000'&&sd_=='0.5' || zz_=='5000'&&sd_=='0.5')
            {
            	price=9000*sl_;
            }
            else
            {
            	price=7500*sl_;
            }
            $("#OPT_TDJJJY_TEMP").val(price);
        }else if(option=="OPT_YSJCZ"){
            //有司机操作 
            if($("#OPT_YSJCZ_TEXT").is(":checked")){
                price = 46*sl_;
            }else{
                price = 0;
            }
            $("#OPT_YSJCZ_TEMP").val(price);
        }else if(option=="OPT_CCTVDL"){
            //CCTV电缆（轿厢到机房）(m)
            var cctvdl_ = parseInt($("#OPT_CCTVDL").val());
            var tsgd_ = parseInt($("#BASE_TSGD").val());
            price=0;
            if(!tsgd_>0)
            {
            	$("#OPT_CCTVDL_TEXT").prop("checked",false);
            	alert("请填写基础参数的提升高度!");
            }
            else if($("#OPT_CCTVDL_TEXT").is(":checked"))
            {
            	price = 16*(tsgd_/1000+15)*sl_;
            }else{
            	price = 0;
            }
            $("#OPT_CCTVDL_TEMP").val(price);
        }else if(option=="OPT_JJBYDYCZZZ"){
            //紧急备用电源操作装置
            if($("#OPT_JJBYDYCZZZ_TEXT").is(":checked")){
                price = 3100*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JJBYDYCZZZ_TEMP").val(price);
        }else if(option=="OPT_JXDZZ"){
            //轿厢到站钟
            if($("#OPT_JXDZZ_TEXT").is(":checked")){
                price = 180*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JXDZZ_TEMP").val(price);
        }else if(option=="OPT_ZPC"){
            //再平层
            if($("#OPT_ZPC_TEXT").is(":checked")){
                price = 0;
                //1500
            }else{
                price = 0;
            }
            $("#OPT_ZPC_TEMP").val(price);
        }else if(option=="OPT_YCJSJKZB"){
            //远程监视接口准备
            if($("#OPT_YCJSJKZB_TEXT").is(":checked")){
                price = 3700*sl_;
            }else{
                price = 0;
            }
            $("#OPT_YCJSJKZB_TEMP").val(price);
        }else if(option=="OPT_YYBZ"){
            //语音报站
            if($("#OPT_YYBZ_TEXT").is(":checked")){
                price = 1200*sl_;
            }else{
                price = 0;
            }
            $("#OPT_YYBZ_TEMP").val(price);
        }else if(option=="OPT_HJZDFHJZ"){
            //火警自动返回基站
            if($("#OPT_HJZDFHJZ_TEXT").is(":checked")){
                price = 150*sl_;
            }else{
                price = 0;
            }
            $("#OPT_HJZDFHJZ_TEMP").val(price);
        }else if(option=="OPT_BAJK"){
            //BA接口
            if($("#OPT_BAJK_TEXT").is(":checked")){
                price = 620*sl_;
            }else{
                price = 0;
            }
            $("#OPT_BAJK_TEMP").val(price);
        }else if(option=="OPT_DJGRBH"){
            //电机过热保护
            if($("#OPT_DJGRBH_TEXT").is(":checked")){
                price = 620*sl_;
            }else{
                price = 0;
            }
            $("#OPT_DJGRBH_TEMP").val(price);
        }else if(option=="OPT_XFLD"){
            //消防联动
            if($("#OPT_XFLD_TEXT").is(":checked")){
                price = 150*sl_;
            }else{
                price = 0;
            }
            $("#OPT_XFLD_TEMP").val(price);
        }else if(option=="OPT_TWXFYFW"){
            //厅外消防员服务
            if($("#OPT_TWXFYFW_TEXT").is(":checked")){
                price = 230*sl_;
            }else{
                price = 0;
            }
            $("#OPT_TWXFYFW_TEMP").val(price);
        }
        else if(option=="OPT_FYHTYJFXGB"){
            //飞弈货梯有机房新国标
            if($("#OPT_FYHTYJFXGB_TEXT").is(":checked")){
                price = 3120*sl_;
            }else{
                price = 0;
            }
            $("#OPT_FYHTYJFXGB_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }

    //轿厢装潢部分-加价
    function editJxzh(option){
        //数量
        var sl_ = $("#SHINY_SL").val()==""?0:parseInt($("#SHINY_SL").val());
        //价格
        var price = 0;
        if(option=="JXZH_JM"){
            //轿门
            var jm_ = $("input[name='JXZH_JM']:checked").val();
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            if(jm_=="钢板喷涂"){
                price = 0;
            }else if(jm_=="镜面不锈钢"){
                price = 0;
            }else if(jm_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = 1500*sl_;
                }else if(kmkd_=="1500"){
                    price = 1700*sl_;
                }else if(kmkd_=="1700"){
                    price = 1800*sl_;
                }else if(kmkd_=="2000"){
                    price = 2200*sl_;
                }else if(kmkd_=="2200"){
                    price = 2300*sl_;
                }
            }
            $("#JXZH_JM_TEMP").val(price);
        }else if(option=="JXZH_JM_quxiao"){
        	$("input[name='JXZH_JM']:checked").removeAttr("checked");
        	$("input[name='JXZH_QWB']:checked").removeAttr("checked");
        	$("input[name='JXZH_CWB']:checked").removeAttr("checked");
        	$("input[name='JXZH_HWB']:checked").removeAttr("checked");
        	$("#JXZH_JM_TEMP").val(0);
        	$("#JXZH_QWB_TEMP").val(0);
        }
        else if(option=="JXZH_QWB"){
            //前围壁
            var qwb_ = $("input[name='JXZH_QWB']:checked").val();
            var cwb_ = $("input[name='JXZH_CWB']:checked").val();
            var hwb_ = $("input[name='JXZH_HWB']:checked").val();
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            var zz_ = $("#BZ_ZZ").val();//载重
            if(qwb_=="发纹不锈钢" && cwb_=="发纹不锈钢" &&hwb_=="发纹不锈钢" ){
                if(zz_=="1000"){
                    price = 5000*sl_;
                }else if(zz_=="2000"){
                    price = 8000*sl_;
                }else if(zz_=="3000"){
                    price = 10000*sl_;
                }else if(zz_=="4000"){
                    price = 12000*sl_;
                }else if(zz_=="5000"){
                    price = 15000*sl_;
                }
            }else{
            	 price = 0;
            }
            $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_CWB"){
            //侧围壁
        	 var qwb_ = $("input[name='JXZH_QWB']:checked").val();
             var cwb_ = $("input[name='JXZH_CWB']:checked").val();
             var hwb_ = $("input[name='JXZH_HWB']:checked").val();
             var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
             var zz_ = $("#BZ_ZZ").val();//载重
             if(qwb_=="发纹不锈钢" && cwb_=="发纹不锈钢" &&hwb_=="发纹不锈钢" ){
                 if(zz_=="1000"){
                     price = 5000*sl_;
                 }else if(zz_=="2000"){
                     price = 8000*sl_;
                 }else if(zz_=="3000"){
                     price = 10000*sl_;
                 }else if(zz_=="4000"){
                     price = 12000*sl_;
                 }else if(zz_=="5000"){
                     price = 15000*sl_;
                 }
             }else{
             	 price = 0;
             }
             $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_HWB"){
            //后围壁
        	 var qwb_ = $("input[name='JXZH_QWB']:checked").val();
             var cwb_ = $("input[name='JXZH_CWB']:checked").val();
             var hwb_ = $("input[name='JXZH_HWB']:checked").val();
             var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
             var zz_ = $("#BZ_ZZ").val();//载重
             if(qwb_=="发纹不锈钢" && cwb_=="发纹不锈钢" &&hwb_=="发纹不锈钢" ){
                 if(zz_=="1000"){
                     price = 5000*sl_;
                 }else if(zz_=="2000"){
                     price = 8000*sl_;
                 }else if(zz_=="3000"){
                     price = 10000*sl_;
                 }else if(zz_=="4000"){
                     price = 12000*sl_;
                 }else if(zz_=="5000"){
                     price = 15000*sl_;
                 }
             }else{
             	 price = 0;
             }
             $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_JDZH"){
            //轿顶装潢
            var jdzh_ = $("#JXZH_JDZH").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(jdzh_=="发纹不锈钢"){
                if(zz_=="1000"){
                    price = 1200*sl_;
                }else if(zz_=="2000"){
                    price = 2300*sl_;
                }else if(zz_=="3000"){
                    price = 3500*sl_;
                }else if(zz_=="4000"){
                    price = 4600*sl_;
                }else if(zz_=="5000"){
                    price = 5800*sl_;
                }
            }else{
                price = 0;
            } 
            //price = 0;
            $("#JXZH_JDZH_TEMP").val(price);
        }else if(option=="JXZH_JDAQC"){
            //轿顶安全窗
            var aqc_ = $("#JXZH_JDAQC").val();
            if(aqc_=="带安全窗(536mm*355mm)"){
            	 price = 1300*sl_;
            }else{
                price = 0;
            } 
            $("#JXZH_JDAQC_TEMP").val(price);
        }else if(option=="JXZH_DBXH"){
            //地板型号
            var dbxh_ = $("#JXZH_DBXH").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(dbxh_=="不锈钢花纹钢板"){
                if(zz_=="1000"){
                    price = 3100*sl_;
                }else if(zz_=="2000"){
                    price = 5400*sl_;
                }else if(zz_=="3000"){
                    price = 7700*sl_;
                }else if(zz_=="4000"){
                    price = 10000*sl_;
                }else if(zz_=="5000"){
                    price = 12000*sl_;
                }
            }else{
                price = 0;
            }
            $("#JXZH_DBXH_TEMP").val(price);
        }else if(option=="JXZH_FZTXH"){
            //防撞条型号
            var fztxh_ = $("#JXZH_FZTXH").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(fztxh_=="木条"){
                if(zz_=="1000"||zz_=="2000"||zz_=="3000"){
                    price = 1500*sl_;
                }else if(zz_=="4000"||zz_=="5000"){
                    price = 1800*sl_;
                }
            }else if(fztxh_=="橡胶条"){
                if(zz_=="1000"||zz_=="2000"||zz_=="3000"){
                    price = 2200*sl_;
                }else if(zz_=="4000"||zz_=="5000"){
                    price = 2600*sl_;
                }
            }
            $("#JXZH_FZTXH_TEMP").val(price);
        }else if(option=="JXZH_BGJ"){
            //半高镜
            if($("#JXZH_BGJ").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();
                if(zz_=="1000"){
                    price = 1200*sl_;
                }else if(zz_=="2000"){
                    price = 1500*sl_;
                }else if(zz_=="3000"){
                    price = 1800*sl_;
                }else if(zz_=="4000"){
                    price = 2200*sl_;
                }else if(zz_=="5000"){
                    price = 2500*sl_;
                }
            }else{
                price = 0;
            }
            $("#JXZH_BGJ_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }

    //厅门门套部分-加价
    function editTmmt(option){
        //数量
        var sl_ = $("#SHINY_SL").val()==""?0:parseInt($("#SHINY_SL").val());
        var sctmmtczxmk_ = $("#TMMT_SCTMMTCZXMK").val();//首层厅门门套材质小门框
        var fsctmmtczxmk_ = $("#TMMT_FSCTMMTCZXMK").val();//非首层厅门门套材质小门框
        var sctmmtczdmk_ = $("#TMMT_SCTMMTCZDMK").val();//首层厅门门套材质大门框
        var fsctmmtczdmk_ = $("#TMMT_FSCTMMTCZDMK").val();//非首层厅门门套材质大门框
        var tmcz_ = $("#TMMT_TMCZ").val();//厅门材质
        var fsctmcz_ = $("#TMMT_FSCTMCZ").val();//非首层厅门材质

        var kmkd_ = $("#BZ_KMKD").val();//开门宽度
        var c_ = parseInt($("#BZ_C").val()-1);//层
        var m_ = parseInt($("#BZ_M").val()-1);//门
        //价格
        var price = 0;
        if(option=="TMMT_SCTMMTCZXMK"){
            //首层厅门门套材质小门框
            var ts_ = parseInt_DN($("#TMMT_SCTMMTCZXMKTS").val());//套数
            if(sctmmtczxmk_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = 460*sl_*ts_;
                }else if(kmkd_=="1500"){
                    price = 540*sl_*ts_;
                }else if(kmkd_=="1700"){
                    price = 620*sl_*ts_;
                }else if(kmkd_=="2000"){
                    price = 690*sl_*ts_;
                }else if(kmkd_=="2200"){
                    price = 770*sl_*ts_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_SCTMMTCZXMK_TEMP").val(price);
        }else if(option=="TMMT_FSCTMMTCZXMK"){
            //非首层厅门门套材质小门框
            var sctmmtczxmk_temp = parseInt($("#TMMT_SCTMMTCZXMK_TEMP").val());
            var ts_ = parseInt_DN($("#TMMT_XMKCZS").val());//套数
            if(fsctmmtczxmk_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = 460*sl_*ts_;
                }else if(kmkd_=="1500"){
                    price = 540*sl_*ts_;
                }else if(kmkd_=="1700"){
                    price = 620*sl_*ts_;
                }else if(kmkd_=="2000"){
                    price = 690*sl_*ts_;
                }else if(kmkd_=="2200"){
                    price = 770*sl_*ts_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_FSCTMMTCZXMK_TEMP").val(price);
        }else if(option=="TMMT_SCTMMTCZDMK"){
            var ts_ = parseInt_DN($("#TMMT_SCTMMTCZDMKTS").val());//套数
            //首层厅门门套材质大门框
            if(sctmmtczdmk_=="钢板喷涂"){
                if(kmkd_=="1400"){
                    price = 2200*sl_*ts_;
                }else if(kmkd_=="1500"){
                    price = 2300*sl_*ts_;
                }else if(kmkd_=="1700"){
                    price = 2600*sl_*ts_;
                }else if(kmkd_=="2000"){
                    price = 3100*sl_*ts_;
                }else if(kmkd_=="2200"){
                    price = 3400*sl_*ts_;
                }
            }else if(sctmmtczdmk_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = 3200*sl_*ts_;
                }else if(kmkd_=="1500"){
                    price = 3400*sl_*ts_;
                }else if(kmkd_=="1700"){
                    price = 3800*sl_*ts_;
                }else if(kmkd_=="2000"){
                    price = 4500*sl_*ts_;
                }else if(kmkd_=="2200"){
                    price = 4800*sl_*ts_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_SCTMMTCZDMK_TEMP").val(price);
        }else if(option=="TMMT_FSCTMMTCZDMK"){
            //非首层厅门门套材质大门框
            var sctmmtczdmk_ = parseInt($("#TMMT_SCTMMTCZDMK_TEMP").val());
            var ts_ = parseInt_DN($("#TMMT_DMKCZS").val());//套数
            if(fsctmmtczdmk_=="钢板喷涂"){
                if(kmkd_=="1400"){
                    price = 2200*sl_*ts_;
                }else if(kmkd_=="1500"){
                    price = 2300*sl_*ts_;
                }else if(kmkd_=="1700"){
                    price = 2600*sl_*ts_;
                }else if(kmkd_=="2000"){
                    price = 3100*sl_*ts_;
                }else if(kmkd_=="2200"){
                    price = 3400*sl_*ts_;
                }
            }else if(fsctmmtczdmk_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = 3200*sl_*ts_;
                }else if(kmkd_=="1500"){
                    price = 3400*sl_*ts_;
                }else if(kmkd_=="1700"){
                    price = 3800*sl_*ts_;
                }else if(kmkd_=="2000"){
                    price = 4500*sl_*ts_;
                }else if(kmkd_=="2200"){
                    price = 4800*sl_*ts_;
                }
            }else{
                price = 0;
            }
            price += sctmmtczdmk_;//
            $("#TMMT_FSCTMMTCZDMK_TEMP").val(price);
        }else if(option=="TMMT_TMCZ"){
            //厅门材质
            var ts_ = parseInt_DN($("#TMMT_TMCZTS").val());//套数
            if(tmcz_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = 1500*sl_*ts_;
                }else if(kmkd_=="1500"){
                    price = 1700*sl_*ts_;
                }else if(kmkd_=="1700"){
                    price = 1800*sl_*ts_;
                }else if(kmkd_=="2000"){
                    price = 2200*sl_*ts_;
                }else if(kmkd_=="2200"){
                    price = 2300*sl_*ts_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_TMCZ_TEMP").val(price);
        }else if(option=="TMMT_FSCTMCZ"){
            //非首层厅门材质
            var tmcz_temp = parseInt($("#TMMT_TMCZ_TEMP").val());
            var ts_ = parseInt_DN($("#TMMT_CZS").val());//套数
            if(fsctmcz_=="发纹不锈钢"){
                if(kmkd_=="1400"){
                    price = 1500*sl_*ts_;
                }else if(kmkd_=="1500"){
                    price = 1700*sl_*ts_;
                }else if(kmkd_=="1700"){
                    price = 1800*sl_*ts_;
                }else if(kmkd_=="2000"){
                    price = 2200*sl_*ts_;
                }else if(kmkd_=="2200"){
                    price = 2300*sl_*ts_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_FSCTMCZ_TEMP").val(price);
        }else if(option=="TMXHZZ_TWZHXH"){
            //厅外召唤型号
            //切换下拉选项时，数量框清空。
            var tmzhzz_twzhxh = $("#TMXHZZ_TWZHXH").val();
            if(tmzhzz_twzhxh=='JFHB06H-E'){
            	//$("#TMXHZZ_SL").val('');
                $("#TMXHZZ_TWZHXH_TEMP").val(parseFloat((getValueToFloat("#TMXHZZ_SL")*31*sl_).toFixed(4)));
            }else if(tmzhzz_twzhxh=='JFHB05P-E'){
            	//暂无加价
                $("#TMXHZZ_TWZHXH_TEMP").val(0);
            }else{
                $("#TMXHZZ_TWZHXH_TEMP").val(0);
            }
            
        }
        //放入价格
        countZhj();
    }
    

    //操纵盘-加价
    function editCzp(option){
        var sl_ = parseInt($("#SHINY_SL").val());
        var price = 0;
        if(option=="CZP_CZPXH"){
            var czpxh_ = $("#CZP_CZPXH").val();
            if(czpxh_=="JFCOP05P-E"){
                price = 0;
            }else if(czpxh_=="JFCOP06H-E"){
                price = 150*sl_;
            }
            $("#CZP_CZPXH_TEMP").val(price);
        }
        //放入价格
        countZhj();
    }

    //厅门信号装置-加价
    function editTmxhzz(option){
        var sl_ = parseInt($("#SHINY_SL").val());
        var price = 0;
        if(option=="TMXHZZ_SL"){
            var tmxhzzsl_ = getValueToFloat("#TMXHZZ_SL");
            var twzhxh_ = $("#TMXHZZ_TWZHXH").val();
            var dtts_ = $("#SHINY_SL").val();
            if(twzhxh_=="JFHB05P-E"){
                price = 0;
            }else if(twzhxh_=="JFHB06H-E"){
                price = 31*tmxhzzsl_*dtts_;
            }
            $("#TMXHZZ_TWZHXH_TEMP").val(price);
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
            $("#SHINY_YSF").val(0);
            $("#XS_YSJ").val(0);
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
                        $("#SHINY_YSF").val(transPrice);
                        $("#XS_YSJ").val(transPrice);
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
                        $("#SHINY_YSF").val(transPrice);
                        $("#XS_YSJ").val(transPrice);
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
            
            if(validateIsInput()){
//             	removeAttrDisabled();
            	
            	var index = layer.load(1);
            	var saveFlag = "1";
    			$.ajax({
    			    type: 'POST',
    			    url: '<%=basePath%>e_offerdt/saveShiny.do',
    			    data: $("#shinyForm").dn2_serialize(getSelectDis())+"&saveFlag="+saveFlag,
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
    }

    function getFBLXJSON() {
    	return ${fns:getDictListJson('fbtype')};
    }
    
    function validateIsInput(){
    	//非空验证
        if ($("#XS_QTFY").val() == "" && $("#XS_QTFY").val() == "") {
			$("#XS_QTFY").focus();
			$("#XS_QTFY").tips({
				side : 3,
				msg : "请填写其他费用!",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
        
        if ($("#XS_YJZE").val() == "" && $("#XS_YJZE").val() == "") {
			$("#XS_YJZE").focus();
			$("#XS_YJZE").tips({
				side : 3,
				msg : "请填写佣金费用!",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
        
        if ($("#XS_CQSJDJ").val() == "" && $("#XS_CQSJDJ").val() == "") {
			$("#XS_CQSJDJ").focus();
			$("#XS_CQSJDJ").tips({
				side : 3,
				msg : "请填写草签实际单价!",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
        
        if ($("#XS_YSJ").val() == "" && $("#XS_YSJ").val() == "") {
			$("#XS_YSJ").focus();
			$("#XS_YSJ").tips({
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
        //井道承重墙厚度
        if($("input[name='BASE_JDCZQHD']:checked").val()!="250"){
            $("input[name='BASE_JDCZQHD']:checked").val($("#BASE_JDCZQHD_TEXT").val());
        }
        
        //设置checkbox选项值
        if($("#JXZH_BGJ").is(":checked")){
            $("#JXZH_BGJ").val("1");
        }else{
            $("#JXZH_BGJ").val("0");
        }
        //可选功能部分
        if($("#OPT_JFGT_TEXT").is(":checked")){
            $("#OPT_JFGT").val("1");
        }else{
            $("#OPT_JFGT").val("0");
        }
        if($("#OPT_GBSCJRCZXCOP_TEXT").is(":checked")){
            $("#OPT_GBSCJRCZXCOP").val("1");
        }else{
            $("#OPT_GBSCJRCZXCOP").val("0");
        }
        if($("#OPT_FDLCZ_TEXT").is(":checked")){
            $("#OPT_FDLCZ").val("1");
        }else{
            $("#OPT_FDLCZ").val("0");
        }
        if($("#OPT_TDJJJY_TEXT").is(":checked")){
            $("#OPT_TDJJJY").val("1");
        }else{
            $("#OPT_TDJJJY").val("0");
        }
        if($("#OPT_YSJCZ_TEXT").is(":checked")){
            $("#OPT_YSJCZ").val("1");
        }else{
            $("#OPT_YSJCZ").val("0");
        }
        if($("#OPT_CCTVDL_TEXT").is(":checked")){
            $("#OPT_CCTVDL").val("1");
        }else{
            $("#OPT_CCTVDL").val("0");
        }
        if($("#OPT_JJBYDYCZZZ_TEXT").is(":checked")){
            $("#OPT_JJBYDYCZZZ").val("1");
        }else{
            $("#OPT_JJBYDYCZZZ").val("0");
        }
        if($("#OPT_JXDZZ_TEXT").is(":checked")){
            $("#OPT_JXDZZ").val("1");
        }else{
            $("#OPT_JXDZZ").val("0");
        }
        if($("#OPT_ZPC_TEXT").is(":checked")){
            $("#OPT_ZPC").val("1");
        }else{
            $("#OPT_ZPC").val("0");
        }
        if($("#OPT_YCJSJKZB_TEXT").is(":checked")){
            $("#OPT_YCJSJKZB").val("1");
        }else{
            $("#OPT_YCJSJKZB").val("0");
        }
        if($("#OPT_YYBZ_TEXT").is(":checked")){
            $("#OPT_YYBZ").val("1");
        }else{
            $("#OPT_YYBZ").val("0");
        }
        if($("#OPT_HJZDFHJZ_TEXT").is(":checked")){
            $("#OPT_HJZDFHJZ").val("1");
        }else{
            $("#OPT_HJZDFHJZ").val("0");
        }
        if($("#OPT_BAJK_TEXT").is(":checked")){
            $("#OPT_BAJK").val("1");
        }else{
            $("#OPT_BAJK").val("0");
        }
        if($("#OPT_DJGRBH_TEXT").is(":checked")){
            $("#OPT_DJGRBH").val("1");
        }else{
            $("#OPT_DJGRBH").val("0");
        }
        if($("#OPT_XFLD_TEXT").is(":checked")){
            $("#OPT_XFLD").val("1");
        }else{
            $("#OPT_XFLD").val("0");
        }
        if($("#OPT_TWXFYFW_TEXT").is(":checked")){
            $("#OPT_TWXFYFW").val("1");
        }else{
            $("#OPT_TWXFYFW").val("0");
        }
        if($("#OPT_FYHTYJFXGB_TEXT").is(":checked")){
            $("#OPT_FYHTYJFXGB").val("1");
        }else{
            $("#OPT_FYHTYJFXGB").val("0");
        }
        if($("#OPT_GTJX_TEXT").is(":checked")){
            $("#OPT_GTJX").val("1");
        }else{
            $("#OPT_GTJX").val("0");
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
        
        return true;
    }
    

    function saveOfAjax() {
    	if(validateIsInput()){
           var index = layer.load(1);
			$.ajax({
			    type: 'POST',
			    url: '<%=basePath%>e_offerdt/${msg}.do',
			    data: $("#shinyForm").dn2_serialize(getSelectDis()),
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
			$('#SHINY_ID').val(data.dtCodId);
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
    	var sl_ = $("#SHINY_SL").val()==""?0:parseInt($("#SHINY_SL").val());
    	//setTimeout(function(){
			basisDate.fbdj = dj;
			$("#SBJ_TEMP").val(dj*sl_);
	        $("#DANJIA").val(dj);
	        setMPrice();
	        countZhj();
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
	  	if(basisDate.isLoadEnd != 1)return;
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
                    	var cqsjdj=$("#XS_CQSJDJ").val();
                    	//数量
                    	var sl=$("#SHINY_SL").val();
                    	//赋值给设备实际报价
                    	$("#XS_SBSJBJ").val(cqsjdj*sl);
                    	
                    	//计算折扣并赋值
                    	var zkl;
                    	var qtfy=$("#XS_QTFY").val()*ShuiLv;//其他费用
                    	var yjze=$("#XS_YJZE").val()*ShuiLv;//佣金总额
                    	var sjbj=$("#XS_SBSJBJ").val();//设备实际报价
                    	var fbj=$("#XS_FBJ").val();//非标价
                    	var jj=parseInt($("#SBJ_TEMP").val());//基价
                    	var xxjj=parseInt($("#XS_XXJJ").val());//选项加价
                    	var qtfya=getValueToFloat("#XS_QTFY");
                    	var a=sjbj-fbj-qtfy-yjze;
                    	var b=jj+xxjj;

                    	zkl=a/b;
                    	$("#XS_ZKL").val((zkl*100).toFixed(1));
                    	
                    	//计算佣金比例并赋值
                    	var yjbl; 
                    	/* var c=sjbj-fbj-qtfy;
                    	yjbl=c/b;
                    	$("#XS_YJBL").val((yjbl*100).toFixed(1)); */
                    	yjbl=$("#XS_YJZE").val()/(sjbj/ShuiLv);
                    	$("#XS_YJBL").val((yjbl*100).toFixed(1));
                    	
                    	//计算佣金使用折扣率和最高佣金
                    	var yjsyzkl;
                    	var ZGYJ;
                    	var ZGYJA;
                    	// (实际报价-非标费-其他费用*1.16)/(基价+选项)
                    	var c=sjbj-fbj-(qtfya*ShuiLv);
                    	//alert(sjbj+'-'+fbj+'-('+qtfya+'*'+ShuiLv+')'+'/'+b);
                    	yjsyzkl=c/b;
                    	$("#YJSYZKL").val((yjsyzkl*100).toFixed(1));
                    	
                    	var yjsyzkla = $("#YJSYZKL").val()==""?0:parseInt($("#YJSYZKL").val());
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
                    			$("#XS_SFCB").val("Y");
                    		}else{$("#XS_SFCB").val("N");}
                    	}
                    	else if(66<=zkl*100<=70)
                    	{
                    		var q=(sjbj*0.5)/ShuiLv;
                    		if(yjze>q)
                    		{
                    			$("#XS_SFCB").val("Y");
                    		}else{$("#XS_SFCB").val("N");}
                    	}
                    	else if(71<=zkl*100<=75)
                    	{
                    		var q=(sjbj*0.6)/ShuiLv;
                    		if(yjze>q)
                    		{
                    			$("#XS_SFCB").val("Y");
                    		}else{$("#XS_SFCB").val("N");}
                    	}
                    	else if(zkl*100>75)
                    	{
                    		var q=(sjbj*0.6)/ShuiLv;
                    		var w=(jj+xxjj)*0.85;
                    		var e=sjbj-fbj-qtfy;
                    		var r=(q+(e-w)*0.5)/ShuiLv;
                    		if(yjze>r)
                    		{
                    			$("#XS_SFCB").val("Y");
                    		}else{$("#XS_SFCB").val("N");}
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
    	var sbsjzj_=parseInt($("#XS_SBSJBJ").val());//设备实际总价
    	var qtfy_=parseInt($("#XS_QTFY").val());//其他费用
    	var azf_=parseInt($("#XS_AZJ").val());//安装费
    	var ysf_=parseInt($("#XS_YSJ").val());//运输费
    	if(isNaN(ysf_))
    	{
    		ysf_=0;
    	}
    	else if(isNaN(azf_))
    	{
    		azf_=0;
    	}
    	else if(isNaN(qtfy_))
    	{
    		qtfy_=0;
    	} 
    	$("#XS_TATOL").val(sbsjzj_+qtfy_+azf_+ysf_);
    }
    
    
    $("#BASE_TSGD").change(function(){
    	editOpt('OPT_CCTVDL');
    });
    $("#BASE_GTMS").change(function(){
    	editGbcs('GTMS_JM');
    });
    $("#BASE_QGLJJ").change(function(){
    	setJdzg();
    });
    
    
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
  	//验证表单输入数字
  	function checkForm(){
    	var checkCq=parseInt($("#XS_CQSJDJ").val());//草签实际单价
    	var checkQtfy=parseInt($("#XS_QTFY").val());//其他费用
    	var checkYjze=parseInt($("#XS_YJZE").val());//佣金总额

    	if(isNaN(checkCq))
    	{
    		document.getElementById('XS_CQSJDJ').value='';
    	}
    	if(isNaN(checkQtfy))
    	{
    		document.getElementById('XS_QTFY').value='';
    	}
    	if(isNaN(checkYjze))
    	{
    		document.getElementById('XS_YJZE').value='';
    	} 
    }
    
  	function isJXCRK() {
  		if($('#BASE_JXCRKSL').val() == 2){
  			$('#OPT_GTJX_TEXT').prop("checked","checked");
  		} else {
  			$("#OPT_GTJX_TEXT").removeAttr("checked");
  		}
  		editGbcs('OPT_GTJX');
	}
  	
</script>
</body>

</html>
