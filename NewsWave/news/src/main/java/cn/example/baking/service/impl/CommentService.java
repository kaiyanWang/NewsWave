package cn.example.baking.service.impl;

import cn.example.baking.pojo.vo.CommentVO;
import cn.example.baking.mapper.CommentMapper;
import cn.example.baking.pojo.dto.CommentDTO;
import cn.example.baking.pojo.entity.Comment;
import cn.example.baking.service.ICommentService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class CommentService implements ICommentService {
    @Autowired
    CommentMapper mapper;

    @Override
    public void addNew(CommentDTO commentDTO) {
        Comment comment = new Comment();
        BeanUtils.copyProperties(commentDTO,comment);
        comment.setCreateTime(new Date());
        mapper.insert(comment);
        //每新增一条评论数据,评论量+1
        mapper.updateCommentCountById(comment.getContentId());
    }

    @Override
    public List<CommentVO> listByContentId(Long id) {
        return mapper.selectByContentId(id);
    }
}
