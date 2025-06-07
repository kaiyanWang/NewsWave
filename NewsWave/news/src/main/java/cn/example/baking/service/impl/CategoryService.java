package cn.example.baking.service.impl;

import cn.example.baking.pojo.vo.CategoryVO;
import cn.example.baking.mapper.CategoryMapper;
import cn.example.baking.service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService implements ICategoryService {
    @Autowired
    CategoryMapper mapper;

    @Override
    public List<CategoryVO> typeList() {
        return mapper.selectForType();
    }

    @Override
    public List<CategoryVO> listByType(Integer type) {
        return mapper.selectByType(type);
    }
}
