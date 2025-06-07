package cn.example.baking.pojo.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class ContentOtherVO {
    private Long id;
    private String title;
    private String imgUrl;
    @JsonFormat(pattern = "yyyy/MM/dd",timezone = "GMT+8")
    private Date createTime;
}
