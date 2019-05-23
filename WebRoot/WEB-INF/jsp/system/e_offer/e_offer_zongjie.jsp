<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<title>${pd.SYSNAME}</title>
</head>
<script type="text/javascript">

$(document).ready(function(){

	if($("#zongjieflag").val()=="1" || "${pd.isCurrentUser}" != "1"){
		
		var textareas = document.getElementsByTagName("textarea");
		for(var i = 0;i<textareas.length;i++){
			textareas[i].setAttribute("disabled","true");
		}
		var selects = document.getElementsByTagName("select");
		for(var i = 0;i<selects.length;i++){
			selects[i].setAttribute("disabled","true");
		}
		var buttons = document.getElementsByTagName("button");
		for(var i = 0;i<selects.length;i++){
			buttons[i].setAttribute("disabled","true");
		}
	}else{
		
	}

})

</script>
<body class="gray-bg">

<form action="e_offer/saveZongJie.do" name="zongJieForm" id="zongJieForm" method="post">
	<input type="hidden" id="item_id" name="item_id" value="${pd.item_id}">
	<input type="hidden" id="zongjieflag" name="zongjieflag" value="${pd.zongjieflag}">
	<input type="hidden" id="offer_no" name="offer_no" value="${pd.offer_no}">
	<input type="hidden" name="type" id="type" value="" />
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div class="row">
							<div class="col-lg-12">
							    <div class="form-group form-inline">
										<span style="color: red;">*</span> 
										<label style="width: 15%">合同可能:</label>
										<select style="width: 30%" class="form-control" id="agreement_possible" name="agreement_possible">
										  <option value=""  ${pd.agreement_possible==""?"selected":""}>请选择</option>
				                          <option value="1" ${pd.agreement_possible=="1"?"selected":""}>50%</option>
                                       	  <option value="2" ${pd.agreement_possible=="2"?"selected":""}>60%</option>
                                       	  <option value="3" ${pd.agreement_possible=="3"?"selected":""}>70%</option>
                                       	  <option value="4" ${pd.agreement_possible=="4"?"selected":""}>80%</option>
                                       	  <option value="5" ${pd.agreement_possible=="5"?"selected":""}>90%</option>
                                       	  <option value="6" ${pd.agreement_possible=="6"?"selected":""}>100%</option>
										</select>
										<span style="color: red; margin-left: 10px">*</span> 
										<label style="width: 15%;">市场区分:</label> 
										<select style="width: 30%" class="form-control" id="market_type" name="market_type">
										  <option value="" ${pd.market_type==""?"selected":""}>请选择</option>
				                          <option value="1" ${pd.market_type=="1"?"selected":""}>住宅</option>
				                          <option value="2" ${pd.market_type=="2"?"selected":""}>工厂</option>
				                          <option value="3" ${pd.market_type=="3"?"selected":""}>医院</option>
				                          <option value="4" ${pd.market_type=="4"?"selected":""}>商业</option>
				                          <option value="5" ${pd.market_type=="5"?"selected":""}>政府机关</option>
				                          <option value="6" ${pd.market_type=="6"?"selected":""}>别墅</option>
				                          <option value="7" ${pd.market_type=="7"?"selected":""}>公寓</option>
				                          <option value="8" ${pd.market_type=="8"?"selected":""}>学校</option>
				                          <option value="9" ${pd.market_type=="9"?"selected":""}>公共交通</option>
				                          <option value="10" ${pd.market_type=="10"?"selected":""}>酒店</option>
				                          <option value="11" ${pd.market_type=="11"?"selected":""}>小业主</option>
				                          <option value="12" ${pd.market_type=="12"?"selected":""}>总包方</option>
				                          <option value="13" ${pd.market_type=="13"?"selected":""}>OEM</option>
										</select> 
									</div>
							        
							        <div class="form-group form-inline">
							            <span style="color: red;">*</span>
										<label style="width: 15%;">我司劣势:</label> 
										<select style="width: 30%" class="form-control" id="self_inferiority" name="self_inferiority">
										  <option value="" ${pd.self_inferiority==""?"selected":""}>请选择</option>
				                          <option value="1" ${pd.self_inferiority=="1"?"selected":""}>价格</option>
                                       	  <option value="2" ${pd.self_inferiority=="2"?"selected":""}>品牌</option>
                                       	  <option value="3" ${pd.self_inferiority=="3"?"selected":""}>关系</option>
                                       	  <option value="4" ${pd.self_inferiority=="4"?"selected":""}>技术</option>
									   </select>
							        </div>
							        
									<div class="form-group">
										<label style="margin-left: 10px"> 备注:</label>
										<textarea class="form-control" rows="5"  cols="20" value="" name="ZongjieBz" id="ZongjieBz"  placeholder="这里输入备注" maxlength="250" title="备注" >${pd.ZongjieBz}</textarea>
									</div>
							</div>
						</div>
					</div>
					<div style="height: 10px;"></div>
                        <div style="height: 40px;"></div>
                    <table>
						<tr>
							<c:if test="${pd.isCurrentUser == '1' }">
							<td><button type="button" class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="saveZongJie('BC');">保存</button>&nbsp;&nbsp;</td>
							<td><button type="button" class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="saveZongJie('TJ');">确认</button></td>
							</c:if>
						</tr>
					</table>
				</div>
			</div>

		</div>
	</div>
