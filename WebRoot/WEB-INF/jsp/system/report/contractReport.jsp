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
        
        
        <div style="text-align: center;">
	        <div id="main" style="width: 900px;height:600px;"></div>
	        <div>
	        	<table>
	        		<tr>
	        			<td><div id="bing1" style="width: 450px;height:450px;"></div></td>
	        			<td><div id="bing3" style="width: 450px;height:450px;"></div></td>
	        		</tr>
	        		<tr>
	        			<td><div id="bing4" style="width: 450px;height:450px;"></div></td>
	        			<td><div id="bing2" style="width: 450px;height:450px;"></div></td>
	        		</tr>
	        	</table>
		        
		        
	        </div>
        </div>
        
        
        

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
		  	
		  	$(ele).attr("href", "<%=basePath%>report/toContractReportExcel.do?"
				+"&input_date_start="+input_date_start
				+"&input_date_end="+input_date_end);
			}
		
		function ShowReport(){
			var input_date_start = $("input[name='input_date_start']").val();
			var input_date_end = $("input[name='input_date_end']").val();
			
			var myChart = echarts.init(document.getElementById('main'));
			var bing1Chart = echarts.init(document.getElementById('bing1'));
			var bing2Chart = echarts.init(document.getElementById('bing2'));
			var bing3Chart = echarts.init(document.getElementById('bing3'));
			var bing4Chart = echarts.init(document.getElementById('bing4'));
			var Reportresult = new Array();
			var arealist = ['东区','南区','西区','北区','苏州多美适','国际部','战略合作部','军民融合部'];
			var item_count = [];
			var item_dtcount = new Array();
			var contractcount = new Array();
			var contractdtcount = new Array();
			
			$.ajax({
		          //几个参数需要注意一下
		              type: "GET",//方法类型
		              dataType: "HTML",//预期服务器返回的数据类型
		              url: "<%=basePath%>report/SearchContractReport.do" ,//url
		              data:{input_date_start:input_date_start,input_date_end:input_date_end},
		              success: function (result) {
						//转Json对象
		            	  Reportresult = eval('(' + result + ')');
		                  
		                  $('#east_item_count').val(Reportresult.east_item_count);
		                  $('#east_itemdt_count').val(Reportresult.east_itemdt_count);
		                  $('#east_Contract_count').val(Reportresult.east_Contract_count);
		                  $('#east_dt_count').val(Reportresult.east_dt_count);
		                  
		                  $('#south_item_count').val(Reportresult.south_item_count);
		                  $('#south_itemdt_count').val(Reportresult.south_itemdt_count);
		                  $('#south_Contract_count').val(Reportresult.south_Contract_count);
		                  $('#south_dt_count').val(Reportresult.south_dt_count);
		                  
		                  $('#west_item_count').val(Reportresult.west_item_count);
		                  $('#west_itemdt_count').val(Reportresult.west_itemdt_count);
		                  $('#west_Contract_count').val(Reportresult.west_Contract_count);
		                  $('#west_dt_count').val(Reportresult.west_dt_count);
		                  
		                  $('#north_item_count').val(Reportresult.north_item_count);
		                  $('#north_itemdt_count').val(Reportresult.north_itemdt_count);
		                  $('#north_Contract_count').val(Reportresult.north_Contract_count);
		                  $('#north_dt_count').val(Reportresult.north_dt_count);
		                  
 		                  item_count.push(Reportresult.east_item_count);
 		                  item_count.push(Reportresult.south_item_count);
 		                  item_count.push(Reportresult.west_item_count);
 		                  item_count.push(Reportresult.north_item_count);
 		                  item_count.push(Reportresult.suzhou_Item_count);
 		                  item_count.push(Reportresult.guoji_Item_count);
 		                  item_count.push(Reportresult.zhanlve_Item_count);
 		                  item_count.push(Reportresult.junmin_Item_count);
 		                  
 		                  item_dtcount.push(Reportresult.east_itemdt_count);
 		                  item_dtcount.push(Reportresult.south_itemdt_count);
 		               	  item_dtcount.push(Reportresult.west_itemdt_count);
 		              	  item_dtcount.push(Reportresult.north_itemdt_count);
 		              	  item_dtcount.push(Reportresult.suzhou_Itemdt_count);
 		              	  item_dtcount.push(Reportresult.guoji_Itemdt_count);
 		              	  item_dtcount.push(Reportresult.zhanlve_Itemdt_count);
 		              	  item_dtcount.push(Reportresult.junmin_Itemdt_count);
		                  
	 		              contractcount.push(Reportresult.east_Contract_count);
	 		           	  contractcount.push(Reportresult.south_Contract_count);
	 		              contractcount.push(Reportresult.west_Contract_count);
	 		          	  contractcount.push(Reportresult.north_Contract_count);
	 		          	  contractcount.push(Reportresult.suzhou_Contract_count);
	 		          	  contractcount.push(Reportresult.guoji_Contract_count);
	 		          	  contractcount.push(Reportresult.zhanlve_Contract_count);
	 		          	  contractcount.push(Reportresult.junmin_Contract_count);
 		                  
		 		          contractdtcount.push(Reportresult.east_dt_count);
		 		          contractdtcount.push(Reportresult.south_dt_count);
		 		          contractdtcount.push(Reportresult.west_dt_count);
		 		      	  contractdtcount.push(Reportresult.north_dt_count);
		 		      	  contractdtcount.push(Reportresult.suzhou_dt_count);
		 		      	  contractdtcount.push(Reportresult.guoji_dt_count);
		 		      	  contractdtcount.push(Reportresult.zhanlve_dt_count);
		 		      	  contractdtcount.push(Reportresult.junmin_dt_count);
 		                  
						  
						  var option = {
					            title: {
					                text: '合同评审报表'
					            },
					            tooltip: {
					                trigger: 'axis',
					                axisPointer: {
					                    type: 'shadow'
					                }
					            },
					            legend: {
					            	data: ['项目总量','项目电梯总量','合同总量','合同电梯总量']
					            },
					            xAxis: {
					                data: arealist
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
					                name: '项目总量',
					                type: 'bar',
					                data: item_count,
					                itemStyle: {
										normal: {
											label: {
												show: true, //开启显示
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
					                name: '项目电梯总量',
					                type: 'bar',
					                data: item_dtcount,
					                itemStyle: {
										normal: {
											label: {
												show: true, //开启显示
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
					                name: '合同总量',
					                type: 'bar',
					                data: contractcount,
					                itemStyle: {
										normal: {
											label: {
												show: true, //开启显示
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
					                name: '合同电梯总量',
					                type: 'bar',
					                data: contractdtcount,
					                itemStyle: {
										normal: {
											label: {
												show: true, //开启显示
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
						  
						  var bing1xs = [];
						  for (var i = 0; i < arealist.length; i++) {
							  bing1xs.push({
								  name:arealist[i],
								  value:item_count[i]
							  });
						  }
						  
						  var bing1option = {
						            title: {
						                text: 'P'+input_date_start+'-'+input_date_end+'评审项目数'
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
						                name: '评审项目数',
						                selectedMode: 'single',
<<<<<<< HEAD
=======
						                selectedMode: 'single',
>>>>>>> 84ecd0dc1cb9b626ed6f32a72eec5d5a6005d642
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
						  var bing2xs = [];
						  for (var i = 0; i < arealist.length; i++) {
							  bing2xs.push({
								  name:arealist[i],
								  value:contractdtcount[i]
							  });
						  }
						  var bing2option = {
						            title: {
						                text: 'P'+input_date_start+'-'+input_date_end+'合同已输出台数'
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
						                name: '合同已输出台数',
						                type: 'pie',
						                selectedMode: 'single',
						                radius : '55%',
						                center: ['50%', '60%'],
						                data: bing2xs,
						                itemStyle: {
						                    emphasis: {
						                        shadowBlur: 10,
						                        shadowOffsetX: 0,
						                        shadowColor: 'rgba(0, 0, 0, 0.5)'
						                    }
						                }
						            }]
						        };
						  var bing3xs = [];
						  for (var i = 0; i < arealist.length; i++) {
							  bing3xs.push({
								  name:arealist[i],
								  value:item_dtcount[i]
							  });
						  }
						  var bing3option = {
						            title: {
						                text: 'P'+input_date_start+'-'+input_date_end+'项目评审台数'
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
						                name: '项目评审台数',
						                type: 'pie',
						                radius : '55%',
						                selectedMode: 'single',
						                center: ['50%', '60%'],
						                data: bing3xs,
						                itemStyle: {
						                    emphasis: {
						                        shadowBlur: 10,
						                        shadowOffsetX: 0,
						                        shadowColor: 'rgba(0, 0, 0, 0.5)'
						                    }
						                }
						            }]
						        };
						  var bing4xs = [];
						  for (var i = 0; i < arealist.length; i++) {
							  bing4xs.push({
								  name:arealist[i],
								  value:contractcount[i]
							  });
							  
						  }
						  var bing4option = {
						            title: {
						                text: 'P'+input_date_start+'-'+input_date_end+'合同总量'
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
						                name: '合同总量',
						                type: 'pie',
						                selectedMode: 'single',
						                radius : '55%',
						                center: ['50%', '60%'],
						                data: bing4xs,
						                itemStyle: {
						                    emphasis: {
						                        shadowBlur: 10,
						                        shadowOffsetX: 0,
						                        shadowColor: 'rgba(0, 0, 0, 0.5)'
						                    }
						                }
						            }]
						        };

					        // 使用刚指定的配置项和数据显示图表。
					        myChart.setOption(option);
					        bing1Chart.setOption(bing1option);
					        bing2Chart.setOption(bing2option);
					        bing3Chart.setOption(bing3option);
					        bing4Chart.setOption(bing4option);
						  
		              },
		              error: function(result){
		            	  console.log(result.status);
		              }

		          });

		}

	</script>
</body>

</html>
