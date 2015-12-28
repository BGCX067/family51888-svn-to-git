<%@ page language="java"  pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"  %>
<%@ page isELIgnored="false" %>	
	<c:if test="${page.totalPages le 0}">
		<c:set var="totalPages" value="1"></c:set>
	</c:if>
	<c:if test="${page.pageNo le 0}">
		<c:set var="pageNo" value="1"></c:set>
	</c:if>

              	共&nbsp;&nbsp;${page.totalPages } 页 &nbsp;&nbsp;${page.totalCount}条记录&nbsp;&nbsp;当前第&nbsp;&nbsp;${page.pageNo }页&nbsp;&nbsp;
              	<c:choose>
              		<c:when test="${page.pageNo gt 1}">
              			<a style = "cursor:hand" onclick="toPage('1')"><font color="#0d6cae">首页</font></a>
              		</c:when>
              		<c:otherwise>
              			首页
              		</c:otherwise>
              	</c:choose>
				<c:choose>
              		<c:when test="${page.pageNo gt 1}">
              			<a style = "cursor:hand" onclick = "toPage(${page.pageNo - 1})"><font color="#0d6cae">上一页</font></a>
              		</c:when>
              		<c:otherwise>
              			上一页
              		</c:otherwise>
              	</c:choose>
          		第
          		<select name = "pageNo" onchange = "toPage(this.value)">
	          		<c:forEach var="itrPage" begin="1" end="${page.totalPages }" step="1">
	          			<c:choose>
	          				<c:when test="${page.pageNo eq itrPage }">
	          					<option value="${itrPage }"  selected="selected">${itrPage }</option>
	          				</c:when>
	          				<c:otherwise>
	          					<option value="${itrPage }">${itrPage }</option>
	          				</c:otherwise>
	          			</c:choose>
	          		</c:forEach>
          		</select>    
          		页
          		<c:choose>
              		<c:when test="${page.pageNo lt page.totalPages }">
              			<a style = "cursor:hand" onclick = "toPage(${page.pageNo + 1 })"><font color="#0d6cae">下一页</font></a>
              		</c:when>
              		<c:otherwise>
              			下一页
              		</c:otherwise>
              	</c:choose>
				<c:choose>
              		<c:when test="${page.pageNo lt page.totalPages }">
              			<a style = "cursor:hand" onclick = "toPage(${page.totalPages })"><font color="#0d6cae">尾页</font></a>
              		</c:when>
              		<c:otherwise>
              			尾页
              		</c:otherwise>
              	</c:choose>

	<script type="text/javascript">
		function toPage(i)
  		{	
			document.forms[0].pageNo.value = i;
		  	document.forms[0].submit();
		 }
	</script>