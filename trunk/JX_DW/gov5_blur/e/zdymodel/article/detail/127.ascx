<% @ Control language="c#" Inherits="PageAdmin.detail_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<div class="current_location" id="current_location"><ul><li class="current_location_1"><%=Current_Location%></li><li class="current_location_2"><%=Current_Name%></li></ul></div>
<div class="sublanmu_box" id="sublanmu_box_<%=Sublanmu_Id%>">
<div class="sublanmu_content" id="sublanmu_content">
<%conn.Open();%><% 
string Pics="";
int News_Pic=0;
DataTable dt,dt1;
dt=Get_Data(); 
DataRow dr,dr1; 
for(int i=0;i<dt.Rows.Count;i++)
 {
  dr=dt.Rows[i]; 
  if(dr["pa_pics"].ToString()!="0" && dr["pa_pics"].ToString()!="")
   {
     News_Pic=int.Parse(dr["pa_pics"].ToString());
   }
%>
<div class="articleinfor" id="articleinfor">
<ul>
<li class="title"><h1><%=Server.HtmlEncode(dr["title"].ToString())%>
</h1></li>
<li class="info">
发布日期：<%=((DateTime)dr["thedate"]).ToString("yyyy-MM-dd")%>&nbsp;&nbsp;
<%=dr["pa_autor"].ToString()==""?"":"&nbsp;作者："+dr["pa_autor"].ToString()%>
浏览量：<span id="clicks"></span>&nbsp;&nbsp;<%=dr["pa_source"].ToString()==""?"":"&nbsp;来源："+dr["pa_source"].ToString()%>&nbsp;&nbsp;字号：[&nbsp;<a href="javascript:FontZoom('16px','Content')">大</a> <a href="javascript:FontZoom('14px','Content')">中</a>  <a href="javascript:FontZoom('12px','Content')">小</a>]
</li>
</ul>

<%//新闻图片组开始
if(News_Pic>0)
{%>
<LINK href="/e/images/picsview/css/style.css" type=text/css rel=stylesheet>
<div class="box-cnfen" style="margin:10px auto;">
      <div class="nph_gallery nph_skin_white" id=gallery342>
		  <div class=nph_bg>
			  <div class=nph_photo id=modePhoto342>
				  <div class=nph_photo_view>
					  <div class=nph_cnt id=photoView342>
					  	<IMG id=photo342 src="images/blank.gif">					 
					  </div>
					  <div class=nph_photo_prev>
						<A class=nph_btn_pphoto id=photoPrev342 hideFocus href="#" target=_self></A>					  
						</div>
					  <div class=nph_photo_next>
					  <A class=nph_btn_nphoto id=photoNext342 hideFocus href="#" target=_self></A>					 
					   </div>
					  <div class=nph_photo_loading id=photoLoading342></div>
				  </div>
				  <div class=nph_cnt>
					  <div class=nph_photo_ctrl>
						  <UL>
						  	<li><SPAN class="nph_set_cur hidden" id=photoType342>（<SPAN class=nph_c_lh id=photoIndex342></SPAN>/<%=News_Pic%>）</SPAN><SPAN class=nph_set_size id=streamType342>（共<SPAN class=nph_c_lh><%=News_Pic%></SPAN>张）</SPAN></li>
							<LI><A class=nph_icon_orig id=viewOrig342  href="#" target=_blank>查看原图</A>|</LI>
						</UL>
					  </div>
					  <div class=nph_photo_desc id=photoDesc342></div>
				  </div>
				  <SPAN class=nph_hr_solid></SPAN>
				  <div class="nph_cnt clearfix">
					  <div class=nph_photo_thumb id=scrl342>
					    <div class=clearfix>
							  <div class=nph_scrl>
								  <div class=nph_scrl_thumb>
									  <div class=nph_scrl_main>
										  <UL class=nph_list_thumb id=thumb342></UL>
									  </div>
									  <div class="nph_scrl_bar clearfix">
										  <SPAN class=nph_scrl_lt></SPAN><SPAN class=nph_scrl_rt></SPAN>
										  <div class=nph_scrl_bd>
											  <div class=nph_scrl_ct>
												  <A class=nph_btn_scrl id=bar342 hideFocus href="#"><B class=nph_btn_lt></B><B class=nph_btn_rt></B><SPAN 
												  class=nph_btn_bd><SPAN><B class=nph_btn_ct></B></SPAN></SPAN></A>											  </div>
										  </div>
									  </div>
								  </div>
							  </div>
						    <SPAN class=nph_scrl_prev><A class=nph_btn_pscrl id=scrlPrev342 hideFocus href="#"></A></SPAN><SPAN class=nph_scrl_next><A class=nph_btn_nscrl id=scrlNext342 hideFocus href="#"></A></SPAN>						  </div>
					  </div>
				  </div>
			  </div>
		  </div>
	   </div>
<TEXTAREA  id=photoList342 style="display:none">
<%
dt1=Get_File("article","pa_pics",Detail_Id);
for(int k=0;k<dt1.Rows.Count;k++)
 {
   dr1=dt1.Rows[k]; 
%><li>
<a href="#p=<%=k+1%>" hidefocus="true"><img src="<%=dr1["thumbnail"]%>"/></a>
<h2><%=dr1["title"]%></h2>
<p></p>
<i title="img"><%=dr1["url"]%></i>
<i title="timg"><%=dr1["thumbnail"]%></i>
</li><%}%>
</TEXTAREA> 
<div class=hidden id=galleryTpl342></div>
<SCRIPT language=javascript src="/e/images/picsview/js/ntes_jslib_1.x.js" type=text/javascript charset=gb2312></SCRIPT>
<SCRIPT language=javascript src="/e/images/picsview/js/ntes_ui_scroll.js" type=text/javascript charset=gb2312></SCRIPT>
<SCRIPT language=javascript  src="/e/images/picsview/js/nph_gallery_2.11.js"  type=text/javascript charset=gb2312></SCRIPT>
<SCRIPT type=text/javascript>
NTES.ready(function ($) { new nph.Gallery({ sn: "342" }); });
</SCRIPT>
</div>
<div class="clear"></div>
<%}//图片组结束%>
<div class="content" id="Content"><%=dr["content"].ToString()%></div>
</div>
<script src="/e/js/internal_page.js" type="text/javascript"></script>
<%}
Prev_and_Next();
%>
<ul class="sublanmu_pn">
<li><%=_Previous==""?"":"上一篇："+_Previous%></li>
<li><%=_Next==""?"":"下一篇："+_Next%></li>
</ul>
<%conn.Close();%>
<script type="text/javascript">Get_Info("<%=Thetable%>","<%=Detail_Id%>")</script>
<asp:PlaceHolder id="P_Comment" runat="server"/></div></div>