var moodzt = "0";
var http_request = false;
function MoodRequest(url,functionName, httpType, sendData) {

	http_request = false;
	if (!httpType) httpType = "GET";

	if (window.XMLHttpRequest) { // Non-IE...
		http_request = new XMLHttpRequest();
		if (http_request.overrideMimeType) {
			http_request.overrideMimeType('text/plain');
		}
	} else if (window.ActiveXObject) { // IE
		try {
			http_request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				http_request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {}
		}
	}

	if (!http_request) {
		alert('Cannot send an XMLHTTP request');
		return false;
	}

	var changefunc="http_request.onreadystatechange = "+functionName;
	eval (changefunc);
	//http_request.onreadystatechange = alertContents;
	http_request.open(httpType, url, true);
	http_request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	http_request.send(sendData);
}


function $() {
  var elements = new Array();

  for (var i = 0; i < arguments.length; i++) {
    var element = arguments[i];
    if (typeof element == 'string')
      element = document.getElementById(element);

    if (arguments.length == 1)
      return element;

    elements.push(element);
  }

  return elements;
}


function get_mood(mood_id)
{
   var repeat_mood=0;//0表示不允许重复表态
   var MIds;
   if(moodzt == "1") 
    {
	 alert("HI,你已经表过态了!");
         return;
    }

   if(repeat_mood==0)
    {
     MIds=GetCookie("mood");
     if(MIds=="")
      {
       MIds=",";
      }
     if(MIds.indexOf(","+detailid+",")>=0)
     {
       alert("HI,你已经表过态了!");
       return;
     }
    else
     {
       SetCookie("mood",MIds+detailid+",",10);
     }
    }

  url = "/e/aspx/mood.aspx?action=add&siteid="+siteid+"&thetable="+thetable+"&detailid="+detailid+"&type="+mood_id+"&m=" + Math.random();
  MoodRequest(url,'return_review','GET','');
  moodzt = "1";
}

function remood()
{
   url = "/e/aspx/mood.aspx?action=show&siteid="+siteid+"&thetable="+thetable+"&detailid="+detailid+"&m="+Math.random();
   MoodRequest(url,'return_review','GET','');
}

