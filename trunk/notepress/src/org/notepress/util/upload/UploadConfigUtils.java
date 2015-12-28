package org.notepress.util.upload;

import java.io.FileInputStream;
import java.io.FileNotFoundException;

import org.notepress.util.print.Print;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

public class UploadConfigUtils {
	private static String uploadConfigPath = "";
	private static UploadConfig uploadConfig = null;

	private UploadConfigUtils() {
	}

	public static void init() {
		Print.println("Initializing NotePress Upload");
		if (uploadConfig == null) {
			XStream xstream = new XStream(new DomDriver());
			xstream.alias("file", UploadConfig.class);
			FileInputStream fis;
			try {
				fis = new FileInputStream(UploadConfigUtils.uploadConfigPath);
				uploadConfig = (UploadConfig) xstream.fromXML(fis);
				Print.println("Ok");
			} catch (FileNotFoundException e) {
				e.printStackTrace();
				System.exit(-1);
			}
		}
	}

	public static UploadConfig getUploadConfig() {
		return UploadConfigUtils.uploadConfig;
	}

	public static String getUploadConfigPath() {
		return uploadConfigPath;
	}

	public static void setUploadConfigPath(String uploadConfigPath) {
		UploadConfigUtils.uploadConfigPath = uploadConfigPath;
	}
}
