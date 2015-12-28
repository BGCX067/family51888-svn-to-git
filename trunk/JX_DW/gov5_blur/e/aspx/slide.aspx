<% @ Page  language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.Text"%>
<% @ Import NameSpace="System.Text.RegularExpressions"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="C#" Runat="server">
  string Pics,Links,Titles,Alts,Width,Height,Show_Text,CurrentId,Target,Border_Width,Border_Color,Show_Slide_Num;
  string TheTable,Sort_Ids,Show_Num,Show_Style,Show_Type,List_Order,Url_Prefix,Is_Static,sql;
  int Title_Num,Sort_Id,Site_Id;
  OleDbConnection conn;
protected void Page_Load(Object sender,EventArgs e)
   {
     Conn Myconn=new Conn();
     string constr=Myconn.Constr();//获取连接字符串
     conn=new OleDbConnection(constr);
     conn.Open();
      Get_Data();
     conn.Close();
   }

private void Get_Data()
   {
     int Id=0;
     if(IsNum(Request.QueryString["id"]))
      {
        Id=int.Parse(Request.QueryString["id"]);
      }
     else
      {
        return;
      }
     OleDbCommand Comm;
     sql="select * from pa_slide where id="+Id;
     Comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=Comm.ExecuteReader();
     if(dr.Read())
      {
       Show_Style=dr["style"].ToString();
        if(Show_Style=="3")
         {
          Pswf2.Visible=true;
          Border_Color=dr["border_color"].ToString().Replace("#","0x");
         }  
        else if(Show_Style=="2")
         {
          Pswf1.Visible=true;
          Border_Color=dr["border_color"].ToString().Replace("#","0x");
         }  
        else
         {
          if(Show_Style=="0")
          {
            Show_Slide_Num="none";
          }
          Pjs.Visible=true;
          Border_Color=dr["border_color"].ToString();
         }
        
        Border_Width=dr["border_width"].ToString();
        CurrentId=dr["id"].ToString();
        Sort_Id=int.Parse(dr["sort_id"].ToString());
        Site_Id=int.Parse(dr["site_id"].ToString());
        Get_Site(Site_Id);
        Title_Num=int.Parse(dr["title_num"].ToString());
        if(Title_Num==0)
         {
          Show_Text="0";
         }
        else
         {
          Show_Text="1";
         }
        Show_Num=dr["show_num"].ToString();
        Show_Type=dr["show_type"].ToString();
        List_Order=dr["zdy_sort"].ToString();
        TheTable=dr["thetable"].ToString();
        if(TheTable==""){TheTable="zdy";}
        if(List_Order=="")
         {
          List_Order="order by "+Get_DefaultSort(TheTable);
         }
        switch(TheTable)
         {
          case "zdy":
             Pics=dr["zdy_image"].ToString();
             Links=dr["zdy_link"].ToString();
             Titles=Server.HtmlEncode(dr["zdy_title"].ToString());
             Alts="";
             if(Titles=="")
              {
                Show_Text="0";
              }
             else
              {
                Show_Text="1";
              }
          break;

          default:
            if(Sort_Id==0)
             {
               sql="select top "+Show_Num+" id from "+TheTable+" where site_id="+Site_Id+" and titlepic<>'' and checked=1 "+Show_Type+" "+List_Order;
             }
            else
             {
               Sort_Ids=SortIds(Sort_Id);
               if(IsNum(Sort_Ids))
               {
                 sql="select top "+Show_Num+" id from "+TheTable+" where site_id="+Site_Id+" and titlepic<>'' and checked=1 and sort_id="+Sort_Ids+" "+Show_Type+" "+List_Order;
               }
               else
               {
                 sql="select top "+Show_Num+" id from "+TheTable+" where site_id="+Site_Id+" and titlepic<>'' and checked=1 and sort_id in("+Sort_Ids+") "+Show_Type+" "+List_Order;
               }
             }
            Get_Data(sql);
          break;
         }
       Width=dr["width"].ToString();
       Height=dr["height"].ToString();
       Target=dr["target"].ToString();
      }
    else
      {
       Response.End();
      }
   dr.Close();
  }

