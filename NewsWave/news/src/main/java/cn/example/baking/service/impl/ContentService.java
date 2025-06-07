package cn.example.baking.service.impl;

import cn.example.baking.pojo.vo.*;
import cn.example.baking.mapper.ContentMapper;
import cn.example.baking.pojo.dto.ContentDTO;
import cn.example.baking.pojo.dto.ContentIndexQueryDTO;
import cn.example.baking.pojo.dto.ContentManagementQueryDTO;
import cn.example.baking.pojo.entity.Content;
import cn.example.baking.pojo.vo.*;
import cn.example.baking.service.IContentService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ContentService implements IContentService {
    @Autowired
    ContentMapper mapper;
    @Override
    public void addNew(ContentDTO contentDTO) {
        Content content = new Content();
        BeanUtils.copyProperties(contentDTO,content);
        if(contentDTO.getId()==null){//没有id 是新增
            content.setCreateTime(new Date());
            mapper.insert(content);
        }else{//有id 是修改
            content.setUpdateTime(new Date());
            mapper.update(content);
        }
    }

    @Override
    public List<ContentManagementVO> listForManagement(ContentManagementQueryDTO contentManagementQueryDTO) {
        return mapper.selectForManagement(contentManagementQueryDTO);
    }

    @Override
    public void deleteById(Long id) {
        mapper.deleteById(id);
    }

    @Override
    public ContentUpdateVO getDetailForUpdate(Long id) {
        return mapper.selectForUpdateById(id);
    }

    @Override
    public List<ContentIndexVO> listForIndex(ContentIndexQueryDTO contentIndexQueryDTO) {
        return mapper.selectForIndex(contentIndexQueryDTO);
    }

    @Override
    public ContentDetailVO getDetailById(Long id) {
        //通过id获取该文章的详情,说明该文章被浏览了一次
        //直接在此处让浏览量+1即可
        mapper.updateViewCountById(id);
        return mapper.selectDetailById(id);
    }

    @Override
    public List<ContentOtherVO> listForOtherByUserId(Long id) {
        return mapper.selectOtherByUserId(id);
    }

    @Override
    public List<ContentOtherVO> listForHot() {
        return mapper.selectHot();
    }

    @Override
    public List<ContentIndexVO> listByType(Integer type) {
        return mapper.selectByType(type);
    }

    @Override
    public List<ContentIndexVO> searchByWd(String wd) {
        return mapper.selectByWd(wd);
    }

    @Override
    public List<ContentAdminVO> listForAdmin() {
        return mapper.selectForAdmin();
    }
}
