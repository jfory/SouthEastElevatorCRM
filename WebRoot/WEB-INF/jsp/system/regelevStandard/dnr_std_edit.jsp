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
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	
	
</head>

<body class="gray-bg">
<form action="regelevStandard/${msg}.do" name="regelevStandardForm" id="regelevStandardForm" method="post">
    <input type="hidden" name="PRICE_TEMP" id="PRICE_TEMP">
	<input type="hidden" name="ID" id="ID" value="${pd.ID}" />
	<%--用户ID--%>
	<input type="hidden" name="requester_id" id="requester_id" value="${userpds.USER_ID}"/>
	
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
                            
                               <div class="ibox float-e-margins" id="menuContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
									<div class="ibox-content">
										
									</div>
							  </div>
							  
								
                                	<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	电梯标准价格详情
                                    </div>
                                    <div class="panel-body" >
                                        <div class="form-group form-inline">
											<span style="color: red">*</span>
											<label style="width: 10%">倾斜角度:</label>
											<select style="width: 18%" class="form-control" id="QXJD" name="QXJD" onchange="editQxjd();">
												<option value="">请选择</option>
												<option value="10">10°</option>
                                                <option value="11">11°</option>
                                                <option value="12">12°</option>
											</select>
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">踏板宽度(mm):</label>
											<select style="width: 18%" class="form-control" id="TBKD" name="TBKD" onchange="setSbj()">
												<option value="">请选择</option>
                                                <option value="800">800</option>
                                                <option value="1000">1000</option>
											</select>
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>速度</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="SD" name="SD">
                                                <option value="0.5">0.5</option>
                                            </select>
                                    	</div>
                                        
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
											<label style="width:10%" >名称:</label>
                                    		<input style="width:18%"  type="text"  placeholder="名称"  id="NAME" name="NAME" value="${pd.NAME }"  class="form-control">
                                    		&nbsp;&nbsp;&nbsp;
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>规格</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="GG" name="GG" onchange="setSbj();">
                                                <option value="">--</option>
                                            </select>
                                        </div>
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
                                   			<label style="width:10%">电梯标准金额:</label>
                                       		<input style="width:18%" type="text" placeholder="这里输入电梯标准金额"  id="PRICE" name="PRICE" value="${pd.PRICE }" class="form-control">
                                        </div>
                                   </div>
                                </div>
                            </div>
                        </div>
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                        <c:if test="${msg eq 'addRegelevStandard'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddRegelevStandard');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'editRegelevStandard'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditRegelevStandard');">关闭</a></td>
                        </c:if>
						</tr>
					</div>
            </div>
            
        </div>
 </div>
 </form> 
 
