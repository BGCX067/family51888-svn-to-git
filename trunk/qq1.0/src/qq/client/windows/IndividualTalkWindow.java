package qq.client.windows;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Container;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.IOException;
import java.util.Calendar;

import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.JColorChooser;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextPane;
import javax.swing.text.BadLocationException;
import javax.swing.text.Document;
import javax.swing.text.Element;
import javax.swing.text.SimpleAttributeSet;
import javax.swing.text.StyleConstants;

import qq.client.ClientMainClass;
import qq.client.panel.FacePanel;
import qq.client.panel.FriendInformation;
import qq.client.panel.MessageReceivedArea;
import qq.client.panel.MessageRecordArea;
import qq.client.panel.MessageWritingArea;
import qq.client.panel.MyFontChooser;
import qq.client.panel.SendButtonPanel;
import qq.client.panel.ToolsPanel;
import qq.client.panel.UserInfoPanel;
import qq.entity.Message;
import qq.entity.Request;
import qq.entity.RequestType;
import qq.entity.User;

public class IndividualTalkWindow extends JFrame implements ActionListener{
	private static final long serialVersionUID = 1664152L;
	private UserInfoPanel userInfoPanel;
	private MessageReceivedArea receivedmessageArea;
	private ToolsPanel toolsPanel;
	private MessageWritingArea sendingMessageArea;
	private SendButtonPanel sendButtonPanel;
	private MessageRecordArea recordArea;
	private User user;
	
	public IndividualTalkWindow(User user) {
		super("与"+user.getName()+"聊天");
		this.user=user;
		this.userInfoPanel = new UserInfoPanel(user);
		this.receivedmessageArea = new MessageReceivedArea();
		this.toolsPanel = new ToolsPanel();
		this.sendingMessageArea=new MessageWritingArea();
		this.sendButtonPanel = new SendButtonPanel();
		this.recordArea=new MessageRecordArea();
		init();
		addHanderListener();
		sendingMessageArea.getTextPane().requestFocusInWindow();
	}

	public void init(){
		Container container = this.getContentPane();
		JPanel leftPanel = new JPanel();  
		leftPanel.setBorder(BorderFactory.createLineBorder(new Color(216,239, 254),5));
		leftPanel.setLayout(new BoxLayout(leftPanel, BoxLayout.Y_AXIS)); //左边面板box布局  
		
		leftPanel.add(userInfoPanel);//左边面板添加组件
		leftPanel.add(receivedmessageArea);
		leftPanel.add(toolsPanel);
		leftPanel.add(sendingMessageArea);
		leftPanel.add(sendButtonPanel);
 		
		container.add(leftPanel, BorderLayout.CENTER);
	}
	
	public void addHanderListener(){
		this.addWindowListener(new WindowAdapter(){
			@Override
			public void windowClosing(WindowEvent e) {
				dispose();
			}
		});
		userInfoPanel.addMouseListener(new MouseAdapter(){

			@Override
			public void mouseClicked(MouseEvent e) {
				if(e.getButton()==MouseEvent.BUTTON1){
					new FriendInformation(user).showMe();
				}
			}
		});
		toolsPanel.getFontButton().addActionListener(this);
		toolsPanel.getColorButton().addActionListener(this);
		toolsPanel.getFaceButton().addActionListener(this);
		sendButtonPanel.getRecordButton().addActionListener(this);
		sendButtonPanel.getSentButton().addActionListener(this);
		sendButtonPanel.getCloseButton().addActionListener(this);
	}
	
	public void actionPerformed(ActionEvent e) {
		if(e.getActionCommand().equals("聊天记录")){
			recordArea.setVisible(true);
			recordArea.setLocation(this.getX(),this.getY()+540);
		}else if(e.getActionCommand().equals("发送")){
			Document doc = sendingMessageArea.getTextPane().getDocument();
			Element root = doc.getDefaultRootElement();
			Message message=new Message(sendingMessageArea.getTextPane().getParagraphAttributes());
			message.setMessage(root);
			message.setFrom(ClientMainClass.currentUser);
			message.setTo(user);
			try {
				ClientMainClass.oos.writeObject(new Request(RequestType.sendMessage));
				ClientMainClass.oos.writeObject(message);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			sendingMessageArea.getTextPane().setText("");
			//输出到本面板
			SimpleAttributeSet set=new SimpleAttributeSet();
			StyleConstants.setFontSize(set, 16);
			StyleConstants.setFontFamily(set,"宋体");
			StyleConstants.setForeground(set, new Color(0,139,139));
			JTextPane jtp=receivedmessageArea.getTextPane();
			Calendar c = Calendar.getInstance();
			String time=c.get(Calendar.YEAR)+"-"+c.get(Calendar.MONTH)+"-"+c.get(Calendar.DAY_OF_MONTH)+" "+
					(c.get(Calendar.HOUR_OF_DAY)+8)+":"+c.get(Calendar.MINUTE)+":"+c.get(Calendar.SECOND);
			try {//输出信息发送人，时间
				jtp.getDocument().insertString(jtp.getDocument().getLength(),
												ClientMainClass.currentUser.getName()+" "+time+"\n",
												set);
//				输出信息
				message.analysisMessage(jtp);
			} catch (BadLocationException e1) {
				e1.printStackTrace();
			}
			
		}else if(e.getActionCommand().equals("关闭")){
			dispose();
		}else if(e.getActionCommand().equals("字体")){
			Font   font  =   MyFontChooser.showDialog(this,null,new Font("宋体",Font.BOLD,12));
			sendingMessageArea.getTextPane().setFont(font);
			sendingMessageArea.getTextPane().requestFocusInWindow();
		}else if(e.getActionCommand().equals("颜色")){
			Color c=JColorChooser.showDialog(this,"请选择文字颜色",Color.BLACK);
			sendingMessageArea.getTextPane().setForeground(c);
			sendingMessageArea.getTextPane().requestFocusInWindow();
		}else if(e.getActionCommand().equals("表情")){
			new FacePanel(sendingMessageArea.getTextPane()).setLocation(this.getX()+20,this.getY()+200);
			sendingMessageArea.getTextPane().requestFocusInWindow();
		}
	}
	
	public void showMe(){
		this.setSize(400,540);
		this.setLocation(250,100);
		this.setVisible(true);
		this.setResizable(false);
		this.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
	}

	public MessageReceivedArea getReceivedmessageArea() {
		return receivedmessageArea;
	}

	public void setReceivedmessageArea(MessageReceivedArea receivedmessageArea) {
		this.receivedmessageArea = receivedmessageArea;
	}
}
