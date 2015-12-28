package qq.client.panel;

import java.awt.Container;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JTabbedPane;

import qq.client.ClientMainClass;
import qq.entity.Request;
import qq.entity.RequestType;
import qq.entity.User;

public class UserManage extends JFrame{
	private static final long serialVersionUID = 2868561L;
	private UserInformationPanel info;
	private ModifyPasswdPanel pwd;
	
	public UserManage() {
		Container container = this.getContentPane();
		info=new UserInformationPanel(ClientMainClass.currentUser);
		pwd=new ModifyPasswdPanel();
		info.setPreferredSize(new Dimension(400,300));
		JTabbedPane pane = new JTabbedPane(JTabbedPane.TOP);
		pane.addTab("个人信息", info);
		pane.addTab("安全", pwd);
		container.add(pane);
		this.setSize(400, 300);
		this.setLocation(200, 120);
		this.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		this.setVisible(true);
		this.setResizable(false);
		info.getCancer().addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				dispose();
			}
		});
		info.getSure().addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				User user=ClientMainClass.currentUser;
				user.setName(info.getUserName().getText().trim());
				if(info.getMale().isSelected()){
					user.setSex('M');
				}else{
					user.setSex('F');
				}
				user.setIcon(String.valueOf(info.getFace().getSelectedIndex())+1);
				user.setMemo(info.getMemo().getText().trim());
				Request req=new Request(RequestType.changeInformation);
				try {
					ClientMainClass.oos.writeObject(req);
					ClientMainClass.oos.writeObject(user);
					ClientMainClass.oos.flush();
					dispose();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
		});
		pwd.getCancer().addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				dispose();
			}
		});
		pwd.getSure().addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				if(new String(pwd.getOldpwd().getPassword()).trim().equals("")){
					JOptionPane.showMessageDialog(null,"请输入旧密码");
					pwd.getOldpwd().requestFocusInWindow();
				}if(new String(pwd.getNewpwd().getPassword()).trim().equals("")){
					JOptionPane.showMessageDialog(null,"请输入新密码");
					pwd.getNewpwd().requestFocusInWindow();
				}else if(new String(pwd.getAgainpwd().getPassword()).trim().equals("")){
					JOptionPane.showMessageDialog(null,"请再次输入新密码");
					pwd.getAgainpwd().requestFocusInWindow();
				}else{
					if(new String(pwd.getNewpwd().getPassword()).equals(new String(pwd.getAgainpwd().getPassword()))){
						Request req=new Request(RequestType.modifypasswd);
						req.setData("id",String.valueOf(ClientMainClass.currentUser.getId()));
						req.setData("oldpwd", new String(pwd.getOldpwd().getPassword()));
						req.setData("newpwd", new String(pwd.getNewpwd().getPassword()));
						try {
							ClientMainClass.oos.writeObject(req);
							ClientMainClass.oos.write(1);
							ClientMainClass.oos.flush();
							dispose();
						} catch (IOException e1) {
							e1.printStackTrace();
						}
					}else{
						JOptionPane.showMessageDialog(null, "两次输入不一致");
						pwd.getNewpwd().requestFocusInWindow();
					}	
				}
			}
		});
	}
}
