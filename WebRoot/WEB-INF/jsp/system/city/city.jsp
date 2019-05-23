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
	<title></title>
</head>

<body class="gray-bg">
    <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	省/市管理
                                    </div>
                                    <div class="panel-body">
                                       
                                       <div class="form-group form-inline"> 
	                                       <lable style="width:10%">省份:</lable>
										   <select style="width: 25%" id="province" name="province" class="form-control">
										    	<option value="">请选择</option>
										    	<c:forEach var="province" items="${provinceList}" >
										    		<option value="${province.id }">${province.name }</option>
										    	</c:forEach>
										   </select>
										   &nbsp;&nbsp;&nbsp;
										   <label style="width:6%" id="agentNo">省/市:</label>
                                    	   <input style="width:25%" type="text"  placeholder="省/市"  id="province_name" name="province_name" value=""  class="form-control">
                                    	   
                                    	   <button class="btn  btn-danger btn-sm" title="新增" type="button" onclick="provinceAdd();">新增</button>
                                    	   <button class="btn  btn-primary btn-sm" title="编辑" type="button"onclick="provinceEdit();">编辑</button>
                                   	  </div>	
                                   </div>
                                </div>
    
    <lable>城市:</lable>
    <select id="city" name="city" disabled="disabled">
    	
    
    </select>
    <lable>区:</lable>
    <select id="county" name="county" disabled="disabled">
    	
    </select>
    <lable>街道:</lable>
    <select>
    	<option value="">请选择</option>
    </select>
	<lable>地址:</lable>
    <input type="text" id="address" name="address">   
	<!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert2/sweetalert2.js"></script>
    <script type="text/javascript">
    var address = 0;
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
       
        $("#province").change(function(){
    		var province_id = $("#province option:selected").val();
    		var province_name = $("#province option:selected").text();
    		$("#province_name").val(province_name);
    		$.post("city/findAllCityByProvinceId.do",{province_id:province_id},function(result){
    			$("#city").empty();
    			if(result != null){
    				$("#city").attr("disabled",false);
    				$("#city").append("<option value=''>请选择</option>");
    				$.each(result,function(key,value){
    					$("#city").append("<option value='"+value.id+"'>"+value.name+"</option>");
    				});
    			}else{
    				$("#city").attr("disabled",true);
    			}
    			
    		});
    	});	
    	
    	$("#city").change(function(){
    		var city_id = $("#city option:selected").val();
    		$.post("city/findAllCountyByCityId.do",{city_id:city_id},function(result){
    			$("#county").empty();
    			if(result != null){
    				$("#county").attr("disabled",false);
    				$("#county").append("<option value=''>请选择</option>");
    				$.each(result,function(key,value){
    					$("#county").append("<option value='"+value.id+"'>"+value.name+"</option>");
    				});
    			}else{
    				$("#county").attr("disabled",true);
    			}
    		})
    	});
	
		 function provinceAdd(){
			 var province_name = $("#province_name").val();
			 $.post("city/provinceAdd.do",{province_name:province_name},function(result){
				 if(result.msg==true){
					 alert("添加成功");
					 window.location.reload();
				 }else{
					 alert(result.msg);
				 }
			 });
		 }
		
		 
		
		</script>
</body>
</html>


