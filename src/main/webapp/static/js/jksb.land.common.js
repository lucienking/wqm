
/**
 * 国土管理系统公共 js方法
 * 
 * @author wangxj
 */

var ctx ="${ctx}";
/**
 * 删除左右两端的空格 
 */
function trim(str){ 
	return str.replace(/(^\s*)|(\s*$)/g, ""); 
} 

/**
 * 判断是否为空
 */
function isNullOrEmpty(strVal) {
	strVal = trim(strVal);
	if (strVal == "" || strVal == null || strVal == undefined) {
		return true;
	} else {
		return false;
	}
}
/**
 * 获取form 的参数
 * @param $
 */
(function($) {
	$.fn.extend({
		getFormData : function() {
			var tagName = $(this)[0].tagName;
			if(tagName != 'FORM') {
				throw new Error('Not a form node.');
			}
			var data = {};
			var array = $(this).serializeArray();
			$.each(array, function() {
				var name = $(this).attr('name');
				if(!isNullOrEmpty(this.value))
				if(name.indexOf('.') != -1) {
					var nameArr = name.split('.');
					if(!data[nameArr[0]]) {
						data[nameArr[0]] = {};
					} 
					data[nameArr[0]][nameArr[1]] = this.value;
				} else {
					data[name] = this.value;
				}
			});
			return data;
		}
	});
})(jQuery);

/**
 * Ajax 请求时，判断session失效，并跳转登录。
 */
jQuery(function($){
    
    var _ajax = $.ajax;   // 备份jquery的ajax方法  
    
    // 重写ajax方法，先判断登录在执行success函数 
    $.ajax=function(opt){
    	var _success = opt && opt.success || function(a, b){};
    	var _error = opt && opt.error || function(a, b){};
        var _opt = $.extend(opt, {
        	success:function(XMLHttpRequest, textStatus){
        	/* if(XMLHttpRequest.message != undefined) {
	        		$.messager.alert({
            			title:'操作提示',
            			msg:"<div style='text-align:center;width:100%;'>"+XMLHttpRequest.message+"</div>",
            			fn:function(){_success(XMLHttpRequest, textStatus);}
            		});
        		}else{ 
        			_success(XMLHttpRequest, textStatus); 
        		}*/
        	   _success(XMLHttpRequest, textStatus); 
            },
            error:function(data, textStatus){
            	if( data.status == "0" && data.readyState == "0"){
            		$.messager.alert({
            			title:'操作失败',
            			msg:'登录失效，请重新登录。',
            			fn:function(){window.location.href = ctx+"/login";}
            		});
            	 	return;
            	}else{ 
            		_error(data, textStatus);
            	}
            }
        });
        _ajax(_opt);
    };
});

/**
 * 以弹出框打开
 * @param element
 */
function openIframeWindow(element) {
	$iframeWindow.show({
		title : $(element).attr("title"),
		id : "newIframeWindow",
		width : $(element).attr("width") || 600,
		height : $(element).attr("height") || 500,
		closed : false,
		cache : false,
		collapsible : false,
		minimizable : false,
		url : $(element).attr("url"),
		modal : true
	});
	var ev = arguments.callee.caller.arguments[0] || window.event;
	if (ev.stopPropagation) {
		ev.stopPropagation();
	} else {
		ev.cancelBubble = true;
	}
}

