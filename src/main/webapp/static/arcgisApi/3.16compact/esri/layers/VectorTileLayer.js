// All material copyright ESRI, All Rights Reserved, unless otherwise specified.
// See http://js.arcgis.com/3.16/esri/copyright.txt for details.
//>>built
define("esri/layers/VectorTileLayer","require dojo/_base/declare dojo/_base/lang dojo/_base/url dojo/dom-construct dojo/dom-style dojo/has dojo/Deferred ../lang ../domUtils ../urlUtils ../kernel ../config ../request ../SpatialReference ../geometry/Extent ./layer ./TileInfo ./unitBezier".split(" "),function(O,A,h,P,E,Q,q,s,F,G,m,r,B,C,H,t,n,I,R){var D=A(n,{declaredClass:"esri.layers.VectorTileLayer",_mapsWithAttribution:["World_Basemap"],_eventMap:{"style-change":["style"]},constructor:function(a,
b){this._displayLevels=b?b.displayLevels:null;this._glStyleApplied=!1;this._serviceOverrides={};this._style=null;b&&(b.tileServers&&b.tileServers.length)&&(this._serviceOverrides.tileServers=b.tileServers.map(function(a){if(g.isMapboxUrl(a))return a;a=m.getAbsoluteUrl(a);var b=g.getTokenFromUrl(a);return b?b.url+"?token\x3d"+b.token:m.urlToObject(a).path},this));var c=a;"string"===typeof a&&(c=g.isMapboxUrl(a)?a:m.getAbsoluteUrl(a),this._serviceOverrides.credential=g.getTokenFromUrl(a));this.setStyle(c);
this.registerConnectEvents()},setStyle:function(a){if(a)return this._glStyleApplied=!1,this._serviceOverrides.credential="string"!==typeof a?null:g.getTokenFromUrl(a),this._loadStyle(a)},getStyle:function(){if(!this._style)return null;var a=JSON.parse(JSON.stringify(this._style.stylesheet)),b=a.sources;Object.keys(b).forEach(function(a){a=b[a];a.tiles=(a.tiles||[]).map(function(a){"string"!==typeof a&&(a=a.value);return a})});return a},opacity:1,setOpacity:function(a){if(this.opacity!=a)this.onOpacityChange(this.opacity=
a)},onOpacityChange:function(){},refresh:function(){},_loadStyle:function(a){return(new s).resolve().then(function(){var a=new s;null==q("ie")||9<q("ie")?k?k.supported()?a.resolve():a.reject(Error("layer not supported"),!0):O(["./vector-tile"],function(c){k=c;k.supported()?a.resolve():a.reject(Error("layer not supported"),!0)}):a.reject(Error("layer not supported"),!0);return a.promise}).then(function(){k.tokenHandler?u=k.tokenHandler:(u=new S,k.tokenHandler=u);this._serviceOverrides&&this._serviceOverrides.credential&&
u.addToken(this._serviceOverrides.credential);return g.loadMetadata(a,this._serviceOverrides)}.bind(this)).then(h.hitch(this,function(b){var c=b.layerDefinition;this.serviceUrl=b.serviceUrl||null;this.styleUrl=b.styleUrl||null;c?(this.spatialReference=c.initialExtent&&c.initialExtent.spatialReference&&new H(c.initialExtent.spatialReference),this.initialExtent=c.initialExtent&&new t(c.initialExtent),this.fullExtent=c.fullExtent&&new t(c.fullExtent),this.version=c.currentVersion,this.tileInfo=new I(c.tileInfo),
F.isDefined(c.minScale)&&!this._hasMin&&this.setMinScale(c.minScale),F.isDefined(c.maxScale)&&!this._hasMax&&this.setMaxScale(c.maxScale),c=null,a&&(c=m.urlToObject(b.serviceUrl).path.toLowerCase(),c=this._getDefaultAttribution(this._getMapName(c))),c&&(this.attributionDataUrl=c,this.hasAttributionData=!0)):(this.spatialReference=v,this.initialExtent=J,this.fullExtent=K,this.tileInfo=L,this.version=null);for(var c=this.tileInfo.lods,d=this.scales=[],e=this._displayLevels,f=-Infinity,g=Infinity,l,
h=0,T=c.length;h<T;h++)if(l=c[h],!e||-1!==e.indexOf(l.level))d[h]=l.scale,f=l.scale>f?l.scale:f,g=l.scale<g?l.scale:g;-Infinity!==f&&!this._hasMin&&this.setMinScale(f);Infinity!==g&&!this._hasMax&&this.setMaxScale(g);this._style=b.style;this.gl&&(k.identityManager=r.id,this._applyGLStyle(this._style));this.onStyleChange(this.getStyle())})).then(h.hitch(this,function(){!this.loaded&&!this.loadError&&(this.loaded=!0,this.onLoad(this))})).otherwise(h.hitch(this,function(a){this._errorHandler(a);throw a;
}))},_setMap:function(a,b,c){this.inherited(arguments);this._map=a;var d=this._div=E.create("div",null,b);Q.set(d,{position:"absolute",width:a.width+"px",height:a.height+"px",overflow:"visible",opacity:this.opacity});this._onResizeHandle=a.on("resize",h.hitch(this,this._onResizeHandler));this._onOpacityHandle=this.on("opacity-change",h.hitch(this,this._opacityChangeHandler));this._onScaleVisHandle=this.on("scale-visibility-change",h.hitch(this,function(){this._applyGLStyle(this._style)}));this._onVisibilityHandle=
this.on("visibility-change",h.hitch(this,function(){this._applyGLStyle(this._style)}));k.identityManager=r.id;this.gl=new k.Renderer({container:d});this.gl.setSize(a.width,a.height);this._applyGLStyle(this._style);this.evaluateSuspension();if(this.suspended&&!a.loaded)var e=a.on("load",h.hitch(this,function(){e.remove();this.evaluateSuspension()}));return d},_unsetMap:function(a,b){this.gl.remove();this.gl=null;this._glStyleApplied=!1;E.destroy(this._div);this._map=this._div=null;this._onResizeHandle=
this._onResizeHandle&&this._onResizeHandle.remove()&&null;this._onOpacityHandle=this._onOpacityHandle&&this._onOpacityHandle.remove()&&null;this._onScaleVisHandle=this._onScaleVisHandle&&this._onScaleVisHandle.remove()&&null;this._onVisibilityHandle=this._onVisibilityHandle&&this._onVisibilityHandle.remove()&&null;this._disableDrawConnectors();this._animation&&(this._animation.stop(),this._animation=null);this.inherited(arguments)},_applyGLStyle:function(a){if(!this._glStyleApplied){var b=this.gl;
b&&(a?this.visible&&this._isMapAtVisibleScale()&&(a.animationLoop=b.animationLoop,b.setStyle(a),a._loaded&&(Object.getOwnPropertyNames(a.sources).forEach(function(a){this.fire("source.add",{source:this.sources[a]})},a),a.fire("load"),a.sprite&&a.sprite.loaded()&&a.fire("change")),this._glStyleApplied=!0):b.setStyle(null))}},_enableDrawConnectors:function(){var a=this._map;a&&(this._panHandle=a.on("pan",h.hitch(this,this._onPanExtentChangeHandler)),this._extentChangeHandle=a.on("extent-change",h.hitch(this,
this._onPanExtentChangeHandler)),this._onScaleHandle=a.on("scale",h.hitch(this,this._onScaleHandler)))},_disableDrawConnectors:function(){this._onScaleHandle=this._onScaleHandle&&this._onScaleHandle.remove()&&null;this._panHandle=this._panHandle&&this._panHandle.remove()&&null;this._extentChangeHandle=this._extentChangeHandle&&this._extentChangeHandle.remove()&&null},_getZoom:function(a){var b=this.tileInfo.lods,c=null,d=null,e=0,f=b.length-1;for(e;e<f;e++){c=b[e];d=b[e+1];if(c.scale<=a)return c.level;
if(d.scale===a)return d.level;if(c.scale>a&&d.scale<a){e=e+1-(a-d.scale)/(c.scale-d.scale);e=Math.ceil(e)-Math.log(Math.abs(Math.ceil(e)-e+1))/Math.LN2;if(0.995<e-Math.floor(e)||0.0050>e-Math.floor(e))e=Math.round(e);return b[e].level}}return a>b[0].scale?b[0].level:b[b.length-1].level},_isMapAtVisibleScale:function(){var a=this.inherited(arguments);if(a){for(var b=this._map,a=this.scales,c=b.getScale(),d=!1,b=b.width>b.height?b.width:b.height,e=0,f=a.length;e<f;e++)if(Math.abs(a[e]-c)/a[e]<1/b){d=
!0;break}a=d}return a},_getMapName:function(a){return(a=a.match(/^https?\:\/\/(basemaps|basemapsbeta)\.arcgis\.com\/arcgis\/rest\/services\/([^\/]+(\/[^\/]+)*)\/vectortileserver/i))&&a[2]},_getDefaultAttribution:function(a){if(a){var b;a=a.toLowerCase();for(var c=0,d=this._mapsWithAttribution.length;c<d;c++)if(b=this._mapsWithAttribution[c],-1<b.toLowerCase().indexOf(a))return"file:"===window.location.protocol?"http:":window.location.protocol+"//static.arcgis.com/attribution/Vector/"+b}},onStyleChange:function(a){},
_opacityChangeHandler:function(a){this.gl&&(this._div.style.opacity=a.opacity)},_onResizeHandler:function(a){if(this.gl){var b=a.extent.getCenter();this.gl.setSize(a.width,a.height);this.gl.jumpTo({center:[b.getLongitude(),b.getLatitude()]});this._div.style.width=a.width+"px";this._div.style.height=a.height+"px"}},onSuspend:function(){this.inherited(arguments);G.hide(this._div);this._disableDrawConnectors()},onResume:function(){this.inherited(arguments);if(this.gl&&this._style){G.show(this._div);
var a=this._map,b=this._getZoom(a.getScale()),a=a.extent.getCenter();this._animate(a,b,!0)}this._enableDrawConnectors()},_onPanExtentChangeHandler:function(a){var b=this._getZoom(this._map.getScale());a=a.extent.getCenter();this._animate(a,b,!0)},_onScaleHandler:function(a){var b=this._map,c=b._zoomAnimDiv.anchor,d=b._zoomAnimDiv.extent.getCenter(),b=this._getZoom(b._zoomAnimDiv.newLod.scale,b._zoomAnimDiv.newLod.level);this._animate(d,b,a.immediate,c)},_animate:function(a,b,c,d){this._animation&&
(this._animation.stop(),this._animation=null);this._animation=U(this.gl,a.getLongitude(),a.getLatitude(),b,c,this._map,d)}}),k=null,u=null;n=Object.freeze||function(a){};for(var w=[],p=0;20>p;p++){var x=78271.51696402048/Math.pow(2,p);w.push({level:p,scale:Math.floor(3779.527559055118*x),resolution:x})}var L=new I({rows:512,cols:512,dpi:96,format:"pbf",origin:{x:-2.0037508342787E7,y:2.0037508342787E7},spatialReference:{wkid:102100},lods:w});n(L);var v=new H(102100);n(v);var J=new t(-2.003750834E7,
-2.003750834E7,2.003750834E7,2.003750834E7,v);n(J);var K=new t(-2.003750834E7,-2.003750834E7,2.003750834E7,2.003750834E7,v);n(K);var y=function(){var a,b=window.performance||{},c=b.now||b.webkitNow||b.msNow||b.oNow||b.mozNow;if(void 0!==c)return function(){return c.call(b)};a=window.performance&&window.performance.timing&&window.performance.timing.navigationStart?window.performance.timing.navigationStart:(new Date).getTime();return function(){return(new Date).getTime()-a}}();n=q("ff");var w=q("ie"),
p=q("webkit"),x=q("opera"),M=(new Date).getTime(),z=window.requestAnimationFrame;z||(z=window[(p&&"webkit"||n&&"moz"||x&&"o"||w&&"ms")+"RequestAnimationFrame"])||(z=function(a){var b=y(),c=Math.max(0,16-(b-M)),d=window.setTimeout(function(){a(y())},c);M=b+c;return d});var V=R.ease,U=function(a,b,c,d,e,f,g){if(e=e||0===B.defaults.map.zoomDuration)return a.jumpTo({center:[b,c],zoom:Math.ceil(d)-Math.log(Math.abs(Math.ceil(d)-d+1))/Math.LN2}),null;var l=!0,h=B.defaults.map.zoomDuration,k=a.transform.center.lat,
m=a.transform.center.lng,n=a.transform.zoom,q=y()+16,p=g?[g.x-f.width/2,g.y-f.height/2]:null,r=function(){if(l){var e=(y()+16-q)/h;1<=e&&(e=1,l=!1);var e=V(e),f=n+(d-n)*e,f=Math.ceil(f)-Math.log(Math.abs(Math.ceil(f)-f+1))/Math.LN2;p?a.zoomTo(f,{animate:!1,offset:p}):a.jumpTo({center:[m+(b-m)*e,k+(c-k)*e],zoom:f});l&&z(r)}};r();return{stop:function(){l=!1}}},N=A(String,{constructor:function(a,b){this.value=a;this.token=b},valueOf:function(){var a=this.value,b=this.token;if(!b){var c=r.id&&r.id.findCredential(a);
c&&c.token&&(b=c.token)}b&&(a+=(-1===a.indexOf("?")?"?":"\x26")+"token\x3d"+b);return a},toString:function(){return this.valueOf()},replace:function(a,b){return String.prototype.replace.call(this.valueOf(),a,b)}}),g={loadMetadata:function(a,b){var c=null,d=null,e=b&&b.credential;return(new s).resolve(a).then(function(){k.config.ACCESS_TOKEN=D.ACCESS_TOKEN;if("string"!==typeof a)return a;g.isMapboxUrl(a)?(d=a,c=k.normalizeStyleURL(a)):d=c=m.normalize(a).replace(/\/*$/,"");g._corsify(c);c=g._appendToken(c,
e);return C({url:c,content:{f:"json"},handleAs:"json"})}).then(function(a){return g._processMetadata(d,a,b)}).then(function(a){return g._loadStyle(a,b)})},isMapboxUrl:function(a){return-1<a.search(/^mapbox:\/\/styles\//)},getTokenFromUrl:function(a){var b;g.isMapboxUrl(a)||(a=m.urlToObject(a),a.query&&a.query.token&&(b={url:a.path,token:a.query.token}));return b},_appendToken:function(a,b){return!b||!b.token?a:a+=(-1===a.indexOf("?")?"?":"\x26")+"token\x3d"+b.token},_configureStyle:function(a,b){var c=
a.layerDefinition,d=a.style,e=a.serviceUrl,f=a.styleUrl,h=g._getAbsolutePath,l=g._corsify;if(c&&d&&d.sources.esri){var k=c.tilejson||"2.0.0",m=c.tileInfo&&c.tileInfo.format||"pbf",n=c.tileMap?l(h(c.tileMap,e)):null,p=(c.tiles||[]).map(function(a){return new N(g._getAbsolutePath(a.valueOf(),e),b&&b.credential&&b.credential.token)});d.sources.esri={type:"vector",scheme:"xyz",tilejson:k,format:m,index:n,tiles:p,description:c.description,name:c.name};p.forEach(l);d.glyphs=l(h(d.glyphs,f));d.sprite=l(h(d.sprite,
f))}return{style:d,layerDefinition:c,serviceUrl:e,styleUrl:f}},_loadStyle:function(a,b){var c=new s,d=a.style,e=d.sources;b&&b.tileServers&&Object.getOwnPropertyNames(e).forEach(h.hitch(this,function(c){c=e[c];var d=b.tileServers.map(function(c){return new N(g._getAbsolutePath(c,a.serviceUrl,b))});c.tiles=d;d.forEach(g._corsify)}));k.identityManager=r.id;var d=new k.Style(d),f=function(){d.off("load",f);d.off("error",m);a.style=d;c.resolve(a)},m=function(a){d.off("load",f);d.off("error",m);c.reject(a)};
d.on("load",f);d.on("error",m);return c.promise},_getAbsolutePath:function(a,b){var c;b=m.urlToObject(b||"").path;if(/^https?:\/\//i.test(a))c=a;else{if(0===a.indexOf("//"))return location.protocol+a;b=b.replace(/(\/+\w+\.\w+)$/,"");/\/+$/.test(b)||(b+="/");0===a.indexOf("/")&&(a=a.substring(1));c=b+a}return m.normalize(c)},_corsify:function(a){a=a.valueOf();var b=B.defaults.io.corsEnabledServers;if(!m.canUseXhr(a)){var c=new P(a),c=(c.host+(c.port?":"+c.port:"")).toLowerCase();-1===b.indexOf(c)&&
b.push(c)}return a},_processMetadata:function(a,b,c){var d={},e,f,k=g._getAbsolutePath,l=g._configureStyle,m=g._corsify,n=c&&c.credential;delete b._ssl;if(b.currentVersion)return e=a,f=k(b.defaultStyles,e),C({url:g._appendToken(f,n),content:{f:"json"},handleAs:"json"}).then(h.hitch(this,function(a){return l({style:a,layerDefinition:b,styleUrl:f,serviceUrl:e},c)}));d=b;f=a;return b.sources.esri&&b.sources.esri.url?(e=m(k(b.sources.esri.url,f)),C({url:g._appendToken(e,n),content:{f:"json"},handleAs:"json"}).then(h.hitch(this,
function(a){return l({style:d,layerDefinition:a,styleUrl:f,serviceUrl:e},c)}))):l({style:d})}},S=A([],{constructor:function(){this._credentials=[]},addToken:function(a){if(!a||!a.url||!a.token)return!1;var b=this.getServiceRoot(a.url);this._credentials.push({rootUrl:b,token:a.token})},findCredential:function(a){var b=-1,c=this._credentials,d=this.getServiceRoot(a);c.some(function(a,c){if(a.rootUrl===d)return b=c,!0});return-1<b?c[b]:null},getServiceRoot:function(a){var b=/(.+\/rest\/services\/.*\/?vectortileserver)/i,
c=/(.+\/sharing\/.*)/i;return b.test(a)?a.match(b)[1].toLowerCase():c.test(a)?a.match(c)[1].toLowerCase():null},shareSameService:function(a,b){a=this.getServiceRoot(a);b=this.getServiceRoot(b);a=a.substr(a.indexOf(":"));b=b.substr(b.indexOf(":"));return a===b}});D.ACCESS_TOKEN=null;return D});