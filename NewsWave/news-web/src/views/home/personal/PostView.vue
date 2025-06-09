<!--稿件发布页-->
<template>
  <h1 style="color:orange;">{{content.id==null?'发布内容页面':'修改内容页面'}}</h1>
  <el-form label-width="100px">
    <el-form-item label="文章标题">
      <el-input placeholder="请输入文章标题" v-model="content.title"></el-input>
    </el-form-item>
    <el-form-item label="文章类型">
      <el-radio-group :disabled="content.id!=null" v-model="content.type" @change="typeChange()">
<!--        <el-radio-button label="1">热点</el-radio-button>-->
<!--        <el-radio-button label="2">科技</el-radio-button>-->
<!--        <el-radio-button label="3">历史</el-radio-button>-->
        <el-radio-button v-for="c in catTypeArr" :label="c.type">{{c.name}}</el-radio-button>
      </el-radio-group>
    </el-form-item>
    <el-form-item label="二级分类">
      <el-select v-model="content.categoryId" placeholder="请选择">
<!--        <el-option label="面包" value="1"></el-option>-->
<!--        <el-option label="小食" value="2"></el-option>-->
        <el-option v-for="c in categoryArr" :label="c.name" :value="c.id"></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="封面">
      <!--&&fileList.length==0为了确保封面图片只有一张 -->
      <img :src="BASE_URL+content.imgUrl"
           v-if="content.id!=null&&fileList.length==0"
           style="width: 145px;height: 145px;margin-right:10px;">
      <!--封面上传开始-->
      <el-upload
          v-model:file-list="fileList"
          :action="BASE_URL + '/v1/upload'"
          name="file"
          limit="1"
          list-type="picture-card"
          :on-preview="handlePictureCardPreview"
          :on-remove="handleRemove"
      >
        <el-icon><Plus /></el-icon>
      </el-upload>

      <el-dialog v-model="dialogVisible">
        <img w-full :src="dialogImageUrl" alt="Preview Image" />
      </el-dialog>
      <!--封面上传结束-->
    </el-form-item>
    <!--视频上传开始-->
    <el-form-item label="视频" v-show="content.type==2">
      <video :src="BASE_URL + content.videoUrl"
      v-if="content.id!=null&&videoList.length==0"
      style="width:300px;margin-right:10px;"
      type="video/mp4" controls></video>

      <el-upload
          v-model:file-list="videoList"
          :action="BASE_URL + '/v1/upload'"
          name="file"
          limit="1"
          accept="video/*"
          :on-preview="handlePictureCardPreview"
          :on-remove="handleRemove"
      >
        <el-button type="warning">点击上传视频</el-button>
        <div> (只能上传不超过100M的mp4文件) </div>
      </el-upload>

      <el-dialog v-model="dialogVisible">
        <img w-full :src="dialogImageUrl" alt="Preview Image" />
      </el-dialog>
    </el-form-item>
    <!--视频上传结束-->
    <el-form-item label="文章内容" v-show="content.type!=2">
      <div ref="editorDiv"></div>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="post()">{{content.id==null?'发布内容':'修改内容'}}</el-button>
    </el-form-item>
  </el-form>
</template>

<script setup>
import {onMounted, ref} from 'vue'
import { Plus } from '@element-plus/icons-vue'
//1.安装富文本编辑器 npm install wangeditor
//2.富文本编辑器需要引入
import Editor from 'wangeditor';
import axios from "axios";
import {ElMessage} from "element-plus";
import qs from "qs";
import router from "@/router";

const catTypeArr = ref([]);
const categoryArr = ref([]);
//定义变量保存文章的标题与类型 类型1表示默认是烘焙食谱类型
const content = ref({title:'',type:'1',categoryId:''});

//当选择的文章类型发生改变时,触发此函数
const typeChange = ()=>{
  //加这个是为了防止切换一级标题时,把原来一级标题下的二级分类带过去
  content.value.categoryId='';
  //请求获取二级分类数据
  axios.get(BASE_URL+'/v1/categories/'+content.value.type+'/sub')
      .then((response)=>{
        if(response.data.code==2001){
          categoryArr.value = response.data.data;
        }
      })
}

