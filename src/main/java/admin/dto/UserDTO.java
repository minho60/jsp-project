package admin.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 사용자 정보를 담는 DTO (members 테이블과 매핑)
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {

    private long userNumber;   // user_num
    private String userName;   // id
    private String name;       // name
    private String email;      // email
    private String phoneNumber; // phone
    private String createdAt;  // created_at (DATETIME → String)
}
