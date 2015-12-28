package accp.scurity.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.util.AntPathRequestMatcher;
import org.springframework.security.web.util.RegexRequestMatcher;
import org.springframework.security.web.util.RequestMatcher;

import accp.services.BaseServices;
import accp.services.RoleServices;


/**
 * 初始化时加载角色资源关联数据
 * 
 * @author liangrui
 * @email 382453602@qq.com
 * @create 2013.08.17
 */
public class SecurityMetadataSourceExtendImpl implements
		SecurityMetadataSourceExtend {

	
	private BaseServices<accp.bean.Resc,Long> baseRescServices;//基本Resc业务资源接口
	
	
	public BaseServices<accp.bean.Resc, Long> getBaseRescServices() {
		return baseRescServices;
	}

	public void setBaseRescServices(
			BaseServices<accp.bean.Resc, Long> baseRescServices) {
		this.baseRescServices = baseRescServices;
	}

	
	private boolean expire = false; // 过期标识
	private RequestMatcher requestMatcher; // 匹配规则

	private String matcher; // 规则标识

	/**
	 * String=资源uri
	 * Collection=角色集合
	 */
	private Map<String, Collection<ConfigAttribute>> kv = new HashMap<String, Collection<ConfigAttribute>>(); // 资源集合

	
	
	public boolean supports(Class<?> clazz) {
		return true;
	}

	// 初始化方法时候从数据库中读取资源
	// @PostConstruct
	public void init() {
		load();
	}

	public Collection<ConfigAttribute> getAllConfigAttributes() {
		Set<ConfigAttribute> attributes = new HashSet<ConfigAttribute>();
		for (Map.Entry<String, Collection<ConfigAttribute>> entry : kv
				.entrySet()) {
			attributes.addAll(entry.getValue());
		}
		return attributes;
	}

	public Collection<ConfigAttribute> getAttributes(Object object)
			throws IllegalArgumentException {
		HttpServletRequest request = ((FilterInvocation) object).getRequest();
		// System.out.println("requestUrl is " + request.getRequestURI());

		//是否刷新了资
		if (isExpire()) {
			// 清空原本资源
			kv.clear();
			expire = false;
		}

		// 如果资源Map为空的时候则重新加载
		if (null == kv || kv.isEmpty())
			load();

		// 请求与当前资源匹配的正确
		Iterator<String> iterator = kv.keySet().iterator();
		while (iterator.hasNext()) {
			String uri = iterator.next();
			if (matcher.toLowerCase().equals("ant")) {
				requestMatcher = new AntPathRequestMatcher(uri);
			}
			if (matcher.toLowerCase().equals("regex")) {
				requestMatcher = new RegexRequestMatcher(uri, request
						.getMethod(), true);
			}
			if (requestMatcher.matches(request))
				return kv.get(uri);
		}
		return null;
	}

	/**
	 * 加载资源与权限的关系
	 * 一个资源可以被那些角色访问
	 */
	public void load() {
		//获取所有资源
		List<accp.bean.Resc> resc = this.baseRescServices.getAll(new accp.bean.Resc());
		for (accp.bean.Resc resource : resc) {
			// 资源下的角色  根据资源id查询出对应的角色
			//List<accp.bean.Role> roles = this.roleServices.getRoleByRescid(resource.getId());
			//根据id 获取次源对象
			accp.bean.Resc rescObj=baseRescServices.getTInId(new accp.bean.Resc(),resource.getId());
			//取出资源对象中所有的权限集合
			Set<accp.bean.Role> rolesSet=rescObj.getRoles();
			System.out.println("资源："+resource.getResString());
			
			for(accp.bean.Role r:rolesSet){
			System.out.println("角色 : "+r.getName());
			}
			//一个资源uri==对应多个角色
			kv.put(resource.getResString(), list2Collection(rolesSet));
			System.out.println("----------------------------");
		}
	}

	/**
	 * 将List<Role>集合转换为框架需要的Collection<ConfigAttribute>集合
	 * 
	 * @param roles
	 * @return Collection<ConfigAttribute>
	 */
	private Collection<ConfigAttribute> list2Collection(Set<accp.bean.Role> roles) {
		//根据一个角色集合，转换为spirng 规范的权限
		List<ConfigAttribute> list = new ArrayList<ConfigAttribute>();
		for (accp.bean.Role role : roles)
			list.add(new SecurityConfig(role.getName()));
		return list;
	}

	public void setMatcher(String matcher) {
		this.matcher = matcher;
	}

	public boolean isExpire() {
		return expire;
	}

	public void expireNow() {
		this.expire = true;
	}

}