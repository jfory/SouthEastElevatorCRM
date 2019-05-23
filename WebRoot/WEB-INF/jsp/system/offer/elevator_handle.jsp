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
	<div id="setElevator" class="animated fadeIn"></div>
	<input type="hidden" name="models_id" id="models_id" value="${pd.models_id}" />
	<input type="hidden" name="elevator_id" id="elevator_id" value="${pd.elevator_id}" />
	<input type="hidden" name="flag" id="flag" value="${flag}" />
	<input type="hidden" name="state" id="state" value="${state}">
	<input type="hidden" name="id" id="id" value="${id}" />
	<input type="hidden" name="elevator_nonstandard_json" id="elevator_nonstandard_json" value="${pd.elevator_nonstandard_json}">
  	<input type="hidden" name="clickCellIndex" id="clickCellIndex">
    <input type="hidden" name="clickRowIndex" id="clickRowIndex">
	<div class="wrapper wrapper-content" style="z-index: -1">
	    <div class="row">
	        <div class="col-sm-12" >
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
											<select style="width: 25%" class="form-control" id="elevator_storey_id" name="elevator_storey_id" onchange="countStandardPrice()">
											</select>	 	
                                    	</div>
                                   </div>
                                </div>
                            </div>
                            </div>
                            <div class="row">
                            <div class="col-sm-12">
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
	                                    			</tr>
	                                    			
	                                    			<tr>
	                                    				<td>
	                                    					<input type="text" style="border-style: none;width: 100%">
														</td>
														<td>
															<input type="text" style="border-style: none;width: 100%">
														</td>
														<td>
															<input type="text" style="border-style: none;width: 100%">
														</td>
														<td>
															<input type="text" style="border-style: none;width: 100%">
														</td>
	                                    				<td></td>
	                                    				<td></td>
	                                    				<td></td>
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
                            </div>
                            </div>

	                		<div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	非标项配置
                                    </div>
                                    <div class="panel-body" id="nonstandardDiv">
                                        <c:forEach items="${ncPdList }" var="nc">
                                        <div class="form-group form-inline">
                                        	<label>非标项描述:</label>
                                        	<textarea>
                                        		${nc.elevator_description}
                                        	</textarea>
                                        	<c:if test="${state == '2'}">
                                        		<button class="btn  btn-primary btn-sm" title="配置" type="button" onClick="setElevator(${nc.centre_id});" name="set">配置</button>
                                        	</c:if>
                                        	<input type="hidden" id="${nc.centre_id}" name="${nc.centre_id}">
                                        	<c:if test="${state == '3'}">
                                        		<button class="btn btn-warning btn-sm" title="报价" type="button" onClick="setElevator(${nc.centre_id});" name="offer">报价</button>
                                        	</c:if>
                                        </div>
                                      </c:forEach>
                                   </div>
                                </div>
                            </div>
                            </div>

                            <div class="row">
                            <div class="col-sm-12">
                            	<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	配置详情
                                    </div>
                                    <div class="panel-body" >
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
                                    			
                                   			<label style="width:6%">非标项总价格:</label>
                                       		<input style="width:25%" type="text" readonly="readonly" placeholder="总价格"  id="elevator_nonstandard_price" name="elevator_nonstandard_price" value="${pd.elevator_nonstandard_price }" class="form-control">
                                        	
                                        	<label style="width:6%">名称:</label>
                                       		<input style="width:25%" type="text"  placeholder="请输入名称"  id="models_name" name="models_name" value="${pd.models_name }" class="form-control">	 	
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
	<script type="text/javascript"
  src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
  	<script type="text/javascript"
  src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
  	<script type="text/javascript"
  src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function(){
		//选配JSON		
		var jsonStr = $("#elevator_optional_json").val();
		loadJsonStr(jsonStr);

		//加载电梯楼层
		findStoreyBySpeedId();

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

	    setDisable();

	    initNonstandardJson();
	});
	
		
	//---------------------------------------------------------------------------------------------

	function initNonstandardJson(){
		var jsonStr = $("#elevator_nonstandard_json").val();
		var jsonStrList = eval('('+jsonStr+')');
		for(var i=0;i<jsonStrList.length;i++){
			$("#nonstandardDiv").find("div").each(function(){
				var id = $(this).find("input").eq(0).attr("id");
				if(id==jsonStrList[i].centre_id){
					$(this).find("input").eq(0).val(JSON.stringify(jsonStrList[i]));
				}
			});
		}
	}

	function setDisable(){
		var inputs = document.getElementsByTagName("input");
		for(var i = 0;i<inputs.length;i++){
			inputs[i].setAttribute("disabled","true");
		}
		var textareas = document.getElementsByTagName("textarea");
		for(var i = 0;i<textareas.length;i++){
			textareas[i].setAttribute("disabled","true");
		}
		var selects = document.getElementsByTagName("select");
		for(var i = 0;i<selects.length;i++){
			selects[i].setAttribute("disabled","true");
		}

		$("#nonstandardDiv").find("div").eq(0).find("input").eq(0).removeAttr("disabled");
		$("#models_id").removeAttr("disabled");
		$("#elevator_nonstandard_json").removeAttr("disabled");
		$("#elevator_nonstandard_price").removeAttr("disabled");
	}


	//---------------------------------------------save--------------------------------------------

	function save(){

		//保存非标json
		var jsonStr = "[";
		//逐个获取非标项配置json
		$("#nonstandardDiv").find("div").each(function(){
			var setting = $(this).find("input").eq(0).val();
			var centreId = $(this).find("input").eq(0).attr("id");
			if(setting!=""){
				jsonStr += setting+",";
			}
		});
		jsonStr = jsonStr.substring(0,jsonStr.length-1)+"]";
		console.log("jsonStr:"+jsonStr);
		if(jsonStr!="]"){
			$("#elevator_nonstandard_json").val(jsonStr);
			$("#functionSetForm").submit();
		}else{
			if($("#elevator_nonstandard_json").val()!=""){
				$("#functionSetForm").submit();
			}else{
				alert("error");	
			}
		}
	}

	//---------------------------------------------------------------------------------------------
	//加载可选项json数据
	function loadJsonStr(jsonStr){
		var jsonStrList = eval('('+jsonStr+')');
		
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
	          
	          
	            $(this).find("td").eq(1).find("input").eq(0).val(jsonStrList[i].twoMenuName);
	            $(this).find("td").eq(2).find("input").eq(0).val(jsonStrList[i].threeMenuName);
	            $(this).find("td").eq(3).find("input").eq(0).val(jsonStrList[i].fourMenuName);
	            $(this).find("td").eq(4).html(jsonStrList[i].elevator_unit_name);
	            $(this).find("td").eq(5).html(jsonStrList[i].elevator_optional_delivery);
	            $(this).find("td").eq(6).html(jsonStrList[i].elevator_optional_price);
            });
        }
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
        $("#elevatorOptionalTable").append(tr);
	}

	//---------------------------------------------------------------------------------------------

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
			});
		}else{
			$("#elevator_storey_id").append('<option value="">请先选择电梯速度参数</option>');
		}
		
	}

	//---------------------------------------------------------------------------------------------

	function setElevator(centre_id){
		var elevator_id = $("#elevator_id").val();
		var models_id = $("#models_id").val();
		var state = $("#state").val();
		$("#setElevator").kendoWindow({
			width:"1200px",
			height:"700px",
			title:"配置参数",
			actions: ["Close"],
	        content: '<%=basePath%>offer/goSetElevator.do?centre_id='+centre_id+'&elevator_id='+elevator_id+'&models_id='+models_id+'&state='+state,
	        modal : true,
			visible : false,
			resizable : true
		}).data("kendoWindow").maximize().open();
	}

	function addNonstandardRows(){
      var tr = $("#elevatorNonstandardTable").find("tr").eq(1).clone();
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
      $("#elevatorNonstandardTable").append(tr);
	}

	//---------------------------------------------------------------------------------------------
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
	}
	//-----------------------------------------zTreeFunction---------------------------------------
	function beforeClick(){}

	function onClick(e, treeId, treeNode){
      var id = treeNode.id;
      var name = treeNode.name;
      var clickCellIndex = $("#clickCellIndex").val();
      var clickRowIndex = $("#clickRowIndex").val();
      var level = treeNode.level;
      var obj = $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(clickCellIndex).find("input").eq(0);
      $(obj).parent().parent().find("td").eq(4).html("");
      $(obj).parent().parent().find("td").eq(5).html("");
      $(obj).parent().parent().find("td").eq(6).html("");
      if(level==1){//选择第一级菜单
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(0).val(treeNode.name);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(0).val("");
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(0).val("");
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(0).val("");

        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(1).val(treeNode.id);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(1).val("");
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(1).val("");
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(1).val("");
      }else if(level==2){//选择第二级菜单
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(0).val(treeNode.getParentNode().name);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(0).val(treeNode.name);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(0).val("");
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(0).val("");

        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(1).val(treeNode.getParentNode().id);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(1).val(treeNode.id);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(1).val("");
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(1).val("");
      }else if(level==3){//选择第三级菜单
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(0).val(treeNode.getParentNode().getParentNode().name);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(0).val(treeNode.getParentNode().name);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(0).val(treeNode.name);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(0).val("");

        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(1).val(treeNode.getParentNode().getParentNode().id);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(1).val(treeNode.getParentNode().id);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(1).val(treeNode.id);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(1).val("");
      }else if(level==4){//选择第四级菜单
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(0).val(treeNode.getParentNode().getParentNode().getParentNode().getParentNode().name);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(0).val(treeNode.getParentNode().getParentNode().name);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(0).val(treeNode.getParentNode().name);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(0).val(treeNode.name);


        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(0).find("input").eq(1).val(treeNode.getParentNode().getParentNode().getParentNode().getParentNode().id);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(1).find("input").eq(1).val(treeNode.getParentNode().getParentNode().id);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(2).find("input").eq(1).val(treeNode.getParentNode().id);
        $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(3).find("input").eq(1).val(treeNode.id);
      }

      //判断ID不为空
      /*if(id != null && id !=""){
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
            $(obj).parent().parent().find("td").eq(4).html(elevator_unit_name);
            $(obj).parent().parent().find("td").eq(5).html(result.elevator_optional_delivery);
            $(obj).parent().parent().find("td").eq(6).html(result.elevator_optional_price);
            
            countsPrice();
          } 
          hideMenu();
        });
      }*/
    }


	//-----------------------------------------zTreeDIV绑定---------------------------------------
    function showMenu(obj) {

      //设置点击的输入框所在坐标
      var clickCellIndex = $(obj).parent().index();
      var clickRowIndex = $(obj).parent().parent().index();
      $("#clickCellIndex").val(clickCellIndex);
      $("#clickRowIndex").val(clickRowIndex);


      var cascadeObj = $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(clickCellIndex).find("input").eq(0);
      var cascadeOffset = $("#elevatorNonstandardTable").find("tr").eq(clickRowIndex).find("td").eq(clickCellIndex).find("input").eq(0).offset();
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
	</script>
</html>
