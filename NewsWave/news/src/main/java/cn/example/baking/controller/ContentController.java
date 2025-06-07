package cn.example.baking.controller;

import cn.example.baking.pojo.vo.*;
import cn.example.baking.pojo.dto.ContentDTO;
import cn.example.baking.pojo.dto.ContentIndexQueryDTO;
import cn.example.baking.pojo.dto.ContentManagementQueryDTO;
import cn.example.baking.pojo.vo.*;
import cn.example.baking.response.JsonResult;
import cn.example.baking.service.IContentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/v1/contents")
public class ContentController {
    @Autowired
    IContentService contentService;

    @PostMapping("add-new")
    public JsonResult addNew(ContentDTO contentDTO){
        contentService.addNew(contentDTO);
        return JsonResult.ok();
    }

    //查询稿件管理页面的表格数据
    @GetMapping("management")
    public JsonResult listForManagement(ContentManagementQueryDTO contentManagementQueryDTO){
        List<ContentManagementVO> list = contentService.listForManagement(contentManagementQueryDTO);
        return JsonResult.ok(list);
    }

    //根据id删除稿件管理对应的内容
    @PostMapping("{id}/delete")
    public JsonResult deleteById(@PathVariable Long id){
        contentService.deleteById(id);
        return JsonResult.ok();
    }
    @GetMapping("{id}/update")
    public JsonResult getDetailForUpdate(@PathVariable Long id){
        ContentUpdateVO contentUpdateVO = contentService.getDetailForUpdate(id);
        return JsonResult.ok(contentUpdateVO);
    }

    @GetMapping("index")
    public JsonResult listForIndex(ContentIndexQueryDTO contentIndexQueryDTO){
        List<ContentIndexVO> list = contentService.listForIndex(contentIndexQueryDTO);
        return JsonResult.ok(list);
    }

    @GetMapping("{id}/detail")
    public JsonResult getDetailById(@PathVariable Long id){
        ContentDetailVO contentDetailVO = contentService.getDetailById(id);
        return JsonResult.ok(contentDetailVO);
    }

    @GetMapping("{id}/other")
    public JsonResult listForOtherByUserId(@PathVariable Long id){
        List<ContentOtherVO> list = contentService.listForOtherByUserId(id);
        return JsonResult.ok(list);
    }

    @GetMapping("hot")
    public JsonResult listForHot(){
        List<ContentOtherVO> list = contentService.listForHot();
        return JsonResult.ok(list);
    }

    @GetMapping("{type}/type")
    public JsonResult listByType(@PathVariable Integer type){
        List<ContentIndexVO> list = contentService.listByType(type);
        return JsonResult.ok(list);
    }

    @GetMapping("{wd}/search")
    public JsonResult searchByWd(@PathVariable String wd){
        List<ContentIndexVO> list = contentService.searchByWd(wd);
        return JsonResult.ok(list);
    }

    @GetMapping("admin")
    public JsonResult listForAdmin(){
        List<ContentAdminVO> list = contentService.listForAdmin();
        return JsonResult.ok(list);
    }

}
