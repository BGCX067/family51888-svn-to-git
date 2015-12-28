package org.notepress.util.print;

public class Print {
	public static void println(String info) {
		Print.println(info, 100);
	}

	public static void println(String info, int size) {
		if (info == null) {
			info = "";
		}
		int length = info.getBytes().length;
		System.out.println(repeat(size - length, "-") + info);
	}

	public static String repeat(int times, String c) {
		String s = "";
		for (int i = 0; i < times; i++) {
			s = s + c;
		}
		return s;
	}
}