</body>
	<script type="text/javascript">

	//计算基础价
    function setSbj(){
        var gg_ = $("#GG").val();  //规格
        var qxjd_ = $("#QXJD").val();     //倾斜角度
        var tbkd_ = $("#TBKD").val();  //踏板宽度
        var price = 0;
        if(qxjd_=="12"){
            if(tbkd_=="1000"){
                if(gg_=="3.0"){
                    price =  271500;
                }else if(gg_=="3.1"){
                    price =  274500;
                }else if(gg_=="3.2"){
                    price =  277500;
                }else if(gg_=="3.3"){
                    price =  280500;
                }else if(gg_=="3.4"){
                    price =  283600;
                }else if(gg_=="3.5"){
                    price =  286600;
                }else if(gg_=="3.6"){
                    price =  289600;
                }else if(gg_=="3.7"){
                    price =  292600;
                }else if(gg_=="3.8"){
                    price =  295700;
                }else if(gg_=="3.9"){
                    price =  298700;
                }else if(gg_=="4.0"){
                    price =  301700;
                }else if(gg_=="4.1"){
                    price =  304800;
                }else if(gg_=="4.2"){
                    price =  307800;
                }else if(gg_=="4.3"){
                    price =  310800;
                }else if(gg_=="4.4"){
                    price =  313800;
                }else if(gg_=="4.5"){
                    price =  316900;
                }else if(gg_=="4.6"){
                    price =  320100;
                }else if(gg_=="4.7"){
                    price =  323100;
                }else if(gg_=="4.8"){
                    price =  326100;
                }else if(gg_=="4.9"){
                    price =  329200;
                }else if(gg_=="5.0"){
                    price =  332200;
                }else if(gg_=="5.1"){
                    price =  335200;
                }else if(gg_=="5.2"){
                    price =  338300;
                }else if(gg_=="5.3"){
                    price =  341300;
                }else if(gg_=="5.4"){
                    price =  344300;
                }else if(gg_=="5.5"){
                    price =  347300;
                }else if(gg_=="5.6"){
                    price =  350400;
                }else if(gg_=="5.7"){
                    price =  355600;
                }else if(gg_=="5.8"){
                    price =  358600;
                }else if(gg_=="5.9"){
                    price =  361600;
                }else if(gg_=="6.0"){
                    price =  364600;
                }
            }else if(tbkd_=="800"){
                if(gg_=="3.0"){
                    price =  264800;
                }else if(gg_=="3.1"){
                    price =  267800;
                }else if(gg_=="3.2"){
                    price =  270800;
                }else if(gg_=="3.3"){
                    price =  273800;
                }else if(gg_=="3.4"){
                    price =  276900;
                }else if(gg_=="3.5"){
                    price =  279900;
                }else if(gg_=="3.6"){
                    price =  282900;
                }else if(gg_=="3.7"){
                    price =  285900;
                }else if(gg_=="3.8"){
                    price =  289000;
                }else if(gg_=="3.9"){
                    price =  292000;
                }else if(gg_=="4.0"){
                    price =  295000;
                }else if(gg_=="4.1"){
                    price =  298100;
                }else if(gg_=="4.2"){
                    price =  301100;
                }else if(gg_=="4.3"){
                    price =  304100;
                }else if(gg_=="4.4"){
                    price =  307100;
                }else if(gg_=="4.5"){
                    price =  310200;
                }else if(gg_=="4.6"){
                    price =  313200;
                }else if(gg_=="4.7"){
                    price =  316200;
                }else if(gg_=="4.8"){
                    price =  319300;
                }else if(gg_=="4.9"){
                    price =  322300;
                }else if(gg_=="5.0"){
                    price =  325300;
                }else if(gg_=="5.1"){
                    price =  328300;
                }else if(gg_=="5.2"){
                    price =  331400;
                }else if(gg_=="5.3"){
                    price =  334400;
                }else if(gg_=="5.4"){
                    price =  337400;
                }else if(gg_=="5.5"){
                    price =  340400;
                }else if(gg_=="5.6"){
                    price =  343700;
                }else if(gg_=="5.7"){
                    price =  346700;
                }else if(gg_=="5.8"){
                    price =  349700;
                }else if(gg_=="5.9"){
                    price =  352800;
                }else if(gg_=="6.0"){
                    price =  355800;
                }
            }
        }else if(qxjd_=="11"){
            if(tbkd_=="1000"){
                if(gg_=="3.0"){
                    price =  280400;
                }else if(gg_=="3.1"){
                    price =  283800;
                }else if(gg_=="3.2"){
                    price =  287100;
                }else if(gg_=="3.3"){
                    price =  290400;
                }else if(gg_=="3.4"){
                    price =  293700;
                }else if(gg_=="3.5"){
                    price =  297000;
                }else if(gg_=="3.6"){
                    price =  300300;
                }else if(gg_=="3.7"){
                    price =  303600;
                }else if(gg_=="3.8"){
                    price =  306900;
                }else if(gg_=="3.9"){
                    price =  310200;
                }else if(gg_=="4.0"){
                    price =  313600;
                }else if(gg_=="4.1"){
                    price =  316900;
                }else if(gg_=="4.2"){
                    price =  320200;
                }else if(gg_=="4.3"){
                    price =  323500;
                }else if(gg_=="4.4"){
                    price =  326800;
                }else if(gg_=="4.5"){
                    price =  330100;
                }else if(gg_=="4.6"){
                    price =  333600;
                }else if(gg_=="4.7"){
                    price =  336900;
                }else if(gg_=="4.8"){
                    price =  340200;
                }else if(gg_=="4.9"){
                    price =  343500;
                }else if(gg_=="5.0"){
                    price =  346900;
                }else if(gg_=="5.1"){
                    price =  350200;
                }else if(gg_=="5.2"){
                    price =  353500;
                }else if(gg_=="5.3"){
                    price =  356800;
                }else if(gg_=="5.4"){
                    price =  360100;
                }else if(gg_=="5.5"){
                    price =  363400;
                }else if(gg_=="5.6"){
                    price =  366700;
                }else if(gg_=="5.7"){
                    price =  372200;
                }else if(gg_=="5.8"){
                    price =  375500;
                }else if(gg_=="5.9"){
                    price =  378800;
                }else if(gg_=="6.0"){
                    price =  382100;
                }
            }else if(tbkd_=="800"){
                if(gg_=="3.0"){
                    price =  273700;
                }else if(gg_=="3.1"){
                    price =  277100;
                }else if(gg_=="3.2"){
                    price =  280400;
                }else if(gg_=="3.3"){
                    price =  283700;
                }else if(gg_=="3.4"){
                    price =  287000;
                }else if(gg_=="3.5"){
                    price =  290300;
                }else if(gg_=="3.6"){
                    price =  293600;
                }else if(gg_=="3.7"){
                    price =  296900;
                }else if(gg_=="3.8"){
                    price =  300200;
                }else if(gg_=="3.9"){
                    price =  303500;
                }else if(gg_=="4.0"){
                    price =  306900;
                }else if(gg_=="4.1"){
                    price =  310200;
                }else if(gg_=="4.2"){
                    price =  313500;
                }else if(gg_=="4.3"){
                    price =  316800;
                }else if(gg_=="4.4"){
                    price =  320100;
                }else if(gg_=="4.5"){
                    price =  323400;
                }else if(gg_=="4.6"){
                    price =  326700;
                }else if(gg_=="4.7"){
                    price =  330000;
                }else if(gg_=="4.8"){
                    price =  333300;
                }else if(gg_=="4.9"){
                    price =  336700;
                }else if(gg_=="5.0"){
                    price =  340000;
                }else if(gg_=="5.1"){
                    price =  343300;
                }else if(gg_=="5.2"){
                    price =  346600;
                }else if(gg_=="5.3"){
                    price =  349900;
                }else if(gg_=="5.4"){
                    price =  353200;
                }else if(gg_=="5.5"){
                    price =  356500;
                }else if(gg_=="5.6"){
                    price =  360000;
                }else if(gg_=="5.7"){
                    price =  363300;
                }else if(gg_=="5.8"){
                    price =  366600;
                }else if(gg_=="5.9"){
                    price =  370000;
                }else if(gg_=="6.0"){
                    price =  373300;
                }
            }
        }else if(qxjd_=="10"){
            if(tbkd_=="1000"){
                if(gg_=="3.0"){
                    price =  291300;
                }else if(gg_=="3.1"){
                    price =  295000;
                }else if(gg_=="3.2"){
                    price =  298600;
                }else if(gg_=="3.3"){
                    price =  302300;
                }else if(gg_=="3.4"){
                    price =  305900;
                }else if(gg_=="3.5"){
                    price =  309600;
                }else if(gg_=="3.6"){
                    price =  313200;
                }else if(gg_=="3.7"){
                    price =  316900;
                }else if(gg_=="3.8"){
                    price =  320500;
                }else if(gg_=="3.9"){
                    price =  324200;
                }else if(gg_=="4.0"){
                    price =  327800;
                }else if(gg_=="4.1"){
                    price =  331500;
                }else if(gg_=="4.2"){
                    price =  335100;
                }else if(gg_=="4.3"){
                    price =  338800;
                }else if(gg_=="4.4"){
                    price =  342400;
                }else if(gg_=="4.5"){
                    price =  346100;
                }else if(gg_=="4.6"){
                    price =  349900;
                }else if(gg_=="4.7"){
                    price =  353600;
                }else if(gg_=="4.8"){
                    price =  357200;
                }else if(gg_=="4.9"){
                    price =  360900;
                }else if(gg_=="5.0"){
                    price =  364500;
                }else if(gg_=="5.1"){
                    price =  368200;
                }else if(gg_=="5.2"){
                    price =  371800;
                }else if(gg_=="5.3"){
                    price =  375500;
                }else if(gg_=="5.4"){
                    price =  379100;
                }else if(gg_=="5.5"){
                    price =  382800;
                }else if(gg_=="5.6"){
                    price =  386400;
                }else if(gg_=="5.7"){
                    price =  392200;
                }else if(gg_=="5.8"){
                    price =  395900;
                }else if(gg_=="5.9"){
                    price =  399500;
                }else if(gg_=="6.0"){
                    price =  403200;
                }
            }else if(tbkd_=="800"){
                if(gg_=="3.0"){
                    price =  284600;
                }else if(gg_=="3.1"){
                    price =  288300;
                }else if(gg_=="3.2"){
                    price =  291900;
                }else if(gg_=="3.3"){
                    price =  295600;
                }else if(gg_=="3.4"){
                    price =  299200;
                }else if(gg_=="3.5"){
                    price =  302900;
                }else if(gg_=="3.6"){
                    price =  306500;
                }else if(gg_=="3.7"){
                    price =  310200;
                }else if(gg_=="3.8"){
                    price =  313800;
                }else if(gg_=="3.9"){
                    price =  317500;
                }else if(gg_=="4.0"){
                    price =  321100;
                }else if(gg_=="4.1"){
                    price =  324800;
                }else if(gg_=="4.2"){
                    price =  328400;
                }else if(gg_=="4.3"){
                    price =  332100;
                }else if(gg_=="4.4"){
                    price =  335700;
                }else if(gg_=="4.5"){
                    price =  339400;
                }else if(gg_=="4.6"){
                    price =  343000;
                }else if(gg_=="4.7"){
                    price =  346700;
                }else if(gg_=="4.8"){
                    price =  350300;
                }else if(gg_=="4.9"){
                    price =  354000;
                }else if(gg_=="5.0"){
                    price =  357600;
                }else if(gg_=="5.1"){
                    price =  361300;
                }else if(gg_=="5.2"){
                    price =  364900;
                }else if(gg_=="5.3"){
                    price =  368600;
                }else if(gg_=="5.4"){
                    price =  372200;
                }else if(gg_=="5.5"){
                    price =  375900;
                }else if(gg_=="5.6"){
                    price =  379700;
                }else if(gg_=="5.7"){
                    price =  383400;
                }else if(gg_=="5.8"){
                    price =  387000;
                }else if(gg_=="5.9"){
                    price =  390700;
                }else if(gg_=="6.0"){
                    price =  394300;
                }
            }
        }
        $("#PRICE_TEMP").val(price);
        $("#PRICE").val(price);
    }


    //修改角度时
    function editQxjd(){
        var appendStr = "<option value=''>请选择</option><option value='3.0'>3.0</option><option value='3.1'>3.1</option><option value='3.2'>3.2</option><option value='3.3'>3.3</option><option value='3.4'>3.4</option><option value='3.5'>3.5</option><option value='3.6'>3.6</option><option value='3.7'>3.7</option><option value='3.8'>3.8</option><option value='3.9'>3.9</option><option value='4.0'>4.0</option><option value='4.1'>4.1</option><option value='4.2'>4.2</option><option value='4.3'>4.3</option><option value='4.4'>4.4</option><option value='4.5'>4.5</option><option value='4.6'>4.6</option><option value='4.7'>4.7</option><option value='4.8'>4.8</option><option value='4.9'>4.9</option><option value='5.0'>5.0</option><option value='5.1'>5.1</option><option value='5.2'>5.2</option><option value='5.3'>5.3</option><option value='5.4'>5.4</option><option value='5.5'>5.5</option><option value='5.6'>5.6</option><option value='5.7'>5.7</option><option value='5.8'>5.8</option><option value='5.9'>5.9</option><option value='6.0'>6.0</option>";
        $("#GG").empty();
        $("#GG").append(appendStr);
    }



        //保存
        function save(){
            $("#regelevStandardForm").submit();
        }
        
        
        function CloseSUWin(id) {
            window.parent.$("#" + id).data("kendoWindow").close();
        }
    
	</script>
</html>
