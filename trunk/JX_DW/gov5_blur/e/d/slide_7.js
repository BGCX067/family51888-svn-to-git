
var Image_7=new Array();
var Pics="/e/upload/s1/article/image/2011-03/c-20093198219526.jpg|/e/upload/s1/article/image/2012-09/c-004冯健斌.jpg|/e/upload/s1/article/image/2012-08/tpic_t_17002421.jpg|/e/upload/s1/article/image/2011-03/t-c-24111159.jpg|/e/upload/s1/article/image/2012-08/tpic_t_17145811.jpg";
var Links="/index.aspx?lanmuid=68&sublanmuid=625&id=419|/index.aspx?lanmuid=68&sublanmuid=625&id=417|/index.aspx?lanmuid=68&sublanmuid=625&id=416|/index.aspx?lanmuid=68&sublanmuid=625&id=415|/index.aspx?lanmuid=65&sublanmuid=613&id=411";
var Titles="zcxc|mmmmmm|yyyyy|zzzzzz|42343232432";
var Alts="zcxc|mmmmmm|yyyyy|zzzzzz|42343232432";
var Apic7=Pics.split('|');
var ALink7=Links.split('|');
var ATitle7=Titles.split('|');
var AAlts7=Alts.split('|');
var Show_Text=1;
var Total_Item=Apic7.length;
for(i=0;i<Total_Item;i++)
  {
   Image_7.src = Apic7[i]; 
  }


function LoadSlideBox_7()
{
var text_mtop = 0;
var text_lm = 0;
var textmargin = text_mtop+"|"+text_lm;
var textcolor = "0x000000|0xff0000";
var text_align= 'center'; 
var text_size = 12;
var Border_Alpha;
if(1=="0")
 {
  Border_Alpha=0;
 }
else
 {
  Border_Alpha=100;
 }
var borderStyle="1|0xeeeeee|"+Border_Alpha;

var Interval_Time=7;
var focus_width=480;
var focus_height=283;
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






LoadSlideBox_7();