package org.notepress.util.json;

import java.io.Writer;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.json.JsonHierarchicalStreamDriver;
import com.thoughtworks.xstream.io.json.JsonWriter;

public class JsonBuilder {
	public static String TREEJSON = "TREE";
	public static String GRIDJSON = "GRID";
	public static String COMBOJSON = "COMBO";
	public static String PLAINJSON = "PLAIN";
	public static String jsonType = PLAINJSON;
	public static XStream xstream = null;
	public static String root = "root";
	public static String totalProperty = "total";
	static {
		xstream = new XStream(new JsonHierarchicalStreamDriver() {
			public HierarchicalStreamWriter createWriter(Writer writer) {
				return new JsonWriter(writer, JsonWriter.DROP_ROOT_MODE);
			}
		});
	}

	public static String getJsonType() {
		return JsonBuilder.jsonType;
	}

	public static void setJsonType(String jsonType) {
		JsonBuilder.jsonType = jsonType;
	}

	/**
	 * 设置root属性名
	 * 
	 * @param root
	 *            root属性名
	 */
	public static void setRootString(String root) {
		JsonBuilder.root = root;
	}

	/**
	 * 设置totalProperty属性名
	 * 
	 * @param totalProperty
	 *            totalProperty属性名
	 */
	public static void setTotalProperty(String totalProperty) {
		JsonBuilder.totalProperty = totalProperty;
	}

	public static String builderTreeJson(List data, RowHanlder rowHanlder) {
		StringBuffer json = new StringBuffer();
		for (Object object : data) {// 循环所有节点，按排序
			AsyncTreeModel tm = rowHanlder.execute(object);
			Map<String, String> map = tm.getAttributes();

		}
		return json.toString();
	}

	public static String builderAsyncTreeJson(List<AsyncTreeModel> data) {
		return xstream.toXML(data);
	}

	public static String builderObjectJson(Object data) {
		return xstream.toXML(data);
	}

	public static String builderFormJson(Object data) {
		String json = xstream.toXML(data);
		String extraJson = "{success:true,data:" + json + "}";
		return extraJson;
	}

	public static String builderFormJson(Object data1, Object data2) {
		String json1 = xstream.toXML(data1);
		String json2 = xstream.toXML(data2);
		String json = StringUtils.substring(json1, 0, json1.length() - 1) + ","
				+ StringUtils.substring(json2, 1);

		String extraJson = "{success:true,data:" + json + "}";
		return extraJson;
	}

	public static String builderGridJson(List data, int totalSize) {
		String json = xstream.toXML(data);
		String extraJson = "{" + JsonBuilder.totalProperty + ":" + totalSize
				+ "," + JsonBuilder.root + ":" + json + "}";
		return extraJson;
	}

}
