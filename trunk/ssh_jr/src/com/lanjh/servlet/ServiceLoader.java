package com.lanjh.servlet;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.BeanFactoryAware;

public class ServiceLoader implements BeanFactoryAware {

	private static BeanFactory beanFactory = null;
	 
    public void setBeanFactory(BeanFactory beanFactory) {
        this.beanFactory = beanFactory;
    }
 
    public static Object getBean(String name) {
        return beanFactory.getBean(name);
    }
 
    public static <T> T getBean(String name, Class<T> clazz) {
        return (T)beanFactory.getBean(name);
    }
 
    public static boolean containsBean(String name) {
        return beanFactory.containsBean(name);
    }

}
