<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
 <!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 图片插件 -->
    <link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
    <!-- 日期控件-->
<script src="static/js/layer/laydate/laydate.js"></script>
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg" >
	<!-- 合同变更 -->
	<div id="ChangeIncontractHTML" class="animated fadeIn"></div>
    
    <div class="wrapper wrapper-content">
        <div class="row">
        <form role="form" action="contractNewInstallation/${msg}.do" method="post" name="ContractNewAzForm" id="ContractNewAzForm">
			<input type="hidden" name="item_id" id="item_id" value="${pd.item_id}" /> 	
			<input type="hidden" name="AZ_NO" id="AZ_NO" value="${pd.AZ_NO}" /> 
			<input type="hidden" name="offer_id" id="offer_id" value="${pd.offer_id}" /> 	
			<input type="hidden" name="DTNUM" id="DTNUM" value="${pd.DT_NUM}" /> 
			<input type="hidden" name="TOTAL" id="TOTAL" value="${pd.TOTAL}" /> 
			<input type="hidden" name="PRICE" id="PRICE" value="${pd.PRICE}" />
			<input type="hidden" name="jsonFkfs" id="jsonFkfs" value="${pd.jsonFkfs}" />
			<input type="hidden" name="HT_UUID" id="HT_UUID" value="${pd.HT_UUID}" /> 
			<input type="hidden" name="AZ_UUID" id="AZ_UUID" value="${pd.AZ_UUID}" /> 	
			<input type="hidden" name="ACT_KEY" id="ACT_KEY" value="${pd.ACT_KEY}" /> 	
						<input type="hidden" name="type" id="type" value="" />
        	<div class="panel blank-panel">
	        	<!-- 头部  Start-->
				<div style="padding-bottom:40px;">
					<label style="margin-top: 15px; margin-left: 20px; width: 8%">合同编号:</label>
					<label style="width: 22%">${pd.AZ_NO}</label> 
					
					<!-- 查看进来时不显示 -->
					 <c:if test="${msg !='view' }">
					     <button class="btn btn-sm btn-primary" style="margin-left:36%;
					    height:31px" title="保存" type="button" onclick="save('BC');">保存</button>
					    
					    <button class="btn btn-sm btn-success" style="margin-left:8px;
					  height:31px" title="提交" type="button" onclick="save('TJ');">提交 </button>
					 </c:if>
					 
				     <!-- <button class="btn btn-sm" title="预览" style="background:#999999;color:white;margin-left:8px;
				      height:31px" type="button" onclick="CNprview();">预览</button> -->
	          	</div>
				<!-- 头部  End-->
        		
        		<!-- Tab Start -->
				<div class="panel-heading" style="margin-top: -40px;">
					<div class="panel-options">
						<ul class="nav nav-tabs">
							<li id="nav-tab-1">
								<a class="count-info-sm" data-toggle="tab" onclick="CutOverTab(1)">
									<i class="fa fa-hourglass-2"></i>
									主信息
								</a>
							</li>
							<li id="nav-tab-2">
								<a data-toggle="tab"  onclick="CutOverTab(2)">
									<i class="fa fa-hourglass"></i>
									电梯信息
								</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- Tab End -->
				
				<!-- 内容层 一 Start -->
					<div class="panel-body">
						<div class="tab-content">
							
							<!-- 主信息  Start -->
							<div id="tab-1" class="tab-pane" style="display:block">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<!-- 主信息内容 Start -->
										<div class="panel panel-primary">
											<div class="panel-heading">主信息</div>
											<div class="panel-body">
											<div class="row" style="margin-left: 10px">
											
											<!-- 10 22 - 10 22 -10 22 -->
											<!-- 第一层 -->
											<div class="form-group form-inline">                                
			                              		<label style="width:10%;">
			                              			<span></span>项目名称:</label>
			                                     	<input type="hidden" name="item_name" id="item_name" value="${pd.item_name}" /> 
			                              			<label style="width: 40%">${pd.item_name}</label> 
			                                 	<label style="width:10%;">
			                                 		<span></span>客户名称:</label>
			                                 		<input type="hidden" name="customer_name" id="customer_name" value="${pd.customer_name}" /> 
			                                 		<label style="width: 22%">${pd.customer_name}</label> 
						                    </div>
						                    <!-- 第二层 -->
						                    <div class="form-group form-inline">                                
			                              		<label style="width:10%;">
			                              			<span></span>安装地址:</label>
			                                     	<label style="width: 40%">${pd.province_name}${pd.city_name}${pd.county_name}${pd.address_info}</label> 
			                                 	<label style="width:10%;">
			                                 		<span></span>最终用户:</label>
			                                 		<label style="width: 22%">${pd.customer_name}</label> 
						                    </div>
						                    <!-- 第三层 -->
						                    <div class="form-group form-inline">                                
			                              		<label style="width:10%;">
			                              			<span><font color="red">*</font></span>合同签订日期:</label>
			                                     	<input style="width:22%" type="text" name="AZ_QDRQ" 
			                                     	id="AZ_QDRQ" value="${pd.AZ_QDRQ}"  
			                                     	placeholder="请输入合同签订日期" title="合同签订日期" class="form-control" onclick="laydate()">
			                                 	<label style="width:10%;">
			                                 		<span><font color="red">*</font></span>免保期限(年):</label>
			                                 		<input style="width:22%" type="text" name="AZ_MBQX" 
													id="AZ_MBQX" value="${pd.AZ_MBQX}"
													placeholder="请输入免保期限" title="免保期限" class="form-control" />
												<label style="width:10%;">
			                                 		<span><font color="red">*</font></span>交货方式:</label>
			                                 		<select style="width:22%" name="AZ_JHFS" id="AZ_JHFS" class="form-control">
			                                  		  <option value="">请选择交货方式</option>
			                                  		  <option value="1" ${pd.AZ_JHFS=='1'?'selected':''}>乙方代办运输</option>
			                                  		  <option value="2" ${pd.AZ_JHFS=='2'?'selected':''}>甲方自提</option>
			                                 		</select>
						                    </div>
						                    <!-- 第四层 -->
						                    <div class="form-group form-inline">                                
			                              		<label style="width:10%;display: none">
			                              			<span><font color="red">*</font></span>质保金比例%:</label>
			                                     	<input style="width:22%;display: none" type="text" name="AZ_ZBJBL"
			                                     	id="AZ_ZBJBL" value="${pd.AZ_ZBJBL}"  
			                                     	placeholder="请输入保质金比例" title="保质金比例" class="form-control">
			                                 	<label style="width:10%;">
			                                 		<span></span>联系人:</label>
			                                 		<input style="width:22%" type="text" name="AZ_LXR" 
													id="AZ_LXR" value="${pd.AZ_LXR}"
													placeholder="请输入联系人" title="联系人" class="form-control" />
												<label style="width:10%;">
			                                 		<span></span>联系电话:</label>
			                                 		<input style="width:22%" type="text" name="AZ_LXDH" 
													id="AZ_LXDH" value="${pd.AZ_LXDH}"
													placeholder="请输入联系电话" title="联系电话" class="form-control" />
												<label style="width:10%;">
													<span><font color="red">*</font></span>预计施工周期(天):</label>
												<input style="width:22%" type="text" name="AZ_YJSGZQ"
													   id="AZ_YJSGZQ" value="${pd.AZ_YJSGZQ}"
													   placeholder="请输入预计施工周期" title="预计施工周期" class="form-control">
						                    </div>
						                    <!-- 第五层 -->
						                    <div class="form-group form-inline">
												<label style="width:10%;">
													<span><font color="red">*</font></span>预计发货日期:</label>
												<input style="width:22%" type="text" name="AZ_YJFFRQ"
													   id="AZ_YJFFRQ" value="${pd.AZ_YJFFRQ}"
													   placeholder="请输入预计发货日期" title="预计发货日期" class="form-control" onclick="laydate()">
			                              		<label style="width:10%;">
			                              			<span><font color="red">*</font></span>预计开工日期:</label>
			                                     	<input style="width:22%" type="text" name="AZ_YJKGRQ" 
			                                     	id="AZ_YJKGRQ" value="${pd.AZ_YJKGRQ}"  
			                                     	placeholder="请输入预计开工日期" title="预计开工日期" class="form-control" onclick="laydate()">
												<label style="width:10%;">
													<span><font color="red">*</font></span>预计验收日期:</label>
												<input style="width:22%" type="text" name="AZ_YJYSRQ"
													   id="AZ_YJYSRQ" value="${pd.AZ_YJYSRQ}"
													   placeholder="请输入预计验收日期" title="预计验收日期" class="form-control" onclick="laydate()">
						                    </div>
											
											
											 <!-- 第五层 -->
						                    <div class="form-group form-inline">
												<label style="width:10%;">
													<span><font color="red">*</font></span>预计质保金收款日期:</label>
												<input style="width:22%" type="text" name="AZ_YJZBJRQ"
													   id="AZ_YJZBJRQ" value="${pd.AZ_YJZBJRQ}"
													   placeholder="请输入预计质保金收款日期" title="预计质保金收款日期" class="form-control" onclick="laydate()">
											</div>
											
											<div class="form-group form-inline">

												<label style="width:10%;">
													<span></span>备注:</label>
												<input style="width:55%" type="text" name="AZ_BZ"
													   id="AZ_BZ" value="${pd.AZ_BZ}"
													   placeholder="请输入备注" title="备注" class="form-control" />
											</div>
											
						                   	<!-- 第六层 -->
						                    <div class="form-group form-inline"> 
						                    <label style="width:10%;">
			                                 		<span></span>附件上传:</label>
			                                 		<input  type="hidden" name="AZ_FJSC" id="AZ_FJSC" value="${pd.AZ_FJSC}"/>
			                                 		<input style="width:20%" class="form-control" type="file" name="HtFjsc" id="HtFjsc" 
													readonly placeholder="这里输入附件" title="附件" onchange="upload(this)" />
						                    		<select style="width:10%" name="AZ_WJLX" id="AZ_WJLX" class="form-control">
				                                  		<option value="">文件类型</option>
				                                  		<option value="1" ${pd.AZ_WJLX=='1'?'selected':''}>非标合同</option>
				                                  		<option value="2" ${pd.AZ_WJLX=='2'?'selected':''}>其他</option>
			                                 		</select>
			                                 		<c:if test="${pd ne null and pd.AZ_FJSC ne null and pd.AZ_FJSC ne '' }">
													  <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
												    </c:if> 
											</div>	
										<!-- row -->		   
										</div>
									<!-- panel-body -->
									</div>
								<!-- panel panel-primary -->
								</div>
								
								<!-- 付款方式 Start -->	
								<div class="panel panel-primary">
								<!-- 头  -->
								<div class="panel-heading" style="padding-right:30px;">付款方式 </div>
								<div class="panel-body">
								<div class="form-inline" style="font-size:16px;float:left;padding-left:10px;">
									安装总金额:${pd.TOTAL}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;合同总金额:<span id="htzje">${pd.PRICE}</span>
								</div>
								<div class="form-group form-inline" style="float:right;margin-right:20px;margin-bottom:0px;">
			                      <c:if test="${msg !='view' }">
			                         <button id="fkfs_add" class="btn btn-sm btn-primary" title="添加"
										type="button" onclick="CNtadAdd();">添加
									 </button>
								  </c:if>
			             		</div>
								<div class="row" style="margin-left: 10px;margin-right: 0px;">	
									<table class="table table-striped table-bordered table-hover" id="CNTableFKFS">
										<thead>
											<tr>
												<th>收款期数</th>
												<th>款项</th>
												<th>判断日期</th>
												<th>付款天数</th>
												<th style="display: none">偏差日期</th>
												<th>付款比例(%)</th>
												<th>金额(元)</th>
												<th>备注</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<!-- 开始循环 -->
											<c:choose>
												<c:when test="${not empty dfkfslist}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${dfkfslist}" var="con" varStatus="vs">
															<tr>
																<td>${vs.index+1}</td>
																<td>
																	<select class="form-control" name='FKFS_KX'>
												                        <option value="1" ${con.FKFS_KX=='1'?'selected':''}>定金</option>
												                        <option value="5" ${con.FKFS_KX=='5'?'selected':''}>安装发货款</option>
												                        <option value="6" ${con.FKFS_KX=='6'?'selected':''}>安装开工款</option>
												                        <option value="7" ${con.FKFS_KX=='7'?'selected':''}>验收款</option>
												                        <option value="8" ${con.FKFS_KX=='8'?'selected':''}>质保金</option>
												                    </select>
																</td>
																<td>
																	<select class="form-control" name='FKFS_PDRQ'>
												                        <option value="2" ${con.FKFS_PDRQ=='2'?'selected':''}>预计发货日期</option>
												                        <option value="4" ${con.FKFS_PDRQ=='4'?'selected':''}>预计进场日期</option>
												                        <option value="5" ${con.FKFS_PDRQ=='5'?'selected':''}>预计验收日期</option>
																		<option value="1" ${con.FKFS_PDRQ=='1'?'selected':''}>合同签订日期</option>
																		<option value="6" ${con.FKFS_PDRQ=='6'?'selected':''}>免保期限</option>
												                    </select>
												                </td>
																<td>
																<input style="width:100%" type="text" name="FKFS_FKTS" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"
																	   value="${con.FKFS_FKTS}" class="form-control" />
																</td>
																<td  style="display: none">
																	<input style="width:100%" type="text" name="FKFS_PCRQ"
																	value="${con.FKFS_PCRQ}" class="form-control" />
																</td>
																<td>
																	<input style="width:100%" type="text" name="FKFS_FKBL"
																	value="${con.FKFS_FKBL}" class="form-control" oninput="setPrice(this)" />
																</td>
																<td>
																	<input style="width:100%" type="text" name="FKFS_JE"
																	value="${con.FKFS_JE}" class="form-control" />
																</td>
																<td>
																	<input style="width:100%" type="text" name="FKFS_BZ"
																	value="${con.FKFS_BZ}" class="form-control" />
																</td>
																<td>
																  <c:if test="${msg !='view' }">
																	<button class="btn btn-sm btn-danger" title="删除"
																			type="button" onclick="CNtabDel(this);">删除
																	</button>
																  </c:if>
																</td>
															</tr>
														</c:forEach>
													</c:if>
													<!-- 权限设置 -->
													<c:if test="${QX.cha == 0 }">
														<tr>
															<td colspan="100" class="center">您无权查看</td>
														</tr>
													</c:if>
												</c:when>
												<c:otherwise>
													<!-- <tr class="main_info">
														<td colspan="100" class="center">没有相关数据</td>
													</tr> -->
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								<!-- 结尾 -->
								</div>
								</div>
								</div>
								<!-- 付款方式  End -->
								
										<!-- 主信息内容 End -->
									</div>
								</div>
							</div>
							<!-- 主信息  End -->

							<!-- 电梯信息 Start -->
							<div id="tab-2" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<!-- 电梯信息内容 Start -->	
										<div class="panel panel-primary">
											<!-- 头  -->
											<div class="panel-heading" style="padding-right:30px;">电梯信息</div>
											<div class="panel-body">
											<div class="form-inline" style="font-size:16px;float:left;padding-left:10px;">
													电梯台数:${pd.DT_NUM}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;总金额:${pd.TOTAL}
											</div>
											<div class="row" style="margin-left: 10px;margin-right: 0px;">	
												<table class="table table-striped table-bordered table-hover">
													<thead>
														<tr>
															<th>序号</th>
															<th>电梯编号</th>
															<th>梯型</th>
															<th>梯号</th>
															<th>层/站/门(提升高度)</th>
															<th>安装调试费(元/台)</th>
														</tr>
													</thead>
													<tbody>
														<!-- 开始循环 -->
														<c:choose>
															<c:when test="${not empty dtxxlist}">
																<c:if test="${QX.cha == 1 }">
																	<c:forEach items="${dtxxlist}" var="con" varStatus="vs">
																		<tr>
																			<td>${vs.index+1}</td>
																			<td>${con.DT_NO}</td>
																			<td>${con.DT_TX}</td>
																			<td>${con.DT_TH}</td>
																			<td>${con.DT_CZM}</td>
																			<td>${con.DT_AZDJ}</td>
																		</tr>
																	</c:forEach>
																</c:if>
																<!-- 权限设置 -->
																<c:if test="${QX.cha == 0 }">
																	<tr>
																		<td colspan="100" class="center">您无权查看</td>
																	</tr>
																</c:if>
															</c:when>
															<c:otherwise>
																<tr class="main_info">
																	<td colspan="100" class="center">没有相关数据</td>
																</tr>
															</c:otherwise>
														</c:choose>
													</tbody>
												</table>
											<!-- 结尾 -->
											</div>
											</div>
											</div>
											<!-- 电梯信息内容 End -->
									</div>
								</div>
							</div>
							<!-- 电梯信息 End -->
							
						</div>
					</div>
					<!-- 内容层 一 End -->
			</div>
		</form>
	</div>
 </div>

