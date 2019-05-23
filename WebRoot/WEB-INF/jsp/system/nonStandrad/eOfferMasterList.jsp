<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div id="zhjView" class="animated fadeIn"></div>
		<div id="ImportExcel" class="animated fadeIn"></div>
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div id="top" ,name="top"></div>
						<form role="form" class="form-inline" action="nonStandrad/eOfferStandradList.do" method="post" name="shopForm" id="shopForm">
							<input type="hidden" name="MODELS_ID" value="${pd.MODELS_ID}">
							<input type="hidden" name="item_id" value="${pd.item_id}">
							<input type="hidden" name="tz_" value="${pd.tz_}">
							<input type="hidden" name="BZ_ZZ" value="${pd.BZ_ZZ}">
							<input type="hidden" name="BZ_SD" value="${pd.BZ_SD}">
							<input type="hidden" name="BZ_KMXS" value="${pd.BZ_KMXS}">
							<input type="hidden" name="BZ_C" value="${pd.BZ_C}">
							<input type="hidden" name="BZ_Z" value="${pd.BZ_Z}">
							<input type="hidden" name="BZ_M" value="${pd.BZ_M}">
							<input type="hidden" name="BZ_KMKD" value="${pd.BZ_KMKD}">
							<input type="hidden" name="BZ_QXJD" value="${pd.BZ_QXJD}">
							<input type="hidden" name="BZ_TJKD" value="${pd.BZ_TJKD}">
							<input type="hidden" name="BZ_SPTJ" value="${pd.BZ_SPTJ}">
							<input type="hidden" name="BZ_TSGD" value="${pd.BZ_TSGD}">
							<div class="form-group ">
								<input class="form-control" type="text" id="nav-search-input"
									type="text" name="item_name" value="${pd.item_name}"
									placeholder="项目名称">
							</div>
							<div class="form-group ">
								<input class="form-control" id="nav-search-input" type="text"
									   name="subsidiary_company" value="${pd.subsidiary_company}" style="margin-left:5px;"
									   placeholder="分公司">
							</div>
							<div class="form-group ">
								<input class="form-control" id="nav-search-input" type="text"
									name="user_name" value="${pd.user_name}" style="margin-left:5px;"
									placeholder="申请人">
							</div>
							<div class="form-group ">
								<input class="form-control" id="nav-search-input" type="text"
									   name="operate_date" value="${pd.operate_date}" style="margin-left:5px;"
                                       onclick="laydate()"
									   placeholder="申请日期">
							</div>
							<div class="form-group">
								<button type="submit" class="btn  btn-primary" title="查询" 
								style="margin-left: 10px; height:32px;margin-top:3px;">查询</button>
								<c:if test="${QX.del == 1 }">
								 <button class="btn  btn-success" title="选择返回" style="margin-left:10px;margin-top: 4px;" type="button"
										onclick="makeAll('sel');">选择返回</button>
							   </c:if>
							</div>
							<button class="btn  btn-success" title="刷新" type="button"
								style="float: right;margin-top: 4px;" onclick="refreshCurrentTab();">刷新
							</button>
						</form>
						<form role="form" class="form-inline" action="houseType/cell.do" method="post" name="houseType" id="houseType">
						  <input type="hidden" id="houses_no" name="houses_no" value="${pd.houses_no}"/>
						  <input type="hidden" id="hou_id" name="hou_id" value="${pd.hou_id}"/>
						</form>
						<div class="row">
							</br>
						</div>
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th><input type="checkbox" name="zcheckbox"
											id="zcheckbox" class="i-checks"></th>
										<th style="text-align:center;">单号</th>
										<th style="text-align:center;">项目名称</th>
										<th style="text-align:center;">梯型</th>
										<!--<th style="text-align:center;">台数</th>-->
										<th style="text-align:center;">价格</th>
										<th style="text-align:center;">申请人</th>
										<th style="text-align:center;">申请日期</th>
										<th style="text-align:center;">分公司</th>
										<th style="text-align:center;">区域</th>
										<th style="text-align:center;">审核状态</th>
										<th style="text-align:center;">操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty nonstandradList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${nonstandradList}" var="e" varStatus="vs">

													<tr>
														<td class='center' style="width: 30px;">
														<label>
														<input
																class="i-checks" type='checkbox' name='ids'
																value="${e.non_standrad_id}" id="${e.non_standrad_id}"
																alt="${e.non_standrad_id}" />
																<span class="lbl"></span>
																</label>
																</td>
														
														<td style="text-align:center;"> ${e.non_standrad_id}</td>
														<td style="text-align:center;">${e.project_name	}</td>
														<td style="text-align:center;">${e.lift_name}</td>
														<!--<td style="text-align:center;">${e.lift_num}</td>-->
														<td style="text-align:center;">${e.nonstand_price}</td>
														<td style="text-align:center;">${e.operate_name}</td>
														<td style="text-align:center;">${e.operate_date}</td>
														<td style="text-align:center;">${e.subsidiary_company}</td>
														<td style="text-align:center;">${e.project_area}</td>
														<td style="text-align:center;">
														    ${e.instance_status=="1"?"待启动":""}
														    ${e.instance_status=="2"?"待审核":""}
														    ${e.instance_status=="3"?"审核中":""}
														    ${e.instance_status=="4"?"已通过":""}
														    ${e.instance_status=="5"?"被驳回":""}
														    ${e.instance_status=="6"?"已通过":""}
														</td>
														<td style="text-align:center;">
														    <c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in">
																<i class="icon-lock" title="无权限">无权限</i></span>
															</c:if> 
															<%-- <!-- cod打印 -->
															<button class="btn  btn-info btn-sm" title="打印" type="button" onclick="DaYin('${e.item_id}');">打印</button> --%>

                                                            <c:if test="${QX.edit == 1 }">
                                                                <button class="btn btn-sm btn-info btn-sm" title="查看" type="button" onclick="edit('${e.non_standrad_id}','sel');">查看</button>
                                                            </c:if>
															<!-- 1.待启动 -->
															<c:if test="${e.instance_status == 1 }">
																<c:if test="${QX.edit == 1 }">
																	<button class="btn  btn-primary btn-sm" title="编辑"
																		type="button" onclick="edit('${e.non_standrad_id}','edit');">编辑
																	</button>
																	<button class="btn  btn-danger btn-sm" title="删除"
																			type="button" onclick="delE_offer('${e.non_standrad_id}');">删除
																	</button>
																</c:if> 
																<button class="btn  btn-warning btn-sm" title="启动流程"
																	type="button" onclick="startLeave('${e.non_standrad_id}','${e.instance_id}')">启动
																</button>
															</c:if>
															<!-- 2.待审核 3.审核中 -->
															<c:if test="${e.instance_status == 2 || e.instance_status == 3 }">
																<button class="btn  btn-info btn-sm" title="审核记录" type="button" onclick="viewHistory('${e.instance_id}');">审核记录</button>
															</c:if>
															<!-- 5.被驳回 -->
															<c:if test="${e.instance_status == 5}">
																<button class="btn  btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('${e.instance_id}');">审核记录</button>
																<button class="btn  btn-warning btn-sm" title="重新申请" type="button" onclick="restartAgent('${e.task_id }','${e.offer_id}');">重新提交</button>
																<!-- <button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="">编辑</button> -->
															</c:if>
															<!-- 4.已通过 -->
															<c:if test="${e.instance_status == 4}">
																<button class="btn  btn-info btn-sm" title="历史记录" type="button" onclick="viewHistory('${e.instance_id}');">审核记录</button>
																
															</c:if>
															
															<!-- 6.已通过 -->
															<c:if test="${e.instance_status == 6}">
															
															</c:if>
															
													 </td>
													</tr>

												</c:forEach>
											</c:if>

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
							<div class="col-lg-12" style="padding-left: 0px; padding-right: 0px">
								${page.pageStr}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--返回顶部开始-->
	<div id="back-to-top">
		<a class="btn btn-warning btn-back-to-top"
			href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
			<i class="fa fa-chevron-up"></i>
		</a>
	</div>
	<!--返回顶部结束-->
	<!-- Fancy box -->
	<script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
	<script src="static/js/iCheck/icheck.min.js"></script>
	<!-- Sweet alert -->
	<script src="static/js/sweetalert/sweetalert.min.js"></script>
	<script type="text/javascript">

    $(document).ready(function () {
		//loading end
		parent.layer.closeAll('loading');
        /* checkbox */
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });
    });
    /* checkbox全选 */
    $("#zcheckbox").on('ifChecked', function (event) {
        $('input').iCheck('check');
    });
    /* checkbox取消全选 */
    $("#zcheckbox").on('ifUnchecked', function (event) {
        $('input').iCheck('uncheck');
    });
    //刷新iframe
    function refreshCurrentTab() {
        $("#shopForm").submit();
    }
   

    //检索
    function search() {
        $("#shopForm").submit();
    }
    //批量操作
    function makeAll(msg) {
        var str = '';
        var emstr = '';
        var phones = '';
        $("[name='ids']:checked").each(function(index){
            if(index==0){
                str=str+$(this).val();
            }else {
                str =str+ ","+$(this).val();
            }
        });
        console.log(str);
        if (str == '') {
            swal({
                title: "您未选择任何数据",
                text: "请选择你需要操作的数据！",
                type: "error",
                showCancelButton: false,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "OK",
                closeOnConfirm: true,
                timer: 1500
            });
        } else {
            $.ajax({
                type: "POST",
                url: '<%=basePath%>nonStandrad/selNonstandradToBJC.do',
                data: {ids: str},
                dataType: 'json',
                cache: false,
                success: function (data) {
                    var rehtml='';
                    for(var i=0;i<data.length;i++){
                    	if(data[i].nonstandrad_valid == '1'){
                    		rehtml+='<tr>' +
	                            '<td style="width:5%;text-align: center;"></td>' +
	                            '<td style="text-align: center;"><span class="fblx">'+window.parent.setfblx(data[i].nonstandrad_spec)+'</span></td>' +
	                            '<td><input type="hidden" name="master_id" value="'+data[i].master_id+'"/><input type="text" class="form-control" name="nonstandrad_describe" readonly="readonly" value="'+data[i].nonstandrad_describe+'"></td>' +
	                            '<td><input type="text" class="form-control" name="nonstandrad_handle" readonly="readonly" value="'+data[i].nonstandrad_handle+'"></td>' +
	                            '<td style="display: none"><input type="text" class="form-control" name="nonstandrad_price" readonly="readonly" value="'+data[i].nonstandrad_price+'"></td>' +
	                            '<td><input type="text" class="form-control" name="nonstandrad_DTBJ" readonly="readonly" value="'+data[i].nonstandrad_DTBJ+'"></td>' +
	                            '<td><input type="text" class="form-control" name="nonstandrad_ZJ" readonly="readonly" value=""></td>' +
	                            '<td style="display: none"><input type="text" class="form-control" name="nonstandrad_sprice" value=""  oninput="setFBPrice();"></td>' +
	                            '<td><span class="iskdz">'+(data[i].nonstandrad_KDZ=="1"?'是':(data[i].nonstandrad_KDZ=="2"?'否':''))+'</span></td>' +
	                            '<td><textarea name="nonstandrad_BZ" class="form-control" rows="1" cols="15" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly" >'+data[i].nonstandrad_BZ+'</textarea></td>' +
	                            '<td><input type="button" value="删除" onclick="delFbRow(this);"></td>' +
	                            '</tr>'
                    	}
                    }

                    window.parent.$("#fbbody").append(rehtml);
                    
                    js_xh();
                    js_zj();

                    window.parent.countFBPrice();
                    window.parent.iaHasFB();
                    window.parent.updateFbX();
                    window.parent.$("#zhjView").data("kendoWindow").close();
                }
            });

        }
    }
    
    function js_zj(){
    	var trs = window.parent.$("#fbbody tr");
    	var dtbj = 0;
    	var zj = 0;
    	var zj_kdz = 0;
    	var zj_bkdz = 0;
        var sl = window.parent.getEleNum();
    	//var xj = 0;
		for (var i = 0; i < trs.length; i++) {
			var _dtbj = trs.eq(i).find("td input[name='nonstandrad_DTBJ']").val();
			//var _xj = trs.eq(i).find("td input[name='nonstandrad_sprice']").val();
			var _kdz = trs.eq(i).find("td .iskdz").html();
			if(_dtbj =='' || isNaN(_dtbj)) _dtbj = 0;
			//if(_xj =='' || isNaN(_xj)) _xj = 0;
			var _zj = window.parent.round(parseFloat(_dtbj) * sl, -1);
			
			dtbj += parseFloat(_dtbj);
			zj += parseFloat(_zj);
			//xj += parseFloat(_xj);
			
			trs.eq(i).find("td input[name='nonstandrad_ZJ']").val(_zj);
			if(_kdz == "是"){
				zj_kdz += parseFloat(_zj);
			} else if(_kdz == "否"){
				zj_bkdz += parseFloat(_zj);
			}
		}
		window.parent.$("#fbhj_dtbj").html(numberFixed(dtbj));
		window.parent.$("#fbhj_zj").html(numberFixed(zj));
		//window.parent.$("#fbhj_xj").html(xj);

		window.parent.$("#zj_kdz").html(numberFixed(zj_kdz));
		window.parent.$("#zj_bkdz").html(numberFixed(zj_bkdz));
    }
    
	function js_xh(){
		var trs = window.parent.$("#fbbody tr");
		for (var i = 0; i < trs.length; i++) {
			trs.eq(i).find("td:first").html(i+1);
		}
    }
	
	function numberFixed(value) {
		  var valueStr = value.toString()
		  if (valueStr.indexOf('.') !== -1 && valueStr.split('.')[1].length > 1) {
		    return value.toFixed(1)
		  } else {
		    return value
		  }  
		}

	//审核记录
	 function viewHistory(instance_id){
		 $("#EditShops").kendoWindow({
			 width: "900px",
			 height: "500px",
			 title: "查看历史记录",
			 actions: ["Close"],
			 content: '<%=basePath%>workflow/goViewHistory.do?pid='+instance_id,
			 modal : true,
			 visible : false,
			 resizable : true
		 }).data("kendoWindow").center().open();
	 }

    /* back to top */
    function setWindowScrollTop(win, topHeight) {
        if (win.document.documentElement) {
            win.document.documentElement.scrollTop = topHeight;
        }
        if (win.document.body) {
            win.document.body.scrollTop = topHeight;
        }
    }


    //修改/查看
    function edit(id,operateType){
        $("#zhjView").kendoWindow({
            width: "1000px",
            height: "800px",
            title: "编辑非标信息",
            actions: ["Close"],
            content: '<%=basePath%>nonStandrad/preEditNonStandrad.do?non_standrad_id='+id+'&operateType='+operateType,
            modal : true,
            visible : false,
            resizable : true
        }).data("kendoWindow").maximize().open();
    }
</script>
</body>
</html>


