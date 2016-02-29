package com.wqm.common.tags;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;



public class FileUploadTag extends TagSupport {

	private static final long serialVersionUID = 1L;
	
	private String id;
	
	private String name;
	
	private String fileNameFiled = "fileName";
	
	private String fileTypeFiled = "fileType";
	
	private String filePathFiled = "filePath";
	
	private String fileSizeFiled = "fileSize";
	
	public String getFileSizeFiled() {
		return fileSizeFiled;
	}

	public void setFileSizeFiled(String fileSizeFiled) {
		this.fileSizeFiled = fileSizeFiled;
	}

	private String style = "width:100%";
	
	private String cssClass;

	private String buttonText = "choose file";
	
	private String uploadPath = "/file/upload";
	
	private String savePath = "default";
	
	private static String basePath;
	
	public int doStartTag() throws JspException {
		return SKIP_BODY;
	}

    public int doEndTag() throws JspException {
    	StringBuffer sb = new StringBuffer();
    	basePath = pageContext.getServletContext().getContextPath();
    	Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMDDHHmmss");
		String dateId = "j"+sdf.format(date)+id;
    	try {
			sb.append("<div class='jksb-fileUpload' id='jksb-fileUpload-"+dateId+"'>");
			
			sb.append("<div id='"+dateId+"FileUploadDiv'>");
			sb.append("<a href='#' onclick='"+dateId+".click()'>"+buttonText+"</a>");
			sb.append("<input type='hidden'id='"+dateId+"savePath' name='savePath' value='"+savePath+"'>");
			sb.append("<input type='file' id='"+dateId+"' onchange=onchangeFileUpload('"+dateId+"','"+basePath+ uploadPath+"') name='file' ");
			sb.append("style='position:absolute; filter:alpha(opacity=0); opacity:0;"+style+"' />");
			sb.append("</div>");
			
			sb.append("<div id='"+dateId+"LoadingDiv' style='"+style+";display:none;'>");
			sb.append("<img src='"+basePath+"/static/jquery-easyui/themes/default/images/loading.gif' style='width:16px;height:16px;'>");
			sb.append("正在上传中，请稍候...");
			sb.append("</div>");
			
			sb.append("<div id='"+dateId+"UploadResult' style='"+style+";display:none;'>");
			sb.append("<input type='hidden' name='"+name+"' />");
			sb.append("<input type='hidden' name='"+fileSizeFiled+"' />");
			sb.append("<input type='hidden' name='"+fileNameFiled+"' />");
			sb.append("<input type='hidden' name='"+fileTypeFiled+"' />");
			sb.append("<input type='hidden' name='"+filePathFiled+"' />");
			sb.append("</div>");

			sb.append("</div>");
			
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getButtonText() {
		return buttonText;
	}

	public void setButtonText(String buttonText) {
		this.buttonText = buttonText;
	}

	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	

	public String getFileNameFiled() {
		return fileNameFiled;
	}

	public void setFileNameFiled(String fileNameFiled) {
		this.fileNameFiled = fileNameFiled;
	}

	public String getFileTypeFiled() {
		return fileTypeFiled;
	}

	public void setFileTypeFiled(String fileTypeFiled) {
		this.fileTypeFiled = fileTypeFiled;
	}

	public String getFilePathFiled() {
		return filePathFiled;
	}

	public void setFilePathFiled(String filePathFiled) {
		this.filePathFiled = filePathFiled;
	}

}
