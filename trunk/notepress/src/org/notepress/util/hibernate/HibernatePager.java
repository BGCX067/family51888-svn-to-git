package org.notepress.util.hibernate;

import java.util.List;

public class HibernatePager {
	private int pageSize = 0;
	private int pageNo = 0;
	private int count = 0;
	private int pageCount = 0;
	private List result = null;
	private String url = "";
	private String pageHtml = "";

	/**
	 * 构件分页对象
	 * 
	 * @param pageSize
	 *            每页显示记录数
	 * @param pageNo
	 *            当前页码
	 * @param count
	 *            总记录数
	 * @param result
	 *            分页结果
	 */
	public HibernatePager(int pageSize, int pageNo, int count, List result) {
		this.pageSize = pageSize;
		this.pageNo = pageNo;
		this.count = count;
		this.pageCount = (int) Math.ceil((float) count / pageSize);
		this.result = result;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public List getResult() {
		return result;
	}

	public void setResult(List result) {
		this.result = result;
	}

	public String getPageHtml() {
		StringBuffer sb = new StringBuffer();
		if (pageNo < 1 || pageNo > pageCount) {
			pageNo = 1;
		}
		if (pageCount <= 1) {
			sb.append("本栏目内容较少，欢迎您推荐或发布内容。");
		} else {
			if (pageNo == 1) {
				sb.append("<span class='border'><a href='" + url + "-"
						+ (pageNo + 1) + "'>下页</a></span>");
				sb.append("<span class='border'><a href='" + url + "-"
						+ pageCount + "'>尾页</a></span>");
			} else if (pageNo == pageCount) {
				sb.append("<span class='border'><a href='" + url + "-" + 1
						+ "'>首页</a></span>");
				sb.append("<span class='border'><a href='" + url + "-"
						+ (pageNo - 1) + "'>上页</a></span>");
			} else {
				sb.append("<span class='border'><a href='" + url + "-" + 1
						+ "'>首页</a></span>");
				sb.append("<span class='border'><a href='" + url + "-"
						+ (pageNo - 1) + "'>上页</a></span>");
				sb.append("<span class='border'><a href='" + url + "-"
						+ (pageNo + 1) + "'>下页</a></span>");
				sb.append("<span class='border'><a href='" + url + "-"
						+ pageCount + "'>尾页</a></span>");
			}
		}
		return sb.toString();
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
}
