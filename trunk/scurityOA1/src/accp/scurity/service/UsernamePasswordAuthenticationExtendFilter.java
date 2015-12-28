package accp.scurity.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import accp.scurity.exception.MethodErrorException;


/**
 * 重载SECURITY3的UsernamePasswordAuthenticationFilter的attemptAuthentication,
 * obtainUsername,obtainPassword方法(完善逻辑) 增加验证码校验模�?添加验证码属�?添加验证码功能开关属�?
 * 
 * @author liangrui
 * @email 382453602@qq.com
 * @create 2013.08.17
 */
public class UsernamePasswordAuthenticationExtendFilter extends
		UsernamePasswordAuthenticationFilter {

	// 验证码字�?
	private String validateCodeParameter = "validateCode";
	// 是否�?��验证码功�?
	private boolean openValidateCode = false;

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request,
			HttpServletResponse response) throws AuthenticationException {
		// 只接受POST方式传
		if (!"POST".equals(request.getMethod()))
			throw new MethodErrorException("不支持非POST方式的请�?");

		/*// �?��验证码功能的情况
		if (isOpenValidateCode())
			checkValidateCode(request);*/

		// 获取Username和Password
		String username = obtainUsername(request);
		String password = obtainPassword(request);

		// UsernamePasswordAuthenticationToken实现Authentication校验
		UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(
				username, password);

		// 允许子类设置详细属
		setDetails(request, authRequest);

		// 运行UserDetailsService的loadUserByUsername 再次封装Authentication
		return this.getAuthenticationManager().authenticate(authRequest);
	}

	// 匹对验证码的正确�?
	/*public void checkValidateCode(HttpServletRequest request) {

		String jcaptchaCode = obtainValidateCodeParameter(request);
		if (null == jcaptchaCode)
			throw new ValidateCodeException("验证码超�?请重新获�?");

		boolean b = CaptchaServiceSingleton.getInstance()
				.validateResponseForID(request.getSession().getId(),
						jcaptchaCode);
		if (!b)
			throw new ValidateCodeException("验证码不正确,请重新输�?");
	}
*/
	public String obtainValidateCodeParameter(HttpServletRequest request) {
		Object obj = request.getParameter(getValidateCodeParameter());
		return null == obj ? "" : obj.toString().trim();
	}

	@Override
	protected String obtainUsername(HttpServletRequest request) {
		Object obj = request.getParameter(getUsernameParameter());
		return null == obj ? "" : obj.toString().trim();
	}

	@Override
	protected String obtainPassword(HttpServletRequest request) {
		Object obj = request.getParameter(getPasswordParameter());
		return null == obj ? "" : obj.toString().trim();
	}

	public String getValidateCodeParameter() {
		return validateCodeParameter;
	}

	public void setValidateCodeParameter(String validateCodeParameter) {
		this.validateCodeParameter = validateCodeParameter;
	}

	public boolean isOpenValidateCode() {
		return openValidateCode;
	}

	public void setOpenValidateCode(boolean openValidateCode) {
		this.openValidateCode = openValidateCode;
	}

}
