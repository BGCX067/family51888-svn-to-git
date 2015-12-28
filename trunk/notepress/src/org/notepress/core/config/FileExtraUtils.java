package org.notepress.core.config;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.List;

import org.notepress.util.print.Print;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

public class FileExtraUtils {
	private static FileExtra fe = null;
	private static String extraDataConfigPath = "";

	private FileExtraUtils() {
	}

	public static void init() {
		Print.println("Initializing NotePress ExtraData");
		if (fe == null) {
			XStream xstream = new XStream(new DomDriver());
			xstream.alias("extra", FileExtra.class);

			xstream.aliasField("file", FileExtra.class, "file");

			xstream.alias("data", ExtraData.class);

			FileInputStream fis;
			try {
				fis = new FileInputStream(FileExtraUtils.extraDataConfigPath);
				fe = (FileExtra) xstream.fromXML(fis);
				Print.println("Ok");
			} catch (FileNotFoundException e) {
				e.printStackTrace();
				System.exit(-1);
			}
		}
	}

	public static List<ExtraData> getFileData() {
		return fe.getFile();
	}

	public static String getFileString() {
		StringBuffer js = new StringBuffer();
		js.append("var fileData=new Array();");
		List<ExtraData> t = fe.getFile();
		if (t != null) {
			int i = 0;
			for (ExtraData extraData : t) {
				js.append("fileData[" + i + "]=['" + extraData.getId() + "','"
						+ extraData.getFieldLabel() + "',"
						+ extraData.getAllowBlank() + ","
						+ extraData.getMaxLength() + "];");
				i++;
			}
		}
		return js.toString();
	}

	public static String getExtraDataConfigPath() {
		return extraDataConfigPath;
	}

	public static void setExtraDataConfigPath(String extraDataConfigPath) {
		FileExtraUtils.extraDataConfigPath = extraDataConfigPath;
	}
}
