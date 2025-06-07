package cn.example.baking.service;

import cn.example.baking.pojo.vo.BannerIndexVO;
import cn.example.baking.pojo.vo.BannerAdminVO;

import java.util.List;

public interface IBannerService {
    List<BannerIndexVO> listForIndex();

    List<BannerAdminVO> listForAdmin();

    void deleteById(Long id);
}
