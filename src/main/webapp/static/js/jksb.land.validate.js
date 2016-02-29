/**
 * 国土前端校验脚本
 * 
 * @author wangxj
 * @author willian Chan
 */

/*
* 必填项检测功能
* 主要检测菜单名称及权限，并设元素对象为焦点
* 输入：1、表单元素ID；2、提示信息。
* 输出：boolean值，false为空值，true为非空值
*/

var checkNotNull=function(ID,idName){
	var refId=$('#'+ID);
	if(refId.val()==""){
		$.messager.alert("出错！","请填写"+idName,'error',function(r){
			refId.textbox().next('span').find('input').focus();
		});
		return false;
	}else{
		return true;
	}
}; 

/*
 *********** 表单 input 验证 基于 easyui.  **************
 */
$.extend($.fn.validatebox.defaults.rules, {
	number: {
        validator: function(value){
        	var strVal = trim(value);
        	if(isNullOrEmpty(strVal)) return false;
        	var reg = new RegExp(isNumber);
        	return reg.test(strVal) ;
        },
        message: '该项应为整数'
    },
    float:{
    	validator: function(value){
        	var strVal = trim(value);
        	if(isNullOrEmpty(strVal)) return false;
        	var reg = new RegExp(isNonNegatedRealNumber2);
        	return reg.test(strVal) ;
        },
        message: '该项为非负数(最多保留两位)'
    },
    idNO:{
    	validator: function(value){
        	var strVal = trim(value);
        	if(isNullOrEmpty(strVal)) return false;
        	var reg = new RegExp(isIDNO);
        	return reg.test(strVal) ;
        },
        message: '身份证号不正确'
    },
    minLength: {
        validator: function(value, param){
            return value.length >= param[0];
        },
        message: '该项长度不能小于 {0}.'
    },
    maxLength: {
        validator: function(value, param){
            return value.length <= param[0];
        },
        message: '该项长度不能超过 {0}.'
    }

});

function getEasyUiInputValue(id){
	return $("#"+id).textbox("getValue");
};


//校验不通过样式设置
function setInvalidStyle(id){
	$("#"+id).next('span').addClass("textbox-invalid");
	$("#"+id).next('span').find("input").addClass("validatebox-invalid");
}

function validateInputGroup(inputs,selects){
	var validateResult = true;
	if(inputs!= null)
	for(i in inputs){
		if(isNullOrEmpty($("#"+inputs[i]).textbox("getValue"))){
			setInvalidStyle(inputs[i]);
			validateResult = false;
		}
	}
	if(selects!= null)
	for(i in selects){
		if(isNullOrEmpty($("#"+selects[i]).combobox("getValue"))){
			setInvalidStyle(selects[i]);
			validateResult = false;
		}
	}
	return validateResult;
}

//校验为空
function validateEmpty(ids){
	var strVal = getEasyUiInputValue(id);  
	strVal = trim(strVal);
	if (strVal == '' || strVal == null || strVal == undefined) {
		return true;
	}
	return false;
}

// 正则 验证输入
function jksbValidate(id,type){  
    var reg = "";
    switch(type){
	    case "isNumber": reg = new RegExp(isNumber);  break;
	    case "isIDNO": reg = new RegExp(isIDNO); break;
	    case "isFloat": reg = new RegExp(isFloat); break;
	    default: reg = new RegExp("");
    }
    var value = getEasyUiInputValue(id);  
	if(reg.test(value)){ return true;	}
	return false;
}  

/**
 * 校验枚举类型（enum 数组）
 * 
 */
function enumValidate(value,enumArray){
	var array = enumArray.split(",");
	 for (var i = 0; i < array.length; i++) {
         if (array[i] === value) {
             return true;
         }
     }
     return false;
}


/*
 *	正则表达式
 */

//验证数字：^[0-9]*$ 
var isNumber = /^[0-9]*$/;
//验证n位的数字：^\d{n}$ 
//验证至少n位数字：^\d{n,}$ 
//验证m-n位的数字：^\d{m,n}$ 
//验证零和非零开头的数字：^(0|[1-9][0-9]*)$ 
//验证有两位小数的正实数：^[0-9]+(.[0-9]{2})?$ 
var isNonNegatedRealNumber1 = /^[0-9]+(.[0-9]{2})?$/;
//验证有1-2位小数的正实数：^[0-9]+(.[0-9]{1,3})?$ 
var isNonNegatedRealNumber2 = /^[0-9]+(.[0-9]{1,2})?$/;
//验证非零的正整数：^\+?[1-9][0-9]*$ 
//验证非零的负整数：^\-[1-9][0-9]*$ 
//验证非负整数（正整数 + 0） ^\d+$ 
//验证非正整数（负整数 + 0） ^((-\d+)|(0+))$ 
//验证长度为3的字符：^.{3}$ 
//验证由26个英文字母组成的字符串：^[A-Za-z]+$ 
//验证由26个大写英文字母组成的字符串：^[A-Z]+$ 
//验证由26个小写英文字母组成的字符串：^[a-z]+$ 
//验证由数字和26个英文字母组成的字符串：^[A-Za-z0-9]+$ 
//验证由数字、26个英文字母或者下划线组成的字符串：^\w+$ 
//验证用户密码:^[a-zA-Z]\w{5,17}$ 正确格式为：以字母开头，长度在6-18之间，只能包含字符、数字和下划线。 
//验证是否含有 ^%&',;=?$\" 等字符：[^%&',;=?$\x22]+ 
//验证汉字：^[\u4e00-\u9fa5],{0,}$ 
//验证Email地址：^\w+[-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$ 
//验证InternetURL：^http://([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$ ；^[a-zA-z]+://(w+(-w+)*)(.(w+(-w+)*))*(?S*)?$ 
//验证电话号码：^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$：--正确格式为：XXXX-XXXXXXX，XXXX-XXXXXXXX，XXX-XXXXXXX，XXX-XXXXXXXX，XXXXXXX，XXXXXXXX。 
//验证身份证号（15位或18位数字）：^\d{15}|\d{}18$ 
//var isIDNO = "^\d{15}|\d{}18$";
//验证一年的12个月：^(0?[1-9]|1[0-2])$ 正确格式为：“01”-“09”和“1”“12” 
//验证一个月的31天：^((0?[1-9])|((1|2)[0-9])|30|31)$ 正确格式为：01、09和1、31。 
//整数：^-?\d+$ 
//非负浮点数（正浮点数 + 0）：^\d+(\.\d+)?$ 
var isNonNegatedFloat = /^\d+(\.\d+)?$/;
//正浮点数 ^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$ 
//非正浮点数（负浮点数 + 0） ^((-\d+(\.\d+)?)|(0+(\.0+)?))$ 
//负浮点数 ^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$ 
//浮点数 ^(-?\d+)(\.\d+)?$ 
var isFloat=/^(-?\d+)(\.\d+)?$/;
//身份证 /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/
var isIDNO = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;

 
