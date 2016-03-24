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
		function randomData() {
		    return Math.round(Math.random()*1000);
		}

		option = {
		    title: {
		        text: '污染物含量',
		        subtext: '纯属虚构',
		        left: 'center'
		    },
		    tooltip: {
		        trigger: 'item'
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data:['污染物1含量','污染物2含量','污染物3含量']
		    },
		    visualMap: {
		        min: 0,
		        max: 2500,
		        left: 'left',
		        top: 'bottom',
		        text: ['高','低'],           // 文本，默认为数值文本
		        calculable: true
		    },
		    toolbox: {
		        show: true,
		        orient: 'vertical',
		        left: 'right',
		        top: 'center',
		        feature: {
		            dataView: {readOnly: false},
		            restore: {},
		            saveAsImage: {}
		        }
		    },
		    series: [
		        {
		            name: '污染物1含量',
		            type: 'map',
		            mapType: 'china',
		            roam: false,
		            label: {
		                normal: {
		                    show: true
		                },
		                emphasis: {
		                    show: true
		                }
		            },
		            data:[
		                {name: '北京',value: randomData() },
		                {name: '天津',value: randomData() },
		                {name: '上海',value: randomData() },
		                {name: '重庆',value: randomData() },
		                {name: '河北',value: randomData() },
		                {name: '河南',value: randomData() },
		                {name: '云南',value: randomData() },
		                {name: '辽宁',value: randomData() },
		                {name: '黑龙江',value: randomData() },
		                {name: '湖南',value: randomData() },
		                {name: '安徽',value: randomData() },
		                {name: '山东',value: randomData() },
		                {name: '新疆',value: randomData() },
		                {name: '江苏',value: randomData() },
		                {name: '浙江',value: randomData() },
		                {name: '江西',value: randomData() },
		                {name: '湖北',value: randomData() },
		                {name: '广西',value: randomData() },
		                {name: '甘肃',value: randomData() },
		                {name: '山西',value: randomData() },
		                {name: '内蒙古',value: randomData() },
		                {name: '陕西',value: randomData() },
		                {name: '吉林',value: randomData() },
		                {name: '福建',value: randomData() },
		                {name: '贵州',value: randomData() },
		                {name: '广东',value: randomData() },
		                {name: '青海',value: randomData() },
		                {name: '西藏',value: randomData() },
		                {name: '四川',value: randomData() },
		                {name: '宁夏',value: randomData() },
		                {name: '海南',value: randomData() },
		                {name: '台湾',value: randomData() },
		                {name: '香港',value: randomData() },
		                {name: '澳门',value: randomData() }
		            ]
		        },
		        {
		            name: '污染物2含量',
		            type: 'map',
		            mapType: 'china',
		            label: {
		                normal: {
		                    show: true
		                },
		                emphasis: {
		                    show: true
		                }
		            },
		            data:[
		                {name: '北京',value: randomData() },
		                {name: '天津',value: randomData() },
		                {name: '上海',value: randomData() },
		                {name: '重庆',value: randomData() },
		                {name: '河北',value: randomData() },
		                {name: '安徽',value: randomData() },
		                {name: '新疆',value: randomData() },
		                {name: '浙江',value: randomData() },
		                {name: '江西',value: randomData() },
		                {name: '山西',value: randomData() },
		                {name: '内蒙古',value: randomData() },
		                {name: '吉林',value: randomData() },
		                {name: '福建',value: randomData() },
		                {name: '广东',value: randomData() },
		                {name: '西藏',value: randomData() },
		                {name: '四川',value: randomData() },
		                {name: '宁夏',value: randomData() },
		                {name: '香港',value: randomData() },
		                {name: '澳门',value: randomData() }
		            ]
		        },
		        {
		            name: '污染物3含量',
		            type: 'map',
		            mapType: 'china',
		            label: {
		                normal: {
		                    show: true
		                },
		                emphasis: {
		                    show: true
		                }
		            },
		            data:[
		                {name: '北京',value: randomData() },
		                {name: '天津',value: randomData() },
		                {name: '上海',value: randomData() },
		                {name: '广东',value: randomData() },
		                {name: '台湾',value: randomData() },
		                {name: '香港',value: randomData() },
		                {name: '澳门',value: randomData() }
		            ]
		        }
		    ]
		};
	
		exampleEcharts.setOption(option);
	</script>
</body>
</html>

