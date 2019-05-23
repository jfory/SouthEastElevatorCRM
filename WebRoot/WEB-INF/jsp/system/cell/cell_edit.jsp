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
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>


<!-- 日期控件-->
<script src="static/js/layer/laydate/laydate.js"></script>
<script type="text/javascript">


     $(document).ready(function () {
            /* 图片 */
            $('.fancybox').fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });
            
          //编辑时加载供应商信息
    		var supplierJSON = $("#supplierJSON").val();
    		if(supplierJSON!=""){
    			setSupplierJSON(supplierJSON);
    		}
    		 //编辑时加载单元房型图信息
    		var drawingJSON = $("#house_type_json").val();
    		if(drawingJSON!=""){
    			setHoseTypeJSON(drawingJSON);
    		}
    		
    		 //编辑时加载    图纸 （东南）
    		var drawingJSON = $("#dn_drawing_json").val();
    		if(drawingJSON!=""){
    			setDrawing_(drawingJSON);
    		}
    		
    		 //编辑时加载    现场照片 （东南）
    		var drawingJSON = $("#dn_picture_json").val();
    		if(drawingJSON!=""){
    			setPicture_(drawingJSON);
    		}
    		
    		 //编辑时加载   解决方案 （东南）
    		var drawingJSON = $("#dn_solution_json").val();
    		if(drawingJSON!=""){
    			setSolution_(drawingJSON);
    		}
        });
        
     
        function save1()
        {
        	
        	//修改单元名称时判断数据库是否存在相同名称
        if($("#cell_name").val()!= $("#cellname").val())
        {
        	  var name = $("#cell_name").val();
        	  var houses_no=$('input[name="houses_name"]').val();
              var url = "<%=basePath%>cell/CellName.do?cell_name=" + name+ "&houses_no=" + houses_no + "&tm=" + new Date().getTime();
			$.get(url, function(data) {
				if (data.msg == "error") {
					$("#cell_name").focus();
					$("#cell_name").tips({
						side : 3,
						msg : '单元名称已存在',
						bg : '#AE81FF',
						time : 3
					});
					setTimeout("$('#cell_name').val('')", 2000);
				} else {
					save();
				}
			});
		} else {
			save();
		}
	}
	//保存
	function save() {

		if ($("#cell_name").val() == "" && $("#cell_name").val() == "") {
			$("#cell_name").focus();
			$("#cell_name").tips({
				side : 3,
				msg : "请输入单元名称",
				bg : '#AE81FF',
				time : 3
			});

			return false;
		}
		if ($("#cell_well").val() == "" && $("#cell_well").val() == "") {
			$("#cell_well").focus();
			$("#cell_well").tips({
				side : 3,
				msg : "请输入井道类型",
				bg : '#AE81FF',
				time : 3
			});

			return false;
		}
		
		if ($("#install_").val() == "0") {
			$("#install_").focus();
			$("#install_").tips({
				side : 3,
				msg : "请选择是否有装梯公司",
				bg : '#AE81FF',
				time : 3
			});

			return false;
		}
		
		if ($("#install_").val() == "1" && $("#in_option").val()=="0") {
			$("#in_option").focus();
			$("#in_option").tips({
				side : 3,
				msg : "请选择装梯公司",
				bg : '#AE81FF',
				time : 3
			});

			return false;
		}
		
		 //拼接供应商信息    +++++++++++++++++++++
		var a = "";
		var b = "";
		var c = "";
		var jsonStr = "[";
		$("#supplier").find("div").each(function(){
			var a=$(this).find("input").eq(0).val();
			var b=$(this).find("input").eq(1).val();
			var c=$(this).find("select").eq(0).val();
			jsonStr += "{\'supp_name\':\'"+a+"\',\'supp_phone\':\'"+b+"\',\'supp_type\':\'"+c+"\'},";
		});
		jsonStr = jsonStr.substring(0,jsonStr.length-1)+"]";
        $("#supplierJSON").val(jsonStr);

        //拼接单元房型图附件地址    +++++++++++++++++++++
        var h="a";
        var json = "[";
        //拼接为json格式保存
		$("#Cell_houseType").find("div").each(function(){
			h = $(this).find("input").eq(0).val();
			json += "{\'house_type_img\':\'"+h+"\'},";
		});
		json = json.substring(0,json.length-1)+"]";
        if(h!="a"&&h!="")
        {
        	$("#house_type_json").val(json);
        }
        else
        {
        	 $("#house_type_json").val("");	
        }
        
        //保存实现多个图纸
        var d="a";
        var json = "[";
        //拼接为json格式保存
		$("#drawing_").find("div").each(function(){
			d = $(this).find("input").eq(0).val();
			json += "{\'dn_drawing\':\'"+d+"\'},";
		});
		json = json.substring(0,json.length-1)+"]";
        if(d!="a"&&d!="")
        {
        	$("#dn_drawing_json").val(json);
        }
        else
        {
        	 $("#dn_drawing_json").val("");	
        }
        
        
        //保存实现多个现场照片 
        var p="a";
        var json = "[";
        //拼接为json格式保存
		$("#picture_").find("div").each(function(){
			p = $(this).find("input").eq(0).val();
			json += "{\'dn_picture\':\'"+p+"\'},";
		});
		json = json.substring(0,json.length-1)+"]";
        if(p!="a"&&p!="")
        {
        	$("#dn_picture_json").val(json);
        }
        else
        {
        	 $("#dn_picture_json").val("");	
        }
        
        
        
      //保存实现多个解决方案 
        var s="a";
        var json = "[";
        //拼接为json格式保存
		$("#solution_").find("div").each(function(){
			s = $(this).find("input").eq(0).val();
			json += "{\'dn_solution\':\'"+s+"\'},";
		});
		json = json.substring(0,json.length-1)+"]";
        if(s!="a"&&s!="")
        {
        	$("#dn_solution_json").val(json);
        }
        else
        {
        	 $("#dn_solution_json").val("");	
        }
        
		$("#cellForm").submit();
	}

	//编辑时加载电梯信息
	function setSupplierJSON(supp){
		var obj = eval("("+supp+")");
		for(var j = 0;j<obj.length-1;j++){
			addSupplier();
		}
		for(var i = 0;i<obj.length;i++){
			$("#supplier").find("div").eq(i).each(function(){
				$(this).find("input").eq(0).val(obj[i].supp_name);
				$(this).find("input").eq(1).val(obj[i].supp_phone);
				$(this).find("select").eq(0).val(obj[i].supp_type);
			});
		}
		/* setElevatorModelWhenEdit(obj.length-1,obj); */
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
	//查看单元房型图附件
	function imgChack(a)
	{
		var src=$(a).prev().prev().prev().val();
		window.open("uploadFiles/file/"+src,"_blank");
	}
	
	 //编辑时加载单元房型图信息
	function setHoseTypeJSON(supp){
		var obj = eval("("+supp+")");
		for(var j = 0;j<obj.length-1;j++){
			addCellHoseType();
		}
		 for(var i = 0;i<obj.length;i++){
			$("#Cell_houseType").find("div").eq(i).each(function(){
				$(this).find("input").eq(0).val(obj[i].house_type_img);
			});
		} 
	}    
	 
	 //编辑时加载图纸（东南）
	function setDrawing_(supp){
		var obj = eval("("+supp+")");
		for(var j = 0;j<obj.length-1;j++){
			addDrawing_();
		}
		 for(var i = 0;i<obj.length;i++){
			$("#drawing_").find("div").eq(i).each(function(){
				$(this).find("input").eq(0).val(obj[i].dn_drawing);
			});
		} 
	}    
	
	//编辑时加载现场照片 （东南）
	function setPicture_(supp){
		var obj = eval("("+supp+")");
		for(var j = 0;j<obj.length-1;j++){
			addPicture_();
		}
		 for(var i = 0;i<obj.length;i++){
			$("#picture_").find("div").eq(i).each(function(){
				$(this).find("input").eq(0).val(obj[i].dn_picture);
			});
		} 
	}  
	
	
	//编辑时加载解决方案  （东南）
	function setSolution_(supp){
		var obj = eval("("+supp+")");
		for(var j = 0;j<obj.length-1;j++){
			addSolution_();
		}
		 for(var i = 0;i<obj.length;i++){
			$("#solution_").find("div").eq(i).each(function(){
				$(this).find("input").eq(0).val(obj[i].dn_solution);
			});
		} 
	}  
</script>


</head>

<body class="gray-bg">
	<form action="cell/${msg}.do" name="cellForm" id="cellForm" method="post">
		    <input type="hidden" name="cellname" id="cellname" value="${pd.cell_name}" /> 
			<input type="hidden" name="houses_name" id="houses_name1" value="${pd.houses_no}" />
			<input type="hidden" name="supplierJSON" id="supplierJSON" value="${pd.supplier}"/>
			<input type="hidden" name="hou_id" id="hou_id" value="${pd.house_id}" />
			<input type="hidden" name="house_type_json" id="house_type_json" value="${pd.house_type_img}" />
			<input type="hidden" name="dn_drawing_json" id="dn_drawing_json" value="${pd.dn_drawing}" />
			<input type="hidden" name="dn_picture_json" id="dn_picture_json" value="${pd.dn_picture}" />
			<input type="hidden" name="dn_solution_json" id="dn_solution_json" value="${pd.dn_solution}" />
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
							<div class="panel panel-primary">
								<div class="panel-heading">单元基本信息</div>
								<div class="panel-body">
										<div class="row" style="margin-left: 10px">
											<div class="form-group form-inline">
											    <span style="color: red;">*</span> <label style="width: 15%">单元编号:</label>
												<input style="width: 30%" type="text" name="cell_id" readonly="readonly" id="cell_id" 
												value="${pd.cell_id}" placeholder="单元编号由系统自动生成" title="单元编号" class="form-control" />
												<span style="color: red;margin-left:19px">*</span> <label style="width: 15%;">单元名称:</label>
												<input style="width: 30%" type="text" name="cell_name"
													id="cell_name" value="${pd.cell_name}"
													placeholder="这里输入单元名称" title="单元名称"
													class="form-control" />
											</div>
								<!-- *******************如果是新增进来的显示**************************** -->
										 <c:if test="${msg== 'saveS' }"> 
											<div class="form-group form-inline">
												<c:if test="${pd.houses_no=='' || pd.houses_no==null}">
												<span style="color: red;">*</span>
													<label style="width: 15%">所属楼盘:</label>
													<select onchange="SelHouseType()" name="houses_name" id="houses_name2" class="selectpicker" data-live-search="true" data-width="30%">
														<option value="">请选择</option>
														<c:forEach items="${housesList}" var="hou">
															<option value="${hou.houses_no}"
																<c:if test="${hou.houses_no eq pd.houses_no}">selected</c:if>>${hou.houses_name}</option>
														</c:forEach>
													</select>
													<span style="color: red;margin-left:19px">*</span>
													<label style="width:15%;">所属户型:</label> 
											        <select style="width: 30%" class="form-control" name="hou_id" readonly id="hou_id2">
													  <option value="">请选择</option>
													</select>
													  <%-- <c:forEach items="${houseTypeList}" var="hou">
											            <option value="${hou.hou_id}"
												           <c:if test="${hou.hou_id eq pd.house_id && pd.house_id != ''}">selected</c:if>>${hou.hou_name}</option>
										              </c:forEach> --%>
												   
												</c:if>
												<!-- 从户型发来  新增请求 -->
												<c:if test="${pd.houses_no!='' && pd.houses_no!=null}">
												    <span style="color: red;">*</span>
													<label style="width: 15%">所属楼盘:</label>
													<select disabled="disabled" style="width: 30%"
														class="form-control" name="houses_name" readonly
														id="houses_name3">
														<option value="">请选择</option>
														<c:forEach items="${housesList}" var="hou">
															<option value="${hou.houses_no}"
																<c:if test="${hou.houses_no eq pd.houses_no}">selected</c:if>>${hou.houses_name}</option>
														</c:forEach>
													</select>
													<c:if test="${cell== 'houseType' }"> 
													<span style="color: red;margin-left:19px;">*</span>
													<label style="width: 15%;">所属户型:</label> 
											        <select disabled="disabled" style="width: 30%" class="form-control" name="hou_id" id="hou_id">
													    <option value="">请选择</option>
												        	<c:forEach items="${houseTypeList}" var="hou">
											                  <option value="${hou.hou_id}"
												               <c:if test="${hou.hou_id eq pd.house_id && pd.house_id != ''}">selected</c:if>>${hou.hou_name}</option>
										                    </c:forEach>
												   </select>
												   </c:if>
												   <c:if test="${cell== 'houses' }"> 
												   <span style="color: red;margin-left:19px;">*</span>
													<label style="width: 15%;">所属户型:</label> 
											        <select style="width: 30%" class="form-control" name="hou_id" id="hou_id2">
													    <option value="">请选择</option>
												        	<c:forEach items="${houseTypeList}" var="hou">
											                  <option value="${hou.hou_id}"
												               <c:if test="${hou.hou_id eq pd.house_id && pd.house_id != ''}">selected</c:if>>${hou.hou_name}</option>
										                    </c:forEach> 
												   </select>
												   </c:if>
												</c:if>
											</div>
										</c:if>
									<!-- ******************如果是编辑打开页面显示******************* -->
											<c:if test="${msg== 'editS' }">
											  <div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">所属楼盘:</label>
												<select onchange="SelHouseType()" name="houses_name" id="houses_name2" class="selectpicker" data-live-search="true" data-width="30%">
													<option value="">请选择</option>
													<c:forEach items="${housesList}" var="hou">
														<option value="${hou.houses_no}"
															<c:if test="${hou.houses_no eq pd.houses_no}">selected</c:if>>${hou.houses_name}</option>
													</c:forEach>
												</select> 
												<span style="color: red;margin-left:19px;">*</span>
												<label style="width: 15%;">所属户型:</label> 
											     <select style="width: 30%" class="form-control" readonly name="hou_id" id="hou_id2">
													<option value="">请选择</option>
													<c:forEach items="${houseTypeList}" var="hou">
											          <option value="${hou.hou_id}"
												         <c:if test="${hou.hou_id eq pd.house_id && pd.house_id != ''}">selected</c:if>>${hou.hou_name}</option>
										            </c:forEach>
												</select>
											</div>
											</c:if>
											
											<div class="form-group form-inline">
												<span style="color: red;">*</span> <label style="width: 15%">井道类型:</label>
												<select style="width: 30%" class="form-control"
													name="cell_well" readonly id="cell_well">
													<option value="">请选择</option>
													<c:forEach items="${wellList}" var="well">
														<option value="${well.well_id}"
															<c:if test="${well.well_id eq pd.cell_well}">selected</c:if>>${well.well_name}</option>
													</c:forEach>
												</select>
												<label style="width: 15%;margin-left:28px">是否已装修:</label> <select
													style="width: 30%" class="form-control"
													name="cell_decorate" readonly id="cell_decorate">
													<option value="">请选择</option>
													<option value="1"
														<c:if test="${pd.cell_decorate=='1'}"> selected</c:if>>是</option>
													<option value="2"
														<c:if test="${pd.cell_decorate=='2'}"> selected</c:if>>否</option>
												</select>
											</div>
											<div class="form-group form-inline">
												<span type="hidden">&nbsp&nbsp</span> <label
													style="width: 15%">是否预留井道:</label> <select
													style="width: 30%" class="form-control"
													name="cell_Reserved_well" readonly id="cell_Reserved_well">
													<option value="">请选择</option>
													<option value="1"
														<c:if test="${pd.cell_Reserved_well =='1'}"> selected</c:if>>是</option>
													<option value="2"
														<c:if test="${pd.cell_Reserved_well =='2'}"> selected</c:if>>否</option>
												</select> 
												<label style="width:15%;margin-left:28px">所属业主:</label> 
											        <select style="width: 30%" class="form-control" name="customer_no" readonly id="customer_no">
													  <option value="">请选择</option>
													  <c:forEach items="${merchantList}" var="mer">
											            <option value="${mer.customer_no}"
												           <c:if test="${mer.customer_no eq pd.customer_no && pd.customer_no != ''}">selected</c:if>>${mer.customer_name}</option>
										              </c:forEach>
												   </select>
												
											</div>
										<!-- *****************实现多个单元房型图********* -->	
									  <div id="Cell_houseType">
											<div class="form-group form-inline">
												<!-- 上传文件 -->
												<label style="width:15%;margin-left: 10px;">单元房型图附件:</label>
												<input class="form-control" type="hidden" name="house_type_img" id="house_type_img"/> 
												<input style="width: 30%" class="form-control" type="file"
													name="houseimg" id="houseimg" placeholder="这里输入安装队保险"
													title="安装队保险" onchange="upload(this)" />
											<c:if test="${msg== 'saveS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addCellHoseType();">加</button>
									         <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
									       </c:if>
									       <c:if test="${msg== 'editS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addCellHoseType2();">加</button>
									          <c:if test="${pd.house_type_img==null || pd.house_type_img=='' }">
									             <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									            title="查看" type="button" onclick="imgChack(this);">查看</button> 
									          </c:if>
									         <c:if test="${pd ne null and pd.house_type_img ne null and pd.house_type_img ne '' }">
									         <button  style="margin-left:3px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
										     <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
									       </c:if> 
									        </c:if>
										</div>
										
									</div>	
											<div class="form-group form-inline">
											    <span type="hidden">&nbsp&nbsp</span>
									           	<label style="width: 15%">住户信息描述:</label> <input
													style="width: 80%" type="text" type="text"
													name="house_owner_info" id="house_owner_info"
													value="${pd.house_owner_info}" placeholder="这里输入住户信息描述"
													title="住户信息描述" class="form-control">
											</div>
										</div>
								</div>
							</div>
                            <div class="panel panel-primary">
								<div class="panel-heading">单元基础尺寸</div>
								<div class="panel-body">
								    <div class="form-group form-inline">
										<label style="width: 15%;margin-left:20px;">顶层高度(mm):</label> 
										<input style="width: 30%" type="text" type="text" name="top_height" 
											id="top_height" value="${pd.top_height}" placeholder="这里输入顶层高度" 
											title="顶层高度" class="form-control">
										<label style="width: 15%;margin-left:20px;">地坑深度(mm):</label> 
										<input style="width: 30%" type="text" type="text" name="pit_deepness" 
											id="pit_deepness" value="${pd.pit_deepness}" placeholder="这里输入地坑深度" 
											title="地坑深度" class="form-control">
									  </div>
									  <div class="form-group form-inline">
										<label style="width: 15%;margin-left:20px;">井道宽(mm):</label> 
										<input style="width: 30%" type="text" type="text" name="well_breadth" 
											id="well_breadth" value="${pd.well_breadth}" placeholder="这里输入井道宽" 
											title="井道宽" class="form-control">
										<label style="width: 15%;margin-left:20px;">井道深(mm):</label> 
										<input style="width: 30%" type="text" type="text" name="well_deepness"  
											id="well_deepness" value="${pd.well_deepness}" placeholder="这里输入井道深" 
											title="井道深" class="form-control">
									  </div>
									  <div class="form-group form-inline">
										<label style="width: 15%;margin-left:20px;">层数:</label> 
										<input style="width: 30%" type="text" type="text" name="tiers" 
											id="tiers" value="${pd.tiers}" placeholder="这里输入层数" 
											title="层数" class="form-control">
										<label style="width: 15%;margin-left:20px;">井道结构:</label> 
										<select style="width: 30%" class="form-control" name="well_structure" readonly id="well_structure">
											<option value="">请选择</option>
											<option value="1" <c:if test="${pd.well_structure =='1'}"> selected</c:if>>铝合金框架</option>
											<option value="2" <c:if test="${pd.well_structure =='2'}"> selected</c:if>>土建</option>
											<option value="3" <c:if test="${pd.well_structure =='3'}"> selected</c:if>>钢结构</option>
										</select> 
									  </div>
								</div>
                           </div>
                           <div class="panel panel-primary">
							<div class="panel-heading">供应商信息</div>
							  <div class="panel-body" id="supplier">
							      <div class="form-group form-inline">
										<label style="width: 10%">公司名称:</label> 
										<input style="width: 22%" type="text" type="text" name="supp_name" 
											id="supp_name" value="${pd.supp_name}" placeholder="这里输入公司名称" 
											title="层数" class="form-control">
										<label style="width: 8%;margin-left:5px;">电话:</label> 
										<input style="width: 22%" type="text" type="text" name="supp_phone" 
											id="supp_phone" value="${pd.supp_phone}" placeholder="这里输入公司电话" 
											title="层数" class="form-control">
										<label style="width: 8%;margin-left:5px;">类型:</label> 
										<select style="width: 20%" class="form-control" name="supp_type" readonly id="supp_type">
											<option value="">请选择</option>
											<option value="1" <c:if test="${pd.supp_type =='1'}"> selected</c:if>>装修公司</option>
											<option value="2" <c:if test="${pd.supp_type =='2'}"> selected</c:if>>设计工作室</option>
											<option value="3" <c:if test="${pd.supp_type =='3'}"> selected</c:if>>设备供应商</option>
										</select> 
										<button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" title="添加" type="button"onclick="addSupplier();">加</button>
								</div>
							  </div>
							</div>

							<div class="panel panel-primary">
								<div class="panel-heading">装梯信息</div>
								<div class="panel-body">
									<div class="row" style="margin-left: 10px">
			<!-- 新增进来显示的页面+++++++++++++++++++++++++++++++++++++++++++++ -->
									<c:if test="${msg== 'saveS' }">
									<div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">是否有装梯公司:</label> 
													<select style="width: 30%" class="form-control"
													name="install_" readonly id="install_">
													<option value="0">请选择</option>
													<option value="1">是</option>
													<option value="2">否</option>
												</select> 
									</div> 
									
									
									<!-- 装梯公司选项 -->
									<div id="install_option" style="display:none" class="form-group form-inline">										
										 <span style="color: red;">*</span>
										 <label style="width: 15%;">选择装梯公司:</label>
										 <select style="width: 30%" class="form-control" name="in_option" readonly id="in_option">
													<option value="">请选择</option>
													<option value="1">竞争对手安装</option>
													<option value="2">东南电梯安装</option>
												</select> 
										</div>
										<!-- **竞争对手信息*** -->
										<div id="comp_install" value="1" style="display:none">
											<div class="form-group form-inline">
												 <label style="width: 15%;margin-left:10px;">对手公司名称:</label>
												 <select class="selectpicker" data-live-search="true" data-width="30%" name="comp_name" readonly id="comp_name">
													<option value="0">请选择</option>
													<c:forEach items="${competitorList}" var="comp">
														<option value="${comp.comp_id}"
															<c:if test="${comp.comp_id eq pd.comp_id && pd.comp_id != ''}">selected</c:if>>${comp.comp_name }</option>
													</c:forEach>
												</select> 
												<label style="width: 15%;margin-left:10px;">进驻渠道:</label>
												 <select style="width: 30%" class="form-control" name="comp_referral" readonly id="comp_referral">
													<option value="">请选择</option>
													<option value="1">物业推荐</option>
										            <option value="2">设计机构</option>
									            	<option value="3">业主自行采购</option>
									            	<option value="4">电梯代理商</option>
									            	<option value="5">朋友推荐</option>
												</select> 
											</div>
											<div class="form-group form-inline">
											   <label style="width: 15%;margin-left:10px;">型号描述:</label>
											   <input style="width: 30%" type="text" name="comp_model" id="comp_model"
											    value="${pd.comp_brand}" placeholder="这里输入型号描述" title="型号描述" class="form-control">
											   <label style="width: 15%;margin-left:10px;">配置描述:</label>
											   <input style="width: 30%" type="text" name="comp_deploy" id="comp_deploy" 
											   value="${pd.comp_drive_mode}" placeholder="这里输入配置描述" title="配置描述" 
											   class="form-control">
										   </div>
										</div>
										
										<!-- **东南信息*** -->
										<div id="dn_install" value="1" style="display:none">
											<div class="form-group form-inline">
												<label style="width: 15%;margin-left:10px;">渠道来源:</label>
												 <select style="width: 30%" class="form-control" name="dn_referral" readonly id="dn_referral">
													<option value="">请选择</option>
													<option value="1">物业推荐</option>
										            <option value="2">设计机构</option>
									            	<option value="3">业主自行采购</option>
									            	<option value="4">电梯代理商</option>
									            	<option value="5">朋友推荐</option>
												</select> 
												<label style="width:15%;margin-left:10px">户型解决方案:</label> 
											        <select style="width: 30%" class="form-control" name="solution_no" readonly id="solution_no">
													  <option value="">请选择</option>
													 <c:forEach items="${solutionList}" var="sol">
											            <option value="${sol.so_id}"
												           <c:if test="${sol.so_id eq pd.solution_no && pd.solution_no != ''}">selected</c:if>>${sol.so_name}</option>
										              </c:forEach> 
												   </select>
											</div>
											<!-- 实现多个图纸 -->
										<div id="drawing_">
											 <div class="form-group form-inline">
											     <label style="width: 15%;margin-left:10px;">图纸:</label>
												 <input class="form-control" type="hidden" name="dn_drawing" id="dn_drawing"/>
											    <input style="width: 30%" class="form-control" type="file"
													name="drawing" id="drawing" placeholder="这里选择图纸文件"
													title="房型图文件" onchange="upload(this)" />
										    <c:if test="${msg== 'saveS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addDrawing_();">加</button>
									         <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
									       </c:if>
									       <c:if test="${msg== 'editS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addDrawing_2();">加</button>
									          <c:if test="${pd.dn_drawing==null || pd.dn_drawing=='' }">
									             <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									            title="查看" type="button" onclick="imgChack(this);">查看</button> 
									          </c:if>
									         <c:if test="${pd ne null and pd.dn_drawing ne null and pd.dn_drawing ne '' }">
									         <button  style="margin-left:3px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
										     <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
									       </c:if> 
									        </c:if>
									    </div>
									</div>
											<!-- 实现多个现场完工照片 -->
											<div id="picture_">
											    <div class="form-group form-inline">
											      <label style="width: 15%;margin-left:10px;">现场完工照片:</label>
											      <input class="form-control" type="hidden" name="dn_picture" id="dn_picture" />
											      <input style="width: 30%" class="form-control" type="file"
													  name="picture" id="picture" placeholder="这里选择现场照片文件"
													  title="现场照片文件" onchange="upload(this)" />
											<c:if test="${msg== 'saveS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addPicture_();">加</button>
									         <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
									       </c:if>
									       <c:if test="${msg== 'editS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addPicture_2();">加</button>
									          <c:if test="${pd.dn_picture==null || pd.dn_picture=='' }">
									             <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									            title="查看" type="button" onclick="imgChack(this);">查看</button> 
									          </c:if>
									         <c:if test="${pd ne null and pd.dn_picture ne null and pd.dn_picture ne '' }">
									         <button  style="margin-left:3px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
										     <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
									       </c:if> 
									      </c:if>
									</div>
								</div>
											<!-- 实现多个解决方案 -->
											<div id="solution_">
											  <div class="form-group form-inline">
											   <label style="width: 15%;margin-left:10px;">解决方案:</label>
											   <input class="form-control" type="hidden" name="dn_solution" id="dn_solution"/>
											    <input style="width: 30%" class="form-control" type="file" name="solution" id="solution"
													title="解决方案文件" onchange="upload(this)" />
												 <c:if test="${msg== 'saveS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addSolution_();">加</button>
									         <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
									       </c:if>
									       <c:if test="${msg== 'editS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addSolution_2();">加</button>
									          <c:if test="${pd.dn_solution==null || pd.dn_solution=='' }">
									             <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									            title="查看" type="button" onclick="imgChack(this);">查看</button> 
									          </c:if>
									         <c:if test="${pd ne null and pd.dn_solution ne null and pd.dn_solution ne '' }">
									         <button  style="margin-left:3px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
										     <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
									       </c:if> 
									        </c:if>
										  </div>
										 </div>
								  </div>
								 <div id="install" style="display:none">
										<div class="form-group form-inline">
										 <label style="width: 15%;margin-left:10px;">产品系列:</label>
											<input style="width: 30%" type="text" type="text"
												name="comp_brand" id="comp_brand" value="${pd.comp_brand}"
												placeholder="这里输入产品系列" title="产品系列" class="form-control">
										<label style="width:15%;margin-left:10px;">电梯驱动方式:</label>
											<input style="width: 30%" type="text" name="comp_drive_mode"
												id="comp_drive_mode" value="${pd.comp_drive_mode}"
												placeholder="这里输入电梯驱动方式" title="电梯驱动方式" class="form-control">
										</div>
										<div class="form-group form-inline">
											<label style="width: 15%;margin-left:10px;">电梯价格from:</label>
											<input style="width: 30%" type="text" type="text"
												name="comp_price_from" id="comp_price_from"
												value="${pd.comp_price_from}" placeholder="这里输入电梯价格from"
												title="电梯价格from" class="form-control"> 
											<label style="width: 15%;margin-left:10px;">电梯价格to:</label>
											<input style="width: 30%" type="text" name="comp_price_to"
												id="comp_price_to" value="${pd.comp_price_to}"
												placeholder="这里输入电梯价格to" title="电梯价格to" class="form-control">
										</div>
									</div>
									</c:if>		
					<!-- 编辑进来显示的页面++++++++++++++++++++++++++++++++++++++++++++++ -->
					   <c:if test="${msg== 'editS' }">
					                <div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">是否有装梯公司:</label> 
													<select style="width: 30%" class="form-control"
													name="install_" readonly id="install_">
													<option value="0">请选择</option>
													<option value="1" <c:if test="${pd.comp_id !=''}"> selected</c:if>>是</option>
													<option value="2" <c:if test="${pd.comp_id ==''}"> selected</c:if>>否</option>
												</select> 
									</div> 
					 				<!-- 装梯公司选项 -->
									<div id="install_option" style="display:none" class="form-group form-inline">										
										 <span style="color: red;">*</span> 
										 <label style="width: 15%;">选择装梯公司:</label>
										 <select style="width: 30%" class="form-control" name="in_option" readonly id="in_option">
													<option value="" <c:if test="${pd.comp_id ==''}"> selected</c:if>>请选择</option>
													<option value="1" <c:if test="${pd.comp_id !='dn001' && pd.comp_id !=''}"> selected</c:if>>竞争对手安装</option>
													<option value="2" <c:if test="${pd.comp_id =='dn001'}"> selected</c:if>>东南电梯安装</option>
												</select> 
										</div>
									
									<!-- 有装梯显示的信息 -->
									
										<!-- **竞争对手信息*** -->
										<div id="comp_install" value="1" style="display:none">
											<div class="form-group form-inline">
												 <label style="width: 15%;margin-left:10px;">对手公司名称:</label>
												 <select class="selectpicker" data-live-search="true" data-width="30%" name="comp_name" id="comp_name">
													<option value="">请选择</option>
													<c:forEach items="${competitorList}" var="comp">
														<option value="${comp.comp_id}"
															<c:if test="${comp.comp_id eq pd.comp_id && pd.comp_id != ''}">selected</c:if>>${comp.comp_name }</option>
													</c:forEach>
												</select> 
												<label style="width: 15%;margin-left:10px;">进驻渠道:</label>
												 <select style="width: 30%" class="form-control" name="comp_referral" readonly id="comp_referral">
													<option value="">请选择</option>
													<option value="1" <c:if test="${pd.comp_referral =='1'}"> selected</c:if>>物业推荐</option>
										            <option value="2" <c:if test="${pd.comp_referral =='2'}"> selected</c:if>>设计机构</option>
									            	<option value="3" <c:if test="${pd.comp_referral =='3'}"> selected</c:if>>业主自行采购</option>
									            	<option value="4" <c:if test="${pd.comp_referral =='4'}"> selected</c:if>>电梯代理商</option>
									            	<option value="5" <c:if test="${pd.comp_referral =='5'}"> selected</c:if>>朋友推荐</option>
												</select> 
											</div>
											<div class="form-group form-inline">
											   <label style="width: 15%;margin-left:10px;">型号描述:</label>
											   <input style="width: 30%" type="text" name="comp_model" id="comp_model"
											    value="${pd.comp_brand}" placeholder="这里输入型号描述" title="型号描述" class="form-control">
											   <label style="width: 15%;margin-left:10px;">配置描述:</label>
											   <input style="width: 30%" type="text" name="comp_deploy" id="comp_deploy" 
											   value="${pd.comp_drive_mode}" placeholder="这里输入配置描述" title="配置描述" 
											   class="form-control">
										   </div>
										</div>
										
										<!-- **东南信息*** -->
										<div id="dn_install" value="1" style="display:none">
											<div class="form-group form-inline">
												<label style="width: 15%;margin-left:10px;">渠道来源:</label>
												 <select style="width: 30%" class="form-control" name="dn_referral" readonly id="dn_referral">
													<option value="">请选择</option>
													<option value="1" <c:if test="${pd.dn_referral =='1'}"> selected</c:if>>物业推荐</option>
										            <option value="2" <c:if test="${pd.dn_referral =='2'}"> selected</c:if>>设计机构</option>
									            	<option value="3" <c:if test="${pd.dn_referral =='3'}"> selected</c:if>>业主自行采购</option>
									            	<option value="4" <c:if test="${pd.dn_referral =='4'}"> selected</c:if>>电梯代理商</option>
									            	<option value="5" <c:if test="${pd.dn_referral =='5'}"> selected</c:if>>朋友推荐</option>
												</select> 
												<label style="width:15%;margin-left:10px">户型解决方案:</label> 
											        <select style="width: 30%" class="form-control" name="solution_no" readonly id="solution_no">
													  <option value="">请选择</option>
													   <c:forEach items="${solutionList}" var="sol">
											            <option value="${sol.so_id}"
												           <c:if test="${sol.so_id eq pd.solution_no && pd.solution_no != ''}">selected</c:if>>${sol.so_name}</option>
										              </c:forEach> 
												   </select>
											</div>
										<!-- 实现多个图纸 -->
										  <div id="drawing_">
											 <div class="form-group form-inline">
											     <label style="width: 15%;margin-left:10px;">图纸:</label>
												 <input class="form-control" type="hidden" name="dn_drawing" id="dn_drawing"/>
											    <input style="width: 30%" class="form-control" type="file" name="drawing" 
											    id="drawing" title="房型图文件" onchange="upload(this)" />
												 <c:if test="${msg== 'saveS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addDrawing_();">加</button>
									         <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
									       </c:if>
									       <c:if test="${msg== 'editS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addDrawing_2();">加</button>
									          <c:if test="${pd.dn_drawing==null || pd.dn_drawing=='' }">
									             <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									            title="查看" type="button" onclick="imgChack(this);">查看</button> 
									          </c:if>
									         <c:if test="${pd ne null and pd.dn_drawing ne null and pd.dn_drawing ne '' }">
									         <button  style="margin-left:3px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
										     <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
									       </c:if> 
									        </c:if>
									    </div>
									</div>
											<!-- 实现多个现场完工照片 -->
											<div id="picture_">
											    <div class="form-group form-inline">
											      <label style="width: 15%;margin-left:10px;">现场完工照片:</label>
											      <input class="form-control" type="hidden" name="dn_picture" id="dn_picture"/>
											      <input style="width: 30%" class="form-control" type="file"
													  name="picture" id="picture" placeholder="这里选择现场照片文件"
													  title="现场照片文件" onchange="upload(this)" />
												  <c:if test="${msg== 'saveS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addPicture_();">加</button>
									         <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
									       </c:if>
									       <c:if test="${msg== 'editS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addPicture_2();">加</button>
									          <c:if test="${pd.dn_picture==null || pd.dn_picture=='' }">
									             <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									            title="查看" type="button" onclick="imgChack(this);">查看</button> 
									          </c:if>
									         <c:if test="${pd ne null and pd.dn_picture ne null and pd.dn_picture ne '' }">
									         <button  style="margin-left:3px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
										     <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
									       </c:if> 
									      </c:if>
										</div>
										</div>
										<!-- 实现多个解决方案 -->
											<div id="solution_">
											  <div class="form-group form-inline">
											   <label style="width: 15%;margin-left:10px;">解决方案:</label>
											   <input class="form-control" type="hidden" name="dn_solution" id="dn_solution" />
											    <input style="width: 30%" class="form-control" type="file"
													name="solution" id="solution" placeholder="这里选择解决方案文件"
													title="解决方案文件" onchange="upload(this)" />
												 <c:if test="${msg== 'saveS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addSolution_();">加</button>
									         <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
									       </c:if>
									       <c:if test="${msg== 'editS' }">
									         <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
									          title="添加" type="button"onclick="addSolution_2();">加</button>
									          <c:if test="${pd.dn_solution==null || pd.dn_solution=='' }">
									             <button  style="margin-left:3px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" 
									            title="查看" type="button" onclick="imgChack(this);">查看</button> 
									          </c:if>
									         <c:if test="${pd ne null and pd.dn_solution ne null and pd.dn_solution ne '' }">
									         <button  style="margin-left:3px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" 
									          title="查看" type="button" onclick="imgChack(this);">查看</button> 
										     <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
									       </c:if> 
									        </c:if>
										  </div>
										</div> 
								</div>
									
									 <div id="install" style="display:none">
										<div class="form-group form-inline">
										 <label style="width: 15%;margin-left:10px;">产品系列:</label>
											<input style="width: 30%" type="text" type="text"
												name="comp_brand" id="comp_brand" value="${pd.comp_brand}"
												placeholder="这里输入产品系列" title="产品系列" class="form-control">
										<label style="width:15%;margin-left:10px;">电梯驱动方式:</label>
											<input style="width: 30%" type="text" name="comp_drive_mode"
												id="comp_drive_mode" value="${pd.comp_drive_mode}"
												placeholder="这里输入电梯驱动方式" title="电梯驱动方式" class="form-control">
										</div>
										<div class="form-group form-inline">
											<label style="width: 15%;margin-left:10px;">电梯价格from:</label>
											<input style="width: 30%" type="text" type="text"
												name="comp_price_from" id="comp_price_from"
												value="${pd.comp_price_from}" placeholder="这里输入电梯价格from"
												title="电梯价格from" class="form-control"> 
											<label style="width: 15%;margin-left:10px;">电梯价格to:</label>
											<input style="width: 30%" type="text" name="comp_price_to"
												id="comp_price_to" value="${pd.comp_price_to}"
												placeholder="这里输入电梯价格to" title="电梯价格to" class="form-control">
										</div>
									</div>
								</c:if>
								</div>
							</div>
						</div>
					</div>

						<tr>
							<td><a class="btn btn-primary"
								style="width: 150px; height: 34px; float: left;"
								onclick="save1();">保存</a></td>
							<td><a class="btn btn-danger"
								style="width: 150px; height: 34px; float: right;"
								onclick="javascript:CloseSUWin('EditShops');">关闭</a></td>
						</tr>
					</div>

				</div>
			</div>
	</form>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		var id=$("#install_").val();
		if(id=="1")
		{
			$("#install_option").show();
		}
	});

	$(document).ready(function() {
		var id2=$("#in_option").val();
		if(id2=="1")
		{
			$("#comp_install").show();
			$("#install").show();
		}
		else if (id2=="2")
		{
			$("#dn_install").show();
			$("#install").show();
		}
	});

	
	
	//显示选择装梯公司选项
	$("#install_").change(function() {
		var id = $(this).find("option:checked").attr("value"); //获取选中值的编号
		if(id=="1")
		{
			$("#install_option").show();
		}else
		{
			$("#install_option").hide();
			$("#comp_install").hide();
			$("#dn_install").hide();
			$("#install").hide();
			$("#in_option").val("");
		}
		
	});
	
	//根据选择的装梯公司显示信息
	$("#in_option").change(function() {
		var id = $(this).find("option:checked").attr("value"); //获取选中值的编号
		if(id=="1")
		{
			$("#comp_install").show();
			$("#install").show();
			$("#dn_install").hide();
			
			$("#dn_drawing").val("");
			$("#drawing").val("");
			$("#dn_referral").val("");
			$("#solution_no").val("");
			$("#dn_picture").val("");
			$("#picture").val("");
			$("#dn_solution").val("");
			$("#solution").val("");
		}
		else if(id=="2")
		{
			$("#comp_install").hide();
			$("#dn_install").show();
			$("#install").show();
			
			$("#comp_name").val("0");
			$("#comp_referral").val("");
			$("#comp_model").val("");
			$("#comp_deploy").val("");
		}
		else
		{
			$("#comp_install").hide();
			$("#dn_install").hide();
			$("#install").hide();
			
			$("#dn_drawing").val("");
			$("#drawing").val("");
			$("#dn_referral").val("");
			$("#dn_picture").val("");
			$("#picture").val("");
			$("#dn_solution").val("");
			$("#solution").val("");
			$("#comp_name").val("0");
			$("#comp_referral").val("0");
			$("#comp_model").val("");
			$("#comp_deploy").val("");
		}
	});
	
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
				$("#hou_id2").empty();
				var jsonObj = result.houseTypeList;
				var str = "<option value=''>请选择</option>";
				for(var i =0;i<jsonObj.length;i++){
					str += "<option value='"+jsonObj[i].hou_id+"'>"+jsonObj[i].hou_name+"</option>";
				}
				$("#hou_id2").html(str);
			}
		});
	}
	
	
	//选中户型后 加载属于该户型的解决方案信息
	$("#hou_id2").change(function() 
	{
		var hou_id = $(this).find("option:checked").attr("value"); //获取选中值的编号
		$.ajax({
			url : "cell/selSolution.do", //请求地址
			type : "POST", //请求方式
			data : {
				'hou_id' : hou_id
			}, //请求参数
			success : function(result) {
				$("#solution_no").empty();
				var jsonObj = result.solutionList;
				var str = "<option value=''>请选择</option>";
				for(var i =0;i<jsonObj.length;i++){
					str += "<option value='"+jsonObj[i].so_id+"'>"+jsonObj[i].so_name+"</option>";
				}
				$("#solution_no").html(str);
			}
		});
	})
	
	var i=0;
	//实现多个供应商 
	function addSupplier(){
		 i = i + 1;
	     $("#supplier").append('<div id="supplier'+i+'" class="form-group form-inline">'+
			'<label style="width: 10%">公司名称:</label> '+
		'	<input style="width: 22%" type="text" type="text" name="supp_name" '+
		'		id="supp_name" value="${pd.supp_name}" placeholder="这里输入公司名称" '+
		'		title="层数" class="form-control">'+
			'<label style="width: 8%;margin-left:8px;">电话:</label> '+
		'	<input style="width: 22%" type="text"  name="supp_phone" '+
			'	id="supp_phone" value="${pd.supp_phone}" placeholder="这里输入公司电话" '+
			'	title="层数" class="form-control">'+
			'<label style="width: 8%;margin-left:9px;">类型:</label> '+
			'<select style="width: 20%" class="form-control" name="supp_type" readonly id="supp_type">'+
			'	<option value="">请选择</option>'+
			'	<option value="1" <c:if test="${pd.supp_type =='1'}"> selected</c:if>>装修公司</option>'+
			'	<option value="2" <c:if test="${pd.supp_type =='2'}"> selected</c:if>>设计工作室</option>'+
			'	<option value="3" <c:if test="${pd.supp_type =='3'}"> selected</c:if>>设备供应商</option>'+
			'</select> '+
			'<button style="margin-left:3px;margin-top:3px;" class="btn  btn-danger btn-sm" title="删除" type="button"onclick="delSupplier('+i+');">减</button>'+
	'</div>'
	     );   
	}
	//删除供应商
	function delSupplier(o)
	{
		 document.getElementById("supplier").removeChild(document.getElementById("supplier"+o));
	}
	
	
	//**************************实现多个单元房型图附件上传
	var j=0;
	function addCellHoseType(){
	j = j + 1;
	$("#Cell_houseType").append('<div id="Cell_houseType'+j+'" class="form-group form-inline">'+
			                     '<label style="width:15%;margin-left: 10px;">单元房型图附件:</label>'+
	                             '<input class="form-control" type="hidden" name="house_type_img" id="house_type_img"/> '+
	                             '<input style="width: 30%" class="form-control" type="file"'+
		                         'name="houseimg" id="houseimg" placeholder="这里输入安装队保险"'+
		                         'title="安装队保险" onchange="upload(this)" />'+
	                         '<button style="margin-left:6px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
			                   'title="删除" type="button"onclick="delCellHoseType('+j+');">减</button>'+ 
			                   '<c:if test="${msg==\'saveS\'}">'+ 
								'<button  style="margin-left:6px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" '+ 
								'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
								'</c:if>'+ 
								'<c:if test="${msg==\'editS\'}">'+ 
								 '<button  style="margin-left:6px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" '+ 
								 'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
								'</c:if>'+ 
			                   '<c:if test="${pd ne null and pd.house_type_img ne null and pd.house_type_img ne '' }">'+
				               '  <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>'+
			                   '</c:if>'+
		                       '</div>'
	     );   
	}

	function addCellHoseType2(){
		j = j + 1;
		$("#Cell_houseType").append('<div id="Cell_houseType'+j+'" class="form-group form-inline">'+
				                    '<label style="width:15%;margin-left: 10px;">单元房型图附件:</label>'+
                                    '<input class="form-control" type="hidden" name="house_type_img" id="house_type_img"/> '+
                                    '<input style="width: 30%" class="form-control" type="file"'+
                                    'name="houseimg" id="houseimg" placeholder="这里输入安装队保险"'+
                                    'title="安装队保险" onchange="upload(this)" />'+
	                                '<button style="margin-left:3px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
	                                'title="删除" type="button"onclick="delCellHoseType('+j+');">减</button>'+ 
						            '<button  style="margin-left:6px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" '+ 
						            'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
			                        '</div>'
		     );   
		}

	//删除户型图附件上传
	function delCellHoseType(o)
	{
		 document.getElementById("Cell_houseType").removeChild(document.getElementById("Cell_houseType"+o));
	}
	
	
