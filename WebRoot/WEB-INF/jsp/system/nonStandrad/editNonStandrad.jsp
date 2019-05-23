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
        .lb-bjc a{
        	color: white;
        }
        .lb-bjc a:link,.lb-bjc a:hover,.lb-bjc a:visited,.lb-bjc a:active{
        	color: white;
        }
        .lb-bjc a:hover{
        	text-decoration: underline;
        }
    </style>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp"%>
    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
    <script src="static/js/select2/select2.min.js"></script>
    <script type="text/javascript">

    </script>
</head>

<body class="gray-bg "><!-- position-relative -->
<form action="nonStandrad/${msg}.do" name="nonstandradForm" id="nonstandradForm" method="post">
    <input type="hidden" name="non_standrad_id" id="non_standrad_id" value="${pd.non_standrad_id}">
    <input type="hidden" name="view" id="view" value="${pd.view}">
    <input type="hidden" name="operate_id" id="operate_id" value="${pd.operate_id}">
    <input type="hidden" name="subtype" id="subtype" value="0">
    <input type="hidden" name="NonUpload_json" id="NonUpload_json" value="${pd.NonUpload}">
    <input type="hidden" name="MODELS_ID" id="MODELS_ID" value="${pd.MODELS_ID}">
    <input type="hidden" name="item_id" id="item_id" value="${pd.item_id}">

    <div class="wrapper wrapper-content" style="z-index: -1">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        非标申请
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px">项目名称:</label>
                                            <input style="width:20%;" class="form-control" id="project_name" type="text"
                                                   name="project_name" value="${pd.project_name}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px">分公司:</label>
                                            <input style="width:20%;" class="form-control" id="subsidiary_company" type="text"
                                                   name="subsidiary_company" value="${pd.subsidiary_company}" readonly="readonly">

                                            <label style="width:11%;margin-bottom: 10px">申请人:</label>
                                            <input style="width:20%;" class="form-control" id="operate_name" type="text"
                                                   name="operate_name" value="${pd.operate_name}" readonly="readonly">
                                        </div>

                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px">项目地址:</label>
                                            <input style="width:20%;" class="form-control" id="project_address" type="text"
                                                   name="project_address" value="${pd.project_address}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px">区域:</label>
                                            <input style="width:20%;" class="form-control" id="project_area" type="text"
                                                   name="project_area" value="${pd.project_area}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px">申请日期:</label>
                                            <input style="width:20%;" class="form-control" id="operate_date" type="text"
                                                   name="operate_date" value="${pd.operate_date}" readonly="readonly">
                                        </div>
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px">梯型:</label>
                                            <input style="width:20%;" class="form-control" id="lift_name" type="text"
                                                   name="lift_name" value="${pd.lift_name}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px">载重(kg):</label>
                                            <input style="width:20%;" class="form-control" id="rated_load" type="text"
                                                   name="rated_load" value="${pd.rated_load}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px">层站门:</label>
                                            <input style="width:20%;" class="form-control" id="lift_czm" type="text"
                                                   name="lift_czm" value="${pd.lift_c}/${pd.lift_z}/${pd.lift_m}" readonly="readonly">
                                            <input type="hidden" name="lift_c" value="${pd.lift_c}">
                                            <input type="hidden" name="lift_z" value="${pd.lift_z}">
                                            <input type="hidden" name="lift_m" value="${pd.lift_m}">
                                        </div>
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px">速度(m/s):</label>
                                            <input style="width:20%;" class="form-control" id="lift_speed" type="text"
                                                   name="lift_speed" value="${pd.lift_speed}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px">底坑深(mm):</label>
                                            <input style="width:20%;" class="form-control" id="pit_depth" type="text"
                                                   name="pit_depth" value="${pd.pit_depth}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px">顶层高(mm):</label>
                                            <input style="width:20%;" class="form-control" id="headroom_height" type="text"
                                                   name="headroom_height" value="${pd.headroom_height}" readonly="readonly">
                                        </div>
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px">提升高度(mm):</label>
                                            <input style="width:20%;" class="form-control" id="traveling_height" type="text"
                                                   name="traveling_height" value="${pd.traveling_height}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px">井道总高(mm):</label>
                                            <input style="width:20%;" class="form-control" id="well_depth" type="text"
                                                   name="well_depth" value="${pd.well_depth}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px">开门尺寸:</label>
                                            <input style="width:20%;" class="form-control" id="opening_width" type="text"
                                                   name="opening_width" value="${pd.opening_width}" readonly="readonly">
                                        </div>
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px">轿厢规格:</label>
                                            <input style="width:20%;" class="form-control" id="car_size" type="text"
                                                   name="car_size" value="${pd.car_size}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px">角度:</label>
                                            <input style="width:20%;" class="form-control" id="lift_angle" type="text"
                                                   name="lift_angle" value="${pd.lift_angle}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px">梯级宽度:</label>
                                            <input style="width:20%;" class="form-control" id="step_width" type="text"
                                                   name="step_width" value="${pd.step_width}" readonly="readonly">
                                        </div>
                                        <div class="form-group form-inline">
                                        	<label style="width:11%;margin-bottom: 10px">轿厢高度:</label>
                                            <input style="width:20%;" class="form-control" id="car_height" type="text"
                                                   name="car_height" value="${pd.car_height}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px;">台数:</label>
                                            <input style="width:20%;" class="form-control" id="lift_num" type="text"
                                                   name="lift_num" value="${pd.lift_num}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px">井道尺寸HW*HD:</label>

                                            <input type="text" name="JDK" id="JDK"class="form-control" style="width: 8%" value="${pd.JDK}"readonly="readonly">
                                            mm宽×
                                            <input type="text" name="JDS" id="JDS" class="form-control" style="width: 8%" value="${pd.JDS}"readonly="readonly">
                                            mm深
                                        </div>
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px">开门形式:</label>
                                            <input style="width:20%;" class="form-control" id="BZ_KMXS" type="text"
                                                   name="BZ_KMXS" value="${pd.BZ_KMXS}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px">水平梯级:</label>
                                            <input style="width:20%;" class="form-control" id="BZ_SPTJ" type="text"
                                                   name="BZ_SPTJ" value="${pd.BZ_SPTJ}" readonly="readonly">
                                        </div>
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px;">土建图图号:</label>
                                            <input style="width:20%;" class="form-control" id="TJTTH" type="text"
                                                   name="TJTTH" value="${pd.TJTTH}" readonly="readonly">
                                            <label style="width:11%;margin-bottom: 10px;">备注:</label>
                                            <textarea rows="2" name="NON_BZ" id="NON_BZ" class="form-control" style="margin: 0px 0px 0px 0px;resize:vertical;width:52%;" >${pd.NON_BZ}</textarea>
                                        </div>
                                        <!-- 新增和编辑时候显示 -->
                                        <c:if test="${msg!='view'}">
	                                        <div id="fjmk">
												<div class="form-group form-inline">
												  <label style="width: 9%;margin-left: 10px;">附件上传:</label> 
												   <input class="form-control" type="hidden" name="NonUpload" value="" title="附件上传" />
													<input style="width: 21%" class="form-control" type="file"
														name="non_upload" id="non_upload" title="附件上传" onchange="upload(this)" />
													<c:if test="${msg=='saveNonStandrad'}">
													  <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
													  title="添加" type="button"onclick="addHousesImg();">加</button>
													</c:if>
													<c:if test="${msg=='editNonStandrad'}">
													  <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
													  title="添加" type="button"onclick="addHousesImg1();">加</button>
													   <c:if test="${pd ne null and pd.NonUpload ne null and pd.NonUpload ne '' }">
													     <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
													  </c:if> 
													</c:if>
                                                    <input type="hidden" name="FILENAME">
												</div>
											</div>
										</c:if>
										
										<!-- 查看时候显示 -->
                                        <c:if test="${msg=='view'}">
	                                        <div id="fjmk">
												<div class="form-group form-inline">
												  <label style="width: 9%;margin-left: 10px;">附件上传:</label> 
												    <input class="form-control" type="hidden" name="NonUpload" value="" title="附件上传" />
													<input style="width: 21%" class="form-control" type="file" disabled="disabled"
														name="non_upload" id="non_upload" title="附件上传" onchange="upload(this)" />
													<button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
													  title="添加" type="button"onclick="addHousesImg1();" disabled="disabled">加</button>
													<c:if test="${pd ne null and pd.NonUpload ne null and pd.NonUpload ne '' }">
													     <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
													</c:if>
                                                    <input type="hidden" name="FILENAME">
												</div>
											</div>
										</c:if>
										<div id="bjc-info"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        非标明细
                                    </div>
                                    <div class="panel-body">
                                        <table class="table table-striped table-bordered table-hover" id="fbTable">

                                            <thead>
                                            <tr>
                                                <th style="width:2%;">序号</th>
                                                <th style="width:9%;">非标类型</th>
                                                <th style="width:25%;">非标描述</th>
                                                <th style="width:25%;${msg=='view'?'':'display:none;'}" >技术处理</th>
                                                <th style="width:10%;${costread=='1'||iscaigou=='1'?'':'display:none;'}">成本</th>
                                                <th style="display: none;">采购周期</th>
                                                <th style="display: none;">价格</th>
                                                <th style="display: none">交货期</th>
                                                <th style="width:2%;${msg=='view'?'':'display:none;'}">有效</th>
                                                <th style="width:6%;">操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:if test="${msg=='saveNonStandrad'}"><c:choose><c:when test="${not empty pd.tezhongArgs}"><c:forEach items="${pd.tezhongArgs }" var="tezhongArg" varStatus="vs">
                                            	<tr>
                                                	<td><span class="ns_index">${vs.index+1 }</span></td>
                                                    <td>
                                                    	<select name="nonstandrad_spec" class="form-control" onchange="updateDescribePlaceholder(this);" style="width: 100%;" selectVal="${tezhongArg.XXCS_TYPE }">
                                                    		<option value="">请选择</option><c:forEach items="${fns:getDictList('fbtype')}" var="fbtype" varStatus="vsfbtype">
                                                    		<option plaer="${fbtype.extend_s1 }" value="${fbtype.value }" >${fbtype.name }</option></c:forEach>
                                                    	</select>
                                                    </td>
                                                    <td><textarea name="nonstandrad_describe" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;">${tezhongArg.XXCS_DESCRIBE }</textarea>
                                                        <input type="hidden" name="detail_id">
                                                    </td>
                                                    <td style="display:none;">
                                                      <textarea rows="1" cols="3" name="nonstandrad_handle" id="nonstandrad_handle" class="form-control" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly"></textarea>
                                                    </td>
                                                    <td style="display:none;">
                                                        <textarea name="nonstandrad_cost" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly"></textarea>
                                                    </td>
                                                    <td style="display: none">
                                                        <textarea name="nonstandrad_cycle" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly"></textarea>
                                                    </td>
                                                    <td style="display: none">
                                                        <textarea name="nonstandrad_price" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly"></textarea>
                                                    </td>
                                                    <td style="width:10%;display: none"><input type="text" name="nonstandrad_date" class="form-control"  value="" readonly="readonly" ${msg=="editNonStandrad"?'onclick="laydate()"':''} ></td>
                                                    <td style="width:10%;display: none;"><input type="checkbox" name="nonstandrad_valid" value="1" checked="checked" readonly="readonly"  ></td>
                                                    <td>
                                                    <c:if test="${vs.index != 0 }"><input type="button" value="删除" onclick='delFbRow(this);'></c:if>
                                                    <input type="button" value="添加" onclick="addFbRow(this);"></td>
                                                </tr>
                                            </c:forEach></c:when><c:otherwise>
                                                <tr>
                                                	<td><span class="ns_index">1</span></td>
                                                    <td>
                                                    	<select name="nonstandrad_spec" class="form-control" onchange="updateDescribePlaceholder(this);" style="width: 100%;">
                                                    		<option value="">请选择</option><c:forEach items="${fns:getDictList('fbtype')}" var="fbtype" varStatus="vsfbtype">
                                                    		<option plaer="${fbtype.extend_s1 }" value="${fbtype.value }">${fbtype.name }</option></c:forEach>
                                                    	</select>
                                                    </td>
                                                    <td><textarea name="nonstandrad_describe" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;"></textarea>
                                                        <input type="hidden" name="detail_id">
                                                    </td>
                                                    <td ${isjishu==1?"":'style="display:none;"'}><!-- <input type="text" name="nonstandrad_handle" class="form-control"  value="" readonly="readonly"> -->
                                                      <c:if test="${isjishu==1}">
                                                        <textarea rows="1" cols="3" name="nonstandrad_handle" id="nonstandrad_handle" class="form-control" style="margin: 0px 0px 0px 0px;resize:vertical;">${e.nonstandrad_spec}</textarea>
                                                      </c:if>
                                                      <c:if test="${isjishu!=1}">
                                                        <textarea rows="1" cols="3" name="nonstandrad_handle" id="nonstandrad_handle" class="form-control" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly">${e.nonstandrad_spec}</textarea>
                                                      </c:if>
                                                    </td>
                                                    <td ${costread=="1"||iscaigou=="1"?"":'style="display:none;"'}>
                                                        <textarea name="nonstandrad_cost" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly"></textarea>
                                                    </td>
                                                    <td style="display: none">
                                                        <textarea name="nonstandrad_cycle" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly"></textarea>
                                                    </td>
                                                    <td style="display: none">
                                                        <textarea name="nonstandrad_price" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly"></textarea>
                                                    </td>
                                                    <td style="width:10%;display: none"><input type="text" name="nonstandrad_date" class="form-control"  value="" readonly="readonly" ${msg=="editNonStandrad"?'onclick="laydate()"':''} ></td>
                                                    <td style="width:10%;display: none;"><input type="checkbox" name="nonstandrad_valid" value="1" checked="checked" readonly="readonly"  ></td>
                                                    <td><input type="button" value="添加" onclick="addFbRow(this);"></td>
                                                </tr></c:otherwise></c:choose>
                                            </c:if>
                                            <c:if test="${msg!='saveNonStandrad'}">
                                                <c:forEach items="${detailList}" var="e" varStatus="vs">
                                                    <c:if test="${vs.index==0}">
                                                        <tr>
                                                		<td><span class="ns_index">${vs.index+1}</span></td>
                                                        <td>
                                                        	<select name="nonstandrad_spec" class="form-control" onchange="updateDescribePlaceholder(this);" style="width: 100%;" selectVal="${e.nonstandrad_spec }">
	                                                    		<option value="">请选择</option><c:forEach items="${fns:getDictList('fbtype')}" var="fbtype" varStatus="vsfbtype">
                                                    			<option title="${fbtype.value }" plaer="${fbtype.extend_s1 }" value="${fbtype.value }" >${fbtype.name }</option></c:forEach>
	                                                    	</select>
                                                        </td>
                                                        <td><textarea name="nonstandrad_describe" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;">${e.nonstandrad_describe}</textarea>
                                                            <input type="hidden" name="detail_id" value="${e.detail_id}"></td>
                                                        <td ${msg=="view"?'':'style="display:none;"'}>
	                                                        <textarea rows="1" cols="3" name="nonstandrad_handle" id="nonstandrad_handle" class="form-control" readonly="readonly"  style="margin: 0px 0px 0px 0px;resize:vertical;">${e.nonstandrad_handle}</textarea>
	                                                    </td>
                                                        <td ${costread=="1"||iscaigou=="1"?"":'style="display:none;"'}>
                                                            <textarea name="nonstandrad_cost" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly">${costread=='1'? e.nonstandrad_cost:'-'}</textarea>

                                                        </td>
                                                        <td style="display: none">
                                                            <textarea name="nonstandrad_cycle" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly">${e.nonstandrad_cycle}</textarea>
                                                        </td>
                                                        <td style="display: none">
                                                            <textarea name="nonstandrad_price" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly">${e.nonstandrad_price}</textarea>
                                                        </td>
                                                        <td style="width:10%;display: none"><input type="text" name="nonstandrad_date" class="form-control" readonly="readonly" value="${e.nonstandrad_date}" ${msg=="editNonStandrad"?'onclick="laydate()"':''} ></td>
                                                        <td style="${msg=='view'?'':'display:none;'}"><input type="checkbox" name="nonstandrad_valid" value="1" ${e.nonstandrad_valid=='1'?'checked="checked"':'' } readonly="readonly"  ></td>
                                                        <td><input type="button" value="添加" onclick="addFbRow(this);"></td>
                                                        </tr>
                                                    </c:if>
                                                    <c:if test="${vs.index!=0}">
                                                        <tr>
                                                		<td><span class="ns_index">${vs.index+1}</span></td>
                                                        <td>
                                                        	<select name="nonstandrad_spec" class="form-control" onchange="updateDescribePlaceholder(this);" style="width: 100%;" selectVal="${e.nonstandrad_spec }">
	                                                    		<option value="">请选择</option><c:forEach items="${fns:getDictList('fbtype')}" var="fbtype" varStatus="vsfbtype">
                                                    			<option title="${fbtype.value }" plaer="${fbtype.extend_s1 }" value="${fbtype.value }">${fbtype.name }</option></c:forEach>
	                                                    	</select>
                                                        </td>
                                                        <td><textarea name="nonstandrad_describe" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;">${e.nonstandrad_describe}</textarea>
                                                            <input type="hidden" name="detail_id" value="${e.detail_id}"></td>
                                                        <td ${msg=="view"?'':'style="display:none;"'}><!-- <input type="text" name="nonstandrad_handle" class="form-control"  value="" readonly="readonly"> -->
	                                                        <textarea rows="1" cols="3" name="nonstandrad_handle" id="nonstandrad_handle" class="form-control" readonly="readonly" style="margin: 0px 0px 0px 0px;resize:vertical;">${e.nonstandrad_handle}</textarea>
	                                                    </td>
                                                        <td ${costread=="1"||iscaigou=="1"?"":'style="display:none;"'}>
                                                            <textarea name="nonstandrad_cost" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly">${costread=='1'? e.nonstandrad_cost:'-'}</textarea>
                                                        </td>
                                                        <td style="display: none">
                                                            <textarea name="nonstandrad_cycle" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly">${e.nonstandrad_cycle}</textarea>
                                                        </td>
                                                        <td style="display: none">
                                                            <textarea name="nonstandrad_price" class="form-control" rows="1" cols="3" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly">${e.nonstandrad_price}</textarea>
                                                        </td>
                                                        <td style="width:10%;display: none"><input type="text" name="nonstandrad_date" class="form-control" readonly="readonly" value="${e.nonstandrad_date}" ${msg=="editNonStandrad"?'onclick="laydate()"':''} ></td>
                                                        <td style="${msg=='view'?'':'display:none;'}"><input type="checkbox" name="nonstandrad_valid" value="1"  ${e.nonstandrad_valid=='1'?'checked="checked"':'' } readonly="readonly"  ></td>
                                                        <td><input type="button" value="删除" onclick='delFbRow(this);'>
                                                        <input type="button" value="添加" onclick="addFbRow(this);"></td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>
                                            </tbody>
                                        </table>
                                        
                                        <c:if test="${msg=='view'}">
                                        <label>价格:</label>
                                        <table class="table table-striped table-bordered table-hover" id="jgTable">
                                        	<thead>
                                            <tr>
                                                <th style="width:5%;">序号</th>
                                                <c:if test="${pd.isqxShow == '1' }">
                                                <th style="width:10%;">差价</th>
                                                <th style="width:10%;">加成本</th>
                                                </c:if>
                                                <th style="width:10%;">加价</th>
                                                <th style="width:10%;">计量单位</th>
                                                <th style="width:10%;">单台用量</th>
                                                <th style="width:10%;">单台报价</th>
                                                <%-- <th style="width:10%;">总价</th> --%>
                                                <th style="width:10%;">可打折</th>
                                                <th style="width:10%;">备注</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            	<c:forEach items="${detailList}" var="e" varStatus="vs">
                                            	<tr>
                                            		<td style="width:5%;text-align: center;">${vs.index+1}</td>
                                            		<c:if test="${pd.isqxShow == '1' }">
                                            		<td style="width:10%">
                                            			<textarea name="nonstandrad_CJ" class="form-control" rows="1" cols="3"
                                                                      style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly">${e.nonstandrad_CJ}</textarea>
                                            		</td>
                                            		<td style="width:10%">
                                            			<textarea name="nonstandrad_JCB" class="form-control" rows="1" cols="3"
                                                                      style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly">${e.nonstandrad_JCB}</textarea>
                                            		</td>
                                            		</c:if>
                                            		<td style="width:10%">
                                            			<textarea name="nonstandrad_JJ" class="form-control" rows="1" cols="3"
                                                                      style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly" >${e.nonstandrad_JJ}</textarea>
                                            		</td>
                                            		<td style="width:10%">
                                            			<textarea name="nonstandrad_JLDW" class="form-control" rows="1" cols="3"
                                                                      style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly">${e.nonstandrad_JLDW}</textarea>
                                            		</td>
                                            		<td style="width:10%">
                                            			<textarea name="nonstandrad_DTYL" class="form-control" rows="1" cols="3"
                                                                      style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly">${e.nonstandrad_DTYL}</textarea>
                                            		</td>
                                            		<td style="width:10%">
                                            			<textarea name="nonstandrad_DTBJ" class="form-control" rows="1" cols="3"
                                                                      style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly" >${e.nonstandrad_DTBJ}</textarea>
                                            		</td>
                                            		<%-- <td style="width:10%">
                                            			<textarea name="nonstandrad_ZJ" class="form-control" rows="1" cols="3"
                                                                      style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly" >${e.nonstandrad_ZJ}</textarea>
                                            		</td> --%>
                                            		<td style="width:10%">
                                            			<select style="width: 100%" class="form-control" name="nonstandrad_KDZ">
                                            				<option value="" ${e.nonstandrad_KDZ==''?'selected':''}></option>
                                            				<option value="1" ${e.nonstandrad_KDZ=='1'?'selected':''}>是</option>
                                            				<option value="2" ${e.nonstandrad_KDZ=='2'?'selected':''}>否</option>
                                            			</select>
                                            		</td>
                                            		<td style="width:10%">
                                            			<textarea name="nonstandrad_BZ" class="form-control" rows="1" cols="3"
                                                                      style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly">${e.nonstandrad_BZ}</textarea>
                                            		</td>
                                            	</tr>
                                            	</c:forEach>
                                            </tbody>
                                            <tr id="hztr">
											    <td style="text-align: center;">总计</td>
											    <c:if test="${pd.isqxShow == '1' }">
											    <td style="text-align: center;"><span class="ZJ_CJ"></span></td>
											    <td style="text-align: center;"><span class="ZJ_JCB"></span></td>
											    </c:if>
											    <td style="text-align: center;"><span class="ZJ_JJ"></span></td>
											    <td style="text-align: center;"></td>
											    <td style="text-align: center;"><span class="ZJ_DTYL"></span></td>
											    <td style="text-align: center;"><span class="ZJ_DTBJ"></span></td>
											    <%-- <td style="text-align: center;"><span class="ZJ_ZJ"></span></td> --%>
											    <td style="text-align: center;"></td>
											    <td style="text-align: center;"></td>
											</tr>
                                        </table>
                                        <div>
                                        	<span style="">可打折合计： <span id="zj_kdz"></span></span>
                                        	<span style="margin-left: 50px;">不可打折合计： <span id="zj_bkdz"></span></span>
                                        </div>
                                        </c:if>
                                        
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

