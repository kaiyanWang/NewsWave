package cn.example.baking.pojo.dto;

import lombok.Data;

@Data
public class UserUpdateDTO {
    private Long id;
    private String nickname;
    //头像图片上传需要添加图片路径属性
    private String imgUrl;
    //后台管理页面更新用户管理员状态时使用
    private Integer isAdmin;
}
