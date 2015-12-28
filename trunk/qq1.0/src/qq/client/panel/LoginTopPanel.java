package qq.client.panel;

import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JPanel;

/**
 * @author Hehaizhou
 *顶部图片
 */
public class LoginTopPanel extends JPanel {
	
	private static final long serialVersionUID = 1157482L;

	public LoginTopPanel(){
		JLabel jl = new JLabel();
		ImageIcon icon = new ImageIcon("qq/images/image/Login.gif");
		if(icon != null){
			jl.setIcon(icon);
		}
		this.add(jl);
		this.setSize(353, 46);
	}

}
