package cn.example.baking.pojo.entity;

import lombok.Data;

import java.util.Date;

//内容实体类
@Data
public class Content {
    private Long id;
    private String title;
    private String imgUrl;
    private String videoUrl;
    private String content;
    private Integer type;
    private Integer viewCount;
    private Integer commentCount;
    private String brief;
    private Long categoryId;
    private Long userId;
    private Long updateBy;
    private Date createTime;
    private Date updateTime;
}
