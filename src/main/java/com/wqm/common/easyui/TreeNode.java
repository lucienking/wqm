package com.wqm.common.easyui;

import java.util.List;
import java.util.Map;

public class TreeNode {
	
	private String id;
	
	private String text;
	
	private String state;

	private boolean checked;
	
	private List<Map<String,String>> attributes;
	
	private TreeNode children = null;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public List<Map<String, String>> getAttributes() {
		return attributes;
	}

	public void setAttributes(List<Map<String, String>> attributes) {
		this.attributes = attributes;
	}

	public TreeNode getChildren() {
		return children;
	}

	public void setChildren(TreeNode children) {
		this.children = children;
	}
}
