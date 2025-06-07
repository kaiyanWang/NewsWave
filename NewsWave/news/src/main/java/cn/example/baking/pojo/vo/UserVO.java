package cn.example.baking.pojo.vo;

import lombok.Data;

import java.util.Date;

@Data
public class UserVO {
    private Long id;
    private String username;
    private String password;
    private String nickname;
    private Integer isAdmin;
    private String imgUrl;
}
