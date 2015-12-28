<% @ Control language="c#" AutoEventWireup="false"%>
<script Language="C#" Runat="server">
string Id,Height,Style;
public string Tb_Id
    {
     set
      {
        Id=value;
       }
    }

public string Fck_Height
   {
    set
    {
      Height=value;
    }
   }

public string Fck_Style
   {
     set
     {
      Style=value;
     }
   }

</script>
<script type="text/javascript" src="/e/incs/fckeditor/fckeditor.js"></script>
<script  type="text/javascript"> 
var FCKeditor = new FCKeditor("<%=Id%>"); 
FCKeditor.BasePath = "/e/incs/fckeditor/"; 
FCKeditor.Height = <%=Height%>; 
FCKeditor.Config['LinkBrowser'] = true  ;
FCKeditor.Config['ImageBrowser'] =true  ;
FCKeditor.Config['FlashBrowser'] =true  ;
FCKeditor.Config['LinkUpload'] = true ;
FCKeditor.Config['ImageUpload'] = true ;
FCKeditor.Config['FlashUpload'] = true ;
FCKeditor.ToolbarSet ="<%=Style%>"; 
FCKeditor.ReplaceTextarea(); 
</script>

