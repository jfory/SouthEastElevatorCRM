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
    	<div id="EditShops" class="animated fadeIn"></div><!-- 打开查看 -->
    	<div id="AddRegelevStandard" class="animated fadeIn"></div>
        <!-- <div id="EditLeaves" class="animated fadeIn"></div>
        <div id="AddLeaves" class="animated fadeIn"></div>
		<div id="viewDiagram" class="animated fadeIn"></div>
		<div id="handleLeave" class="animated fadeIn"></div>
		<div id="viewHistory" class="animated fadeIn"></div> -->
	        <div class="row">
				<div class="panel blank-panel">
					<div class="panel-heading">
						<div class="panel-options">
							<ul class="nav nav-tabs">
								<li id="nav-tab-2">
									<a class="count-info-sm" data-toggle="tab" href="#tab-2" onclick="tabChange(2)">
										<i class="fa fa-hourglass-2"></i>
										直梯
										<c:if test="${pd.count>0}">
											<span class="label label-warning">${pd.count}</span>
										</c:if>
									</a>
								</li>
								<li id="nav-tab-3">
									<a data-toggle="tab" href="#tab-3" onclick="tabChange(3)">
										<i class="fa fa-hourglass"></i>
										扶梯
									</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="panel-body">
						<div class="tab-content">
							<div id="tab-1" class="tab-pane">
								<div class="ibox float-e-margins">
									
								</div>
							</div>
							<!-- 直梯 -->
							<div id="tab-2" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<div id="top2"name="top2"></div>
										<form role="form" class="form-inline" action="basicPrice/regelevStandardList.do" method="post" name="leaveForm2" id="leaveForm2">
										    <input type="text" name="NAME" value="${ZNAME}" placeholder="这里输入名称" class="form-control">
	                                        <input type="text" name="SD" value="${SD}" placeholder="这里输入速度" class="form-control">
	                                        <input type="text" name="ZZ" value="${ZZ}" placeholder="这里输入载重" class="form-control">
	                                        <input type="text" name="C" value="${C}" placeholder="这里输入层" class="form-control">
	                                        <input type="text" name="TSGD" value="${TSGD}" placeholder="这里输入提升高度" class="form-control">
										    
										    <button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab(2);">刷新</button>
										    <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
										</form>
										<div class="row">
											</br>
										</div>
										<div class="table-responsive">
										  <table class="table table-striped table-bordered table-hover">
			                                <thead>
			                                    <tr>
			                                   		<th style="width:2%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
			                                        <th>序号</th>
			                                        <th>名称</th>
			                                        <th>速度(m/s)</th>
			                                        <th>承重(KG)</th>
			                                        <th>层站门</th>
			                                        <th>价格</th>
			                                        <th>生效日期</th>
			                                        <th>失效日期</th>
			                                        <th>标准提升高度(m)</th>
			                                        <th>超出高度(米)</th>
			                                        <th>超高加价(元)</th>
			                                        <th>操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty regelevStandardList}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${regelevStandardList}" var="var" varStatus="vs">
															<tr id="${var.autoid }">
																<td><input type="checkbox"  class="i-checks" name='ids' id='ids' value="${var.ID}"></td>
																<td>${vs.index+1}</td>
																<td>
																	${var.NAME}
																</td>
																<td>
																	${var.SD}
																</td>
																<td>
																	${var.ZZ}
																</td>
																<td>
																	${var.C}
																	/
																	${var.Z}
																	/
																	${var.M}
																</td>
																<td>${var.PRICE }</td>
																<td>${var.KS_TIME }</td>
																<td>${var.END_TIME }</td>
																
																<td>${var.TSGD }</td>
																<td>${var.EWAI }</td>
																<td>${var.JJ }</td>
																
																<td>
																		<c:if test="${QX.edit != 1 && QX.del != 1 }">
																			<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																		</c:if>
																		<c:if test="${QX.edit == 1 }">
																			<button class="btn  btn-primary btn-sm" title="编辑" type="button"onclick="edit('${var.ID}','${var.NAME}');">编辑</button>
																		</c:if>
																		<c:if test="${QX.del == 1 }">
																			<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="del('${var.ID }');">删除</button>
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
														<td colspan="100" class="center" >没有相关数据</td>
													</tr>
												</c:otherwise>
											</c:choose>
		                                </tbody>
			                            </table>
			                            <div class="col-lg-12" style="padding-left:0px;padding-right:0px">
											<c:if test="${QX.add == 1 }">
												<button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button>
											</c:if>
											<c:if test="${QX.del == 1 }">
												<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll('del');">批量删除</button>						
											</c:if>
											<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile()">导入</button>
											<input style="display: none" class="form-control" type="file"  title="导入" id="importFile" onchange="importExcel(this)"/>
											<button class="btn  btn-success" title="下载数据模板" type="button" onclick="downFileZ()">下载模板</button>
										    ${page.pageStr}
										</div>
			                            
			                            
										</div>
										</br>
									</div>
								</div>
							</div>
							<%--扶梯--%>
							<div id="tab-3" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<div id="top3" name="top3"></div>
										<form role="form" class="form-inline" action="basicPrice/F_basicPricelistPage.do" method="post" name="leaveForm3" id="leaveForm3">
										    <input type="text" name="NAME" value="${NAME}" placeholder="这里输入名称" class="form-control">
	                                        <input type="text" name="GG" value="${GG}" placeholder="这里输入规格" class="form-control">
	                                        <input type="text" name="XJ" value="${XJ}" placeholder="这里输入斜角" class="form-control">
	                                        <input type="text" name="KD" value="${KD}" placeholder="这里输入梯级宽度" class="form-control">
										    <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
											<button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab(3);">刷新</button>
										
										
										</form>
										<div class="row">
											</br>
										</div>
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover">
												<thead>
												<tr>
												    <th style="width:2%;"><input type="checkbox" name="zcheckbox2" id="zcheckbox2" class="i-checks" ></th>
													<th style="text-align:center;">序号</th>
													<th>名称</th>
													<th>规格</th>
													<th>倾斜角度</th>
													<th>梯级宽度</th>
													<th>价格</th>
													<th>生效日期</th>
													<th>失效日期</th>
													<th>操作</th>
												</tr>
												</thead>
												<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty F_basicPriceList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${F_basicPriceList}" var="f" varStatus="vs3">
																<tr>
																    <td><input type="checkbox"  class="i-checks" name='ids2' id='ids2' value="${f.ID}"></td>
																	<td class='center' style="width: 30px;">${vs3.index+1}</td>
																	<td>${f.NAME}</td>
																	<td>${f.TSGD}</td>
																	<td>${f.QXJD}</td>
																	<td>${f.TJKD}</td>
																	<td>${f.PRICE}</td>
																	<td>${f.KS_TIME}</td>
																	<td>${f.JS_TIME}</td>
																	<td style="text-align:center;">
																		<c:if test="${QX.edit != 1 && QX.del != 1 }">
																			<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																		</c:if>
																		<c:if test="${QX.edit == 1 }">
																			<button class="btn  btn-primary btn-sm" title="编辑" type="button"onclick="editF('${f.ID}','${f.NAME}');">编辑</button>
																		</c:if>
																		<c:if test="${QX.del == 1 }">
																			<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delF('${f.ID }');">删除</button>
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
												<button class="btn  btn-primary" title="新增" type="button" onclick="saveF();">新增</button>
											</c:if>
											<c:if test="${QX.del == 1 }">
												<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll2('del');">批量删除</button>						
											</c:if>
											<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFileF()">导入</button>
											<input style="display: none" class="form-control" type="file"  title="导入" id="importFileF" onchange="importExcelF(this)"/>
											<button class="btn  btn-success" title="下载数据模板" type="button" onclick="downFileF()">下载模板</button>
										    ${page.pageStr}
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
            <a class="btn btn-warning btn-back-to-top" id="top" >
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
	 if(isActive1=="1"){
		 $("#nav-tab-1").addClass("active");
		 $("#tab-1").addClass("active");
	 }else if(isActive2=="1"){
		 $("#nav-tab-2").addClass("active");
		 $("#tab-2").addClass("active");
	 }else if(isActive3=="1"){
		 $("#nav-tab-3").addClass("active");
		 $("#tab-3").addClass("active");
	 }
	 //tab切换
	 function tabChange(id){
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
        	$("#leaveForm"+id).submit();
        }
		//检索
		function search(id){
			$("#leaveForm"+id).submit();
		}
		
		/*直梯相关操作*/
		//新增
		function add(){
			$("#AddRegelevStandard").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "新增电梯标准价格",
		        actions: ["Close"],
		        content: '<%=basePath%>basicPrice/goAddRegelevStandard.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		
		//删除
		function del(id){
           swal({
                   title: "您确定要删除该条信息吗？",
                   text: "删除后将无法恢复，请谨慎操作！",
                   type: "warning",
                   showCancelButton: true,
                   confirmButtonColor: "#DD6B55",
                   confirmButtonText: "删除",
                   cancelButtonText: "取消",
                   closeOnConfirm: false,
                   closeOnCancel: false
               }).then(function (isConfirm) {
                   if (isConfirm) {
                   	var url = "<%=basePath%>basicPrice/delBasicPrice.do?ID="+id;
       				$.get(url,function(data){
       					if(data.msg=='success'){
       						swal({   
       				        	title: "删除成功！",
       				        	text: "您已经成功删除了这条信息。",
       				        	type: "success",  
       				        	}).then(function(){
       									refreshCurrentTab(2);
       							});
       					}else{
       						swal("删除失败", "您的删除操作失败了！", "error");
       					}
       				});
                   } else {
                       swal("已取消", "您取消了删除操作！", "error");
                   }
               });
		}
		
		//修改
		function edit(ID,MODELS){
			$("#AddRegelevStandard").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "编辑基础价格",
		        actions: ["Close"],
		        content: '<%=basePath%>basicPrice/goEditBasicPrice.do?ID='+ID+'&MODELS='+MODELS,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		
		 //批量操作
	    function makeAll(msg) {
	        var str = '';
	        var emstr = '';
	        var phones = '';
	        for (var i = 0; i < document.getElementsByName('ids').length; i++) {
	            if (document.getElementsByName('ids')[i].checked) {
	                if (str == '') str += document.getElementsByName('ids')[i].value;
	                else str += ',' + document.getElementsByName('ids')[i].value;
	            }
	        }
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
	                    }).then(function (isConfirm) 
	                    		{
	                        if (isConfirm) {
	                            $.ajax({
	                                type: "POST",
	                                url: '<%=basePath%>basicPrice/delAll.do',
	                                data: {ids: str},
	                                dataType: 'json',
	                                cache: false,
	                                success: function (data) {
	                                    if (data.msg == 'success') {
	                                    	swal({   
			        				        	title: "删除成功！",
			        				        	text: "您已经成功删除了这些数据",
			        				        	type: "success",  
	                                    	}).then(function(){   
			        				        		 refreshCurrentTab(2); 
			        				        	 });
	                                    } else {
	                                        swal("删除失败", "您的删除操作失败了！", "error");
	                                    }

	                                }
	                            });
	                        } else {
	                            swal("已取消", "您取消了删除操作！", "error");
	                        }
	                    });
	        }
	    }
		

		//选择导入文件
		function inputFile(){
			$("#importFile").click();
		}

		//导入Excel
		function importExcel(e){
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
	            url:"<%=basePath%>basicPrice/importExcel.do",
	            type:"POST",
	            data:data,
	            cache: false,
	            processData:false,
	            contentType:false,
	            success:function(result){
	            	$(e).val("");
	                if(result.msg=="success"){
	                	swal({
	                		title:"导入成功!",
	                		text:"导入数据成功。",
	                		type:"success"
	                	}).then(function(){
							 refreshCurrentTab(2);
						 });
	                }else if(result.msg=="allErr"){
	                    swal({
	                    	title:"导入失败!",
	                    	text:"导入数据失败!"+result.errorUpload,
	                    	type:"error"
	                    }).then(function(){
							 refreshCurrentTab(2);
						 });
	                }else if(result.msg=="error"){
	                    swal({
	                    	title:"部分数据导入失败!",
	                    	text:"错误信息："+result.errorUpload,
	                    	type:"warning"
	                    }).then(function(){
							 refreshCurrentTab(2);
						 });
	                }else if(result.msg=="exception"){
	                    swal({
	                    	title:"导入失败!",
	                    	text:"导入数据失败!"+result.errorUpload,
	                    	type:"error"
	                    }).then(function(){
							 refreshCurrentTab(2);
						 });
	                }
	            }
	        });
		}

		//  扶梯相关功能 
		 /* checkbox全选 */
	     $("#zcheckbox2").on('ifChecked', function(event){
	     	$('input').iCheck('check');
	   	});
	     /* checkbox取消全选 */
	     $("#zcheckbox2").on('ifUnchecked', function(event){
	     	
	     	$('input').iCheck('uncheck');
	   	});
		
		
		//新增
		function saveF(){
			$("#AddRegelevStandard").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "新增电梯标准价格",
		        actions: ["Close"],
		        content: '<%=basePath%>basicPrice/goAddFbasicPrice.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		
		//修改
		function editF(ID,MODELS){
			$("#AddRegelevStandard").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "编辑基础价格",
		        actions: ["Close"],
		        content: '<%=basePath%>basicPrice/goEditF_BasicPrice.do?ID='+ID+'&MODELS='+MODELS,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		
		
		//删除
		function delF(id){
           swal({
                   title: "您确定要删除该条信息吗？",
                   text: "删除后将无法恢复，请谨慎操作！",
                   type: "warning",
                   showCancelButton: true,
                   confirmButtonColor: "#DD6B55",
                   confirmButtonText: "删除",
                   cancelButtonText: "取消",
                   closeOnConfirm: false,
                   closeOnCancel: false
               }).then(function (isConfirm) {
                   if (isConfirm) {
                   	var url = "<%=basePath%>basicPrice/deleteF.do?ID="+id;
       				$.get(url,function(data){
       					if(data.msg=='success'){
       						swal({   
       				        	title: "删除成功！",
       				        	text: "您已经成功删除了这条信息。",
       				        	type: "success",  
       				        	}).then(function(){
       									refreshCurrentTab(3);
       							});
       					}else{
       						swal("删除失败", "您的删除操作失败了！", "error");
       					}
       				});
                   } else {
                       swal("已取消", "您取消了删除操作！", "error");
                   }
               });
		}
		
		 //批量操作
	    function makeAll2(msg) {
	        var str = '';
	        var emstr = '';
	        var phones = '';
	        for (var i = 0; i < document.getElementsByName('ids2').length; i++) {
	            if (document.getElementsByName('ids2')[i].checked) {
	                if (str == '') str += document.getElementsByName('ids2')[i].value;
	                else str += ',' + document.getElementsByName('ids2')[i].value;
	            }
	        }
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
	                    }).then(function (isConfirm) 
	                    		{
	                        if (isConfirm) {
	                            $.ajax({
	                                type: "POST",
	                                url: '<%=basePath%>basicPrice/delFAll.do',
	                                data: {ids: str},
	                                dataType: 'json',
	                                cache: false,
	                                success: function (data) {
	                                    if (data.msg == 'success') {
	                                    	swal({   
			        				        	title: "删除成功！",
			        				        	text: "您已经成功删除了这些数据",
			        				        	type: "success",  
	                                    	}).then(function(){   
			        				        		 refreshCurrentTab(3); 
			        				        	 });
	                                    } else {
	                                        swal("删除失败", "您的删除操作失败了！", "error");
	                                    }

	                                }
	                            });
	                        } else {
	                            swal("已取消", "您取消了删除操作！", "error");
	                        }
	                    });
	        }
	    }
		
		//选择导入文件
		function inputFileF(){
			$("#importFileF").click();
		}

		//导入Excel
		function importExcelF(e){
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
	            url:"<%=basePath%>basicPrice/importExcelF.do",
	            type:"POST",
	            data:data,
	            cache: false,
	            processData:false,
	            contentType:false,
	            success:function(result){
	            	$(e).val("");
	                if(result.msg=="success"){
	                	swal({
	                		title:"导入成功!",
	                		text:"导入数据成功。",
	                		type:"success"
	                	}).then(function(){
							 refreshCurrentTab(3);
						 });
	                }else if(result.msg=="allErr"){
	                    swal({
	                    	title:"导入失败!",
	                    	text:"导入数据失败!"+result.errorUpload,
	                    	type:"error"
	                    }).then(function(){
							 refreshCurrentTab(3);
						 });
	                }else if(result.msg=="error"){
	                    swal({
	                    	title:"部分数据导入失败!",
	                    	text:"错误信息："+result.errorUpload,
	                    	type:"warning"
	                    }).then(function(){
							 refreshCurrentTab(3);
						 });
	                }else if(result.msg=="exception"){
	                    swal({
	                    	title:"导入失败!",
	                    	text:"导入数据失败!"+result.errorUpload,
	                    	type:"error"
	                    }).then(function(){
							 refreshCurrentTab(3);
						 });
	                }
	            }
	        });
		}

		// 下载文件   e代表当前路径值 
		function downFileZ() {
			var url="uploadFiles/file/DataModel/basicPrice/直梯基础价格.xls";
			var name = window.encodeURI(window.encodeURI(url));
			window.open("customer/DataModel?url=" + name,"_blank");
		}
		
		// 下载文件   e代表当前路径值 
		function downFileF() {
			var url="uploadFiles/file/DataModel/basicPrice/扶梯基础价格.xls";
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

		$("#top").click(function(){
			
			$("html,body").animate({scrollTop : 0},500);
		});
      	
		</script>
</body>
</html>


