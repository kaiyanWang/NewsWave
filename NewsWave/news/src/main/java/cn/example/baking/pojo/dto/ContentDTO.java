package cn.example.baking.pojo.dto;

import lombok.Data;

@Data
public class ContentDTO {
    //新增文章id属性,修改时传入
    private Long id;
    private String title;
    private Integer type;
    private Long categoryId;
    private String imgUrl;
    private String videoUrl;
    private String content;
    private String brief;
    private Long userId;
    private Long updateBy;
}
