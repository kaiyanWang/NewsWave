package cn.example.baking.controller;

import cn.example.baking.pojo.vo.CommentVO;
import cn.example.baking.pojo.dto.CommentDTO;
import cn.example.baking.response.JsonResult;
import cn.example.baking.service.ICommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/v1/comments")
public class CommentController {
    @Autowired
    ICommentService commentService;

    @PostMapping("add-new")
    public JsonResult addNew(CommentDTO commentDTO){
        commentService.addNew(commentDTO);
        return JsonResult.ok();
    }

    @GetMapping("{id}")
    public JsonResult listByContentId(@PathVariable Long id){
        List<CommentVO> list = commentService.listByContentId(id);
        return JsonResult.ok(list);
    }

}
