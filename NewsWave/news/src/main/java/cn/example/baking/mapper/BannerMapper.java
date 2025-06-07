package cn.example.baking.mapper;

import cn.example.baking.pojo.vo.BannerIndexVO;
import cn.example.baking.pojo.vo.BannerAdminVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BannerMapper {
    List<BannerIndexVO> selectForIndex();

    List<BannerAdminVO> selectForAdmin();

    String selectUrlById(Long id);

    void deleteById(Long id);
}