private void Get_Data(string sql)
   {
      string SP="";
      DataSet ds=new  DataSet(); 
      OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);//在数据库和DataSet之间建立桥接。
      myAdapter.Fill(ds,0,int.Parse(Show_Num),"default");
      ds=Optimize_DataSet(ds,TheTable,List_Order);
      DataRow dr;
      for(int i=0;i<ds.Tables["default"].Rows.Count;i++)
        { 
          dr=ds.Tables["default"].Rows[i];
          if(i<ds.Tables["default"].Rows.Count-1)
           {
             SP="|";
           }
          else
           {
             SP="";
           }
           Pics+=dr["titlepic"].ToString()+SP;
           Links+=DetailUrl(dr["static_dir"].ToString(),dr["static_file"].ToString(),dr["lanmu_id"].ToString(),dr["sublanmu_id"].ToString(),dr["id"].ToString(),dr["zdy_url"].ToString(),dr["permissions"].ToString(),dr["html"].ToString())+SP;
           Titles+=Get_title_num(dr["title"].ToString(),true)+SP;
           Alts+=dr["title"].ToString()+SP;
         }

   }

private DataSet Optimize_DataSet(DataSet SourceDs,string Table,string Order)
 {
   int RCount=SourceDs.Tables["default"].Rows.Count;
   string Ids="0";
   if(RCount>0)
    {
      DataRow dr;
      for(int i=0;i<RCount;i++)
       {
         dr=SourceDs.Tables["default"].Rows[i];
         Ids+=","+dr["id"].ToString();
       }
    }
   SourceDs.Clear();
   string sql="select id,title,titlepic,static_dir,static_file,lanmu_id,sublanmu_id,zdy_url,permissions,[html] from "+Table+" where id in("+Ids+") "+Order;
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   myAdapter.Fill(SourceDs,"default");
   return SourceDs;
 }

private string Get_DefaultSort(string Table)
 {
   string rv="";
   string sql="select default_sort from pa_table where thetable='"+Table+"'";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
      {
        rv=dr["default_sort"].ToString();
      }
   dr.Close();
   if(rv==""){rv="actdate desc";}
   return rv;
 }

private string SortIds(int SortId)
 {
     string Ids=SortId.ToString(); 
     sql="select id from pa_sort where site_id="+Site_Id+" and thetable='"+TheTable+"' and final_sort=1 and parent_ids like '%,"+SortId+",%'";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     while(dr.Read())
      {
        Ids+=","+dr["id"].ToString();
      }
    dr.Close();
    return Ids;
 }


private string DetailUrl(string Static_dir,string Static_file,string Lanmu_Id,string SubLanmu_Id,string Id,string ZdyUrl,string Permissions,string Html)
 {
  string Rv;
  if(ZdyUrl!="")
   {
     Rv=ZdyUrl;
   }
  else
   {
    if(Is_Static=="1")
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
     Is_Static=dr["html"].ToString();
     string SiteDir=dr["directory"].ToString();
     string TheDomain=dr["domain"].ToString();
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
   else
    {
     Url_Prefix="/";
     Response.End();
    }
   dr.Close();
 }

private string Get_title_num(string Title,bool HtmlEncode) 
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
</script>
var Image_<%=CurrentId%>=new Array();
var Pics="<%=Pics%>";
var Links="<%=Links%>";
var Titles="<%=Server.HtmlEncode(Titles)%>";
var Alts="<%=Server.HtmlEncode(Alts)%>";
var Apic<%=CurrentId%>=Pics.split('|');
var ALink<%=CurrentId%>=Links.split('|');
var ATitle<%=CurrentId%>=Titles.split('|');
var AAlts<%=CurrentId%>=Alts.split('|');
var Show_Text=<%=Show_Text%>;
var Total_Item=Apic<%=CurrentId%>.length;
for(i=0;i<Total_Item;i++)
  {
   Image_<%=CurrentId%>.src = Apic<%=CurrentId%>[i]; 
  }

<asp:PlaceHolder id="Pswf1" runat="server" Visible="false">
function LoadSlideBox_<%=CurrentId%>()
{
var text_mtop = 0;
var text_lm = 0;
var textmargin = text_mtop+"|"+text_lm;
var textcolor = "0x000000|0xff0000";
var text_align= 'center'; 
var text_size = 12;
var Border_Alpha;
if(<%=Border_Width%>=="0")
 {
  Border_Alpha=0;
 }
else
 {
  Border_Alpha=100;
 }
var borderStyle="<%=Border_Width%>|<%=Border_Color%>|"+Border_Alpha;

var Interval_Time=7;
var focus_width=<%=Width%>;
var focus_height=<%=Height%>;
var text_height=20;
if(Show_Text==0)
 {
   text_height=0;
 }
var swf_height = focus_height+text_height+text_mtop; 
var text_align="center";
Links=escape(Links);
document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ focus_width +'" height="'+ swf_height +'">');
document.write('<param name="allowScriptAccess" value="sameDomain"><param name="movie" value="/e/images/swf/focus.swf"> <param name="quality" value="high"><param name="bgcolor" value="#ffffff">');
document.write('<param name="menu" value="false"><param name=wmode value="transparent">');
document.write('<param name="FlashVars" value="pics='+Pics+'&links='+Links+'&texts='+Titles+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'&textmargin='+textmargin+'&textcolor='+textcolor+'&borderstyle='+borderStyle+'&text_align='+text_align+'&interval_time='+Interval_Time+'">');
document.write('<embed src="/e/images/swf/focus.swf"  wmode="transparent"  FlashVars="pics='+Pics+'&links='+Links+'&texts='+Titles+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'&textmargin='+textmargin+'&textcolor='+textcolor+'&borderstyle='+borderStyle+'&text_align='+text_align+'&interval_time='+Interval_Time+'" menu="false" bgcolor="#ffffff" quality="high" width="'+ focus_width +'" height="'+ swf_height +'" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');
document.write('</object>');
}
</asp:PlaceHolder>

