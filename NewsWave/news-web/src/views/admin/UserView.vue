<!--用户管理页-->
<template>
  <el-table :data="arr">
    <el-table-column type="index" label="编号" width="100px"></el-table-column>
    <el-table-column prop="username" label="用户名"></el-table-column>
    <el-table-column prop="nickname" label="昵称"></el-table-column>
    <el-table-column label="头像">
      <template #default="scope">
        <el-avatar :src="BASE_URL+scope.row.imgUrl"></el-avatar>
      </template>
    </el-table-column>
    <el-table-column label="管理员">
      <template #default="scope">
        <el-switch v-model="scope.row.isAdmin" @change="changeAdmin(scope.row)" :active-value="1" :inactive-value="0"></el-switch>
      </template>
    </el-table-column>
    <el-table-column prop="createTime" label="创建时间"></el-table-column>
    <el-table-column label="操作">
      <template #default="scope">
        <el-button type="danger" @click="del(scope.$index,scope.row)">删除</el-button>
      </template>
    </el-table-column>
  </el-table>

  <!-- 点击此按钮,弹出添加用户的蒙版弹窗 -->
  <el-button type="primary" @click="dialogVisible=true"
             style="width:100%;margin-top:15px;font-weight:bold;">添加用户</el-button>
  <el-dialog title="添加用户" v-model="dialogVisible" style="padding-right:60px;border-radius:10px;">
    <el-form label-width="100px">
      <el-form-item label="用户名">
        <el-input v-model="user.username" placeholder="用户名"></el-input>
      </el-form-item>
      <el-form-item label="密码">
        <el-input v-model="user.password" placeholder="密码" type="password"></el-input>
      </el-form-item>
      <el-form-item label="昵称">
        <el-input v-model="user.nickname" placeholder="昵称"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" style="width:100%;" @click="add()">添加</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>

</template>

<script setup>
import {onMounted, ref} from "vue";
import {ElMessage} from "element-plus";
import axios from "axios";
import qs from "qs";
//此变量用来控制添加用户弹窗是否出现 默认false不出现
const dialogVisible = ref(false);
const user = ref({username:'',nickname:'',password:''})
const add = ()=>{
  dialogVisible.value=false;
  let data = qs.stringify(user.value);
  axios.post(BASE_URL+'/v1/users/reg',data).then((response)=>{
    if(response.data.code==2001){
      ElMessage.success('添加成功!');
      user.value = {username:'',nickname:'',password:''};
      loadData();
    }else{
      ElMessage.error(response.data.msg);
    }
  })
}

const changeAdmin = (user)=>{
  let data = qs.stringify({id:user.id,isAdmin:user.isAdmin});
  console.log(data);
  axios.post(BASE_URL+'/v1/users/update',data).then((response)=>{
    if(response.data.code==2001){
      ElMessage.success('修改完成!');
    }
  })
}

const del = (i,user)=>{
  if(confirm('您确认要删除'+user.nickname+'吗?')){
    axios.post(BASE_URL+'/v1/users/'+user.id+'/delete').then((response)=>{
      if(response.data.code==2001){
        ElMessage.success(user.nickname+'已被删除!');
        arr.value.splice(i,1);
      }
    })
  }
}

const arr = ref([]);
const loadData = ()=>{
  axios.get(BASE_URL+'/v1/users/admin').then((response)=>{
    if(response.data.code==2001){
      arr.value = response.data.data;
    }
  })
}
//一进入页面要加载所有的表格数据 新增成功后也要加载所有的表格数据
onMounted(()=>{
    loadData();
})

</script>

<style scoped>

</style>