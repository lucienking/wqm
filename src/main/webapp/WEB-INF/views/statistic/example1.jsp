<!DOCTYPE html>
<%@ page language="java"  language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/public/common.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>监测数据</title>
	<script src="${ctx }/static/echarts/dist/echarts-all.js"></script>
</head>
<body>
	<div id="exampleEcharts" style="width: 100%;height:550px;"></div>
	<script type="text/javascript">
		var exampleEcharts = echarts.init(document.getElementById('exampleEcharts')); 
		var option = {
			    title : {
			        text: '福创溪监测数据统计',
			        subtext: '纯属虚构'
			    },
			    tooltip : {
			        trigger: 'axis'
			    },
			    legend: {
			        data:['溶解氧','PH值','氯化物','盐度','电导率','透明度']
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            dataView : {show: true, readOnly: false},
			            magicType : {show: true, type: ['line', 'bar']},
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    },
			    calculable : true,
			    xAxis : [
			        {
			            type : 'category',
			            data : ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value'
			        }
			    ],
			    series : [
			        {
			            name:'溶解氧',
			            type:'bar',
			            data:[2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3],
			            markPoint : {
			                data : [
			                    {type : 'max', name: '最大值'},
			                    {type : 'min', name: '最小值'}
			                ]
			            },
			            markLine : {
			                data : [
			                    {type : 'average', name: '平均值'}
			                ]
			            }
			        },
			        {
			            name:'PH值',
			            type:'bar',
			            data:[5.9, 5.9, 6.3,6.9, 7.0, 7.0, 6.5, 6.6, 6.4, 6.7, 6.0,6.5],
			            markPoint : {
			                data : [
			                    {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183},
			                    {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
			                ]
			            },
			            markLine : {
			                data : [
			                    {type : 'average', name : '平均值'}
			                ]
			            }
			        },
			        {
			            name:'氯化物',
			            type:'bar',
			            data:[23.2, 21.2, 43.2, 73.2, 83.2, 76.7, 19.6, 79.2, 32.6, 20.0, 27.2, 93.3],
			            markPoint : {
			                data : [
			                    {type : 'max', name: '最大值'},
			                    {type : 'min', name: '最小值'}
			                ]
			            },
			            markLine : {
			                data : [
			                    {type : 'average', name: '平均值'}
			                ]
			            }
			        },
			        {
			            name:'盐度',
			            type:'bar',
			            data:[2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3],
			            markPoint : {
			                data : [
			                    {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183},
			                    {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
			                ]
			            },
			            markLine : {
			                data : [
			                    {type : 'average', name : '平均值'}
			                ]
			            }
			        },
			        {
			            name:'电导率',
			            type:'bar',
			            data:[12.0, 14.9, 17.0, 33.2, 25.6, 46.7, 35.6, 62.2, 42.6, 60.0, 62.4, 32.3],
			            markPoint : {
			                data : [
			                    {type : 'max', name: '最大值'},
			                    {type : 'min', name: '最小值'}
			                ]
			            },
			            markLine : {
			                data : [
			                    {type : 'average', name: '平均值'}
			                ]
			            }
			        },
			        {
			            name:'透明度',
			            type:'bar',
			            data:[25.6, 52.9, 91.0, 26.4, 48.7, 30.7, 85.6, 68.2, 78.7, 38.8, 26.0, 21.3],
			            markPoint : {
			                data : [
			                    {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183},
			                    {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
			                ]
			            },
			            markLine : {
			                data : [
			                    {type : 'average', name : '平均值'}
			                ]
			            }
			        }
			    ]
			};
	
		exampleEcharts.setOption(option);
	</script>
</body>
</html>

