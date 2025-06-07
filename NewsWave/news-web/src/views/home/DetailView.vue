<!--详情页-->
<template>
  <el-row :gutter="10" style="width: 1200px;margin: 0 auto;">
   <!-- 详情页左侧部分 -->
   <el-col :span="18">
     <el-card>
       <h1 style="color:orange;text-align: center;">{{content.title}}</h1>
       <p style="font-size:12px;color:#666;text-align: center;">作者: {{content.nickname}} | 发布时间: {{content.createTime}}
         | 阅读次数: {{content.viewCount}} </p>
       <hr>
       <div v-if="content.type!=2">
         <el-card>
           <span style="color:#0aa1ed;font-weight:bold;">摘要: </span>
           {{content.brief}}
         </el-card>
         <div v-html="content.content"></div>
       </div>
       <div v-else>
         <video :src="'http://localhost:8080'+content.videoUrl"
                controls type="video/mp4" style="width:100%;"></video>
       </div>
     </el-card>


     <!--评论相关内容-->
     <el-card style="margin-top:10px;">
       <p>发一条友善的评论</p>
       <hr>
       <el-row :gutter="10">
        <el-col :span="22">
          <el-input placeholder="想不想说点啥..." v-model="comment.content" @keydown.enter="post()"></el-input>
        </el-col>
        <el-col :span="2">
          <el-button @click="post()">发布</el-button>
        </el-col>
       </el-row>
       <el-row :gutter="10" v-for="item in commentArr" style="margin:10px;">
        <el-col :span="2">
          <el-avatar style="margin:10px;"><img :src="'http://localhost:8080'+item.userImgUrl"></el-avatar>
        </el-col>
        <el-col :span="22">
          <p style="color:orange;font-weight:bold;margin:0;font-size:15px;">{{ item.nickname }}</p>
          <p style="font-size:13px;margin:2px 0;">{{ item.content }}</p>
          <p style="font-size:12px;margin:0;color:#666;">{{ item.createTime }}</p>
        </el-col>
       </el-row>
     </el-card>
   </el-col>
   <!-- 详情页右侧部分 -->
   <el-col :span="6">
     <el-card>
       <div id="head-div"></div>
       <div style="text-align:center;position:relative;bottom:45px;">
          <el-avatar :size="90" :src="'http://localhost:8080'+content.userImgUrl" style="border:5px solid #fff;"></el-avatar>
          <p style="font-size:20px;font-weight:bold;margin:5px 0;">{{content.nickname}}</p>
         <el-icon class="head-icon"><Edit/></el-icon><span>本文作者</span>
         <br>
         <el-icon class="head-icon"><Clock/></el-icon><span>{{content.createTime}}</span>
       </div>
     </el-card>
     <el-card style="margin-top:10px;">
       <h2>热门文章</h2>
       <hr>
       <el-row :gutter="10" v-for="item in hotArr">
        <el-col :span="10">
          <router-link :to="'/detail?id='+item.id">
          <img :src="'http://localhost:8080'+item.imgUrl" style="width:100%;">
          </router-link>
        </el-col>
        <el-col :span="14">
          <router-link :to="'/detail?id='+item.id">
          <p class="title_p">{{ item.title }}</p>
          </router-link>
          <p style="margin:0;color:#666;font-size:12px;">{{item.createTime}}</p>
        </el-col>
       </el-row>
     </el-card>
     <el-card style="margin-top:10px;">
       <h2>作者其它文章</h2>
       <hr>
       <el-row :gutter="10" v-for="item in otherArr">
         <el-col :span="10">
           <router-link :to="'/detail?id='+item.id">
           <img :src="'http://localhost:8080'+item.imgUrl" style="width:100%;">
           </router-link>
         </el-col>
         <el-col :span="14">
           <router-link :to="'/detail?id='+item.id">
           <p class="title_p">{{ item.title }}</p>
           </router-link>
           <p style="margin:0;color:#666;font-size:12px;">{{item.createTime}}</p>
         </el-col>
       </el-row>
     </el-card>
   </el-col>
  </el-row>
</template>

<script setup>

import {onBeforeUpdate, onMounted, ref} from "vue";
import axios from "axios";
import {ElMessage} from "element-plus";
import qs from "qs";

const content = ref({});
const otherArr = ref([]);
const hotArr = ref([]);
const comment = ref({content:'',userId:'',contentId:''});
const commentArr = ref([]);

//定义一个加载评论的方法 参数是当前文章的id
const loadComments = (id)=>{
  axios.get('http://localhost:8080/v1/comments/'+id).then((response)=>{
    if(response.data.code==2001){
      commentArr.value = response.data.data;
    }
  })
}

const post = ()=>{
  let user = localStorage.user?JSON.parse(localStorage.user):null;
  if(user==null){
    alert('请先登录!');
    return;
  }
  if(comment.value.content==''){
    ElMessage.error('评论内容不允许为空!');
    return;
  }
  comment.value.userId = user.id; //作者
  comment.value.contentId = content.value.id; //文章id
  let data = qs.stringify(comment.value);
  axios.post('http://localhost:8080/v1/comments/add-new',data)
      .then((response)=>{
        if(response.data.code==2001){
          ElMessage.success('评论成功!');
          //评论成功后需要加载评论
          loadComments(content.value.id);
          //每次评论发布成功后,清空输入框
          comment.value.content='';
        }
      })
}

//将请求数据的内容封装到本函数中,需要初始化详情页数据时调用
const initData = ()=>{
  let id = new URLSearchParams(location.search).get('id');
  //一进到当前页面就需要加载评论
  loadComments(id);
  axios.get('http://localhost:8080/v1/contents/'+id+'/detail')
      .then((response)=>{
        if(response.data.code==2001){
          content.value = response.data.data;
          //一定要在获取内容详情后再获取作者的其它文章,因为这里有用户id了
          axios.get('http://localhost:8080/v1/contents/'+content.value.userId+'/other')
              .then((response)=>{
                if(response.data.code==2001){
                  otherArr.value = response.data.data;
                }
              })
        }
      })

  //请求热门文章
  axios.get('http://localhost:8080/v1/contents/hot').then((response)=>{
    if(response.data.code==2001){
      hotArr.value=response.data.data;
    }
  })
}

//onMounted跳转过来当前页面后,立即执行  A页面-->B页面
onMounted(()=>{
  initData();
})
//与onMounted相反, A页面-->A页面 执行
onBeforeUpdate(()=>{
  initData();
})

</script>

<style scoped>
.title_p {
  height: 40px;
  margin-top: 0;
  /*设置文章标题 最多显示2行 超出的部分替换成省略号 以下代码是组合代码 缺一不可*/
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp:2; /*设置显示的行数*/
  -webkit-box-orient: vertical; /*纵向排列*/
  color: orange;
}
a {
  color: #333;
  text-decoration: none; /*去掉超链接的下划线*/
}
a:hover{ /*悬停在标题时*/
  font-weight: bold; /*文字加粗*/
  color: orange;
}



#head-div {
  height: 90px;
  background-image: url("/public/imgs/avarbg.jpg");
}
.head-icon {
  color: orange;
  font-weight: bold;
  position: relative;
  top:3px;
  right:5px;
}
</style>