package accp.scurity.interceptor;

import java.util.Map;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

/**
 * 拦截器SCRIPT安全
 * 
 * @author liangrui
 * @email 382453602@qq.com
 * @create 2013.08.17
 */
@SuppressWarnings("serial")
public class SecurityInterceptor implements Interceptor {

	private static Pattern scriptPattern = Pattern.compile("script",
			Pattern.CASE_INSENSITIVE);

	public String intercept(ActionInvocation invocation) throws Exception {
		Map<String, Object> parameters = invocation.getInvocationContext()
				.getParameters();
		for (String key : parameters.keySet()) {
			Object value = parameters.get(key);
			if (value instanceof String[]) {
				String[] values = (String[]) value;
				for (int i = 0, len = values.length; i < len; i++) {
					values[i] = scriptPattern.matcher(values[i]).replaceAll(
							"&#x73;cript");
					values[i] = StringUtils.replace(values[i], "<", "&lt;");
					values[i] = StringUtils.replace(values[i], ">", "&gt;");
				}
				parameters.put(key, values);
			}
		}
		return invocation.invoke();
	}

	public void destroy() {
	}

	public void init() {
	}

}