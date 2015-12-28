package org.notepress.util;

public class HtmlUtils {
	public static String filterHtml(String text) {

		String result = "";
		int length = text.length();
		for (int i = 0; i < length; i++) {
			char c = text.charAt(i);
			switch (c) {
			case '<':
				result += "&lt;";
				break;
			case '>':
				result += "&gt;";
				break;
			case '"':
				result += "&quot;";
				break;
			case '\'':
				result += "&apos;";
				break;
			case '\t':
			case '\n':
				result += "<br/>";
				break;
			default:
				result += c;
			}
		}
		return result;
	}

}
