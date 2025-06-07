<!--列表页-->
<template>
  <div style="width: 1200px;margin: 0 auto;">
    <!-- 复制有四张卡片的行 -->
    <el-row :gutter="10">
      <el-col :span="6" v-for="item in contentArr" style="margin-top:10px">
        <el-card>
          <router-link :to="'/detail?id='+item.id" style="text-decoration: none;color:#333;">
            <img :src="'http://localhost:8080'+item.imgUrl" style="width: 100%;height: 150px;">
            <p style="line-height:40px;">{{ item.title }}</p>
          </router-link>
          <el-row :gutter="10">
            <el-col :span="4">
              <el-avatar :src="'http://localhost:8080'+item.userImgUrl"></el-avatar>
            </el-col>
            <el-col :span="13" style="font-size:20px;line-height:40px;">{{ item.nickname }}</el-col>
            <el-col :span="7" style="line-height:40px;">{{ item.categoryName }}</el-col>
          </el-row>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import {onBeforeUpdate, onMounted, ref} from "vue";
import axios from "axios";

  const contentArr = ref([]);

  const loadContents = ()=>{
    //判断是否包含wd关键字,如果包含,是关键字搜索
    if(location.search.includes('wd')){
      let wd = new URLSearchParams(location.search).get('wd');
      axios.get('http://localhost:8080/v1/contents/'+wd+'/search')
          .then((response)=>{
            if(response.data.code==2001){
              contentArr.value = response.data.data;
            }
          })
    }else{ //反之,是之前的业务,根据type查对应类型的内容
      let type = new URLSearchParams(location.search).get('type');
      axios.get('http://localhost:8080/v1/contents/'+type+'/type')
          .then((response)=>{
            if(response.data.code==2001){
              contentArr.value = response.data.data;
            }
          })
    }
  }
  onMounted(()=>{
   loadContents();
  })
  onBeforeUpdate(()=>{
    loadContents();
  })
</script>

<style scoped>
p {
  white-space: nowrap; /*强制内容不换行*/
  overflow: hidden; /*溢出隐藏*/
  text-overflow: ellipsis; /*溢出的部分替换为省略号*/
}
</style>