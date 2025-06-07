<template>
  <div class="common-layout">
    <el-container>
      <!--编辑共有的头部-->
      <el-header style="background-color:#368;line-height:60px;">
        <h1 style="color:#fff;margin: 0;font-size:30px;">
          浪潮新闻后台管理系统
          <el-button style="float: right;margin:14px 0 0 5px;" @click="logout()">退出登录</el-button>
          <span style="float: right;font-size:20px;">欢迎{{user.nickname}}回来!</span>
        </h1>
      </el-header>
      <el-container>
        <!--共有的左侧侧边栏-->
        <el-aside width="200px">
          <el-menu router active-text-color="orange" default-active="/admin/user"
                   style="height:100%;">
            <img src="/imgs/icon2.png" style="width: 150px;margin:20px;">
            <el-menu-item index="/admin/user">
              <el-icon><User/></el-icon>用户管理
            </el-menu-item>
            <el-menu-item index="/admin/banner">
              <el-icon><Picture/></el-icon>轮播图管理
            </el-menu-item>
            <el-menu-item index="/admin/content">
              <el-icon><ChatDotSquare/></el-icon>内容管理
            </el-menu-item>
            <el-menu-item index="/index">
              <el-icon><ChatDotSquare/></el-icon>回到首页
            </el-menu-item>
          </el-menu>
        </el-aside>
        <el-main>
          <router-view/>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>


<script setup>
  import router from "@/router";
  import {onMounted, ref} from "vue";
  import {ElMessage} from "element-plus";

  const user = ref(localStorage.user?JSON.parse(localStorage.user):null);
  const logout = ()=>{
    if(confirm('您确认要退出吗?')){
      localStorage.clear();
      router.push('/');
    }
  }
</script>

<style scoped>

</style>