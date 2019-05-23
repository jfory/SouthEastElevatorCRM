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
    <style type="text/css">
    	.overHide{
			overflow:hidden;
			white-space:nowrap;
			text-overflow:ellipsis;
		}
    </style>
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
	<div id="InformationHTML" class="animated fadeIn"></div>
	
    <div class="wrapper wrapper-content animated fadeInRight">
        <div id="EditItem" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top" name="top"></div>
	                        <form role="form" class="form-inline" action="item/listItem.do" method="post" name="ItemForm" id="ItemForm">
	                            <div class="form-group  form-inline ">
	                                <!-- <select style="width:170px" name="search_item_name" id="search_item_name"  class="selectpicker" data-live-search="true">
	                                	<option value="">查询所有</option>
	                                	<c:forEach items="${itemList}" var="var">
	                                		<option value="${var.item_name}">${var.item_name}</option>
	                                	</c:forEach>
	                                </select> -->
	                                <input style="width:160px" type="text" value="${pd.search_item_name}" name="search_item_name" id="search_item_name" placeholder="项目名称查询"  class="form-control">
	                                <input style="width:160px" type="text" value="${ZL_TYPE}" name="ZL_TYPE" id="ZL_TYPE" placeholder="项目滞留状态查询"  class="form-control">
	                                <input style="width:160px" type="text" value="${pd.input_name}" name="input_name" id="input_name" placeholder="项目录入人查询"  class="form-control">
	                                <input style="width:160px" type="text" value="${pd.item_area_name}" name="item_area_name" id="item_area_name" placeholder="项目区域查询"  class="form-control">
	                                <input style="width:160px" type="text" value="${pd.item_sub_branch_name}" name="item_sub_branch_name" id="item_sub_branch_name" placeholder="项目分公司查询"  class="form-control">
	                                <select class="form-control" id="search_item_approval" name="search_item_approval" style="margin-left:5px;" >
									    <option value="">审核状态</option>
									    <option value="-1" ${pd.search_item_approval=="-1"?"selected='selected'":""}>无需审核</option>
									    <option value="1" ${pd.search_item_approval=="1"?"selected='selected'":""}>新建</option>
									    <option value="2" ${pd.search_item_approval=="2"?"selected='selected'":""}>待审核</option>
									    <option value="3" ${pd.search_item_approval=="3"?"selected='selected'":""}>审核中</option>
									    <option value="4" ${pd.search_item_approval=="4"?"selected='selected'":""}>已通过</option>
									    <option value="5" ${pd.search_item_approval=="5"?"selected='selected'":""}>被驳回</option>
									 </select>
	                            </div>
	                            <div class="form-group form-inline ">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                                 <c:if test="${QX.add == 1 }">
										<button class="btn  btn-primary" style="margin-bottom:0px;margin-left: 5px;" title="新增" type="button" onclick="add();">新增</button>
									 </c:if>
	                            </div>
	                            <button class="btn  btn-success" title="刷新" type="button" style="margin-top: 0px;margin-bottom:0px;float: right" onclick="refreshCurrentTab();">刷新</button>
	                        </form>
	                            <div class="row">
	                            </br>
	                             </div>
	                        <div class="table-responsive">
	                            <table class="table table-striped table-bordered table-hover" style="table-layout:fixed">
	                                <thead>
	                                    <tr>
	                                        <th style="width:3%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
	                                        <th style="width:12%;">项目编号</th>
	                                        <th style="width:18%;">项目名称</th>
	                                        <th style="width:10%;">区域</th>
	                                        <th style="width:10%;">分公司</th>
	                                        <th style="width:10%;">录入人</th>
	                                        <th style="width:10%;" class="overHide" title="项目录入时间">项目录入时间</th>
	                                        <th style="width:8%;">跟进状态</th>
	                                        <th style="width:8%;">项目状态</th>
	                                        <th style="width:8%;">审核状态</th>
	                                        <th style="width:13%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty itemList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${itemList}" var="var" >
													<tr>
														<td class="overHide"><input type="checkbox" class="i-checks" name='ids' id='${var.item_id}' value='${var.item_id}' ></td>
														<td class="overHide" title="${var.item_no}"><a herf="#" onclick="edit('${var.item_id}','sel');">${var.item_no}</a></td>
														<td class="overHide" title="${var.item_name}">${var.item_name}</td>
														<td class="overHide" title="${var.item_area_name}">${var.item_area_name}</td>
														<td class="overHide" title="${var.item_sub_branch_name}">${var.item_sub_branch_name}</td>
														<td class="overHide" title="${var.input_uname}">${var.input_uname}</td>
														<th class="overHide" title="${var.HTLRSJ}">${var.HTLRSJ}</th>
														<td class="overHide" title="${var.ZL_TYPE}">${var.ZL_TYPE}</td>
														<td class="overHide">
															${var.item_status==""?"未选择":""}
															${var.item_status=="1"?"信息":""}
															${var.item_status=="2"?"报价":""}
															${var.item_status=="3"?"投标":""}
															${var.item_status=="4"?"洽谈":""}
															${var.item_status=="5"?"合同":""}
															${var.item_status=="6"?"中标":""}
															${var.item_status=="7"?"失标":""}
															${var.item_status=="8"?"取消":""}
															${var.item_status=="9"?"生效":""}
															${var.item_status=="11"?"关闭":""}
														</td>
														
														<!-- 审核状态 -->
														<td class="overHide">
															<c:if test="${var.is_cross_region == 0 }">
																无需审核
															</c:if>
															<c:if test="${var.is_cross_region == 1 && var.item_approval==1}">
																新建
															</c:if>
															<c:if test="${var.is_cross_region == 1 && var.item_approval==2}">
																待审核
															</c:if>
															<c:if test="${var.is_cross_region == 1 && var.item_approval==3}">
																审核中
															</c:if>
															<c:if test="${var.is_cross_region == 1 && var.item_approval==4}">
																通过
															</c:if>
															<c:if test="${var.is_cross_region == 1 && var.item_approval==5}">
																驳回
															</c:if>
															
														</td>
														
														
														<td>
															<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
															</c:if>
															<div><input name="h-is-cross-region" type="hidden" value="${var.is_cross_region }" />
																<input name="h-item-approval" type="hidden" value="${var.item_approval }" />
																<input name="h-item-status" type="hidden" value="${var.item_status }" />
																<c:if test="${QX.edit == 1 }">
																	<%-- <button class="btn btn-sm btn-info btn-sm" title="查看" type="button" onclick="edit('${var.item_id}','sel');">查看</button> --%>
																</c:if>
																<c:if test="${QX.edit == 1 && (var.is_cross_region == 0 ||(var.is_cross_region == 1 && var.item_approval==1))}">
																	<button class="btn btn-sm btn-primary btn-sm" title="编辑" type="button" onclick="edit('${var.item_id}','edit');">编辑</button>
																</c:if>
																<c:if test="${QX.edit == 1 && (var.is_cross_region == 1 && (var.item_approval==5 || var.item_approval==4))}">
																	<button class="btn btn-sm btn-primary btn-sm" title="编辑" type="button" onclick="edit('${var.item_id}','edit');">编辑</button>
																</c:if>
																<c:if test="${QX.edit == 1 && var.item_status == 1 && (var.is_cross_region == 0 ||(var.is_cross_region == 1 && (var.item_approval==1||var.item_approval==4)))}">
																	<%-- <button class="btn btn-sm btn-primary btn-sm" title="关闭" type="button" onclick="close1('${var.item_id}','${var.item_name}');">关闭</button> --%>
																</c:if>
																<c:if test="${QX.del == 1  && (var.is_cross_region == 0 ||(var.is_cross_region == 1 && (var.item_approval==1||var.item_approval==4))) }">
																	<%-- <button class="btn btn-sm btn-danger btn-sm" title="删除" type="button" onclick="del('${var.item_id}','${var.item_name}');">删除</button> --%>
																</c:if>
																
																<c:if test="${var.item_instance_id ne null && var.is_cross_region == 1 && var.item_approval==1 && var.item_status!=11}">	
																		<button class="btn  btn-warning btn-sm" title="启动流程" type="button" onclick="startAgent('${var.item_id }','${var.item_instance_id}');">启动</button>
																</c:if>
																
																 <c:if test="${var.item_instance_id ne null && var.is_cross_region == 1 && var.item_approval==5}">
															           <button class="btn  btn-warning btn-sm" title="重新提交" type="button" 
															           onclick="restartAgent('${var.task_id }','${var.item_id}');">重新提交</button>
														         </c:if>

																<c:if test="${var.item_instance_id ne null && var.is_cross_region == 1 && var.item_approval !=1}">
														           <button class="btn  btn-info btn-sm" title="审核记录" type="button" 
														                  onclick="viewHistory('${var.item_instance_id}');">审核记录</button>
							 							        </c:if>	
							 							        
																<%-- <c:if test="${QX.cha == 1 && var.item_status == 1}">
																	<button class="btn btn-sm btn-warning btn-sm" title="报价" type="button" onclick="sub('${var.item_id}');">报价</button>
																</c:if> --%>
															</div>
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
									<c:if test="${QX.del == 1 }">
										<%-- <button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button> --%>
									</c:if>
									<a class="btn btn-warning btn-outline" title="导出到Excel" type="button" target="_blank" onclick="toExcel2(this)" href="javascript:;">导出</a>
									<!-- <button class="btn btn-warning" title="导出到Excel" type="button" onclick="toExcel()">导出</button> -->
									<button class="btn btn-info btn-outline" title="导入到Excel" type="button" onclick="inputFile()">导入</button>
									<input style="display: none" class="form-control" type="file"  title="导入" id="importFile" onchange="importExcel(this)"/>
									<button class="btn  btn-success" title="下载数据模板" type="button" onclick="downFile()">下载模板</button>	
									<div class="btn-group dropup">
									  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									    工具 <span class="caret"></span>
									  </button>
									  <ul class="dropdown-menu dropdown-menu-right">
									  	<c:if test="${QX.del == 1 }"><li><a href="Javascript:;" onclick="makeAll();">删除</a></li></c:if>
									    <c:if test="${QX.edit == 1 }"><li ><a href="Javascript:;" onclick="makeClose1();">关闭</a></li></c:if>
									  </ul>
									</div>
										${page.pageStr}
								</div>
								</div>
	                        </div>
	                    </div>
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
        	/* 图片 */
            $('.fancybox').fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });
        });
        /* checkbox全选 */
        $("#zcheckbox").on('ifChecked', function(event){
        	
        	$('input').iCheck('check');
      	});
        /* checkbox取消全选 */
        $("#zcheckbox").on('ifUnchecked', function(event){
        	
        	$('input').iCheck('uncheck');
      	});

      	//新增
		function add(){
			$("#EditItem").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "编辑项目信息",
		        actions: ["Close"],
		        content: '<%=basePath%>item/goAddItem.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}

		//修改/查看
		function edit(id,operateType){
			$("#EditItem").kendoWindow({
		        width: "1000px",
		        height: "800px",
		        title: "编辑项目信息",
		        actions: ["Close"],
		        content: '<%=basePath%>item/goEditItem.do?item_id='+id+'&operateType='+operateType,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}

		//删除
		function del(id,title){
			swal({
                        title: "您确定要删除["+title+"]吗？",
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
                    	if(isConfirm){
                        	var url = "<%=basePath%>item/delItem.do?item_id="+id+"&tm="+new Date().getTime();;
            				$.get(url,function(data){
            					if(data.msg=='success'){
            						swal({   
            				        	title: "删除成功！",
            				        	text: "您已经成功删除了这条信息。",
            				        	type: "success",  
            				        	 }, 
            				        	function(){   
            				        		 refreshCurrentTab(); 
            				        	 });
            					}else{
            						swal("删除失败", "您的删除操作失败了！", "error");
            					}
            				});
            			}else{
            				swal("已取消", "您取消了删除操作！", "error");
            			}
            });
		}
        
		
		
		//关闭
		function close1(id,title){
			swal({
                        title: "您确定要关闭["+title+"]吗？",
                        text: "",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "关闭",
                        cancelButtonText: "取消",
                        closeOnConfirm: false,
                        closeOnCancel: false
                    },
                    function (isConfirm) {
                    	if(isConfirm){
                        	var url = "<%=basePath%>item/closeItem.do?item_id="+id+"&tm="+new Date().getTime();;
            				$.get(url,function(data){
            					if(data.msg=='success'){
            						swal({   
            				        	title: "关闭成功！",
            				        	text: "您已经成功关闭了["+title+"]项目。",
            				        	type: "success",  
            				        	 }, 
            				        	function(){   
            				        		 refreshCurrentTab(); 
            				        	 });
            					}else{
            						swal("关闭失败", "您的关闭操作失败了！", "error");
            					}
            				});
            			}else{
            				swal("已取消", "您取消了关闭操作！", "error");
            			}
            });
		}
        //批量操作
		function makeAll(){
			var str = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++){
			  if(document.getElementsByName('ids')[i].checked){
				  
				  var sTr = $(document.getElementsByName('ids')[i]).parents("tr");
				  var icr = sTr.find('input[name=h-is-cross-region]').val();
				  var ia = sTr.find('input[name=h-item-approval]').val();
				  
				  if(icr == 1 && (ia == 2 || ia == 3)){
					  var _xm = sTr.find("td").eq(2).text();
					  swal({
			                title: "您不能删除项目["+_xm+"]",
			                text: "您所选的项目["+_xm+"]在审核中，不能删除！",
			                type: "error",
			                showCancelButton: false
			            });
					  return;
				  }
				  
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
							url: '<%=basePath%>item/delAllItem.do',
					    	data: {item_ids:str},
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

		//提交
		function sub(item_id){
			swal({
	                title: "您确定要对项目进行报价吗？",
	                text: "报价时将无法编辑项目信息，请谨慎操作！",
	                type: "warning",
	                showCancelButton: true,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "报价",
	                cancelButtonText: "取消",
	                closeOnConfirm: false,
	                closeOnCancel: false
	            },
	            function (isConfirm) {
	                if (isConfirm) {
	                	$.ajax({
							type: "POST",
							url: '<%=basePath%>item/subItem.do',
					    	data: {item_id:item_id},
							dataType:'json',
							cache: false,
							success: function(data){
								if(data.msg=='success'){
									swal({   
	        				        	title: "操作成功！",
	        				        	text: "您已经成功提交了这些数据。",
	        				        	type: "success",  
	        				        	 }, 
	        				        	function(){   
	        				        		 refreshCurrentTab(); 
	        				        	 });
		    					}else{
		    						swal("操作失败", "您的提交操作失败了！", "error");
		    					}
								
							}
						});
	                } else {
	                    swal("已取消", "您取消了提交操作！", "error");
	                }
	            });
		}

		//导出到Excel
		function toExcel(){
			$.post("<%=basePath%>item/toExcel.do");
			/*window.location.href='<%=basePath%>item/toExcel.do';*/
		}
		
		//导出到Excel
		function toExcel2(ele){
			var search_item_name = $("input[name='search_item_name']").val();
		  	var ZL_TYPE = $("input[name='ZL_TYPE']").val();
		  	$(ele).attr("href", "<%=basePath%>item/toExcel.do?search_item_name="
		  			+search_item_name+"&ZL_TYPE="
		  			+ZL_TYPE);
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
	            url:"<%=basePath%>item/importExcel.do",
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
	                    	text:"导入数据失败!"+result.errorUpload,
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

      	//刷新iframe
        function refreshCurrentTab() {
        	$("#ItemForm").submit();
        }
		//检索
		function search(){
			$("#ItemForm").submit();
		}
		
		/* 下载数据模板 
		  2017-06-13 Stone
		*/
		function downFile() {
			var url="uploadFiles/file/DataModel/Item/项目报备.xls";
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
		
		
		
	    //启动流程
		function startAgent(item_id,item_instance_id){
			swal({
				title: "您确定要启动流程吗？",
				text: "点击确定将会启动该流程，请谨慎操作！",
				type: "warning",
				showCancelButton: true,
				confirmButtonColor: "#DD6B55",
				confirmButtonText: "启动",
				cancelButtonText: "取消",
				closeOnConfirm: false,
	            closeOnCancel: false
		        },function (isConfirm) {
				if (isConfirm)
				{
					var url = "<%=basePath%>item/apply.do?item_id="+item_id+'&item_instance_id='+item_instance_id;
					$.get(url, function (data) {
						console.log(data.msg);
						if (data.msg == "success") {
							swal({   
								title: "启动成功！",
								text: "您已经成功启动该流程。\n该流程实例ID为："+item_instance_id+",下一个任务为："+data.task_name,
					        	type: "success",  
							    },function(){
								    refreshCurrentTab();
							    });
							
						} else {
							swal("启动失败","error");
						}
					});
				} 
				else
				{
					swal("已取消", "您已经取消启动操作了！", "error");
				}
			});
		}
		
		//审核记录
		 function viewHistory(item_instance_id){
			 $("#InformationHTML").kendoWindow({
				 width: "900px",
				 height: "500px",
				 title: "查看审核记录",
				 actions: ["Close"],
				 content: '<%=basePath%>workflow/goViewHistory.do?pid='+item_instance_id,
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").center().open();
		 }
		
		
		
			//重新提交流程
		 function restartAgent(task_id,item_id){
			 swal({
				 title: "您确定要重新提交吗？",
				 text: "重新提交流程进行审核！",
				 type: "warning",
				 showCancelButton: true,
				 confirmButtonColor: "#DD6B55",
				 confirmButtonText: "提交",
				 cancelButtonText: "取消"
			 },
			 function (isConfirm) {
				 if (isConfirm === true) {
					 var url = "<%=basePath%>item/restartItem.do?task_id="+task_id+"&item_id="+item_id+"&tm="+new Date().getTime();
					 $.get(url, function (data) {
						 console.log(data.msg);
						 if (data.msg == "success") {
							 swal({
								 title: "重新提交成功！",
								 text: "您已经成功重新提交了该流程！",
								 type: "success"
							 },
							 function(){
								 refreshCurrentTab();
							 });
						 } else {
							 swal({
								 title: "重新提交失败！",
								 text:  data.err,
								 type: "error",
								 showConfirmButton: false,
								 timer: 1000
							 });
						 }
					 });
				 } else if (isConfirm == false) {
					 swal({
						 title: "取消重新提交！",
						 text: "您已经取消重新提交操作了！",
						 type: "error",
						 showConfirmButton: false,
						 timer: 1000
					 });
				 }
			 });
		 }
			
		function makeClose1() {
			var str = '';
			var _xm = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++){
			  if(document.getElementsByName('ids')[i].checked){
				  
				  var sTr = $(document.getElementsByName('ids')[i]).parents("tr");
				  var icr = sTr.find('input[name=h-is-cross-region]').val();
				  var ia = sTr.find('input[name=h-item-approval]').val();
				  var is = sTr.find('input[name=h-item-status]').val();

				  _xm = sTr.find("td").eq(2).text();
				  if(is == 1 && (icr == 0 || (icr == 1 && (ia == 1 || ia == 4 || ia == 5)))){
					  str = document.getElementsByName('ids')[i].value;
				  } else {
					  swal({
			                title: "您所选项目["+_xm+"]不能关闭",
			                text: "您所选的项目["+_xm+"]不能关闭！",
			                type: "error",
			                showCancelButton: false
			            });
					  return;
				  }
				  
				  break;
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
			} else {
				
				close1(str,_xm);
				
			}
			
			
		}
	    
		</script>
</body>
</html>


