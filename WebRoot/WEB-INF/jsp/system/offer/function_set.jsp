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
<form action="offer/${msg}.do" name="functionSetForm" id="functionSetForm" method="post">
	<div id="ViewElevatorBase" class="animated fadeIn"></div>
	<input type="hidden" name="models_id" id="models_id" value="${pd.models_id}" />
	<input type="hidden" name="elevator_id" id="elevator_id" value="${pd.elevator_id}" />
	<input type="hidden" name="flag" id="flag" value="${flag}" />
	<input type="hidden" name="id" id="id" value="${id}" />
	<input type="hidden" name="product_id" id="product_id" value="${product_id}" />
  <input type="hidden" name="clickCellIndex" id="clickCellIndex">
  <input type="hidden" name="clickRowIndex" id="clickRowIndex">
	
	<%--用户ID--%>
	<input type="hidden" name="requester_id" id="requester_id" value="${userpds.USER_ID}"/>
	<div id="elevatorNonstandard" class="animated fadeIn"></div>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
							  	<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	电梯标准信息
                                    </div>
                                    <div class="panel-body" >
                                        
                                        <div class="form-group form-inline">
	                                    	
											
											<span style="color: red">*</span>
											<label style="width: 6%">电梯速度:</label>
											<select style="width: 25%" class="form-control" id="elevator_speed_id" name="elevator_speed_id" onchange="findStoreyBySpeedId();">
												<option value="">请选择</option>
												<c:forEach items="${elevatorSpeedList }" var="elevatorSpeed">
													<option value="${elevatorSpeed.elevator_speed_id }" ${elevatorSpeed.elevator_speed_id eq pd.elevator_speed_id ? 'selected':'' } >${elevatorSpeed.elevator_speed_name }</option>
												</c:forEach>
												
											</select>
											
											<span style="color: red">*</span>
											<label style="width: 6%">电梯重量:</label>
											<select style="width: 25%" class="form-control" id="elevator_weight_id" name="elevator_weight_id" onchange="findStoreyBySpeedId()">
												<option value="">请选择</option>
												<c:forEach items="${elevatorWeightList }" var="elevatorWeight">
													<option value="${elevatorWeight.elevator_weight_id }" ${elevatorWeight.elevator_weight_id eq pd.elevator_weight_id ? 'selected':'' } >${elevatorWeight.elevator_weight_name }</option>
												</c:forEach>
												
											</select>
                                    			
                                    		
                                        	<span style="color: red">*</span>
											<label style="width: 6%">电梯楼层:</label>
											<select style="width: 25%" class="form-control" id="elevator_storey_id" name="elevator_storey_id" onchange="findStoreyById()">
											</select>
											
											
                                    	</div>
                                        
                                        
                                        <div class="form-group form-inline">
                                        	<span style="color: red">&nbsp;</span>
											<label style="width: 6%">标准高度:</label>
											<label style="width: 25%" id="elevator_height_name"></label>
                                        	
                                        	<span style="color: red">*</span>
											<label style="width: 8%">井道提升(米):</label>
											<select style="width: 23%" class="form-control" id="elevator_height_add" name="elevator_height_add" onchange="findHeightMoney()">
												<option value="">请选择</option>
												<option value="0" ${pd.elevator_height_add eq 0 ? "selected":"" } >0米</option>
												<option value="1" ${pd.elevator_height_add eq 1 ? "selected":"" } >1米</option>
												<option value="2" ${pd.elevator_height_add eq 2 ? "selected":"" } >2米</option>
											</select>	 	
                                        
                                        	<span style="color: red">*</span>
											<label style="width:6%" >提升价格:</label>
                                    		<input style="width:25%"  type="text"  placeholder="提升价格"  id="elevator_height_money" name="elevator_height_money" readonly="readonly" value="${pd.elevator_height_money }"  class="form-control">
                                    		
                                    		
                                        </div>
                                   		
                                   		<div class="form-group form-inline">
                                        	 	
                                        
                                        	<span style="color: red">*</span>
											<label style="width:6%" >标准价格:</label>
                                    		<input style="width:25%"  type="text"  placeholder="价格"  id="elevator_standard_price" name="elevator_standard_price" readonly="readonly" value="${pd.elevator_standard_price }"  class="form-control">
                                    		
                                    		
                                        </div>
                                   	   
                                   </div>
                                </div>
                                
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	基础项配置
                                        	<button style="margin-left: 80%" class="btn  btn-info btn-sm" title="删除" type="button" onclick="viewElevatorBase()" >查看</button>
                                    </div>
                                </div>
                                
                                 <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	选配项配置
                                    </div>
                                    <div class="panel-body" >
                                        
                                        <div class="form-group form-inline">
                                        
                                        	<table class="table table-striped table-bordered table-hover" id="elevatorOptionalTable">

	                                    			<tr>
				                                        <th style="width:10%;">父菜单</th>
				                                        <th style="width:10%;">二级菜单</th>
				                                        <th style="width:10%;">三级菜单</th>
				                                        <th style="width:10%;">四级菜单</th>
				                                        <th style="width:10%;">单位</th>
				                                        <th style="width:10%;">交货期</th>
				                                        <th style="width:10%;">价格</th>
				                                        <th style="width:20%;">操作</th>
	                                    			</tr>
	                                    			
	                                    			<tr>
	                                    				<td>
	                                    					<!-- <select  onchange="addElevatorOptional(this)">
                  																<option value="">请选择</option>
                  															</select> -->
                                                <input type="text" style="border-style: none;width: 100%" onclick="showMenu(this)">
                                                <input type="hidden">
                  														</td>
                  														<td>
                  															<!-- <select disabled="disabled"  onchange="addElevatorOptional(this)">
                  																<option value="">请选择</option>
                  															</select> -->
                                                <input type="text" style="border-style: none;width: 100%" onclick="showMenu(this)">
                                                <input type="hidden">
                  														</td>
                  														<td>
                  															<!-- <select disabled="disabled" onchange="addElevatorOptional(this)">
                  																<option value="">请选择</option>
                  															</select> -->
                                                <input type="text" style="border-style: none;width: 100%" onclick="showMenu(this)">
                                                <input type="hidden">
                  														</td>
                  														<td>
                  															<!-- <select disabled="disabled" onchange="addElevatorOptional(this)">
                  																<option value="">请选择</option>
                  															</select> -->
                                                <input type="text" style="border-style: none;width: 100%" onclick="showMenu(this)">
                                                <input type="hidden">
                  														</td>
	                                    				<td></td>
	                                    				<td></td>
	                                    				<td></td>
	                                    				<td><button class="btn  btn-primary btn-sm" title="新增" type="button"onclick="addOptionalRows();">新增</button></td>
	                                    			</tr>
                                        	</table>
                                        </div>
                                   		<div class="form-group form-inline">
                                        	<input type="hidden" id="elevator_optional_json" name="elevator_optional_json" value="${pd.elevator_optional_json }">
                                        	<span style="color: red">*</span>
											                     <label style="width:6%" >价格:</label>
                                    		  <input style="width:25%"  type="text" readonly="readonly"  placeholder="价格"  id="elevator_optional_price" name="elevator_optional_price" value="${pd.elevator_optional_price }"  class="form-control">
                                      </div>
                                   </div>
                                </div>
                                
                                 <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	导轨支架
                                    </div>
                                    <div class="panel-body" >
                                        
                                        <div class="form-group form-inline">
	                                    	
											
											<span style="color: red">*</span>
											<label style="width:6%" >提升高度:</label>
                                    		<input style="width:25%"  type="text"  placeholder="提升高度"  id="rise" name="rise" value="${pd.rise }"  class="form-control" onkeyup="countRailBracketPrice()">
                                    			
                                   	   		<span style="color: red">*</span>
											<label style="width:6%" >顶层高度:</label>
                                    		<input style="width:25%"  type="text"  placeholder="顶层高度"  id="top_height" name="top_height" value="${pd.top_height }"  class="form-control" onkeyup="countRailBracketPrice()">
                                    		
                                    		<span style="color: red">*</span>
											<label style="width:6%" >底坑深度:</label>
                                    		<input style="width:25%"  type="text"  placeholder="底坑深度"  id="pit_depth" name="pit_depth" value="${pd.pit_depth }"  class="form-control" onkeyup="countRailBracketPrice()">
                                   		</div>
                                   		
                                   		<div class="form-group form-inline">
                                   			<span style="color: red">*</span>
											<label style="width:6%" >CRBsp:</label>
                                    		<input style="width:25%"  type="text"  placeholder="CRBsp"  id="crbsp" name="crbsp" value="${pd.crbsp }"  class="form-control" onkeyup="countRailBracketPrice()">
                                    			
                                   			<span style="color: red">*</span>
											<label style="width:6%" >价格:</label>
                                    		<input style="width:25%"  type="text" readonly="readonly"  placeholder="价格"  id="rail_bracket_price" name="rail_bracket_price" value="${pd.rail_bracket_price }"  class="form-control">
                                    			
                                   		</div>
                                	</div>
                                </div>
                                
                                
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	CCTV电缆
                                    </div>
                                    <div class="panel-body" >
                                        
                                        <div class="form-group form-inline">
	                                    	
											
											<span style="color: red">*</span>
											<label style="width:6%" >提升高度:</label>
                                    		<input style="width:25%"  type="text"  placeholder="提升高度"  id="cable_height" name="cable_height" value="${pd.cable_height }"  class="form-control" onkeyup="countCableHeight()">
                                    			
                                   	   		<span style="color: red">*</span>
											<label style="width:6%" >价格:</label>
                                    		<input style="width:25%"  type="text" readonly="readonly"  placeholder="价格"  id="cable_price" name="cable_price" value="${pd.cable_price }"  class="form-control">
                                    			
                                   		</div>
                                   		
                                   		
                                	</div>
                                </div>	
                                
                              
                                  <div class="panel panel-primary">
                                 	 <div class="panel-heading">
                                        	非标项描述
                                    </div>
                                    
                                    
                                    
                                    
                                     <div class="panel-body" >
                                        
                                        <div class="form-group form-inline">
                                        
                                        	<table class="table table-striped table-bordered table-hover" id="elevatorNonstandardForm">

	                                    			<tr>
				                                        <th style="width:10%;">梯号</th>
				                                        <th style="width:10%;">非标要求/特殊要求描述</th>
				                                        <th style="width:20%;">操作</th>
	                                    			</tr>
	                                    			
	                                    			<tr>
	                                    				<td>
	                                    					<label>${id }</label>
														</td>
														<td>
															<input type="hidden">
															<textarea rows="5" cols="30"></textarea>
														</td>
														
	                                    				
	                                    				
	                                    				<td>
	                                    					<button class="btn  btn-primary btn-sm" title="新增" type="button"onclick="addNonstandardFormRows();">新增</button>
	                                    				</td>
	                                    			</tr>
                                        	</table>
                                        
                                        </div>
                                   		
                                   		<div class="form-group form-inline">
                                        	<input type="hidden" id="elevator_nonstandardform_json" name="elevator_nonstandardform_json" value="${pd.elevator_nonstandardform_json }">
                                        </div>
                                   	   
                                   </div> 
                                    
                                 </div> 
                             
                            	<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	配置详情
                                    </div>
                                    <div class="panel-body" >
                                        
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
                                    			
                                   			<label style="width:6%">总价格:</label>
                                       		<input style="width:25%" type="text" readonly="readonly" placeholder="请选择功能"  id="models_price" name="models_price" value="${pd.models_price }" class="form-control">
                                        	
                                        	<label style="width:6%">名称:</label>
                                       		<input style="width:25%" type="text"  placeholder="请输入名称"  id="models_name" name="models_name" value="${pd.models_name }" class="form-control">	 	
                                    	</div>
                                   </div>
                                </div>
                            </div>
                        </div>
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                        <c:if test="${msg eq 'functionAdd'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('SetFunction');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'functionEnit'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('SetFunction');">关闭</a></td>
                        </c:if>
						</tr>
					</div>
            </div>
            
        </div>
 </div>

  <!-- ztree选配项显示模块 -->
 <div class="ibox float-e-margins" id="menuContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
  <div class="ibox-content">
    <div>
      <input class="form-control" style="height: 30px" type="text" placeholder="搜索" id="keyWord" onkeyup="searchTreeNodesByKeyWord()">
      <ul id="cascade_zTree" class="ztree" style="margin-top:0; width:170px;"></ul>
    </div>
  </div>
 </div>
 </form> 
 
