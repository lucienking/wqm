package com.wqm.common.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.shiro.web.tags.SecureTag;

public abstract class RoleAndPermissionTag extends SecureTag {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String roleName=null;
	private String permissionName=null;
	
	public RoleAndPermissionTag(){
		
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getPermissionName() {
		return permissionName;
	}

	public void setPermissionName(String permissionName) {
		this.permissionName = permissionName;
	}

	public int onDoStartTag() throws JspException {
        boolean show = showTagBody(getRoleName(),getPermissionName());
        if (show) {
            return TagSupport.EVAL_BODY_INCLUDE;
        } else {
            return TagSupport.SKIP_BODY;
        }
    }

	protected abstract boolean showTagBody(String roleNames,String permissionNames);

}
