package service.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FaqDTO {
    private int qaNum;
    private String type; 
    private String  question; 
    private String answer;
     
}
