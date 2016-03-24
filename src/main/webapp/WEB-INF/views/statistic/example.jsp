<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="jksb" uri="http://www.jksb.com/jksb-land/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	function initrentalInfoPie(farmCode,farmName){
		var rentalInfoChart = echarts.init(document.getElementById('rentalInfo_main')); 
		$.ajax({
			url:"${ctx}/statistics/getRentalData",
			type:'GET',
			data:{farmCode:farmCode},
			success:function(data){ 
				var names = [];
				var bg_values = [];
				var pd_values = [];
				for(var o in data){
					names[o] = data[o].yearStr;
					bg_values[o] = data[o].budget;
					pd_values[o] = data[o].paid;
				}
				$('#rentalInfo_table').datagrid({
					title:"<div style='width:100%;text-align:center'>"+farmName+" 租金情况统计</div>",
					data:data,
				    columns:[[
				        {field:'yearStr',title:'年份',width:'33%'},
				        {field:'budget',title:'应缴(元)',width:'33%'},
				        {field:'paid',title:'已缴(元)',width:'34%'}
				    ]],
				    onLoadSuccess:function(data){
				    	addSumCells('rentalInfo_table','budget','paid');
				    } 
				}); 
				var option = {
					    title : {
					        text: farmName+'租金情况统计分析' 
					    },
					    tooltip : {
					        trigger: 'axis'
					    },
					    legend: {
					        data:['应缴','已缴']
					    },
					    toolbox: {
					        show : true,
					        feature : {
					            mark : {show: true},
					            dataView : {show: true, readOnly: false},
					            magicType : {show: true, type: ['line', 'bar']},
					            restore : {show: true},
					            saveAsImage : {show: true}
					        }
					    },
					    calculable : true,
					    xAxis : [{
					            type : 'category',
					            data : names
					    }],
					    yAxis : [{
					            type : 'value'
					    }],
					    series : [{
				            name:'应缴',
				            type:'bar',
				            data:bg_values,
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
				            },
				            itemStyle:{ 
				                normal:{ 
				                      label:{ 
				                        show: true, 
				                        formatter: '{c}' 
				                      }, 
				                      labelLine :{show:true} 
				                    } 
				                } 
					     },
					     {
					            name:'已缴',
					            type:'bar',
					            data:pd_values,
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
					            },
					            itemStyle:{ 
					                normal:{ 
					                      label:{ 
					                        show: true, 
					                        formatter: '{c}' 
					                      }, 
					                      labelLine :{show:true} 
					                    } 
					                } 
						     }
					    ]
					};
				rentalInfoChart.setOption(option);
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				$.messager.alert('操作失败',"错误提示:"+XMLHttpRequest.responseText);
			}
		});
	}
	
$("#rentalInfo_farm_select").combobox({
	url:'${ctx}/sys/org/getAllFarms',
    valueField:'code',
    textField:'name',
    method:'GET',
    readonly:true,
    onSelect:function(rec){
    	initrentalInfoPie(rec.code=="1"?"":rec.code,rec.name );
	},
	onLoadSuccess:function(){
		$("#rentalInfo_farm_select").combobox("select","${farmCode}");
		if("${farmCode}" == "1") {
			$(this).combobox("readonly",false);
			initrentalInfoPie("","海南农垦");
		}
	}
}); 
	
</script>
<div style="margin-top:10px;margin-left:50px;margin-bottom:20px;">
	选择农场：<input id="rentalInfo_farm_select" class="easyui-combobox" style="width:120px;" />
</div>

<div class="echarts_container">
	<div style="height:auto;width:95%;float:left;margin-left:20px;text-align:center;">
	  <div style="width:30%;MARGIN-RIGHT: auto; MARGIN-LEFT: auto;float:left; ">
		<table id="rentalInfo_table" ></table>
	  </div>
	<div id="rentalInfo_main" class="echarts_main" _echarts_instance_="14365226577137591"
		style="-webkit-tap-highlight-color: transparent; -webkit-user-select: none; cursor: default; background-color: rgba(0, 0, 0, 0); width: 60%; height: 578px;">
		<div style="position: relative; overflow: hidden; width: 60%; height: 278px;">
			<div data-zr-dom-id="bg" class="zr-element"
				style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none;"></div>
			<canvas width="983" height="378" data-zr-dom-id="0"
				class="zr-element"
				style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></canvas>
			<canvas width="983" height="378" data-zr-dom-id="1"
				class="zr-element"
				style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></canvas>
			<canvas width="983" height="378" data-zr-dom-id="_zrender_hover_"
				class="zr-element"
				style="position: absolute; left: 0px; top: 0px; width: 983px; height: 378px; -webkit-user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></canvas>
			<div class="echarts-dataview"
				style="position: absolute; display: block; overflow: hidden; transition: height 0.8s, background-color 1s; -webkit-transition: height 0.8s, background-color 1s; z-index: 1; left: 0px; top: 0px; width: 983px; height: 0px; background-color: rgb(240, 255, 255);"></div>
			<div class="echarts-tooltip zr-element"
				style="position: absolute; display: none; border: 0px solid rgb(51, 51, 51); white-space: nowrap; transition: left 0.4s, top 0.4s; -webkit-transition: left 0.4s, top 0.4s; border-radius: 4px; color: rgb(255, 255, 255); font-family: 微软雅黑, Arial, Verdana, sans-serif; padding: 5px; left: 331px; top: 262px; background-color: rgba(50, 50, 50, 0.498039);">
			</div>
		</div>
	</div>
	</div>
</div>

