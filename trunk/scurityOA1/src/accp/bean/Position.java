package accp.bean;
/**
 * Ա��ְλ
 * @author liangrui
 *
 */
public class Position implements java.io.Serializable {
	private Long id;
	private String name_cn;//����
	private String name_en;//Ӣ��
	//private Set user=new HashSet();//һ�Զ� ���ص㣬�ݲ���
	
	
	public Position(){}
	
	public Position(Long id, String name_cn, String name_en) {
		super();
		this.id = id;
		this.name_cn = name_cn;
		this.name_en = name_en;
	}
	//
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName_cn() {
		return name_cn;
	}
	public void setName_cn(String name_cn) {
		this.name_cn = name_cn;
	}
	public String getName_en() {
		return name_en;
	}
	public void setName_en(String name_en) {
		this.name_en = name_en;
	}
	
	
	
	
	

}
