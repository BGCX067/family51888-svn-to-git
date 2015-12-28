package com.oa.util;
import java.util.Hashtable;   

	/**  
	 * @author hxb  
	 *  
	 */  
	public class WeatherObj {   
	  
	    public static final String REGIONFIRST = "_regionFirst";//�ϼ�������   
	    public static final String REGIONSECOND = "_regionSecond";//����������   
	    public static final String REGIONID = "_regionId";//������id   
	    public static final String REGIONPIC = "_regionPic";//������ͼƬ   
	    public static final String REPORTTIME = "_reportTime";//�����ϱ�ʱ��   
	    
	    
	    public static final String TODAYTEMPERATURE = "_todayTemperature";//�����¶�   
	    public static final String TODAYDATE = "_todayDate";//��������   
	    public static final String TODAYWIND = "_todayWind";//������   
	    public static final String TODAYPIC_1 = "_todayPic_1";//��������ͼƬ1   
	    public static final String TODAYPIC_2 = "_todayPic_2";//��������ͼƬ2   
	    public static final String TODAYDETAIL = "_todayDetail";//��������ʵ��   
	    public static final String ZHISHU = "_zhiShu";//����ָ��   
	    
	    /*public static final String CHUANYIZHISHU = "����ָ����";   
	    public static final String GANMAOZHISHU = "��ðָ����";   
	    public static final String CHENLIANZHISHU = "����ָ����";   
	    public static final String JIAOTONGZHISHU = "��ָͨ����";   
	    public static final String LIANGSHAIZHISHU = "��ɹָ����";   
	    public static final String LVYOUZHISHU = "����ָ����";   
	    public static final String LUKUANGZHISHU = "·��ָ����";   
	    public static final String SHUSHIDUZHISHU = "���ʶ�ָ����";   */
	 /*   
	    public static final String CHUANYIZHISHU = "����ָ����";   
	    public static final String GUOMINZHISHU = "����ָ����";   
	    public static final String YUANDONGZHISHU = "�˶�ָ����";   
	    public static final String LIANGSHAIZHISHU = "��ɹָ����";   
	    public static final String LVYOUZHISHU = "����ָ����";   
	    public static final String LUKUANGZHISHU = "·��ָ����";   
	    public static final String SHUSHIDUZHISHU = "���ʶ�ָ����";   
	    public static final String KONGQIWURANGZHISHU="������Ⱦָ����";
	    */
	    public static final String TOMORROWTEMPERATURE = "_tomorrowTemperature";//�����¶�   
	    public static final String TOMORROWDATE = "_tomorrowDate";//��������   
	    public static final String TOMORROWWIND = "_tomorrowWind";//������   
	    public static final String TOMORROWPIC_1 = "_tomorrowPic_1";//��������ͼƬ1   
	    public static final String TOMORROWPIC_2 = "_tomorrowPic_2";//��������ͼƬ2   
	    
	    
	    
	    public static final String AFTERTOMORROWTEMPERATURE = "_affterTomorrowTemperature";//�����¶�   
	    public static final String AFTERTOMORROWDATE = "_affterTomorrowDate";//��������   
	    public static final String AFTERTOMORROWWIND = "_affterTomorrowWind";//������   
	    public static final String AFTERTOMORROWPIC_1 = "_affterTomorrowPic_1";//��������ͼƬ1   
	    public static final String AFTERTOMORROWPIC_2 = "_affterTomorrowPic_2";//��������ͼƬ2   
	    public static final String DESCRIPT = "_descript";//���ؽ���   
	       
	    public static final Hashtable<Integer,String> input = new Hashtable<Integer,String>(0);//������������Ӧ   
	       
	    static{   
	        input.put(0, REGIONFIRST);   
	        input.put(1, REGIONSECOND);   
	        input.put(2, REGIONID);   
	        input.put(3, REGIONPIC);   
	        input.put(4, REPORTTIME);   
	           
	        input.put(5, TODAYTEMPERATURE);   
	        input.put(6, TODAYDATE);   
	        input.put(7, TODAYWIND);   
	        input.put(8, TODAYPIC_1);   
	        input.put(9, TODAYPIC_2);   
	        input.put(10, TODAYDETAIL);   
	           
	        input.put(11, ZHISHU);   
	           
	        input.put(12, TOMORROWTEMPERATURE);   
	        input.put(13, TOMORROWDATE);   
	        input.put(14, TOMORROWWIND);   
	        input.put(15, TOMORROWPIC_1);   
	        input.put(16, TOMORROWPIC_2);   
	           
	        input.put(17, AFTERTOMORROWTEMPERATURE);   
	        input.put(18, AFTERTOMORROWDATE);   
	        input.put(19, AFTERTOMORROWWIND);   
	        input.put(20, AFTERTOMORROWPIC_1);   
	        input.put(21, AFTERTOMORROWPIC_2);   
	           
	        input.put(22, DESCRIPT);   
	    }   
	       
	    private String name;   
	       
	    private String message;   
	  
	    public String getMessage() {   
	        return message;   
	    }   
	  
	    public void setMessage(String message) {   
	        this.message = message;   
	    }   
	  
	    public String getName() {   
	        return name;   
	    }   
	  
	    public void setName(String name) {   
	        this.name = name;   
	    }   

	}


