package qq.client;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JTextPane;

import qq.client.windows.LoginWindow;
import qq.entity.User;
/**
 * @author lanjh
 * 客户端主程序
 */

public class ClientMainClass {
	public static  Socket socket;//当前连接的Socket，此Socket在整个客户端程序运行过程中一直有效。
	public static ObjectInputStream ois;//根据Socket得到的对象输入流，在整个客户端程序运行过程中一直有效。
	public static ObjectOutputStream oos;//根据Socket得到的对象输出流，在整个客户端程序运行过程中一直有效。
	public static User currentUser;//当前用户
	public static List<User> onlineUsers;//当前在线用户
	public static Map<Long,JTextPane> individual;//私聊好友
	public static Set<Long> shield;//屏蔽发言
	
	private static void init(){
		Properties p=new Properties();
		try {
			p.load(new FileInputStream("client_config.txt"));
		}  catch (IOException e) {
			JOptionPane.showMessageDialog(new JFrame(),"配置文件丢失或已损坏，请重新定义配置文件！");
			System.exit(0);
		}
		String hostName=p.getProperty("ServerIP");
		String port=p.getProperty("ServerPort");
		try {
			shield=new HashSet<Long>();
			onlineUsers=new ArrayList<User>();
			individual=new HashMap<Long,JTextPane>();
			socket=new Socket(hostName,Integer.parseInt(port));
			oos=new ObjectOutputStream(socket.getOutputStream());
			ois=new ObjectInputStream(socket.getInputStream());
		} catch (Exception e) {
			JOptionPane.showMessageDialog(new JFrame(),"不能建立网络连接，请检查配置参数！");
			System.exit(0);
		}
	}
	/**
	 * 客户端运行的主方法。
	 */
	public static void main(String[] args) {
		ClientMainClass.init();
		new LoginWindow().showMe();
	}

}
