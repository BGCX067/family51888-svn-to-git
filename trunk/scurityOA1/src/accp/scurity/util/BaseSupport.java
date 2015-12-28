package accp.scurity.util;


/**
 * 工具集合支持类
 * 
 * @author shadow
 * @create 2013.04.03
 */
public abstract class BaseSupport {

	/**
	 * CONTEXT工具类
	 */
	public static ContextUtil ContextUtil = new ContextUtilImpl();

	/**
	 * 一般工具类
	 */
	public static CommonUtil CommonUtil = new CommonUtilImpl();

	/**
	 * spring工具类
	 */
	//public static SpringUtil SpringUtil = new SpringUtilImpl();

	/**
	 * SECURITY工具类
	 */
	public static SecurityUtil SecurityUtil = new SecurityUtilImpl();

	/**
	 * 上传工具类
	 */
	//public static UploadUtil UploadUtil = new UploadUtilImpl();

	/**
	 * 文件工具类
	 */
	//public static FileUtil FileUtil = new FileUtilImpl();

	/**
	 * 加密工具类(默认使用SECURITY的MD5加密)
	 */
	public static Encoder Encoder = new MD5Encoder();

	/**
	 * 校验工具类
	 */
	public static Validator Validator = new ValidatorImpl();

	/**
	 * 敏感字符匹配工具
	 */
	public static AcUtil AcUtil = new AcUtilImpl();
	
	/**
	 * 拼音转换工具
	 */
	//public static PinYinUtil PinYinUtil = new PinYinUtilImpl();
}
