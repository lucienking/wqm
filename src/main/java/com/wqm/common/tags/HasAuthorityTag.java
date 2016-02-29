package com.wqm.common.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.tags.SecureTag;

public class HasAuthorityTag extends SecureTag {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String authorityId = null;

	protected boolean showTagBody(String authorityId) {
		boolean isShow = Boolean.FALSE ;
		Subject currentUser = SecurityUtils.getSubject(); 
		if (currentUser.isPermitted(authorityId)) {    
			isShow = Boolean.TRUE;
		}  
		return isShow;
	}

    protected void verifyAttributes() throws JspException {
        String permission = getAuthorityId();

        if (permission == null || permission.length() == 0) {
            String msg = "The 'authorityId' tag attribute must be set.";
            throw new JspException(msg);
        }
    }

    public int onDoStartTag() throws JspException {
        String p = getAuthorityId();
        boolean show = showTagBody(p);
        if (show) {
            return TagSupport.EVAL_BODY_INCLUDE;
        } else {
            return TagSupport.SKIP_BODY;
        }
    }

    protected boolean isPermitted(String p) {
        return getSubject() != null && getSubject().isPermitted(p);
    }

	public String getAuthorityId() {
		return authorityId;
	}

	public void setAuthorityId(String authorityId) {
		this.authorityId = authorityId;
	}
	
}
