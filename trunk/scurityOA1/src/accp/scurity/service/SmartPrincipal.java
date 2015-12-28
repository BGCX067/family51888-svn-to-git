package accp.scurity.service;


import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

import org.springframework.util.Assert;
import accp.exception.IfMaximumExceeded;

public class SmartPrincipal {
  private static final Log logger = LogFactory.getLog(AuditListener.class);

    private String username;
    private String ip;

    public SmartPrincipal(String username, String ip) {
        Assert.notNull(username,
            "username cannot be null (violation of interface contract)");
        Assert.notNull(ip,
            "username cannot be null (violation of interface contract)");
        this.username = username;
        this.ip = ip;
    }

    public SmartPrincipal(Authentication authentication) {
        Assert.notNull(authentication,
            "authentication cannot be null (violation of interface contract)");

        String username = null;

        if (authentication.getPrincipal() instanceof UserDetails) {
            username = ((UserDetails) authentication.getPrincipal())
                .getUsername();
        } else {
            username = (String) authentication.getPrincipal();
        }

        String ip = ((WebAuthenticationDetails) authentication
            .getDetails()).getRemoteAddress();
        this.username = username;
        this.ip = ip;
        logger.info("hello logger your ip:"+this.ip+" usernaem:"+this.username
        		+" date: "+new Date());
        System.out.println("hello your ip:"+this.ip+" usernaem:"+this.username
        		+" date: "+new Date());
    }

    //这个方法没有做呢
    public boolean equalsIp(SmartPrincipal smartPrincipal) {
    	boolean b=false;
        b= this.ip.equals(smartPrincipal.ip);
      // System.out.println("�ж�ip: smartPrincipal.ip:"+smartPrincipal.ip+"== thisIP:"+this.ip);
        System.out.println(b);
        return b;
        }
    
   
    @Override
    public boolean equals(Object obj)   {
    	boolean usernameB=false;
    	boolean ipB=false;
        if (obj instanceof SmartPrincipal) {
            SmartPrincipal smartPrincipal = (SmartPrincipal) obj;
          System.out.println("username: :"+username+"== "+smartPrincipal.username);
            usernameB=username.equals(smartPrincipal.username);
            ipB=this.ip.equals(smartPrincipal.ip);
        }
       System.out.println("username: "+usernameB+"  ip:"+ipB);
        if(usernameB==true&&ipB==true){
        	return true;
        }else{
		throw new IfMaximumExceeded("不能在多个ip下，同时登陆同一个用户，请注销正在使用的用户才能合法登陆");
     
        }
       
       //return false;
    }

    @Override
    public int hashCode() {
        return username.hashCode();
    }

    @Override
    public String toString() {
        return "SmartPrincipal:{username=" + username + ",ip=" + ip + "}";
    }
}
