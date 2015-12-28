package org.notepress.security.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.notepress.security.service.IFunctionService;
import org.notepress.util.hibernate.HibernateDaoSupport;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;

public class FunctionServiceImpl extends HibernateDaoSupport implements
		IFunctionService {

	public Map<String, Collection<ConfigAttribute>> findRoleUrl()
			throws Exception {
		// 存储url对应的角色集合
		Map<String, Collection<ConfigAttribute>> sourceMap = new HashMap<String, Collection<ConfigAttribute>>();

		// 查询出url和角色的关系
		String queryString = "select a.functionAnturl,b.roleName from Function a,Role b,RoleFunction c where a.id=c.functionId and b.id=c.roleId";
		List allSource = this.findEntity(queryString);
		for (Object source : allSource) {
			// 角色集合
			Collection<ConfigAttribute> configAttributeCollection = null;
			// 角色
			ConfigAttribute ca = null;

			Object[] sources = (Object[]) source;
			String url = (String) sources[0];// 资源url
			String roleName = (String) sources[1];// 角色名
			if (sourceMap.containsKey(url)) {// 如果已包含此url对应的角色集合，则取出它，并更新它
				configAttributeCollection = sourceMap.get(url);
				ca = new SecurityConfig("ROLE_" + roleName);
				configAttributeCollection.add(ca);
			} else {
				// 如果没有此Url对应的角色集合，则新建一个角色集合
				configAttributeCollection = new ArrayList<ConfigAttribute>();
				// 创建一个包含角色的ConfigAttribute
				ca = new SecurityConfig("ROLE_" + roleName);
				// 将ConfigAttribute放入角色集合中
				configAttributeCollection.add(ca);
			}
			// 将url与对应的角色集合放入map中
			sourceMap.put(url, configAttributeCollection);
		}
		return sourceMap;
	}
}
