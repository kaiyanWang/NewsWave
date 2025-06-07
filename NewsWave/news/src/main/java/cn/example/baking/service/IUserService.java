package cn.example.baking.service;

import cn.example.baking.pojo.dto.UserLoginDTO;
import cn.example.baking.pojo.dto.UserRegDTO;
import cn.example.baking.pojo.dto.UserUpdateDTO;
import cn.example.baking.pojo.vo.UserAdminVO;
import cn.example.baking.pojo.vo.UserVO;

import java.util.List;

public interface IUserService {
    void reg(UserRegDTO userRegDTO);

    UserVO login(UserLoginDTO userLoginDTO);

    void update(UserUpdateDTO userUpdateDTO);

    List<UserAdminVO> listForAdmin();

    void deleteById(Long id);
}
