package accp.util;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.FactoryBean;

import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.object.MappingSqlQuery;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.ConfigAttributeEditor;
import org.springframework.security.web.access.intercept.DefaultFilterInvocationSecurityMetadataSource;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;

import org.springframework.security.web.util.AntPathRequestMatcher;
import org.springframework.security.web.util.RequestMatcher;
import org.springframework.security.authentication.AuthenticationManager;

public class JdbcFilterInvocationDefinitionSourceFactoryBean
    extends JdbcDaoSupport implements FactoryBean {
	
	public JdbcFilterInvocationDefinitionSourceFactoryBean(){
		System.out.println("初始化了JdbcFilterInvocationDefinitionSourceFactoryBean");
	}
	
    private String resourceQuery;

    public boolean isSingleton() {
        return true;
    }

    public Class getObjectType() {
        return FilterInvocationSecurityMetadataSource.class;
    }

    public Object getObject() {
        return new DefaultFilterInvocationSecurityMetadataSource(this
            .buildRequestMap());
    }
    /**
     * getDataSource 数据库源
     * resourceQuery 查询语句
     * @return
     */
    protected Map<String, String> findResources() {
    	System.out.println("resourceQueryXXXXXXXXXXX:  "+resourceQuery);
    	
        ResourceMapping resourceMapping = new ResourceMapping(getDataSource(),
                resourceQuery);

        Map<String, String> resourceMap = new LinkedHashMap<String, String>();

        for (Resource resource : (List<Resource>) resourceMapping.execute()) {
        
            String url = resource.getUrl();
            //System.out.println("url:"+url);
            String role = resource.getRole();

            if (resourceMap.containsKey(url)) {
                String value = resourceMap.get(url);
               // System.out.println("uriValue: "+value);
                resourceMap.put(url, value + "," + role);
                //System.out.println(url+ value + "," + role);
            } else {
                resourceMap.put(url, role);
               // System.out.println("no:"+url+ "," + role);
            }
        }
        // System.out.println("重新封装完毕");
        return resourceMap;
    }

    protected LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>> buildRequestMap() {
        LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>> requestMap =
            null;
        requestMap = new LinkedHashMap<RequestMatcher, Collection<ConfigAttribute>>();

        ConfigAttributeEditor editor = new ConfigAttributeEditor();

        Map<String, String> resourceMap = this.findResources();

        for (Map.Entry<String, String> entry : resourceMap.entrySet()) {
            String key = entry.getKey();
            editor.setAsText(entry.getValue());
            requestMap.put(new AntPathRequestMatcher(key),
                (Collection<ConfigAttribute>) editor.getValue());
        }

        return requestMap;
    }

    public void setResourceQuery(String resourceQuery) {
        this.resourceQuery = resourceQuery;
    }

    private class Resource {
        private String url;
        private String role;

        public Resource(String url, String role) {
            this.url = url;
            this.role = role;
        }

        public String getUrl() {
            return url;
        }

        public String getRole() {
            return role;
        }
    }

    private class ResourceMapping extends MappingSqlQuery {
        protected ResourceMapping(DataSource dataSource,
            String resourceQuery) {
            super(dataSource, resourceQuery);
            compile();
        }

        protected Object mapRow(ResultSet rs, int rownum)
            throws SQLException {
            String url = rs.getString(1);
            String role = rs.getString(2);
            Resource resource = new Resource(url, role);

            return resource;
        }
    }
}