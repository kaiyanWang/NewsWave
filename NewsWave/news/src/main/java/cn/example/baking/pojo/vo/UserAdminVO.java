package cn.example.baking.pojo.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class UserAdminVO {
    private Long id;
    private String username;
    private String nickname;
    private String imgUrl;
    private Integer isAdmin;
    @JsonFormat(pattern = "yyyy/MM/dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;
}
