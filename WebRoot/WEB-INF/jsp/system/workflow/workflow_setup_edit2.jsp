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
    <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css"/>

    <title>${pd.SYSNAME}</title>
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	
</head>

<body class="gray-bg">
<form action="auto_respon/${msg}.do" name="autoResonForm" id="autoResonForm" method="post">
	<input type="hidden" name="autoid" id="autoid" value="${pd.autoid}" />
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
                                <%--select menu--%>
                                <div class="ibox float-e-margins" id="menuContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
                                    <div class="ibox-content">
                                        <div>
                                            <input class="form-control" style="height: 30px" type="text" placeholder="搜索" id="keyWord" onkeyup="searchTreeNodesByKeyWord()">
                                            <ul id="myzTree" class="ztree" style="margin-top:0; width:160px;"></ul>
                                        </div>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <select class="form-control" name="assign_type" id="assign_type" title="任务角色类型">
										<option value="0"
											<c:if test="${pd.assign_type == '0'}"> selected</c:if>>
											个人
										</option>
										<option value="1"
											<c:if test="${pd.assign_type == '1'}"> selected</c:if>>
											职位
										</option>
                                        <option value="2"
                                                <c:if test="${pd.assign_type == '2'}"> selected</c:if>>
                                            部门
                                        </option>
									</select>
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" readonly type="text" name="person" id="person" placeholder="点击这里选取" value="${pd.keyword}" onclick="showMenu1();" title="选择该任务的处理角色" />
                                    </div>
                                    <div class="form-group">
                                   		 <input class="form-control"  type="text" name="title" id="title" placeholder="这里输入标题" value="${pd.title }" title="标题" />
                                    </div>
                                    <div class="form-group">
                                    	 <input class="form-control"  type="text" name="texturl" id="texturl" placeholder="这里输入链接地址" value="${pd.texturl }" title="链接地址" />
                                    </div>
                                    <div class="form-group">
                                    	<div  id="picurltip" style="color: red;">图片链接，支持JPG、PNG格式，较好的效果为大图360*200，小图200*200</div>
                                    </div>
                            
                            </div>
                            
                        </div>
                        
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>\
                        <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddAutoRespon');">关闭</a></td>

						</tr>
					</div>
            </div>
            
        </div>
 </div>
 </form>
 
</body>
<script type="text/javascript" src="plugins/zTree/3.5.24/js/jquery.ztree.all.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){

	});
    function showMenu1() {
        var person = $("#person");
        var personOffset = $("#person").offset();
        $("#menuContent").css({left:(personOffset.left+6) + "px", top:personOffset.top + person.outerHeight() + "px"}).slideDown("fast");

        $("body").bind("mousedown", onBodyDown);
    }
	
		//保存
		function save(){
		
		if($("#keyword").val()=="")
		{
		$("#keyword").tips({
					side:3,
		            msg:'请输入关键字',
		            bg:'#AE81FF',
		            time:2
		        });
		        $("#keyword").focus();
					return false;
		}
	
		if($("#t_type").val() =="1")
		{
		if($("#title").val()=="")
		{
		$("#title").tips({
					side:3,
		            msg:'请输入标题',
		            bg:'#AE81FF',
		            time:2
		        });
		        $("#title").focus();
				return false;
		}
		if($("#texturl").val()=="")
		{
		$("#texturl").tips({
					side:3,
		            msg:'请输入网页链接',
		            bg:'#AE81FF',
		            time:2
		        });
		        $("#texturl").focus();
				return false;
		}
		if($("#picurl").val()=="")
		{
		$("#picurl").tips({
					side:3,
		            msg:'请输入图片链接',
		            bg:'#AE81FF',
		            time:2
		        });
		        $("#picurl").focus();
				return false;
		}
	   }
		if($("#description").val()=="")
		{
		$("#description").tips({
					side:3,
		            msg:'请输入内容',
		            bg:'#AE81FF',
		            time:2
		        });
		        $("#description").focus();
				return false;
		}
			
			$("#autoResonForm").submit();
		}
		
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		}
	</script>
</html>
