package org.notepress.util.cache;

import java.io.Serializable;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

import org.notepress.util.print.Print;

public class CacheUtils {
	private static Cache cache = null;

	private CacheUtils() {
	}

	private static String cacheConfigPath = "";

	public static void setCacheConfigPath(String cacheConfigPath) {
		CacheUtils.cacheConfigPath = cacheConfigPath;
	}

	public static void init() {
		Print.println("Initializing NotePress Cache");
		if (cache == null) {
			try {
				CacheManager manager = new CacheManager(cacheConfigPath);
				manager.addCache("notepress");
				cache = manager.getCache("notepress");
				Print.println("Ok");
			} catch (Exception e) {
				e.printStackTrace();
				System.exit(-1);
			}

		}
	}

	public static void put(String key, Object object) {
		init();
		cache.put(new Element(key, object));
	}

	public static Serializable get(String key) {
		init();
		Serializable value = cache.get(key).getValue();
		return value;
	}
}