function return_review(ajax)
{
	if (http_request.readyState == 4) {
		if (http_request.status == 200) {
			var str_error_num = http_request.responseText;
			if(str_error_num=="error")
			{
			    alert("信息不存在！");
			}
			else if(str_error_num==0)
			{
			  alert("HI,你已经表过态了！");
			}
			else
			{
			  moodinner(str_error_num);
			}
		} else {
			alert('There was a problem with the request.');
		}
	}
}
function moodinner(moodtext)
{
	var imga = "/e/images/mood/pre_02.gif";
	var imgb = "/e/images/mood/pre_01.gif";
	var color1 = "#666666";
	var color2 = "#EB610E";
	var heightz = "60";	//图片100%时的高
	var hmax = 0;
	var hmaxpx = 0;
	var heightarr = new Array();
	var moodarr = moodtext.split(",");
	var moodzs = 0;
	for(k=0;k<8;k++) {
		moodarr[k] = parseInt(moodarr[k]);
		moodzs += moodarr[k];
	}
	for(i=0;i<8;i++) {
		heightarr[i]= Math.round(moodarr[i]/moodzs*heightz);
		if(heightarr[i]<1) heightarr[i]=1;
		if(moodarr[i]>hmaxpx) {
		hmaxpx = moodarr[i];
		}
	}
	$("moodtitle").innerHTML = "<span style='color: #555555;padding-left: 20px;'>已有<font color='#FF0000'>"+moodzs+"</font>人表态了！您看完后的感受是：</span>";
	for(j=0;j<8;j++)
	{
		if(moodarr[j]==hmaxpx && moodarr[j]!=0) {
			$("moodinfo"+j).innerHTML = "<span style='color: "+color2+";'>"+moodarr[j]+"</span><br><img src='"+imgb+"' width='20' height='"+heightarr[j]+"'>";
		} else {
			$("moodinfo"+j).innerHTML = "<span style='color: "+color1+";'>"+moodarr[j]+"</span><br><img src='"+imga+"' width='20' height='"+heightarr[j]+"'>";
		}
	}
}
document.writeln("<table width=\"528\" border=\"0\" cellpadding=\"1\" cellspacing=\"0\" style=\"font-size:12px;margin-top: 20px;margin-bottom: 20px;\">");
document.writeln("<tr>");
document.writeln("<td colspan=\"8\" id=\"moodtitle\"  align=\"left\"><\/td>");
document.writeln("<\/tr>");
document.writeln("<tr align=\"center\" valign=\"bottom\">");
document.writeln("<td height=\"60\" id=\"moodinfo0\"><\/td>");
document.writeln("<td id=\"moodinfo1\"><\/td>");
document.writeln("<td id=\"moodinfo2\"><\/td>");
document.writeln("<td id=\"moodinfo3\"><\/td>");
document.writeln("<td id=\"moodinfo4\"><\/td>");
document.writeln("<td id=\"moodinfo5\"><\/td>");
document.writeln("<td id=\"moodinfo6\"><\/td>");
document.writeln("<td id=\"moodinfo7\"><\/td>");
document.writeln("<\/tr>");
document.writeln("<tr align=\"center\" valign=\"middle\">");
document.writeln("<td><img src=\"\/e\/images\/mood\/0.gif\" width=\"40\" height=\"40\"><\/td>");
document.writeln("<td><img src=\"\/e\/images\/mood\/1.gif\" width=\"40\" height=\"40\"><\/td>");
document.writeln("<td><img src=\"\/e\/images\/mood\/2.gif\" width=\"40\" height=\"40\"><\/td>");
document.writeln("<td><img src=\"\/e\/images\/mood\/3.gif\" width=\"40\" height=\"40\"><\/td>");
document.writeln("<td><img src=\"\/e\/images\/mood\/4.gif\" width=\"40\" height=\"40\"><\/td>");
document.writeln("<td><img src=\"\/e\/images\/mood\/5.gif\" width=\"40\" height=\"40\"><\/td>");
document.writeln("<td><img src=\"\/e\/images\/mood\/6.gif\" width=\"40\" height=\"40\"><\/td>");
document.writeln("<td><img src=\"\/e\/images\/mood\/7.gif\" width=\"40\" height=\"40\"><\/td>");
document.writeln("<\/tr>");
document.writeln("<tr>");
document.writeln("<td align=\"center\">吃惊<\/td>");
document.writeln("<td align=\"center\">欠揍<\/td>");
document.writeln("<td align=\"center\">支持<\/td>");
document.writeln("<td align=\"center\">很棒<\/td>");
document.writeln("<td align=\"center\">找骂<\/td>");
document.writeln("<td align=\"center\">搞笑<\/td>");
document.writeln("<td align=\"center\">呕吐<\/td>");
document.writeln("<td align=\"center\">不解<\/td>");
document.writeln("<\/tr>");
document.writeln("<tr align=\"center\">");
document.writeln("<td><input onClick=\"get_mood(\'1\')\" type=\"radio\" name=\"radiobutton\" value=\"radiobutton\"><\/td>");
document.writeln("<td><input onClick=\"get_mood(\'2\')\" type=\"radio\" name=\"radiobutton\" value=\"radiobutton\"><\/td>");
document.writeln("<td><input onClick=\"get_mood(\'3\')\" type=\"radio\" name=\"radiobutton\" value=\"radiobutton\"><\/td>");
document.writeln("<td><input onClick=\"get_mood(\'4\')\" type=\"radio\" name=\"radiobutton\" value=\"radiobutton\"><\/td>");
document.writeln("<td><input onClick=\"get_mood(\'5\')\" type=\"radio\" name=\"radiobutton\" value=\"radiobutton\"><\/td>");
document.writeln("<td><input onClick=\"get_mood(\'6\')\" type=\"radio\" name=\"radiobutton\" value=\"radiobutton\"><\/td>");
document.writeln("<td><input onClick=\"get_mood(\'7\')\" type=\"radio\" name=\"radiobutton\" value=\"radiobutton\"><\/td>");
document.writeln("<td><input onClick=\"get_mood(\'8\')\" type=\"radio\" name=\"radiobutton\" value=\"radiobutton\"><\/td>");
document.writeln("<\/tr>");
document.writeln("<\/table>")
remood();