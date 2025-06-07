package cn.example.baking.service;

import cn.example.baking.pojo.vo.CategoryVO;

import java.util.List;

public interface ICategoryService {
    List<CategoryVO> typeList();

    List<CategoryVO> listByType(Integer type);
}
