package cn.example.baking.service;

import cn.example.baking.pojo.vo.CommentVO;
import cn.example.baking.pojo.dto.CommentDTO;

import java.util.List;

public interface ICommentService {
    void addNew(CommentDTO commentDTO);

    List<CommentVO> listByContentId(Long id);
}
