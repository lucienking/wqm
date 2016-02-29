package com.wqm.common.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;




public class FileDownloadTag extends TagSupport {

	private static final long serialVersionUID = 1L;
	
	private String id;
	
	private String fileName;
	
	private String filePath;
	
	private String style = "width:100%";
	
	private String cssClass;

	private String hrefText = "下载";
	
	public int doStartTag() throws JspException {
		return SKIP_BODY;
	}

    public int doEndTag() throws JspException {
    	StringBuffer sb = new StringBuffer();
    	String path = super.pageContext.getSession().getServletContext().getContextPath();
    	try {
			sb.append("<a href='").append(path).append("/file/download?filePath=").append(filePath);
			sb.append("&fileName=").append(fileName).append("'");
			if(!"".equals(id)&&id!=null) sb.append(" id='").append(id).append("'");
			if(!"".equals(style)&&style!=null) sb.append(" style='").append(style).append("'");
			if(!"".equals(cssClass)&&cssClass!=null) sb.append(" class='").append(cssClass).append("'");
			sb.append(">");
			sb.append(hrefText);
			sb.append("</a>");
			
			pageContext.getOut().write(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
    	return EVAL_PAGE;
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getCssClass() {
		return cssClass;
	}

	public void setCssClass(String cssClass) {
		this.cssClass = cssClass;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getHrefText() {
		return hrefText;
	}

	public void setHrefText(String hrefText) {
		this.hrefText = hrefText;
	}
	 
}
