package member;

/**
 * 쇼핑몰 회원 모듈 공통 상수
 */
public final class MemberConstants {

    private MemberConstants() {}

    /** 쇼핑몰 회원 세션 attribute key (관리자 세션과 분리) */
    public static final String SESSION_KEY = "DD_MEMBER_AUTH";

    /** 세션 타임아웃 (초): 60분 */
    public static final int SESSION_TIMEOUT_SECONDS = 60 * 60;
}
