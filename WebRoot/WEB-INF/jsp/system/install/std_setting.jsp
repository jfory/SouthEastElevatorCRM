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
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg" >
<form action="install/${msg}.do" name="standardForm" id="standardForm" method="post">
    <input type="hidden" name="check_json" id="check_json">
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                基本信息
                            </div>
                            <div class="panel-body">
                                <div class="form-group form-inline">
                                    <label>类型:</label>
                                    <select name="elevator_id" id="elevator_id" class="form-control m-b" onchange="setModelList();">
                                        <option value="">请选择梯种</option>
                                        <option value="1">常规梯</option>
                                        <option value="2">家用梯</option>
                                        <option value="3">特种梯</option>
                                    </select>
                                    <label style="margin-left: 20px">型号:</label>
                                    <select class="form-control m-b" name="models_id" id="models_id">
                                        <option value="">请选择型号</option>
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
                                规格信息
                            </div>
                            <div class="panel-body" name="setting" id="setting">
                                <div class="form-group form-inline" name="class">
                                <label>分类名:</label>
                                <input type="text" class="form-control">
                                <input type="button" onclick="cloneGroup();" value="添加">
                                <input type="button" onclick="removeGroup(this);" value="删除">
                                <input type="button" onclick="showDiv(this);" value="展开">
                                <table class="table table-striped table-bordered table-hover" name="tab" >
                                    <tr>
                                        <th style="width:15%;">名称</th>
                                        <th style="width:15%;">标准值</th>
                                        <th style="width:10%;">公差</th>
                                        <th style="width:10%;">单位</th>
                                        <th style="width:15%;">操作</th>  
                                    </tr>
                                    <tr>
                                        <td><input type="text" class="form-control"></td>
                                        <td><input type="text" class="form-control"></td>
                                        <td><input type="text" class="form-control"></td>
                                        <td><input type="text" class="form-control"></td>
                                        <td>
                                            <input type="button" onclick="cloneRow(this)" value="添加">
                                            <input type="button" onclick="removeRow(this)" value="删除">
                                        </td>
                                    </tr>
                                </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <tr>
                <td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditStandard');">关闭</a></td>
                </tr>
            </div>
        </div>
    </div>
</form>

 <!--返回顶部开始-->
        <div id="back-to-top">
            <a class="btn btn-warning btn-back-to-top" href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
                <i class="fa fa-chevron-up"></i>
            </a>
        </div>
        <!--返回顶部结束-->
	<!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert/sweetalert.min.js"></script>
	<script type="text/javascript">
	 $(document).ready(function () {
		//loading end
		parent.layer.closeAll('loading');
		/* checkbox */
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });
     });

     /* checkbox全选 */
     $("#zcheckbox").on('ifChecked', function(event){
        
        $('input').iCheck('check');
    });
     /* checkbox取消全选 */
     $("#zcheckbox").on('ifUnchecked', function(event){
        
        $('input').iCheck('uncheck');
    });

    //修改梯型下拉框
    function setModelList(){
        var elevator_id = $("#elevator_id").val();
        $.post("<%=basePath%>install/setModelList.do?elevator_id="+elevator_id,
                function(data){
                    if(data.msg=="success"){
                        var jsonObj = data.modelsList;
                        var optionStr = "<option value=''>请选择型号</option>";
                        $.each(jsonObj, function(index, obj){
                            optionStr += "<option value='"+obj.models_id+"'>"+obj.models_name+"</option>"
                        });
                        $("#models_id").empty();
                        $("#models_id").append(optionStr);
                    }
                }
        );
    }

    //添加一个规格分类
    function cloneGroup(){
        var obj = $("div[name='class']").eq(0).clone();
        $("#setting").append(obj);
    }

    //删除规格分类
    function removeGroup(obj){
        $(obj).parent().remove();
    }

    //添加行
    function cloneRow(obj){
        var c_tr = $("table[name='tab']").eq(0).find("tr").eq(1).clone();
        $(obj).parent().parent().parent().parent().append(c_tr);
    }

    //删除行
    function removeRow(obj){
        $(obj).parent().parent().remove();
    }

    //展开
    function showDiv(obj){
        var flag = $(obj).parent().find("table").eq(0).is(':hidden');
        if(flag){
            $(obj).parent().find("table").eq(0).show();
        }else{
            $(obj).parent().find("table").eq(0).hide();
        }
    }

    //保存
    function save(){
        setJson();
        alert($("#check_json").val());
        $("#standardForm").submit();
    }

    //获取标准规格json
    function setJson(){
        var jsonStr = "[";
        var childStr = "[";
        $("div[name='class']").each(function(index, obj){
            var type = $(obj).find("input").eq(0).val();
            jsonStr += "{'type':'"+type+"','children':";
            var trObj = $(obj).find("table").find("tr:not(:first)");
            $(trObj).each(function(trIndex, trObj){
                var name = $(trObj).find("input").eq(0).val();
                var std = $(trObj).find("input").eq(1).val();
                var tol = $(trObj).find("input").eq(2).val();
                var unit = $(trObj).find("input").eq(3).val();
                childStr += "{'name':'"+name+"','std':'"+std+"','tol':'"+tol+"','unit':'"+unit+"'},"
            });
            childStr = childStr.substring(0,childStr.length-1)+"]";
            jsonStr = jsonStr+childStr+"},";
            childStr = "[";
        });
        jsonStr = jsonStr.substring(0,jsonStr.length-1)+"]";
        $("#check_json").val(jsonStr);
    }

	//刷新iframe
    function refreshCurrentTab() {
     	$("#standardForm").submit();
    }

	function CloseSUWin(id){
		window.parent.$("#"+id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
