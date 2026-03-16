package admin;

/**
 * 관리자 모듈 공통 상수
 */
public final class AdminConstants {

    private AdminConstants() {}

    /** 관리자 세션 attribute key (쇼핑몰 사용자 세션과 분리) */
    public static final String SESSION_KEY = "DD_ADMIN_AUTH";

    /** 세션 타임아웃 (초): 30분 */
    public static final int SESSION_TIMEOUT_SECONDS = 30 * 60;
}
