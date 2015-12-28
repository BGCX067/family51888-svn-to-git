package qq.client.panel;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.BorderFactory;
import javax.swing.JTextPane;
import javax.swing.SwingConstants;
import javax.swing.border.Border;
/**
 * 公告面板
 * @author Hehaizhou
 *
 */
public class PublicInfoPanel extends JPanel{
	
	private static final long serialVersionUID = 14257854L;
	private JTextPane textpane;
	
	public PublicInfoPanel(){
		Border line = BorderFactory.createLineBorder(new Color(74,133, 213));
		this.setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
		//公告栏
		JPanel panelTitle = new JPanel();
		panelTitle.setBackground(new Color(244, 249, 254));
		panelTitle.setLayout(new FlowLayout(FlowLayout.LEADING,2,0));
		ImageIcon icon=new ImageIcon("images/image/message.gif");
		JLabel label = new JLabel("               公告栏         ",icon,SwingConstants .CENTER);
		panelTitle.add(label);
		panelTitle.setBorder(line);
		panelTitle.setPreferredSize(new Dimension(200,25));
		//最新公告内容
		
		textpane = new JTextPane();
		textpane.setText("\n	欢迎使用\n 功能进一步完善中 author Herb");
		textpane.setEditable(false);
		textpane.setBorder(line);
		this.setPreferredSize(new Dimension(200,150));
		this.add(panelTitle);
		this.add(textpane);
	}
	/**
	 * 返回公告面板
	 * @return
	 */
	public JTextPane getTextpane() {
		return textpane;
	}

}
