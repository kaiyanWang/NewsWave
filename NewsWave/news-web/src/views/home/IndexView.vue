<!--首页-->
<template>
  <div style="width: 1200px;margin: 0 auto;">
    <!--首页轮播图 todo-->

    <!-- 首页轮播图 -->
    <el-carousel :interval="4000" arrow="always">
      <el-carousel-item v-for="item in bannerArr" :key="item.id">
        <img :src="BASE_URL + item.imgUrl" style="width: 100%;">
      </el-carousel-item>
    </el-carousel>

    <el-row :gutter="10" style="background-color:#fff;margin-top:10px;">
     <el-col :span="3">
       <p style="font-size:28px;margin:10px;">热点</p>
     </el-col>
     <el-col :span="21">
       <el-menu mode="horizontal" active-text-color="orange" default-active="0" @select="selectRecipe">
         <el-menu-item index="0">全部</el-menu-item>
         <el-menu-item v-for="c in recipeCatArr" :index="c.id">{{c.name}}</el-menu-item>
       </el-menu>
     </el-col>
    </el-row>
    <el-row :gutter="10">
     <el-col :span="6" v-for="item in recipeArr" style="margin-top:10px">
       <el-card>
         <!--点击图片与标题都可以跳转至详情页-->
           <img :src="BASE_URL+item.imgUrl" style="width: 100%;height: 150px;">
           <p style="line-height:40px;">{{ item.title }}</p>
         <el-row :gutter="10">
          <el-col :span="4">
            <el-avatar :src="BASE_URL+item.userImgUrl"></el-avatar>
          </el-col>
          <el-col :span="16" style="font-size:20px;line-height:40px;">{{ item.nickname }}</el-col>
          <el-col :span="4" style="line-height:40px;">{{ item.categoryName }}</el-col>
         </el-row>
       </el-card>
     </el-col>
    </el-row>
    <div style="text-align:center;margin:10px;">
      <el-button @click="router.push('/list?type=1')">点击加载更多...</el-button>
    </div>

    <el-row :gutter="10" style="background-color:#fff;margin-top:10px;">
      <el-col :span="3">
        <p style="font-size:28px;margin:10px;">科技</p>
      </el-col>
      <el-col :span="21">
        <el-menu mode="horizontal" active-text-color="orange" default-active="0" @select="selectVideo">
          <el-menu-item index="0">全部</el-menu-item>
          <el-menu-item v-for="c in videoCatArr" :index="c.id">{{c.name}}</el-menu-item>
        </el-menu>
      </el-col>
    </el-row>
    <el-row :gutter="10">
      <el-col :span="6" v-for="item in videoArr" style="margin-top:10px">
        <el-card>
            <img :src="BASE_URL+item.imgUrl" style="width: 100%;height: 150px;">
            <p style="line-height:40px;">{{ item.title }}</p>
          <el-row :gutter="10">
            <el-col :span="4">
              <el-avatar :src="BASE_URL+item.userImgUrl"></el-avatar>
            </el-col>
            <el-col :span="13" style="font-size:20px;line-height:40px;">{{ item.nickname }}</el-col>
            <el-col :span="7" style="line-height:40px;">{{ item.categoryName }}</el-col>
          </el-row>
        </el-card>
      </el-col>
    </el-row>
    <div style="text-align:center;margin:10px;">
      <el-button @click="router.push('/list?type=2')">点击加载更多...</el-button>
    </div>

    <el-row :gutter="10" style="background-color:#fff;margin-top:10px;">
      <el-col :span="3">
        <p style="font-size:28px;margin:10px;">历史</p>
      </el-col>
      <el-col :span="21">
        <el-menu mode="horizontal" active-text-color="orange" default-active="0" @select="selectInfo">
          <el-menu-item index="0">全部</el-menu-item>
          <el-menu-item v-for="c in infoCatArr" :index="c.id">{{c.name}}</el-menu-item>
        </el-menu>
      </el-col>
    </el-row>
    <el-row :gutter="10">
      <el-col :span="6" v-for="item in infoArr" style="margin-top:10px">
        <el-card>

            <img :src="BASE_URL+item.imgUrl" style="width: 100%;height: 150px;">
            <p style="line-height:40px;">{{ item.title }}</p>
          <el-row :gutter="10">
            <el-col :span="4">
              <el-avatar :src="BASE_URL+item.userImgUrl"></el-avatar>
            </el-col>
            <el-col :span="13" style="font-size:20px;line-height:40px;">{{ item.nickname }}</el-col>
            <el-col :span="7" style="line-height:40px;">{{ item.categoryName }}</el-col>
          </el-row>
        </el-card>
      </el-col>
    </el-row>
    <div style="text-align:center;margin:10px;">
      <el-button @click="router.push('/list?type=3')">点击加载更多...</el-button>
    </div>

  </div>
</template>

<script setup>
import router from "@/router";
import {onMounted, ref} from "vue";
import axios from "axios";
import qs from "qs";

//1.定义三个二级分类数据
const recipeCatArr = ref([]);
const videoCatArr = ref([]);
const infoCatArr = ref([]);
//定义三个内容数组
const recipeArr = ref([]);
const videoArr = ref([]);
const infoArr = ref([]);
//2.立即执行
onMounted(()=>{
  axios.get(BASE_URL+'/v1/categories/1/sub').then((response)=>{
    if(response.data.code==2001){
      recipeCatArr.value = response.data.data;
    }
  })
  axios.get(BASE_URL+'/v1/categories/2/sub').then((response)=>{
    if(response.data.code==2001){
      videoCatArr.value = response.data.data;
    }
  })
  axios.get(BASE_URL+'/v1/categories/3/sub').then((response)=>{
    if(response.data.code==2001){
      infoCatArr.value = response.data.data;
    }
  })
  //调用加载内容的方法 (类型,二级分类) 0代表默认加载本类型的全部内容
  loadContents(1,0);
  loadContents(2,0);
  loadContents(3,0);
})

const loadContents = (type,categoryId)=>{
   let data = qs.stringify({type:type,categoryId:categoryId});
   axios.get(BASE_URL+'/v1/contents/index?'+data)
  .then((response)=>{
    if(response.data.code==2001){
      switch (type){
        case 1 :
          recipeArr.value = response.data.data;break;
        case 2 :
          videoArr.value = response.data.data;break;
        case 3 :
          infoArr.value = response.data.data;break;
      }
    }
  })
}
//选择对应食谱二级分类菜单项时,会触发下面的函数
//index是二级分类的id :index="c.id"
const selectRecipe = (index)=>{
  loadContents(1,index)
}
const selectVideo = (index)=>{
  loadContents(2,index)
}
const selectInfo = (index)=>{
  loadContents(3,index)
}
//定义轮播图数组 todo
const bannerArr = ref([]);

onMounted(() => {
  axios.get(BASE_URL + "/v1/banners/index").then((response) => {
    if (response.data.code === 2001) {
      bannerArr.value = response.data.data;
    }
  });
});

</script>

<style scoped>
  p {
    white-space: nowrap; /*强制内容不换行*/
    overflow: hidden; /*溢出隐藏*/
    text-overflow: ellipsis; /*溢出的部分替换为省略号*/
  }
</style>