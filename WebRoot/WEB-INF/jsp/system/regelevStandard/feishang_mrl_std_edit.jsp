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
												<option value="0.5">0.5</option>
												<option value="1.0">1.0</option>
											</select>
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">电梯载重(KG):</label>
											<select style="width: 18%" class="form-control" id="ZZ" name="ZZ" onchange="setSbj()">
												<option value="">请选择</option>
												<option value="1000">1000</option>
												<option value="2000">2000</option>
												<option value="3000">3000</option>
											</select>
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">层站门:</label>
                                            <select class="form-control m-b" style="width:7%" name="C" id="C" onchange="setSbj();">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control m-b" style="width:7%" name="Z" id="Z" onchange="setSbj();">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control m-b" style="width:7%" name="M" id="M" onchange="setMPrice();">
                                                <option value="">请选择</option>
                                            </select>
											<!-- <input style="width:6%"  type="text"  placeholder="层"  id="C" name="C" value="${pd.C }"  class="form-control" onchange="setSbj();">
											<input style="width:6%"  type="text"  placeholder="站"  id="Z" name="Z" value="${pd.Z }"  class="form-control">
											<input style="width:6%"  type="text"  placeholder="门"  id="M" name="M" value="${pd.M }"  class="form-control" onkeyup="setMPrice();"> -->
                                    	</div>
                                        
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
											<label style="width:10%" >名称:</label>
                                    		<input style="width:18%"  type="text"  placeholder="名称"  id="NAME" name="NAME" value="${pd.NAME }"  class="form-control">
                                    		&nbsp;&nbsp;&nbsp;
                                    		<label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门形式</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="KMXS" name="KMXS">
                                                <option value="中分">中分</option>
                                                <option value="左旁开">左旁开</option>
                                                <option value="右旁开">右旁开</option>
                                                <option value="中分双折">中分双折</option>
                                            </select>
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门宽度:</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="KMKD" name="KMKD" onchange="setMPrice();">
                                                <option value="900">900</option>
                                                <option value="1500">1500</option>
                                                <option value="2000">2000</option>
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
        var sd_ = $("#SD").val();  //速度
        var c_ = $("#C").val();     //层站
        var zz_ = $("#ZZ").val();  //载重
        var price = 0;
        if(sd_=="0.5"){
            if(zz_=="1000"){
                if(c_=="2"){
                    price = 95550;
                }else if(c_=="3"){
                    price = 99340;
                }else if(c_=="4"){
                    price = 103130;
                }else if(c_=="5"){
                    price = 106920
                }else if(c_=="6"){
                    price = 110710;
                }else if(c_=="7"){
                    price = 114500;
                }else if(c_=="8"){
                    price = 118300;
                }
            }else if(zz_=="2000"){
                if(c_=="2"){
                    price = 129140;
                }else if(c_=="3"){
                    price = 138330;
                }else if(c_=="4"){
                    price = 147530;
                }else if(c_=="5"){
                    price = 156730;
                }else if(c_=="6"){
                    price = 165920;
                }else if(c_=="7"){
                    price = 175120;
                }else if(c_=="8"){
                    price = 184310;
                }
            }else if(zz_=="3000"){
                if(c_=="2"){
                    price = 176370;
                }else if(c_=="3"){
                    price = 187530;
                }else if(c_=="4"){
                    price = 198700;
                }else if(c_=="5"){
                    price = 209870;
                }else if(c_=="6"){
                    price = 221040;
                }else if(c_=="7"){
                    price = 232210;
                }else if(c_=="8"){
                    price = 243380;
                }
            }
        }else if(sd_=="1.0"){
            if(zz_=="1000"){
                if(c_=="2"){
                    price = 96070;
                }else if(c_=="3"){
                    price = 99860;
                }else if(c_=="4"){
                    price = 103650;
                }else if(c_=="5"){
                    price = 107440
                }else if(c_=="6"){
                    price = 111240;
                }else if(c_=="7"){
                    price = 115030;
                }else if(c_=="8"){
                    price = 118820;
                }else if(c_=="9"){
                    price = 122610;
                }else if(c_=="10"){
                    price = 126400;
                }else if(c_=="11"){
                    price = 131090;
                }else if(c_=="12"){
                    price = 135080;
                }else if(c_=="13"){
                    price = 139080;
                }else if(c_=="14"){
                    price = 143080;
                }else if(c_=="15"){
                    price = 147070;
                }
            }else if(zz_=="2000"){
                if(c_=="2"){
                    price = 140720;
                }else if(c_=="3"){
                    price = 149860;
                }else if(c_=="4"){
                    price = 159010;
                }else if(c_=="5"){
                    price = 168150;
                }else if(c_=="6"){
                    price = 177300;
                }else if(c_=="7"){
                    price = 186440;
                }else if(c_=="8"){
                    price = 195590;
                }else if(c_=="9"){
                    price = 204730;
                }else if(c_=="10"){
                    price = 213880;
                }else if(c_=="11"){
                    price = 223020;
                }else if(c_=="12"){
                    price = 232160;
                }else if(c_=="13"){
                    price = 241310;
                }else if(c_=="14"){
                    price = 250450;
                }else if(c_=="15"){
                    price = 259600;
                }
            }else if(zz_=="3000"){
                if(c_=="2"){
                    price = 193160;
                }else if(c_=="3"){
                    price = 204300;
                }else if(c_=="4"){
                    price = 215430;
                }else if(c_=="5"){
                    price = 226570;
                }else if(c_=="6"){
                    price = 237710;
                }else if(c_=="7"){
                    price = 248850;
                }else if(c_=="8"){
                    price = 259980;
                }else if(c_=="9"){
                    price = 271120;
                }else if(c_=="10"){
                    price = 282260;
                }else if(c_=="11"){
                    price = 293400;
                }else if(c_=="12"){
                    price = 304540;
                }else if(c_=="13"){
                    price = 315670;
                }else if(c_=="14"){
                    price = 326810;
                }else if(c_=="15"){
                    price = 337950;
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
                if(kmkd_=="900"){
                    price = price-2400*jm;
                }else if(kmkd_=="1500"){
                    price = price-4300*jm;
                }else if(kmkd_=="2000"){
                    price = price-5800*jm;
                }
            }
            $("#PRICE").val(price);
        }
    }


    //修改速度时
    function editSd(){
        var sd_ = $("#SD").val();
        if(sd_=="0.5"){
            var appendStr = "<option value=''>请选择</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option>";
            $("#C").empty();
            $("#Z").empty();
            $("#M").empty();
            $("#C").append(appendStr);
            $("#Z").append(appendStr);
            $("#M").append(appendStr);
        }else if(sd_=="1.0"){
            var appendStr = "<option value=''>请选择</option><option value='2' ${regelevStandardPd.C=='2'?'selected':''}>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option>";
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
