package qq.client.windows;
/**
 * @author Hehaizhou
 * 登录窗口
 */
import java.awt.Container;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.EOFException;

import javax.swing.BoxLayout;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import qq.client.*;
import qq.client.panel.*;
import qq.entity.*;

public class LoginWindow extends JFrame {
	private static final long serialVersionUID = 11896163L;
	private LoginTopPanel top;
	private LoginArea loginArea;
	private LoginPanel login;
	
	public LoginWindow(){
		super("Tencent Messenger");
		Container container = this.getContentPane();
		container.setLayout(new BoxLayout(container, BoxLayout.Y_AXIS));
		
		top=new LoginTopPanel();
		loginArea=new LoginArea();
		login=new LoginPanel();
		
		container.add(top);
		container.add(loginArea);
		container.add(login);
		addHanderListener();
	}
	
	private void addHanderListener(){
		login.getBtnCancer().addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				loginArea.getNameField().setText("");
				loginArea.getPwdField().setText("");
			}
		});
		
		login.getBtnLoad().addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				load(loginArea.getNameField().getText().trim(),new String(loginArea.getPwdField().getPassword()).trim());
			}
		});
		//注册
		login.getBtnRegister().addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				Request req=new Request(RequestType.register);
				try {
					ClientMainClass.oos.writeObject(req);
					ClientMainClass.oos.write(1);
					ClientMainClass.oos.flush();
					User user=(User)ClientMainClass.ois.readObject();
					if(user!=null){
						JOptionPane.showMessageDialog(null,"恭喜您! 注册成功!\n用户id : "+user.getId()+"\n密码 : "+user.getPwd());
					}
					loginArea.getNameField().requestFocusInWindow();
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		});
		
		this.addWindowListener(new WindowAdapter(){
			@Override
			public void windowClosing(WindowEvent e) {
				try {
					Request req=new Request(RequestType.exit);
					ClientMainClass.oos.writeObject(req);
					ClientMainClass.oos.flush();
					System.exit(0);		
				}catch (EOFException e2) {
					
				}catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		});
	}
	//登录验证
	private void load(String id,String pwd){
		if(id.equals("")){
			JOptionPane.showMessageDialog(null,"请输入用户名");
			loginArea.getNameField().requestFocusInWindow();
		}else if(pwd.equals("") ){
			JOptionPane.showMessageDialog(null,"请输入密码");
			loginArea.getPwdField().requestFocusInWindow();
		}else{	
			try {
				Request req=new Request(RequestType.login);
				req.setData("id",id);
				req.setData("pwd",pwd);
				ClientMainClass.oos.writeObject(req);//发送登录请求
				ClientMainClass.oos.write(1);//
				ClientMainClass.oos.flush();
				Response res=(Response)ClientMainClass.ois.readObject();
				User user=(User)res.getData();
				if(res.getType().equals(RequestType.haveOnline)){
					JOptionPane.showMessageDialog(this,"对不起，此用户已经在线!");
				}else if(user!=null&&res.getType().equals(RequestType.online)){
					ClientMainClass.currentUser=user;
					int n=ClientMainClass.ois.read();
					for(int i=0;i<n;i++){
						ClientMainClass.onlineUsers.add((User)ClientMainClass.ois.readObject());
					}
					this.dispose();
					new ClientMainWindow().showMe();
				}else{
					JOptionPane.showMessageDialog(this,"对不起，用户名或密码不正确，请重新输入！");
				}
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}
	}
	
	public void showMe(){
		this.setSize(new Dimension(360,230));
		this.setLocation(300,200);				
		this.setVisible(true);
		this.setResizable(false);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}

}
