package service.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QaDTO {
    private Long qaNum;
    private String type;
    private String title;
    private String content;
    
    // 회원
    private Long userNum;

    // 비회원
    private String guestName;
    private String guestPassword;  // BCrypt 해시 예정
    private String guestEmail;

    private String status;         // WAITING, ANSWERED
    private String answer;
    private LocalDateTime answeredAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

}
