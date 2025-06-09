<!--稿件管理页-->
<template>
  <el-radio-group v-model="type" @change="loadContents()">
    <el-radio-button v-for="c in catTypeArr" :label="c.type">{{c.name}}</el-radio-button>
<!--    <el-radio-button label="1">热点</el-radio-button>-->
<!--    <el-radio-button label="2">科技</el-radio-button>-->
<!--    <el-radio-button label="3">历史</el-radio-button>-->
  </el-radio-group>
  <el-button type="primary" style="margin-left:20px;margin-top:7px;" @click="router.push('/personal/post')">发布内容</el-button>
  <el-table :data="arr">
    <el-table-column type="index" label="编号" width="80" align="center"></el-table-column>
    <el-table-column prop="title" label="标题" width="290" align="center"></el-table-column>
    <el-table-column prop="categoryName" label="分类" width="80" align="center"></el-table-column>
    <el-table-column prop="viewCount" label="浏览量" width="80" align="center"></el-table-column>
    <el-table-column prop="commentCount" label="评论量" width="80" align="center"></el-table-column>
    <el-table-column prop="createTime" label="发布时间" width="120" align="center"></el-table-column>
    <el-table-column label="操作" align="center">
      <template #default="scope">
        <el-button-group>
          <el-button type="success" @click="edit(scope.row)">编辑</el-button>
          <el-button type="danger" @click="del(scope.$index,scope.row)">删除</el-button>
        </el-button-group>
      </template>
    </el-table-column>
  </el-table>
</template>

<script setup>
import router from "@/router";
import {onMounted, ref} from "vue";
import {ElMessage} from "element-plus";
import axios from "axios";
import qs from "qs";

//跳转到内容发布页进行编辑
const edit = (c)=>{
  router.push('/personal/post?id='+c.id);
}

const del=(i,c)=>{
  if(confirm('是否确认删除此稿件?')){
    axios.post(BASE_URL+'/v1/contents/'+c.id+'/delete')
    .then((response)=>{
      if(response.data.code==2001){
        arr.value.splice(i,1);
        ElMessage.success('删除成功!');
      }
    })

  }
}
//1.准备JS数组
const arr = ref([]);//存放下方表格中的真实数据
const catTypeArr = ref([]);//存放真实的一级分类数据
const type = ref('1');//设置单选组的默认值为1,也就是type=1,烘焙食谱
//2.页面加载完立即执行
onMounted(()=>{
  //请求一级分类数据
  axios.get(BASE_URL+'/v1/categories/type').then((response)=>{
    if(response.data.code==2001){
      catTypeArr.value = response.data.data;
    }
  })
  //页面加载完成,调用加载内容方法,此时type的默认值为1,默认加载烘焙食谱下的内容
  loadContents();
})

//每次切换一级分类,调用此函数,发请求获取当前分类下的内容
const loadContents = ()=>{
  //获取用户数据
  let user = localStorage.user?JSON.parse(localStorage.user):null;
  //准备发请求时需要用到的参数 当前用户当前类型的表格内容
  let data = qs.stringify({userId:user.id,type:type.value});
  //get请求的参数是以?拼接查询字符串的形式写的
  axios.get(BASE_URL+'/v1/contents/management?'+data)
      .then((response)=>{
        if(response.data.code==2001){
          arr.value = response.data.data;
        }
      })
}

</script>

<style scoped>

</style>