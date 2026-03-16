package member;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 쇼핑몰 회원 정보를 담는 DTO
 * members 테이블과 매핑
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MemberDTO {

    private long userNum;
    private String id;
    private String pw;
    private String name;
    private String phone;
    private String email;
    private String createdAt;
}
