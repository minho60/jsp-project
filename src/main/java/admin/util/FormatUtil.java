package admin.util;

import java.text.NumberFormat;
import java.util.Locale;

/**
 * JSP에서 사용할 포맷팅 유틸리티
 * EL에서 static 메서드 호출이 어려우므로 인스턴스 메서드로 제공
 */
public class FormatUtil {

    /**
     * 숫자를 한국식 천단위 구분으로 포맷
     */
    public String number(Object value) {
        if (value == null) return "0";
        try {
            long num = Long.parseLong(String.valueOf(value));
            return NumberFormat.getNumberInstance(Locale.KOREA).format(num);
        } catch (NumberFormatException e) {
            return String.valueOf(value);
        }
    }
}
