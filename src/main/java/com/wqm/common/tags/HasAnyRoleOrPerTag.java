package com.wqm.common.tags;

import org.apache.shiro.subject.Subject;

/**
 * 拥有任何配置中的角色或权限时就显示tagbody中的内容
 * @author liuxin
 *
 */
public class HasAnyRoleOrPerTag extends RoleAndPermissionTag {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6050667737902852143L;
	private static final String SEPARATOR=",";

	@Override
	protected boolean showTagBody(String roleNames, String permissionNames) {
		boolean hasAnyRoleOrPer=false;
		Subject subject=getSubject();
		if(subject!=null){
			if(roleNames!=null&&!"".equals(roleNames.trim())){
				for (String role : roleNames.split(SEPARATOR)) {
	                if (subject.hasRole(role.trim())) {
	                	hasAnyRoleOrPer = true;
	                    break;
	                }
	            }
			}
			if(!hasAnyRoleOrPer){
				if(permissionNames!=null&&!"".equals(permissionNames.trim())){
					for(String permission : permissionNames.split(SEPARATOR)){
						if(subject.isPermitted(permission.trim())){
							hasAnyRoleOrPer=true;
							break;
						}
					}
				}
			}
		}
		return hasAnyRoleOrPer;
	}

}
