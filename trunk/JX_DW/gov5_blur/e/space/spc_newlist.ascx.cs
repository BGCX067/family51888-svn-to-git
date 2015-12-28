using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Text;
using System.Text.RegularExpressions;
namespace PageAdmin
 {
  public class spc_newlist:UserControl
  {
   protected Repeater P1,P2;
   OleDbConnection conn;
   protected string UID,UserName;
   int Is_Static;
   string Url_Prefix,TheTable,sql;
   protected void Page_Load(Object sender,EventArgs e)
    {
         Conn Myconn=new Conn();
         string constr=Myconn.Constr();//获取连接字符串
         conn=new OleDbConnection(constr);
         conn.Open();
           Table_Bind();
         conn.Close();
    }


private void Table_Bind()
  {
   sql="select id,thetable,table_name from pa_table where [inspace]=1 order by xuhao";
   DataSet ds=new DataSet();
   OleDbDataAdapter myadapter=new OleDbDataAdapter(sql,conn);
   myadapter.Fill(ds,"tb");
   if(ds.Tables["tb"].Rows.Count>0)
   {
     P1.DataSource =ds.Tables["tb"].DefaultView;
     P1.DataBind();
   }

  }

private void List_Bind(Repeater P,string Table)
 { 
   UID=Request.QueryString["uid"];
   UserName="";
   sql="select username from pa_member where id="+UID;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     UserName=dr["username"].ToString();
    }
   dr.Close();
   if(UserName!="")
    {
   sql="select top 15 site_id,sort_id,id,title,lanmu_id,sublanmu_id,thedate,static_dir,Static_file,zdy_url,permissions,clicks,[html] from "+Table+" where checked=1 and username='"+UserName+"' order by thedate desc";
   DataSet ds=new DataSet();
   OleDbDataAdapter myadapter=new OleDbDataAdapter(sql,conn);
   myadapter.Fill(ds,"tb");
   if(ds.Tables["tb"].Rows.Count>0)
   {
     P.DataSource =ds.Tables["tb"].DefaultView;
     P.DataBind();
   }
  }
 }

protected void Data_Bound(Object sender,RepeaterItemEventArgs e)
 { 
 if (e.Item.ItemType   ==   ListItemType.Item   ||   e.Item.ItemType   ==   ListItemType.AlternatingItem) 
    { 
      Repeater P=(Repeater)e.Item.FindControl("P2");
      Label Lb1=(Label)e.Item.FindControl("Lb_Table");
      TheTable=Lb1.Text;
      List_Bind(P,TheTable);
    }
 }

protected string DetailUrl(string SiteId,string Static_dir,string Static_file,string Lanmu_Id,string SubLanmu_Id,string Id,string ZdyUrl,string Permissions,string Html)
 {
  string Rv;
  if(ZdyUrl!="")
   {
     Rv=ZdyUrl;
   }
  else
   {
    Get_Site(int.Parse(SiteId));
    if(Is_Static==1)
     {
       switch(Html)
        {
          case "2":
           if(Permissions=="")
            {Rv=Url_Prefix+Static_dir+"/"+(Static_file==""?Id+".html":Static_file);}
           else
            {Rv=Url_Prefix+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;}
          break;

          case "1":
            Rv=Url_Prefix+TheTable+"/detail_"+Id+".html";
          break;

          default:
            Rv=Url_Prefix+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;
          break;
        }
     }
    else
     {
       Rv=Url_Prefix+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;
     }
   }
  return Rv;
 }

private void Get_Site(int sid)
 {
   Url_Prefix="/";
   sql="select [directory],[domain],[html] from pa_site where id="+sid;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     string SiteDir=dr["directory"].ToString();
     string TheDomain=dr["domain"].ToString();
     Is_Static=int.Parse(dr["html"].ToString());
     if(TheDomain!="")
      {
        Url_Prefix="http://"+TheDomain.Replace("http://","")+"/";
      }
     if(SiteDir!="")
        {
          if(TheDomain=="")
           {
             Url_Prefix="/"+SiteDir+"/";
           }
          else
           {
             Url_Prefix+=SiteDir+"/";
           }
        }

    }
   dr.Close();
 }

protected string GetSortName(string sortid)
 {
   string Rv="";
   sql="select sort_name from pa_sort where id="+int.Parse(sortid);
   OleDbCommand  myComm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=myComm.ExecuteReader();
   if(dr.Read())
    {
      Rv="["+dr["sort_name"].ToString()+"]";
    }
   dr.Close();
   return Rv;
 }

private bool Has_Data(string thetable)
 {
   bool Rv=false;
   sql="select id from "+thetable+" where checked=1 and username='"+UserName+"'";
   OleDbCommand  myComm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=myComm.ExecuteReader();
   if(dr.Read())
    {
      Rv=true;
    }
   dr.Close();
   return Rv;
 }
protected string SubStr(string Title,int Title_Num,bool HtmlEncode) 
{ 
   if(Title_Num==0)
    {
      return "";
    }
   else
    {
       Regex regex = new Regex("[\u4e00-\u9fa5]+", RegexOptions.Compiled); 
       char[] stringChar = Title.ToCharArray(); 
       StringBuilder sb = new StringBuilder(); 
       int nLength = 0; 
      for(int i = 0; i < stringChar.Length; i++) 
       { 
          if (regex.IsMatch((stringChar[i]).ToString())) 
           { 
            nLength += 2; 
           } 
         else 
           { 
             nLength = nLength + 1; 
           } 
         if(nLength <= Title_Num) 
          { 
           sb.Append(stringChar[i]); 
          } 
        else 
         { 
          break; 
         } 
      } 
     if(sb.ToString() != Title) 
      { 
         sb.Append("..."); 
      } 
    if(HtmlEncode)
      {
        return Server.HtmlEncode(sb.ToString());
      }
    else
      {
        return sb.ToString(); 
      }
  }
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
  string str1="1234567890";
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
