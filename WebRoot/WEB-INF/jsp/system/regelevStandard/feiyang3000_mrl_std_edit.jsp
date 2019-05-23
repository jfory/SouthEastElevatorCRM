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
											<label style="width: 10%">电梯速度(m/s):</label>
											<select style="width: 18%" class="form-control" id="SD" name="SD" onchange="editSd();">
												<option value="">请选择</option>
												<option value="1.0">1.0</option>
												<option value="1.5">1.5</option>
                                                <option value="1.75">1.75</option>
											</select>
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">电梯载重(KG):</label>
											<select style="width: 18%" class="form-control" id="ZZ" name="ZZ" onchange="setSbj()">
												<option value="">请选择</option>
												<option value="450">450</option>
                                                <option value="630">630</option>
                                                <option value="800">800</option>
                                                <option value="1000">1000</option>
												<option value="1150">1150</option>
												<option value="1350">1350</option>
                                                <option value="1600">1600</option>
											</select>
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">层站门:</label>
											<!-- <input style="width:6%"  type="text"  placeholder="层"  id="C" name="C" value="${pd.C }"  class="form-control" onchange="setSbj();">
											<input style="width:6%"  type="text"  placeholder="站"  id="Z" name="Z" value="${pd.Z }"  class="form-control">
											<input style="width:6%"  type="text"  placeholder="门"  id="M" name="M" value="${pd.M }"  class="form-control" onkeyup="setMPrice()"> -->
                                            <select class="form-control m-b" style="width:7%" name="C" id="C" onchange="setSbj();">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control m-b" style="width:7%" name="Z" id="Z" onchange="setSbj();">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control m-b" style="width:7%" name="M" id="M" onchange="setMPrice();">
                                                <option value="">请选择</option>
                                            </select>
                                    	</div>
                                        
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
											<label style="width:10%" >名称:</label>
                                    		<input style="width:18%"  type="text"  placeholder="名称"  id="NAME" name="NAME" value="${pd.NAME }"  class="form-control">
                                    		&nbsp;&nbsp;&nbsp;
                                    		<label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门形式</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="KMXS" name="KMXS">
                                                <option value="中分">中分</option>
                                            </select>
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门宽度:</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="KMKD" name="KMKD" onchange="setMPrice();">
                                                <option value="900">800</option>
                                                <option value="1500">900</option>
                                                <option value="2000">1100</option>
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
        var sd_ = $("#SD").val();  //速度
        var c_ = $("#C").val();     //层站
        var zz_ = $("#ZZ").val();  //载重
        var price = 0;
        if(sd_=="1.0"){
            if(zz_=="450"){
                if(c_=="3"){
                    price = 134900;
                }else if(c_=="4"){
                    price = 139900;
                }else if(c_=="5"){
                    price = 144900;
                }else if(c_=="6"){
                    price = 149900;
                }else if(c_=="7"){
                    price = 155900;
                }else if(c_=="8"){
                    price = 160900;
                }else if(c_=="9"){
                    price = 165900;
                }else if(c_=="10"){
                    price = 170900;
                }else if(c_=="11"){
                    price = 175900;
                }else if(c_=="12"){
                    price = 180900;
                }else if(c_=="13"){
                    price = 185900;
                }else if(c_=="14"){
                    price = 190900;
                }else if(c_=="15"){
                    price = 195900;
                }else if(c_=="16"){
                    price = 200900;
                }else if(c_=="17"){
                    price = 205900;
                }else if(c_=="18"){
                    price = 210900;
                }else if(c_=="19"){
                    price = 215900;
                }else if(c_=="20"){
                    price = 221900;
                }
            }else if(zz_=="630"){
                if(c_=="3"){
                    price = 137400;
                }else if(c_=="4"){
                    price = 142400;
                }else if(c_=="5"){
                    price = 147400;
                }else if(c_=="6"){
                    price = 152400;
                }else if(c_=="7"){
                    price = 158400;
                }else if(c_=="8"){
                    price = 163400;
                }else if(c_=="9"){
                    price = 168400;
                }else if(c_=="10"){
                    price = 173400;
                }else if(c_=="11"){
                    price = 178400;
                }else if(c_=="12"){
                    price = 183400;
                }else if(c_=="13"){
                    price = 188400;
                }else if(c_=="14"){
                    price = 193400;
                }else if(c_=="15"){
                    price = 198400;
                }else if(c_=="16"){
                    price = 203400;
                }else if(c_=="17"){
                    price = 208400;
                }else if(c_=="18"){
                    price = 213400;
                }else if(c_=="19"){
                    price = 218400;
                }else if(c_=="20"){
                    price = 224400;
                }
            }else if(zz_=="800"){
                if(c_=="3"){
                    price = 139910;
                }else if(c_=="4"){
                    price = 144910;
                }else if(c_=="5"){
                    price = 149910;
                }else if(c_=="6"){
                    price = 154910;
                }else if(c_=="7"){
                    price = 159910;
                }else if(c_=="8"){
                    price = 164910;
                }else if(c_=="9"){
                    price = 169910;
                }else if(c_=="10"){
                    price = 174910;
                }else if(c_=="11"){
                    price = 180910;
                }else if(c_=="12"){
                    price = 185910;
                }else if(c_=="13"){
                    price = 190910;
                }else if(c_=="14"){
                    price = 195910;
                }else if(c_=="15"){
                    price = 200910;
                }else if(c_=="16"){
                    price = 205910;
                }else if(c_=="17"){
                    price = 210910;
                }else if(c_=="18"){
                    price = 215910;
                }else if(c_=="19"){
                    price = 220910;
                }else if(c_=="20"){
                    price = 225910;
                }
            }else if(zz_=="1000"){
                if(c_=="3"){
                    price = 147670;
                }else if(c_=="4"){
                    price = 152670;
                }else if(c_=="5"){
                    price = 157670;
                }else if(c_=="6"){
                    price = 162670;
                }else if(c_=="7"){
                    price = 167670;
                }else if(c_=="8"){
                    price = 172670;
                }else if(c_=="9"){
                    price = 177670;
                }else if(c_=="10"){
                    price = 182670;
                }else if(c_=="11"){
                    price = 187670;
                }else if(c_=="12"){
                    price = 192670;
                }else if(c_=="13"){
                    price = 197670;
                }else if(c_=="14"){
                    price = 203670;
                }else if(c_=="15"){
                    price = 208670;
                }else if(c_=="16"){
                    price = 213670;
                }else if(c_=="17"){
                    price = 218670;
                }else if(c_=="18"){
                    price = 223670;
                }else if(c_=="19"){
                    price = 228670;
                }else if(c_=="20"){
                    price = 233670;
                }
            }else if(zz_=="1350"){
                if(c_=="3"){
                    price = 192850;
                }else if(c_=="4"){
                    price = 197790;
                }else if(c_=="5"){
                    price = 202740;
                }else if(c_=="6"){
                    price = 207690;
                }else if(c_=="7"){
                    price = 212630;
                }else if(c_=="8"){
                    price = 217580;
                }else if(c_=="9"){
                    price = 222520;
                }else if(c_=="10"){
                    price = 227470;
                }else if(c_=="11"){
                    price = 232410;
                }else if(c_=="12"){
                    price = 237360;
                }else if(c_=="13"){
                    price = 242310;
                }else if(c_=="14"){
                    price = 247250;
                }else if(c_=="15"){
                    price = 252200;
                }else if(c_=="16"){
                    price = 257140;
                }else if(c_=="17"){
                    price = 262090;
                }else if(c_=="18"){
                    price = 267040;
                }else if(c_=="19"){
                    price = 271980;
                }else if(c_=="20"){
                    price = 276930;
                }
            }else if(zz_=="1600"){
                if(c_=="3"){
                    price = 195780;
                }else if(c_=="4"){
                    price = 200830;
                }else if(c_=="5"){
                    price = 205880;
                }else if(c_=="6"){
                    price = 210920;
                }else if(c_=="7"){
                    price = 215970;
                }else if(c_=="8"){
                    price = 221020;
                }else if(c_=="9"){
                    price = 226070;
                }else if(c_=="10"){
                    price = 231120;
                }else if(c_=="11"){
                    price = 236170;
                }else if(c_=="12"){
                    price = 241220;
                }else if(c_=="13"){
                    price = 246260;
                }else if(c_=="14"){
                    price = 251310;
                }else if(c_=="15"){
                    price = 256360;
                }else if(c_=="16"){
                    price = 261410;
                }else if(c_=="17"){
                    price = 266460;
                }else if(c_=="18"){
                    price = 271510;
                }else if(c_=="19"){
                    price = 276550;
                }else if(c_=="20"){
                    price = 281600;
                }
            }
        }else if(sd_=="1.5"){   //速度=1.5m/s
            if(zz_=="450"){
                if(c_=="3"){
                    price = 139900;
                }else if(c_=="4"){
                    price = 144900;
                }else if(c_=="5"){
                    price = 149900;
                }else if(c_=="6"){
                    price = 154900;
                }else if(c_=="7"){
                    price = 160900;
                }else if(c_=="8"){
                    price = 165900;
                }else if(c_=="9"){
                    price = 170900;
                }else if(c_=="10"){
                    price = 175900;
                }else if(c_=="11"){
                    price = 180900;
                }else if(c_=="12"){
                    price = 185900;
                }else if(c_=="13"){
                    price = 190900;
                }else if(c_=="14"){
                    price = 195900;
                }else if(c_=="15"){
                    price = 200900;
                }else if(c_=="16"){
                    price = 205900;
                }else if(c_=="17"){
                    price = 210900;
                }else if(c_=="18"){
                    price = 215900;
                }else if(c_=="19"){
                    price = 220900;
                }else if(c_=="20"){
                    price = 226900;
                }else if(c_=="21"){
                    price = 231900;
                }else if(c_=="22"){
                    price = 236900;
                }else if(c_=="23"){
                    price = 241900;
                }else if(c_=="24"){
                    price = 246900;
                }
            }else if(zz_=="630"){
                if(c_=="3"){
                    price = 142400;
                }else if(c_=="4"){
                    price = 147400;
                }else if(c_=="5"){
                    price = 152400;
                }else if(c_=="6"){
                    price = 157400;
                }else if(c_=="7"){
                    price = 163400;
                }else if(c_=="8"){
                    price = 168400;
                }else if(c_=="9"){
                    price = 173400;
                }else if(c_=="10"){
                    price = 178400;
                }else if(c_=="11"){
                    price = 183400;
                }else if(c_=="12"){
                    price = 188400;
                }else if(c_=="13"){
                    price = 193400;
                }else if(c_=="14"){
                    price = 198400;
                }else if(c_=="15"){
                    price = 203400;
                }else if(c_=="16"){
                    price = 208400;
                }else if(c_=="17"){
                    price = 213400;
                }else if(c_=="18"){
                    price = 218400;
                }else if(c_=="19"){
                    price = 223400;
                }else if(c_=="20"){
                    price = 229400;
                }else if(c_=="21"){
                    price = 234400;
                }else if(c_=="22"){
                    price = 239400;
                }else if(c_=="23"){
                    price = 244400;
                }else if(c_=="24"){
                    price = 249400;
                }
            }else if(zz_=="800"){
                if(c_=="3"){
                    price = 144910;
                }else if(c_=="4"){
                    price = 149910;
                }else if(c_=="5"){
                    price = 154910;
                }else if(c_=="6"){
                    price = 159910;
                }else if(c_=="7"){
                    price = 164910;
                }else if(c_=="8"){
                    price = 169910;
                }else if(c_=="9"){
                    price = 174910;
                }else if(c_=="10"){
                    price = 179910;
                }else if(c_=="11"){
                    price = 185910;
                }else if(c_=="12"){
                    price = 190910;
                }else if(c_=="13"){
                    price = 195910;
                }else if(c_=="14"){
                    price = 200910;
                }else if(c_=="15"){
                    price = 205910;
                }else if(c_=="16"){
                    price = 210910;
                }else if(c_=="17"){
                    price = 215910;
                }else if(c_=="18"){
                    price = 220910;
                }else if(c_=="19"){
                    price = 225910;
                }else if(c_=="20"){
                    price = 230910;
                }else if(c_=="21"){
                    price = 235910;
                }else if(c_=="22"){
                    price = 240910;
                }else if(c_=="23"){
                    price = 245910;
                }else if(c_=="24"){
                    price = 250910;
                }
            }else if(zz_=="1000"){
                if(c_=="3"){
                    price = 152670;
                }else if(c_=="4"){
                    price = 157670;
                }else if(c_=="5"){
                    price = 162670;
                }else if(c_=="6"){
                    price = 167670;
                }else if(c_=="7"){
                    price = 172670;
                }else if(c_=="8"){
                    price = 177670;
                }else if(c_=="9"){
                    price = 182670;
                }else if(c_=="10"){
                    price = 187670;
                }else if(c_=="11"){
                    price = 192670;
                }else if(c_=="12"){
                    price = 197670;
                }else if(c_=="13"){
                    price = 202670;
                }else if(c_=="14"){
                    price = 208670;
                }else if(c_=="15"){
                    price = 213670;
                }else if(c_=="16"){
                    price = 218670;
                }else if(c_=="17"){
                    price = 223670;
                }else if(c_=="18"){
                    price = 228670;
                }else if(c_=="19"){
                    price = 233670;
                }else if(c_=="20"){
                    price = 238670;
                }else if(c_=="21"){
                    price = 243670;
                }else if(c_=="22"){
                    price = 248670;
                }else if(c_=="23"){
                    price = 253670;
                }else if(c_=="24"){
                    price = 258670;
                }
            }else if(zz_=="1350"){
                if(c_=="3"){
                    price = 196350;
                }else if(c_=="4"){
                    price = 201280;
                }else if(c_=="5"){
                    price = 206170;
                }else if(c_=="6"){
                    price = 211060;
                }else if(c_=="7"){
                    price = 215950;
                }else if(c_=="8"){
                    price = 220840;
                }else if(c_=="9"){
                    price = 225730;
                }else if(c_=="10"){
                    price = 230630;
                }else if(c_=="11"){
                    price = 235520;
                }else if(c_=="12"){
                    price = 240410;
                }else if(c_=="13"){
                    price = 245300;
                }else if(c_=="14"){
                    price = 250190;
                }else if(c_=="15"){
                    price = 255090;
                }else if(c_=="16"){
                    price = 259980;
                }else if(c_=="17"){
                    price = 264780;
                }else if(c_=="18"){
                    price = 269760;
                }else if(c_=="19"){
                    price = 274650;
                }else if(c_=="20"){
                    price = 279540;
                }else if(c_=="21"){
                    price = 284440;
                }else if(c_=="22"){
                    price = 289330;
                }else if(c_=="23"){
                    price = 294220;
                }else if(c_=="24"){
                    price = 299110;
                }
            }else if(zz_=="1600"){
                if(c_=="3"){
                    price = 203730;
                }else if(c_=="4"){
                    price = 208670;
                }else if(c_=="5"){
                    price = 213610;
                }else if(c_=="6"){
                    price = 218550;
                }else if(c_=="7"){
                    price = 223480;
                }else if(c_=="8"){
                    price = 228420;
                }else if(c_=="9"){
                    price = 233360;
                }else if(c_=="10"){
                    price = 238300;
                }else if(c_=="11"){
                    price = 243240;
                }else if(c_=="12"){
                    price = 248180;
                }else if(c_=="13"){
                    price = 253120;
                }else if(c_=="14"){
                    price = 258050;
                }else if(c_=="15"){
                    price = 262990;
                }else if(c_=="16"){
                    price = 267930;
                }else if(c_=="17"){
                    price = 272870;
                }else if(c_=="18"){
                    price = 277810;
                }else if(c_=="19"){
                    price = 282750;
                }else if(c_=="20"){
                    price = 287690;
                }else if(c_=="21"){
                    price = 292620;
                }else if(c_=="22"){
                    price = 297560;
                }else if(c_=="23"){
                    price = 302500;
                }else if(c_=="24"){
                    price = 307440;
                }
            }
        }else if(sd_=="1.75"){  //速度=1.75m/s
            if(zz_=="450"){
                if(c_=="4"){
                    price = 148900;
                }else if(c_=="5"){
                    price = 153900;
                }else if(c_=="6"){
                    price = 158900;
                }else if(c_=="7"){
                    price = 164900;
                }else if(c_=="8"){
                    price = 169900;
                }else if(c_=="9"){
                    price = 174900;
                }else if(c_=="10"){
                    price = 179900;
                }else if(c_=="11"){
                    price = 184900;
                }else if(c_=="12"){
                    price = 189900;
                }else if(c_=="13"){
                    price = 194900;
                }else if(c_=="14"){
                    price = 199900;
                }else if(c_=="15"){
                    price = 204900;
                }else if(c_=="16"){
                    price = 209900;
                }else if(c_=="17"){
                    price = 214900;
                }else if(c_=="18"){
                    price = 219900;
                }else if(c_=="19"){
                    price = 224900;
                }else if(c_=="20"){
                    price = 230900;
                }else if(c_=="21"){
                    price = 235900;
                }else if(c_=="22"){
                    price = 240900;
                }else if(c_=="23"){
                    price = 245900;
                }else if(c_=="24"){
                    price = 250900;
                }else if(c_=="25"){
                    price = 255900;
                }else if(c_=="26"){
                    price = 260900;
                }else if(c_=="27"){
                    price = 265900;
                }else if(c_=="28"){
                    price = 270900;
                }else if(c_=="29"){
                    price = 275900;
                }else if(c_=="30"){
                    price = 280900;
                }
            }else if(zz_=="630"){
                if(c_=="4"){
                    price = 151400;
                }else if(c_=="5"){
                    price = 156400;
                }else if(c_=="6"){
                    price = 161400;
                }else if(c_=="7"){
                    price = 167400;
                }else if(c_=="8"){
                    price = 172400;
                }else if(c_=="9"){
                    price = 177400;
                }else if(c_=="10"){
                    price = 182400;
                }else if(c_=="11"){
                    price = 187400;
                }else if(c_=="12"){
                    price = 192400;
                }else if(c_=="13"){
                    price = 197400;
                }else if(c_=="14"){
                    price = 202400;
                }else if(c_=="15"){
                    price = 207400;
                }else if(c_=="16"){
                    price = 212400;
                }else if(c_=="17"){
                    price = 217400;
                }else if(c_=="18"){
                    price = 222400;
                }else if(c_=="19"){
                    price = 227400;
                }else if(c_=="20"){
                    price = 233400;
                }else if(c_=="21"){
                    price = 238400;
                }else if(c_=="22"){
                    price = 243400;
                }else if(c_=="23"){
                    price = 248400;
                }else if(c_=="24"){
                    price = 253400;
                }else if(c_=="25"){
                    price = 258400;
                }else if(c_=="26"){
                    price = 263400;
                }else if(c_=="27"){
                    price = 268400;
                }else if(c_=="28"){
                    price = 273400;
                }else if(c_=="29"){
                    price = 278400;
                }else if(c_=="30"){
                    price = 283400;
                }
            }else if(zz_=="800"){
                if(c_=="4"){
                    price = 153910;
                }else if(c_=="5"){
                    price = 158910;
                }else if(c_=="6"){
                    price = 163910;
                }else if(c_=="7"){
                    price = 168910;
                }else if(c_=="8"){
                    price = 173910;
                }else if(c_=="9"){
                    price = 178910;
                }else if(c_=="10"){
                    price = 183910;
                }else if(c_=="11"){
                    price = 189910;
                }else if(c_=="12"){
                    price = 194910;
                }else if(c_=="13"){
                    price = 199910;
                }else if(c_=="14"){
                    price = 204910;
                }else if(c_=="15"){
                    price = 209910;
                }else if(c_=="16"){
                    price = 214910;
                }else if(c_=="17"){
                    price = 219910;
                }else if(c_=="18"){
                    price = 224910;
                }else if(c_=="19"){
                    price = 229910;
                }else if(c_=="20"){
                    price = 234910;
                }else if(c_=="21"){
                    price = 239910;
                }else if(c_=="22"){
                    price = 244910;
                }else if(c_=="23"){
                    price = 249910;
                }else if(c_=="24"){
                    price = 254910;
                }else if(c_=="25"){
                    price = 259910;
                }else if(c_=="26"){
                    price = 264910;
                }else if(c_=="27"){
                    price = 269910;
                }else if(c_=="28"){
                    price = 274910;
                }else if(c_=="29"){
                    price = 279910;
                }else if(c_=="30"){
                    price = 284910;
                }
            }else if(zz_=="1000"){
                if(c_=="4"){
                    price = 161670;
                }else if(c_=="5"){
                    price = 166670;
                }else if(c_=="6"){
                    price = 171670;
                }else if(c_=="7"){
                    price = 176670;
                }else if(c_=="8"){
                    price = 181670;
                }else if(c_=="9"){
                    price = 186670;
                }else if(c_=="10"){
                    price = 191670;
                }else if(c_=="11"){
                    price = 196670;
                }else if(c_=="12"){
                    price = 201670;
                }else if(c_=="13"){
                    price = 206670;
                }else if(c_=="14"){
                    price = 212670;
                }else if(c_=="15"){
                    price = 217670;
                }else if(c_=="16"){
                    price = 222670;
                }else if(c_=="17"){
                    price = 227670;
                }else if(c_=="18"){
                    price = 232670;
                }else if(c_=="19"){
                    price = 237670;
                }else if(c_=="20"){
                    price = 242670;
                }else if(c_=="21"){
                    price = 247670;
                }else if(c_=="22"){
                    price = 252670;
                }else if(c_=="23"){
                    price = 257670;
                }else if(c_=="24"){
                    price = 262670;
                }else if(c_=="25"){
                    price = 267670;
                }else if(c_=="26"){
                    price = 272670;
                }else if(c_=="27"){
                    price = 277670;
                }else if(c_=="28"){
                    price = 282670;
                }else if(c_=="29"){
                    price = 287670;
                }else if(c_=="30"){
                    price = 292670;
                }
            }else if(zz_=="1350"){
                if(c_=="4"){
                    price = 207310;
                }else if(c_=="5"){
                    price = 212170;
                }else if(c_=="6"){
                    price = 217030;
                }else if(c_=="7"){
                    price = 221900;
                }else if(c_=="8"){
                    price = 226760;
                }else if(c_=="9"){
                    price = 231620;
                }else if(c_=="10"){
                    price = 236480;
                }else if(c_=="11"){
                    price = 241350;
                }else if(c_=="12"){
                    price = 246210;
                }else if(c_=="13"){
                    price = 251070;
                }else if(c_=="14"){
                    price = 255930;
                }else if(c_=="15"){
                    price = 260790;
                }else if(c_=="16"){
                    price = 265660;
                }else if(c_=="17"){
                    price = 270520;
                }else if(c_=="18"){
                    price = 275380;
                }else if(c_=="19"){
                    price = 280240;
                }else if(c_=="20"){
                    price = 285100;
                }else if(c_=="21"){
                    price = 289970;
                }else if(c_=="22"){
                    price = 294830;
                }else if(c_=="23"){
                    price = 299690;
                }else if(c_=="24"){
                    price = 304550;
                }else if(c_=="25"){
                    price = 309420;
                }else if(c_=="26"){
                    price = 314280;
                }else if(c_=="27"){
                    price = 319140;
                }else if(c_=="28"){
                    price = 324000;
                }else if(c_=="29"){
                    price = 328860;
                }else if(c_=="30"){
                    price = 333730;
                }
            }else if(zz_=="1600"){
                if(c_=="4"){
                    price = 212570;
                }else if(c_=="5"){
                    price = 217530;
                }else if(c_=="6"){
                    price = 222500;
                }else if(c_=="7"){
                    price = 227470;
                }else if(c_=="8"){
                    price = 232440;
                }else if(c_=="9"){
                    price = 237410;
                }else if(c_=="10"){
                    price = 242380;
                }else if(c_=="11"){
                    price = 247350;
                }else if(c_=="12"){
                    price = 252320;
                }else if(c_=="13"){
                    price = 257390;
                }else if(c_=="14"){
                    price = 262260;
                }else if(c_=="15"){
                    price = 267230;
                }else if(c_=="16"){
                    price = 272190;
                }else if(c_=="17"){
                    price = 277160;
                }else if(c_=="18"){
                    price = 282130;
                }else if(c_=="19"){
                    price = 287100;
                }else if(c_=="20"){
                    price = 292070;
                }else if(c_=="21"){
                    price = 297040;
                }else if(c_=="22"){
                    price = 302010;
                }else if(c_=="23"){
                    price = 306980;
                }else if(c_=="24"){
                    price = 311950;
                }else if(c_=="25"){
                    price = 316920;
                }else if(c_=="26"){
                    price = 321890;
                }else if(c_=="27"){
                    price = 326850;
                }else if(c_=="28"){
                    price = 331820;
                }else if(c_=="29"){
                    price = 336790;
                }else if(c_=="30"){
                    price = 341760;
                }
            }
        }
        $("#PRICE_TEMP").val(price);
        $("#PRICE").val(price);
    }


    //修改门数量时修改标准价格
    function setMPrice(){
        var m_ = parseInt($("#M").val());
        var c_ = parseInt($("#C").val());
        var price = parseInt($("#PRICE_TEMP").val());
        var kmkd_ = parseInt($("#KMKD").val());
        if(!isNaN(m_)&&!isNaN(c_)&&!isNaN(price)){
            var jm = c_-m_;
            if(jm>0){
                if(kmkd_=="800"){
                    price = price-2100*jm;
                }else if(kmkd_=="900"){
                    price = price-2400*jm;
                }else if(kmkd_=="1100"){
                    price = price-2800*jm;
                }
            }
            $("#PRICE").val(price);
        }
    }

    //修改速度时
    function editSd(){
        var sd_ = $("#SD").val();
        if(sd_=="1.0"){
            var appendStr = "<option value=''>请选择</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option>";
            $("#C").empty();
            $("#Z").empty();
            $("#M").empty();
            $("#C").append(appendStr);
            $("#Z").append(appendStr);
            $("#M").append(appendStr);
        }else if(sd_=="1.5"){
            var appendStr = "<option value=''>请选择</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option>";
            $("#C").empty();
            $("#Z").empty();
            $("#M").empty();
            $("#C").append(appendStr);
            $("#Z").append(appendStr);
            $("#M").append(appendStr);
        }else if(sd_=="1.75"){
            var appendStr = "<option value=''>请选择</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option>";
            $("#C").empty();
            $("#Z").empty();
            $("#M").empty();
            $("#C").append(appendStr);
            $("#Z").append(appendStr);
            $("#M").append(appendStr);
        }
    }


    //保存
    function save(){
        if($("#SD").val()==""){
            $("#SD").focus();
            $("#SD").tips({
                side:3,
                msg:'请选择电梯速度',
                bg:'#AE81FF',
                time:2
            });
            return false;
        }
        if($("#ZZ").val()==""){
            $("#ZZ").focus();
            $("#ZZ").tips({
                side:3,
                msg:'请选择电梯重量',
                bg:'#AE81FF',
                time:2
            });
            return false;
        }
        
        if($("#C").val()==""){
            $("#C").focus();
            $("#C").tips({
                side:3,
                msg:'请填写电梯层',
                bg:'#AE81FF',
                time:2
            });
            return false;
        }
        if($("#Z").val()==""){
            $("#Z").focus();
            $("#Z").tips({
                side:3,
                msg:'请填写电梯站',
                bg:'#AE81FF',
                time:2
            });
            return false;
        }
        if($("#M").val()==""){
            $("#M").focus();
            $("#M").tips({
                side:3,
                msg:'请填写电梯门',
                bg:'#AE81FF',
                time:2
            });
            return false;
        }
        
        if($("#NAME").val()==""){
            $("#NAME").focus();
            $("#NAME").tips({
                side:3,
                msg:'请填写名称',
                bg:'#AE81FF',
                time:2
            });
            return false;
        }
        $("#regelevStandardForm").submit();
    }
    
    
    function CloseSUWin(id) {
        window.parent.$("#" + id).data("kendoWindow").close();
    }
    
	</script>
</html>
