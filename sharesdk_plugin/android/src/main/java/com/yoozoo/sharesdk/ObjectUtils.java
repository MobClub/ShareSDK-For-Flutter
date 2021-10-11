package com.yoozoo.sharesdk;

import java.util.Collection;
import java.util.Map;

public class ObjectUtils {
	public static final boolean isEmpty(Collection collection) {
		return null == collection || collection.isEmpty();
	}

	public static final boolean isEmpty(Map map) {
		return null == map || map.isEmpty();
	}

	public static final boolean isEmpty(Object[] objects) {
		return null == objects || objects.length == 0;
	}

	public static final boolean isNull(Object o) {
		return null == o;
	}

	public static final boolean notNull(Object o) {
		return null != o;
	}
}
