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
<html>

<head>

<base href="<%=basePath%>">


<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<title>${pd.SYSNAME}</title>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>
<!-- Fancy box -->
<script src="static/js/fancybox/jquery.fancybox.js"></script>
<link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
<script type="text/javascript">
        $(document).ready(function () {
            /* 图片 */
            $('.fancybox').fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });
            //编辑时加载户型图信息
    		var drawingJSON = $("#drawing_json").val();
    		if(drawingJSON!=""){
    			setDrawingJSON(drawingJSON);
    		}
          
        });
        //保存
        function save() {
            if ($("#hou_name").val() == "" && $("#hou_name").val() == "") {
                $("#hou_name").tips({
                    side: 3,
                    msg: "请输入户型名称",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#hou_name").focus();
                return false;
            }
            
            if ($("#houses_name2").val() == "" && $("#houses_name2").val() == "") {
                $("#houses_name2").tips({
                    side: 3,
                    msg: "请选择所属楼盘",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#houses_name2").focus();
                return false;
            }
            
            var h="";
            var json = "[";
            //拼接为json格式保存
    		$("#houseImg").find("div").each(function(){
    			h = $(this).find("input").eq(0).val();
    			json += "{\'hou_drawing\':\'"+h+"\'},";
    		});
    		json = json.substring(0,json.length-1)+"]";
            if(h!=""&&h!=null)
            {
            	$("#drawing_json").val(json);
            }
            else
            {
            	 $("#drawing_json").val("");	
            }
            
            
            $("#shopForm").submit();
        }
        
        //判断户型名称是否已存在
        function HouseTypeName() {
            var name = $("#hou_name").val();
            var url = "<%=basePath%>houseType/HouseTypeName.do?hou_name=" + name + "&tm="
				+ new Date().getTime();
		$.get(url, function(data) {
			if (data.msg == "error") {
				$("#hou_name").focus();
				$("#hou_name").tips({
					side : 3,
					msg : '户型名称已存在',
					bg : '#AE81FF',
					time : 3
				});
				setTimeout("$('#hou_name').val('')", 2000);
			}
		});
	}
        
        
        
        
        
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
	}
	
	//文件异步上传  
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
		var downFile = $(e).prev().prev().prev().prev().val();
		window.location.href = "cell/down?downFile=" + downFile;
	}
	//查看户型图附件
	function imgChack(a)
	{
		var src=$(a).prev().prev().prev().val();
		window.open("uploadFiles/file/"+src,"_blank");
	}
	
	 //编辑时加载户型图信息 
	function setDrawingJSON(supp){
		var obj = eval("("+supp+")");
		for(var j = 0;j<obj.length-1;j++){
			addHouseImg();
		}
		 for(var i = 0;i<obj.length;i++){
			$("#houseImg").find("div").eq(i).each(function(){
				$(this).find("input").eq(0).val(obj[i].hou_drawing);
			});
		} 
	}    
</script>
</head>

<body class="gray-bg">
	<form action="houseType/${msg}.do" name="shopForm" id="shopForm"method="post">
		<input type="hidden" name="houses_name" id="houses_name" value="${pd.houses_id}"/>
		<input type="hidden" name="drawing_json" id="drawing_json" value="${pd.hou_drawing}"/>
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
                            <div class="panel panel-primary">
                               <div class="panel-heading">户型基本信息</div>
                                  <div class="panel-body">
								     <div class="form-group form-inline">
									    <label style="width: 15%">户型编号:</label>
										<input style="width: 30%" type="text" name="hou_id" id="hou_id" value="${pd.hou_id}" readonly
											placeholder="这里输入户型编号" title="户型编号" class="form-control" />
										<span style="color: red;margin-left:10px;">*</span>
									    <label style="width: 15%;">户型名称:</label>
										<input style="width: 30%" type="text" name="hou_name" id="hou_name"
										 value="${pd.hou_name}" placeholder="这里输入户型名称" title="户型名称" onblur="HouseTypeName()" class="form-control">
								     </div>
								     <c:if test="${msg=='saveS'}">
								        <c:if test="${pd.houses_id!='saveS'}">
								           <div class="form-group form-inline">
								           <span style="color: red;margin-left: -11px">*</span>
									         <label style="width: 15%">所属楼盘:</label>
										       <select style="width:30%" class="form-control" name="houses_name" id="houses_name" disabled="disabled">
										         <option value="">请选择</option>
										         <c:forEach items="${housesList}" var="hou">
											     <option value="${hou.houses_no}"
											  	 <c:if test="${hou.houses_no eq pd.houses_id && pd.houses_id != ''}">selected</c:if>>${hou.houses_name}</option>
										         </c:forEach>
									           </select>
								          </div>
								        </c:if>
								        <c:if test="${pd.houses_id=='saveS'}">
								            <div class="form-group form-inline">
								            <span style="color: red;margin-left: -11px">*</span>
									         <label style="width: 15%">所属楼盘:</label>
										       <select style="width:30%" class="form-control" name="houses_name" id="houses_name2" readonly>
										         <option value="">请选择</option>
										         <c:forEach items="${housesList}" var="hou">
											     <option value="${hou.houses_no}"
											  	 <c:if test="${hou.houses_no eq pd.houses_id && pd.houses_id != ''}">selected</c:if>>${hou.houses_name}</option>
										         </c:forEach>
									           </select>
								          </div>
								        </c:if>
								     </c:if>
								     
								     <c:if test="${msg=='editS'}">
								        <div class="form-group form-inline">
								            <span style="color: red;margin-left: -11px">*</span>
									         <label style="width: 15%">所属楼盘:</label>
										       <select style="width:30%" class="form-control" name="houses_name" id="houses_name2" readonly>
										         <option value="">请选择</option>
										         <c:forEach items="${housesList}" var="hou">
											     <option value="${hou.houses_no}"
											  	 <c:if test="${hou.houses_no eq pd.houses_id && pd.houses_id != ''}">selected</c:if>>${hou.houses_name}</option>
										         </c:forEach>
									           </select>
								          </div>
								     </c:if>
				<!-- *********实现多个户型图上传*********** -->
				                <div id="houseImg">
								   <div class="form-group form-inline">
								      <label style="width: 15%">户型图附件:</label> 
								        <input class="form-control" type="hidden" name="hou_drawing" id="hou_drawing" />
										<input style="width: 30%" class="form-control" type="file" name="houDrawing" id="houDrawing"
										 onchange="upload(this)" placeholder="这里输入安装队保险" title="安装队保险"/>
									<c:if test="${msg== 'saveS' }">
									  <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									  title="添加" type="button"onclick="addHouseImg();">加</button>
									  <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									  title="查看" type="button" onclick="imgChack(this);">查看</button> 
									</c:if>
									<c:if test="${msg== 'editS' }">
									  <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									  title="添加" type="button"onclick="addHouseImg2();">加</button>
									     <c:if test="${pd.hou_drawing==null || pd.hou_drawing=='' }">
									         <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
									     </c:if>
									<c:if test="${pd ne null and pd.hou_drawing ne null and pd.hou_drawing ne '' }">
									    <button  style="margin-left:3px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" 
									    title="查看" type="button" onclick="imgChack(this);">查看</button> 
										<a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
									</c:if> 
									</c:if>
								  </div>
						</div>	  
                                  <div class="form-group form-inline">
									  <label style="width: 15%">户型描述:</label>
									<input style="width: 80%" type="text" name="explain" id="explain" 
									value="${pd.hou_explain}" placeholder="这里输入户型描述" title="户型描述" class="form-control" />
								</div>
							 </div>
						</div>
					</div>
				</div>
              </div>
			<div style="height: 20px;"></div>
				<tr>
					<td>
					  <a class="btn btn-primary" style="width: 150px; height: 34px; float: left; margin-left: 30px;" 
					    onclick="save();">保存</a>
					</td>
					<td>
					  <a class="btn btn-danger" style="width: 150px; height: 34px; float: right; margin-right: 30px;"
							onclick="javascript:CloseSUWin('EditShops');">关闭</a>
					</td>
			   </tr>   
		</div>
	</form>
</body>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript">
//实现多个户型图附件上传
var j=0;
function addHouseImg(){
j = j + 1;
$("#houseImg").append('<div id="houseImg'+j+'" class="form-group form-inline">'+
		                '<label style="width: 15%">户型图附件:</label> '+
                        '<input class="form-control" type="hidden" name="hou_drawing"/>'+
                         '<input style="width: 30%" class="form-control" type="file" name="houDrawing" id="houDrawing"'+
                         ' onchange="upload(this)" placeholder="这里输入安装队保险" title="安装队保险"/> '+
                         '<button style="margin-left:3px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
		                   'title="删除" type="button"onclick="delHouseImg('+j+');">减</button>'+ 
		                   '<c:if test="${msg==\'saveS\'}">'+ 
							'<button  style="margin-left:6px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" '+ 
							'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
							'</c:if>'+ 
							'<c:if test="${msg==\'editS\'}">'+ 
							 '<button  style="margin-left:6px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" '+ 
							 'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
							'</c:if>'+ 
		                   '<c:if test="${pd ne null and pd.hou_drawing ne null and pd.hou_drawing ne '' }">'+
			               '  <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>'+
		                   '</c:if>'+
	                       '</div>'
     );   
}

function addHouseImg2(){
	j = j + 1;
	$("#houseImg").append('<div id="houseImg'+j+'" class="form-group form-inline">'+
			                '<label style="width: 15%">户型图附件:</label> '+
	                        '<input class="form-control" type="hidden" name="hou_drawing"/>'+
	                         '<input style="width: 30%" class="form-control" type="file" name="houDrawing" id="houDrawing"'+
	                         ' onchange="upload(this)" placeholder="这里输入安装队保险" title="安装队保险"/> '+
	                         '<button style="margin-left:3px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
			                 'title="删除" type="button"onclick="delHouseImg('+j+');">减</button>'+ 
							'<button  style="margin-left:6px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" '+ 
							'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
		                    '</div>'
	     );   
	}

//删除户型图附件上传
function delHouseImg(o)
{
	 document.getElementById("houseImg").removeChild(document.getElementById("houseImg"+o));
}
</script>
</html>
