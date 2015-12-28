
var Image_13=new Array();
var Pics="/e/upload/s1/article/image/2012-09/t_c-20093198125546.jpg|/e/upload/s1/article/image/2012-09/t_c-24111159.jpg|/e/upload/s1/article/image/2012-09/t_c-24111420.jpg";
var Links="/index.aspx?lanmuid=67&sublanmuid=636&id=482|/index.aspx?lanmuid=67&sublanmuid=636&id=481|/index.aspx?lanmuid=67&sublanmuid=636&id=479";
var Titles="美国中小学校长考察团...|我校召开第五届教育教...|别开生面的班主任工作...";
var Alts="美国中小学校长考察团到我校参加交流和考察活动|我校召开第五届教育教学年会第一次会议|别开生面的班主任工作研讨会";
var Apic13=Pics.split('|');
var ALink13=Links.split('|');
var ATitle13=Titles.split('|');
var AAlts13=Alts.split('|');
var Show_Text=1;
var Total_Item=Apic13.length;
for(i=0;i<Total_Item;i++)
  {
   Image_13.src = Apic13[i]; 
  }


function LoadSlideBox_13()
{
var text_mtop = 0;
var text_lm = 0;
var textmargin = text_mtop+"|"+text_lm;
var textcolor = "0x000000|0xff0000";
var text_align= 'center'; 
var text_size = 12;
var Border_Alpha;
if(0=="0")
 {
  Border_Alpha=0;
 }
else
 {
  Border_Alpha=100;
 }
var borderStyle="0|0xcccccc|"+Border_Alpha;

var Interval_Time=7;
var focus_width=220;
var focus_height=160;
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






LoadSlideBox_13();