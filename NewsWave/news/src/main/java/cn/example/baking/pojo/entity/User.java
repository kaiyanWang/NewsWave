package cn.example.baking.pojo.entity;

import lombok.Data;

import java.util.Date;

@Data
public class User {
    private Long id;
    private String username;
    private String password;
    private String nickname;
    private Integer isAdmin;
    private Date createTime;
    private String imgUrl;
}
