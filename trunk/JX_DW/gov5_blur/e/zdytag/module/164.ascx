<%@ Control Language="C#"%>
<div class="tab">
<div class="fd">
<form action="/e/search/" target="zdy_search" method="get" name="S_letter">
</form>
</div>
<div class="tabheader">
<dl class="tab_t_1" id="tab_t_hdjl">
    <dd>国网材料</dd>
    <dd>公司材料</dd>
    <dd>政府材料</dd>
    <dd>其他材料</dd>
    <dd>规章制度</dd>
</dl>
</div>
<div class="tabcontent">
<dl class="tab_c" id="tab_c_hdjl" style="height:150px">  
    <dd><% @ Register TagPrefix="ascx" TagName="M_0" src="/e/zdymodel/article/module/43.ascx"%><ascx:M_0 runat="server" SiteId=1 ZdyTag=1 ModuleId="164_0"  TagTable="article" TagSortId=529 SqlOrder="order by " SqlCondition="" ShowNum=5 TitleNum=50 TitlePicWidth=150 TitlePicHeight=150 TheTarget="_blank"/></dd>
    <dd><% @ Register TagPrefix="ascx" TagName="M_1" src="/e/zdymodel/article/module/43.ascx"%><ascx:M_1 runat="server" SiteId=1 ZdyTag=1 ModuleId="164_1"  TagTable="article" TagSortId=530 SqlOrder="order by " SqlCondition="" ShowNum=5 TitleNum=50 TitlePicWidth=150 TitlePicHeight=150 TheTarget="_blank"/></dd>
    <dd><% @ Register TagPrefix="ascx" TagName="M_2" src="/e/zdymodel/article/module/43.ascx"%><ascx:M_2 runat="server" SiteId=1 ZdyTag=1 ModuleId="164_2"  TagTable="article" TagSortId=531 SqlOrder="order by " SqlCondition="" ShowNum=5 TitleNum=50 TitlePicWidth=150 TitlePicHeight=150 TheTarget="_blank"/></dd>
    <dd><% @ Register TagPrefix="ascx" TagName="M_3" src="/e/zdymodel/article/module/43.ascx"%><ascx:M_3 runat="server" SiteId=1 ZdyTag=1 ModuleId="164_3"  TagTable="article" TagSortId=544 SqlOrder="order by " SqlCondition="" ShowNum=5 TitleNum=50 TitlePicWidth=150 TitlePicHeight=150 TheTarget="_blank"/></dd>
    <dd><% @ Register TagPrefix="ascx" TagName="M_4" src="/e/zdymodel/article/module/43.ascx"%><ascx:M_4 runat="server" SiteId=1 ZdyTag=1 ModuleId="164_4"  TagTable="article" TagSortId=549 SqlOrder="order by " SqlCondition="" ShowNum=5 TitleNum=50 TitlePicWidth=150 TitlePicHeight=150 TheTarget="_blank"/></dd>
</dl>
</div>
</div>
<script type="text/javascript">

tabs("tab_t_hdjl","tab_c_hdjl","onmousrover");

</script>