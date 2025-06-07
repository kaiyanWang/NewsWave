package cn.example.baking.pojo.vo;

import lombok.Data;

@Data
public class ContentUpdateVO {
    private Long id;
    private String title;
    private String imgUrl;
    private String videoUrl;
    private String content;
    private Integer type;
    private Long categoryId;
}
