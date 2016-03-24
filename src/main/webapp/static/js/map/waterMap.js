/**
 * 2016.03.04 author by tangweilong
 */
var wkid = 4490;
// var serviceUrl = "http://localhost:6080/arcgis/rest/services/";
var serviceUrl = "http://10.215.201.151:6080/arcgis/rest/services/";
// var serviceUrl = "http://127.0.0.1:6080/arcgis/rest/services/";
var monitor_points_Url = serviceUrl + "monitor_points/MapServer";
var water_pollution_Url = serviceUrl + "water_pollution/MapServer";
var haikou_region_Url= serviceUrl +"haikou_region/MapServer";
var mapSpatialReference='' ;
require(
		[ "esri/map", "esri/layers/WebTiledLayer", "esri/geometry/Extent",
				"esri/geometry/Point", "esri/layers/TileInfo", "dojo/parser",
				"esri/dijit/OverviewMap", "esri/SpatialReference",
				"esri/layers/ArcGISDynamicMapServiceLayer",
				"esri/toolbars/navigation", "esri/layers/FeatureLayer",
				"esri/InfoTemplate", "dojo/on", "dojo/dom",
				"esri/dijit/Legend", "esri/dijit/HomeButton",
				"esri/symbols/SimpleFillSymbol",
				"esri/symbols/SimpleMarkerSymbol",
				"esri/symbols/SimpleLineSymbol", "esri/Color", "esri/graphic",
				"esri/tasks/query", "esri/tasks/QueryTask",
				"esri/dijit/Scalebar", "dijit/layout/TabContainer",
				"dijit/layout/ContentPane", "esri/dijit/InfoWindow",
				"dojo/dom-construct","dijit/registry",
				"CustomModules/geometryUtils", "dijit/Toolbar", "dojo/domReady!" ],
		function(Map, WebTiledLayer, Extent, Point, TileInfo, parser,
				OverviewMap, SpatialReference, ArcGISDynamicMapServiceLayer,
				Navigation, FeatureLayer, InfoTemplate, on, dom, Legend,
				HomeButton, SimpleFillSymbol, SimpleMarkerSymbol,
				SimpleLineSymbol, Color, Graphic, Query, QueryTask, Scalebar,
				TabContainer, ContentPane, InfoWindow, domConstruct,
				registry,geometryUtils) {
			var infoWindow = new InfoWindow(null, domConstruct.create("div"));
			infoWindow.startup();
			parser.parse();
			mapSpatialReference = new SpatialReference({"wkt": 'PROJCS["CGCS_2000_3_Degree_GK_CM_111E",GEOGCS["CGCS_2000",DATUM["CGCS_2000",SPHEROID["CGCS_2000",6378137.0,298.257222101]],PRIMEM["Greenwich",0.0],UNIT["Degree",0.0174532925199433]],PROJECTION["Gauss_Kruger"],PARAMETER["False_Easting",500000.0],PARAMETER["False_Northing",0.0],PARAMETER["Central_Meridian",111.0],PARAMETER["Scale_Factor",1.0],PARAMETER["Latitude_Of_Origin",0.0],UNIT["Meter",1.0]]'
			});
			var bounds = new Extent({
				"xmin" : 416663.40979999956,
				"ymin" : 2205915.9924,
				"xmax" : 445812.31259999983,
				"ymax" : 2221406.5243999995,
				"spatialReference" : mapSpatialReference
			});
			var map = new Map("map", {
				zoom : 16,
				extent : bounds,
				infoWindow : infoWindow,
				slider:false,
				logo : false
			});
			map.infoWindow.resize(400, 300);

// var home = new HomeButton({
// map : map
// }, "homeButton");
// home.startup();
			var scalebar = new Scalebar({ // 比例尺
				map : map,
				attachTo : "bottom-left",
				scalebarUnit : "metric",
				scalebarStyle : "ruler"
			});

			/**
			 * 鹰眼图
			 */
// var overviewMapDijit = new OverviewMap({
// map : map,
// attachTo : "bottom-left",
// visible : true
// }, dom.byId("overViewMap"));
// overviewMapDijit.startup();
			toolBar(map);

			/**
			 * 定义弹窗
			 */
			var monitoring_point_info = new InfoTemplate();
			monitoring_point_info.setTitle("监测点信息");
			monitoring_point_info.setContent(getMonitoringPointContent);
			var water_pollution_filed = [ "water_body","water_id" ];
			var monitoring_point_filed = [ "scdCode", "water_body",
					"section_name", "section_position", "section_condition" ];
			var water_pollution_info = new InfoTemplate();
			water_pollution_info.setTitle("水体信息");
			water_pollution_info.setContent(getWaterContent);
			var monitoring_point_layer = new FeatureLayer(monitor_points_Url
					+ "/0", {
				"opacity" : 0,
				outFields : monitoring_point_filed,
				infoTemplate : monitoring_point_info
			});
			var water_pollution_Dynamiclayer = new ArcGISDynamicMapServiceLayer(water_pollution_Url,{
				"id": "layer0",
		        "opacity": 1
			});
//			water_pollution_Dynamiclayer.setInfoTemplates({
//			        0: { infoTemplate: water_pollution_info }
//			      });
			var water_pollution_layer = new FeatureLayer(water_pollution_Url
					+ "/0", {
				"opacity" : 0,
				outFields : water_pollution_filed,
				infoTemplate : water_pollution_info
			});
			var monitoring_point_Dynamiclayer= new ArcGISDynamicMapServiceLayer(monitor_points_Url,{
				"id": "layer1",
		        "opacity": 1
			});
//			monitoring_point_Dynamiclayer.setInfoTemplates({
//			        0: { infoTemplate: monitoring_point_info}
//			      });
			var haikou_region_Dynamiclayer = new ArcGISDynamicMapServiceLayer(
					haikou_region_Url,{
						"id": "layer2"
					});
			
			

			var subNodes = [];
			var visible = [];
			var layers = [{"layer": water_pollution_Dynamiclayer,"name":"水体","id":2},
			          {"layer": monitoring_point_Dynamiclayer,"name":"监测点","id":2},
			          {"layer": haikou_region_Dynamiclayer,"name":"区划","id":13},
			          {"layer":monitoring_point_layer },{"layer":water_pollution_layer}];
			 for (let i = 0; i < layers.length; i++) {
				 if(i<3){
		            if (layers[i].layer.loaded) {
		              buildLayerList(layers[i].layer);
		            } else {
		              dojo.connect(layers[i].layer, "onLoad", buildLayerList);
		            }
				 } 
		            // 添加到地图控件进行显示
		            map.addLayer(layers[i].layer);
		          }
//			 var legend = new Legend({
//					map : map,
//					layerInfos : [ {
//						layer : monitoring_point_Dynamiclayer,
//						title : "监测点"
//					}, {
//						layer : water_pollution_Dynamiclayer,
//						title : "监测水体"
//					} ,{
//						layer : haikou_region_Dynamiclayer,
//						title : "区划"
//					}]
//				}, "legend");
//				legend.startup();
			isJump();
			
			function isJump() {
				var waterId = $("#map_waterId").val();
				var isLeaf = $("#map_isLeaf").val();
// var Request=getRequest();
// var waterId = Request["waterId"]; // 取出参数
// var isLeaf = Request["isLeaf"];
				if (waterId != "" && isLeaf != "" && waterId != 0 && isLeaf !=0) {
					if (isLeaf == "true") {
						selectMontoringpoints(waterId);
						console.log(0);
					} else if(isLeaf == "false") {
						selectWater(waterId);
					}
				}
			}
			function toolBar(map){
				/**
				 * 工具栏
				 */
				var navToolbar = new Navigation(map);
				on(navToolbar, "onExtentHistoryChange", extentHistoryChangeHandler);

				registry.byId("zoomin").on("click", function() {
					navToolbar.activate(Navigation.ZOOM_IN);
				});

				registry.byId("zoomout").on("click", function() {
					navToolbar.activate(Navigation.ZOOM_OUT);
				});

				registry.byId("zoomfullext").on("click", function() {
					navToolbar.zoomToFullExtent();
				});

				registry.byId("zoomprev").on("click", function() {
					navToolbar.zoomToPrevExtent();
				});

				registry.byId("zoomnext").on("click", function() {
					navToolbar.zoomToNextExtent();
				});

				registry.byId("pan").on("click", function() {
					navToolbar.activate(Navigation.PAN);
				});

				registry.byId("deactivate").on("click", function() {
					navToolbar.deactivate();
				});
			}
			
			function extentHistoryChangeHandler() {
				registry.byId("zoomprev").disabled = navToolbar.isFirstExtent();
				registry.byId("zoomnext").disabled = navToolbar.isLastExtent();
			}
			
			function getWaterContent(graphic) {
				var waterTab = new TabContainer({
					style : "width:100%;height:100%;class:claro"
				}, domConstruct.create("div"));
				var content_Info = "<strong>水体名称:</strong>"
					+ graphic.attributes.water_body;
				var contentInfo = new ContentPane({
					title : "基本信息",
					content:content_Info
				});
				var contentMedia = new ContentPane({
					title : "水体水文信息"
				});

				var contentFiles = new ContentPane({
					title : "水体综合信息"
				});
				waterTab.addChild(contentInfo);
				waterTab.addChild(contentMedia);
				waterTab.addChild(contentFiles);
				return waterTab.domNode;
			}
			function getMonitoringPointContent(graphic) {
				// Make a tab container.
				var scdCode = graphic.attributes.scdCode;
				var content_Info = "<strong>监测站名称:</strong>"
						+ graphic.attributes.section_name + "<br>"
						+ "<strong>监测站位置:</strong>"
						+ graphic.attributes.section_position + "<br>"
						+ "<strong>水体名称:</strong>"
						+ graphic.attributes.water_body + "<br>"
						+ "<strong>监测站情况:</strong>"
						+ graphic.attributes.section_condition + "<br>"
						+ "<strong>二级编号:</strong>" + scdCode;

				var content_Monitor = monitoring_info(1401);
				var pointTab = new TabContainer({
					style : "width:100%;height:100%;"
				}, domConstruct.create("div"));
				var contentInfo = new ContentPane({
					title : "基本信息",
					content : content_Info
				});
				var contentMonitor = new ContentPane({
					title : "监测信息",
					content : content_Monitor
				});
				var contentMedia = new ContentPane({
					title : "多媒体信息"
				});
				var contentFiles = new ContentPane({
					title : "档案信息"
				});
				pointTab.addChild(contentInfo);
				pointTab.addChild(contentMonitor);
				pointTab.addChild(contentMedia);
				pointTab.addChild(contentFiles);
				return pointTab.domNode;
			}
			function monitoring_info(id) {
				var monitor_inf = '';
				var monitor_inf_length = 0;
				var monitor_inf_Element = '';
				$.ajax({
					url : "/wqm/show/getMonitorDataById",
					type : 'GET',
					async : false,
					dataType : 'json',
					data : {
						"id" : id,
					},
					success : function(data, status) {
						console.log(data);
						monitor_inf = data;
						monitor_inf_length = monitor_inf.length;
						monitor_inf_Element = getMonitorInfElement(monitor_inf,
								monitor_inf_length);

					},
					error : function(data, status, e) {
						console.log("e:" + e);
						console.log("status:" + status);
					}
				});
				return monitor_inf_Element;
			}
			function getMonitorInfElement(monitor_inf, monitor_inf_length) {
				var monitor_inf_Element = '';
				if (monitor_inf_length > 0) {
					monitor_inf_Element = "<table class='infowindow_tab'>";
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
				monitor_inf_Element += "</table>";
				console.log(monitor_inf_Element);
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
				if (id != null) {
					var id_num = id.split('w')[1];
					where += "water_id" + "='" + id_num + "'";
				}
				return where;
			}
			function MontoringPiointISWhere(id) {
				var where = '';

				if (id != null) {
					var id_num = id.split('w')[1];
					where += "scdCode" + "='" + id_num + "'";
				}
				return where;
			}
			/**
			 * @param queryResult
			 * @returns
			 */
			function displayResult(queryResult, mapSpatialReference, isPoint) { // 设置显示结果的符合颜色等
				map.graphics.clear();
				map.infoWindow.hide();
				var waterSymbol = new SimpleFillSymbol(
									SimpleFillSymbol.STYLE_SOLID, 
									new SimpleLineSymbol(
											SimpleLineSymbol.STYLE_SOLID, 
											new Color([ 238,238, 0 ]),
											1
											), 
									new Color([ 238, 238, 0,
									1 ]));
				var pointSymbol = new SimpleMarkerSymbol(
						SimpleMarkerSymbol.STYLE_CIRCLE, 0,
						new SimpleLineSymbol(SimpleLineSymbol.STYLE_NULL,
								new Color(0, 255, 255, 1), 1), new Color([ 0,
								229, 238, 1 ]));
				if (isPoint == true) {
					var pointGeometry = queryResult[0].feature.geometry;
					var x = pointGeometry.x;
					var y = pointGeometry.y;
					var location = new Point(x, y, mapSpatialReference);
					map.centerAt(location);
					var pointGraphic = new Graphic(location, pointSymbol);
					map.graphics.add(pointGraphic);
					map.infoWindow.setTitle("监测站信息");
					map.infoWindow.setContent(getJumpMonitoringPointContent(queryResult[0].feature.attributes));
					map.infoWindow.show(location);

				} else {
					for ( var index in queryResult) {
						var feature = queryResult[index].feature;
						var waterGraphic = new Graphic(feature.geometry,
								waterSymbol);
						map.graphics.add(waterGraphic);
					}
					var extent=getExtent(queryResult, mapSpatialReference);
					map.setExtent(extent);
					var labelPt = geometryUtils.getPolygonCenterPoint(queryResult[0].feature.geometry);
					map.infoWindow.setTitle("水体信息");
					map.infoWindow.setContent(getJumpWaterContent(queryResult[0].feature.attributes));
				    map.infoWindow.show( map.toScreen(labelPt));
				}
				
			}
			function getJumpMonitoringPointContent(attributes) {
				// Make a tab container.
				var scdCode = attributes.scdCode;
				var content_Info = "<strong>监测站名称:</strong>"
						+ attributes.section_name + "<br>"
						+ "<strong>监测站位置:</strong>"
						+ attributes.section_position + "<br>"
						+ "<strong>水体名称:</strong>"
						+ attributes.water_body + "<br>"
						+ "<strong>监测站情况:</strong>"
						+ attributes.section_condition + "<br>"
						+ "<strong>二级编号:</strong>" + scdCode;
				var content_Monitor = monitoring_info(1401);
				var pointTab = new TabContainer({
					style : "width:100%;height:100%;"
				}, domConstruct.create("div"));
				var contentInfo = new ContentPane({
					title : "基本信息",
					content : content_Info
				});
				var contentMonitor = new ContentPane({
					title : "监测信息",
					content : content_Monitor
				});
				var contentMedia = new ContentPane({
					title : "多媒体信息"
				});
				var contentFiles = new ContentPane({
					title : "档案信息"
				});
				pointTab.addChild(contentInfo);
				pointTab.addChild(contentMonitor);
				pointTab.addChild(contentMedia);
				pointTab.addChild(contentFiles);
				return pointTab.domNode;
			}
			
			function getChildrenNodes(parentnodes, node) {
		          for (let i = parentnodes.length - 1; i >= 0; i--) {
		            var pnode = parentnodes[i];
		            // 如果是父子关系，为父节点增加子节点，退出for循环
		            if (pnode.id == node.pid) {
		              pnode.state = "closed";// 关闭二级树
		              pnode.children.push(node);
		              return;
		            } else {
		              // 如果不是父子关系，删除父节点栈里当前的节点，
		              // 继续此次循环，直到确定父子关系或不存在退出for循环
		              parentnodes.pop();
		            }
		          }
		        }
		    function buildLayerList(layer) {
		          // 构建图层树形结构
		        console.log("构建节点");	
		        var id = 0;
		        var name = "";
		        for (let i = 0; i < layers.length; i++) {
		            if (layer == layers[i].layer) {
		              id = layers[i].id;
		              name = layers[i].name;
		              break;
		            }
		          }	
		          var layerinfos = layer.layerInfos;
		          //console.log(layerinfos);
		          // var treeList = [];//jquery-easyui的tree用到的tree_data.json数组
		          var parentnodes = [];// 保存所有的父亲节点
		          var pnode = {"id": "node" & id, "text": name, "children": []};// 增加一个根节点
		          console.log(layerinfos.length);
		          console.log(pnode);
		          
		          var node = {};
		          
		          if (layerinfos !=null && layerinfos.length > 0) {
		        	  console.log("002");
		            for (let z = 0, j = layerinfos.length; z < j; z++) {
		              var info = layerinfos[z];
		              if (info.defaultVisibility) {
		                visible.push(info.id);
		              }
		              // node为tree用到的json数据
		              node = {
		                "id": info.id,
		                "text": info.name,
		                "pid": info.parentLayerId,
		                "checked": info.defaultVisibility ? true : false,
		                "attr":layer.id,
		                "children": []
		              };
		              if (info.parentLayerId == -1) {
		                parentnodes.push(node);
		                pnode.children.push(node);
		              } else {
		                getChildrenNodes(parentnodes, node);
		                parentnodes.push(node);
		              }
		            }
		            console.log("加载节点");
		            subNodes.push(pnode);
		          }
		          if(subNodes[2]!=undefined&&subNodes[0]!=undefined&&subNodes[1]!=undefined){
		          var root = {
		            "id": "rootnode", "text": "海口市", "children": [
		              {
		                "id": 1,
		                "text": "基础地理数据",
		                "children": [{
		                  "id": 11,
		                  "text": "影像图"
		                },
		                  {
		                    "id": 12,
		                    "text": "道路",
		                    "checked": true,
		                  },
		                  {
		                    "id": 13,
		                    "text": "行政区划",
		                    "checked": true,
		                    "children": [subNodes[2]],
		                  },
		                  {
		                    "id": 14,
		                    "text": "地名",
		                    "value": "anno",
		                    "checked": true,
		                    "children":[]
		                  }
		                ]
		              },
		              {
		                "id": 2,
		                "text": "水资源",
		                "checked": true,
		                "children": [subNodes[0],subNodes[1]]
		              }
		            ]
		          };
		          addTree(root);
		          }
		        }

		        function addTree(root) {
		          var treeList = [];// jquery-easyui的tree用到的tree_data.json数组
		          treeList.push(root);
		          // jquery-easyui的树
		          $('#toc').tree({
		            data: treeList,
		            checkbox: true, // 使节点增加选择框
		            onCheck: function (node, checked) {// 更新显示选择的图层
		            	var nodes = $('#toc').tree("getChecked") ;
		                setVisibleLayer("layer0",nodes);
		                setVisibleLayer("layer1",nodes);
		                setVisibleLayer("layer2",nodes);
		            }
		          });
		        }

		        function isLeaf(node) {
		          return $(node).tree('isLeaf', node.target);
		        }
		        
		        function setVisibleLayer(name,nodes){
		            var visible1=[];
		            dojo.forEach(nodes, function(node) {
		              if(node.attr==name&&isLeaf(node)==true){
		                visible1.push(node.id);
		              }
		            });

		            if (visible1.length === 0) {
		              visible1.push(-1);
		            }
		            console.log(visible1);
		            var layer=map.getLayer(name);
		            layer.setVisibleLayers(visible1);
		          } 
			
			/**
			 * 获取结果集的范围
			 */
			function getExtent(queryResult, mapSpatialReference) {
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
					"spatialReference":mapSpatialReference
				});
			}
			
			function getMonitoringPointContent(graphic) {
				// Make a tab container.
				var scdCode = graphic.attributes.scdCode;
				var content_Info = "<strong>监测站名称:</strong>"
						+ graphic.attributes.section_name + "<br>"
						+ "<strong>监测站位置:</strong>"
						+ graphic.attributes.section_position + "<br>"
						+ "<strong>水体名称:</strong>"
						+ graphic.attributes.water_body + "<br>"
						+ "<strong>监测站情况:</strong>"
						+ graphic.attributes.section_condition + "<br>"
						+ "<strong>二级编号:</strong>" + scdCode;

				var content_Monitor = monitoring_info(1401);
				var pointTab = new TabContainer({
					style : "width:100%;height:100%;"
				}, domConstruct.create("div"));
				var contentInfo = new ContentPane({
					title : "基本信息",
					content : content_Info
				});
				var contentMonitor = new ContentPane({
					title : "监测信息",
					content : content_Monitor
				});
				var contentMedia = new ContentPane({
					title : "多媒体信息"
				});
				var contentFiles = new ContentPane({
					title : "档案信息"
				});
				pointTab.addChild(contentInfo);
				pointTab.addChild(contentMonitor);
				pointTab.addChild(contentMedia);
				pointTab.addChild(contentFiles);
				return pointTab.domNode;
			}
			function getJumpWaterContent(attributes) {
				var waterTab = new TabContainer({
					style : "width:100%;height:100%;class:claro"
				}, domConstruct.create("div"));
				var content_Info = "<strong>水体名称:</strong>"
					+ attributes.water_body;
				var contentInfo = new ContentPane({
					title : "基本信息",
					content:content_Info
				});
				var contentMedia = new ContentPane({
					title : "水体水文信息"
				});

				var contentFiles = new ContentPane({
					title : "水体综合信息"
				});
				waterTab.addChild(contentInfo);
				waterTab.addChild(contentMedia);
				waterTab.addChild(contentFiles);
				return waterTab.domNode;
			}
			
			function selectWater(id) {
				var query = new Query();
				var queryTask = new QueryTask(water_pollution_Url + "/0");
				query.where = WaterISWhere(id);
				query.returnGeometry = true;
				query.maxAllowableOffset = 0.000001;
				query.num = 2000;
				query.outFields = water_pollution_filed;
				var queryResult = [];
				var isPoint = false;
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
							displayResult(queryResult,mapSpatialReference, isPoint);
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
				query.maxAllowableOffset = 0.0001;
				query.num = 2000;
				query.outFields = monitoring_point_filed;
				var isPoint = true;
				var queryResult = [];
				queryTask.execute(query, function(results) {
					if (results.features) {
						for ( var index in results.features) {
							var feature = results.features[index];
							var result = {
								feature : feature
							};
							queryResult.push(result);
						}
						if (queryResult.length > 0) {
							displayResult(queryResult,mapSpatialReference, isPoint);
						} else {
							$.messager.alert('提示', '没有符合条件的监测站', 'info');
						}
					}
				});
			}
		});