<!-- Fancy box -->
<script src="static/js/fancybox/jquery.fancybox.js"></script>
<!-- iCheck -->
<script src="static/js/iCheck/icheck.min.js"></script>
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>

<script type="text/javascript">
	
	//---------------------------xcx-------------------------Start
	//页面加载完成时调用
	$(document).ready(function () {
		//关闭加载层   可能用的上
		parent.layer.closeAll('loading');
        /* tab 默认 主信息*/
        $("#nav-tab-1").addClass("active");
		$("#tab-1").addClass("active");
		
		//弹出框用，可能需要
		$(document).ready(function () {
            /* 图片 */
            $('.fancybox').fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });
        });

        if('${msg}'=='view'){
            $("input").attr("disabled","disabled");
            $("select").attr("disabled","disabled");
            $("#fileLDiv").find("button").attr("disabled","disabled");
        }
    });
	
	//切换窗口
	function CutOverTab(num){
		if(num==""||num=="1"){
			//$("#tab-1").slideToggle(2000,null)
			$("#tab-1").css("display", "block");
			$("#tab-2").css("display", "none");
        }else if(num=="2"){
        	//$("#tab-2").slideToggle(2000,null)
        	$("#tab-1").css("display", "none");
 			$("#tab-2").css("display", "block"); 
        }
	}
	
	//日期范围限制
    var start = {
        elem: '#start_time',
        format: 'YYYY/MM/DD hh:mm:ss',
        max: '2099-06-16 23:59:59', //最大日期
        istime:true,
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
    //laydate(start);
    //laydate(end);
    
    //关闭页面
    function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	};
    
    //提交
    function CNSubmin(){
    	save();
    };
    
    //预览
    function CNprview(){
    	
    };
	
	//付款方式  新增
	function CNtadAdd(){
		var trNum = $("#CNTableFKFS tr").length;
		//克隆第一行
		var tr='<tr>'+
			'<td>'+trNum+'</td>'+
			'<td>'+
			'	<select class="form-control" name='+"'"+'FKFSKX'+"'"+'>'+
            '        <option value='+"'"+'1'+"'"+'>定金</option>'+
            '        <option value='+"'"+'5'+"'"+'>安装发货款</option>'+
            '        <option value='+"'"+'6'+"'"+'>安装开工款</option>'+
            '        <option value='+"'"+'7'+"'"+'>验收款</option>'+
            '        <option value='+"'"+'8'+"'"+'>质保金</option>'+
            '    </select>'+
			'</td>'+
			'<td>'+
			'	<select class="form-control" id="" name='+"'"+'FKFS_PDRQ'+"'"+'>'+
	        '              <option value='+"'"+'1'+"'"+'>预计发货日期</option>'+
	        '              <option value='+"'"+'2'+"'"+'>预计进场日期</option>'+
	        '              <option value='+"'"+'3'+"'"+'>预计验收日期</option>'+
	        '              <option value='+"'"+'4'+"'"+'>合同签订日期</option>'+
	        '              <option value='+"'"+'5'+"'"+'>免保期限</option>'+
	        '          </select>'+
	        '      </td>'+
			'<td>'+
			'	<input style="width:100%" type="text" name="FKFS_FKTS" id="" onkeyup="this.value=this.value.replace(/\\D/g,\'\')" onafterpaste="this.value=this.value.replace(/\D/g,\'\')" '+
			'	value="" class="form-control" />'+
			'</td>'+
			'<td  style="display: none">'+
			'	<input style="width:100%" type="text" name="FKFSPCRQ" id="" '+
			'	value="" class="form-control" />'+
			'</td>'+
			'<td>'+
			'	<input style="width:100%" type="text" name="FKFS_FKBL" id="" '+
			'	value="" class="form-control" oninput="setPrice(this)" />'+
			'</td>'+
			'<td>'+
			'	<input style="width:100%" type="text" name="FKFS_JE" id="" '+
			'	value="" class="form-control" />'+
			'</td>'+
			'<td>'+
			'	<input style="width:100%" type="text" name="FKFSBZ" id="" '+
			'	value="" class="form-control" />'+
			'</td>'+
			'<td>'+
			'	<button class="btn btn-sm btn-danger" title="删除"'+
			'			type="button" onclick="CNtabDel(this);">删除'+
			'	</button>'+
			'</td>'+
		'</tr>';
		$("#CNTableFKFS").append(tr);
	};

	function setPrice(obj) {
    	$(obj).val($(obj).val().replace(/\D/g,''));
		
	    if ($(obj).val()==''){
            $(obj).parents("tr").find("[name='FKFS_JE']").val('0');
            countFKFSPrice();
		}else if(!isNaN($(obj).val())){
		    var total=$("#TOTAL").val();
		    if(total!=""&&!isNaN(total)){
		        $(obj).parents("tr").find("[name='FKFS_JE']").val(parseFloat((parseFloat(total)*(parseFloat($(obj).val())/100)).toFixed(2)));
                countFKFSPrice();
			}

		}
    }
	
	//付款方式  删除
	function CNtabDel(obj){
		 swal({
             title: "您确定要删除此条付款方式的信息吗？",
             text: "删除后将无法恢复，请谨慎操作！",
             type: "warning",
             showCancelButton: true,
             confirmButtonColor: "#DD6B55",
             confirmButtonText: "删除",
             cancelButtonText: "取消",
             closeOnConfirm: false,
             closeOnCancel: false
         },
         function (isConfirm) {
             if (isConfirm) {
            	 delTab(obj); 
            	 swal({   
			        	title: "删除成功！",
			        	text: "您已经成功删除了这条信息。",
			        	type: "success",  
			        	 }); 
             } else {
                 swal("已取消", "您取消了删除操作！", "error");
             }
         });
		
		function delTab(obj){
			$(obj).parent().parent().remove();
			//重新标记序号
			var trNum = $("#CNTableFKFS tr").length;
			for(var i=1;i<=trNum;i++){
				$("#CNTableFKFS").find("tr").eq(i).find("td").eq(0).html(i);  
			}
            countFKFSPrice();
		}
	};
    
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
		var downFile = $(e).prev().prev().prev().val();
		window.location.href = "cell/down?downFile=" + downFile;
	}
	
	//---------------------------xcx-------------------------End
   
	//保存
	function save(type) 
	{
		
		 if(type=='TJ')
		    {
		    	$("#type").val("TJ");
		    }
		    else
		    {
		    	$("#type").val("BC");
		    }
		
		if ($("#AZ_QDRQ").val() == "" && $("#AZ_QDRQ").val() == "") {
			$("#AZ_QDRQ").focus();
			$("#AZ_QDRQ").tips({
				side : 3,
				msg : "请选择合同签订日期",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
		
		if ($("#AZ_MBQX").val() == "" && $("#AZ_MBQX").val() == "") {
			$("#AZ_MBQX").focus();
			$("#AZ_MBQX").tips({
				side : 3,
				msg : "请输入免保期限",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
		if ($("#AZ_JHFS").val() == "" && $("#AZ_JHFS").val() == "") {
			$("#AZ_JHFS").focus();
			$("#AZ_JHFS").tips({
				side : 3,
				msg : "请选择交货方式",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
        if ($("#AZ_YJFFRQ").val() == "" && $("#AZ_YJFFRQ").val() == "") {
            $("#AZ_YJFFRQ").focus();
            $("#AZ_YJFFRQ").tips({
                side : 3,
                msg : "请选择预计发货日期",
                bg : '#AE81FF',
                time : 3
            });
            return false;
        }
		if ($("#AZ_YJKGRQ").val() == "" && $("#AZ_YJKGRQ").val() == "") {
			$("#AZ_YJKGRQ").focus();
			$("#AZ_YJKGRQ").tips({
				side : 3,
				msg : "请选择预计开工日期",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
        if ($("#AZ_YJYSRQ").val() == "" && $("#AZ_YJYSRQ").val() == "") {
            $("#AZ_YJYSRQ").focus();
            $("#AZ_YJYSRQ").tips({
                side : 3,
                msg : "请选择预计验收日期",
                bg : '#AE81FF',
                time : 3
            });
            return false;
        }
		if ($("#AZ_YJSGZQ").val() == "" && $("#AZ_YJSGZQ").val() == "") {
			$("#AZ_YJSGZQ").focus();
			$("#AZ_YJSGZQ").tips({
				side : 3,
				msg : "请输入预计施工周期",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
		
		if(!validateFKSF()){
			return false;
		}
		
		if(type=='TJ'){
	    	if($("#CNTableFKFS tr:not(:first)").length == 0){
	    		$("#fkfs_add").focus();
				$("#CNTableFKFS").tips({
					side : 3,
					msg : "请添加付款方式",
					bg : '#AE81FF',
					time : 3
				});
				return false;
	    	}
	    }
		
		//付款信息转为json
		var jsonFkfs="[";
		$("#CNTableFKFS tr:not(:first)").each(function()
		{
			jsonFkfs +=  "{\'FKFS_QS\':\'"+$(this).find("td").eq(0).text()+"\',"+
                "\'FKFS_KX\':\'"+$(this).find("td").eq(1).find("select").eq(0).val()+"\',"+
                "\'FKFS_PDRQ\':\'"+$(this).find("td").eq(2).find("select").eq(0).val()+"\',"+
                "\'FKFS_FKTS\':\'"+$(this).find("td").eq(3).find("input").eq(0).val()+"\',"+
                "\'FKFS_PCRQ\':\'"+$(this).find("td").eq(4).find("input").eq(0).val()+"\',"+
                "\'FKFS_FKBL\':\'"+$(this).find("td").eq(5).find("input").eq(0).val()+"\',"+
                "\'FKFS_JE\':\'"+$(this).find("td").eq(6).find("input").eq(0).val()+"\',"+
                "\'FKFS_BZ\':\'"+$(this).find("td").eq(7).find("input").eq(0).val()+"\'},";
			
		});
        jsonFkfs = (jsonFkfs.length>1?jsonFkfs.substring(0,jsonFkfs.length-1): jsonFkfs)+"]";
		$("#jsonFkfs").val(jsonFkfs);
		
		$("#ContractNewAzForm").submit();
	}
	
	function countFKFSPrice() {
		var zprice=0;
		$("[name='FKFS_JE']").each(function(idx){
			zprice+=isNaN(parseFloat($(this).val()))?0:parseFloat($(this).val());
		});
		$("#PRICE").val(parseFloat(zprice.toFixed(2)));
		$("#htzje").html(parseFloat(zprice.toFixed(2)));
    }
	
	function validateFKSF() {
    	var iss = true;
    	$('input[name="FKFS_FKTS"]').each(function(i) {
			if($(this).val() == ''){
				$(this).focus() 
				$(this).tips({
	                side : 3,
	                msg : "请输入付款天数",
	                bg : '#AE81FF',
	                time : 3
	            });
				iss = false;
				return false;
			}
    		
			var FKFSFKBL = $("#CNTableFKFS tr").eq(i+1).find("td").eq(5).find("input");
			if(FKFSFKBL.length > 0 && (FKFSFKBL.val() == '' || FKFSFKBL.val() == '0')){
				FKFSFKBL.focus();
				var mss = '请输入付款比例';
				if(FKFSFKBL.val() == '0'){
					mss = '付款比例不能为0';
				}
				FKFSFKBL.tips({
	                side : 3,
	                msg : mss,
	                bg : '#AE81FF',
	                time : 3
	            });

				iss = false;
				return false;
			}
			
		});
    	return iss;
	}

</script>

</body>
</html>
