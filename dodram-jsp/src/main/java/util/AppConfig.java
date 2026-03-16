package util;

import java.io.File;
import java.io.InputStream;
import java.util.Properties;

/**
 * local.env에서 UPLOAD_DIR 등 앱 설정을 읽는 클래스. 우선순위: 환경변수 > local.env > OS 기반 기본값
 */
public class AppConfig {

	private static final String PROPERTIES_FILE = "local.env";
	private static final AppConfig INSTANCE = new AppConfig();

	private final String uploadDir;

	private AppConfig() {
		String dir = null;

		// 1순위: 환경변수
		String envDir = System.getenv("UPLOAD_DIR");
		if (envDir != null && !envDir.isBlank()) {
			dir = envDir;
		}

		// 2순위: local.env 파일
		if (dir == null) {
			try {
				Properties props = new Properties();
				InputStream input = AppConfig.class.getClassLoader().getResourceAsStream(PROPERTIES_FILE);
				if (input != null) {
					props.load(input);
					String propDir = props.getProperty("UPLOAD_DIR");
					if (propDir != null && !propDir.isBlank()) {
						dir = propDir;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// 3순위: OS 기반 기본값
		if (dir == null) {
			String home = System.getProperty("user.home");
			dir = home + File.separator + "dodram-uploads";
		}

		this.uploadDir = dir;

		// 디렉토리 자동 생성
		File base = new File(this.uploadDir);
		if (!base.exists()) {
			base.mkdirs();
		}
	}

	public static AppConfig getInstance() {
		return INSTANCE;
	}

	/** 업로드 기본 경로 */
	public String getUploadDir() {
		return uploadDir;
	}

//	/** 상품 이미지 업로드 경로 */
//	public String getProductDir() {
//		return uploadDir + File.separator + "product";
//	}

//	/** 공지사항 이미지 업로드 경로 */
//	public String getNoticeDir() {
//		return uploadDir + File.separator + "notice";
//	}
}