<table width="100%">
<tr>
    <td width="33%">
        <c:if test="${msg!='view'}">
            <a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save(0);">保存</a>
        </c:if>
    </td>
    <td width="33%" style="text-align: center">
        <c:if test="${msg!='view'}">
            <a class="btn btn-primary" style="width: 150px; height:34px;"  onclick="save(1);">提交</a>
        </c:if>
    </td>
    <td width="33%"><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('zhjView');">关闭</a></td>
</tr>
</table>
<div>&nbsp;</div>
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<script src="static/js/iCheck/icheck.min.js"></script>
<script type="text/javascript">
    $(function () {
        if('${msg}'=='view'){
            $("input").attr("disabled","disabled");
            $("textarea").attr("readonly","readonly");
            $("select").attr("disabled","disabled");
            $("#fbTable").find("button").attr("disabled","disabled");
            
          	//合计
    		JS_ZJ();
        }
        if('${msg}'=='view'){
        	//查看时加载附件上传信息
    		var housesJSON = $("#NonUpload_json").val();
    		if(housesJSON!=""){
    			setCheckJSON(housesJSON);
    		}
        }else{
        	//编辑时加载附件上传信息
    		var housesJSON = $("#NonUpload_json").val();
    		if(housesJSON!=""){
    			setHousesJSON(housesJSON);
    		}
        }
        
        if("${msg}" == "editNonStandrad"){
            initDescribePlaceholder();
        }
        
        $('select[name=nonstandrad_spec]').each(function() {
        	if($(this).attr("selectVal")){
        		$(this).val($(this).attr("selectVal"));
        		if($(this).val() == null){
        			$(this).select2({
        		    	tags: true,
        		        data: [{id: $(this).attr("selectVal"), text: getFBLXJSON($(this).attr("selectVal")), selected:true}]
        		   	});
        		} else {
        			$(this).select2({
        		    	tags: true
        		   	});
        		}
        	} else {
        		$(this).select2({
    		    	tags: true
    		   	});
        	}
		});
        
        getBjcsInfo();
    });
    
    function getFBLXJSON(value) {
    	var _name = value;
    	/* var sfblx = '${fns:getDictListJson("models_nonstanard_xx")}';
    	if(sfblx != ''){
    		var fblx = $.parseJSON(sfblx);
        	if(fblx && value){
        		$.each(fblx, function(i, item){
        			if(item.value == value){
        				_name = item.name;
        				return false;
        			}
        		});
        	}
    	} */
    	
    	return _name;
    }
    
    //非标,点击添加行
    function addFbRow(ele){
		$("#fbTable tr").eq(1).find("td").eq(1).find("select").eq(0).select2("destroy");
        var tr = $("#fbTable tr").eq(1).clone();
        $(tr).find("td").eq(0).find("textarea").eq(0).val("");
        $(tr).find("td").eq(1).find("textarea").eq(0).val("");
        $(tr).find("td").eq(1).find("select").eq(0).val("1");
        $(tr).find("td").eq(1).find("select").eq(0).removeAttr("selectVal");
        $(tr).find("td").eq(2).find("textarea").eq(0).val("");
        $(tr).find("td").eq(2).find("textarea").eq(0).attr("placeholder", "");
        $(tr).find("td").eq(3).find("textarea").eq(0).val("");
        $(tr).find("td").eq(4).find("textarea").eq(0).val("");
        $(tr).find("td").eq(5).find("textarea").eq(0).val("");
        $(tr).find("td").eq(6).find("textarea").eq(0).val("");
        $(tr).find("td:last").html("").append("<input type='button' value='删除' onclick='delFbRow(this);'><input style='margin-left:5px;' type='button' value='添加' onclick='addFbRow(this);'>");
        
        if(ele){
        	$(ele).parents("tr").after(tr);
        } else{
            $("#fbTable").append(tr);
        }
        
        $("#fbTable tr").eq(1).find("td").eq(1).find("select").eq(0).select2({tags: true});
		$(tr).find("td").eq(1).find("select").eq(0).select2({tags: true});
        
        reloadUpdateXH();
    }
    //非标,点击删除行
    function delFbRow(obj){
        $(obj).parent().parent().remove();
        
        reloadUpdateXH();
    }


    //保存
    function reloadUpdateXH(){
        var trs = $("#fbTable tr");
    	for (var i = 1; i < trs.length; i++) {
    		var tr = trs.eq(i);
    		tr.find(".ns_index").html(i);
		}
    }
    
    function save(type){
        //非标json
        var result=true;
        $("[name='nonstandrad_describe']").each(function(idx){
            if($(this).val()==''){
                $(this).focus();
                $(this).tips({
                    side: 3,
                    msg: "请输入描述",
                    bg: '#AE81FF',
                    time: 2
                });
                result=false;
                return false;
            }
            if($($("[name='nonstandrad_spec']")[idx]).val()==''){
                $($("[name='nonstandrad_spec']")[idx]).focus();
                $($("[name='nonstandrad_spec']")[idx]).tips({
                    side: 3,
                    msg: "请选择非标类型",
                    bg: '#AE81FF',
                    time: 2
                });
                result=false;
                return false;
            }
        });
        if(!result){
            return false;
        }
        
        var h="";
        var json = "[";
        //附件上传  拼接为json格式保存
		$("#fjmk").find("div").each(function(){
			h = $(this).find("input").eq(0).val();
            var fname= $(this).find("[name='FILENAME']").eq(0).val();
			json += "{\'NonUpload\':\'"+h+"\',\'FILENAME\':\'"+fname+"\'},";
		});
		json = json.substring(0,json.length-1)+"]";
        if(h==""||h==null)
        {
        	$("#NonUpload_json").val("");
        }
        else
        {
        	 $("#NonUpload_json").val(json);	
        }
   
        
        $("#subtype").val(type);
	
        $("[name='nonstandrad_describe']").each(function(idx){
        	$(this).val($(this).val().replace(/%/g, '%25').replace(/,/g, '%2C'));
        	$("[name='nonstandrad_handle']").eq(idx).val($("[name='nonstandrad_handle']").eq(idx).val().replace(/%/g, '%25').replace(/,/g, '%2C'));
        });
        
        $("#nonstandradForm").submit();
    }
    //关闭当前页面
    function CloseSUWin(id) {
        window.parent.$("#" + id).data("kendoWindow").close();
    }
    
    //文件异步上传   e代表当前File对象,v代表对应路径值
	function upload(e) {
		var v=$(e).prev().val();
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
			url : "houses/upload.do",
			type : "POST",
			data : data,
			cache : false,
			processData : false,
			contentType : false,
			success : function(result) {
				if (result.success) {
					$(e).prev().val(result.filePath);
                    var flist=$(e).parent().find("[name='non_upload']").eq(0).val().split("\\");
                    $(e).parent().find("[name='FILENAME']").val(flist[flist.length-1]);
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
		var downFile = $(e).parent().find("[name='NonUpload']").val();
		window.location.href = "cell/down?downFile=" + downFile+"&fileName="+ encodeURIComponent($(e).parent().find("[name='FILENAME']").val());
	}
	
	//实现多个附件上传 
	var j=0;
	function addHousesImg(){
		 j = j + 1;
	     $("#fjmk").append('<div id="fjmk'+j+'" class="form-group form-inline">'+
		                       '<label style="width:9%;margin-left:13px;">附件上传:</label>'+ 
		                       '<input class="form-control" type="hidden" name="NonUpload"'+
				               'value="" title="附件上传" />'+
			                   '<input style="width: 21%" class="form-control" type="file"'+
				               'name="non_upload" id="non_upload"'+
				               'title="附件上传" onchange="upload(this)" />'+
			                   '<button style="margin-left:6px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
			                   'title="删除" type="button"onclick="delHouses('+j+');">减</button>'+ 
			                   '<c:if test="${pd ne null and pd.NonUpload ne null and pd.NonUpload ne '' }">'+
				               '  <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>'+
			                   '</c:if>'+
                                '<input type="hidden" name="FILENAME">'+
		                       '</div>'
	     );   
	}
	function addHousesImg1(){
		 j = j + 1;
	     $("#fjmk").append('<div id="fjmk'+j+'" class="form-group form-inline">'+
		                       '<label style="width:9%;margin-left:13px;">附件上传:</label>'+ 
		                       '<input class="form-control" type="hidden" name="NonUpload"'+
				               'value="" title="附件上传" />'+
			                   '<input style="width: 21%" class="form-control" type="file"'+
				               'name="non_upload" id="non_upload"'+
				               'title="附件上传" onchange="upload(this)" />'+
			                   '<button style="margin-left:6px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
			                   'title="删除" type="button"onclick="delHouses('+j+');">减</button>'+
                                '<input type="hidden" name="FILENAME">'+
		                       '</div>'
	     );   
	}
	//删除附件 
	function delHouses(o)
	{
		 document.getElementById("fjmk").removeChild(document.getElementById("fjmk"+o));
	}
	
	//编辑时加载附件上传 
	function setHousesJSON(supp){
		var obj = eval("("+supp+")");
		for(var j = 0;j<obj.length-1;j++){
			addHousesImg();
		}
		 for(var i = 0;i<obj.length;i++){
			$("#fjmk").find("div").eq(i).each(function(){
				$(this).find("input").eq(0).val(obj[i].NonUpload);
                $(this).find("[name='FILENAME']").val(obj[i].FILENAME);
                $(this).append(obj[i].FILENAME);
			});
		} 
	} 
	
	//查看时加载附件上传 
	function setCheckJSON(supp){
		var obj = eval("("+supp+")");
		for(var j = 0;j<obj.length-1;j++){
			addCheckImg();
		}
		 for(var i = 0;i<obj.length;i++){
			$("#fjmk").find("div").eq(i).each(function(){
				$(this).find("input").eq(0).val(obj[i].NonUpload);
                $(this).find("[name='FILENAME']").val(obj[i].FILENAME);
                $(this).append(obj[i].FILENAME);
			});
		} 
	}
	//实现 查看多个附件上传
	var x=0;
	function addCheckImg(){
		 x = x + 1;
	     $("#fjmk").append('<div id="fjmk'+x+'" class="form-group form-inline">'+
		                       '<label style="width:9%;margin-left:13px;">附件上传:</label>'+ 
		                       '<input class="form-control" type="hidden" name="NonUpload"'+
				               'value="" title="附件上传" />'+
			                   '<input style="width: 21%" class="form-control" type="file"'+
				               'disabled="disabled" name="non_upload" id="non_upload"'+
				               'title="附件上传" onchange="upload(this)" />'+
			                   '<button style="margin-left:6px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
			                   'title="删除" disabled="disabled" type="button"onclick="delHouses('+j+');">减</button>'+ 
			                   '<c:if test="${pd ne null and pd.NonUpload ne null and pd.NonUpload ne '' }">'+
				               '  <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>'+
			                   '</c:if>'+
                                '<input type="hidden" name="FILENAME">'+
		                       '</div>'
	     );   
	}
	
	function initDescribePlaceholder() {
		var trs = $("#fbTable tbody tr");
		for (var i = 0; i < trs.length; i++) {
			var _spec = trs.eq(i).find("select[name='nonstandrad_spec']").get(0);
			updateDescribePlaceholder(_spec);
		}
	}
	
	function updateDescribePlaceholder(ele) {
		var _plaer = $(ele).find("option:selected").attr("plaer");
		if(_plaer){
			$(ele).parents('tr').find('textarea[name=nonstandrad_describe]').attr('placeholder', _plaer);
		} else {
			$(ele).parents('tr').find('textarea[name=nonstandrad_describe]').attr('placeholder', '');
		}
	}
	
	function JS_ZJ() {
		var trs = $("#jgTable tbody tr");
		if(trs.length < 2)
			return;
		var cj = 0;
		var cbj = 0;
		var jj = 0;
		var dtyl = 0;
		var dtbj = 0;
		var zj = 0;
		var zj_kdz = 0;
		var zj_bkdz = 0;
		for (var i = 0; i < trs.length - 1; i++) {
			var _cj = trs.eq(i).find("textarea[name='nonstandrad_CJ']").val();
			var _cbj = trs.eq(i).find("textarea[name='nonstandrad_JCB']").val();
			var _jj = trs.eq(i).find("textarea[name='nonstandrad_JJ']").val();
			var _dtyl = trs.eq(i).find("textarea[name='nonstandrad_DTYL']").val();
			var _dtbj = trs.eq(i).find("textarea[name='nonstandrad_DTBJ']").val();
			//var _zj = trs.eq(i).find("textarea[name='nonstandrad_ZJ']").val();
			var _kdz = trs.eq(i).find("select[name='nonstandrad_KDZ']").val();
			if(_cj =='' || isNaN(_cj)) _cj = 0;
			if(_cbj =='' || isNaN(_cbj)) _cbj = 0;
			if(_jj =='' || isNaN(_jj)) _jj = 0;
			if(_dtyl =='' || isNaN(_dtyl)) _dtyl = 0;
			if(_dtbj =='' || isNaN(_dtbj)) _dtbj = 0;
			//if(_zj =='' || isNaN(_zj)) _zj = 0;
			cj += parseFloat(_cj);
			cbj += parseFloat(_cbj);
			jj += parseFloat(_jj);
			dtyl += parseFloat(_dtyl);
			dtbj += parseFloat(_dtbj);
			//zj += parseFloat(_zj);
			
			if(_kdz == "1"){
				zj_kdz += parseFloat(_dtbj);
			} else if(_kdz == "2"){
				zj_bkdz += parseFloat(_dtbj);
			}
		}
		var lastTr = $("#jgTable tr:last");
		lastTr.find("span.ZJ_CJ").html(numberFixed(cj));
		lastTr.find("span.ZJ_JCB").html(numberFixed(cbj));
		lastTr.find("span.ZJ_JJ").html(numberFixed(jj));
		lastTr.find("span.ZJ_DTYL").html(dtyl);
		lastTr.find("span.ZJ_DTBJ").html(numberFixed(dtbj));
		//lastTr.find("span.ZJ_ZJ").html(numberFixed(zj));
		
		$("#zj_kdz").html(numberFixed(zj_kdz));
		$("#zj_bkdz").html(numberFixed(zj_bkdz));
	}
	
	function numberFixed(value) {
	  var valueStr = value.toString()
	  if (valueStr.indexOf('.') !== -1 && valueStr.split('.')[1].length > 1) {
	    return value.toFixed(1)
	  } else {
	    return value
	  }  
	}
	
	function getBjcsInfo() {
		var master_id = $('#non_standrad_id').val();
		var item_id = $('#item_id').val();
		if(master_id == ''
				|| item_id == ''){
			return;
		}
		
		$.ajax({
		    type: 'POST',
		    url: '<%=basePath%>nonStandrad/getBjcs.do',
		    data: {
		    	'master_id':master_id,
		    	'item_id':item_id,
		    },
		    dataType: "JSON",
		    success: function(data) {
		    	if(data.code == 1){
		    		var bjs = data.bjcs;
		    		
		    		var content = '';
		    		$.each(bjs, function(i, v) {
						content += ' <span class="label label-primary lb-bjc" style="font-size: 14px;" ><a class="" onclick="See(\''+v.offer_no+'\',\''+v.item_id+'\')" title="点击打开报价信息" href="javascript:;">'+v.offer_version+'版本</a> : <a class="" onclick="sel(\''+v.bjc_cod_id+'\',\''+v.models_id+'\',\''+v.bjc_id+'\');" href="javascript:;" title="点击打开报价电梯信息">'+v.models_name+'</a></span> ';
					});
		    		
		    		if(content == ''){
		    			$('#bjc-info').html('<span class="label label-error" style="font-size: 14px;" >没找到对应的电梯报价信息</span>');
		    		} else {
			    		$('#bjc-info').html(content);
		    		}
		    		
		    		
		    	} else {
		    	}
		    },
		    error: function(data) {
		    }
		});
		
		
	}
	
	
	//跳转查看
	  function sel(cod_id,models_id,bjc_id){
	  	var url = "<%=basePath%>e_offer/offerView.do?COD_ID="+cod_id+"&MODELS_ID="+models_id+"&BJC_ID="+bjc_id+"&forwardMsg=view";
	  	window.parent.$("#ElevatorParam").kendoWindow({
	        width: "1000px",
	        height: "600px",
	        title: "报价清单",
	        actions: ["Close"],
	        content: url,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	  }
	
	//查看报价信息
    function See(offer_no, item_id) {
    	window.parent.$("#viewShops").kendoWindow({
            width: "800px",
            height: "700px",
            title: "查看报价",
            actions: ["Close"],
            content: '<%=basePath%>e_offer/SeeEoffer.do?offer_no=' + offer_no + '&item_id=' + item_id,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();
    }
	
</script>
</body>

</html>
