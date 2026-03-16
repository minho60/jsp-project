package admin.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 카테고리 정보를 담는 DTO (categories 테이블과 매핑)
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CategoryDTO {

    private int categoryNumber;  // category_num
    private String name;         // name
    private String description;  // description
    private String icon;         // icon
    private String createdAt;    // created_at (DATETIME → String)
}