</form>
<script type="text/javascript">


	//保存
	function saveZongJie(type)
	{
		
		//确认锁定总结
	    if(type=='TJ')
	    {
	    	
	    	if ($("#agreement_possible").val() == "" && $("#agreement_possible").val() == "") {
  				$("#agreement_possible").focus();
  				$("#agreement_possible").tips({
  					side : 3,
  					msg : "请选择合同可能性",
  					bg : '#AE81FF',
  					time : 3
  				});
  				return false;
  			}
  		
  			if ($("#market_type").val() == "" && $("#market_type").val() == "") {
  				$("#market_type").focus();
  				$("#market_type").tips({
  					side : 3,
  					msg : "请选择市场区分",
  					bg : '#AE81FF',
  					time : 3
  				});
  				return false;
  			}
  			
  			if ($("#self_inferiority").val() == "" && $("#self_inferiority").val() == "") {
  				$("#self_inferiority").focus();
  				$("#self_inferiority").tips({
  					side : 3,
  					msg : "请选择我司劣势",
  					bg : '#AE81FF',
  					time : 3
  				});
  				return false;
  			}
	    	
	    	$("#type").val("TJ");
	    	
	    	swal({
	            title: "您确定锁定并提交该总结吗？",
	            text: "该操作会锁定该报价的总结信息无法再修改，请谨慎操作！",
	            type: "warning",
	            showCancelButton: true,
	            confirmButtonColor: "#DD6B55",
	            confirmButtonText: "确定",
	            cancelButtonText: "取消",
	            closeOnConfirm: true,
	            closeOnCancel: false
	        },function(isConfirm)
	  		{
	  			if(isConfirm){
		  			$("#zongJieForm").submit();
		  			$("#type").val("");
	  			} else {
	  				swal("已取消", "您取消了总结操作！", "error");
	  			}
	  		});
	    }
	    else
	    {
	    	$("#type").val("BC");
	    	
			if ($("#agreement_possible").val() == "" && $("#agreement_possible").val() == "") {
				$("#agreement_possible").focus();
				$("#agreement_possible").tips({
					side : 3,
					msg : "请选择合同可能性",
					bg : '#AE81FF',
					time : 3
				});
				return false;
			}
		
			if ($("#market_type").val() == "" && $("#market_type").val() == "") {
				$("#market_type").focus();
				$("#market_type").tips({
					side : 3,
					msg : "请选择市场区分",
					bg : '#AE81FF',
					time : 3
				});
				return false;
			}
			
			if ($("#self_inferiority").val() == "" && $("#self_inferiority").val() == "") {
				$("#self_inferiority").focus();
				$("#self_inferiority").tips({
					side : 3,
					msg : "请选择我司劣势",
					bg : '#AE81FF',
					time : 3
				});
				return false;
			}
			
			
			$("#zongJieForm").submit();
	    }
		

	}
	
	
	
	
</script>
</body>

</html>
