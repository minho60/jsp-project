package admin.util;

/**
 * 개인정보 마스킹 유틸리티
 */
public class MaskUtil {

    /**
     * 이메일 마스킹
     * maskEmail("kahyou222@gmail.com") -> "kah***@gmail.com"
     */
    public String maskEmail(String email) {
        if (email == null || email.isEmpty()) return "";
        int at = email.indexOf('@');
        if (at < 0) return email;

        String local = email.substring(0, at);
        String domain = email.substring(at + 1);

        if (local.length() <= 3) {
            return local.charAt(0) + "***@" + domain;
        }
        return local.substring(0, 3) + "***@" + domain;
    }

    /**
     * 전화번호 마스킹
     * maskPhoneNumber("010-1234-5678") -> "010-12**-****"
     */
    public String maskPhoneNumber(String phone) {
        if (phone == null || phone.isEmpty()) return "";
        String[] parts = phone.split("-");
        if (parts.length != 3) return phone;

        String maskedMiddle = parts[1].substring(0, Math.min(2, parts[1].length())) + "**";
        return parts[0] + "-" + maskedMiddle + "-****";
    }
}
