package cn.example.baking.mapper;

import cn.example.baking.pojo.vo.*;
import cn.example.baking.pojo.dto.ContentIndexQueryDTO;
import cn.example.baking.pojo.dto.ContentManagementQueryDTO;
import cn.example.baking.pojo.entity.Content;
import cn.example.baking.pojo.vo.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContentMapper {
    void insert(Content content);

    List<ContentManagementVO> selectForManagement(ContentManagementQueryDTO contentManagementQueryDTO);

    void deleteById(Long id);

    ContentUpdateVO selectForUpdateById(Long id);

    void update(Content content);

    List<ContentIndexVO> selectForIndex(ContentIndexQueryDTO contentIndexQueryDTO);

    ContentDetailVO selectDetailById(Long id);

    List<ContentOtherVO> selectOtherByUserId(Long id);

    List<ContentOtherVO> selectHot();

    void updateViewCountById(Long id);

    List<ContentIndexVO> selectByType(Integer type);

    List<ContentIndexVO> selectByWd(String wd);

    List<ContentAdminVO> selectForAdmin();
}