var $iframeWindow = {
		show : function(options) {
			var id = options.id;
			var length = $("#" + id).length;
			var _options = {
				cache : false,
				onClose : function() {
					$("#" + id).window('destroy');
				}
			};

			$.extend(_options, options);

			if (length == 0) {
				var win = $('<div id="'
						+ id
						+ '" ><iframe style="width:100%;height:100%;border:0;" src="'
						+ _options.url + '"></iframe></div>');
				$("body").append(win);
			}

			var _window = $('#' + id).window(_options);
			return _window;
		},
		//增加打开窗口js
		openWin : function(options){
			var ifChange = false;
			var id = options.id;
			var length = $("#" + id).length;
			var _options = {
				cache : false,
				onClose : function() {
					ifChange = false;
					$("#" + id).window('destroy');
				},
				onBeforeClose : function() {
					var ifClose = false;
					if (ifChange) {
						$.messager.confirm('Confirm', '您已进行编辑，是否关闭窗口？',
								function(r) {
									if (r) {
										ifClose = true;
										ifChange = false;
										$('#' + id).window('close');
									} else {
										ifClose = false;
									}
								});
					} else {
						ifClose = true;
					}
					return ifClose;
				}
			};

			$.extend(_options, options);

			if (length == 0) {
				var win = $("<div id='" + id + "' ></div>");
				$("body").append(win);
			}

			var _window = $('#' + id).window(_options);
			return _window;
		}
	};

  function alertMessageAndDetail(message,detail){
	 return $.messager.alert('操作结果',"<div style='text-left:center;width:100%;'>上传失败:"+message+" " +
				"<a href='#' onclick=javascript:showhideDivClass('detailInfo') style='text-decoration: none; '><span style='font-size:5px'> 详细</span></a></div><br/>"
				+"<div class = 'detailInfo' style='display:none'>详细信息："+detail+"</div>");
  }
  
  function showhideDivClass(cla){
		 $("."+cla).toggle();
  }
  
  function showhideDivId(id){
		 $("."+id).toggle();
}
  
  /**
   * 将js object 转换成字符串
   * @param o
   * @returns
   */
 function obj2string(o){ 
	    var r=[]; 
	    if(typeof o=="string"){ 
        return "\""+o.replace(/([\'\"\\])/g,"\\$1").replace(/(\n)/g,"\\n").replace(/(\r)/g,"\\r").replace(/(\t)/g,"\\t")+"\""; 
    } 
    if(typeof o=="object"){ 
        if(!o.sort){ 
            for(var i in o){ 
                r.push(i+":"+obj2string(o[i])); 
            } 
            if(!!document.all&&!/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)){ 
                r.push("toString:"+o.toString.toString()); 
            } 
            r="{"+r.join()+"}"; 
        }else{ 
            for(var i=0;i<o.length;i++){ 
                r.push(obj2string(o[i])) ;
            } 
            r="["+r.join()+"]"; 
        }  
        return r; 
    }  
    return o.toString(); 
} 
 
 /**
  *  Map jsMap
  */
 
 function Map() {     
	    /** 存放键的数组(遍历用到) */    
	    this.keys = new Array();     
	    /** 存放数据 */    
	    this.data = new Object();     
	         
	    /**   
	     * 放入一个键值对   
	     * @param {String} key   
	     * @param {Object} value   
	     */    
	    this.put = function(key, value) {     
	        if(this.data[key] == null){     
	            this.keys.push(key);     
	        }     
	        this.data[key] = value;     
	    };     
	         
	    /**   
	     * 获取某键对应的值   
	     * @param {String} key   
	     * @return {Object} value   
	     */    
	    this.get = function(key) {     
	        return this.data[key];     
	    };     
	         
	    /**   
	     * 删除一个键值对   
	     * @param {String} key   
	     */    
	    this.remove = function(key) {     
	        this.keys.remove(key);     
	        this.data[key] = null;     
	    };     
	         
	    /**   
	     * 遍历Map,执行处理函数   
	     *    
	     * @param {Function} 回调函数 function(key,value,index){..}   
	     */    
	    this.each = function(fn){     
	        if(typeof fn != 'function'){     
	            return;     
	        }     
	        var len = this.keys.length;     
	        for(var i=0;i<len;i++){     
	            var k = this.keys[i];     
	            fn(k,this.data[k],i);     
	        }     
	    };     
	         
	    /**   
	     * 获取键值数组(类似Java的entrySet())   
	     * @return 键值对象{key,value}的数组   
	     */    
	    this.entrys = function() {     
	        var len = this.keys.length;     
	        var entrys = new Array(len);     
	        for (var i = 0; i < len; i++) {     
	            entrys[i] = {     
	                key : this.keys[i],     
	                value : this.data[i]     
	            };     
	        }     
	        return entrys;     
	    };     
	         
	    /**   
	     * 判断Map是否为空   
	     */    
	    this.isEmpty = function() {     
	        return this.keys.length == 0;     
	    };     
	         
	    /**   
	     * 获取键值对数量   
	     */    
	    this.size = function(){     
	        return this.keys.length;     
	    };     
	         
	    /**   
	     * 重写toString    
	     */    
	    this.toString = function(){     
	        var s = "{";     
	        for(var i=0;i<this.keys.length;i++,s+=','){     
	            var k = this.keys[i];     
	            s += k+"="+this.data[k];     
	        }     
	        s+="}";     
	        return s;     
	    };     
	}

 /**
 *@author wangxj
 *	合并dataGrid 单元格 按列 
 *@param  field
 */
 function mergeCells(grid,field){
	    var rows = $("#"+grid).datagrid('getRows');	
	    var newArr = [];
	    var n = 0;
	    for(var i = 0; i < rows.length -1; i++){
	    	if (rows[i][field] != rows[i + 1][field]) {
	    		var tempArr = [];
	    		tempArr.push(n);
	    		tempArr.push(i+1);
	            newArr.push(tempArr);
	            n = i + 1;
	        }
	    }
	    var foo = [];
	    foo.push(n);
	    foo.push(rows.length);
	    newArr.push(foo);
	    for(var i=0; i<newArr.length; i++){
	        $("#"+grid).datagrid('mergeCells',{
	            index: newArr[i][0],
	            field: field,
	            rowspan: newArr[i][1] -newArr[i][0]
	        });
	    } 
	}
 
 
 /**
  *@author wangxj
  *	合计dataGrid 单元格 按列 
  *@param  field
  */
 function addSumCells(){
	  var grid = arguments[0];
	  var fields = $("#"+grid).datagrid('getColumnFields');
	  var data = {};
	/*  for(var o in fields){
		  if(o==0)
			  data[fields[o]] = "<b>合计</b>";
		  else if($.inArray(fields[o],arguments))
			  data[fields[o]] =  sumCells(grid,fields[o]);
		  else
			  data[fields[o]] = " ";
	  }*/
	  data[fields[0]] = "<b>合计</b>";
	  for(var i=1;i<arguments.length;i++){
		  data[arguments[i]] =  sumCells(grid,arguments[i]);
	  }
	  $("#"+grid).datagrid('appendRow',data);
 }

function sumCells(grid,field){
    var rows = $("#"+grid).datagrid('getRows');	
    var total = 0;
    for(var i = 0; i < rows.length; i++){
    	total += rows[i][field];
    }
    return total.toFixed(2);
}

/**
 * 根据字典值和字典组 获取字典名称
 * @param dictValue
 * @param dictGroup
 * @returns {String}
 */
function getDictName(dictValue,dictGroup){
	var name = "";
	$.ajax({
		url:"/land/sys/dict/findNameByValueAndGroup",
		type:'GET',
		async:false,
		data:{'dictValue':dictValue,'dictGroup':dictGroup},
		success:function(data){
			name = data.dictName;
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			name = dictValue;
		}
	});
	return name;
}