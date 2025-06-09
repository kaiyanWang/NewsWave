<!--轮播图管理页面-->
<template>
  <div>
    <!-- 添加轮播图表单 todo-->
    <!-- 添加轮播图表单 -->
    <el-form label-width="100px">
      <el-form-item label="轮播图">
        <el-upload
            :action="BASE_URL + '/v1/upload'"
            :on-success="handleUploadSuccess"
            :show-file-list="false"
            name="file"
        >
          <el-button type="primary">选择图片</el-button>
        </el-upload>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="addBanner">添加轮播图</el-button>
      </el-form-item>
    </el-form>

    <el-table :data="arr">
      <el-table-column type="index" label="编号" width="120px" align="center"></el-table-column>
      <el-table-column label="轮播图" width="450" align="center">
        <template #default="scope">
          <img :src="BASE_URL + scope.row.imgUrl" style="width:100%;">
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="发布时间" align="center"></el-table-column>
      <el-table-column label="操作">
        <template #default="scope">
          <el-button type="danger" @click="del(scope.$index, scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script setup>
import {onMounted, ref} from "vue";
import {ElMessage} from "element-plus";
import axios from "axios";

// 添加轮播图todo
const imgUrl = ref("");

const handleUploadSuccess = (response) => {
  if (response.code === 2001) {
    imgUrl.value = response.data;
    ElMessage.success("图片上传成功");
  } else {
    ElMessage.error("图片上传失败");
  }
};

const addBanner = () => {
  if (!imgUrl.value) {
    ElMessage.error("请先上传图片");
    return;
  }
  axios.post(BASE_URL + "/v1/banners/add", { imgUrl: imgUrl.value }).then((response) => {
    if (response.data.code === 2001) {
      ElMessage.success("轮播图添加成功");
      // 重新加载轮播图数据
      onMounted(() => {
        axios.get(BASE_URL + "/v1/banners/admin").then((response) => {
          if (response.data.code === 2001) {
            arr.value = response.data.data;
          }
        });
      });
    } else {
      ElMessage.error("轮播图添加失败");
    }
  });
};

 const del = (i,banner)=>{
   if(confirm('确认删除此轮播图吗?')){
     axios.post(BASE_URL+'/v1/banners/'+banner.id+'/delete').then((response)=>{
       if(response.data.code==2001){
         arr.value.splice(i,1);
         ElMessage.success('删除成功!');
       }
     })
   }
 };

 //发请求获取真实的轮播图数据，存入arr数组中
 const arr = ref([]);
 onMounted(()=>{
   axios.get(BASE_URL+'/v1/banners/admin').then((response)=>{
     if(response.data.code==2001){
       arr.value = response.data.data;
     }
   });
 });
</script>

<style scoped>

</style>