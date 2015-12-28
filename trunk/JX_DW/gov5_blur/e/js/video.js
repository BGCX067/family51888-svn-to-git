function player(url,width,height)
{ 
 var html='';  
 if(url.toLowerCase().substring(0,6)=='youku:')
  { 
    var code=url.split(":");            
    html=youku(code[1],width,height); 
    return html;     
  }    
var ext=String(url).split(".");         
ext=ext[ext.length-1];    
if(ext=='mp3'|| ext=='wma'|| ext=='mid' || ext=='wav' || ext=='avi' || ext=='mpg' || ext=='rmvb')
 { 
   html='<embed showstatusbar="true" showtracker="false" showaudiocontrols="false" autostart="false" style="filter: xray()alpha(opacity=80,style=1,finishopacity=5)" volume="0" loop="1" width="'+width+'" height="'+height+'" src="'+url+'"></embed>';
 }
else if(ext=="wmv")
 {
  html+='<object classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6" type="application/x-oleobject" width="'+width+'" height="'+height+'">';
  html+='<param name="autoStart" value="0" />';
  html+='<param name="url" value="'+url+'" />';
  html+='<param name="balance" value="0" />';
  html+='<param name="currentPosition" value="0" />';
  html+='<param name="currentMarker" value="0" />';
  html+='<param name="enableContextMenu" value="false" />';
  html+='<param name="enableErrorDialogs" value="false" />';
  html+='<param name="enabled" value="true" />';
  html+='<param name="fullScreen" value="false" />';
  html+='<param name="invokeURLs" value="false" />';
  html+='<param name="mute" value="false" />';
  html+='<param name="playCount" value="1" />';
  html+='<param name="DisplaySize" value="2" />';
  html+='<param name="rate" value="1" />';
  html+='<param name="uiMode" value="full" />';
  html+='<param name="volume" value="90" />';
  html+='</object>';
 }
else if(ext=="swf")
 {
  html='<embed src="'+url+'" quality="high" wmode="transparent" width="'+width+'" height="'+height+'" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash"></embed>';
 }
else if(url.toLowerCase().substring(0,7)=='qvod://')
 {
   html=qvod(url,width,height); 
 }
else if(url.toLowerCase().substring(0,7)=='pvod://')
 { 
   html=pvod(url,width,height);
 }

else if(ext=='flv')
 {
  html=flv(url,width,height);
 }
else if(url.toLowerCase().substring(0,23)==' http://player.youku.com')
{ 
 var code=url.split("/");
 html=youku(code[5],width,height); 
}
else
{
  html='很抱歉，此媒体文件不存在或无法播放！';    
} 
document.write(html); 
}

function flv(url,width,height)
{
 return '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="'+width+'" height="'+height+'"><param name="movie" value="/e/images/swf/flvplayer.swf" /><param name="quality" value="high" /><param name="allowFullScreen" value="true" /><param name="FlashVars" value="vcastr_file='+url+'&vcastr_title=&BufferTime=2" /><embed src="/e/images/swf/flvplayer.swf" allowfullscreen="true" flashvars="vcastr_file='+url+'&LogoText=" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="'+width+'" height="'+height+'"></embed></object>';
}

function youku(code,width,height)
{
return "<EMBED pluginspage= http://www.macromedia.com/go/getflashplayer src= http://player.youku.com/player.php/sid/"+code+"=/v.swf width=\""+width+"\" height=\""+height+"\" type=application/x-shockwave-flash flashvars=\"isAutoPlay=false&amp;Version=/v1.0.0304&amp;winType=interior\" allowscriptaccess=\"always\" allowfullscreen=\"true\" quality=\"high\" bgcolor=\"#FFFFFF\" EnableContextMenu=\"1\" wmode=\"opaque\"></EMBED>";
}

function qvod(url,width,height)
{
return "<object classid='clsid:F3D0D36F-23F8-4682-A195-74C92B03D4AF' width='"+width+"' height='"+height+"' id='QvodPlayer' onError=\"if(confirm('请您先安装QvodPlayer软件,然后刷新本页才可以正常播放.')){window.open(' http://www.qvod.com/download.htm')}\"><PARAM NAME='URL' VALUE='"+url+"'><PARAM NAME='Autoplay' VALUE='1'></object>";
}

function pvod(url,width,height)
{
return "<object classid=\"CLSID:1DD5176B-B71E-4956-8F32-691702ACDCFE\" width='"+width+"' height='"+height+"' id='PvodPlayer' onError=\"if(confirm('请您先安装PvodPlayer软件,然后刷新本页才可以正常播放.')){window.open(' http://www.pvod.cn/install/index.html')}\"><PARAM NAME='URL' VALUE='"+url+"'></object>";
}