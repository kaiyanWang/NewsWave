package cn.example.baking.service;

import cn.example.baking.pojo.vo.*;
import cn.example.baking.pojo.dto.ContentDTO;
import cn.example.baking.pojo.dto.ContentIndexQueryDTO;
import cn.example.baking.pojo.dto.ContentManagementQueryDTO;
import cn.example.baking.pojo.vo.*;

import java.util.List;

public interface IContentService {
    void addNew(ContentDTO contentDTO);

    List<ContentManagementVO> listForManagement(ContentManagementQueryDTO contentManagementQueryDTO);

    void deleteById(Long id);

    ContentUpdateVO getDetailForUpdate(Long id);

    List<ContentIndexVO> listForIndex(ContentIndexQueryDTO contentIndexQueryDTO);

    ContentDetailVO getDetailById(Long id);

    List<ContentOtherVO> listForOtherByUserId(Long id);

    List<ContentOtherVO> listForHot();

    List<ContentIndexVO> listByType(Integer type);

    List<ContentIndexVO> searchByWd(String wd);

    List<ContentAdminVO> listForAdmin();
}