//东南安装  ++++++++++++++++++++++++

//实现多个图纸
var d=0;
function addDrawing_(){
d = d + 1;
$("#drawing_").append('<div id="drawing_'+d+'" class="form-group form-inline">'+
					         '<label style="width: 15%;margin-left:13px;">图纸:</label>'+
							'<input class="form-control" type="hidden" name="dn_drawing" id="dn_drawing"/>'+
							'<input style="width: 30%" class="form-control" type="file"'+
							'name="drawing" id="drawing" placeholder="这里选择图纸文件"'+
							'title="房型图文件" onchange="upload(this)" />'+
			                 '<button style="margin-left:6px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
					         'title="删除" type="button"onclick="delDrawing_('+d+');">减</button>'+ 
					         '<c:if test="${msg==\'saveS\'}">'+ 
							 '<button  style="margin-left:6px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" '+ 
							 'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
							 '</c:if>'+ 
							 '<c:if test="${msg==\'editS\'}">'+ 
							'<button  style="margin-left:6px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" '+ 
							 'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
							'</c:if>'+ 
					          '<c:if test="${pd ne null and pd.house_type_img ne null and pd.house_type_img ne '' }">'+
						       '  <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>'+
					          '</c:if>'+
				          '</div>'
			     );   
			}

function addDrawing_2(){
d = d + 1;
$("#drawing_").append('<div id="drawing_'+d+'" class="form-group form-inline">'+
		                     '<label style="width: 15%;margin-left:10px;">图纸:</label>'+
			                 '<input class="form-control" type="hidden" name="dn_drawing" id="dn_drawing"/>'+
			                 '<input style="width: 30%" class="form-control" type="file"'+
		         	         'name="drawing" id="drawing" placeholder="这里选择图纸文件"'+
			                 'title="房型图文件" onchange="upload(this)" />'+
			                 '<button style="margin-left:3px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
			                  'title="删除" type="button"onclick="delDrawing_('+d+');">减</button>'+ 
							'<button  style="margin-left:6px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" '+ 
							'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
					      '</div>'
				     );   
				}
