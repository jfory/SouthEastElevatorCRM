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
												<option value="35">35°</option>
                                                <option value="30">30°</option>
											</select>
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">梯级宽度(mm):</label>
											<select style="width: 18%" class="form-control" id="TJKD" name="TJKD" onchange="setSbj()">
												<option value="">请选择</option>
                                                <option value="600">600</option>
                                                <option value="800">800</option>
                                                <option value="1000">1000</option>
											</select>
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">水平梯级数:</label>
											<select style="width: 18%" class="form-control" id="SPTJ" name="SPTJ" onchange="setSbj()">
                                                <option value="">请选择</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                            </select>
                                    	</div>
                                        
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
											<label style="width:10%" >名称:</label>
                                    		<input style="width:18%"  type="text"  placeholder="名称"  id="NAME" name="NAME" value="${pd.NAME }"  class="form-control">
                                    		&nbsp;&nbsp;&nbsp;
                                    		<label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>速度</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="SD" name="SD">
                                                <option value="0.5">0.5</option>
                                            </select>
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
                        <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddRegelevStandard');">关闭</a></td>
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
        var tjkd_ = $("#TJKD").val();  //梯级宽度
        var price = 0;
        if(qxjd_=="35"){
            if(tjkd_=="1000"){
                if(gg_=="3.0"){
                    price =  165900;
                }else if(gg_=="3.1"){
                    price =  167300;
                }else if(gg_=="3.2"){
                    price =  168700;
                }else if(gg_=="3.3"){
                    price =  170200;
                }else if(gg_=="3.4"){
                    price =  171600;
                }else if(gg_=="3.5"){
                    price =  173000;
                }else if(gg_=="3.6"){
                    price =  174400;
                }else if(gg_=="3.7"){
                    price =  175800;
                }else if(gg_=="3.8"){
                    price =  177200;
                }else if(gg_=="3.9"){
                    price =  178600;
                }else if(gg_=="4.0"){
                    price =  180000;
                }else if(gg_=="4.1"){
                    price =  182400;
                }else if(gg_=="4.2"){
                    price =  183800;
                }else if(gg_=="4.3"){
                    price =  185200;
                }else if(gg_=="4.4"){
                    price =  186600;
                }else if(gg_=="4.5"){
                    price =  188000;
                }else if(gg_=="4.6"){
                    price =  189500;
                }else if(gg_=="4.7"){
                    price =  190900;
                }else if(gg_=="4.8"){
                    price =  192300;
                }else if(gg_=="4.9"){
                    price =  193700;
                }else if(gg_=="5.0"){
                    price =  195300;
                }else if(gg_=="5.1"){
                    price =  197100;
                }else if(gg_=="5.2"){
                    price =  198500;
                }else if(gg_=="5.3"){
                    price =  199900;
                }else if(gg_=="5.4"){
                    price =  201300;
                }else if(gg_=="5.5"){
                    price =  202700;
                }else if(gg_=="5.6"){
                    price =  204100;
                }else if(gg_=="5.7"){
                    price =  205500;
                }else if(gg_=="5.8"){
                    price =  206900;
                }else if(gg_=="5.9"){
                    price =  208300;
                }else if(gg_=="6.0"){
                    price =  209800;
                }
            }else if(tjkd_=="800"){
                if(gg_=="3.0"){
                    price =  164700;
                }else if(gg_=="3.1"){
                    price =  166000;
                }else if(gg_=="3.2"){
                    price =  167400;
                }else if(gg_=="3.3"){
                    price =  168800;
                }else if(gg_=="3.4"){
                    price =  170200;
                }else if(gg_=="3.5"){
                    price =  171600;
                }else if(gg_=="3.6"){
                    price =  173000;
                }else if(gg_=="3.7"){
                    price =  174400;
                }else if(gg_=="3.8"){
                    price =  175800;
                }else if(gg_=="3.9"){
                    price =  177200;
                }else if(gg_=="4.0"){
                    price =  178500;
                }else if(gg_=="4.1"){
                    price =  179900;
                }else if(gg_=="4.2"){
                    price =  181300;
                }else if(gg_=="4.3"){
                    price =  182700;
                }else if(gg_=="4.4"){
                    price =  184100;
                }else if(gg_=="4.5"){
                    price =  185500;
                }else if(gg_=="4.6"){
                    price =  186900;
                }else if(gg_=="4.7"){
                    price =  188300;
                }else if(gg_=="4.8"){
                    price =  189600;
                }else if(gg_=="4.9"){
                    price =  191000;
                }else if(gg_=="5.0"){
                    price =  192600;
                }else if(gg_=="5.1"){
                    price =  195400;
                }else if(gg_=="5.2"){
                    price =  196800;
                }else if(gg_=="5.3"){
                    price =  198200;
                }else if(gg_=="5.4"){
                    price =  199500;
                }else if(gg_=="5.5"){
                    price =  200900;
                }else if(gg_=="5.6"){
                    price =  202300;
                }else if(gg_=="5.7"){
                    price =  203700;
                }else if(gg_=="5.8"){
                    price =  205100;
                }else if(gg_=="5.9"){
                    price =  206500;
                }else if(gg_=="6.0"){
                    price =  207900;
                }
            }else if(tjkd_=="600"){
                if(gg_=="3.0"){
                    price =  163800;
                }else if(gg_=="3.1"){
                    price =  165200;
                }else if(gg_=="3.2"){
                    price =  166600;
                }else if(gg_=="3.3"){
                    price =  167900;
                }else if(gg_=="3.4"){
                    price =  169300;
                }else if(gg_=="3.5"){
                    price =  170700;
                }else if(gg_=="3.6"){
                    price =  172100;
                }else if(gg_=="3.7"){
                    price =  173500;
                }else if(gg_=="3.8"){
                    price =  174800;
                }else if(gg_=="3.9"){
                    price =  176200;
                }else if(gg_=="4.0"){
                    price =  177600;
                }else if(gg_=="4.1"){
                    price =  178900;
                }else if(gg_=="4.2"){
                    price =  180300;
                }else if(gg_=="4.3"){
                    price =  181700;
                }else if(gg_=="4.4"){
                    price =  183100;
                }else if(gg_=="4.5"){
                    price =  184500;
                }else if(gg_=="4.6"){
                    price =  185800;
                }else if(gg_=="4.7"){
                    price =  187200;
                }else if(gg_=="4.8"){
                    price =  188600;
                }else if(gg_=="4.9"){
                    price =  190000;
                }else if(gg_=="5.0"){
                    price =  191500;
                }else if(gg_=="5.1"){
                    price =  193300;
                }else if(gg_=="5.2"){
                    price =  194700;
                }else if(gg_=="5.3"){
                    price =  196100;
                }else if(gg_=="5.4"){
                    price =  197400;
                }else if(gg_=="5.5"){
                    price =  198800;
                }else if(gg_=="5.6"){
                    price =  200200;
                }else if(gg_=="5.7"){
                    price =  201500;
                }else if(gg_=="5.8"){
                    price =  202900;
                }else if(gg_=="5.9"){
                    price =  204300;
                }else if(gg_=="6.0"){
                    price =  205700;
                }
            }
        }else if(qxjd_=="30"){
            if(tjkd_=="1000"){
                if(gg_=="3.0"){
                    price =   171700;
                }else if(gg_=="3.1"){
                    price =   173300;
                }else if(gg_=="3.2"){
                    price =   174900;
                }else if(gg_=="3.3"){
                    price =   176500;
                }else if(gg_=="3.4"){
                    price =   178100;
                }else if(gg_=="3.5"){
                    price =   179700;
                }else if(gg_=="3.6"){
                    price =   182300;
                }else if(gg_=="3.7"){
                    price =   184000;
                }else if(gg_=="3.8"){
                    price =   185600;
                }else if(gg_=="3.9"){
                    price =   187200;
                }else if(gg_=="4.0"){
                    price =   188800;
                }else if(gg_=="4.1"){
                    price =   190400;
                }else if(gg_=="4.2"){
                    price =   192000;
                }else if(gg_=="4.3"){
                    price =   193600;
                }else if(gg_=="4.4"){
                    price =   195200;
                }else if(gg_=="4.5"){
                    price =   196800;
                }else if(gg_=="4.6"){
                    price =   198400;
                }else if(gg_=="4.7"){
                    price =   200100;
                }else if(gg_=="4.8"){
                    price =   201700;
                }else if(gg_=="4.9"){
                    price =   203700;
                }else if(gg_=="5.0"){
                    price =   205300;
                }else if(gg_=="5.1"){
                    price =   206900;
                }else if(gg_=="5.2"){
                    price =   208500;
                }else if(gg_=="5.3"){
                    price =   210100;
                }else if(gg_=="5.4"){
                    price =   211700;
                }else if(gg_=="5.5"){
                    price =   213300;
                }else if(gg_=="5.6"){
                    price =   214900;
                }else if(gg_=="5.7"){
                    price =   216500;
                }else if(gg_=="5.8"){
                    price =   218200;
                }else if(gg_=="5.9"){
                    price =   219800;
                }else if(gg_=="6.0"){
                    price =   221400;
                }else if(gg_=="6.1"){
                    price =   243000;
                }else if(gg_=="6.2"){
                    price =   244600;
                }else if(gg_=="6.3"){
                    price =   246200;
                }else if(gg_=="6.4"){
                    price =   247800;
                }else if(gg_=="6.5"){
                    price =   249400;
                }else if(gg_=="6.6"){
                    price =   254400;
                }else if(gg_=="6.7"){
                    price =   256000;
                }else if(gg_=="6.8"){
                    price =   257600;
                }else if(gg_=="6.9"){
                    price =   259200;
                }else if(gg_=="7.0"){
                    price =   260800;
                }else if(gg_=="7.1"){
                    price =   262400;
                }else if(gg_=="7.2"){
                    price =   264000;
                }else if(gg_=="7.3"){
                    price =   265700;
                }else if(gg_=="7.4"){
                    price =   267300;
                }else if(gg_=="7.5"){
                    price =   268900;
                }
            }else if(tjkd_=="800"){
                if(gg_=="3.0"){
                    price =    170400;
                }else if(gg_=="3.1"){
                    price =    171900;
                }else if(gg_=="3.2"){
                    price =    173500;
                }else if(gg_=="3.3"){
                    price =    175100;
                }else if(gg_=="3.4"){
                    price =    176700;
                }else if(gg_=="3.5"){
                    price =    178300;
                }else if(gg_=="3.6"){
                    price =    179900;
                }else if(gg_=="3.7"){
                    price =    181500;
                }else if(gg_=="3.8"){
                    price =    183000;
                }else if(gg_=="3.9"){
                    price =    184600;
                }else if(gg_=="4.0"){
                    price =    186200;
                }else if(gg_=="4.1"){
                    price =    188800;
                }else if(gg_=="4.2"){
                    price =    190400;
                }else if(gg_=="4.3"){
                    price =    192000;
                }else if(gg_=="4.4"){
                    price =    193500;
                }else if(gg_=="4.5"){
                    price =    195100;
                }else if(gg_=="4.6"){
                    price =    196700;
                }else if(gg_=="4.7"){
                    price =    198300;
                }else if(gg_=="4.8"){
                    price =    199900;
                }else if(gg_=="4.9"){
                    price =    201900;
                }else if(gg_=="5.0"){
                    price =    203500;
                }else if(gg_=="5.1"){
                    price =    205000;
                }else if(gg_=="5.2"){
                    price =    206600;
                }else if(gg_=="5.3"){
                    price =    208200;
                }else if(gg_=="5.4"){
                    price =    209800;
                }else if(gg_=="5.5"){
                    price =    211400;
                }else if(gg_=="5.6"){
                    price =    213000;
                }else if(gg_=="5.7"){
                    price =    214600;
                }else if(gg_=="5.8"){
                    price =    216200;
                }else if(gg_=="5.9"){
                    price =    217700;
                }else if(gg_=="6.0"){
                    price =    219300;
                }else if(gg_=="6.1"){
                    price =    241300;
                }else if(gg_=="6.2"){
                    price =    242900;
                }else if(gg_=="6.3"){
                    price =    244500;
                }else if(gg_=="6.4"){
                    price =    246200;
                }else if(gg_=="6.5"){
                    price =    247800;
                }else if(gg_=="6.6"){
                    price =    249400;
                }else if(gg_=="6.7"){
                    price =    251000;
                }else if(gg_=="6.8"){
                    price =    252600;
                }else if(gg_=="6.9"){
                    price =    254200;
                }else if(gg_=="7.0"){
                    price =    255800;
                }else if(gg_=="7.1"){
                    price =    257400;
                }else if(gg_=="7.2"){
                    price =    259000;
                }else if(gg_=="7.3"){
                    price =    260600;
                }else if(gg_=="7.4"){
                    price =    262300;
                }else if(gg_=="7.5"){
                    price =    263900;
                }
            }else if(tjkd_=="600"){
                if(gg_=="3.0"){
                    price =    169500;
                }else if(gg_=="3.1"){
                    price =    171000;
                }else if(gg_=="3.2"){
                    price =    172600;
                }else if(gg_=="3.3"){
                    price =    174200;
                }else if(gg_=="3.4"){
                    price =    175800;
                }else if(gg_=="3.5"){
                    price =    177300;
                }else if(gg_=="3.6"){
                    price =    178900;
                }else if(gg_=="3.7"){
                    price =    180500;
                }else if(gg_=="3.8"){
                    price =    182100;
                }else if(gg_=="3.9"){
                    price =    183600;
                }else if(gg_=="4.0"){
                    price =    185200;
                }else if(gg_=="4.1"){
                    price =    186800;
                }else if(gg_=="4.2"){
                    price =    188300;
                }else if(gg_=="4.3"){
                    price =    189900;
                }else if(gg_=="4.4"){
                    price =    191500;
                }else if(gg_=="4.5"){
                    price =    193100;
                }else if(gg_=="4.6"){
                    price =    194600;
                }else if(gg_=="4.7"){
                    price =    196200;
                }else if(gg_=="4.8"){
                    price =    197800;
                }else if(gg_=="4.9"){
                    price =    199700;
                }else if(gg_=="5.0"){
                    price =    201300;
                }else if(gg_=="5.1"){
                    price =    202900;
                }else if(gg_=="5.2"){
                    price =    204500;
                }else if(gg_=="5.3"){
                    price =    206000;
                }else if(gg_=="5.4"){
                    price =    207600;
                }else if(gg_=="5.5"){
                    price =    209200;
                }else if(gg_=="5.6"){
                    price =    210800;
                }else if(gg_=="5.7"){
                    price =    212300;
                }else if(gg_=="5.8"){
                    price =    213900;
                }else if(gg_=="5.9"){
                    price =    215500;
                }else if(gg_=="6.0"){
                    price =    217000;
                }else if(gg_=="6.1"){
                    price =    239600;
                }else if(gg_=="6.2"){
                    price =    241200;
                }else if(gg_=="6.3"){
                    price =    242900;
                }else if(gg_=="6.4"){
                    price =    244500;
                }else if(gg_=="6.5"){
                    price =    246100;
                }else if(gg_=="6.6"){
                    price =    247700;
                }else if(gg_=="6.7"){
                    price =    249300;
                }else if(gg_=="6.8"){
                    price =    250900;
                }else if(gg_=="6.9"){
                    price =    252500;
                }else if(gg_=="7.0"){
                    price =    254100;
                }else if(gg_=="7.1"){
                    price =    255700;
                }else if(gg_=="7.2"){
                    price =    257300;
                }else if(gg_=="7.3"){
                    price =    259000;
                }else if(gg_=="7.4"){
                    price =    260600;
                }else if(gg_=="7.5"){
                    price =    262200;
                }
            }
        }
        $("#PRICE_TEMP").val(price);
        $("#PRICE").val(price);
    }


    //修改角度时
    function editQxjd(){
        var qxjd_ = $("#QXJD").val();
        if(qxjd_=="35"){
            var appendStr = "<option value=''>请选择</option><option value='3.0'>3.0</option><option value='3.1'>3.1</option><option value='3.2'>3.2</option><option value='3.3'>3.3</option><option value='3.4'>3.4</option><option value='3.5'>3.5</option><option value='3.6'>3.6</option><option value='3.7'>3.7</option><option value='3.8'>3.8</option><option value='3.9'>3.9</option><option value='4.0'>4.0</option><option value='4.1'>4.1</option><option value='4.2'>4.2</option><option value='4.3'>4.3</option><option value='4.4'>4.4</option><option value='4.5'>4.5</option><option value='4.6'>4.6</option><option value='4.7'>4.7</option><option value='4.8'>4.8</option><option value='4.9'>4.9</option><option value='5.0'>5.0</option><option value='5.1'>5.1</option><option value='5.2'>5.2</option><option value='5.3'>5.3</option><option value='5.4'>5.4</option><option value='5.5'>5.5</option><option value='5.6'>5.6</option><option value='5.7'>5.7</option><option value='5.8'>5.8</option><option value='5.9'>5.9</option><option value='6.0'>6.0</option>";
            $("#GG").empty();
            $("#GG").append(appendStr);
        }else if(qxjd_=="30"){
            var appendStr = "<option value=''>请选择</option><option value='3.0'>3.0</option><option value='3.1'>3.1</option><option value='3.2'>3.2</option><option value='3.3'>3.3</option><option value='3.4'>3.4</option><option value='3.5'>3.5</option><option value='3.6'>3.6</option><option value='3.7'>3.7</option><option value='3.8'>3.8</option><option value='3.9'>3.9</option><option value='4.0'>4.0</option><option value='4.1'>4.1</option><option value='4.2'>4.2</option><option value='4.3'>4.3</option><option value='4.4'>4.4</option><option value='4.5'>4.5</option><option value='4.6'>4.6</option><option value='4.7'>4.7</option><option value='4.8'>4.8</option><option value='4.9'>4.9</option><option value='5.0'>5.0</option><option value='5.1'>5.1</option><option value='5.2'>5.2</option><option value='5.3'>5.3</option><option value='5.4'>5.4</option><option value='5.5'>5.5</option><option value='5.6'>5.6</option><option value='5.7'>5.7</option><option value='5.8'>5.8</option><option value='5.9'>5.9</option><option value='6.0'>6.0</option><option value='6.1'>6.1</option><option value='6.2'>6.2</option><option value='6.3'>6.3</option><option value='6.4'>6.4</option><option value='6.5'>6.5</option><option value='6.6'>6.6</option><option value='6.7'>6.7</option><option value='6.8'>6.8</option><option value='6.9'>6.9</option><option value='7.0'>7.0</option><option value='7.1'>7.1</option><option value='7.2'>7.2</option><option value='7.3'>7.3</option><option value='7.4'>7.4</option><option value='7.5'>7.5</option>";
            $("#GG").empty();
            $("#GG").append(appendStr);
        }
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
