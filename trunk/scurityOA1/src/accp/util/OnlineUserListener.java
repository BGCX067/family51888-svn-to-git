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

        // ȡ�õ�¼���û���
        String username = (String) session.getAttribute("username");
        System.out.println("username:"+username);
        if(!"".equals(username)&&null!=username){
        // �������б���ɾ���û���
        List onlineUserList = (List) application.getAttribute("onlineUserList");
        onlineUserList.remove(username);

        System.out.println(username + "�����ߵ��û��߳�ȥ��...��");
        }*/
    	
    }

    public void sessionDestroyed(HttpSessionEvent event) {
    	System.out.println("sessionDestroyed-----");
        HttpSession session = event.getSession();
        ServletContext application = session.getServletContext();

        // ȡ�õ�¼���û���
        String username = (String) session.getAttribute("username");

        if(!"".equals(username)&&null!=username){
        	System.out.println(username+"��Ϊnull");
        // �������б���ɾ���û���
        List onlineUserList = (List) application.getAttribute("onlineUserList");
        onlineUserList.remove(username);

        System.out.println(username + "��ʱ�˳���");
        }
    }

}