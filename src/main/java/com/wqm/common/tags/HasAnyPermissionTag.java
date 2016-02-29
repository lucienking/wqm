package com.wqm.common.tags;


import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.tags.PermissionTag;

public class HasAnyPermissionTag extends PermissionTag {
	
	private static final long serialVersionUID = 3499400941984659449L;
	private static final String SEPARATOR=",";

	@Override
	protected boolean showTagBody(String permissionNames) {
		boolean hasAnyPermission=false;
		Subject subject=getSubject();
		if(subject!=null){
			for(String permission : permissionNames.split(SEPARATOR)){
				if(subject.isPermitted(permission.trim())){
					hasAnyPermission=true;
					break;
				}
			}
		}
		return hasAnyPermission;
	}

}
