package cn.example.baking.mapper;

import cn.example.baking.pojo.entity.User;
import cn.example.baking.pojo.vo.UserAdminVO;
import cn.example.baking.pojo.vo.UserVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {
    UserVO selectByUserName(String username);
    int insert(User user);

    void update(User user);

    List<UserAdminVO> selectForAdmin();

    String selectUrlById(Long id);

    void deleteById(Long id);
}
