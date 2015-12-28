function NotLogin(sid) //未登录提示
 {
   alert("请先登录!");
   var backurl=parent.location.href;
   var url="/e/member/index.aspx?type=login&s="+sid+"&to="+escape(backurl);
   parent.location=url;
   CloseDialog();
 }

function NoReserves(sid) //无库存
 {
   alert('此产品已无库存！');
   CloseDialog();
 }

function AlreadyInOrder()
 {
   //alert("此产品已经在订购列表中!");
  //location.href=location.href;
 }

function Get_CheckBox(Name)
 {
   var Obj=document.getElementsByName(Name);
   var ID="0";
   for(i=0;i<Obj.length;i++)
     {
      if(Obj[i].checked)
       {
         ID+=","+Obj[i].value;
       }
     }
   return ID.replace("0,","");
 }

function edit_order() //修改参数
 {
   var Obj=document.getElementsByName("id");
   if(Obj.length==0)
     {
       return;
     }

     for(i=0;i<Obj.length;i++)
     {
       Obj[i].checked=true;
     }
     document.order.post.value="edit"
     document.order.submit();

 }

function del_order(id) //删除订单
 {
   if(confirm("是否确定删除!"))
    {
     document.order.delid.value=id;
     document.order.post.value="del"
     document.order.submit();
    }
 }

function order_submit(tourl) //订单提交完毕
 {
   alert("订单提交成功!");
   parent.location=tourl;
   CloseDialog();
 }

function Exchange(str) //积分兑换
 {
   switch(str)
    {
   case "invalid":
     alert("参数错误!");
     location.href= location.href;
   break;

   case "num>reserves":
     alert("兑换失败，兑换数不能大于商品库存!");
     location.href= location.href;
   break;

   case "mypoint<points":
     alert("兑换失败，可用积分不足!");
     location.href= location.href;
   break;

   case "success":
     alert("兑换成功!");
   break;
  }
 }


