<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
<title>${pd.SYSNAME}</title>
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css" />
<!-- Sweet Alert -->
<link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
<style type="text/css">
.ztree li span.button.add {
	margin-left: 2px;
	margin-right: -1px;
	background-position: -144px 0;
	vertical-align: top;
	*vertical-align: middle
}
</style>
</head>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>

<script type="text/javascript">
		var setting = {
				view: {
					addHoverDom: addHoverDom,
					removeHoverDom: removeHoverDom,
					selectedMulti: false
				},
				edit: {
					enable: true,
					editNameSelectAll: true,
					showRemoveBtn: showRemoveBtn,
					showRenameBtn: showRenameBtn,
					editNameSelectAll:true
				},
				data: {
					simpleData: {
						enable: true
					}
				},
				callback: {
					beforeDrag: beforeDrag,
					beforeEditName: beforeEditName,
					beforeRemove: beforeRemove,
					beforeRename: beforeRename,
					onRemove: onRemove,
					onRename: onRename,
					beforeClick: beforeClick
				}
			};

		var zNodes =${regions};
			var log, className = "dark";
			function beforeDrag(treeId, treeNodes) {
				return false;
			}
			function beforeEditName(treeId, treeNode) {
				className = (className === "dark" ? "":"dark");
				var zTree = $.fn.zTree.getZTreeObj("myzTree");
				zTree.selectNode(treeNode);
				return true;
			}
			function beforeRemove(treeId, treeNode) {
				className = (className === "dark" ? "":"dark");
				var zTree = $.fn.zTree.getZTreeObj("myzTree");
				zTree.selectNode(treeNode);
				
				return confirmDelByzTree(treeNode.id,treeNode.name,treeNode);
			}
			function onRemove(e, treeId, treeNode) {
				return true;
			}
			function beforeRename(treeId, treeNode, newName, isCancel) {
				className = (className === "dark" ? "":"dark");
				if (newName.length == 0) {
					swal({   
			        	title: "节点名称不能为空！",
			        	text: "请重新输入。",
			        	type: "error",
			        	timer:1500,
			        	showConfirmButton: false
			        	 });
					var zTree = $.fn.zTree.getZTreeObj("myzTree");
					setTimeout(function(){zTree.editName(treeNode)}, 10);
					return false;
				}
				return true;
			}
			function onRename(e, treeId, treeNode, isCancel) {
				confirmEditByzTree(treeNode.id,treeNode.name);
			}
			//删除权限
			var canRemove = (${QX.del}==1)?true:false;
			function showRemoveBtn(treeId, treeNode) {
				 return !treeNode.isParent&&canRemove; 
			}
			//修改权限
			var canRename = (${QX.edit}==1)?true:false;
			function showRenameBtn(treeId, treeNode) {
				return canRename;
			}
			function getTime() {
				var now= new Date(),
				h=now.getHours(),
				m=now.getMinutes(),
				s=now.getSeconds(),
				ms=now.getMilliseconds();
				return (h+":"+m+":"+s+ " " +ms);
			}

			//新增权限
			var canAdd = (${QX.add}==1)?true:false;
			var newCount = 1;
			function addHoverDom(treeId, treeNode) {
				if(canAdd){
					var sObj = $("#" + treeNode.tId + "_span");
					if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
					var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
						+ "' title='add node' onfocus='this.blur();'></span>";
					sObj.after(addStr);
					var btn = $("#addBtn_"+treeNode.tId);
					if (btn) btn.bind("click", function(){
						addByzTree(treeNode.id,treeNode.name,treeNode);
						return false;
					});
				}else{
					return false;
				}
				
			};
			
			function removeHoverDom(treeId, treeNode) {
				$("#addBtn_"+treeNode.tId).unbind().remove();
			};
			//刷新iframe
	        function refreshCurrentTab() {
	        	$("#regionForm").submit();
	        };
	        
	        
		//zTree新增
    	function addByzTree(pId,pName,treeNode) {
			swal({   
	        	title: "您确定要在[" + pName + "]下创建一个子节点吗？",
	        	text: "请填写节点名称:",
	        	type: "input",  
	        	showCancelButton: true,   
	        	closeOnConfirm: false,   
	        	animation: "slide-from-top",   
	        	inputPlaceholder: "请这这里输入名称" }, 
	        	function(inputValue){   
	        		if (inputValue === false)
	        			return false;      
	        		if (inputValue === "") {     
	        			swal.showInputError("请输入名称!");     
	        			return false  
	        			}else{
	        				var url = "<%=basePath%>region/addRegion.do?pId=" + pId + "&name="+ inputValue + "&tm=" + new Date().getTime();
	        				$.get(url, function(data) {
	        					if (data.msg == 'success') {
	        						swal({   
	        				        	title: "新增成功！",
	        				        	text: "您已经成功成功新增一条记录。",
	        				        	type: "success",  
	        				        	 }, 
	        				        	function(){   
	        				        		 var zTree = $.fn.zTree.getZTreeObj("myzTree");
	 	        							zTree.addNodes(treeNode, {id:data.id, pId:treeNode.id, name:inputValue});
	        				        	 });
	        					} else {
	        						swal("新增失败", data.err, "error");
	        					}
	        				});
	        			}      
	        		});
	    };
	      //新增
	        function add() {
	    	  	var pId = $("#pId").val();
	    	  	if(pId==""||pId==null){
	    	  		$("#pId").tips({
	    				side:3,
	    	            msg:"请填写父类ID",
	    	            bg:'#AE81FF',
	    	            time:2
	    	        });
	    	  		$("#pId").focus();
	    			return false;
	    		}
	    	  	var name = $("#name").val();
	    	  	if(name==""||name==null){
	    	  		$("#name").tips({
	    				side:3,
	    	            msg:"请填写名称",
	    	            bg:'#AE81FF',
	    	            time:2
	    	        });
	    	  		$("#name").focus();
	    			return false;
	    		}
	        	var url = "<%=basePath%>region/addRegion.do?pId=" + pId + "&name="+ name + "&tm=" + new Date().getTime();
				$.get(url, function(data) {
					if (data.msg == 'success') {
						swal({   
				        	title: "新增成功！",
				        	text: "您已经成功新增一条记录。",
				        	type: "success",  
				        	 }, 
				        	function(){   
				        		 refreshCurrentTab(); 
				        	 });
					} else {
						swal("新增失败", data.err, "error");
					}
				});
	};
	//确认zTree删除
	function confirmDelByzTree(pId,name,treeNode){
		swal({
            title: "您确定要删除["+name+"]吗？",
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
            	var url = "<%=basePath%>region/delRegion.do?id=" + treeNode.id + "&tm=" + new Date().getTime();
				$.get(url,function(data){
					if(data.msg=="success"){
						swal({   
				        	title: "删除成功！",
				        	text: "您已经成功删除了这条数据。",
				        	type: "success"
				        	 }, 
					        	function(){//隐藏右边视图   
				        		$("#rightdiv").css("display","none");
				        	 });
						}else{
							swal({   
					        	title: "删除失败！",
					        	text: "您的删除操作失败了！",
					        	type: "error",  
					        	 }, 
					        	function(){   
					        		 refreshCurrentTab(); 
					        	 });
						}
					});
						
			}else{
				swal({   
		        	title: "取消删除！",
		        	text: "您已经取消删除操作了！",
		        	type: "error",  
		        	 }, 
		        	function(){   
		        		 refreshCurrentTab(); 
		        	 });
			}
	});
	}
	//确认zTree修改名称
	function confirmEditByzTree(id,name){
		var url = "<%=basePath%>region/editRegion.do?id=" + id + "&name="+ name + "&tm=" + new Date().getTime();
		$.get(url,function(data){
			if(data.msg=="success"){
				swal({   
		        	title: "修改成功！",
		        	text: "您已经成功修改了这条数据。",
		        	type: "success",
		        	timer:1500,
		        	showConfirmButton: false
		        	 });
				}else{
					swal({   
			        	title: "修改失败！",
			        	text: "您的修改操作失败了！",
			        	type: "error",  
			        	 }, 
			        	function(){   
			        		 refreshCurrentTab(); 
			        	 });
				}
			});
	}
	//点中
	function beforeClick(treeId, treeNode, clickFlag) {
		$("#rightdiv").css("display","block");
		$("#right_id").text(treeNode.id);
		$("#right_name").text(treeNode.name);
		$("#right_pId").text(treeNode.pId);
	}
	//折叠全部
    function collapseAll() {
    	var zTree = $.fn.zTree.getZTreeObj("myzTree");
    	zTree.expandAll(false);
    };
  	//展开全部
    function expandAll() {
    	var zTree = $.fn.zTree.getZTreeObj("myzTree");
    	zTree.expandAll(true);
    };

    //导出
    function toExcel(){
        document.getElementById("alink_toExcel").click();
    }
    //触发导入
    function importRegion(){
        $("#importFile").click();
    }
    function importExcel(e){
        var url = "<%=basePath%>region/importExcelRegion.do";
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
	$(document).ready(function() {
		//loading end
		parent.layer.closeAll('loading');
		$.fn.zTree.init($("#myzTree"), setting, zNodes);
		var zTree = $.fn.zTree.getZTreeObj("myzTree");
		zTree.expandAll(true);
		
	});
</script>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div id="editRegion" class="animated fadeIn"></div>
		<div class="row">
			<div class="col-sm-12">
				<!-- 上方新增、按钮视图 -->
				 <c:choose>
                     <c:when test="${QX.add == 1}">
                     <div class="ibox float-e-margins">
						<div class="ibox-content" style="padding: 10px 10px 10px 10px;">
							<form role="form" class="form-inline"
								action="region/listRegions.do" method="post" name="regionForm"
								id="regionForm">
								<div class="form-group ">
									<input autocomplete="off" id="pId" type="text" name="pId"
										placeholder="这里输入父类ID" class="form-control">
								</div>
								<div class="form-group ">
									<input autocomplete="off" id="name" type="text" name="name"
										placeholder="这里输入名称" class="form-control">
								</div>
								<div class="form-group">
									<button type="button" class="btn  btn-primary " onclick="add();"
										style="margin-bottom: 0px;" title="新增">新增</button>
								</div>
                                <div class="form-group">
                                    <button type="button" class="btn  btn-warning btn-outline" onclick="toExcel();"
                                            style="margin-bottom: 0px;" title="导出">导出
                                    </button>
                                    <a id="alink_toExcel" target="_blank" href="<%=basePath%>region/toExcelRegion.do" style="display: none"><span></span></a>
                                </div>
                                <div class="form-group">
                                    <button type="button" class="btn btn-primary btn-outline" onclick="importRegion();"
                                            style="margin-bottom: 0px;" title="导入">导入
                                    </button>
                                    <input style="display: none" class="form-control" type="file"  title="导入" id="importFile" onchange="importExcel(this)"/>
                                </div>
								<div class="form-group" style="float: right;margin-right: 10px;">
								<button class="btn  btn-success" title="刷新" type="button"
									style="margin-bottom: 0px;"  onclick="refreshCurrentTab();">刷新</button>
								</div>	
								<div class="form-group" style="float: right;margin-right: 10px;">
								<button class="btn  btn-warning" title="折叠" type="button"
									style="margin-bottom: 0px;"  onclick="collapseAll();">折叠</button>
								</div>
								<div class="form-group" style="float: right;margin-right: 10px;">	
								<button class="btn  btn-info" title="展开" type="button"
									style="margin-bottom: 0px;" onclick="expandAll();">展开</button>
								</div>	
							</form>
						</div>
					</div>
                     </c:when>
               		 <c:otherwise>
                 	<div class="ibox float-e-margins">
                 	<div style="padding: 0px 10px 10px 10px;">
							<form role="form" class="form-inline"
								action="region/listRegions.do" method="post" name="regionForm"
								id="regionForm">
								<div class="form-group" style="float: right;margin-right: 10px;">
								<button class="btn  btn-success" title="刷新" type="button"
									style="margin-bottom: 0px;"  onclick="refreshCurrentTab();">刷新</button>
								</div>	
								<div class="form-group" style="float: right;margin-right: 10px;">
								<button class="btn  btn-warning" title="折叠" type="button"
									style="margin-bottom: 0px;"  onclick="collapseAll();">折叠</button>
								</div>
								<div class="form-group" style="float: right;margin-right: 10px;">	
								<button class="btn  btn-info" title="展开" type="button"
									style="margin-bottom: 0px;" onclick="expandAll();">展开</button>
								</div>	
							</form>
						</div>
					</div>
                 	 </c:otherwise>
                 </c:choose>
				
				<!-- 左边zTree视图 -->
				
				<div id="leftdiv" name="leftdiv" class="col-sm-6" style="height:700px;overflow-y:scroll;overflow-x:auto;
							<c:choose>
								 <c:when test='${not empty regions and QX.cha == 1|| QX.edit == 1|| QX.del == 1||QX.add == 1}'>display:block;</c:when>
								 <c:otherwise>display:none;</c:otherwise>
							</c:choose>
							 ">
					<div class="ibox float-e-margins">
						<div class="ibox-content">
						<div id="myzTree" class="ztree"></div>
						</div>
					</div>
				</div>
				<c:if test="${QX.cha == 1|| QX.edit == 1|| QX.del == 1||QX.add == 1}">
				<!-- 右边属性视图 -->
				 <div id="rightdiv" name="rightdiv" class="col-sm-6" style="display:none">
					<div class="ibox float-e-margins">
						<div class="ibox-content">
							<div class="table-responsive">
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                        <th>ID</th>
	                                        <th>名称</th>
	                                        <th>父类ID</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
										<tr>
											<td id="right_id" name="right_id"></td>
											<td id="right_name" name="right_name"></td>
											<td id="right_pId" name="right_pId"></td>
										</tr>
                                </tbody>
	                            </table>
	                        </div>
						</div>
					</div>
				</div> 
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>


