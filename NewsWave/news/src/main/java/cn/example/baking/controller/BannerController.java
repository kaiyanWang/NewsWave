package cn.example.baking.controller;

import cn.example.baking.pojo.vo.BannerIndexVO;
import cn.example.baking.pojo.vo.BannerAdminVO;
import cn.example.baking.response.JsonResult;
import cn.example.baking.service.IBannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/v1/banners")
public class BannerController {
    @Autowired
    IBannerService bannerService;

    @GetMapping("index")
    public JsonResult listForIndex(){
        List<BannerIndexVO> list = bannerService.listForIndex();
        return JsonResult.ok(list);
    }

    @GetMapping("admin")
    public JsonResult listForAdmin(){
        List<BannerAdminVO> list = bannerService.listForAdmin();
        return JsonResult.ok(list);
    }

    @PostMapping("{id}/delete")
    public JsonResult deleteById(@PathVariable Long id){
        bannerService.deleteById(id);
        return JsonResult.ok();
    }

    @PostMapping("add")
    public JsonResult addBanner(@RequestBody Map<String, String> request) {
        String imgUrl = request.get("imgUrl");
        bannerService.addBanner(imgUrl);
        return JsonResult.ok();
    }
}
