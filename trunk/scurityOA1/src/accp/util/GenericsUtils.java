package accp.util;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

public class GenericsUtils {
	 /**   
     * ͨ������,��ö���Classʱ�����ĸ���ķ��Ͳ���������.   
     * ��public BookManager extends GenricManager<Book>   
     *   
     * @param clazz The class to introspect   
     * @return the first generic declaration, or Object.class if cannot be determined   
     */  
    public static Class getSuperClassGenricType(Class clazz) {  
        return getSuperClassGenricType(clazz, 0);  
    }  
  
    /**   
     * ͨ������,��ö���Classʱ�����ĸ���ķ��Ͳ���������.   
     * ��public BookManager extends GenricManager<Book>   
     *   
     * @param clazz clazz The class to introspect   
     * @param index the Index of the generic ddeclaration,start from 0.   
     */  
    public static Class getSuperClassGenricType(Class clazz, int index) throws IndexOutOfBoundsException {  
        Type genType = clazz.getGenericSuperclass();  
  
        if (!(genType instanceof ParameterizedType)) {  
            return Object.class;  
        }  
  
        Type[] params = ((ParameterizedType) genType).getActualTypeArguments();  
       
        if (index >= params.length || index < 0) {  
            return Object.class;  
        }  
        if (!(params[index] instanceof Class)) {  
            return Object.class;  
        }  
        return (Class) params[index];  
    }  
}  

