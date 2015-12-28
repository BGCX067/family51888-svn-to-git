package qq.client.panel;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.List;
import javax.swing.*;
import javax.swing.border.Border;
import javax.swing.tree.TreePath;

import qq.client.ClientMainClass;
import qq.entity.User;

public class UserListPanel extends JPanel {

	private static final long serialVersionUID = 1252421L;
	private JTree tree ;
	private MyTreeModel m;
	
	public UserListPanel() {
		Border line = BorderFactory.createLineBorder(new Color(74,133, 213));
		this.setLayout(new BorderLayout());
		this.setBorder(line);
		m=new MyTreeModel(ClientMainClass.onlineUsers);
		tree= new JTree(m);
		tree.setCellRenderer(new MyTreeCellRenderer());
		tree.addMouseListener(new MouseAdapter(){
			@Override
			public void mouseClicked(MouseEvent e) {
				//右键菜单
				if(e.getButton()==MouseEvent.BUTTON3){
					TreePath pt=tree.getPathForLocation(e.getX(), e.getY());
					if(pt!=null){
						Object obj=pt.getLastPathComponent();
						if (obj instanceof User) {
							User user = (User) obj;
							new MouseRightMenu(user).show(tree, e.getX(), e.getY());
						}			
					}
				}
			}
		});
		JScrollPane jsp=new JScrollPane(tree); 
		this.add(jsp);
	}

	public void freash(List<User> onlineUsers){
		m.setRoot(onlineUsers);
		SwingUtilities.invokeLater(new Runnable() {
			public void run() {
				SwingUtilities.updateComponentTreeUI(tree);
			}
		});
		
		
	}
}
