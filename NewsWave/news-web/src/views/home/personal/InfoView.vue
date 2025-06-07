<!--个人信息页-->
<template>
  <el-form label-width="100px" style="width:500px;">
    <el-form-item label="头像">
      <!--头像上传开始-->
      <!--action设置上传地址 limit="1"限制上传数量为1
      name="file"设置上传参数名称,后端服务器需要使用相同的名称-->
      <el-upload
          v-model:file-list="fileList"
          action="http://localhost:8080/v1/upload"
          limit="1"
          name="file"
          list-type="picture-card"
          :on-preview="handlePictureCardPreview"
          :on-remove="handleRemove"
      >
        <el-icon><Plus /></el-icon>
      </el-upload>

      <el-dialog v-model="dialogVisible">
        <img w-full :src="dialogImageUrl" alt="Preview Image" />
      </el-dialog>
      <!--头像上传结束-->
    </el-form-item>
    <el-form-item label="昵称">
      <el-input placeholder="请输入昵称" v-model="user.nickname"></el-input>
    </el-form-item>
    <el-form-item label="用户名">
      <!--注意:这里的用户名输入框是禁用的,不允许用户输入,所以只需要属性绑定,不用双向绑定-->
      <el-input :value="user.username" disabled></el-input>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="save()">保存修改</el-button>
    </el-form-item>
  </el-form>
</template>

<script setup>
import { ref } from 'vue'
import { Plus } from '@element-plus/icons-vue'
import axios from "axios";
import {ElMessage} from "element-plus";
import qs from "qs";

const user = ref(localStorage.user?JSON.parse(localStorage.user):null);
const save = ()=>{
  let newUser = {id:user.value.id,nickname:user.value.nickname};
  //处理头像上传
  if(fileList.value.length>0){
    //得到图片路径
    let url = fileList.value[0].response.data;
    console.log(url);
    //得到的图片路径装到newUser中给后端,数据库中的数据要更新
    newUser.imgUrl = url;
    //还要把图片路径放到user响应式对象中,一会localStorage数据也要更新
    user.value.imgUrl = url;
  }

  let data = qs.stringify(newUser);
  axios.post('http://localhost:8080/v1/users/update',data)
    .then((response)=>{
      if(response.data.code==2001){
        ElMessage.success('修改成功!');
        //注意:修改完成后也要更新localStorage中的用户数据
        localStorage.user = JSON.stringify(user.value);
        location.reload();//重新加载本页面
      }
  })
}

const fileList = ref([])

const dialogImageUrl = ref('')
const dialogVisible = ref(false)

const handleRemove = (uploadFile, uploadFiles) => {
  console.log(uploadFile, uploadFiles)
}

const handlePictureCardPreview = (uploadFile) => {
  dialogImageUrl.value = uploadFile.url
  dialogVisible.value = true
}
</script>

<style scoped>

</style>