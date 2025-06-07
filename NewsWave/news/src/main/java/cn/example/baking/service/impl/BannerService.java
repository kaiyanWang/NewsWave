package cn.example.baking.service.impl;

import cn.example.baking.pojo.vo.BannerIndexVO;
import cn.example.baking.mapper.BannerMapper;
import cn.example.baking.pojo.vo.BannerAdminVO;
import cn.example.baking.service.IBannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.List;

@Service
public class BannerService implements IBannerService {
    @Value("${file-path}")
    private String dirPath;

    @Autowired
    BannerMapper mapper;
    @Override
    public List<BannerIndexVO> listForIndex() {
        return mapper.selectForIndex();
    }

    @Override
    public List<BannerAdminVO> listForAdmin() {
        return mapper.selectForAdmin();
    }

    @Override
    public void deleteById(Long id) {
        //根据轮播图id查询对应轮播图的数据库表中存储的路径，如 /banner1.jpg
        String imgUrl = mapper.selectUrlById(id);
        //拼接完整的路径，并删除对应路径下的轮播图片
        new File(dirPath+imgUrl).delete();
        mapper.deleteById(id);
    }
}
