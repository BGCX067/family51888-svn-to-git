using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Security.Cryptography;
using System.Collections.Specialized;
using System.IO;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.Net;
using PageAdmin;

public partial class Alipay_Return : System.Web.UI.Page
{
    /// <summary>
    /// created by sunzhizhi 2006.5.21,sunzhizhi@msn.com。
    /// </summary>
    /// 

    OleDbConnection conn;
    public string Pay_Result,SiteId;
    string UserName;
    public static string GetMD5(string s, string _input_charset)
    {

        /// <summary>
        /// 与ASP兼容的MD5加密算法
        /// </summary>
       
        MD5 md5 = new MD5CryptoServiceProvider();
        byte[] t = md5.ComputeHash(Encoding.GetEncoding(_input_charset).GetBytes(s));
        StringBuilder sb = new StringBuilder(32);
        for (int i = 0; i < t.Length; i++)
        {
            sb.Append(t[i].ToString("x").PadLeft(2, '0'));
        }
        return sb.ToString();
    }

    public static string[] BubbleSort(string[] r)
    {
        /// <summary>
        /// 冒泡排序法
        /// </summary>

        int i, j; //交换标志 
        string temp;

        bool exchange;

        for (i = 0; i < r.Length; i++) //最多做R.Length-1趟排序 
        {
            exchange = false; //本趟排序开始前，交换标志应为假

            for (j = r.Length - 2; j >= i; j--)
            {
                if (System.String.CompareOrdinal(r[j + 1], r[j]) < 0)　//交换条件
                {
                    temp = r[j + 1];
                    r[j + 1] = r[j];
                    r[j] = temp;

                    exchange = true; //发生了交换，故将交换标志置为真 
                }
            }

            if (!exchange) //本趟排序未发生交换，提前终止算法 
            {
                break;
            }

        }
        return r;
    }
    //获取远程服务器ATN结果
    public String Get_Http(String a_strUrl, int timeout)
    {
        string strResult;
        try
        {

            HttpWebRequest myReq = (HttpWebRequest)HttpWebRequest.Create(a_strUrl);
            myReq.Timeout = timeout;
            HttpWebResponse HttpWResp = (HttpWebResponse)myReq.GetResponse();
            Stream myStream = HttpWResp.GetResponseStream();
            StreamReader sr = new StreamReader(myStream, Encoding.Default);
            StringBuilder strBuilder = new StringBuilder();
            while (-1 != sr.Peek())
            {
                strBuilder.Append(sr.ReadLine());
            }

            strResult = strBuilder.ToString();
        }
        catch (Exception exp)
        {

            strResult = "错误：" + exp.Message;
        }

        return strResult;
    }

 public string  Get_Alipay()
     {
       string sql="select onlinepay_key,onlinepay_partnerid from pa_onlinepay where onlinepay_type='alipay'";
       string Val;
       OleDbCommand comm=new OleDbCommand(sql,conn);
       OleDbDataReader dr=comm.ExecuteReader();
       if(dr.Read())  
        { 
           Val=dr["onlinepay_key"].ToString()+","+dr["onlinepay_partnerid"].ToString();
        }
      else
        {
          Val="";
          Response.Write("Error");
          Response.End();
        }
       return Val;
     }


