<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

<head>

<base href="<%=basePath%>">


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>${pd.SYSNAME}</title>
    <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css"/>
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	
	
</head>

<body class="gray-bg">
<form action="models/${msg}.do" name="modelsForm" id="modelsForm" method="post">
	<div id="ViewElevatorBase" class="animated fadeIn"></div>
	<input type="hidden" name="models_id" id="models_id" value="${pd.models_id}" />
	<%--用户ID--%>
	<input type="hidden" name="requester_id" id="requester_id" value="${userpds.USER_ID}"/>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
							  <div class="panel panel-primary">
                                <div class="panel-heading">
                                    	型号详情
                                </div>
                                <div class="panel-body" >
                                    <div class="form-group form-inline">
										<span style="color: red">*</span>
										<label style="width: 6%">楼梯类型:</label>
										<select style="width: 25%" class="form-control" id="elevator_id" name="elevator_id" onchange="elevatorOptionalListByElevatorId();">
											<option value="1">常规梯</option>
										</select>
										<span style="color: red">*</span>
										<label style="width: 6%">产品线:</label>
										<select style="width: 25%" class="form-control" id="product_id" name="product_id" >
											<option value="">请选择</option>
											<c:forEach items="${productList }" var="product">
												<option value="${product.product_id }" ${product.product_id eq pd.product_id ? 'selected':'' } >${product.product_name }</option>
											</c:forEach>
										</select>
										
										<span style="color: red">*</span>
										<label style="width:6%" >型号名称:</label>
										<input type="text" name="models_name" id="models_name" style="width: 25%" class="form-control"/>
                                        <!-- <select style="width: 25%" class="form-control" id="models_name" name="models_name">
                                            <option value="">请选择</option>
                                            <option value="飞尚曳引货梯">飞尚曳引货梯</option>
                                            <option value="飞尚货梯MRL">飞尚货梯MRL</option>
                                            <option value="飞扬3000+MRL">飞扬3000+MRL</option>
                                            <option value="飞扬3000+">飞扬3000+</option>
                                            <option value="飞扬消防梯">飞扬消防梯</option>
                                            <option value="新飞越">新飞越</option>
                                            <option value="新飞越MRL">新飞越MRL</option>
                                            <option value="DNP9300">DNP9300</option>
                                            <option value="DNR">DNR</option>
                                            <option value="曳引货梯">曳引货梯</option>
                                        </select> -->
                                	</div>
                               		<div class="form-group form-inline">
                                        <span style="color: red">*</span>
                                        <label style="width:6%">电梯标准:</label>
                                        <select style="width: 25%" class="form-control" id="standard_id" name="standard_id">
                                            <option value="">请选择</option>
                                            <c:forEach items="${regelevStandardList }" var="var">
                                                <option value="${var.ID }">${var.NAME }</option>
                                            </c:forEach>
                                        </select>
                               	    </div>
                                    <div class="form-group form-inline">
                                        <span style="color: red">*</span>
                                        <label style="width:6%">型号描述:</label>
                                        <textarea class="form-control" rows="3" cols="100%" name="models_description" id="models_description" placeholder="这里输入型号描述" maxlength="250" title="型号描述" >${pd.models_description}</textarea>
                                    </div>
                               </div>
                            </div>
                        </div>
                    </div>
					<div style="height: 20px;"></div>
					<tr>
					<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                    <c:if test="${msg eq 'modelsAdd'}">
                        <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddModels');">关闭</a></td>
                    </c:if>
                    <c:if test="${msg eq 'modelsEdit'}">
                        <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditModels');">关闭</a></td>
                    </c:if>
					</tr>
				</div>
            </div>
        </div>
    </div>
 </form> 
 
</body>

 
 	<%--zTree--%>
