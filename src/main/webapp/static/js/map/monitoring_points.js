/**
 * 2016.03.04 author by tangweilong
 */
var wkid = 4490;
var serviceUrl = "http://10.215.201.151:6080/arcgis/rest/services/";
var monitor_points_Url = serviceUrl + "monitor_points/MapServer";
var water_pollution_Url = serviceUrl + "water_pollution/MapServer";
require(
		[ "esri/map", "esri/layers/WebTiledLayer", "esri/geometry/Extent",
				"esri/geometry/Point", "esri/layers/TileInfo", "dojo/parser",
				"esri/dijit/OverviewMap","esri/SpatialReference",
				"esri/layers/ArcGISDynamicMapServiceLayer",
				"esri/layers/FeatureLayer", "esri/InfoTemplate", "dojo/on",
				"dojo/dom", "esri/dijit/Legend",
				"esri/symbols/SimpleFillSymbol","esri/symbols/SimpleMarkerSymbol",
				"esri/symbols/SimpleLineSymbol", "esri/Color", "esri/graphic",
				"esri/tasks/query", "esri/tasks/QueryTask",
				"dijit/layout/BorderContainer", "dijit/layout/ContentPane",
				"dojo/domReady!" ],
		function(Map, WebTiledLayer, Extent, Point, TileInfo, parser,
				OverviewMap,SpatialReference, ArcGISDynamicMapServiceLayer, FeatureLayer,
				InfoTemplate, on, dom, Legend, SimpleFillSymbol,SimpleMarkerSymbol,
				SimpleLineSymbol, Color, Graphic, Query, QueryTask) {

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
				zoom: 16,
				extent : bounds,
				logo : false
			});
			
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
			var content = "<table cellspacing='0' border='1' width='260'>"
					+ "<tr hidden='hidden'>"
					+ "<td>二级编号:<b id='scdCode' hidden='hidden'>${scdCode}</b></td>"
					+ "</tr>" + monitoring_info() + "</table>";
			var monitoring_point_info = new InfoTemplate();
			monitoring_point_info.setTitle("监测点信息");
			monitoring_point_info.setContent(content);
			var water_pollution_filed = [ "water_body" ];
			var monitoring_point_filed = [ "scdCode", "fstCode" ];
			var water_pollution_info = new InfoTemplate();
			water_pollution_info.setTitle("水体信息");
			water_pollution_info
					.setContent("<strong>水体名称:</strong>${water_body}<br>");
			var monitoring_point_layer = new FeatureLayer(monitor_points_Url
					+ "/0", {
				"opacity" : 1,
				outFields : monitoring_point_filed,
				infoTemplate : monitoring_point_info
			});
			var water_pollution_layer = new FeatureLayer(water_pollution_Url
					+ "/0", {
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

			$('#indexTree').tree({
				onClick: function(node){
					//alert(node.text);  // alert node text property when clicked
					//断面
					if(!$('#indexTree').tree('isLeaf',node.target)&&(node.id).substr(0,1)=="w"){
						selectWater(node.id);
						console.log(node.id);
					}else if($('#indexTree').tree('isLeaf',node.target)){
						selectMontoringpoints(node.id);
						console.log(node.id);
					}
				}
			});

			function monitoring_info() {
				var fstCode = $('#scdCode').text();
				console.log(fstCode);
				var monitor_inf = [ {
					"name" : "水温",
					"value" : "27℃"
				}, {
					"name" : "电导率",
					"value" : "4%"
				}, {
					"name" : "溶解氧",
					"value" : "0.6%"
				}, {
					"name" : "总磷",
					"value" : "7%"
				}, {
					"name" : "氨氮",
					"value" : "0.6%"
				}, {
					"name" : "盐度",
					"value" : "0.6%"
				}, {
					"name" : "色度",
					"value" : "0.6%"
				} ];
				var monitor_inf_length = getJsonObjLength(monitor_inf);
				var monitor_inf_Element = '';
				if (monitor_inf_length > 0) {
					monitor_inf_Element = "<tr style='text-align:center;'><td colspan='2'><b>水质监测指标</b></td></tr>";
					for (var i = 0; i < monitor_inf_length; i++) {
						if (Math.round(i % 2) === 0) {
							monitor_inf_Element += "<tr><td><strong>"
									+ monitor_inf[i].name + ":</strong>"
									+ monitor_inf[i].value + "</td>";
						} else {
							monitor_inf_Element += "<td><strong>"
									+ monitor_inf[i].name + ":</strong>"
									+ monitor_inf[i].value + "</td></tr>";
						}
					}
				}
				if (Math.round(monitor_inf_length % 2) != 0) {
					monitor_inf_Element += "<td>&nbsp;</td></tr>";
				}
				return monitor_inf_Element;
			}

			function getJsonObjLength(jsonObj) {
				var Length = 0;
				var item = 0;
				for (item in jsonObj) {
					Length++;
				}
				return Length;
			}
			function calcOffset() {
				return (map.extent.getWidth() / map.width);
			}
			
			function WaterISWhere(id) {
				var where = '';
				if(id!=null){
					var id_num=id.split('w')[1];
					where += "water_id"+"='"+id_num+"'";
				}
				return where;
			}
			function MontoringPiointISWhere(id) {
				var where = '';
				
				if(id!=null){
					var id_num=id.split('w')[1];
					where += "scdCode"+"='"+id_num+"'";
				}
				return where;
			}
			/**
			 * @param queryResult
			 * @returns
			 */
			function displayResult(queryResult, wkid,isPoint) { // 设置显示结果的符合颜色等
				map.graphics.clear();
				map.infoWindow.hide();
				var waterSymbol = new SimpleFillSymbol(
						SimpleFillSymbol.STYLE_SOLID, new SimpleLineSymbol(
								SimpleLineSymbol.STYLE_SOLID, new Color([ 0,
										255, 255 ]), 1), new Color([ 0, 255,
								255, 1 ]));
				var pointSymbol = new SimpleMarkerSymbol(
			            SimpleMarkerSymbol.STYLE_CIRCLE,
			            18, new SimpleLineSymbol(
			                SimpleLineSymbol.STYLE_NULL,
			                new Color(0, 255, 255, 1),
			                1), 
			            new Color([0, 229, 238, 1])
			        );
				if(isPoint==true){
					var pointGeometry = queryResult[0].feature.geometry;
					var x=pointGeometry.x;
					var y=pointGeometry.y;
					var location = new Point(x, y, new SpatialReference({wkid: wkid}));
			        map.centerAt(location);
			        var pointGraphic = new Graphic(location, pointSymbol);
			        map.graphics.clear();
			        map.infoWindow.hide();
			        map.graphics.add(pointGraphic);
			      
				}else{
					for ( var index in queryResult) {
						var feature = queryResult[index].feature;
						var waterGraphic = new Graphic(feature.geometry,
								waterSymbol);
						map.graphics.add(waterGraphic);
					}
					map.setExtent(getExtent(queryResult, wkid));
				}
				
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

			function selectWater(id) {
				var query = new Query();
				var queryTask = new QueryTask(water_pollution_Url + "/0");
				query.where = WaterISWhere(id);
				query.returnGeometry = true;
				query.maxAllowableOffset = 0.01;
				query.multipatchOption = "xyFootprint";
				query.num = 2000;
				query.outFields = water_pollution_filed;
				var queryResult = [];
				var isPoint=false;
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
							displayResult(queryResult, wkid,isPoint);
						} else {
							$.messager.alert('提示', '没有符合条件的水体', 'info');
						}
					}
				});
			}
			function selectMontoringpoints(id) {
				var query = new Query();
				var queryTask = new QueryTask(monitor_points_Url + "/0");
				query.where = MontoringPiointISWhere(id);
				query.returnGeometry = true;
				
<<<<<<< HEAD
				query.maxAllowableOffset = 0.0001;
=======
				query.maxAllowableOffset = 0.01;
>>>>>>> origin/master
				query.num = 2000;
				query.outFields = monitoring_point_filed;
				var isPoint=true;	
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
							displayResult(queryResult, wkid,isPoint);
						} else {
							$.messager.alert('提示', '没有符合条件的断面', 'info');
						}
					}
				});
			}
		});
