package qq.client.panel;

import java.awt.FlowLayout;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class LoginPanel extends JPanel {

	private static final long serialVersionUID = 1564163L;
	private JButton btnRegister;
	private JButton btnLoad;
	private JButton btnCancer;
	
	public LoginPanel(){
		btnRegister = new JButton("注册");
		btnLoad = new JButton("登录");
		btnCancer = new JButton("取消");
		JLabel label = new JLabel("                         ");
	
		this.setLayout(new FlowLayout(FlowLayout.LEADING, 10 ,10));
		this.add(btnRegister);
		this.add(label);
		this.add(btnLoad);
		this.add(btnCancer);
	}

	public JButton getBtnCancer() {
		return btnCancer;
	}

	public JButton getBtnLoad() {
		return btnLoad;
	}

	public JButton getBtnRegister() {
		return btnRegister;
	}

}
