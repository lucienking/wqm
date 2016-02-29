package com.wqm.common.tags;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang3.StringUtils;

import com.wqm.common.context.SpringContextHolder;
import com.wqm.entity.sys.DictionaryEntity;
import com.wqm.service.sys.DictionaryService;

public class DictionaryTag  extends TagSupport {

	private static final long serialVersionUID = 1L;
	
	private String id;
	
	private String name;
	
	private String style;
	
	private String cssClass;

	private String dictCode;
	
	private String dictValue;
	
	private String groupId;
	
	private String defaultValue;
	
	private String display;
	
	private String dataOptions;
	
	private DictionaryService dictionaryService;
	
	private DictionaryEntity dictionary = null;
	
	private List<DictionaryEntity> dictItem = null;
	
	public int doStartTag() throws JspException {
		dictionaryService = (DictionaryService) SpringContextHolder.getBean("dictionaryService");
		if("Y".equals(display)){
			if(StringUtils.isNotBlank(dictValue)&&StringUtils.isNotBlank(groupId))
				dictionary = dictionaryService.getDictItemByVAndG(dictValue, groupId);
		}else{
			dictItem = dictionaryService.getDictItemByGroup(groupId);
		}
		return SKIP_BODY;
	}

    public int doEndTag() throws JspException {
    	StringBuffer sb = new StringBuffer();
    	try {
    		if(dictionary != null){
				sb.append("<span> "+dictionary.getDictName()).append("</span>");
    		}else if(dictItem != null){
				sb.append("<select id='" + id).append("' class='"+cssClass)
				.append("' name='"+name).append("' style='"+style+"'")
				.append(" data-options='"+dataOptions==null?"":dataOptions+"'");
				sb.append(">");
				for(DictionaryEntity dict:dictItem){
					sb.append("<option value='"+("blank".equals(dict.getDictValue())?"":dict.getDictValue()));
					if(dict.getDictValue().equals(defaultValue))
						sb.append("' selected='selected");
					sb.append("'>"+dict.getDictName()+"</option>");
				}
				sb.append("</select>");
			}else{
				sb.append("<span></span>");
			}
			pageContext.getOut().write(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
    	return EVAL_PAGE;
    }

	public String getDictCode() {
		return dictCode;
	}

	public void setDictCode(String dictId) {
		this.dictCode = dictId;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCssClass() {
		return cssClass;
	}

	public void setCssClass(String cssClass) {
		this.cssClass = cssClass;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}

	public String getDictValue() {
		return dictValue;
	}

	public void setDictValue(String dictValue) {
		this.dictValue = dictValue;
	}

	public String getDisplay() {
		return display;
	}

	public void setDisplay(String display) {
		this.display = display;
	}

	public String getDataOptions() {
		return dataOptions;
	}

	public void setDataOptions(String dataOptions) {
		this.dataOptions = dataOptions;
	}
	 
}
