package cn.example.baking.service.impl;

import cn.example.baking.exception.ServiceException;
import cn.example.baking.response.StatusCode;
import cn.example.baking.mapper.UserMapper;
import cn.example.baking.pojo.dto.UserLoginDTO;
import cn.example.baking.pojo.dto.UserRegDTO;
import cn.example.baking.pojo.dto.UserUpdateDTO;
import cn.example.baking.pojo.entity.User;
import cn.example.baking.pojo.vo.UserAdminVO;
import cn.example.baking.pojo.vo.UserVO;
import cn.example.baking.service.IUserService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.Date;
import java.util.List;

@Service
public class UserService implements IUserService {
    @Value("${file-path}")
    private String dirPath;

    @Autowired
    UserMapper userMapper;

    @Override
    public void reg(UserRegDTO userRegDTO) {
       UserVO userVO = userMapper.selectByUserName(userRegDTO.getUsername());
       if(userVO!=null){
           throw new ServiceException(StatusCode.USERNAME_ALREADY_EXISTS);
       }
       User user = new User();
        BeanUtils.copyProperties(userRegDTO,user);
        user.setCreateTime(new Date());
        user.setIsAdmin(0);
        userMapper.insert(user);
    }

    @Override
    public UserVO login(UserLoginDTO userLoginDTO) {
        UserVO userVO = userMapper.selectByUserName(userLoginDTO.getUsername());
        if(userVO==null){
            throw new ServiceException(StatusCode.USERNAME_ERROR);
        }
        if(!userVO.getPassword().equals(userLoginDTO.getPassword())){
            throw new ServiceException(StatusCode.PASSWORD_ERROR);
        }
        return userVO;
    }

    @Override
    public void update(UserUpdateDTO userUpdateDTO) {
        User user = new User();
        BeanUtils.copyProperties(userUpdateDTO,user);
        userMapper.update(user);
    }

    @Override
    public List<UserAdminVO> listForAdmin() {
        return userMapper.selectForAdmin();
    }

    @Override
    public void deleteById(Long id) {
        //先拿到用户的头像路径
        String url = userMapper.selectUrlById(id);
        //在磁盘中删除用户的头像图片文件
        new File(dirPath+url).delete();
        //再删除数据库中的用户数据
        userMapper.deleteById(id);
    }
}
