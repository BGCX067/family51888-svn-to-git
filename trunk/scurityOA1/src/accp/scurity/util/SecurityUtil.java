package accp.scurity.util;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * SPRING SECURITY3工具类接口
 * 
 * @author shadow
 * @email 124010356@qq.com
 * @create 2012.04.28
 */
public interface SecurityUtil {

	public final static String SPRING_SECURITY_CONTEXT = "SPRING_SECURITY_CONTEXT";

	/**
	 * 获取SECURITY3的CONTEXT
	 * 
	 * @return SecurityContext
	 */
	public SecurityContext getSecurityContext();

	/**
	 * 获取SECURITY3的认证
	 * 
	 * @return Authentication
	 */
	public Authentication getAuthentication();

	/**
	 * 获取SECURITY3的认证对象
	 * 
	 * @return UserDetails
	 */
	public UserDetails getUserDetails();
}