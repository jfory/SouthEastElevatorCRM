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
<form action="offer/${msg}.do" name="elevatorSetForm" id="elevatorSetForm" method="post">
	<input type="hidden" name="centre_id" id="centre_id" value="${centre_id}" />
    <input type="hidden" name="elevator_id" id="elevator_id" value="${elevator_id}" />
    <input type="hidden" name="models_id" id="models_id" value="${models_id}" />
    <input type="hidden" name="state" id="state" value="${state}">
    <input type="hidden" name="countsPrice" id="countsPrice">
    <input type="hidden" name="jsonStr" id="jsonStr" value="${jsonStr}">

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
                        非标项配置
                </div>
                <div class="panel-body">
                    <div class="form-group form-inline">
                        <table class="table table-striped table-bordered table-hover" id="elevatorNonstandardTable">
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
                                        <input type="text" style="border-style: none;width: 100%" onclick="showMenu(this)">
                                        <input type="hidden">
                                    </td>
                                    <td>
                                        <input type="text" style="border-style: none;width: 100%" onclick="showMenu(this)">
                                        <input type="hidden">
                                    </td>
                                    <td>
                                        <input type="text" style="border-style: none;width: 100%" onclick="showMenu(this)">
                                        <input type="hidden">
                                    </td>
                                    <td>
                                        <input type="text" style="border-style: none;width: 100%" onclick="showMenu(this)">
                                        <input type="hidden">
                                    </td>
                                    <td></td>
                                    <td></td>
                                    <td><input type="text" style="border-style: none;width: 100%"></td>
                                    <td><button class="btn  btn-primary btn-sm" title="新增" type="button"onclick="addNonstandardRows();">新增</button></td>
                                </tr>
                        </table>
                    </div>
               </div>
            </div>
        </div>
        </div>

        <div style="height: 20px;"></div>
        <tr>
        <td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
        <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="CloseSUWin('setElevator');">关闭</a></td>
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

        //获取非标项json
        var jsonStr = $("#jsonStr").val();
        if(jsonStr!=""){
            loadJsonStr(jsonStr);   
        }

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


    //--------------------------------------------

    function addNonstandardRows(){
      var tr = $("#elevatorNonstandardTable").find("tr").eq(1).clone();
      $(tr).find("td").eq(0).find("input").val("");
      $(tr).find("td").eq(1).find("input").val("");
      $(tr).find("td").eq(2).find("input").val("");
      $(tr).find("td").eq(3).find("input").val("");
      $(tr).find("td").eq(4).empty();
      $(tr).find("td").eq(5).empty();
      $(tr).find("td").eq(6).find("input").val("");
      $(tr).find("td:last").html("").append(
                          '<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delRows(this);">删除</button>'
                          );
      $("#elevatorNonstandardTable").append(tr);
    }

    //加载可选项json数据
    function loadJsonStr(jsonStr){
        var jsonStrList = eval('('+jsonStr+')');
        
        //添加行
        for(var i=0;i<jsonStrList.length-1;i++){
            addNonstandardRows();
        }
            
        //读取菜单数据
        for(var i=0;i<jsonStrList.length;i++){
            $("#elevatorNonstandardTable").find("tr:not(:first)").eq(i).each(function(){
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
                $(this).find("td").eq(5).html(jsonStrList[i].elevator_nonstandard_delivery);
                $(this).find("td").eq(6).find("input").eq(0).val(jsonStrList[i].elevator_nonstandard_price);
            });
        }
    }

    //--------------------------------------------

    function save(){
        var countsPrice = 0;
        //获取当前非标项描述id
        var centreId = $("#centre_id").val();
        //非标项配置json
        var jsonStr = "";
        $("#elevatorNonstandardTable tr:not(:first)").each(function(){
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
            var elevator_nonstandard_delivery =  $(this).find("td").eq(5).html();
            var elevator_nonstandard_price =  $(this).find("td").eq(6).find("input").eq(0).val();
            jsonStr += "{";
            jsonStr += "'centre_id':'" + centreId + "',"
            jsonStr += "'parentMenu':'" + parentMenu + "',"
            jsonStr += "'parentMenuName':'" + parentMenuName + "',"
                    jsonStr += "'twoMenu':'" + twoMenu + "',"
            jsonStr += "'twoMenuName':'" + twoMenuName + "',"
                    jsonStr += "'threeMenu':'" + threeMenu + "',"
            jsonStr += "'threeMenuName':'" + threeMenuName + "',"
                    jsonStr += "'fourMenu':'" + fourMenu + "',"
            jsonStr += "'fourMenuName':'" + fourMenuName + "',"
            jsonStr += "'elevator_unit_name':'" + elevator_unit_name + "',"
            jsonStr += "'elevator_nonstandard_delivery':'" + elevator_nonstandard_delivery + "',"
            jsonStr += "'elevator_nonstandard_price':'" + elevator_nonstandard_price + "'},"
            console.log("elevator_nonstandard_price:"+elevator_nonstandard_price);
            countsPrice += parseInt(elevator_nonstandard_price);


        });
        jsonStr = jsonStr.substring(0,jsonStr.length-1);
        $("#elevator_nonstandard_json").val(jsonStr);
        $("#countsPrice").val(countsPrice);
        $("#elevatorSetForm").submit();
    }

    function CloseSUWin(id) {
        window.parent.$("#" + id).data("kendoWindow").close();
    }

    //--------------------------------------------
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