<script type="text/javascript"
		src="plugins/zTree/3.5.24/js/jquery.ztree.all.js"></script>
	<script type="text/javascript">
		//保存
		function save(){
			if($("#elevator_id").val()==""){
				$("#elevator_id").focus();
				$("#elevator_id").tips({
					side:3,
		            msg:'请选择型号类型',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			if($("#models_name").val()==""){
				$("#models_name").focus();
				$("#models_name").tips({
					side:3,
		            msg:'请选择型号名称',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			$("#modelsForm").submit(); 
		}
		
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		}
		
		//计算电梯标准价格
		function countStandardPrice(){
			var elevator_speed_id = $("#elevator_speed_id").val();
			var elevator_weight_id = $("#elevator_weight_id").val();
			var elevator_storey_id = $("#elevator_storey_id").val();
			
			/* if($("#elevator_speed_id").val()==""){
				$("#elevator_speed_id").focus();
				$("#elevator_speed_id").tips({
					side:3,
		            msg:'请填选择电梯速度参数',
		            bg:'#AE81FF',
		            time:2
		        });
				
				return false;
			}
			if($("#elevator_weight_id").val()==""){
				$("#elevator_weight_id").focus();
				$("#elevator_weight_id").tips({
					side:3,
		            msg:'请填选择电梯重量参数',
		            bg:'#AE81FF',
		            time:2
		        });
				
				return false;
			}
			if($("#elevator_storey_id").val()==""){
				$("#elevator_storey_id").focus();
				$("#elevator_storey_id").tips({
					side:3,
		            msg:'请填选择电梯楼层参数',
		            bg:'#AE81FF',
		            time:2
		        });
				
				return false;
			} */
			
			$.post("models/countStandardPrice.do",{elevator_speed_id:elevator_speed_id,elevator_weight_id:elevator_weight_id,elevator_storey_id:elevator_storey_id},function(result){
				if(result.success){
					$("#elevator_standard_price").val(result.elevator_standard_price);
					countsPrice();
				}else{
					$("#elevator_standard_price").val("");
				}
			});
		}
		
		 
		
		
	
		
		//根据电梯速度参数查询楼层
		function findStoreyBySpeedId(){
			var elevator_speed_id = $("#elevator_speed_id").val();
			var models_id = $("#models_id").val();
			var flag = $("#flag").val();
			$("#elevator_storey_id").html("");
			$("#elevator_standard_price").val("");
			if(elevator_speed_id !=null && elevator_speed_id !=""){
				
				$.post("models/findStoreyBySpeedId.do",{elevator_speed_id:elevator_speed_id,models_id:models_id,flag:flag},function(result){
					var elevatorStoreyList = eval(result.elevatorStoreyList);
					var modelsList = eval(result.modelsList);
					
					$("#elevator_storey_id").append('<option value="">请选择</option>');
					for(var i=0;i<elevatorStoreyList.length;i++){
						$("#elevator_storey_id").append('<option value="'+elevatorStoreyList[i].elevator_storey_id+'">'+elevatorStoreyList[i].elevator_storey_name+'</option>');
						for(var j=0;j<modelsList.length;j++){
							
							
							if(elevatorStoreyList[i].elevator_storey_id == modelsList[j].elevator_storey_id){
								$("#elevator_storey_id").find("option[value='"+elevatorStoreyList[i].elevator_storey_id+"']").attr("selected",true);
								break;
							}
						}
					}
					countStandardPrice();
					findStoreyById();
				});
			}else{
				$("#elevator_storey_id").append('<option value="">请先选择电梯速度参数</option>');
			}
			
		}
		
		//根据电梯速度参数查询楼层
		/* function findStoreyBySpeedId(){
			var elevator_speed_id = $("#elevator_speed_id").val();
			var models_id = $("#models_id").val();
			$("#elevator_storey_id").html("");
			$("#elevator_standard_price").val("");
			if(elevator_speed_id !=null && elevator_speed_id !=""){
				
				$.post("models/findStoreyBySpeedId.do",{elevator_speed_id:elevator_speed_id,models_id:models_id},function(result){
					var elevatorStoreyList = eval(result.elevatorStoreyList);
					var modelsList = eval(result.modelsList);
					
					$("#elevator_storey_id").append('<option value="">请选择</option>');
					for(var i=0;i<elevatorStoreyList.length;i++){
						$("#elevator_storey_id").append('<option value="'+elevatorStoreyList[i].elevator_storey_id+'">'+elevatorStoreyList[i].elevator_storey_name+'</option>');
						for(var j=0;j<modelsList.length;j++){
							
							
							if(elevatorStoreyList[i].elevator_storey_id == modelsList[j].elevator_storey_id){
								$("#elevator_storey_id").find("option[value='"+elevatorStoreyList[i].elevator_storey_id+"']").attr("selected",true);
								break;
							}
						}
					}
					
				});
			}else{
				$("#elevator_storey_id").append('<option value="">请先选择电梯速度参数</option>');
			}
		} */
		
		//点击功能计算电梯价钱
		function countPrice(){
			
			var str="";
			var elevator_base_id = $("#elevator_base_id").val();
			str = $("input:checkbox:checked").map(function(index,elem){
				return $(elem).val();
			}).get().join(',');
			
			
			
			if(str!=null && str!=''){
				$("#elevator_base_id").val(str);
				 $.post("models/baseCountTotalPrice",{str:str,elevator_base_id:elevator_base_id},function(result){
					if(result.success){
						$("#elevator_base_price").val(result.countPrice);
						
					}
				});
			}else{
				$("#elevator_base_price").val("");
				$("#elevator_base_id").val("");
			}
		}
		
		// 根据选择楼梯类型加载可选配置信息列表
		function elevatorOptionalListByElevatorId(){
			var elevator_id = $("#elevator_id").val();
			if(elevator_id != null && elevator_id != ""){
				$.post("models/elevatorOptionalListByElevatorId.do",{elevator_id:elevator_id},function(result){
					var elevatorCascadeList = eval(result);
					
					$("#elevatorOptionalTable").find("tr").eq(1).find("td").eq(0).find("select").eq(0).html("");
					
					//切换电梯类型时删除多余td
					$("#elevatorOptionalTable").find("tr:not(:first)").each(function(key,value){
						if(key>0){
							var delObj = $(this).find("td").eq(key).find("select");
							delRows(delObj);
						}
					});
					
					$("#elevatorOptionalTable").find("tr").eq(1).find("td").eq(0).find("select").append('<option value="">请选择</option>')
					for(var i=0; i<elevatorCascadeList.length; i++){
						
						$("#elevatorOptionalTable").find("tr").eq(1).find("td").eq(0).find("select").append('<option value="'+elevatorCascadeList[i].id+'">'+elevatorCascadeList[i].name+'</option>')
					}
					var obj = $("#elevatorOptionalTable").find("tr").eq(1).find("td").eq(0).find("select");
					
					addElevatorOptional(obj);
					countsPrice();
				});
			}
		}
		
		//级联选配项配置
		function addElevatorOptional(obj){
			var parentId = $(obj).val();
			//列索引
			var columnIndex = $(obj).parent().index();
			//行索引
			var rowIndex = $(obj).parent().parent().index();
			
			/* //判断列索引不为空时 
			if(columnIndex != "" ){
				//判断动态追加tr,td 索引
				if(indexNum>0){
					// j 等于当前选择的列    判断当前列是否少于当前追加 tr td
					for(var j=columnIndex;j<indexNum;indexNum--){
						//删除table 追加的tr td
						$("#elevatorCascadeTable").find("tr").eq(rowIndex+1).find("td").eq(indexNum).remove();
						$("#elevatorCascadeTable").find("tr").eq(rowIndex).find("th").eq(indexNum).remove();
					}
				
				}
			} */
			//清空追加tr,td
			if(columnIndex != -1){
				
				for(var i=columnIndex+1;i<4;i++){
					$("#elevatorOptionalTable").find("tr").eq(rowIndex).find("td").eq(i).find("select").eq(0).attr("disabled",true);
					$("#elevatorOptionalTable").find("tr").eq(rowIndex).find("td").eq(i).find("select").eq(0).html("");
					
				}
				 
				$("#elevatorOptionalTable").find("tr").eq(rowIndex).find("td").eq(4).html("");
				$("#elevatorOptionalTable").find("tr").eq(rowIndex).find("td").eq(5).html("");
				$("#elevatorOptionalTable").find("tr").eq(rowIndex).find("td").eq(6).html("");
			}
			
			
			
				
			
			//判断ID不为空
			if(parentId != null && parentId !=""){
				$.post("models/addElevatorOptional.do",{parentId:parentId},function(result){
					countsPrice();
					var elevatorCascadeList = eval(result.elevatorCascadeList);
					var elevatorUnitList = eval(result.elevatorUnitList);
					if(elevatorCascadeList != null){
						//如有子类  去除禁用
						for(var j=columnIndex;j<4;j++){
							if(parentId != ""){
								$("#elevatorOptionalTable").find("tr").eq(rowIndex).find("td").eq(columnIndex+1).find("select").eq(0).attr("disabled",false);
							}
						} 
						
						$(obj).parent().parent().find("td").eq(columnIndex+1).find("select").append("<option value=''>请选择</option>");
						for(var i=0;i<elevatorCascadeList.length>0;i++){
							$(obj).parent().parent().find("td").eq(columnIndex+1).find("select").append('<option value="'+elevatorCascadeList[i].id+'">'+elevatorCascadeList[i].name+'</option>');
						}
					}else{
						var elevator_unit_name = "";
						for(var i=0;i<elevatorUnitList.length;i++){
							if(elevatorUnitList[i].elevator_unit_id == result.elevator_unit_id){
								elevator_unit_name = elevatorUnitList[i].elevator_unit_name;
								break;
							}
						}
						$(obj).parent().parent().find("td").eq(4).append(elevator_unit_name);
						$(obj).parent().parent().find("td").eq(5).append(result.elevator_optional_delivery);
						$(obj).parent().parent().find("td").eq(6).append(result.elevator_optional_price);
						countsPrice();
					} 
					
				});
			}
			
		}
		
		//级联非标项配置
		function addElevatorNonstandard(obj){
			var parentId = $(obj).val();
			//列索引
			var columnIndex = $(obj).parent().index();
			//行索引
			var rowIndex = $(obj).parent().parent().index();
			
			
			//清空追加tr,td
			if(columnIndex != -1){
				
				for(var i=columnIndex+1;i<4;i++){
					$("#elevatorNonstandardTable").find("tr").eq(rowIndex).find("td").eq(i).find("select").eq(0).attr("disabled",true);
					$("#elevatorNonstandardTable").find("tr").eq(rowIndex).find("td").eq(i).find("select").eq(0).html("");
					
				}
				 for(var j=columnIndex;j<4;j++){
					if(parentId != ""){
						$("#elevatorNonstandardTable").find("tr").eq(rowIndex).find("td").eq(columnIndex+1).find("select").eq(0).attr("disabled",false);
					}
				} 
				$("#elevatorNonstandardTable").find("tr").eq(rowIndex).find("td").eq(4).html("");
				$("#elevatorNonstandardTable").find("tr").eq(rowIndex).find("td").eq(5).html("");
				$("#elevatorNonstandardTable").find("tr").eq(rowIndex).find("td").eq(6).html("");
			}
			
			
			
				
			
			//判断ID不为空
			if(parentId != null && parentId !=""){
				$.post("models/addElevatorNonstandard.do",{parentId:parentId},function(result){
					var elevatorCascadeList = eval(result.elevatorCascadeList);
					var elevatorUnitList = eval(result.elevatorUnitList);
					if(elevatorCascadeList != null){
						
						
						$(obj).parent().parent().find("td").eq(columnIndex+1).find("select").append('<option value="">请选择</option>');
						for(var i=0;i<elevatorCascadeList.length>0;i++){
							$(obj).parent().parent().find("td").eq(columnIndex+1).find("select").append('<option value="'+elevatorCascadeList[i].id+'">'+elevatorCascadeList[i].name+'</option>');
						}
					}else{
						var elevator_unit_name = "";
						for(var i=0;i<elevatorUnitList.length;i++){
							if(elevatorUnitList[i].elevator_unit_id == result.elevator_unit_id){
								elevator_unit_name = elevatorUnitList[i].elevator_unit_name;
								break;
							}
						}
						$(obj).parent().parent().find("td").eq(4).append(elevator_unit_name);
						$(obj).parent().parent().find("td").eq(5).append(result.elevator_nonstandard_delivery);
						$(obj).parent().parent().find("td").eq(6).append(result.elevator_nonstandard_price);
					} 
					
				});
			}
			
		}
		
		
		
		//table 非标项配置  添加行
		function addNonstandardRows(){
			var tr = $("#elevatorNonstandardTable").find("tr").eq(1).clone();
			$(tr).find("td").eq(1).find("select").empty();
			$(tr).find("td").eq(2).find("select").empty();
			$(tr).find("td").eq(3).find("select").empty();
			$(tr).find("td").eq(4).empty();
			$(tr).find("td").eq(5).empty();
			$(tr).find("td").eq(6).empty();
			$(tr).find("td:last").html("").append(
													'<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delRows(this);">删除</button>'
													);
				$("#elevatorNonstandardTable").append(tr);
			countsPrice();	
		}
		
		//计算选配价格
		function countsPrice(){
			var count = 0;
			
			$("#elevatorOptionalTable").find("tr:not(:first)").each(function(){
				count += parseInt($(this).find("td").eq(6).html()==''?0:$(this).find("td").eq(6).html());
				
			});	
			$("#elevator_optional_price").val(count);
			totalPrice();
		}
		
		function totalPrice(){
			var elevator_optional_price =  parseInt($("#elevator_optional_price").val()==''?0:$("#elevator_optional_price").val());
			/* var elevator_base_price =  parseInt($("#elevator_base_price").val() ==''?0:$("#elevator_base_price").val()); */
			var elevator_standard_price = parseInt($("#elevator_standard_price").val() ==''?0:$("#elevator_standard_price").val());
			var total= elevator_optional_price + elevator_standard_price;
			$("#models_price").val(total);
		}
		
		//table 选配项配置  添加行
		function addOptionalRows(){
			
			var tr = $("#elevatorOptionalTable").find("tr").eq(1).clone();
			
			
			/* $(tr).find("td").eq(0).find("select").eq(0).find("option").each(function(){
				var obj = $(this).val();
				for(var i =0;i<rowArr.length;i++){
					var checkObj = rowArr[i];
					if(obj == checkObj){
						//将已选中 ,在新增时去除
						$(tr).find("td").eq(0).find("select").eq(0).find("option[value='"+checkObj+"']").remove();
					}
				}
			}); */
			
			
			$(tr).find("td").eq(1).find("select").empty();
			$(tr).find("td").eq(2).find("select").empty();
			$(tr).find("td").eq(3).find("select").empty();
			$(tr).find("td").eq(4).empty();
			$(tr).find("td").eq(5).empty();
			$(tr).find("td").eq(6).empty();
			$(tr).find("td:last").html("").append(
													'<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delRows(this);">删除</button>'
													);
				$("#elevatorOptionalTable").append(tr);
			
			//选中的下拉框数组
			var rowArr = new Array();
			//遍历选配TABLE获取现有的下拉框
			$("#elevatorOptionalTable tr:not(:first)").each(function(){
				if($(this).find("td").eq(0).find("select").val() != null && $(this).find("td").eq(0).find("select").val() != ""){
					//放入已选中到数组
					rowArr.push($(this).find("td").eq(0).find("select").val());
				}
			});
			
			$("#elevatorOptionalTable tr:not(:first)").each(function(i){
				
				var obj = $(this).find("td").find("select").eq(0).find("option:selected").val();
					
					for(var i =0;i<rowArr.length;i++){
						var checkObj = rowArr[i];
						if(obj != "" && obj == checkObj){
							//将已选中 ,在新增时去除
							$(tr).find("td").eq(0).find("select").eq(0).find("option[value='"+checkObj+"']").remove();
						}
					}
				
			});
		}
		
		
		
		//table 删除行
		function delRows(obj){
			$(obj).parent().parent().remove();
			countsPrice();
		}
		
		//加载可选项json数据
		function loadJsonStr(jsonStr,mapJsonArray){
			var jsonStrList = eval('('+jsonStr+')');
			//封装总菜单
			var totalList = eval(mapJsonArray);
			
			
			//添加行
			for(var i=0;i<jsonStrList.length-1;i++){
				addOptionalRows();
			}
			
			//读取已添加选项配置
			for(var i=0;i<mapJsonArray.length;i++){
				//父菜单
				var parentMenuList = totalList[i].parentMenuList;
				//二级菜单 
				var twoMenuList = totalList[i].twoMenuList;
				//三级菜单
				var threeMenuList = totalList[i].threeMenuList;
				//四级菜单
				var fourMenuList = totalList[i].fourMenuList;
				//循环拼接父菜单
				for(var j=0;j<parentMenuList.length;j++){
					$("#elevatorOptionalTable").find("tr:not(:first)").eq(i).each(function(){
						$(this).find("td").eq(0).find("select").eq(0).append('<option value="'+parentMenuList[j].id+'">'+parentMenuList[j].name+'</option>'); 
					})
				}
				//循环拼接二级菜单
				for(var j=0;j<twoMenuList.length;j++){
					$("#elevatorOptionalTable").find("tr:not(:first)").eq(i).each(function(){
						$(this).find("td").eq(1).find("select").eq(0).append('<option value="'+twoMenuList[j].id+'">'+twoMenuList[j].name+'</option>'); 
					})
				}
				//循环拼接三级菜单
				for(var k=0;k<threeMenuList.length;k++){
					$("#elevatorOptionalTable").find("tr:not(:first)").eq(i).each(function(){
						$(this).find("td").eq(2).find("select").eq(0).append('<option value="'+threeMenuList[k].id+'">'+threeMenuList[k].name+'</option>'); 
					})
				}
				//循环拼接四级菜单
				for(var f=0;f<fourMenuList.length;f++){
					$("#elevatorOptionalTable").find("tr:not(:first)").eq(i).each(function(){
						$(this).find("td").eq(3).find("select").eq(0).append('<option value="'+fourMenuList[f].id+'">'+fourMenuList[f].name+'</option>'); 
					})
				}
				
			}
			
			//读取菜单数据
			for(var i=0;i<jsonStrList.length;i++){
				$("#elevatorOptionalTable").find("tr:not(:first)").eq(i).each(function(){
					$(this).find("td").eq(0).find("select").eq(0).val(jsonStrList[i].parentMenu);
					
					//二级菜单 
					var twoMenu = jsonStrList[i].twoMenu;
					//三级菜单 
					var threeMenu = jsonStrList[i].threeMenu;
					//四级菜单 
					var fourMenu = jsonStrList[i].fourMenu;
					
					if(twoMenu != "null"){
						$(this).find("td").eq(1).find("select").eq(0).attr("disabled",false);
					}else{
						$(this).find("td").eq(1).find("select").eq(0).attr("disabled",true);
					}
					if(threeMenu  != "null"){
						$(this).find("td").eq(2).find("select").eq(0).attr("disabled",false);
					}else{
						$(this).find("td").eq(2).find("select").eq(0).attr("disabled",true);
					}
					if(fourMenu  != "null" ){
						$(this).find("td").eq(3).find("select").eq(0).attr("disabled",false);
					}else{
						$(this).find("td").eq(3).find("select").eq(0).attr("disabled",true);
					}
					$(this).find("td").eq(1).find("select").eq(0).val(jsonStrList[i].twoMenu);
					$(this).find("td").eq(2).find("select").eq(0).val(jsonStrList[i].threeMenu);
					$(this).find("td").eq(3).find("select").eq(0).val(jsonStrList[i].fourMenu);
					$(this).find("td").eq(4).html(jsonStrList[i].elevator_unit_name);
					$(this).find("td").eq(5).html(jsonStrList[i].elevator_optional_delivery);
					$(this).find("td").eq(6).html(jsonStrList[i].elevator_optional_price);
				});
				
			}
		}
		
		
		//加载非标项json数据
		function loadJsonStrs(elevatorNonstandardJson,nonstandardJsonArrays){
			var jsonStrList = eval('('+elevatorNonstandardJson+')');
			//封装总菜单
			var totalList = eval(nonstandardJsonArrays);
			
			
			//添加行
			for(var i=0;i<jsonStrList.length-1;i++){
				addNonstandardRows();
			}
			
			//读取已添加选项配置
			for(var i=0;i<nonstandardJsonArrays.length;i++){
				//二级菜单 
				var twoMenuList = totalList[i].twoMenuList;
				//三级菜单
				var threeMenuList = totalList[i].threeMenuList;
				//四级菜单
				var fourMenuList = totalList[i].fourMenuList;
				
				//循环拼接二级菜单
				for(var j=0;j<twoMenuList.length;j++){
					$("#elevatorNonstandardTable").find("tr:not(:first)").eq(i).each(function(){
						$(this).find("td").eq(1).find("select").eq(0).append('<option value="'+twoMenuList[j].id+'">'+twoMenuList[j].name+'</option>'); 
					})
				}
				//循环拼接三级菜单
				for(var k=0;k<threeMenuList.length;k++){
					$("#elevatorNonstandardTable").find("tr:not(:first)").eq(i).each(function(){
						$(this).find("td").eq(2).find("select").eq(0).append('<option value="'+threeMenuList[k].id+'">'+threeMenuList[k].name+'</option>'); 
					})
				}
				//循环拼接三级菜单
				for(var f=0;f<fourMenuList.length;f++){
					$("#elevatorNonstandardTable").find("tr:not(:first)").eq(i).each(function(){
						$(this).find("td").eq(3).find("select").eq(0).append('<option value="'+fourMenuList[f].id+'">'+fourMenuList[f].name+'</option>'); 
					})
				}
				
			}
			
			//读取菜单数据
			for(var i=0;i<jsonStrList.length;i++){
				$("#elevatorNonstandardTable").find("tr:not(:first)").eq(i).each(function(){
					$(this).find("td").eq(0).find("select").eq(0).val(jsonStrList[i].parentMenu);
					//二级菜单 
					var twoMenu = jsonStrList[i].twoMenu;
					//三级菜单 
					var threeMenu = jsonStrList[i].threeMenu;
					//四级菜单 
					var fourMenu = jsonStrList[i].fourMenu;
					
					if(twoMenu != ""){
						$(this).find("td").eq(1).find("select").eq(0).attr("disabled",false);
					}
					
					if(threeMenu != ""){
						$(this).find("td").eq(2).find("select").eq(0).attr("disabled",false);
					}
					if(fourMenu != "" ){
						$(this).find("td").eq(3).find("select").eq(0).attr("disabled",false);
					} 
					
					$(this).find("td").eq(1).find("select").eq(0).val(jsonStrList[i].twoMenu);
					$(this).find("td").eq(2).find("select").eq(0).val(jsonStrList[i].threeMenu);
					$(this).find("td").eq(3).find("select").eq(0).val(jsonStrList[i].fourMenu);
					$(this).find("td").eq(4).html(jsonStrList[i].elevator_unit_name);
					$(this).find("td").eq(5).html(jsonStrList[i].elevator_nonstandard_delivery);
					$(this).find("td").eq(6).html(jsonStrList[i].elevator_nonstandard_price);
				});
				
			}
		}
		
		
		//根据电梯楼层参数查询标准高度
		function findStoreyById(){
			
			var elevator_storey_id = $("#elevator_storey_id").val();
			if(elevator_storey_id != null && elevator_storey_id != ""){
				$.post("models/findStoreyById.do",{elevator_storey_id:elevator_storey_id},function(result){
					if(result != null){
						$("#elevator_height_name").html(result);
						countStandardPrice();
					}
				});
			}
		}
		
		//根据井道提高获取金额
		function findHeightMoney(){
			var elevator_speed_id = $("#elevator_speed_id").val();
			var elevator_weight_id = $("#elevator_weight_id").val();
			var elevator_height_add = $("#elevator_height_add").val();
			if(elevator_speed_id != "" &&  elevator_weight_id != "" && elevator_height_add != "" ){
				$.post("models/findHeightMoney.do",{elevator_speed_id:elevator_speed_id,elevator_weight_id:elevator_weight_id,elevator_height_add:elevator_height_add},function(result){
					if(elevator_height_name != 0){
						$("#elevator_height_money").val(result);
					}else{
						$("#elevator_height_money").val(0);
					}
				});
			}else{
				$("#elevator_height_money").val("0.00");
			}
		}
		
		
		//查看 
		function viewElevatorBase(){
			var elevator_id = $("#elevator_id").val();
			
			$("#ViewElevatorBase").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "查看标准配置信息",
		        actions: ["Close"],
		        content: '<%=basePath%>offer/toElevatorBaseView.do?elevator_id='+elevator_id,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		
		//计算CCTV电缆价格 A*(H+15M),A为选项加价,H为提升高度 选项加价:17
		function countCableHeight(){
			var cableHeight = $("#cable_height").val();
			if(cableHeight != null && cableHeight != ""){
				var cable_height = parseInt($("#cable_height").val()) + parseInt("15");
				var price = parseInt("17");
				var totalPrice = cable_height * price;
				$("#cable_price").val(totalPrice);
			}else{
				$("#cable_price").val("");
			}
			
			
		}
		
		//计算导轨支架价格
		function countRailBracketPrice(){
			var rise = $("#rise").val();
			var top_height = $("#top_height").val();
			var pit_depth = $("#pit_depth").val();
			var crbsp = $("#crbsp").val();
			
			$("#rail_bracket_price").val("");
			if(rise != null && rise != ""){
				rise = parseInt(rise)
			}else{
				return false;
			}
			
			if(top_height != null && top_height != ""){
				top_height = parseInt(top_height)
			}else{
				return false;
			}
			
			if(pit_depth != null && pit_depth != ""){
				pit_depth = parseInt(pit_depth)
			}else{
				return false;
			}
			
			if(crbsp != null && crbsp != ""){
				crbsp = parseInt(crbsp)
			}else{
				return false;
			}
			
			var totalPrice = parseFloat((rise * parseInt("1000") + top_height + pit_depth)/crbsp).toFixed(0);
			if(totalPrice != null && totalPrice != ""){
				$("#rail_bracket_price").val(totalPrice);
			}
		}
		
		
	</script>
</html>
