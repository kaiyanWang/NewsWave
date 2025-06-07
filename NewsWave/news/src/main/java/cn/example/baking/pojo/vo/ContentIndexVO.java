package cn.example.baking.pojo.vo;

import lombok.Data;

@Data
public class ContentIndexVO {
    //内容表
    private Long id;
    private String title;
    private String imgUrl;
    //用户表
    private String userImgUrl;
    private String nickname;
    //分类表
    private String categoryName;
}
