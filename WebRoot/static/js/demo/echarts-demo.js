
var dndata='[';   //东南
var compdata='['; //对手

var num;



function a()
{
	$.ajax({
  		url : "statistics/statisticslist.do", //请求地址
  		type : "POST", //请求方式
  		dataType:"JSON",
  		success : function(result) 
  		{
  			num=result.statlist[0].d+100;  //拿到最大的安装数量
  			for(var i=0;i<result.statlist.length;i++)
  			{
  				dndata+='{'+'name:\''+ result.statlist[i].c +'\', value:'+ result.statlist[i].a+'},';
  				compdata+='{'+'name:\''+ result.statlist[i].c +'\', value:'+ result.statlist[i].b+'},';
  			}	
  			dndata = dndata.substring(0, dndata.length - 1);
  			dndata += "]";
  			dndata=eval('('+dndata+')');
  			
  			compdata = compdata.substring(0, compdata.length - 1);
  			compdata += "]";
  			compdata=eval('('+compdata+')');
  			
  			//--------
  		  
  			//-=------
  		    var mapChart = echarts.init(document.getElementById("echarts-map-chart"));
  		    var mapoption = {
  		        title : {
  		            text: '东南电梯销量',
  		            x:'center'
  		        },
  		        
  		        tooltip : {
  		            trigger: 'item',
  		            //formatter:'{a}<br/>{b}:{c}'
  		          formatter:function (params,ticket,callback){
  		        	//alert(params[0]);
  		        
	                     var $pna = params.name;
	                     var res = '';
	                     $.ajax({
	                 		url : "statistics/statisticslist.do", //请求地址
	                 		type : "POST", //请求方式
	                 		dataType:"JSON",
	                 		success : function(result) {
	                 			for(var i=0;i<result.statlist.length;i++)
	                 			{
	             					if(result.statlist[i].c ==$pna)
	                 				{
	             						if(params[0]=="东南安装 ")
	             	  		        	  {
	             							
	             							res =result.statlist[i].c+"<br/>"+"东南安装:"+result.statlist[i].a;
	             							 break;
	             	  		        	  }
	             						else if(params[0]=="竞争对手 ")
	             						{
	             							res =result.statlist[i].c+"<br/>"+"竞争对手:"+result.statlist[i].b;
	             							 break; 
	             						}
	             						else
	             						{
	             							res =result.statlist[i].c+"<br/>"+"东南安装:"+result.statlist[i].a+"<br/>竞争对手:"+result.statlist[i].b;
	             							 break;
	             						}
	                 				}
	                 				else
	                 				{
	                 					res=$pna+":0";
	                 				}
	                 			}
	                 		}
	                 	});
	                     
	                     setTimeout(function (){
	                         // 仅为了模拟异步回调
	                         callback(ticket, res);//回调函数，这里可以做异步请求加载的一些代码
	                     }, 1000)
	                     return '正在加载';
	            	 }
  		        },
  		      //-----------结束--------------
  		        legend: {
  		            orient: 'vertical',
  		            x:'left',
  		            data:['东南安装','竞争对手'],
  		            selected: {
  		                //默认选中
  		            	'东南安装': true,
  		                '竞争对手': true
  		            }
  		        },
  		        dataRange: {
  		            min: 0,
  		            max: num,
  		            x: 'left',
  		            y: 'bottom',
  		            text:['数量'],           // 文本，默认为数值文本
  		            calculable : true
  		        },
  		        toolbox: {
  		            show: true,
  		            orient : 'vertical',
  		            x: 'right',
  		            y: 'center',
  		            feature : {
  		              
  		                dataView : {show: true, readOnly: false},
  		                restore : {show: true},
  		              saveAsImage : {show: true}
  		            }
  		        },
  		        roamController: {
  		            show: true,
  		            x: 'right',
  		            mapTypeControl: {
  		                'china': true
  		            }
  		        },
  		        
  		        series : [
  		            {
  		                name: '东南安装',
  		                type: 'map',
  		                mapType: 'china',
  		              selectedMode:'single',//展示一个还是多个地图
  		            mapValueCalculation:'sum',
  		                
  		                itemStyle:{
  		                    normal:{label:{show:true}},
  		                    emphasis:{label:{show:true}}
  		                },
  		               data:dndata
  		            },
  		            {
  		                name: '竞争对手',
  		                type: 'map',
  		                mapType: 'china',
  		              selectedMode:'single',
  		                itemStyle:{
  		                    normal:{label:{show:true}},
  		                    emphasis:{label:{show:true}}
  		                },
  		                data:compdata
  		            }
  		        ]
  		   
  		    };
  		    mapChart.setOption(mapoption);
  		    $(window).resize(mapChart.resize);
  		}
	}) 
}

$(function () {	
  a();
	
});







