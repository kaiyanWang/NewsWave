package cn.example.baking.controller;

import cn.example.baking.pojo.vo.CategoryVO;
import cn.example.baking.response.JsonResult;
import cn.example.baking.service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/v1/categories")
public class CategoryController {
    @Autowired
    ICategoryService categoryService;

    @GetMapping("type")
    public JsonResult typeList(){
        List<CategoryVO> list = categoryService.typeList();
        return JsonResult.ok(list);
    }

    @GetMapping("{type}/sub")
    public JsonResult listByType(@PathVariable Integer type){
        List<CategoryVO> list = categoryService.listByType(type);
        return JsonResult.ok(list);
    }

}
