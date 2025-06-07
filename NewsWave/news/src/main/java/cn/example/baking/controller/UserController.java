package cn.example.baking.controller;

import cn.example.baking.pojo.dto.UserLoginDTO;
import cn.example.baking.pojo.dto.UserRegDTO;
import cn.example.baking.pojo.dto.UserUpdateDTO;
import cn.example.baking.pojo.vo.UserAdminVO;
import cn.example.baking.pojo.vo.UserVO;
import cn.example.baking.response.JsonResult;
import cn.example.baking.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/v1/users")
public class UserController {
    @Autowired
    IUserService userService;

    @PostMapping("reg")
    public JsonResult reg(UserRegDTO userRegDTO){
        System.out.println("userRegDTO = " + userRegDTO);
        userService.reg(userRegDTO);
        return JsonResult.ok();
    }

    @PostMapping("login")
    public JsonResult login(UserLoginDTO userLoginDTO){
        UserVO userVO = userService.login(userLoginDTO);
        return JsonResult.ok(userVO);
    }

    @PostMapping("update")
    public JsonResult update(UserUpdateDTO userUpdateDTO){
        System.out.println("userUpdateDTO = " + userUpdateDTO);
        userService.update(userUpdateDTO);
        return JsonResult.ok();
    }

    //查询用户管理界面所有用户数据
    @GetMapping("admin")
    public JsonResult listForAdmin(){
        List<UserAdminVO> list = userService.listForAdmin();
        return JsonResult.ok(list);
    }

    //用户管理界面删除用户
    @PostMapping("{id}/delete")
    public JsonResult deleteById(@PathVariable Long id){
        userService.deleteById(id);
        return JsonResult.ok();
    }
}
