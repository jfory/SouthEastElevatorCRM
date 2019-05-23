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
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
    
    <script src="static/js/plugins/echarts/echarts3/echarts.js"></script>
	<!-- echarts -->
    <link href="static/css/echarts/style.css" rel="stylesheet">
    
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg" >
    <input type="hidden" name="type" id="type">

    <div class="col-sm-12">
        <div class="form-control form-inline" style="margin-bottom: 15px;height:2%;padding:10px;">
            <input class="form-control" id="nav-search-input" type="text"
			   name="input_date_start"
                                 onclick="laydate()"
			   placeholder="录入日期开始于">
			<input class="form-control" id="nav-search-input" type="text"
			   name="input_date_end"
                                 onclick="laydate()"
			   placeholder="录入日期结束于">
<!--             <a class="btn btn-warning btn-outline" style="margin-left: 10px; height:32px;" title="导出到Excel" type="button" target="_blank" onclick="toExcel(this);" href="javascript:;">导出</a> -->
        
        	<select style="width: 20%;" class="form-control" id="areaSelect" name="areaSelect">
<<<<<<< HEAD
                <option value="">区域选择</option>
                <option value="东区营销中心">东区营销中心</option>
                <option value="南区营销中心">南区营销中心</option>
                <option value="西区营销中心">西区营销中心</option>
                <option value="北区营销中心">北区营销中心</option>
                <option value="苏州多美适">苏州多美适</option>
                <option value="国际部">国际部</option>
                <option value="战略客户">战略客户</option>
                <option value="军民融合部">军民融合部</option>
=======
                <option value="">请选择</option>
                <option value="1">东区营销中心</option>
                <option value="2">南区营销中心</option>
                <option value="3">西区营销中心</option>
                <option value="4">北区营销中心</option>
                <option value="5">苏州多美适</option>
                <option value="6">国际部</option>
                <option value="7">战略客户</option>
                <option value="8">军民融合部</option>
>>>>>>> 84ecd0dc1cb9b626ed6f32a72eec5d5a6005d642
            </select>
        	<button class="btn  btn-primary" title="查询" 
								style="margin-left: 10px; height:32px;margin-top:3px;"onclick="ShowReport()">按时间段查询</button>
								&nbsp;
			<a class="btn btn-warning btn-outline" style="margin-left: 10px; height:32px;" title="导出到Excel" type="button" target="_blank" onclick="toExcel(this);" href="javascript:;">导出</a>
								
        </div>
        
        <div class="table-responsive" style="visibility: hidden;">
        	<table class="table table-striped table-bordered table-hover">
        		<thead>
					<tr>
						<th style="text-align:center;">营运模块</th>
						<th style="text-align:center;">P10评审项目数</th>
						<th style="text-align:center;">P10评审台数</th>
						<th style="text-align:center;">P10合同已输出项目数</th>
						<th style="text-align:center;">P10已输出台数</th>
					</tr>
				</thead>
				<tbody>
						<tr>
							<td>东区</td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="east_item_count" name="east_item_count" value="${pd.east_item_count}"/></td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="east_itemdt_count" name="east_itemdt_count" value="${pd.east_itemdt_count}"/></td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="east_Contract_count" name="east_Contract_count" value="${pd.east_Contract_count}"/></td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="east_dt_count" name="east_dt_count" value="${pd.east_dt_count}"/></td>
						</tr>
						<tr>
							<td>南区</td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="south_item_count" name="south_item_count" value="${pd.south_item_count}"/></td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="south_itemdt_count" name="south_itemdt_count" value="${pd.south_itemdt_count}"/></td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="south_Contract_count" name="south_Contract_count" value="${pd.south_Contract_count}"/></td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="south_dt_count" name="south_dt_count" value="${pd.south_dt_count}"/></td>
						</tr>
						<tr>
							<td>西区</td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="west_item_count" name="west_item_count" value="${pd.west_item_count}"/></td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="west_itemdt_count" name="west_itemdt_count" value="${pd.west_itemdt_count}"/></td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="west_Contract_count" name="west_Contract_count" value="${pd.west_Contract_count}"/></td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="west_dt_count" name="west_dt_count" value="${pd.west_dt_count}"/></td>
						</tr>
						<tr>
							<td>北区</td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="north_item_count" name="north_item_count" value="${pd.north_item_count}"/></td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="north_itemdt_count" name="north_itemdt_count" value="${pd.north_itemdt_count}"/></td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="north_Contract_count" name="north_Contract_count" value="${pd.north_Contract_count}"/></td>
							<td><input type="text" style="width: 100%;height:100%;" readonly="readonly" id="north_dt_count" name="north_dt_count" value="${pd.north_dt_count}"/></td>
						</tr>
				</tbody>
        	</table>
        </div>
        
        
        
        <div id="main" style="width: 1200px;height:600px;"></div>
