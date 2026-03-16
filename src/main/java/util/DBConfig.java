package util;

import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;

class DBConfig {

	private static final String PROPERTIES_FILE = "local.env";
	private static final String[] KEYS = { "JDBC_URL", "JDBC_USERNAME", "JDBC_PASSWORD" };

	private static final DBConfig INSTANCE = new DBConfig();

	private final Map<String, String> values = new LinkedHashMap<>();
	private final Map<String, String> source = new LinkedHashMap<>();

	private DBConfig() {
		for (String key : KEYS) {
			values.put(key, null);
			source.put(key, null);
		}

		try {
			for (String key : KEYS) {
				String value = System.getenv(key);
				if (value == null)
					continue;
				values.put(key, value);
				source.put(key, "env");
			}

			boolean hasMissing = values.containsValue(null);

			if (hasMissing) {
				Properties props = new Properties();

				InputStream input = DBConfig.class.getClassLoader().getResourceAsStream(PROPERTIES_FILE);
				if (input == null) {
					throw new Exception("환경변수 또는 " + PROPERTIES_FILE + " 를 찾을 수 없음");
				}

				props.load(input);

				for (String key : KEYS) {
					if (values.get(key) != null)
						continue;
					String value = props.getProperty(key);
					if (value == null)
						continue;
					values.put(key, value);
					source.put(key, "properties");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static DBConfig getInstance() {
		return INSTANCE;
	}

	public String get(String key) {
		return values.get(key);
	}

	public Map<String, String> getSourceInfo() {
		return new LinkedHashMap<>(source);
	}
}
