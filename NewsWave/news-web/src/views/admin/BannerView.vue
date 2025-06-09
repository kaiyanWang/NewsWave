<!--轮播图管理页面-->
<template>
  <el-table :data="arr">
    <el-table-column type="index" label="编号" width="120px" align="center"></el-table-column>
    <el-table-column label="轮播图" width="450" align="center">
      <template #default="scope">
        <img :src="BASE_URL+scope.row.imgUrl" style="width:100%;">
      </template>
    </el-table-column>
    <el-table-column prop="createTime" label="发布时间" align="center"></el-table-column>
    <el-table-column label="操作">
      <template #default="scope">
        <el-button type="danger" @click="del(scope.$index,scope.row)">删除</el-button>
      </template>
    </el-table-column>
  </el-table>
</template>

<script setup>
import {onMounted, ref} from "vue";
import {ElMessage} from "element-plus";
import axios from "axios";

 const del = (i,banner)=>{
   if(confirm('确认删除此轮播图吗?')){
     axios.post(BASE_URL+'/v1/banners/'+banner.id+'/delete').then((response)=>{
       if(response.data.code==2001){
         arr.value.splice(i,1);
         ElMessage.success('删除成功!');
       }
     })
   }
 }

 //发请求获取真实的轮播图数据，存入arr数组中
 const arr = ref([]);
 onMounted(()=>{
   axios.get(BASE_URL+'/v1/banners/admin').then((response)=>{
     if(response.data.code==2001){
       arr.value = response.data.data;
     }
   })
 })
</script>

<style scoped>

</style>