<<<<<<< HEAD
        <div id="bing1" style="width: 1200px;height:600px;"></div>
=======
>>>>>>> 84ecd0dc1cb9b626ed6f32a72eec5d5a6005d642
        

    </div>

    
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
	
	
	    });
		
		function toExcel(ele){
			var input_date_start = $("input[name='input_date_start']").val();
			var input_date_end = $("input[name='input_date_end']").val();
		  	
		  	$(ele).attr("href", "<%=basePath%>report/toitemRollingReportExcel.do?"
				+"&input_date_start="+input_date_start
				+"&input_date_end="+input_date_end);
			}
		
		function ShowReport(){
			var input_date_start = $("input[name='input_date_start']").val();
			var input_date_end = $("input[name='input_date_end']").val();
<<<<<<< HEAD
			var areaSelect = $("#areaSelect").val();
			var Reportresult = new Array();
			var date = new Date();
			var year = date.getFullYear();
			var month = date.getMonth() + 1;
			var arealist = ['丢失','延迟','考察入围','最终入围','中标通知书','合同谈判','合同评审','等待定金','定金付出','定金收到'];
			var bing1xs = [];
			var barxs = [];
			var myChart = echarts.init(document.getElementById('main'));
			var bing1Chart = echarts.init(document.getElementById('bing1'));
			bing1Chart.clear();
			myChart.clear();
			if (input_date_start=="") {
				
				input_date_start = year+"-"+month+"-"+"01";
				input_date_end = year+"-"+month+"-"+"31";
			}
			
			
			if (areaSelect!="") {
				
				
				$.ajax({
					type: "GET",//方法类型
		              dataType: "HTML",//预期服务器返回的数据类型
		              url: "<%=basePath%>report/SearchItemRollingBycondition.do" ,//url
		              data:{input_date_start:input_date_start,input_date_end:input_date_end,areaSelect:areaSelect},
		              success: function (result) {
		            	  Reportresult = eval('(' + result + ')');
		                  
		                  for (var i = 0; i < arealist.length; i++) {
		                	  bing1xs.push({
								  name:arealist[i],
								  value:Reportresult[i]
							  });
						  }
		                  
		                  var bing1option = {
						            title: {
						                text: areaSelect
						            },
						            tooltip: {
						                trigger: 'item',
						                formatter: "{a} <br/>{b} : {c} ({d}%)"
						            },
						            legend: {
						            	data: arealist,
						            	x:50,
						            	y:50
						            },
						            series: [{
						                name: areaSelect,
						                selectedMode: 'single',
						                type: 'pie',
						                radius : '55%',
						                center: ['50%', '60%'],
						                data: bing1xs,
						                itemStyle: {
						                    emphasis: {
						                        shadowBlur: 10,
						                        shadowOffsetX: 0,
						                        shadowColor: 'rgba(0, 0, 0, 0.5)'
						                    }
						                }
						            }]
						        };
		                  
		                 var chartoption = {
		                		 color: ['#003366', '#006699', '#4cabce', '#e5323e'],
		                		    tooltip: {
		                		        trigger: 'axis',
		                		        axisPointer: {
		                		            type: 'shadow'
		                		        }
		                		    },
		                		    legend: {
		                		        data: arealist
		                		    },
		                		    toolbox: {
		                		        show: true,
		                		        orient: 'vertical',
		                		        left: 'right',
		                		        top: 'center',
		                		        feature: {
		                		            mark: {show: true},
		                		            dataView: {show: true, readOnly: false},
		                		            magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},
		                		            restore: {show: true},
		                		            saveAsImage: {show: true}
		                		        }
		                		    },
		                		    xAxis: {
		                		        type: 'category',
		                		        data: arealist
		                		    },
		                		    yAxis: {
		                		        type: 'value'
		                		    },
		                		    series: [{
		                		        data: bing1xs,
		                		        type: 'bar'
		                		    }]
		                		};
		                  bing1Chart.setOption(bing1option);
		                  myChart.setOption(chartoption);
		                  
		              },
		              error: function(result){
		            	  console.log("fail");
		              }
		              
				});
// 				myChart.setOption(option);
//				清空
				bing1xs = [];
			}else{
				
				var countlist = new Array();
=======
			var areaSelect = $("input[name='areaSelect']").val();
			if (areaSelect!=""&&areaSelect.length>0) {
				var myChart = echarts.init(document.getElementById('main'));
				var bingChart = echarts.init(document.getElementById('bing1'));
				var Reportresult = new Array();
			}else{
				var myChart = echarts.init(document.getElementById('main'));
				var Reportresult = new Array();
				var countlist = new Array();
				
				
>>>>>>> 84ecd0dc1cb9b626ed6f32a72eec5d5a6005d642
				var diushiarray = new Array();
				var yanhouarray = new Array();
				var kaochaarray = new Array();
				var zuizhongarray = new Array();
				var zhongbiaoarray = new Array();
				var hetongtanpanarray = new Array();
				var hetongpingshenarray = new Array();
				var dengdaidingjinarray = new Array();
				var dingjinfuchuarray = new Array();
				var dingjinshoudaoarray = new Array();

				
				$.ajax({
			          //几个参数需要注意一下
			              type: "GET",//方法类型
			              dataType: "HTML",//预期服务器返回的数据类型
			              url: "<%=basePath%>report/SearchItemRolling.do" ,//url
			              data:{input_date_start:input_date_start,input_date_end:input_date_end},
			              success: function (report) {
							//转Json对象
			            	  Reportresult = eval('(' + report + ')');
<<<<<<< HEAD

=======
	 		                  console.log(report);
			                  console.log(Reportresult);
>>>>>>> 84ecd0dc1cb9b626ed6f32a72eec5d5a6005d642

			                  for(var i = 0; i < 8; i++) {
			                  	  for(var j = 0; j < 10; j++) {
			                  		  switch (j) {
			        					case 0:
			        						diushiarray.push(Reportresult[i][0]);
			        						break;
			        					case 1:
			        						yanhouarray.push(Reportresult[i][1]);
			        						break;
			        					case 2:
			        						kaochaarray.push(Reportresult[i][2]);
			        						break;
			        					case 3:
			        						zuizhongarray.push(Reportresult[i][3]);
			        						break;
			        					case 4:
			        						zhongbiaoarray.push(Reportresult[i][4]);
			        						break;
			        					case 5:
			        						hetongtanpanarray.push(Reportresult[i][5]);
			        						break;
			        					case 6:
			        						hetongpingshenarray.push(Reportresult[i][6]);
			        						break;
			        					case 7:
			        						dengdaidingjinarray.push(Reportresult[i][7]);
			        						break;
			        					case 8:
			        						dingjinfuchuarray.push(Reportresult[i][8]);
			        						break;
			        					case 9:
			        						dingjinshoudaoarray.push(Reportresult[i][9]);
			        						break;
			        					default:
			        						break;
			        					}
			        	          		
			                  		
			                  		  
			                  	  }
			              		}

							  var option = {
						            title: {
						                text: ''
						            },
						            tooltip: {
						                trigger: 'axis',
						                axisPointer: {
						                    type: 'shadow'
						                }
						            },
						            legend: {
						            	data: ['丢失','延后','考察入围','最终入围','中标通知书','合同谈判','合同评审','等待订金','订金付出','订金收到']
						            },
						            xAxis: {
						                data: ['东区','南区','西区','北区','苏州多美适','国际部','战略客户部','军民融合部']
						            },
						            yAxis: {},
						            toolbox: {
						                show: true,
						                orient: 'vertical',
						                left: 'right',
						                top: 'center',
						                feature: {
						                    mark: {show: true},
						                    dataView: {show: true, readOnly: false},
						                    magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},
						                    restore: {show: true},
						                    saveAsImage: {show: true}
						                }
						            },
						            series: [{
						                name: '丢失',
						                type: 'bar',
						                data: diushiarray,
						                itemStyle: {
											normal: {
												label: {
													show: false, //开启显示
													position: 'top', //在上方显示
													textStyle: { //数值样式
														color: 'black',
														fontSize: 14
													}
												}
											}
						                }
						            },
						            {
						                name: '延后',
						                type: 'bar',
						                data: yanhouarray,
						                itemStyle: {
											normal: {
												label: {
													show: false, //开启显示
													position: 'top', //在上方显示
													textStyle: { //数值样式
														color: 'black',
														fontSize: 14
													}
												}
											}
						                }
						            },
						            {
						                name: '考察入围',
						                type: 'bar',
						                data: kaochaarray,
						                itemStyle: {
											normal: {
												label: {
													show: false, //开启显示
													position: 'top', //在上方显示
													textStyle: { //数值样式
														color: 'black',
														fontSize: 14
													}
												}
											}
						                }
						            },
						            {
						                name: '最终入围',
						                type: 'bar',
						                data: zuizhongarray,
						                itemStyle: {
											normal: {
												label: {
													show: false, //开启显示
													position: 'top', //在上方显示
													textStyle: { //数值样式
														color: 'black',
														fontSize: 14
													}
												}
											}
						                }
						            },
						            {
						                name: '中标通知书',
						                type: 'bar',
						                data: zhongbiaoarray,
						                itemStyle: {
											normal: {
												label: {
													show: false, //开启显示
													position: 'top', //在上方显示
													textStyle: { //数值样式
														color: 'black',
														fontSize: 14
													}
												}
											}
						                }
						            },
						            {
						                name: '合同谈判',
						                type: 'bar',
						                data: hetongtanpanarray,
						                itemStyle: {
											normal: {
												label: {
													show: false, //开启显示
													position: 'top', //在上方显示
													textStyle: { //数值样式
														color: 'black',
														fontSize: 14
													}
												}
											}
						                }
						            },
						            {
						                name: '合同评审',
						                type: 'bar',
						                data: hetongpingshenarray,
						                itemStyle: {
											normal: {
												label: {
													show: false, //开启显示
													position: 'top', //在上方显示
													textStyle: { //数值样式
														color: 'black',
														fontSize: 14
													}
												}
											}
						                }
						            },
						            {
						                name: '等待订金',
						                type: 'bar',
						                data: dengdaidingjinarray,
						                itemStyle: {
											normal: {
												label: {
													show: false, //开启显示
													position: 'top', //在上方显示
													textStyle: { //数值样式
														color: 'black',
														fontSize: 14
													}
												}
											}
						                }
						            },
						            {
						                name: '订金付出',
						                type: 'bar',
						                data: dingjinfuchuarray,
						                itemStyle: {
											normal: {
												label: {
													show: false, //开启显示
													position: 'top', //在上方显示
													textStyle: { //数值样式
														color: 'black',
														fontSize: 14
													}
												}
											}
						                }
						            },
						            {
						                name: '订金收到',
						                type: 'bar',
						                data: dingjinshoudaoarray,
						                itemStyle: {
											normal: {
												label: {
													show: false, //开启显示
													position: 'top', //在上方显示
													textStyle: { //数值样式
														color: 'black',
														fontSize: 14
													}
												}
											}
						                }
						            }]
						        };

						        // 使用刚指定的配置项和数据显示图表。
						        myChart.setOption(option);
							  
			              },
			              error: function(result){
			            	  console.log(result);
			              }

			          });
<<<<<<< HEAD
				//清空
				Reportresult = [];
=======
>>>>>>> 84ecd0dc1cb9b626ed6f32a72eec5d5a6005d642
			}
			
			
			

		}

	</script>
</body>

</html>
