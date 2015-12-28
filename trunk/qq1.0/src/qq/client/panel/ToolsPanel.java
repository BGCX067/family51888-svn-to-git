package qq.client.panel;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Insets;

import javax.swing.*;
import javax.swing.border.Border;

/**
 * @author haizhou
 * 选择表情，设置字体
 */

public class ToolsPanel extends JPanel{
	private static final long serialVersionUID = 1552162L;
	private JButton face;
	private JButton font;
	private JButton color;

	public ToolsPanel(){
		this.setLayout(new FlowLayout(FlowLayout.LEADING,20,2));
		this.setBackground(new Color(244, 249, 254));
		Border line = BorderFactory.createLineBorder(new Color(74,133, 213));
		this.setBorder(line);
		ImageIcon icon=new ImageIcon("qq/images/image/font.gif");
		font=new JButton(icon);
		font.setBorderPainted(false);
		font.setFocusPainted(false);
		font.setMargin(new Insets(0,0,0,0));
		font.setActionCommand("字体");
		
		icon=new ImageIcon("qq/images/image/color.gif");
		color=new JButton(icon);
		color.setBorderPainted(false);
		color.setFocusPainted(false);
		color.setMargin(new Insets(0,0,0,0));
		color.setActionCommand("颜色");
		
		icon=new ImageIcon("qq/images/image/face.gif");
		face=new JButton(icon);
		face=new JButton(icon);
		face.setBorderPainted(false);
		face.setFocusPainted(false);
		face.setMargin(new Insets(0,0,0,0));
		face.setActionCommand("表情");
		
		this.add(font);
		this.add(color);
		this.add(face);
		this.setSize(new Dimension(5,5));
	}

	public JButton getColorButton() {
		return color;
	}

	public JButton getFaceButton() {
		return face;
	}

	public JButton getFontButton() {
		return font;
	}
	
}
