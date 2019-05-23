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
            
          //编辑时加载方案图信息
    		var drawingJSON = $("#so_drawing_json").val();
    		if(drawingJSON!=""){
    			setDrawingJSON(drawingJSON);
    		}
    		
        });
        //保存
        function save() {
            if ($("#so_name").val() == "" && $("#so_name").val() == "") {
                $("#so_name").tips({
                    side: 3,
                    msg: "请输入方案名称",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#so_name").focus();
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
            if ($("#house_name2").val() == "" && $("#house_name2").val() == "") {
                $("#house_name2").tips({
                    side: 3,
                    msg: "请选择所属户型",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#house_name2").focus();
                return false;
            }
            if ($("#so_price").val() == "" && $("#so_price").val() == "") {
                $("#so_price").tips({
                    side: 3,
                    msg: "请输入建议价格",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#so_price").focus();
                return false;
            }
            
            var h="a";
            var json = "[";
            //拼接为json格式保存
    		$("#solution").find("div").each(function(){
    			h = $(this).find("input").eq(0).val();
    			json += "{\'so_drawing\':\'"+h+"\'},";
    		});
    		json = json.substring(0,json.length-1)+"]";
            if(h!="a"&&h!="")
            {
            	$("#so_drawing_json").val(json);
            }
            else
            {
            	 $("#so_drawing_json").val("");	
            }
            
            
            $("#shopForm").submit();
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
			addSolutionImg();
		}
		 for(var i = 0;i<obj.length;i++){
			$("#solution").find("div").eq(i).each(function(){
				$(this).find("input").eq(0).val(obj[i].so_drawing);
			});
		} 
	}    
</script>
</head>

<body class="gray-bg">
	<form action="solution/${msg}.do" name="shopForm" id="shopForm"method="post">
	<input type="hidden" name="house_name" id="house_name" value="${pd.houseType_id}"/>
	<input type="hidden" name="houses_name" id="houses_name" value="${pd.houses_no}"/>
	<input type="hidden" name="so_drawing_json" id="so_drawing_json" value="${pd.so_drawing}"/>
	
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
                            <div class="panel panel-primary">
                               <div class="panel-heading">户型解决方案信息</div>
                                  <div class="panel-body">
								     <div class="form-group form-inline">
									    <label style="width: 15%">方案编号:</label>
										<input style="width: 30%" type="text" name="so_id" id="so_id" value="${pd.so_id}" readonly
											placeholder="这里输入方案编号" title="方案编号" class="form-control" />
										<span style="color: red;margin-left:11px">*</span>
									    <label style="width: 15%;">方案名称:</label>
										<input style="width: 30%" type="text" name="so_name" id="so_name"
										 value="${pd.so_name}" placeholder="这里输入方案名称" title="方案名称" class="form-control">
								     </div>
				<!-- ***************************如果是新增进来显示*************************** -->
								     <c:if test="${msg=='saveS'}">
								     <div class="form-group form-inline">
								     <span style="color: red;margin-left: -11px">*</span>
									    <label style="width: 15%">所属楼盘:</label>
										 <select style="width:30%" class="form-control" name="houses_name" id="houses_name" disabled="disabled">
										   <option value="">请选择</option>
										   <c:forEach items="${housesList}" var="hou">
										     <option value="${hou.houses_no}"
										     <c:if test="${hou.houses_no eq pd.houses_no && pd.houses_no != ''}">selected</c:if>>${hou.houses_name}</option>
										   </c:forEach>
									     </select>
									     <span style="color: red;margin-left: 11px">*</span>
									    <label style="width: 15%;">所属户型:</label>
										<select style="width:30%" class="form-control" name="house_name" id="house_name2" disabled="disabled">
										<option value="">请选择</option>
										<c:forEach items="${houseTypeList}" var="hou">
											<option value="${hou.hou_id}"
												<c:if test="${hou.hou_id eq pd.houseType_id && pd.houseType_id != ''}">selected</c:if>>${hou.hou_name}</option>
										</c:forEach>
									    </select>
								     </div>
								     </c:if>
				<!-- ***************************如果是 编辑进来显示*************************** -->				     
								     <c:if test="${msg=='editS'}">
								     <div class="form-group form-inline">
								     <span style="color: red;margin-left: -11px">*</span>
									    <label style="width: 15%">所属楼盘:</label>
										 <select onchange="SelHouseType()" class="selectpicker" data-live-search="true" data-width="30%" name="houses_name" id="houses_name2">
										   <option value="">请选择</option>
										   <c:forEach items="${housesList}" var="hou">
										     <option value="${hou.houses_no}"
										     <c:if test="${hou.houses_no eq pd.houses_no && pd.houses_no != ''}">selected</c:if>>${hou.houses_name}</option>
										   </c:forEach>
									     </select>
									     <span style="color: red;margin-left:11px">*</span>
									    <label style="width: 15%;">所属户型:</label>
										<select style="width:30%" class="form-control" name="house_name" id="house_name2">
										<option value="">请选择</option>
										<c:forEach items="${houseTypeList}" var="hou">
											<option value="${hou.hou_id}"
												<c:if test="${hou.hou_id eq pd.houseType_id && pd.houseType_id != ''}">selected</c:if>>${hou.hou_name}</option>
										</c:forEach>
									    </select>
								     </div>
								     </c:if>
								     
								     <div class="form-group form-inline">
								       <span style="color: red;margin-left: -11px">*</span>
								       <label style="width: 15%;">建议价格:</label>
										<input style="width: 30%" type="text" name="so_price" id="so_price" value="${pd.so_price}" 
											placeholder="这里输入建议价格" title="建议价格" class="form-control" />
								     </div>
					   <!-- ********************实现多个方案图纸上传***** -->
								 <div id="solution">
								     <div class="form-group form-inline">
								           <label style="width: 15%">方案图纸:</label> 
								           <input class="form-control" type="hidden" name="so_drawing" id="so_drawing" />
										   <input style="width: 30%" class="form-control" type="file" name="drawing" id="drawing" 
										     title="安装队保险" onchange="upload(this)" />
										   <c:if test="${msg== 'saveS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addSolutionImg();">加</button>
									         <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
									       </c:if>
									       <c:if test="${msg== 'editS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addSolutionImg2();">加</button>
									          <c:if test="${pd.so_drawing==null || pd.so_drawing=='' }">
									             <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									            title="查看" type="button" onclick="imgChack(this);">查看</button> 
									          </c:if>
									         <c:if test="${pd ne null and pd.so_drawing ne null and pd.so_drawing ne '' }">
									         <button  style="margin-left:3px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
										     <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
									       </c:if> 
									        </c:if>
								     </div>
							</div>
							
							
                                     <div class="form-group form-inline">
									   <label style="width: 15%">方案描述:</label>
										<input style="width: 80%" type="text" name="so_describe" id="so_describe" 
										value="${pd.so_describe}" placeholder="这里输入方案描述" title="方案描述" class="form-control" />
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
<script type="text/javascript">
//选中楼盘后 加载属于该楼盘的户型信息
function SelHouseType()
{
	 var houses_id=$("#houses_name2").val(); 
	$.ajax({
		url : "cell/SelhuseType.do", //请求地址
		type : "POST", //请求方式
		data : {
			'houses_id' : houses_id
		}, //请求参数
		success : function(result) {
			$("#house_name2").empty();
			var jsonObj = result.houseTypeList;
			var str = "<option value=''>请选择</option>";
			for(var i =0;i<jsonObj.length;i++){
				str += "<option value='"+jsonObj[i].hou_id+"'>"+jsonObj[i].hou_name+"</option>";
			}
			$("#house_name2").html(str);
		}
	});
}

//实现多个户型图附件上传
var j=0;
function addSolutionImg(){
j = j + 1;
$("#solution").append('<div id="solution'+j+'" class="form-group form-inline">'+
		                '<label style="width: 15%">方案图纸:</label> '+
						'<input class="form-control" type="hidden" name="so_drawing" id="so_drawing"/>'+
						'<input style="width: 30%" class="form-control" type="file" name="drawing" id="drawing" '+
						'title="安装队保险" onchange="upload(this)" />'+
                         '<button style="margin-left:3px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
		                   'title="删除" type="button"onclick="delSolutionImg('+j+');">减</button>'+ 
		                   '<c:if test="${msg==\'saveS\'}">'+ 
							'<button  style="margin-left:6px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" '+ 
							'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
							'</c:if>'+ 
							'<c:if test="${msg==\'editS\'}">'+ 
							 '<button  style="margin-left:6px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" '+ 
							 'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
							'</c:if>'+ 
		                   '<c:if test="${pd ne null and pd.so_drawing ne null and pd.so_drawing ne '' }">'+
			               '  <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>'+
		                   '</c:if>'+
	                       '</div>'
     );   
}

function addSolutionImg2(){
	j = j + 1;
	$("#solution").append('<div id="solution'+j+'" class="form-group form-inline">'+
			               '<label style="width: 15%">方案图纸:</label> '+
			               '<input class="form-control" type="hidden" name="so_drawing" id="so_drawing"/>'+
				           '<input style="width: 30%" class="form-control" type="file" name="drawing" id="drawing" '+
				             'title="安装队保险" onchange="upload(this)" />'+
                           '<button style="margin-left:3px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
                             'title="删除" type="button"onclick="delSolutionImg('+j+');">减</button>'+ 
					       '<button  style="margin-left:6px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" '+ 
					        'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
		                    '</div>'
	     );   
	}

//删除户型图附件上传
function delSolutionImg(o)
{
	 document.getElementById("solution").removeChild(document.getElementById("solution"+o));
}

</script>
</html>
