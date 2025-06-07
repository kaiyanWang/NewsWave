package cn.example.baking.mapper;

import cn.example.baking.pojo.vo.CommentVO;
import cn.example.baking.pojo.entity.Comment;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentMapper {
    void insert(Comment comment);

    List<CommentVO> selectByContentId(Long id);

    void updateCommentCountById(Long contentId);
}