</body>

 
 	<%--zTree--%>
<!-- <script type="text/javascript"
		src="plugins/zTree/3.5.24/js/jquery.ztree.all.js"></script> -->
  <script type="text/javascript"
  src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
  <script type="text/javascript"
  src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
  <script type="text/javascript"
  src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>
	<script type="text/javascript">
	var zNodes;
  var setting;
	$(document).ready(function(){
		//非标JSON
		var elevatorNonstandardJson = $("#elevator_nonstandard_json").val();
		var nonstandardJsonArrays = ${nonstandardJsonArrays};
		//选配JSON		
		var jsonStr = $("#elevator_optional_json").val();
		var mapJsonArray = ${mapJsonArray};
		//不为空时读取选配数据
		if(jsonStr != "" && mapJsonArray != ""){
			loadJsonStr(jsonStr,mapJsonArray);
		}
		//不为空时读取非标数据
		if(elevatorNonstandardJson != "" && nonstandardJsonArrays != ""){
			loadJsonStrs(elevatorNonstandardJson,nonstandardJsonArrays);
		}
		//非标项配置申请JSON
		var elevatorNonstandardformJson = $("#elevator_nonstandardform_json").val();
		if(elevatorNonstandardformJson != ""){
			loadElevatorNonstandardformJson(elevatorNonstandardformJson);
		}
		
		
		findStoreyBySpeedId();
		
		
		countsPrice();

    //初始化zTree
      zNodes = ${cascade};
      setting = {
        view: {
          dblClickExpand: false
        },
        data: {
          simpleData: {
            enable: true
          }
        },
        callback: {
          beforeClick: beforeClick,
          onClick: onClick
        }
      };

      $.fn.zTree.init($("#cascade_zTree"), setting, zNodes);
      $.fn.zTree.getZTreeObj("cascade_zTree").expandAll(true);
		
	});
	
	
	
		//保存
		function save(){
			if($("#elevator_speed_id").val()==""){
				$("#elevator_speed_id").focus();
				$("#elevator_speed_id").tips({
					side:3,
		            msg:'请选择电梯速度',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			if($("#elevator_storey_id").val()==""){
				$("#elevator_storey_id").focus();
				$("#elevator_storey_id").tips({
					side:3,
		            msg:'请选择电梯楼层',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			if($("#elevator_standard_price").val()==""){
				$("#elevator_standard_price").focus();
				$("#elevator_standard_price").tips({
					side:3,
		            msg:'请先计算价格',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			
			
			if($("#elevator_base_price").val()==""){
				$("#elevator_base_price").focus();
				$("#elevator_base_price").tips({
					side:3,
		            msg:'请选择基础配置',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			if($("#elevator_optional_price").val()==""){
				$("#elevator_optional_price").focus();
				$("#elevator_optional_price").tips({
					side:3,
		            msg:'请填写选配项配置价格',
		            bg:'#AE81FF',
		            time:2
		        });
				
				return false;
			}
			
			//可选项配置json
			var jsonStr = "["
			$("#elevatorOptionalTable tr:not(:first)").each(function(){
				//主菜单    
				var parentMenu =  $(this).find("td").eq(0).find("input").eq(1).val();
        var parentMenuName = $(this).find("td").eq(0).find("input").eq(0).val();
				//二级菜单
				var twoMenu =  $(this).find("td").eq(1).find("input").eq(1).val();
        var twoMenuName = $(this).find("td").eq(1).find("input").eq(0).val();
				if(typeof(twoMenu) == "undefined" ){
					/*twoMenu = $(this).find("td").eq(1).html();*/
				}
				//三级菜单
				var threeMenu =  $(this).find("td").eq(2).find("input").eq(1).val();
        var threeMenuName = $(this).find("td").eq(2).find("input").eq(0).val();
				if(typeof(threeMenu) == "undefined"){
					/*threeMenu = $(this).find("td").eq(2).html();*/
				}
				//四级菜单
				var fourMenu =  $(this).find("td").eq(3).find("input").eq(1).val();
        var fourMenuName = $(this).find("td").eq(3).find("input").eq(0).val();
				if(typeof(fourMenu) == "undefined"){
					/*fourMenu = $(this).find("td").eq(3).html();*/
				}
				
				var elevator_unit_name =  $(this).find("td").eq(4).html();
				var elevator_optional_delivery =  $(this).find("td").eq(5).html();
				var elevator_optional_price =  $(this).find("td").eq(6).html();
				jsonStr += "{";
				jsonStr += "'parentMenu':'" + parentMenu + "',"
        jsonStr += "'parentMenuName':'" + parentMenuName + "',"
				jsonStr += "'twoMenu':'" + twoMenu + "',"
        jsonStr += "'twoMenuName':'" + twoMenuName + "',"
				jsonStr += "'threeMenu':'" + threeMenu + "',"
        jsonStr += "'threeMenuName':'" + threeMenuName + "',"
				jsonStr += "'fourMenu':'" + fourMenu + "',"
        jsonStr += "'fourMenuName':'" + fourMenuName + "',"
				jsonStr += "'elevator_unit_name':'" + elevator_unit_name + "',"
				jsonStr += "'elevator_optional_delivery':'" + elevator_optional_delivery + "',"
				jsonStr += "'elevator_optional_price':'" + elevator_optional_price + "'},"
				
				
			});
			jsonStr = jsonStr.substring(0,jsonStr.length-1);
			jsonStr += "]";
			$("#elevator_optional_json").val(jsonStr);
			
			
			//非标项描述 
			var  nonstandardJsonStr = "["
			$("#elevatorNonstandardForm tr:not(:first)").each(function(){
				var elevator_no = $(this).find("td").eq(0).find("label").eq(0).text();
				var centre_id = $(this).find("td").eq(1).find("input:hidden").eq(0).val();
				var elevator_description = $(this).find("td").eq(1).find("textarea").eq(0).val();
				
				nonstandardJsonStr += "{";
				nonstandardJsonStr += "'elevator_no':'" + elevator_no + "',";
				nonstandardJsonStr += "'centre_id':'" + centre_id + "',";
				nonstandardJsonStr += "'elevator_description':'" + elevator_description + "'},";
				if(elevator_description == ""){
					
					nonstandardJsonStr=null;
				}
			});
			if(nonstandardJsonStr != null && nonstandardJsonStr !=""){
				nonstandardJsonStr = nonstandardJsonStr.substring(0,nonstandardJsonStr.length-1)+"]";
			}
			$("#elevator_nonstandardform_json").val(nonstandardJsonStr);
			
			
			$("#functionSetForm").submit(); 
		}
		
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		}
		
		//计算电梯标准价格
		function countStandardPrice(){
			var elevator_speed_id = $("#elevator_speed_id").val();
			var elevator_weight_id = $("#elevator_weight_id").val();
			var elevator_storey_id = $("#elevator_storey_id").val();
			$.post("models/countStandardPrice.do",{elevator_speed_id:elevator_speed_id,elevator_weight_id:elevator_weight_id,elevator_storey_id:elevator_storey_id},function(result){
				if(result.success){
					$("#elevator_standard_price").val(result.elevator_standard_price);
					totalPrice();
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
		
		
		//级联选配项配置
		function addElevatorOptional(obj){
			
			var parentId = $(obj).val();
			//列索引
			var columnIndex = $(obj).parent().index();
			//行索引
			var rowIndex = $(obj).parent().parent().index();
			
      if(columnIndex != -1){
        for(var i=columnIndex+1;i<4;i++){
          $("#elevatorOptionalTable").find("tr").eq(rowIndex).find("td").eq(i).find("input").eq(0).val("");
          $("#elevatorOptionalTable").find("tr").eq(rowIndex).find("td").eq(i).find("input").eq(1).val("");
        }
      }
			
			$("#elevatorOptionalTable").find("tr").eq(rowIndex).find("td").eq(4).html("");
			$("#elevatorOptionalTable").find("tr").eq(rowIndex).find("td").eq(5).html("");
			$("#elevatorOptionalTable").find("tr").eq(rowIndex).find("td").eq(6).html("");
			
				
			
			//判断ID不为空
			if(parentId != null && parentId !=""){
				$.post("models/addElevatorOptional.do",{parentId:parentId},function(result){
					countsPrice();
					var elevatorCascadeList = eval(result.elevatorCascadeList);
					var elevatorUnitList = eval(result.elevatorUnitList);
					
					if(elevatorCascadeList != null){
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
			
			
		}
		
		//table 非标项描述 添加行
		function addNonstandardFormRows(){
			var tr = $("#elevatorNonstandardForm").find("tr").eq(1).clone();
			$(tr).find("td").eq(1).find("input").val("");
			$(tr).find("td").eq(1).find("textarea").val("");
			$(tr).find("td:last").html("").append(
													'<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delRows(this);">删除</button> '
													);
			$("#elevatorNonstandardForm").append(tr);										
		}
		
		
		//table 选配项配置  添加行
		function addOptionalRows(){
      var tr = $("#elevatorOptionalTable").find("tr").eq(1).clone();
      $(tr).find("td").eq(0).find("input").val("");
      $(tr).find("td").eq(1).find("input").val("");
      $(tr).find("td").eq(2).find("input").val("");
      $(tr).find("td").eq(3).find("input").val("");
      $(tr).find("td").eq(4).empty();
      $(tr).find("td").eq(5).empty();
      $(tr).find("td").eq(6).empty();
      $(tr).find("td:last").html("").append(
                          '<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delRows(this);">删除</button>'
                          );
      $("#elevatorOptionalTable").append(tr);
      countsPrice();
		}
		
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
			
			//读取菜单数据
      for(var i=0;i<jsonStrList.length;i++){
        $("#elevatorOptionalTable").find("tr:not(:first)").eq(i).each(function(){
          $(this).find("td").eq(0).find("input").eq(1).val(jsonStrList[i].parentMenu);
          $(this).find("td").eq(0).find("input").eq(0).val(jsonStrList[i].parentMenuName);
          //二级菜单 
          var twoMenu = jsonStrList[i].twoMenu;
          //三级菜单 
          var threeMenu = jsonStrList[i].threeMenu;
          //四级菜单 
          var fourMenu = jsonStrList[i].fourMenu;
          
          
          $(this).find("td").eq(1).find("input").eq(1).val(jsonStrList[i].twoMenu);
          $(this).find("td").eq(1).find("input").eq(0).val(jsonStrList[i].twoMenuName);
          $(this).find("td").eq(2).find("input").eq(1).val(jsonStrList[i].threeMenu);
          $(this).find("td").eq(2).find("input").eq(0).val(jsonStrList[i].threeMenuName);
          $(this).find("td").eq(3).find("input").eq(1).val(jsonStrList[i].fourMenu);
          $(this).find("td").eq(3).find("input").eq(0).val(jsonStrList[i].fourMenuName);
          $(this).find("td").eq(4).html(jsonStrList[i].elevator_unit_name);
          $(this).find("td").eq(5).html(jsonStrList[i].elevator_optional_delivery);
          $(this).find("td").eq(6).html(jsonStrList[i].elevator_optional_price);
        });
      }
		}
		
		
		//加载非标项描述
		function loadElevatorNonstandardformJson(elevatorNonstandardformJson){
			var jsonStr = eval('('+elevatorNonstandardformJson+')');
			for(var i=0;i<jsonStr.length-1;i++){
				addNonstandardFormRows();
			}
			for(var j=0;j<jsonStr.length;j++){
				$("#elevatorNonstandardForm").find("tr:not(:first)").eq(j).each(function(){
					$(this).find("td").eq(0).val(jsonStr[j].elevator_no);
					$(this).find("td").eq(1).find("input:hidden").val(jsonStr[j].centre_id);
					$(this).find("td").eq(1).find("textarea").eq(0).val(jsonStr[j].elevator_description);
				});
				
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
    //-----------------------------------------zTree绑定---------------------------------------

    
    
    function showMenu(obj) {

      //设置点击的输入框所在坐标
      var clickCellIndex = $(obj).parent().index();
      var clickRowIndex = $(obj).parent().parent().index();
      $("#clickCellIndex").val(clickCellIndex);
      $("#clickRowIndex").val(clickRowIndex);


      var cascadeObj = $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(clickCellIndex).find("input").eq(0);
      var cascadeOffset = $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(clickCellIndex).find("input").eq(0).offset();
      $("#menuContent").css({left:(cascadeOffset.left+6) + "px", top:cascadeOffset.top + cascadeObj.outerHeight() + "px"}).slideDown("fast");

      $("body").bind("mousedown", onBodyDown);
    }
    

    function onBodyDown(event) {
      if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
        hideMenu();
      }
    }

    function hideMenu() {
      $("#menuContent").fadeOut("fast");
      $("body").unbind("mousedown", onBodyDown);
    }

    function beforeClick(){

    }

    function onClick(e, treeId, treeNode){
      var id = treeNode.id;
      var name = treeNode.name;
      var clickCellIndex = $("#clickCellIndex").val();
      var clickRowIndex = $("#clickRowIndex").val();
      var level = treeNode.level;
      var obj = $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(clickCellIndex).find("input").eq(0);
      $(obj).parent().parent().find("td").eq(4).html("");
      $(obj).parent().parent().find("td").eq(5).html("");
      $(obj).parent().parent().find("td").eq(6).html("");
      if(level==1){//选择第一级菜单
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(0).val(treeNode.name);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(0).val("");
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(0).val("");
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(0).val("");

        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(1).val(treeNode.id);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(1).val("");
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(1).val("");
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(1).val("");
      }else if(level==2){//选择第二级菜单
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(0).val(treeNode.getParentNode().name);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(0).val(treeNode.name);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(0).val("");
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(0).val("");

        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(1).val(treeNode.getParentNode().id);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(1).val(treeNode.id);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(1).val("");
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(1).val("");
      }else if(level==3){//选择第三级菜单
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(0).val(treeNode.getParentNode().getParentNode().name);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(0).val(treeNode.getParentNode().name);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(0).val(treeNode.name);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(0).val("");

        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(1).val(treeNode.getParentNode().getParentNode().id);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(1).val(treeNode.getParentNode().id);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(1).val(treeNode.id);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(1).val("");
      }else if(level==4){//选择第四级菜单
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(0).val(treeNode.getParentNode().getParentNode().getParentNode().getParentNode().name);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(0).val(treeNode.getParentNode().getParentNode().name);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(0).val(treeNode.getParentNode().name);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(0).val(treeNode.name);


        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(1).val(treeNode.getParentNode().getParentNode().getParentNode().getParentNode().id);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(1).val(treeNode.getParentNode().getParentNode().id);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(1).val(treeNode.getParentNode().id);
        $("#elevatorOptionalTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(1).val(treeNode.id);
      }


      //判断ID不为空
      if(id != null && id !=""){
        $.post("models/addElevatorOptional.do",{parentId:id},function(result){
          countsPrice();
          var elevatorCascadeList = eval(result.elevatorCascadeList);
          var elevatorUnitList = eval(result.elevatorUnitList);
          if(elevatorCascadeList != null){
          }else{
            var elevator_unit_name = "";
            for(var i=0;i<elevatorUnitList.length;i++){
              if(elevatorUnitList[i].elevator_unit_id == result.elevator_unit_id){
                elevator_unit_name = elevatorUnitList[i].elevator_unit_name;
                break;
              }
            }
            
            /*$(obj).parent().parent().find("td").eq(4).append(elevator_unit_name);
            $(obj).parent().parent().find("td").eq(5).append(result.elevator_optional_delivery);
            $(obj).parent().parent().find("td").eq(6).append(result.elevator_optional_price);*/
            $(obj).parent().parent().find("td").eq(4).html(elevator_unit_name);
            $(obj).parent().parent().find("td").eq(5).html(result.elevator_optional_delivery);
            $(obj).parent().parent().find("td").eq(6).html(result.elevator_optional_price);
            
            countsPrice();
          } 
          hideMenu();
        });
      }
    }

    //-----------------------------------------zTree菜单搜索------------------------------------
     // 树形结构搜索
  function searchTreeNodesByKeyWord() {

    if(zNodes.id == null){
      return false;
    }
    // 将原树形结构恢复默认状态
    // 声明一个新的树对象
    var newZNodes = null;
    var zNode= orderSiblingsByUid(zNodes);
    // 将原树对象复制出一个副本，并将这个副本JSON字符串转换成新的树对象
    var treeJSON = cloneTreeNodes(zNode);
    newZNodes = eval('(' + '[' + treeJSON + ']' + ')');
    var root = newZNodes[0];
    // 对新树对象建立反向引用关系（在子节点中增加父节点的引用）
    var nodeMap = {};
    // 构造节点映射表（下面借助该映射表建立反向引用关系）
    nodeMap = buildNodeMap(root, nodeMap);
    // 建立子节点对父节点的引用
    nodeMap = buildParentRef(root, nodeMap);
    // 设置树节点为“不可见”状态
    setTreeNotVisible(root);
    // 搜索包含关键字的树节点，将包含关键字的节点所在路径设置为“可见”，例如：如果某一节点包含搜索关键字，
    // 那么它的所有上级节点和所有下级节点都设置为“可见”
    searchTreeNode(root, root, nodeMap, document.getElementById('keyWord').value);
    // 对树形结构数据进行搜索过滤后，根据JavaScript树状对象，重新生成JSON字符串
    treeJSON = reBuildTreeJSON(root);
    newZNodes = eval('(' + '[' + treeJSON + ']' + ')');
    $.fn.zTree.init($("#cascade_zTree"), setting, newZNodes);
    $.fn.zTree.getZTreeObj("cascade_zTree").expandAll(true);
  }

  // 将原树形结构数据复制出一个副本，以备对副本进行搜索过滤，而不破坏原始数据（原始数据用来恢复原状用）【先序遍历法】
  function cloneTreeNodes(root) {
    if(root.iconSkin!=null&&root.iconSkin!=undefined){
      var treeJSON = '{' + '\'name\' : \'' + root.name + '\', \'id\' : \'' + root.id + '\',' + '\'parentId\' : \'' + root.parentId + '\',' + ' \'orderNo\' : ' + root.orderNo+ ', \'iconSkin\' : \'' + root.iconSkin+ '\', \'nodeType\' : \'' + root.nodeType+'\'';
    }else{
      var treeJSON = '{' + '\'name\' : \'' + root.name + '\', \'id\' : \'' + root.id + '\',' + '\'parentId\' : \'' + root.parentId + '\',' + ' \'orderNo\' : ' + root.orderNo+ ', \'iconSkin\' : ' + root.iconSkin+ ', \'nodeType\' : \'' + root.nodeType+'\'';
    }
    if (root.children && root.children.length != 0) {
      treeJSON += ', \'children\' : [';
      for (var i = 0; i < root.children.length; i++) {
        treeJSON += cloneTreeNodes((root.children)[i]) + ',';
      }
      treeJSON = treeJSON.substring(0, treeJSON.length - 1);
      treeJSON += "]";
    }
    return treeJSON + '}';
  }

  // 构造节点映射表【先序遍历法】
  // 这里特殊说明一下：
  // 构造节点映射表的目的，是为了下面建立子节点对父节点的引用，这是一个中间步骤，但是有个小问题：
  // 在javascript中，如果是在原树状对象上建立子节点对父节点的引用，会发生『Stack overflow』错误，
  // 我估计是由于循环引用造成的，因为原树状对象已经存在父节点对子节点的引用，此时再建立子节点对
  // 父节点的引用，造成循环引用，这在Java中是没有问题的，但是在JavaScript中却有问题，所以为了避免
  // 这个问题，我创建了一批新的节点，这些节点的内容和原树状结构节点内容一致，但是没有children属性，
  // 也就是没有父节点对子节点的引用，然后对这批新节点建立子节点对父节点的引用关系，这个方法会被buildParentRef()方法调用，来完成这个目的。
  function buildNodeMap(node, nodeMap) {
    var newObj = new Object();
    newObj.name = node.name;
    newObj.id = node.id;
    newObj.parentId = node.parentId;
    newObj.orderNo = node.orderNo;
    newObj.ex_visible = node.ex_visible;
    nodeMap['_' + node.id] = newObj;
    if (node.children && node.children.length != 0) {
      for (var i = 0; i < node.children.length; i++) {
        buildNodeMap((node.children)[i], nodeMap);
      }
    }
    return nodeMap; // 这里需要将nodeMap返回去，然后传给buildParentRef()函数使用，这和Java中的引用传递不一样，怪异！！
  }

  // 建立子节点对父节点的引用
  function buildParentRef(node, nodeMap) {
    for (id in nodeMap) {
      if ((nodeMap[id]).parentId == '') {
        (nodeMap[id]).ex_parentNode = null;
      } else {
        (nodeMap[id]).ex_parentNode = nodeMap['_' + (nodeMap[id]).parentId];
      }
    }
    return nodeMap;
  }


  // 对树形结构数据进行搜索过滤后，根据JavaScript树状对象，重新生成JSON字符串【先序遍历法】
  function reBuildTreeJSON(node) {
    if (node.ex_visible) {
      if(node.iconSkin!=null&&node.iconSkin!=undefined){
        var treeJSON = '{' + '\'name\' : \'' + node.name + '\', \'id\': \'' + node.id + '\',' + '\'parentId\' : \'' + node.parentId + '\',' + ' \'orderNo\' : ' + node.orderNo + ', \'iconSkin\' : \'' + node.iconSkin + '\', \'nodeType\' : \'' + node.nodeType + '\', \'ex_visible\' : '  + node.ex_visible + ', \'ex_parentNode\' : null';
      }else{
        var treeJSON = '{' + '\'name\' : \'' + node.name + '\', \'id\': \'' + node.id + '\',' + '\'parentId\' : \'' + node.parentId + '\',' + ' \'orderNo\' : ' + node.orderNo + ', \'iconSkin\' : ' + node.iconSkin + ', \'nodeType\' : \'' + node.nodeType + '\', \'ex_visible\' : ' + node.ex_visible +', \'ex_parentNode\' : null';
      }
      if (node.children && node.children.length != 0) {
        treeJSON += ', \'children\' : [';
        for (var i = 0; i < node.children.length; i++) {
          if ((node.children)[i].ex_visible) {
            treeJSON += reBuildTreeJSON((node.children)[i]) + ',';
          } else {
            treeJSON += reBuildTreeJSON((node.children)[i]);
          }
        }
        treeJSON = treeJSON.substring(0, treeJSON.length - 1);
        treeJSON += "]";
      }
      return treeJSON + '}';
    } else {
      return '';
    }
  }
  // 搜索包含关键字的树节点，将包含关键字的节点所在路径设置为“可见”，例如：如果某一节点包含搜索关键字，
  // 那么它的所有上级节点和所有下级节点都设置为“可见”【先序遍历法】
  function searchTreeNode(root1, root2, nodeMap, keyWord) {
    if (root2.name.toLowerCase().indexOf(keyWord.toLowerCase()) > -1) {//大小写不敏感
//            if (root2.name.indexOf(keyWord) > -1) {//大小写敏感
      setTreeVisible(root2);
      setRouteVisible(root1, root2, nodeMap);
    } else {
      if (root2.children && root2.children.length != 0) {
        for (var i = 0; i < root2.children.length; i++) {
          searchTreeNode(root1, (root2.children)[i], nodeMap, keyWord);
        }
      }
    }
  }
  // 设置树节点为“不可见”状态【先序遍历法】
  function setTreeNotVisible(root) {
    root.ex_visible = false;
    if (root.children && root.children.length != 0) {
      for (var i = 0; i < root.children.length; i++) {
        setTreeNotVisible((root.children)[i]);
      }
    }
  }
  // 设置树节点为“可见”状态【先序遍历法】
  function setTreeVisible(root) {
    root.ex_visible = true;
    if (root.children && root.children.length != 0) {
      for (var i = 0; i < root.children.length; i++) {
        setTreeVisible((root.children)[i]);
      }
    }
  }
  // 设置当前节点及其所有上级节点为“可见”状态
  function setRouteVisible(root, node, nodeMap) {
    node.ex_visible = true;
    var parentNodes = [];
    var currentNode = nodeMap['_' + node.id];
    var parentNode = currentNode.ex_parentNode;
    while (parentNode != null) {
      parentNodes.push(parentNode);
      parentNode = parentNode.ex_parentNode;
    }
    // 如果没有上级节点，说明当前节点就是根节点，直接返回即可
    if (parentNodes.length == 0) {
      return;
    }
    setParentNodesVisible(root, parentNodes);
  }
  // 设置所有上级节点为“可见”，
  // 这是由于在JavaScript中无法建立像Java中的那种带有双向引用的多叉树结构（即父节点
  // 引用子节点，子节点引用父节点），在JavaScript中如果做这种双向引用的话，会造成『Stack overflow』异常，所以只能分别建立
  // 两棵多叉树对象，一棵是原始树形结构对象，另一棵是利用nodeMap建立的多叉树对象，专门用于反向引用，即子节点对父节点的引用。
  // 而在Java中，直接可以根据一个节点的父节点引用，找到它所有的父节点。但是在这里，只能采用一种笨办法，先从反向引用的多叉树
  // 中找到某一节点的所有父节点，存在一个数组里，然后在原始树形结构对象中使用先序遍历方法，从顶向下依次查找，把某一节点的所有
  // 父节点设置为可见，效率较低，但与利用反向引用查找父节点的方法目的是一样的。
  function setParentNodesVisible(node, parentNodes) {
    if (containNode(node, parentNodes)) {
      node.ex_visible = true;
    }
    if (node.children && node.children.length != 0) {
      var i = 0;
      for (; i < node.children.length; i++) {
        if (containNode(node, parentNodes)) {
          setParentNodesVisible((node.children)[i], parentNodes);
        }
      }
      // 如果在本层节点中没有找到要设置“可见性”的节点，说明需要设置“可见性”的节点都已经找完了，不需要再向下一层节点中寻找了，
      // 直接退出递归函数
      if (i == node.children.length - 1) {
        return;
      }
    }
  }
  // 检查数组中是否包含与指定节点编号相同的节点
  function containNode(node, parentNodes) {
    for (var i = 0; i < parentNodes.length; i++) {
      if (parentNodes[i].id == node.id) {
        return true;
      }
    }
    return false;
  }
  // 按照节点编号对树形结构进行兄弟节点排序【递归排序】
  function orderSiblingsByUid(node) {
    if (node.children && node.children.length != 0) {
      bubbleSortByUid(node.children);
      for (var i = 0; i < node.children.length; i++) {
        orderSiblingsByUid((node.children)[i]);
      }
    }
    return node;
  }
  // 排序方法：按照排序编号排序，排序编号小的排在前面，重复的按名称【冒泡法排序】
  function bubbleSortByUid(theArray) {
    var temp;
    for (var i = 0; i < theArray.length - 1; i++) {
      for (var j = theArray.length - 1; j > i; j--) {
        if (theArray[j].orderNo < theArray[j - 1].orderNo) {
          temp = theArray[j];
          theArray[j] = theArray[j - 1];
          theArray[j - 1] = temp;
        }
      }
    }
    return theArray;
  }
	</script>
</html>
