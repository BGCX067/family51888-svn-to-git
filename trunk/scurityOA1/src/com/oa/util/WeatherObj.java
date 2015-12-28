package com.oa.util;
import java.util.Hashtable;   

	/**  
	 * @author hxb  
	 *  
	 */  
	public class WeatherObj {   
	  
	    public static final String REGIONFIRST = "_regionFirst";//上级行政区   
	    public static final String REGIONSECOND = "_regionSecond";//本级行政区   
	    public static final String REGIONID = "_regionId";//行政区id   
	    public static final String REGIONPIC = "_regionPic";//行政区图片   
	    public static final String REPORTTIME = "_reportTime";//最新上报时间   
	    
	    
	    public static final String TODAYTEMPERATURE = "_todayTemperature";//今天温度   
	    public static final String TODAYDATE = "_todayDate";//今天日期   
	    public static final String TODAYWIND = "_todayWind";//今天风况   
	    public static final String TODAYPIC_1 = "_todayPic_1";//今天天气图片1   
	    public static final String TODAYPIC_2 = "_todayPic_2";//今天天气图片2   
	    public static final String TODAYDETAIL = "_todayDetail";//今天天气实况   
	    public static final String ZHISHU = "_zhiShu";//各个指数   
	    
	    /*public static final String CHUANYIZHISHU = "穿衣指数：";   
	    public static final String GANMAOZHISHU = "感冒指数：";   
	    public static final String CHENLIANZHISHU = "晨练指数：";   
	    public static final String JIAOTONGZHISHU = "交通指数：";   
	    public static final String LIANGSHAIZHISHU = "晾晒指数：";   
	    public static final String LVYOUZHISHU = "旅游指数：";   
	    public static final String LUKUANGZHISHU = "路况指数：";   
	    public static final String SHUSHIDUZHISHU = "舒适度指数：";   */
	 /*   
	    public static final String CHUANYIZHISHU = "穿衣指数：";   
	    public static final String GUOMINZHISHU = "过敏指数：";   
	    public static final String YUANDONGZHISHU = "运动指数：";   
	    public static final String LIANGSHAIZHISHU = "晾晒指数：";   
	    public static final String LVYOUZHISHU = "旅游指数：";   
	    public static final String LUKUANGZHISHU = "路况指数：";   
	    public static final String SHUSHIDUZHISHU = "舒适度指数：";   
	    public static final String KONGQIWURANGZHISHU="空气污染指数：";
	    */
	    public static final String TOMORROWTEMPERATURE = "_tomorrowTemperature";//明天温度   
	    public static final String TOMORROWDATE = "_tomorrowDate";//明天日期   
	    public static final String TOMORROWWIND = "_tomorrowWind";//明天风况   
	    public static final String TOMORROWPIC_1 = "_tomorrowPic_1";//明天天气图片1   
	    public static final String TOMORROWPIC_2 = "_tomorrowPic_2";//明天天气图片2   
	    
	    
	    
	    public static final String AFTERTOMORROWTEMPERATURE = "_affterTomorrowTemperature";//后天温度   
	    public static final String AFTERTOMORROWDATE = "_affterTomorrowDate";//后天日期   
	    public static final String AFTERTOMORROWWIND = "_affterTomorrowWind";//后天风况   
	    public static final String AFTERTOMORROWPIC_1 = "_affterTomorrowPic_1";//后天天气图片1   
	    public static final String AFTERTOMORROWPIC_2 = "_affterTomorrowPic_2";//后天天气图片2   
	    public static final String DESCRIPT = "_descript";//本地介绍   
	       
	    public static final Hashtable<Integer,String> input = new Hashtable<Integer,String>(0);//常量与数量对应   
	       
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


