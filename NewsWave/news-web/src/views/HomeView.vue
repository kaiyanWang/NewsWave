<template>
  <div class="common-layout">
    <el-container>
      <el-header style="background-color:#fff;height: 80px;">
        <!--头部-->
        <el-row :gutter="20" style="width: 1200px;margin: 0 auto;">
         <el-col :span="6">
           <!--头部logo图片,点击logo跳转至http://localhost:8080/index-->
           <router-link to="/">
             <img src="/imgs/icon2.png" width="200px">
           </router-link>
         </el-col>
         <el-col :span="10">
            <!--头部导航栏-->
           <el-menu @select="handleSelect" mode="horizontal" active-text-color="orange" style="height:70px;">
             <el-menu-item index="1">热点</el-menu-item>
             <el-menu-item index="2">科技</el-menu-item>
             <el-menu-item index="3">历史</el-menu-item>
             <el-menu-item index="4">总览</el-menu-item>
           </el-menu>
         </el-col>
         <el-col :span="6">
            <!--头部搜索框-->
            <el-input placeholder="请输入您要搜索的内容" v-model="wd" @keydown.enter="search()" style="margin-top: 25px;">
              <template #append>
                <!--注意:此图标必须在下方的JS代码中导入！-->
                <el-button :icon="Search" @click="search()"></el-button>
              </template>
            </el-input>
         </el-col>
         <el-col :span="2">
            <!--设置气泡卡片-->
           <el-popover title="欢迎访问浪潮新闻" v-if="user==null" popper-style="text-align:center;">
             <template #reference>
                 <el-icon size="25" color="#666" style="margin-top:30px;"><User/></el-icon>
             </template>
             <div style="text-align: center;">
               <el-button type="info" size="small" @click="router.push('/reg')">注册</el-button>
               <el-button type="warning" size="small" @click="router.push('/login')">登录</el-button>
             </div>
           </el-popover>
           <!--再复制一个气泡卡片 登录后显示-->
           <el-popover :title="'欢迎'+user.nickname+'回来!'" v-else :width="200"
                       popper-style="text-align:center;">
             <template #reference>
               <el-icon size="25" color="#666" style="margin-top:30px;"><User/></el-icon>
             </template>
             <el-avatar :src="BASE_URL+user.imgUrl"></el-avatar>
             <div style="text-align: center;">
               <el-button type="success" size="small" @click="router.push('/personal')">个人中心</el-button>
               <el-button type="danger" size="small" @click="logout()">退出登录</el-button>
               <br>
               <el-button v-if="user.isAdmin==1" type="primary"
                          @click="router.push('/admin')"
               style="width: 158px;margin-top:8px;" size="small">后台管理页面</el-button>
             </div>
           </el-popover>
         </el-col>
        </el-row>
      </el-header>
      <el-main>
        <!--中间的部分是可变区域-->
        <router-view/>
      </el-main>
      <!--共有的尾部区域-->
      <el-footer style="background-color:rgb(50,50,50);color:#666;height: 300px;padding:50px;text-align: center;">
        <div style="width: 1200px;margin: 0 auto;">
          <el-row :gutter="10">
           <!--底部左侧区域-->
           <el-col :span="8">
             <img src="/imgs/icon2.png" width="200px">
             <p>实事热点就看浪潮新闻</p>
             <p>商城行业社区平台</p>
             <p>全国成百上千个职位等你来</p>
           </el-col>
           <!--底部中间区域-->
           <el-col :span="8" id="footer-center">
             <el-row :gutter="10">
              <el-col :span="8">
                <h3>关于我们</h3>
                <p>浪潮学院</p>
                <p>浪潮视频</p>
                <p>分类信息</p>
                <p>求职招聘</p>
                <p>社区交流</p>
              </el-col>
              <el-col :span="8">
                <h3>服务与支持</h3>
                <p>联系我们</p>
                <p>广告投放</p>
                <p>用户协议</p>
                <p>友情链接</p>
                <p>在线反馈</p>
              </el-col>
              <el-col :span="8">
                <h3>底部导航</h3>
                <p>Archiver</p>
                <p>手机版</p>
                <p>小黑屋</p>
              </el-col>
             </el-row>
           </el-col>
           <!--底部右侧区域-->
           <el-col :span="8">
             <p style="font-size:60px;color:#666;margin: 10px 0;">
               <span style="color:orange;">浪潮</span>新闻
             </p>
           </el-col>
          </el-row>
        </div>
      </el-footer>
    </el-container>
  </div>
</template>


<script setup>
//此处导入的是头部搜索框中的放大镜图标
import {Search} from '@element-plus/icons-vue'
import router from "@/router";
import {ref} from "vue";

const wd = ref('');
const search = ()=>{
  //搜索后,携带关键词到列表页
  router.push('/list?wd='+wd.value);
}


const user = ref(localStorage.user?JSON.parse(localStorage.user):null);

const logout = ()=>{
  if(confirm('您确认要退出吗?')){
    localStorage.clear();
    user.value=null;
    router.push('/');
  }
}

//给顶部一级菜单添加功能:选择对应的一级菜单项时,跳转到列表页
const handleSelect = (index)=>{
  if (index === '4') {
    // 推荐菜单项跳转到首页
    router.push('/index');
  }else{
    router.push('/list?type='+index);
  }
}
</script>

<style>
#footer-center h3 {
  color: #fff;
}
#footer-center p {
  margin: 5px 0;
}
</style>