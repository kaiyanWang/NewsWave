package cn.example.baking.mapper;

import cn.example.baking.pojo.vo.CategoryVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryMapper {
    List<CategoryVO> selectForType();

    List<CategoryVO> selectByType(Integer type);
}
