package qq.server;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.*;

import qq.dao.hibernate.IServiceDao;
import qq.entity.*;

public class ServerController {
	private User user;
	private Socket s;
	private IServiceDao dao;
	private ObjectInputStream ois;
	private ObjectOutputStream oos;
	private OnlineUser onlineUser;
	
	public ServerController(Socket s) {
		super();
		dao=ServerMainClass.userDao;
		this.s = s;
	}
	 
	public void handle() throws Exception {
		ois=new ObjectInputStream(s.getInputStream());
		oos=new ObjectOutputStream(s.getOutputStream());
		onlineUser=new OnlineUser(ois,oos);
		while(true){
			Request req=(Request)ois.readObject();
			RequestType type=req.getType();
			if(type.equals(RequestType.exit)){
				exitHandle();
				break;
			}else if(type.equals(RequestType.login)){
				loginHandle(req);
			}else if(type.equals(RequestType.register)){
				registerHandle();
			}else if(type.equals(RequestType.offline)){
				offlineHandle();
				break;
			}else if(type.equals(RequestType.changeInformation)){
				changeInformationHandle();
			}else if(type.equals(RequestType.modifypasswd)){
				modifypasswdHandle(req);
			}else if(type.equals(RequestType.sendMessage)){
				sendMessageHandle(req);
			}else if(type.equals(RequestType.receiveFile)){
				receiveFileHandle(req);
			}else if(type.equals(RequestType.sendFile)){
				sendFileHandle(req);
			}
			ois.read();
		}
	}
	private void modifypasswdHandle(Request req) {
		Long id=Long.parseLong(req.getData("id"));
		String oldpwd=req.getData("oldpwd");
		String newpwd=req.getData("newpwd");
		Response res=new Response(RequestType.modifypasswd);
		try {
			dao.updatePwd(id, oldpwd, newpwd);
			res.setData(1);
			try {
				oos.writeObject(res);
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch (RuntimeException e) {
			try {
				oos.writeObject(res);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
	}

	private void changeInformationHandle() {
		try {
			User user=(User)ois.readObject();
			Response res=new Response(RequestType.changeInformation);
			try {
				dao.updateUser(user);
				res.setData(1);//修改成功返回值带一个整形值
				oos.writeObject(res);
				oos.flush();
			} catch (RuntimeException e) {
				oos.writeObject(res);//失败则返回值不带参数
				oos.flush();
				e.printStackTrace();
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	private void exitHandle() {
		try {
			s.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//发送文件
	private void sendFileHandle(Request req) {
//		try {
//			User u=(User)ois.readObject();
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		} 
	}
	//接受文件
	private void receiveFileHandle(Request req) {
		
	}
		
	//发送消息
	private void sendMessageHandle(Request req) {
		Response res=new Response(RequestType.receiveMessage);
		Message message=null;
		try {
			message=(Message)ois.readObject();
			res.setData(message);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		User to=message.getTo();
		if(to==null){
			sendToAllUser(res);//如果收信人为null，则发送信息给所有人
		}else{
			//发送信息给to和他自己
			Response res1=new Response(RequestType.individualTalk);
			res1.setData(message);
			ObjectOutputStream o=null;
			Set<User>set=ServerMainClass.userMap.keySet();
			Iterator it=set.iterator();
			while(it.hasNext()){
				User u=(User)it.next();
				if(u.equals(to)){
					o=ServerMainClass.userMap.get(u).getOos();
					break;
				}				
			}
			try {
				o.writeObject(res1);
				o.flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	//下线
	private void offlineHandle() {
		try {
			ServerMainClass.userMap.remove(user);
			Response res=new Response(RequestType.offline);
			res.setData(user);//把下线用户发送给所有客户端
			sendToAllUser(res);
			s.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void registerHandle() {
		User user=dao.addUser();
		try {
			oos.writeObject(user);
			System.out.println(user.getId()+":"+user.getName());
			oos.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//登录
	private void loginHandle(Request req) {
		Long id=Long.parseLong((String)req.getData("id"));
		String pwd=(String)req.getData("pwd");
		user=dao.getUser(id,pwd);
		Response res;
		try {
			Set<User>users=ServerMainClass.userMap.keySet();
			Iterator iter=users.iterator();
			while(iter.hasNext()){
				User u=(User)iter.next();
				if(u.equals(user)){
					res=new Response(RequestType.haveOnline);
					oos.writeObject(res);
					oos.flush();
					return;//该用户已经在线
				}				
			}
			res=new Response(RequestType.online);
			res.setData(user);
			oos.writeObject(res);
			oos.flush();
//				给刚上线用户发送在线用户列表
			if(user!=null){
				Set<User>set=ServerMainClass.userMap.keySet();
				oos.write(set.size());
				Iterator it=set.iterator();
				while(it.hasNext()){
					oos.writeObject(it.next());
				}
				oos.flush();
				sendToAllUser(res);//通知在线用户有新用户上线
				ServerMainClass.userMap.put(user, onlineUser);//保存用户信息
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void sendToAllUser(Response res){
		try {
			 Collection c= ServerMainClass.userMap.values();
			Iterator it=c.iterator();
			while(it.hasNext()){
				ObjectOutputStream o=((OnlineUser)it.next()).getOos();
				o.writeObject(res);
				o.flush();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