<asp:PlaceHolder id="Pswf2" runat="server" Visible="false">
function LoadSlideBox_<%=CurrentId%>()
{
var bcastr_config="&bcastr_config=0xffffff|2|0x000000|60|0xffffff|0xff6600|0x000033|7|1|1|<%=Target%>";
//文字颜色|文字位置|文字背景颜色|文字背景透明度|按键文字颜色|按键默认颜色|按键当前颜色|自动播放时间(秒)|图片过渡效果|是否显示按钮|打开目标窗口
var swf_width=<%=Width%>;
var swf_height=<%=Height%>;
Links=escape(Links);
document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
document.write('<param name="movie" value="/e/images/swf/bcastr3.swf"><param name="quality" value="high">');
document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
document.write('<param name="FlashVars" value="bcastr_file='+Pics+'&bcastr_link='+Links+'&bcastr_title='+Titles+'&bcastr_config='+bcastr_config+'">');
document.write('<embed src="/e/images/swf/bcastr3.swf" wmode="opaque" FlashVars="bcastr_file='+Pics+'&bcastr_link='+Links+'&bcastr_title='+Titles+'&bcastr_config='+bcastr_config+'& menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); 
document.write('</object>'); 
}
</asp:PlaceHolder>


<asp:PlaceHolder id="Pjs" runat="server" Visible="false">
 var speed_<%=CurrentId%>=7000;
 var slide_currentitem_<%=CurrentId%>=0; 
 var Title="",Link="";
 var slide_Time_<%=CurrentId%>;
function LoadSlideBox_<%=CurrentId%>()
{
SlideHtml='<a href="#" id="slide_link_<%=CurrentId%>" target="<%=Target%>"><img class="slide_image" style="display:block;filter:revealTrans(duration=1,transition=20);display:none;border:<%=Border_Width%>px solid <%=Border_Color%>;width:<%=Width%>px;height:<%=Height%>px"  name="slide_pic_<%=CurrentId%>" id="slide_pic_<%=CurrentId%>"></a>';
SlideHtml+='<ul  class="slide_item" style="display:<%=Show_Slide_Num%>">';
for(i=0;i<Total_Item;i++)
  {
    SlideHtml+='<li id="slide_num_<%=CurrentId%>_'+i+'" onclick="Change_Num_<%=CurrentId%>('+i+')">'+(i+1)+'</li>';
  }
SlideHtml+='</ul>';
document.write("<div id='slide_box_<%=CurrentId%>' class='slide_box' style='width:<%=Width%>px;height:<%=Height%>px'>"+SlideHtml+"</div><div style='width:<%=Width%>px;text-align:center;display:none' id='slide_title_<%=CurrentId%>'></div>");
document.images["slide_pic_<%=CurrentId%>"].src=Apic<%=CurrentId%>[0];
document.images["slide_pic_<%=CurrentId%>"].alt=AAlts<%=CurrentId%>[0];
document.images["slide_pic_<%=CurrentId%>"].style.display="inline";


Title="<a href='"+ALink<%=CurrentId%>[0]+"' class='slide_title' target='<%=Target%>'>"+ATitle<%=CurrentId%>[0]+"</a>";
document.getElementById("slide_link_<%=CurrentId%>").href=ALink<%=CurrentId%>[0];
if(Show_Text=="1")
 {
  document.getElementById("slide_title_<%=CurrentId%>").style.display="";
  document.getElementById("slide_title_<%=CurrentId%>").innerHTML=Title;
 }


document.getElementById("slide_num_<%=CurrentId%>_0").className="current";
slide_Time_<%=CurrentId%>=setInterval(nextAd_<%=CurrentId%>,speed_<%=CurrentId%>);
document.getElementById("slide_box_<%=CurrentId%>").onmouseover=function() {clearInterval(slide_Time_<%=CurrentId%>)}
document.getElementById("slide_box_<%=CurrentId%>").onmouseout=function() {slide_Time_<%=CurrentId%>=setInterval(nextAd_<%=CurrentId%>,speed_<%=CurrentId%>)}

}

function setTransition_<%=CurrentId%>()
{
  if (document.all)
   {
     document.images["slide_pic_<%=CurrentId%>"].filters.revealTrans.Transition=23;
     document.images["slide_pic_<%=CurrentId%>"].filters.revealTrans.apply();
   }
}


function playTransition_<%=CurrentId%>()
{
  if(document.all)
  document.images["slide_pic_<%=CurrentId%>"].filters.revealTrans.play()
}


function Control_Num_<%=CurrentId%>(Currentnum)
 {
  for(i=0;i<Apic<%=CurrentId%>.length;i++)
  {
   document.getElementById("slide_num_<%=CurrentId%>_"+i).className="";
  }
  document.getElementById("slide_num_<%=CurrentId%>_"+Currentnum).className="current";
 }

function Change_Num_<%=CurrentId%>(Currentnum)
 {
  for(i=0;i<Total_Item;i++)
  {
   document.getElementById("slide_num_<%=CurrentId%>_"+i).className="";
  }
  document.getElementById("slide_num_<%=CurrentId%>_"+Currentnum).className="current";
  slide_currentitem_<%=CurrentId%>=Currentnum;
  ShowFocus_<%=CurrentId%>(Currentnum);
 }

function nextAd_<%=CurrentId%>()
{
  if(Apic<%=CurrentId%>.length<=1)
   {
     clearInterval(slide_Time_<%=CurrentId%>);
     return;
   }

  if(slide_currentitem_<%=CurrentId%><Apic<%=CurrentId%>.length-1)
    {
      slide_currentitem_<%=CurrentId%>++;
    }
  else 
   {
     slide_currentitem_<%=CurrentId%>=0;
   }
 ShowFocus_<%=CurrentId%>(slide_currentitem_<%=CurrentId%>);
}


function ShowFocus_<%=CurrentId%>(slide_currentitem_<%=CurrentId%>)
 {
  if(ATitle<%=CurrentId%>.length>slide_currentitem_<%=CurrentId%>)
   {
     if(ALink<%=CurrentId%>.length>slide_currentitem_<%=CurrentId%>)
      {
       Title="<a href='"+ALink<%=CurrentId%>[slide_currentitem_<%=CurrentId%>]+"' class='slide_title' target='<%=Target%>'>"+ATitle<%=CurrentId%>[slide_currentitem_<%=CurrentId%>]+"</a>";
      }
     else
      {
       Title=ATitle<%=CurrentId%>[slide_currentitem_<%=CurrentId%>]; 
      }
   }
  else
   {
       Title=""; 
   }

  if(ALink<%=CurrentId%>.length>slide_currentitem_<%=CurrentId%>)
   {
      Link=ALink<%=CurrentId%>[slide_currentitem_<%=CurrentId%>];
   }
  else
   {
      Link="#";
   }

  document.getElementById("slide_link_<%=CurrentId%>").href=Link;
  document.getElementById("slide_title_<%=CurrentId%>").innerHTML=Title;

  setTransition_<%=CurrentId%>();
  document.images["slide_pic_<%=CurrentId%>"].src=Apic<%=CurrentId%>[slide_currentitem_<%=CurrentId%>];
  document.images["slide_pic_<%=CurrentId%>"].alt=AAlts<%=CurrentId%>[slide_currentitem_<%=CurrentId%>];
  document.getElementById("slide_title_<%=CurrentId%>").innerHTML=Title;
  playTransition_<%=CurrentId%>();
  Control_Num_<%=CurrentId%>(slide_currentitem_<%=CurrentId%>);
 }
</asp:PlaceHolder>
LoadSlideBox_<%=CurrentId%>();