using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Text.RegularExpressions;
namespace PageAdmin
 {
 public class order:Page
 {
  protected Repeater List;
  OleDbConnection conn;
  string Type_Id,UserName,DetailId,sql;
  protected string SiteId,Table,Tongji,Tongji_Point,ServerInfo;
  protected int RecordCounts;
  double MPrice;

  protected void Page_Load(Object sender,EventArgs e)
   {
     SiteId=Request.QueryString["s"];
     Table=Request.QueryString["table"];
     DetailId=Request.QueryString["id"];
     if(!IsNum(Request.QueryString["id"]))
      {
       DetailId="0";
      }
     if(!Page.IsPostBack)
      {
        Conn Myconn=new Conn();
        conn=new OleDbConnection(Myconn.Constr());
        if(Request.Form["post"]!=null)
         {
            conn.Open();
             Set_Car();
            conn.Close();
         }
        else
         {
           if(IsNum(SiteId))
           {
             Member_Check();
             if(IsUserName(UserName))
             {
              conn.Open();
              if(IsNum(DetailId) && IsStr(Table))
               {
                Add_Prod();
               }
              Get_Total();
              Data_Bind();
              conn.Close();
             }
           }
  
        }
      }
    
   }


private void Member_Check()
  {
     if(Request.Cookies["Member"]==null)
        {
          UserName="";
          Type_Id="";
          string fun="quick_login(\""+SiteId+"\",\"ordercart('"+SiteId+"','"+Table+"',"+DetailId+")\")";
          fun=fun.Replace("\"","\\\"");
          Response.Write("<script type='text/javascript'>parent.CloseDialog(\""+fun+"\")</"+"script>");
          Response.End();
        }
      else
        {
          Member_Valicate Mck=new Member_Valicate();
          Mck.Member_Check();
          UserName=Mck._UserName;
          Type_Id=(Mck._MemberTypeId).ToString();
        }
  }

private void Data_Bind()
 { 
   if(UserName==""){return;}
   sql="select id,title,thetable,detail_id,member_price,num,(sendpoint*num) as count_sendpoint,(member_price*num) as tj from pa_orderlist where username='"+UserName+"' and state=0";
   DataSet ds=new DataSet();
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   myAdapter.Fill(ds,"tb");
   RecordCounts=ds.Tables["tb"].Rows.Count;
   if(RecordCounts>0)
    {
       List.DataSource=ds.Tables["tb"].DefaultView;
       List.DataBind();
    }
 }

private void Get_Total()
 {  
   sql="select sum(member_price*num) as Tj,sum(sendpoint*num) as Tj_Point from pa_orderlist where username='"+UserName+"' and state=0";
   OleDbCommand comm=new OleDbCommand (sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
      Tongji_Point=dr["Tj_Point"].ToString();
      Tongji=dr["Tj"].ToString();
    }
   else
    {
      Tongji_Point="0";
      Tongji="0";
    }
   dr.Close();
 }

private void Add_Prod()
  {
    int Id=int.Parse(DetailId);
    if(Id==0)
     {
      return;
     }
    sql="select title,price,member_price,reserves,sendpoint from "+Table+" where id="+Id;
    OleDbCommand comm=new OleDbCommand (sql,conn);
    OleDbDataReader dr=comm.ExecuteReader();
    if(dr.Read())
     {
      string PdName=dr["title"].ToString();
      MPrice=GetPrice(dr["member_price"].ToString());
      if(MPrice==0 && IsFloat(dr["price"].ToString()))
       {
        MPrice=double.Parse(dr["price"].ToString());
       }
      int Number=1;
      if(dr["reserves"].ToString()=="0")
       {
         ServerInfo="NoReserves()";
         return;
       }
      else
       {
         Add_Order(Table,Id,Sql_Format(PdName),Number,MPrice,int.Parse(dr["sendpoint"].ToString()));
       }
     }
    dr.Close();
  }


private void Add_Order(string Table,int DetailId,string Title,int Number,double MPrice,int SendPoint)
 {
   sql="select id from pa_orderlist where username='"+UserName+"' and detail_id="+DetailId+" and thetable='"+Table+"' and state=0";
   OleDbCommand comm=new OleDbCommand (sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(!dr.Read())
    {
     sql="insert into pa_orderlist(username,thetable,detail_id,title,num,member_price,sendpoint) values('"+UserName+"','"+Table+"',"+DetailId+",'"+Title+"',"+Number+","+MPrice+","+SendPoint+")";
     comm=new OleDbCommand (sql,conn);
     comm.ExecuteNonQuery();
    }
   else
    {
      //dr.Close();
      //ServerInfo="AlreadyInOrder();";
    }
   dr.Close();
 }

protected string Get_Field(string Table,string Field,string DetailId)
 {
   string rv="";
   int HasTable=1;
   if(IsStr(Table) && IsStr(Field) && IsNum(DetailId))
    {
     OleDbCommand comm;
     OleDbDataReader dr;
     sql="select id from pa_table where thetable='"+Table+"'";
     comm=new OleDbCommand (sql,conn);
     dr=comm.ExecuteReader();
     if(!dr.Read())
     {
       HasTable=0;
     }
    dr.Close();
    if(HasTable==1)
     {
       sql="select "+Field+" from "+Table+" where id="+DetailId;
       comm=new OleDbCommand (sql,conn);
       dr=comm.ExecuteReader();
       if(dr.Read())
       {
        return dr[Field].ToString();
       }
       dr.Close();
     }
    }
   if(Field=="title_pic" && rv=="")
    {
     rv="/e/images/noimage.gif";
    }
   return rv;
 }

private double GetPrice(string MPrice)
 {
   string[] AMPrice=MPrice.Split('|');
   if(AMPrice.Length!=2)
    {
      return 0;
    }
   string[] AMtype=AMPrice[0].Split(',');
   string[] APrice=AMPrice[1].Split(',');
   int SiteNum=Array.IndexOf(AMtype,Type_Id);
   if(SiteNum>=0 && IsFloat(APrice[SiteNum]))
    {
      return double.Parse(APrice[SiteNum]);
    }
   else
    {
      return 0;
    }
 }

private void Set_Car()
 {
   string post=Request.Form["post"];
   string Ids=Request.Form["id"];
   string Did=Request.Form["delid"];
   string Nums=Request.Form["num"];
   string[] Aids=Ids.Split(',');
   string[] ANums=Nums.Split(',');
   OleDbCommand comm;
   switch(post)
    {
     case "edit":
      if(Ids!=null)
      {
        for(int i=0;i<Aids.Length;i++)
         {
          if(!IsNum(ANums[i])){continue;}
          sql="update pa_orderlist set num="+ANums[i]+" where id="+int.Parse(Aids[i]);
          comm=new OleDbCommand (sql,conn);
          comm.ExecuteNonQuery();
         }
        conn.Close();
      }
     Response.Write("<script type='text/javascript'>location.href='?s="+SiteId+"&table="+Table+"';</script>");
     Response.End();

     break;

     case "del":
      if(IsNum(Did))
       {
         sql="delete from pa_orderlist where id="+Did;
         comm=new OleDbCommand(sql,conn);
         comm.ExecuteNonQuery();
       }
      conn.Close();
     Response.Write("<script type='text/javascript'>location.href='?s="+SiteId+"&table="+Table+"';</script>");
     Response.End();
     break;
    }
 }

private bool IsUserName(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  Regex re = new Regex(@"[\u4e00-\u9fa5]+");
  str=re.Replace(str,"");
  if(str.Length==0){return true;}
  else{return IsStr(str);}
 }

private string Sql_Format(string str)
 {
   if(string.IsNullOrEmpty(str)){return "";}
   string Res=str.Replace("'","''");
   Res=Res.Replace("\"","\""); 
   return Res;
 }

private bool IsFloat(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="0123456789.";
  if((str.Length-str.Replace(".",String.Empty).Length)>1)
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

private bool IsStr(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="abcdefghijklmnopqrstuvwxyz0123456789_";
  string str2=str.ToLower();;
  for(int i=0;i<str2.Length;i++)
   {
    if(str1.IndexOf(str2[i])==-1)
     {
       return false;
     }
   }
  return true;
 }

private bool IsNum(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="0123456789";
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

 }