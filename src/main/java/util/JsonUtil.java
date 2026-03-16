package util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

/**
 * Java의 Map/List/DTO를 JSON 문자열로 변환하는 유틸리티. 외부 라이브러리(Gson 등) 없이 동작.
 */
public class JsonUtil {

	@SuppressWarnings("unchecked")
	public static String toJson(Object obj) {
		if (obj == null)
			return "null";

		if (obj instanceof String) {
			return "\"" + escapeJson((String) obj) + "\"";
		}
		if (obj instanceof Number || obj instanceof Boolean) {
			return obj.toString();
		}
		if (obj instanceof Enum) {
			return toJson(enumToMap((Enum<?>) obj));
		}
		if (obj.getClass().isArray()) {
			Object[] arr = toObjectArray(obj);
			StringBuilder sb = new StringBuilder("[");
			boolean first = true;
			for (Object item : arr) {
				if (!first)
					sb.append(",");
				first = false;
				sb.append(toJson(item));
			}
			sb.append("]");
			return sb.toString();
		}
		if (obj instanceof Map) {
			Map<String, Object> map = (Map<String, Object>) obj;
			StringBuilder sb = new StringBuilder("{");
			boolean first = true;
			for (Map.Entry<String, Object> entry : map.entrySet()) {
				if (!first)
					sb.append(",");
				first = false;
				sb.append("\"").append(escapeJson(entry.getKey())).append("\":");
				sb.append(toJson(entry.getValue()));
			}
			sb.append("}");
			return sb.toString();
		}
		if (obj instanceof List) {
			List<?> list = (List<?>) obj;
			StringBuilder sb = new StringBuilder("[");
			boolean first = true;
			for (Object item : list) {
				if (!first)
					sb.append(",");
				first = false;
				sb.append(toJson(item));
			}
			sb.append("]");
			return sb.toString();
		}

		// DTO 등 일반 객체 -> getter 기반 직렬화
		return objectToJson(obj);
	}

	/**
	 * 일반 Java 객체(DTO)를 getter 메서드 기반으로 JSON 직렬화
	 */
	private static String objectToJson(Object obj) {
		Class<?> clazz = obj.getClass();

		// java.*, javax.* 등의 기본 클래스는 toString으로 처리
		String pkg = clazz.getPackage() != null ? clazz.getPackage().getName() : "";
		if (pkg.startsWith("java.") || pkg.startsWith("javax.")) {
			return "\"" + escapeJson(obj.toString()) + "\"";
		}

		StringBuilder sb = new StringBuilder("{");
		boolean first = true;

		// 필드 기반으로 getter 호출
		for (Field field : clazz.getDeclaredFields()) {
			// static, synthetic 필드 제외
			if (java.lang.reflect.Modifier.isStatic(field.getModifiers()))
				continue;
			if (field.isSynthetic())
				continue;

			String fieldName = field.getName();
			Object value = getFieldValue(obj, clazz, field, fieldName);

			if (!first)
				sb.append(",");
			first = false;
			sb.append("\"").append(escapeJson(fieldName)).append("\":");
			sb.append(toJson(value));
		}

		// 추가 getter 메서드 (getXxxLabel, getXxxColor 등 파생 프로퍼티)
		for (Method method : clazz.getDeclaredMethods()) {
			String methodName = method.getName();
			if (method.getParameterCount() != 0)
				continue;
			if (java.lang.reflect.Modifier.isStatic(method.getModifiers()))
				continue;

			// getXxx() 형태이면서 기본 필드가 아닌 파생 프로퍼티
			if (methodName.startsWith("get") && methodName.length() > 3) {
				String propName = Character.toLowerCase(methodName.charAt(3)) + methodName.substring(4);

				// 이미 필드에서 처리한 것은 건너뜀
				boolean isField = false;
				for (Field f : clazz.getDeclaredFields()) {
					if (f.getName().equals(propName)) {
						isField = true;
						break;
					}
				}
				if (isField)
					continue;

				try {
					method.setAccessible(true);
					Object value = method.invoke(obj);
					if (!first)
						sb.append(",");
					first = false;
					sb.append("\"").append(escapeJson(propName)).append("\":");
					sb.append(toJson(value));
				} catch (Exception e) {
					// 무시
				}
			}
		}

		sb.append("}");
		return sb.toString();
	}

	/**
	 * 필드 값을 가져옴 (getter 우선, 없으면 필드 직접 접근)
	 */
	private static Object getFieldValue(Object obj, Class<?> clazz, Field field, String fieldName) {
		// getter 메서드 시도
		String getterName = "get" + Character.toUpperCase(fieldName.charAt(0)) + fieldName.substring(1);
		try {
			Method getter = clazz.getMethod(getterName);
			return getter.invoke(obj);
		} catch (Exception e) {
			// boolean 타입: isXxx() 시도
			if (field.getType() == boolean.class || field.getType() == Boolean.class) {
				String isGetterName = "is" + Character.toUpperCase(fieldName.charAt(0)) + fieldName.substring(1);
				try {
					Method isGetter = clazz.getMethod(isGetterName);
					return isGetter.invoke(obj);
				} catch (Exception ex) {
					// 무시
				}
			}
		}

		// 필드 직접 접근
		try {
			field.setAccessible(true);
			return field.get(obj);
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * Enum을 key/label 맵으로 변환
	 */
	private static Map<String, Object> enumToMap(Enum<?> e) {
		java.util.LinkedHashMap<String, Object> map = new java.util.LinkedHashMap<>();
		map.put("key", e.name());

		// getLabel() 메서드가 있으면 호출
		try {
			Method labelMethod = e.getClass().getMethod("getLabel");
			map.put("label", labelMethod.invoke(e));
		} catch (Exception ex) {
			map.put("label", e.name());
		}

		// getColor() 메서드가 있으면 호출
		try {
			Method colorMethod = e.getClass().getMethod("getColor");
			map.put("color", colorMethod.invoke(e));
		} catch (Exception ex) {
			// color 없으면 무시
		}

		return map;
	}

	/**
	 * primitive 배열을 Object[]로 변환
	 */
	private static Object[] toObjectArray(Object arr) {
		if (arr instanceof Object[])
			return (Object[]) arr;
		int len = java.lang.reflect.Array.getLength(arr);
		Object[] result = new Object[len];
		for (int i = 0; i < len; i++) {
			result[i] = java.lang.reflect.Array.get(arr, i);
		}
		return result;
	}

	private static String escapeJson(String s) {
		if (s == null)
			return "";
		return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r")
				.replace("\t", "\\t").replace("<", "\\u003c").replace(">", "\\u003e");
	}
}
