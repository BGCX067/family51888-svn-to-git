package qq.server;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import qq.dao.hibernate.IServiceDao;
import qq.dao.hibernate.ServiceDaoImHbn;
import qq.entity.OnlineUser;
import qq.entity.User;

public class ServerMainClass {
	public static IServiceDao userDao;
	public static Map<User,OnlineUser> userMap;
	public static Properties pro;//初始化配置参数
	/**
	 * 静态初始化方法。
	 *
	 */
	public static void init(){
		pro=new Properties();
		try {
			pro.load(new FileInputStream("server_config.txt"));
		}catch (IOException e) {
			System.out.println("找不到配置文件或配置文件格式不正确！");
			e.printStackTrace();
		}
		userDao=new ServiceDaoImHbn();
		userMap=new HashMap<User,OnlineUser> ();
	}

	public static void main(String[] args) throws NumberFormatException, IOException {
		init();
		ServerSocket ss = null;
		ss = new ServerSocket(Integer.parseInt(pro.getProperty("ServerPort")));
		while (true) {
			Socket s = null;
			try {
				s = ss.accept();
				new ServerThread(s).start();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