//删除户型图附件上传
function delDrawing_(o)
{
	 document.getElementById("drawing_").removeChild(document.getElementById("drawing_"+o));
}


//实现多个现场照片
var p=0;
function addPicture_(){
p = p + 1;
$("#picture_").append('<div id="picture_'+p+'" class="form-group form-inline">'+
		              '<label style="width: 15%;margin-left:10px;">现场照片:</label>'+
                      '<input class="form-control" type="hidden" name="dn_picture" id="dn_picture" />'+
                       '<input style="width: 30%" class="form-control" type="file" name="picture" id="picture" '+
	                  'title="现场照片文件" onchange="upload(this)" />'+
			           '<button style="margin-left:6px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
					   'title="删除" type="button"onclick="delPicture_('+p+');">减</button>'+ 
					    '<c:if test="${msg==\'saveS\'}">'+ 
						'<button  style="margin-left:6px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" '+ 
						'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
						'</c:if>'+ 
						'<c:if test="${msg==\'editS\'}">'+ 
						'<button  style="margin-left:6px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" '+ 
						'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
						'</c:if>'+ 
					    '<c:if test="${pd ne null and pd.house_type_img ne null and pd.house_type_img ne '' }">'+
						 '  <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>'+
					    '</c:if>'+
				       '</div>'
			     );   
			}

