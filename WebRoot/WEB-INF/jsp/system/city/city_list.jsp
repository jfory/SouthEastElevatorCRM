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
	<link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div id="EditProvince" class="animated fadeIn"></div>
        <div id="AddProvince" class="animated fadeIn"></div>
		<div id="EditCity" class="animated fadeIn"></div>
        <div id="AddCity" class="animated fadeIn"></div>
        <div id="EditCounty" class="animated fadeIn"></div>
        <div id="AddCounty" class="animated fadeIn"></div>
        <div id="addcitydept" class="animated fadeIn"></div>
        <div id="editcitydept" class="animated fadeIn"></div>
	        <div class="row">
				<div class="panel blank-panel">
					<div class="panel-heading">
						<div class="panel-options">
							<ul class="nav nav-tabs">
								<li id="nav-tab-1" >
									<a data-toggle="tab" href="#tab-1" onclick="tabChange(1)">
										<i class="fa fa-hourglass-o"></i>
										省份管理
									</a>
								</li>
								<li id="nav-tab-2">
									<a class="count-info-sm" data-toggle="tab" href="#tab-2" onclick="tabChange(2)">
										<i class="fa fa-hourglass-2"></i>
										城市管理
										
									</a>
								</li>
								<li id="nav-tab-3">
									<a data-toggle="tab" href="#tab-3" onclick="tabChange(3)">
										<i class="fa fa-hourglass"></i>
										区县管理
									</a>
								</li>
								<li id="nav-tab-4">
									<a data-toggle="tab" href="#tab-4" onclick="tabChange(4)">
										<i class="fa fa-hourglass"></i>
										公司管辖区域
									</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="panel-body">
						<div class="tab-content">
							<div id="tab-1" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<div id="top1" name="top1"></div>
										<form role="form" class="form-inline" action="city/provinceList.do" method="post" name="leaveForm1" id="leaveForm1">
											<div class="form-group ">
	                                			<input type="text" name="province_name" value="${province_name}" placeholder="这里输入省份名称" class="form-control">
	                            			</div>
	                            			<div class="form-group">
	                                 			<button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            			</div>
											<button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab(1);">刷新</button>

										</form>
										<div class="row">
											</br>
										</div>
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover">
												<thead>
												<tr>
													<th style="width:2%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
													<th style="width:5%;">序号</th>
													<th style="width:25%;">省份名称</th>
													<th >操作</th>
												</tr>
												</thead>
												<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty provinceList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${provinceList}" var="province" varStatus="vs1">
																<tr>
																	<td><input type="checkbox"  class="i-checks" name='ids' id='ids' value="${province.id}"></td>
																	<td class='center' style="width: 30px;">${vs1.index+1}</td>
																	<td>${province.name }</td>
																	<td>
																	  <button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editProvince('${province.id }');">编辑</button>
																	  <button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delProvince('${province.id }');">删除</button>
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
															<td colspan="100" class="center" >没有相关数据</td>
														</tr>
													</c:otherwise>
												</c:choose>
												</tbody>
											</table>
										</div>
										</br>
										<div class="col-lg-12" style="padding-left:0px;padding-right:0px;margin:10px -10px 10px -10px">
											<c:if test="${QX.add == 1 }">
												<button class="btn  btn-primary" title="新增" type="button" onclick="addProvince();">新增</button>
											</c:if>
											<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>city/toExcel.do?type=1">导出</a>
											<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile(1)">导入</button>
											<input style="display: none" class="form-control" type="file"  title="导入" id="provinceImportFile" onchange="importExcel(this,1)"/>
											<%--<c:if test="${QX.del == 1 }">--%>
												<%--<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>--%>
											<%--</c:if>--%>
											<button class="btn  btn-success" title="下载数据模板" type="button" onclick="downFile1()">下载模板</button>
											${page.pageStrForActiviti}
										</div>
									</div>
								</div>
							</div>
							<!-- 城市 -->
							<div id="tab-2" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<div id="top2"name="top2"></div>
										<form role="form" class="form-inline" action="city/cityList.do" method="post" name="leaveForm2" id="leaveForm2">
											<div class="form-group ">
	                                			<input type="text" name="city_name" value="${city_name}" placeholder="这里输入城市名称" class="form-control">
	                            			</div>
	                            			<div class="form-group">
	                                 			<button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            			</div>
											<button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab(2);">刷新</button>

										</form>
										<div class="row">
											</br>
										</div>
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover">
												<thead>
												<tr>
													<th style="width:2%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
													<th style="width:5%;">序号</th>
													<th style="width:25%;">城市名称</th>
													
													
													<th >操作</th>
												</tr>
												</thead>
												<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty cityList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${cityList}" var="city" varStatus="vs2">
																<tr>
																	<td><input type="checkbox"  class="i-checks" name='ids' id='ids' value="${city.id}"></td>
																	<td class='center' style="width: 30px;">${vs2.index+1}</td>
																	<td>${city.name }</td>
																	<td>
																		<button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editCity('${city.id }');">编辑</button>
																		<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delCity('${city.id }');">删除</button>
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
															<td colspan="100" class="center" >没有相关数据</td>
														</tr>
													</c:otherwise>
												</c:choose>
												</tbody>
											</table>
										</div>
										</br>
										<div class="col-lg-12" style="padding-left:0px;padding-right:0px;margin:10px -10px 10px -10px">
											<c:if test="${QX.add == 1 }">
												<button class="btn  btn-primary" title="新增" type="button" onclick="addCity();">新增</button>
											</c:if>
											<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>city/toExcel.do?type=2">导出</a>
											<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile(2)">导入</button>
											<input style="display: none" class="form-control" type="file"  title="导入" id="cityImportFile" onchange="importExcel(this,2)"/>
											<button class="btn  btn-success" title="下载数据模板" type="button" onclick="downFile2()">下载模板</button>
											${page.pageStrForActiviti}
										</div>
									</div>
								</div>
							</div>
							<%--区县--%>
							<div id="tab-3" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<div id="top3" name="top3"></div>
										<form role="form" class="form-inline" action="city/countyList.do" method="post" name="leaveForm3" id="leaveForm3">
											<div class="form-group ">
	                                			<input type="text" name="county_name" value="${county_name}" placeholder="这里输入区域名称" class="form-control">
	                            			</div>
	                            			<div class="form-group">
	                                 			<button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            			</div>
											<button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab(3);">刷新</button>

										</form>
										<div class="row">
											</br>
										</div>
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover">
												<thead>
												<tr>
													
													<th style="width:2%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
													<th style="width:5%;">序号</th>
													<th style="width:25%;">区域名称</th>
													
													<th >操作</th>
												</tr>
												</thead>
												<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty countyList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${countyList}" var="county" varStatus="vs3">
																<tr>
																	<td><input type="checkbox"  class="i-checks" name='ids' id='ids' value="${city.id}"></td>
																	<td class='center' style="width: 30px;">${vs3.index+1}</td>
																	<td>${county.name }</td>
																	<td>
																		<button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editCounty('${county.id }');">编辑</button>
																		<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delCounty('${county.id }');">删除</button>
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
															<td colspan="100" class="center" >没有相关数据</td>
														</tr>
													</c:otherwise>
												</c:choose>
												</tbody>
											</table>
										</div>
										</br>
										<div class="col-lg-12" style="padding-left:0px;padding-right:0px;margin:10px -10px 10px -10px;">
											<c:if test="${QX.add == 1 }">
												<button class="btn  btn-primary" title="新增" type="button" onclick="addCounty();">新增</button>
											</c:if>
											<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>city/toExcel.do?type=3">导出</a>
											<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile(3)">导入</button>
											<input style="display: none" class="form-control" type="file"  title="导入" id="countyImportFile" onchange="importExcel(this,3)"/>
											<button class="btn  btn-success" title="下载数据模板" type="button" onclick="downFile3()">下载模板</button>
											${page.pageStrForActiviti}
										</div>
									</div>
								</div>
							</div>
							
							<%--城市公司--%>
							<div id="tab-4" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<div id="top4" name="top4"></div>
										<form role="form" class="form-inline" action="city/cityitemsubbranchList.do" method="post" name="leaveForm4" id="leaveForm4">
											<div class="form-group ">
	                                			<input type="text" id="departmentname" name="departmentname" value="${departmentname}" placeholder="这里输入公司名称" class="form-control">
	                            			</div>
	                            			<div class="form-group">
	                                 			<button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            			</div>
											<button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab(4);">刷新</button>

										</form>
										<div class="row">
											</br>
										</div>
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover">
												<thead>
												<tr>
													
													<th style="width:2%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
													<th style="width:5%;">序号</th>
													<th style="width:25%;">公司名称</th>
													<th style="width:25%;">城市名称</th>
													
													<th >操作</th>
												</tr>
												</thead>
												<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty cityDeptList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${cityDeptList}" var="cityDept" varStatus="vs4">
																<tr>
																	<td><input type="checkbox"  class="i-checks" name='ids' id='ids' value="${city.id}"></td>
																	<td class='center' style="width: 30px;">${vs4.index+1}</td>
																	<td>${cityDept.departmentname }</td>
																	<td>${cityDept.cityname }</td>
																	
																	<td>
																		<button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editcitydept('${cityDept.itemsubbranch }');">编辑</button> 
																		<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delcitydept('${cityDept.id }');">删除</button>
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
															<td colspan="100" class="center" >没有相关数据</td>
														</tr>
													</c:otherwise>
												</c:choose>
												</tbody>
											</table>
										</div>
										</br>
										<div class="col-lg-12" style="padding-left:0px;padding-right:0px;margin:10px -10px 10px -10px;">
											<c:if test="${QX.add == 1 }">
												<button class="btn  btn-primary" title="新增" type="button" onclick="addcitydept();">新增</button>
											</c:if>
									<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="" id="outFile">导出</a>
									<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile(4)">导入</button>
									<input style="display: none" class="form-control" type="file"  title="导入" id="citydeptImportFile" onchange="importExcel(this,4)"/>
									<button class="btn  btn-success" title="下载数据模板" type="button" onclick="downFile4()">下载模板</button> 
									<%-- 	<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>city/toExcel.do?type=3">导出</a>
											<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile(3)">导入</button>
											--%>
											${page.pageStrForActiviti}
										</div>
									</div>
								</div>
							</div>
							
							
							
						</div>
					</div>
				</div>
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">

	                </div>
	            </div>
	        </div>
	    </div>
	    <!--返回顶部开始-->
        <div id="back-to-top">
            <a class="btn btn-warning btn-back-to-top" href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
                <i class="fa fa-chevron-up"></i>
            </a>
        </div>
        <!--返回顶部结束-->
	<!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <!-- Sweet alert -->
	<script src="static/js/sweetalert2/sweetalert2.js"></script>
    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
    
	<script type="text/javascript">
	 $(document).ready(function () {
		 //loading end
		 parent.layer.closeAll('loading');
		 //本页面点击
		 layer.closeAll('loading');
     	/* checkbox */
         $('.i-checks').iCheck({
             checkboxClass: 'icheckbox_square-green',
             radioClass: 'iradio_square-green',
         });
     });

	 //设置tab显示
	 var isActive1 = "${pd.isActive1}";
	 var isActive2 = "${pd.isActive2}";
	 var isActive3 = "${pd.isActive3}";
	 var isActive4 = "${pd.isActive4}";
	 if(isActive1=="1"){
		 $("#nav-tab-1").addClass("active");
		 $("#tab-1").addClass("active");
	 }else if(isActive2=="1"){
		 $("#nav-tab-2").addClass("active");
		 $("#tab-2").addClass("active");
	 }else if(isActive3=="1"){
		 $("#nav-tab-3").addClass("active");
		 $("#tab-3").addClass("active");
	 }else if(isActive4=="1"){
		 $("#nav-tab-4").addClass("active");
		 $("#tab-4").addClass("active");
	 }
	 //tab切换
	 function tabChange(id){
		 //loading
		 layer.load(1);
		$("#leaveForm"+id).submit();

	 }
     /* checkbox全选 */
     $("#zcheckbox").on('ifChecked', function(event){
     	$('input').iCheck('check');
   	});
     /* checkbox取消全选 */
     $("#zcheckbox").on('ifUnchecked', function(event){
     	
     	$('input').iCheck('uncheck');
   	});
    
    	//刷新iframe
        function refreshCurrentTab(id) {
			//loading
			layer.load(1);
        	$("#leaveForm"+id).submit();
        }
		//检索
		function search(id){
			//loading
			layer.load(1);
			$("#leaveForm"+id).submit();
		}
		
		//新增省份
		function addProvince(){
			$("#AddProvince").kendoWindow({
		        width: "500px",
		        height: "500px",
		        title: "新增省份",
		        actions: ["Close"],
		        content: '<%=basePath%>city/goAddProvince.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		 //编辑省份
		 function editProvince(id){
			 $("#EditProvince").kendoWindow({
				 width: "500px",
				 height: "500px",
				 title: "编辑",
				 actions: ["Close"],
				 content: '<%=basePath%>city/goEditProvince.do?province_id='+id+"&tm="+new Date().getTime(),
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").center().open();
		 }
		
		//删除省份
		function delProvince(id){
            swal({
                    title: "您确定要删除这条记录吗？",
                    text: "删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    cancelButtonText: "取消",
                    closeOnConfirm: false,
                    closeOnCancel: false
                }).then(function (isConfirm) {
				if (isConfirm===true) {
					var url = "<%=basePath%>city/delProvince.do?province_id="+id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if(data.msg=='success'){
							swal({
										title: "删除成功！",
										text: "您已经成功删除了这条数据。",
										type: "success",
									}).then(function(){
								refreshCurrentTab(1);
							});
						}else{
							swal("删除失败", data.err, "error");
						}
					});
				}  else if (isConfirm === false) {
					swal("已取消", "您取消了删除操作！", "error");
				}
			});
		}
		
		//新增城市 
		function addCity(){
			$("#AddCity").kendoWindow({
		        width: "500px",
		        height: "500px",
		        title: "新增城市",
		        actions: ["Close"],
		        content: '<%=basePath%>city/goAddCity.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		 //编辑城市 
		 function editCity(id){
			 $("#EditCity").kendoWindow({
				 width: "500px",
				 height: "500px",
				 title: "编辑城市",
				 actions: ["Close"],
				 content: '<%=basePath%>city/goEditCity.do?city_id='+id+"&tm="+new Date().getTime(),
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").center().open();
		 }
		
		//删除城市 
		function delCity(id){
            swal({
                    title: "您确定要删除这条记录吗？",
                    text: "删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    cancelButtonText: "取消",
                    closeOnConfirm: false,
                    closeOnCancel: false
                }).then(function (isConfirm) {
				if (isConfirm===true) {
					var url = "<%=basePath%>city/delCity.do?city_id="+id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if(data.msg=='success'){
							swal({
										title: "删除成功！",
										text: "您已经成功删除了这条数据。",
										type: "success",
									}).then(function(){
								refreshCurrentTab(2);
							});
						}else{
							swal("删除失败", data.err, "error");
						}
					});
				}  else if (isConfirm === false) {
					swal("已取消", "您取消了删除操作！", "error");
				}
			});
		}
		
		
		//新增区县
		function addCounty(){
			$("#AddCounty").kendoWindow({
		        width: "500px",
		        height: "500px",
		        title: "新增区县",
		        actions: ["Close"],
		        content: '<%=basePath%>city/goAddCounty.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		
		 //新增城市公司addcitydept
		function addcitydept(){
			$("#addcitydept").kendoWindow({
		        width: "500px",
		        height: "300px",
		        title: "新增公司管辖区域",
		        actions: ["Close"],
		        content: '<%=basePath%>city/goAddcitydept.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		 
		//删除公司城市的对应关系
		function delcitydept(id){
            swal({
                    title: "您确定要删除这条记录吗？",
                    text: "删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    cancelButtonText: "取消",
                    closeOnConfirm: false,
                    closeOnCancel: false
                }).then(function (isConfirm) {
				if (isConfirm===true) {
					var url = "<%=basePath%>city/delcitydept.do?county_id="+id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if(data.msg=='success'){
							swal({
										title: "删除成功！",
										text: "您已经成功删除了这条数据。",
										type: "success",
									}).then(function(){
								refreshCurrentTab(4);
							});
						}else{
							swal("删除失败", data.err, "error");
						}
					});
				}  else if (isConfirm === false) {
					swal("已取消", "您取消了删除操作！", "error");
				}
			});
		}
		
		//编辑公司管辖区域
		function editcitydept(id){
			 $("#editcitydept").kendoWindow({
				 width: "500px",
				 height: "500px",
				 title: "编辑管辖区域",
				 actions: ["Close"],
				 content: '<%=basePath%>city/goEditcitydept.do?id='+id+"&tm="+new Date().getTime(),
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").center().open();
		 }
		
		 //编辑区县
		 function editCounty(id){
			 $("#EditCounty").kendoWindow({
				 width: "500px",
				 height: "500px",
				 title: "编辑区县",
				 actions: ["Close"],
				 content: '<%=basePath%>city/goEditCounty.do?county_id='+id+"&tm="+new Date().getTime(),
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").center().open();
		 }
		
		//删除区县
		function delCounty(id){
            swal({
                    title: "您确定要删除这条记录吗？",
                    text: "删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    cancelButtonText: "取消",
                    closeOnConfirm: false,
                    closeOnCancel: false
                }).then(function (isConfirm) {
				if (isConfirm===true) {
					var url = "<%=basePath%>city/delCounty.do?county_id="+id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if(data.msg=='success'){
							swal({
										title: "删除成功！",
										text: "您已经成功删除了这条数据。",
										type: "success",
									}).then(function(){
								refreshCurrentTab(3);
							});
						}else{
							swal("删除失败", data.err, "error");
						}
					});
				}  else if (isConfirm === false) {
					swal("已取消", "您取消了删除操作！", "error");
				}
			});
		}
		
		//批量操作
		function makeAll(){
			var str = '';
			var emstr = '';
			var phones = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				  if(document.getElementsByName('ids')[i].checked){
				  	if(str=='') str += document.getElementsByName('ids')[i].value;
				  	else str += ',' + document.getElementsByName('ids')[i].value;
				  }
			}
			if(str==''){
				swal({
	                title: "您未选择任何数据",
	                text: "请选择你需要操作的数据！",
	                type: "error",
	                showCancelButton: false,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "OK",
	                closeOnConfirm: true,
	                timer:1500
	            });
			}else{
				swal({
	                title: "您确定要删除选中的数据吗？",
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
	                	$.ajax({
							type: "POST",
							url: '<%=basePath%>workflow/leave/delAllLeaves.do',
					    	data: {leave_ids:str},
							dataType:'json',
							cache: false,
							success: function(data){
								if(data.msg=='success'){
									swal({   
	        				        	title: "删除成功！",
	        				        	text: "您已经成功删除了这些数据。",
	        				        	type: "success",  
	        				        	 }, 
	        				        	function(){   
	        				        		 refreshCurrentTab(); 
	        				        	 });
		    					}else{
		    						swal("删除失败", data.err, "error");
		    					}
								
							}
						});
	                } else {
	                    swal("已取消", "您取消了删除操作！", "error");
	                }
	            });
			}
		}
		
		
		//导出到Excel
		function toExcel(){
			$.post("<%=basePath%>sysAgent/toExcel.do");
		}

		//选择导入文件
		function inputFile(type){
			if(type == 1){
				$("#provinceImportFile").click();
			}else if(type == 2){
				$("#cityImportFile").click();
			}else if(type == 3){
				$("#countyImportFile").click();	
			}else if(type == 4){
				$("#citydeptImportFile").click();	
			}
		}

		//导入Excel
		function importExcel(e,type){
	    	var filePath = $(e).val();
	    	console.log(filePath);
	    	var suffix = filePath.substring(filePath.lastIndexOf(".")).toLowerCase();
	    	var fileType = ".xls|.xlsx|";
	    	if(filePath == null || filePath == ""){
	            return false;
	        }
	        if(fileType.indexOf(suffix+"|")==-1){
	            var ErrMsg = "该文件类型不允许上传。请上传 "+fileType+" 类型的文件，当前文件类型为"+suffix; 
	            $(e).val("");
	            alert(ErrMsg);
	            return false;
	        }
	        var data = new FormData();
	    	data.append("file", $(e)[0].files[0]);
	    	console.log($(e)[0].files[0]);
	    	$.ajax({
	            url:"<%=basePath%>city/importExcel.do?type="+type,
	            type:"POST",
	            data:data,
	            cache: false,
	            processData:false,
	            contentType:false,
	            success:function(result){
	                if(result.msg=="success"){
	                	swal({
	                		title:"导入成功!",
	                		text:"导入数据成功。",
	                		type:"success"
	                	},
						 function(){
							 refreshCurrentTab();
						 });
	                }else if(result.msg=="allErr"){
	                    swal({
	                    	title:"导入失败!",
	                    	text:"导入数据失败!"+result.errorUpload,
	                    	type:"error"
	                    },
						 function(){
							 refreshCurrentTab();
						 });
	                }else if(result.msg=="error"){
	                    swal({
	                    	title:"部分数据导入失败!",
	                    	text:"错误信息："+result.errorUpload,
	                    	type:"warning"
	                    },
						 function(){
							 refreshCurrentTab();
						 });
	                }else if(result.msg=="exception"){
	                    swal({
	                    	title:"导入失败!",
	                    	text:"导入数据失败!"+result.errorUpload,
	                    	type:"error"
	                    },
						 function(){
							 refreshCurrentTab();
						 });
	                }
	            }
	        });
		}
	 
	 // 下载文件  (省份)
	function downFile1() {
		var url="uploadFiles/file/DataModel/City/省份管理.xls";
		var name = window.encodeURI(window.encodeURI(url)); 
		window.open("customer/DataModel?url=" + name,"_blank");
	}
	 //(城市)
	 function downFile2() {
		 var url="uploadFiles/file/DataModel/City/城市管理.xls";
		 var name = window.encodeURI(window.encodeURI(url)); 
		 window.open("customer/DataModel?url=" + name,"_blank");
		
	}
	//(区县)
	function downFile3() {
		var url="uploadFiles/file/DataModel/City/区县管理.xls";
		var name = window.encodeURI(window.encodeURI(url)); 
		window.open("customer/DataModel?url=" + name,"_blank");
		
	}
	//(公司管辖区域)
	function downFile4() {
		var url="uploadFiles/file/DataModel/City/公司管辖区域.xls";
		var name = window.encodeURI(window.encodeURI(url)); 
		window.open("customer/DataModel?url=" + name,"_blank");
		
	}
	 
		/* back to top */
		function setWindowScrollTop(win, topHeight){
		    if(win.document.documentElement){
		        win.document.documentElement.scrollTop = topHeight;
		    }
		    if(win.document.body){
		        win.document.body.scrollTop = topHeight;
		    }
		}
		
		 $(document).ready(function(){
		       //点击链接的时候调用
		      $("#outFile").click(function(){
		          //得到departmentname的值
		          var departmentname = $("#departmentname").val();
		          //alert(departmentname);
		          //设置outFile的href的值
		          $("#outFile").attr("href","<%=basePath%>city/toExcel.do?type=4&departmentname="+departmentname);
		          
		      });
		    });
	</script>
</body>
</html>
