package accp.util;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionListener;
import javax.servlet.http.HttpSessionEvent;

public class OnlineUserListener implements HttpSessionListener {

    public void sessionCreated(HttpSessionEvent event) {
    	System.out.println("sessionCreated-----");
    /*	HttpSession session = event.getSession();
        ServletContext application = session.getServletContext();

        // 取得登录的用户名
        String username = (String) session.getAttribute("username");
        System.out.println("username:"+username);
        if(!"".equals(username)&&null!=username){
        // 从在线列表中删除用户名
        List onlineUserList = (List) application.getAttribute("onlineUserList");
        onlineUserList.remove(username);

        System.out.println(username + "把在线的用户踢出去了...。");
        }*/
    	
    }

    public void sessionDestroyed(HttpSessionEvent event) {
    	System.out.println("sessionDestroyed-----");
        HttpSession session = event.getSession();
        ServletContext application = session.getServletContext();

        // 取得登录的用户名
        String username = (String) session.getAttribute("username");

        if(!"".equals(username)&&null!=username){
        	System.out.println(username+"不为null");
        // 从在线列表中删除用户名
        List onlineUserList = (List) application.getAttribute("onlineUserList");
        onlineUserList.remove(username);

        System.out.println(username + "超时退出。");
        }
    }

}