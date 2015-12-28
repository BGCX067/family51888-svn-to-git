package accp.scurity.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

import org.springframework.security.core.userdetails.UsernameNotFoundException;

import accp.services.BaseServices;


/**
 * SPRING SECURITY3用户登录处理
 * 
 * @author liangrui
 * @email 382453602@qq.com
 * @create 2013.08.17
 */
public class UserDetailsServiceImpl implements UserDetailsService {

    private BaseServices<accp.bean.User,Long> baseUserServices;//基本user业务
	
    public BaseServices<accp.bean.User, Long> getBaseUserServices() {
		return baseUserServices;
	}

	public void setBaseUserServices(BaseServices<accp.bean.User, Long> baseUserServices) {
		
		this.baseUserServices = baseUserServices;
	}

	

	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {

		// 使用User服务类查询数据用户是否存�?如不存在或密码错误则抛出对应的异�?
		accp.bean.User uWhere=new  accp.bean.User();
		uWhere.setUsername(username);
		List<accp.bean.User> users=null;
		try {
			//从数据库中查询出用户所有信息
			users = this.baseUserServices.getTInName(uWhere);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (null == users || users.isEmpty())
			throw new UsernameNotFoundException("用户/密码错误,请重新输");

		accp.bean.User user = users.get(0);
		//获取角色
		Set<accp.bean.Role> roles = user.getRoles();
		
		if (null == roles || roles.isEmpty())
			throw new UsernameNotFoundException("权限不足!");
		// 把权限赋值给当前对象
		Collection<GrantedAuthority> gaRoles = new ArrayList<GrantedAuthority>();
		for (accp.bean.Role role : roles) {
			gaRoles.add(new SimpleGrantedAuthority(role.getName()));
		}
		user.setAuthorities(gaRoles);//权限转换为spring 规定的
		
		
		
		return user;
	}

}