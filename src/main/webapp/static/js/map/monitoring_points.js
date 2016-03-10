/**
 * 2016.03.04 author by tangweilong
 */
require([ "esri/map", "esri/layers/WebTiledLayer", "esri/geometry/Extent",
		"esri/geometry/Point", "esri/layers/TileInfo", "dojo/parser",
		"esri/dijit/OverviewMap", "esri/layers/ArcGISDynamicMapServiceLayer",
		"esri/layers/FeatureLayer", "esri/InfoTemplate", "dojo/on", "dojo/dom",
		"esri/dijit/Legend", "esri/symbols/SimpleFillSymbol",
		"esri/symbols/SimpleLineSymbol", "esri/Color", "esri/graphic",
		"esri/tasks/query", "esri/tasks/QueryTask",
		"dijit/layout/BorderContainer", "dijit/layout/ContentPane",
		"dojo/domReady!" ], function(Map, WebTiledLayer, Extent, Point,
		TileInfo, parser, OverviewMap, ArcGISDynamicMapServiceLayer,
		FeatureLayer, InfoTemplate, on, dom, Legend, SimpleFillSymbol,
		SimpleLineSymbol, Color, Graphic, Query, QueryTask) {
	
	var wkid = 4490;
	var bounds = new Extent({
		"xmin" : 127.45141764160003,
		"ymin" : 15.81985415245003,
		"xmax" : 127.66669821040004,
		"ymax" : 15.918851260550074,
		"spatialReference" : {
			"wkid" : 4490
		}
	});
	var map = new Map("map", {
		extent : bounds,
		logo : false
	});
	var serviceUrl = "http://10.215.201.151:6080/arcgis/rest/services/";
	var monitor_points_Url = serviceUrl + "monitor_points/MapServer";
	var water_pollution_Url = serviceUrl + "water_pollution/MapServer";
	/**
	 * 鹰眼图
	 */
	var overviewMapDijit = new OverviewMap({
		map : map,
		attachTo : "bottom-left",
		visible : true
	}, dom.byId("overViewMap"));
	overviewMapDijit.startup();

	/**
	 * 定义弹窗
	 */

	var monitoring_point_info = new InfoTemplate();
	monitoring_point_info.setTitle("监测点信息");
	monitoring_point_info
			.setContent("<strong>断面情况</strong>${section_condition}<br>"
					+ "<strong>水体名称:</strong>${water_body}<br>"
					+ "<strong>断面名称:</strong>${section_name}<br>"
					+ "<strong>断面位置:</strong>${section_position}<br>"
					+ "<strong>二级编号:</strong>${scdCode}<br>"
					+ "<strong>一级编号:</strong>${fstCode}<br>");
	var water_pollution_filed = [ "water_body" ];
	var monitoring_point_filed = [ "section_condition", "water_body",
			"section_name", "section_position", "scdCode", "fstCode" ];
	var water_pollution_info = new InfoTemplate();
	water_pollution_info.setTitle("水体信息");
	water_pollution_info.setContent("<strong>水体名称:</strong>${water_body}<br>");
	var monitoring_point_layer = new FeatureLayer(monitor_points_Url + "/0", {
		"opacity" : 1,
		outFields : monitoring_point_filed,
		infoTemplate : monitoring_point_info
	});
	var water_pollution_layer = new FeatureLayer(water_pollution_Url + "/0", {
		"opacity" : 1,
		outFields : water_pollution_filed,
		infoTemplate : water_pollution_info
	});
	var water_pollution_Dynamiclayer = new ArcGISDynamicMapServiceLayer(
			water_pollution_Url);
	map.addLayer(water_pollution_Dynamiclayer);
	var legend = new Legend({
		map : map,
		layerInfos : [ {
			layer : monitoring_point_layer,
			title : "监测点"
		}, {
			layer : water_pollution_layer,
			title : "监测水体"
		} ]
	}, "legend");
	legend.startup();

	map.addLayers([ water_pollution_layer, monitoring_point_layer ]);

	function WaterISWhere(conditions) {
		var where = '';
		for ( var index in conditions) {
			var condition = conditions[index];
			if (!condition.value || condition.value.length == 0)
				continue;
			if (where.length > 0) {
				where += ' OR ';
			}
			where += 'time = ' + (parseFloat(condition.value));
		}
		return where;
	}
	/**
	 * @param queryResult
	 * @returns
	 */
	function displayResult(queryResult, wkid) { // 设置显示结果的符合颜色等
		map.graphics.clear();
		map.infoWindow.hide();
		var highlightSymbol = new SimpleFillSymbol(
				SimpleFillSymbol.STYLE_SOLID, new SimpleLineSymbol(
						SimpleLineSymbol.STYLE_SOLID,
						new Color([ 0, 255, 255 ]), 1), new Color([ 0, 255,
						255, 1 ]));
		var template = new InfoTemplate();
		template.setTitle("水体信息");
		for ( var index in queryResult) {
			var feature = queryResult[index].feature;
			var highlightGraphic = new Graphic(feature.geometry,highlightSymbol);
			template.setContent(getShowContent(feature.attributes)); 
			highlightGraphic.setInfoTemplate(template);
			map.graphics.add(highlightGraphic);
		}
		map.setExtent(getExtent(queryResult, wkid));
	}
	/**
	 * 设置查询结果的信息框
	 */
	function getShowContent(attribute) {
	    var content = '';
	    content += '<strong>水体名称:</strong>' + attribute["water_body"] + '<br>';
	    content += '<strong>面积：</strong>' + (parseFloat(attribute["Shape.STArea()"]) / 666.67).toFixed(2) + '亩';
	    return content;
	}
	/**
	 * 获取结果集的范围
	 */
	function getExtent(queryResult, wkid) { 
		var xmin = 0;
		var ymin = 0;
		var xmax = 0;
		var ymax = 0;
		for ( var index in queryResult) {
			var extent = queryResult[index].extent;
			if (xmin == 0) {
				xmin = extent.xmin;
			}
			if (ymin == 0) {
				ymin = extent.ymin;
			}
			if (xmax == 0) {
				xmax = extent.xmax;
			}
			if (ymax == 0) {
				ymax = extent.ymax;
			} // 判断图形范围,选取所以图形的最小最大坐标当显示范围
			xmin = (xmin > extent.xmin ? extent.xmin : xmin);
			ymin = (ymin > extent.ymin ? extent.ymin : ymin);
			xmax = (xmax > extent.xmax ? xmax : extent.xmax);
			ymax = (ymax > extent.ymax ? ymax : extent.ymax);
		}
		return new Extent({
			"xmin" : xmin,
			"ymin" : ymin,
			"xmax" : xmax,
			"ymax" : ymax,
			"spatialReference" : {
				"wkid" : wkid
			}
		});
	}

	function selectWater() {
		var query = new arcgisObj.Query();
		var queryTask = new QueryTask(water_pollution_Url + "/0");
		query.where = WaterISWhere();
		query.returnGeometry = true;
		query.maxAllowableOffset = calcOffset();
		query.num = 2000;
		query.outFields = water_pollution_filed;
		template.setTitle("水体信息");
		var queryResult = [];
		queryTask.execute(query, function(results) {
			if (results.features) {
				for ( var index in results.features) {
					var feature = results.features[index];
					var extent = feature.geometry.getExtent();
					var result = {
						extent : extent,
						feature : feature
					};
					queryResult.push(result);
				}
				if (queryResult.length > 0) {
					displayResult(queryResult, wkid);
				} else {
					$.messager.alert('提示', '没有符合条件的地块', 'info');
				}
			}
		});
	}

	function calcOffset() {
		return (map.extent.getWidth() / map.width);
	}
});