    protected void Page_Load(object sender, EventArgs e)
    {
       if(Request.Cookies["site"]==null)
        {
          Response.Write("<script type='text/javascript'>alert('invalid siteid!');</script>");
          Response.End();
          return;
        }
      else if(!IsNum(Request.Cookies["site"].Value))
        {
          Response.Write("<script type='text/javascript'>alert('invalid siteid!');</script>");
          Response.End();
          return;
        }
       SiteId=Request.Cookies["site"].Value;
       Member_Valicate MCheck=new Member_Valicate();
       MCheck.Member_Check(true,SiteId);
       UserName=Request.Cookies["Member"].Values["UserName"].ToString();

       PageAdmin.Conn Myconn=new PageAdmin.Conn();
       string constr=Myconn.Constr();
       conn=new OleDbConnection(constr);
       conn.Open();

     //***************************************************************     
        string alipayNotifyURL = "https://www.alipay.com/cooperate/gateway.do?";
        string[] Alipay_Val=Get_Alipay().Split(',');
        string key = Alipay_Val[0]; //partner 的对应交易安全校验码（必须填写）
        string _input_charset = "utf-8";
        string partner = Alipay_Val[1]; 		//partner合作伙伴id（必须填写）

        alipayNotifyURL = alipayNotifyURL + "service=notify_verify" + "&partner=" + partner + "&notify_id=" + Request.QueryString["notify_id"];

        //获取支付宝ATN返回结果，true是正确的订单信息，false 是无效的
        string responseTxt = Get_Http(alipayNotifyURL, 120000);
        int i;
        NameValueCollection coll;
        //Load Form variables into NameValueCollection variable.
        coll = Request.QueryString;

        // Get names of all forms into a string array.
        String[] requestarr = coll.AllKeys;





        //进行排序；
        string[] Sortedstr = BubbleSort(requestarr);

       /* for (i = 0; i < Sortedstr.Length; i++)
       { 
          Response.Write("Form: " + Sortedstr[i] + "=" + Request.QueryString[Sortedstr[i]] + "<br>");
       }*/

        //构造待md5摘要字符串 ；

        StringBuilder prestr = new StringBuilder();

        for (i = 0; i < Sortedstr.Length; i++)
        {
            if (Request.Form[Sortedstr[i]] != "" && Sortedstr[i] != "sign" && Sortedstr[i] != "sign_type")
            {
                if (i == Sortedstr.Length - 1)
                {
                    prestr.Append(Sortedstr[i] + "=" + Request.QueryString[Sortedstr[i]]);
                }
                else
                {
                    prestr.Append(Sortedstr[i] + "=" + Request.QueryString[Sortedstr[i]] + "&");
                 
                }
            }

           
        }

        prestr.Append(key);
//**********************************************************************
        //生成Md5摘要；
       // string mysign = GetMD5(prestr.ToString(), _input_charset);
        string mysign = GetMD5(prestr.ToString(), _input_charset);
        string sign = Request.QueryString["sign"];
        string trade_status = Request.QueryString["trade_status"];

        //Response.Write(prestr.ToString());  //打印返回通知消息，接收到的

        if (mysign == sign && responseTxt == "true" && trade_status == "TRADE_FINISHED")   //验证支付发过来的消息，签名是否正确
        {

            //更新自己数据库的订单语句，请自己填写一下
               string Pay_Amount=Request.QueryString["total_fee"];
               string v_oid="alipay_"+Request.QueryString["trade_no"];
               double Fnc_Amount=double.Parse(Pay_Amount);
               if(!Fnc_rk(v_oid))
                {
                  Update_member_fnc(Fnc_Amount);
                  Update_fnc_list(Fnc_Amount,"支付宝",v_oid,"订单号:"+v_oid);
                  string M_body="支付方式：支付宝<br>订单号："+v_oid+"<br>支付金额："+Pay_Amount;
                  SendMail(M_body);
                }
               else
                {
                  Response.Write("<script>alert('此次支付已经成功转入到您的用户名下!')</script>");
                }
              conn.Close();
              Pay_Result="支付成功,金额已经转入您的会员名下";

	
            //Response.Write("success");     //返回给支付宝消息，成功（不用返回给支付宝）
//**************************************************************************
            //打印出接收通知。计算结果
            //Response.Write("------------------------------------------");
            //Response.Write("<br>Result:responseTxt=" + responseTxt);
            //Response.Write("<br>Result:mysign=" + mysign);
            //Response.Write("<br>Result:sign=" + sign);

        }
        else
        {
  //**************************************************************************
            //打印出接收通知。计算结果
            Response.Write("-------------------error-----------------------");
            Response.Write("<br>Result:responseTxt=" + responseTxt);
            Response.Write("<br>Result:mysign=" + mysign);
            Response.Write("<br>Result:sign=" + sign);
            Response.End();
        }

    }

public bool Fnc_rk(string OrderId)  //判断是否入款。
  {
   string sql="select id from pa_fnc_list where identification='"+OrderId+"' and thetype=1 and username='"+UserName+"'";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())  
     { 
       return true;
     }
   else
     {
       return false;
     }
   dr.Close();
  }


public void Update_member_fnc(double Fnc_Amount)
 {
     string sql="update pa_member set fnc_rk=fnc_rk+"+Fnc_Amount+",fnc_ky=fnc_ky+"+Fnc_Amount+" where username='"+UserName+"'";
     OleDbCommand Comm=new OleDbCommand(sql,conn);
     Comm.ExecuteNonQuery();
 }

public void Update_fnc_list(double Fnc_Amount,string Rk_way,string OrderId,string Beizhu)
 {
     string sql="insert into pa_fnc_list([site_id],[thetype],[username],[act],[amount],[detail],[identification],[beizhu]) values("+SiteId+",1,'"+UserName+"','c',"+Fnc_Amount+",'"+Rk_way+"','"+OrderId+"','"+Beizhu+"')";
     OleDbCommand Comm=new OleDbCommand(sql,conn);
     Comm.ExecuteNonQuery();

 }

private void  SendMail(string Mail_Body) //发邮件部分
 {
  string FajianName,MailTo,Mail_subject;
  string sql="select fajianname,em_fnc from pa_webset where site_id="+int.Parse(SiteId);
  OleDbCommand comm=new OleDbCommand(sql,conn);
  OleDbDataReader dr=comm.ExecuteReader();
  if(dr.Read())
   {
    FajianName=dr["fajianname"].ToString();
    MailTo=dr["em_fnc"].ToString();
    Mail_subject="来自"+FajianName+"的在线支付通知";
    if(MailTo!="")
     {
      PageAdmin.SendMail Mail=new PageAdmin.SendMail(int.Parse(SiteId));   
      bool sendresult=Mail.Send(MailTo,"","",Mail_subject,Mail_Body);//发邮件
     }
   } 
}


private bool IsNum(string str)
 {
  string str1="1234567890";
  if(str=="" ||   str==null)
   {
    return false;
   }

  for(int i=0;i<str.Length;i++)
   {
    if(str1.IndexOf(str[i])==-1)
     {
       return false;
     }
   }
  return true;
 }


}
