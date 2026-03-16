package service.dto;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EventDto implements Serializable {
    private int id;
    private String tab;
    private String title;
    private String img;
    private String alt;
    private String date;
    private String content;
    private Date createTime;   // 작성시간
    private int viewCount;     // 조회수

    public EventDto() {}

    public EventDto(int id, String tab, String title, String img, String alt, String date, String content) {
        this.id = id;
        this.tab = tab;
        this.title = title;
        this.img = img;
        this.alt = alt;
        this.date = date;
        this.content = content;
    }
}