package cn.example.baking.pojo.entity;

import lombok.Data;

import java.util.Date;

@Data
public class Banner {
    private Long id;
    private String imgUrl;
    private Date createTime;
}
