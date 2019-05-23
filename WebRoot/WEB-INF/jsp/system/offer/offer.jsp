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
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div id="EditItem" class="animated fadeIn"></div>
        <div id="EditOffer" class="animated fadeIn"></div>
        <div id="EditDiscount" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top" name="top"></div>
	                        <form role="form" class="form-inline" action="offer/offerList.do" method="post" name="OfferForm" id="OfferForm">
	                            <div class="form-group  form-inline ">
	                                <input style="width:170px" type="text" name="search_item_name" id="search_item_name" placeholder="输入项目名称查询"  class="form-control">
	                            </div>
	                            <div class="form-group form-inline ">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div>
	                            <button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;margin-bottom:0px;float: right" onclick="refreshCurrentTab();">刷新</button>
	                        </form>
	                            <div class="row">
	                            </br>
	                             </div>
	                        <div class="table-responsive">
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
	                                        <th style="width:5%;">项目编号</th>
	                                        <th style="width:10%;">项目名称</th>
	                                        <th style="width:10%;">联系人</th>
	                                        <th style="width:10%;">联系人电话</th>
	                                        <th style="width:10%;">项目状态</th>	                                        
	                                        <th style="width:15%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty itemList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${itemList}" var="var" >
													<tr>
														<td><input type="checkbox" class="i-checks" name='ids' id='${var.item_id}' value='${var.item_id}' ></td>
														<td>${var.item_no}</td>
														<td>${var.item_name}</td>
														<td>${var.order_org_contact==""?"未填":var.order_org_contact}</td>
														<td>${var.order_org_phone==""?"未填":var.order_org_phone}</td>
														<td>
															${var.item_status=="2"?"报价":""}
														</td>
														<td>
															<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
															</c:if>
															<div>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn btn-sm btn-info btn-sm" title="查看" type="button" onclick="edit('${var.item_id}','sel');">查看</button>
																</c:if>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn btn-sm btn-primary btn-sm" title="编辑" type="button" onclick="edit('${var.item_id}','edit');">编辑</button>
																	<button class="btn  btn-warning btn-sm" title="报价" type="button" onclick="addOffer('${var.item_id}')" >报价</button>
																</c:if>
																<c:if test="${var.offerState == 1}">
																	<button class="btn  btn-success btn-sm" title="折扣" type="button" onclick="discount('${var.item_id}')" >折扣</button>
																</c:if>
																<c:if test="${QX.del == 1 }">
																	<%-- <button class="btn btn-sm btn-danger btn-sm" title="删除" type="button" onclick="del('${var.item_id}','${var.item_name}');">删除</button> --%>
																</c:if>
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
									<input type="button" class="btn btn-outline btn-warning" value="导出" onclick="toExcelView()" id="toExcel" name="toExcel">
									<input type="button" class="btn btn-outline btn-primary" onclick="importExcelView()" id="importExcel" name="importExcel" value="导入">
									<input type="hidden" id="importType" name="importType">
									<input style="display: none" class="form-control" type="file"  title="导入" id="importFile" onchange="importExcel(this)"/>
									${page.pageStr}
									<c:if test="${QX.add == 1 }">
										<!-- <button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button> -->
									</c:if>
									<c:if test="${QX.del == 1 }">
										<!-- <button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>	 -->					
									</c:if>
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
        <div class="ibox float-e-margins" id="toExcelContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
			<div class="ibox-content">
				<div>
					<h5><a target="_blank" href="<%=basePath%>offer/toExcelOffer.do">报价信息</a></h5><br>
					<h5>-----------------------------------------------------------</h5><br>
					<h5><a target="_blank" href="<%=basePath%>elevator/toExcelElevatorAudit.do">电梯种类审核</a></h5><br>
					<h5><a target="_blank" href="<%=basePath%>elevator/toExcelElevatorDetails.do">电梯信息</a></h5><br>
					<h5><a target="_blank" href="<%=basePath%>elevator/toExcelElevatorHeight.do">电梯提升高度价格</a></h5><br>
					<h5><a target="_blank" href="<%=basePath%>elevator/toExcelProductInfo.do">产品信息</a></h5><br>					
					<h5><a target="_blank" href="<%=basePath%>elevator/toExcelElevatorSpec.do">电梯规格</a></h5><br>
					<%-- <h5><a target="_blank" href="<%=basePath%>elevator/toExcelElevatorNum.do">elevatorNum</a></h5><br> --%>
					<%-- <h5><a target="_blank" href="<%=basePath%>elevator/toExcelModels.do">电梯型号</a></h5><br> --%>
					<%-- <h5><a target="_blank" href="<%=basePath%>elevator/toExcelElevatorOptional.do">elevatorOptional</a></h5><br> --%>
					<%-- <h5><a target="_blank" href="<%=basePath%>elevator/toExcelElevatorInfo.do">elevatorInfo</a></h5><br> --%>
					<%-- <h5><a target="_blank" href="<%=basePath%>elevator/toExcelElevatorNonstandard.do">elevatorNonstandard</a></h5><br> --%>
				    <%-- <h5><a target="_blank" href="<%=basePath%>elevator/toExcelElevatorBase.do">电梯基础配置</a></h5><br> --%>
				</div>
			</div>
		</div>
		<div class="ibox float-e-margins" id="importExcelContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
			<div class="ibox-content">
				<div>
					<h5><a href="javascript:inputFile('offer')">报价信息</a></h5><br>
					<h5>------------------------------------------------------------</h5><br>
					<h5><a href="javascript:inputFile('elevatorAudit')">电梯种类审核</a></h5><br>
					<h5><a href="javascript:inputFile('elevatorDetails')">电梯信息</a></h5><br>
					<h5><a href="javascript:inputFile('elevatorHeight')">电梯提升高度</a></h5><br>
					<h5><a href="javascript:inputFile('elevatorSpec')">电梯规格</a></h5><br>
					<h5><a href="javascript:inputFile('productInfo')">产品信息</a></h5><br>
					<!-- <h5><a href="javascript:inputFile('elevatorNum')">elevatorNum</a></h5><br> -->
					<!-- <h5><a href="javascript:inputFile('elevatorInfo')">电梯订单详情</a></h5><br> -->
					<!-- <h5><a href="javascript:inputFile('elevatorNonstandard')">非标配置</a></h5><br> -->
					<!-- <h5><a href="javascript:inputFile('elevatorOptional')">可选项配置</a></h5><br> -->
					<!-- <h5><a href="javascript:inputFile('elevatorBase')">基础项配置</a></h5><br> -->
					<!-- <h5><a href="javascript:inputFile('elevator')">电梯梯种</a></h5><br> -->
				</div>
			</div>
		</div>
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

            $("body").click(function(event){
				event  =  event  ||  window.event; // 事件 
		        var  target    =  event.target  ||  ev.srcElement; // 获得事件源 
		        var  obj  =  target.getAttribute('id');
		        if(obj!='toExcel'){
					$("#toExcelContent").hide();
		        }
		        if(obj!='importExcel'){
		        	$("#importExcelContent").hide();
		        }
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


      	//弹出导出框
		function toExcelView(){
			var toExcelObj = $("#toExcel");
			var toExcelOffset = $("#toExcel").offset();
			$("#toExcelContent").css({left:(toExcelOffset.left+6) + "px", top:toExcelOffset.top + toExcelObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
		}

		//弹出导入框
		function importExcelView(){
			var importExcelObj = $("#importExcel");
			var importExcelOffset = $("#importExcel").offset();
			$("#importExcelContent").css({left:(importExcelOffset.left+6) + "px", top:importExcelOffset.top + importExcelObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
		}

		//选择导入文件
		function inputFile(str){
			$("#importType").val(str);
			$("#importFile").click();
		}

		//导入Excel
		function importExcel(e){
			var url;
			var importType = $("#importType").val();
			if(importType=="offer"){
				url = "<%=basePath%>offer/importExcelOffer.do";
			}else if(importType=="elevator"){
				url = "<%=basePath%>elevator/importExcelElevator.do";
			}else if(importType=="elevatorAudit"){
				url = "<%=basePath%>elevator/importExcelElevatorAudit.do";
			}else if(importType=="elevatorBase"){
				url = "<%=basePath%>elevator/importExcelElevatorBase.do";
			}else if(importType=="elevatorDetails"){
				url = "<%=basePath%>elevator/importExcelElevatorDetails.do";
			}else if(importType=="elevatorHeight"){
				url = "<%=basePath%>elevator/importExcelElevatorHeight.do";
			}else if(importType=="elevatorInfo"){
				url = "<%=basePath%>elevator/importExcelElevatorInfo.do";
			}else if(importType=="elevatorNonstandard"){
				url = "<%=basePath%>elevator/importExcelElevatorNonstandard.do";
			}else if(importType=="elevatorNum"){
				url = "<%=basePath%>elevator/importExcelElevatorNum.do";
			}else if(importType=="elevatorOptional"){
				url = "<%=basePath%>elevator/importExcelElevatorOptional.do";
			}else if(importType=="elevatorSpec"){
				url = "<%=basePath%>elevator/importExcelElevatorSpec.do";
			}else if(importType=="productInfo"){
				url = "<%=basePath%>elevator/importExcelProductInfo.do";
			}
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
	            return false;
	        }
	        var data = new FormData();
        	data.append("file", $(e)[0].files[0]);
        	console.log($(e)[0].files[0]);
        	$.ajax({
	            url: url,
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
	                	});
	                }else{
	                    swal({
	                    	title:"导入失败!",
	                    	text:"导入数据失败,"+result.errorMsg,
	                    	type:"error"
	                    });
	                }
	            }
	        });
		}


        //报价
        function addOffer(id){
        	console.log("offerId"+id);
        	$("#EditOffer").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "报价",
		        actions: ["Close"],
		        content: '<%=basePath%>offer/toOfferEdit.do?item_id='+id,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
        }

        //申请折扣
        function discount(id){
        	$("#EditDiscount").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "新增折扣申请",
	        actions: ["Close"],
	        content: '<%=basePath%>discount/goAddDiscount.do?item_id='+id,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
        }

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
      	//刷新iframe
        function refreshCurrentTab() {
        	$("#OfferForm").submit();
        }
		//检索
		function search(){
			$("#OfferForm").submit();
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



		/*function hideMenu(event){
			event  =  event  ||  window.event; // 事件 
	        var  target    =  event.target  ||  ev.srcElement; // 获得事件源 
	        var  obj  =  target.getAttribute('id');
	        if(obj!='toExcel'){
				$("#toExcelContent").hide();
	        }
	        if(obj!='importExcel'){
	        	$("#importExcelContent").hide();
	        }
		}*/
		</script>
</body>
</html>