onMounted(()=>{
  //location中包含了当前url的信息
  if(location.search.includes('id')){//修改
    let id = new URLSearchParams(location.search).get('id');
    axios.get(BASE_URL+'/v1/contents/'+id+'/update')
    .then((response)=>{
      if(response.data.code==2001){
        console.log(response.data.data);
        content.value = response.data.data;
        //让富文本编辑器显示文章内容
        editor.txt.html(content.value.content);
        //二级分类无法正常回显
        //原因:当type为1时,没有其它一级分类下的二级分类数据
        //解决:重新请求content对象中对应type的二级分类\
        //请求获取二级分类数据
        axios.get(BASE_URL+'/v1/categories/'+content.value.type+'/sub')
            .then((response)=>{
              if(response.data.code==2001){
                categoryArr.value = response.data.data;
              }
            })
      }
    })
  }

  //请求获取二级分类数据
  axios.get(BASE_URL+'/v1/categories/1/sub')
  .then((response)=>{
    if(response.data.code==2001){
      categoryArr.value = response.data.data;
    }
  })

  //请求获取一级分类数据
  axios.get(BASE_URL+'/v1/categories/type')
  .then((response)=>{
    if(response.data.code==2001){
      catTypeArr.value = response.data.data;
    }
  })
})



//3.创建响应式变量代表页面中装富文本编辑器的空div
const editorDiv = ref(null);

let editor = null;
//页面初始化完成立即执行的方法
onMounted(()=>{
  //初始化富文本编辑器,需要装到上面的div里
  editor = new Editor(editorDiv.value);
  //配置富文本编辑器里的占位文本
  editor.config.placeholder="请输入文章内容详情...";
  //根据上面的配置信息创建富文本编辑器
  editor.create();
})


const fileList = ref([])

const dialogImageUrl = ref('')
const dialogVisible = ref(false)

//完成删除封面图片的方法
const handleRemove = (uploadFile) => {
  let imgUrl = uploadFile.response.data;
  axios.post(BASE_URL+'/v1/remove?imgUrl='+imgUrl)
  .then((response)=>{
    if(response.data.code==2001){
      ElMessage.success('已成功删除封面！');
    }
  })
}

const handlePictureCardPreview = (uploadFile) => {
  dialogImageUrl.value = uploadFile.url
  dialogVisible.value = true
}

//定义视频数组
const videoList = ref([]);
//完成发布功能
const post = ()=>{
  //发布前必须登录!
  let user = localStorage.user?JSON.parse(localStorage.user):null;
  if(user==null){
    ElMessage.error('请先登录!');
    router.push('/login');
    return;
  }
  //将用户id存入content对象中
  content.value.userId = user.id;
  //发文章之前给必要内容做非空校验
  if(content.value.title.trim()==''){ElMessage.error('请输入标题!');return;}
  if(content.value.categoryId==''){ElMessage.error('请选择二级分类!');return;}
  //判断是发布还是修改 发布必须选封面 修改可以使用旧封面
  if(content.value.id==null){//新发布
    if(fileList.value.length==0){ElMessage.error('请选择封面图片!');return;}
    //获取用户上传的封面图片路径,存入content JS对象的imgUrl属性中
    let imgUrl = fileList.value[0].response.data;
    content.value.imgUrl = imgUrl;
  }else{//修改内容
    if(fileList.value.length>0){
      let imgUrl = fileList.value[0].response.data;
      content.value.imgUrl = imgUrl;
    }
  }

  //要判断是文章还是视频
  if(content.value.type==2){//视频
    if(content.value.id==null){//发布
      if(videoList.value.length==0){ElMessage.error('请先选择视频文件!');return;}
      let videoUrl = videoList.value[0].response.data;
      content.value.videoUrl = videoUrl;
    }else{//修改
      if(videoList.value.length>0){
        let videoUrl = videoList.value[0].response.data;
        content.value.videoUrl = videoUrl;
      }
    }
  }else{//文章
    //设置文章内容,带格式.html()
    content.value.content = editor.txt.html();
    //设置文章摘要,不带格式.text() 截取前30个字.slice(0,30)
    content.value.brief = editor.txt.text().slice(0,30);
    console.log(content.value);
  }
  //给后端发请求
  let data = qs.stringify(content.value);
  axios.post(BASE_URL+'/v1/contents/add-new',data)
  .then((response)=>{
    if(response.data.code==2001){
      ElMessage.success(content.value.id==null?'发布成功!':'修改成功!');
      //发布成功后要判断来源,如果有来源，且来源为后台管理页
      if(localStorage.from!=null&&localStorage.from=='admin'){
        router.push('/admin/content');//回到后台内容管理页
        localStorage.from=null;
      }else{
        //回到个人稿件管理页
        router.push('/personal/management');
      }
    }
  })
}
</script>

<style scoped>

</style>