function addPicture_2(){
p = p + 1;
$("#picture_").append('<div id="picture_'+p+'" class="form-group form-inline">'+
		               '<label style="width: 15%;margin-left:10px;">现场照片:</label>'+
                       '<input class="form-control" type="hidden" name="dn_picture" id="dn_picture" />'+
                       '<input style="width: 30%" class="form-control" type="file" name="picture" id="picture" '+
                       'title="现场照片文件" onchange="upload(this)" />'+
			            '<button style="margin-left:3px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
			             'title="删除" type="button"onclick="delPicture_('+p+');">减</button>'+ 
					    '<button  style="margin-left:6px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" '+ 
						'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
					  '</div>'
				     );   
				}
//删除现场照片
function delPicture_(o)
{
	 document.getElementById("picture_").removeChild(document.getElementById("picture_"+o));
}


//实现多个解决方案 
var s=0;
function addSolution_(){
s = s + 1;
$("#solution_").append('<div id="solution_'+s+'" class="form-group form-inline">'+
		               '<label style="width: 15%;margin-left:10px;">解决方案:</label>'+
		               '<input class="form-control" type="hidden" name="dn_solution" id="dn_solution"/>'+
			           '<input style="width: 30%" class="form-control" type="file" name="solution" id="solution"'+
				       '  title="解决方案文件" onchange="upload(this)" />'+
			           '<button style="margin-left:6px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
					   'title="删除" type="button"onclick="delSolution_('+s+');">减</button>'+ 
					    '<c:if test="${msg==\'saveS\'}">'+ 
						'<button  style="margin-left:6px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" '+ 
						'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
						'</c:if>'+ 
						'<c:if test="${msg==\'editS\'}">'+ 
						'<button  style="margin-left:6px;margin-top:3px;" class="btn btn-sm btn-info btn-sm" '+ 
						'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
						'</c:if>'+ 
					    '<c:if test="${pd ne null and pd.house_type_img ne null and pd.house_type_img ne '' }">'+
						 '  <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>'+
					    '</c:if>'+
				       '</div>'
			     );   
			}

function addSolution_2(){
s = s + 1;
$("#solution_").append('<div id="solution_'+s+'" class="form-group form-inline">'+
		               '<label style="width: 15%;margin-left:10px;">解决方案:</label>'+
                       '<input class="form-control" type="hidden" name="dn_solution" id="dn_solution"/>'+
                        '<input style="width: 30%" class="form-control" type="file" name="solution" id="solution"'+
	                    '  title="解决方案文件" onchange="upload(this)" />'+
			            '<button style="margin-left:3px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
			             'title="删除" type="button"onclick="delSolution_('+s+');">减</button>'+ 
					    '<button  style="margin-left:6px;margin-top:3px;display:none;" class="btn btn-sm btn-info btn-sm" '+ 
						'title="查看" type="button" onclick="imgChack(this);">查看</button> '+ 
					  '</div>'
				     );   
				}
//删除
function delSolution_(o)
{
	 document.getElementById("solution_").removeChild(document.getElementById("solution_"+o));
}
</script>
</html>
