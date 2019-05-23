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
        <div id="AddEscalatorStandard" class="animated fadeIn"></div>
        <div id="EditEscalatorStandard" class="animated fadeIn"></div>
        <div id="ViewProduct" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top",name="top"></div>
	                        <form role="form" class="form-inline" action="escalatorStandard/escalatorStandardList.do" method="post" name="escalatorStandardForm" id="escalatorStandardForm">
	                            <div class="form-group ">
	                                <input type="text" name="home_standard_name" value="${home_standard_name}" placeholder="这里输入名称" class="form-control">
	                            </div>
	                           
	                            <div class="form-group">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div>
	                            <button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab();">刷新</button>
	                        </form>
	                            <div class="row">
	                            </br>
	                             </div>
	                        <div class="table-responsive" >
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                   		<th style="width:2%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
	                                        <th style="width:5%;">序号</th>
	                                        <th style="width:20%;">型号</th>
	                                        <th style="width:10%;">规格</th>
	                                        <th style="width:10%;">宽度(MM)</th>
	                                        <th style="width:20%;">价格</th>
	                                        <th style="width:20%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty escalatorStandardList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${escalatorStandardList}" var="var" varStatus="vs">
													<tr id="${var.autoid }">
														
														
														<td><input type="checkbox"  class="i-checks" name='ids' id='ids' value="${var.id}"></td>
														
														
														
														<td>${vs.index+1}</td>
														
														<td>
															${var.escalator_model_id eq 1 ? "30°":""}
															${var.escalator_model_id eq 2 ? "35°":""}
														</td>
														<td>
															
															${var.escalator_standard_id eq 1 ? "3.0":"" }
															${var.escalator_standard_id eq 2 ? "3.1":"" }
															${var.escalator_standard_id eq 3 ? "3.2":"" }
															${var.escalator_standard_id eq 4 ? "3.3":"" }
															${var.escalator_standard_id eq 5 ? "3.4":"" }
															${var.escalator_standard_id eq 6 ? "3.5":"" }
															${var.escalator_standard_id eq 7 ? "3.6":"" }
															${var.escalator_standard_id eq 8 ? "3.7":"" }
															${var.escalator_standard_id eq 9 ? "3.8":"" }
															${var.escalator_standard_id eq 10 ? "3.9":"" }
															
															${var.escalator_standard_id eq 11 ? "4.0":"" }
															${var.escalator_standard_id eq 12 ? "4.1":"" }
															${var.escalator_standard_id eq 13 ? "4.2":"" }
															${var.escalator_standard_id eq 14 ? "4.3":"" }
															${var.escalator_standard_id eq 15 ? "4.4":"" }
															${var.escalator_standard_id eq 16 ? "4.5":"" }
															${var.escalator_standard_id eq 17 ? "4.6":"" }
															${var.escalator_standard_id eq 18 ? "4.7":"" }
															${var.escalator_standard_id eq 19 ? "4.8":"" }
															${var.escalator_standard_id eq 20 ? "4.9":"" }
															
															${var.escalator_standard_id eq 21 ? "5.0":"" }
															${var.escalator_standard_id eq 22 ? "5.1":"" }
															${var.escalator_standard_id eq 23 ? "5.2":"" }
															${var.escalator_standard_id eq 24 ? "5.3":"" }
															${var.escalator_standard_id eq 25 ? "5.4":"" }
															${var.escalator_standard_id eq 26 ? "5.5":"" }
															${var.escalator_standard_id eq 27 ? "5.6":"" }
															${var.escalator_standard_id eq 28 ? "5.7":"" }
															${var.escalator_standard_id eq 29 ? "5.8":"" }
															${var.escalator_standard_id eq 30 ? "5.9":"" }
															
															${var.escalator_standard_id eq 31 ? "6.0":"" }
															${var.escalator_standard_id eq 32 ? "6.1":"" }
															${var.escalator_standard_id eq 33 ? "6.2":"" }
															${var.escalator_standard_id eq 34 ? "6.3":"" }
															${var.escalator_standard_id eq 35 ? "6.4":"" }
															${var.escalator_standard_id eq 36 ? "6.5":"" }
															${var.escalator_standard_id eq 37 ? "6.6":"" }
															${var.escalator_standard_id eq 38 ? "6.7":"" }
															${var.escalator_standard_id eq 39 ? "6.8":"" }
															${var.escalator_standard_id eq 40 ? "6.9":"" }
															
															${var.escalator_standard_id eq 41 ? "7.0":"" }
															${var.escalator_standard_id eq 42 ? "7.1":"" }
															${var.escalator_standard_id eq 43 ? "7.2":"" }
															${var.escalator_standard_id eq 44 ? "7.3":"" }
															${var.escalator_standard_id eq 45 ? "7.4":"" }
															${var.escalator_standard_id eq 46 ? "7.5":"" }
															
														</td>
														<td>
															${var.escalator_width_id eq 1 ? "1000MM":"" }
															${var.escalator_width_id eq 2 ? "800MM":"" }
															${var.escalator_width_id eq 3 ? "600MM":"" }
														</td>
														
														<td>${var.escalator_standard_price }</td>
														
														<td>
																<c:if test="${QX.edit != 1 && QX.del != 1 }">
																	<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																</c:if>
																<!--  
																<c:if test="${QX.cha == 1 }">
																	<button class="btn  btn-success btn-sm" title="查看" type="button" onclick="viewAgent('${var.agent_id }');" >查看</button>
																</c:if>
																-->
																<c:if test="${QX.edit == 1 }">
																	<button class="btn  btn-primary btn-sm" title="编辑" type="button"onclick="edit('${var.id }');">编辑</button>
																</c:if>
																<c:if test="${QX.del == 1 }">
																	<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="del('${var.id }');">删除</button>
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
										<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>						
									</c:if>
									<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>escalatorStandard/toExcel.do">导出</a>
									<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile()">导入</button>
									<input style="display: none" class="form-control" type="file"  title="导入" id="importFile" onchange="importExcel(this,4)"/>
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
        
      	//刷新iframe
        function refreshCurrentTab() {
      	/* 	alert("refresh");
      		alert("src=>"+window.location); */
        	window.location.reload();
        }
		//检索
		function search(){
			$("#Form").submit();
		}
		//新增
		function add(){
			$("#AddEscalatorStandard").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "新增电梯标准价格",
		        actions: ["Close"],
		        content: '<%=basePath%>escalatorStandard/goAddEscalatorStandard.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		
		//删除
		function del(id){
                swal({
                        title: "您确定要删除吗？",
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
                        	var url = "<%=basePath%>escalatorStandard/delEscalatorStandard.do?id="+id+"&guid="+new Date().getTime();
            				$.get(url,function(data){
            					if(data=='success'){
            						swal({   
            				        	title: "删除成功！",
            				        	text: "您已经成功删除了这条信息。",
            				        	type: "success",  
            				        	}).then(function(){
            									refreshCurrentTab();
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
		
		//查看 
		function viewAgent(agent_id){
			$("#ViewAgent").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "查看详情",
		        actions: ["Close"],
		        content: '<%=basePath%>sysAgent/toView.do?agent_id='+agent_id,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		//修改
		function edit(id){
			$("#EditEscalatorStandard").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "编辑电梯标准价格",
		        actions: ["Close"],
		        content: '<%=basePath%>escalatorStandard/goEditEscalatorStandard.do?id='+id,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		//批量操作
		function makeAll(){
			var str = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++){
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
	            }).then(function (isConfirm) {
	                if (isConfirm) {
	                	$.ajax({
							type: "POST",
							url: '<%=basePath%>escalatorStandard/escalatorStandardDeleteAll.do',
					    	data: {DATA_IDS:str},
							dataType:'json',
							cache: false,
							success: function(data){
								$.each(data.list, function(i, list){
									if(list.msg=='ok'){
										swal({   
		        				        	title: "删除成功！",
		        				        	text: "您已经成功删除了这条信息。",
		        				        	type: "success",  
		        				        	 }).then(function(){   
	        				        		 	refreshCurrentTab(); 
	        				        	 	});
			    					}else{
			    						swal("删除失败", "您的删除操作失败了！", "error");
			    					}
							 	});
								
							}
						});
	                } else {
	                    swal("已取消", "您取消了删除操作！", "error");
	                }
	            });
				
				
				
				
				
				
				
			}
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
	            url:"<%=basePath%>escalatorStandard/importExcel.do",
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
	                }else{
	                	 swal({
		                    	title:"导入失败!",
		                    	text:"导入数据失败,"+result.errorMsg,
		                    	type:"error"
		                    },
							 function(){
								 refreshCurrentTab();
							 });
	                }
	            }
	        });
		}
		</script>
</body>
</html>


