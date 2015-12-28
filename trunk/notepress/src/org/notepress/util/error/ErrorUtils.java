package org.notepress.util.error;

import java.io.FileInputStream;
import java.io.FileNotFoundException;

import org.notepress.util.print.Print;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

public class ErrorUtils {
	private static String errorConfigPath = "";
	private static Error error = null;

	private ErrorUtils() {

	}

	public static void init() {
		Print.println("Initializing NotePress Error");
		if (error == null) {
			XStream xstream = new XStream(new DomDriver());
			xstream.alias("error", Error.class);
			FileInputStream fis;
			try {
				fis = new FileInputStream(ErrorUtils.errorConfigPath);
				error = (Error) xstream.fromXML(fis);
				Print.println("Ok");
			} catch (FileNotFoundException e) {
				e.printStackTrace();
				System.exit(-1);
			}
		}
	}

	public static Error getError() {
		return ErrorUtils.error;
	}

	public static String toJavaScript() {
		StringBuffer sb = new StringBuffer();
		sb.append("var NPC001 = '" + error.getNpc001() + "';");
		sb.append("var NPC002 = '" + error.getNpc002() + "';");
		sb.append("var NPC003 = '" + error.getNpc003() + "';");

		sb.append("var NPI001 = '" + error.getNpi001() + "';");
		sb.append("var NPI002 = '" + error.getNpi002() + "';");
		sb.append("var NPI003 = '" + error.getNpi003() + "';");
		sb.append("var NPI004 = '" + error.getNpi004() + "';");
		sb.append("var NPI005 = '" + error.getNpi005() + "';");
		sb.append("var NPI006 = '" + error.getNpi006() + "';");
		sb.append("var NPI007 = '" + error.getNpi007() + "';");
		sb.append("var NPI008 = '" + error.getNpi008() + "';");
		sb.append("var NPI009 = '" + error.getNpi009() + "';");
		sb.append("var NPI010 = '" + error.getNpi010() + "';");

		sb.append("var NPE001 = '" + error.getNpe001() + "';");
		sb.append("var NPE002 = '" + error.getNpe002() + "';");
		sb.append("var NPE003 = '" + error.getNpe003() + "';");
		sb.append("var NPE004 = '" + error.getNpe004() + "';");
		sb.append("var NPE005 = '" + error.getNpe005() + "';");
		sb.append("var NPE006 = '" + error.getNpe006() + "';");
		sb.append("var NPE007 = '" + error.getNpe007() + "';");
		sb.append("var NPE008 = '" + error.getNpe008() + "';");
		sb.append("var NPE009 = '" + error.getNpe009() + "';");
		sb.append("var NPE010 = '" + error.getNpe010() + "';");
		return sb.toString();
	}

	public static String getErrorConfigPath() {
		return errorConfigPath;
	}

	public static void setErrorConfigPath(String errorConfigPath) {
		ErrorUtils.errorConfigPath = errorConfigPath;
	}
}
