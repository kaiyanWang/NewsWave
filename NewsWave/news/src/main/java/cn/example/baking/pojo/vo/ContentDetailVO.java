package cn.example.baking.pojo.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class ContentDetailVO {
    private Long id;
    private String title;
    private String content;
    private String brief;
    private String videoUrl;
    private String nickname;
    private String userImgUrl;
    private Integer viewCount;
    @JsonFormat(pattern = "yyyy/MM/dd",timezone = "GMT+8")
    private Date createTime;
    private Long userId;
    private Integer type;
}
