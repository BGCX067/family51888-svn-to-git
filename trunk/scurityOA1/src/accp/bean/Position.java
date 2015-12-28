package accp.bean;
/**
 * 员工职位
 * @author liangrui
 *
 */
public class Position implements java.io.Serializable {
	private Long id;
	private String name_cn;//汉语
	private String name_en;//英语
	//private Set user=new HashSet();//一对多 非重点，暂不配
	
	
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
