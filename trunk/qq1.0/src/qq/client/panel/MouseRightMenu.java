package qq.client.panel;

import java.awt.HeadlessException;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.io.ObjectOutputStream;

import javax.swing.*;
import qq.client.*;
import qq.client.windows.IndividualTalkWindow;
import qq.entity.*;

public class MouseRightMenu extends JPopupMenu implements ActionListener {
	
	private static final long serialVersionUID = 1157615L;
	private User user;
	private JMenuItem information;
	private JMenuItem individual;
	private JMenuItem sendFile;
	private JMenuItem shield;
	
	public MouseRightMenu(User user) throws HeadlessException {
		super();
		this.user = user;
		this.information = new JMenuItem("查看信息");
		this.individual = new JMenuItem("私聊");
		this.shield=new JMenuItem("屏蔽发言");
		this.sendFile = new JMenuItem("发送文件");
		init();
	}

	private void init(){
		this.add(information);
		this.add(individual);
		this.add(shield);
		this.add(sendFile);
		shield.addActionListener(this);
		information.addActionListener(this);
		individual.addActionListener(this);
	}
	
	public void actionPerformed(ActionEvent e) {
		if (e.getSource()==information) {
			new FriendInformation(user).showMe();
		} else if (e.getSource()==individual) {
			IndividualTalkWindow indi=new IndividualTalkWindow(user);
			ClientMainClass.individual.put(user.getId(), indi.getReceivedmessageArea().getTextPane());
			indi.showMe();
		} else if (e.getSource()==sendFile) {
			sendFile();
		}else{
			ClientMainClass.shield.add(user.getId());
		}
	}

	private void sendFile(){
//		ObjectOutputStream oos=ClientMainClass.oos;
//		
//		try {
//			oos.writeObject(new Request(RequestType.sendFile));
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
	}
}
