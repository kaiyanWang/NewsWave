<template>
  <div style="padding: 10px; margin-bottom: 50px">
    <el-row>
      <!-- 左侧在线用户列表 -->
      <el-col :span="8">
        <el-card style="width: 100%; min-height: 500px; color: #333">
          <div style="padding-bottom: 10px; border-bottom: 1px solid #ccc">在线用户<span style="font-size: 12px">（点击聊天气泡开始聊天）</span></div>
          <!-- 在线用户循环显示 -->
          <div style="padding: 10px 0" v-for="user in users" :key="user.username">
            <span>{{ user.username }}</span>
            <!-- 改为按钮-->
            <!-- 聊天按钮，点击设置当前聊天对象 -->
            <button class="el-icon-chat-dot-round" style="margin-left: 10px; font-size: 16px; cursor: pointer"
               @click="chatUser = user.username"></button>
            <!-- 显示当前聊天状态 -->
            <span style="font-size: 12px;color: limegreen; margin-left: 5px" v-if="user.username === chatUser">chatting...</span>
          </div>
        </el-card>
      </el-col>

      <!-- 右侧聊天主界面 -->
      <el-col :span="16">

        <div style="width: 800px; margin: 0 auto; background-color: white;
                    border-radius: 5px; box-shadow: 0 0 10px #ccc">
          <!-- 聊天标题，显示当前聊天对象 -->
          <div style="text-align: center; line-height: 50px;">
            Web聊天室（{{ chatUser || '未选择聊天对象'}}）
          </div>

          <!-- 消息显示区域，使用v-html渲染HTML内容 -->
          <div style="height: 350px; overflow:auto; border-top: 1px solid #ccc" v-html="content"></div>
          <div style="height: 100px">
            <textarea v-model="text" style="height: 20px; width: 95%; padding: 20px; border: none; border-top: 1px solid #ccc;
             border-bottom: 1px solid #ccc; outline: none" placeholder="请输入消息..."></textarea>
            <div style="text-align: right; padding-right: 10px">
              <el-button type="primary" size="mini" @click="send">发送</el-button>
            </div>
          </div>

        </div>
      </el-col>

    </el-row>
  </div>
</template>

<script>

import {ref} from "vue";

let socket;
export default {
  name: "Im",
  data() {
    return {
      circleUrl: 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
      user: {},
      isCollapse: false,
      users: [],
      chatUser: '',
      text: "",
      messages: [],
      content: ''
    }
  },
  created() {
    this.init()
  },
  methods: {
    send() {
      if (!this.chatUser) {
        this.$message({type: 'warning', message: "请选择聊天对象"})
        return;
      }
      if (!this.text) {
        this.$message({type: 'warning', message: "请输入内容"})
      } else {
        if (typeof (WebSocket) == "undefined") {
          console.log("您的浏览器不支持WebSocket");
        } else {
          console.log("您的浏览器支持WebSocket");
          // 组装待发送的消息 json
          // {"from": "zhang", "to": "admin", "text": "聊天文本"}
          let message = {from: this.user.username, to: this.chatUser, text: this.text}
          socket.send(JSON.stringify(message));  // 将组装好的json发送给服务端，由服务端进行转发
          this.messages.push({user: this.user.username, text: this.text})
          // 构建消息内容，本人消息
          this.createContent(null, this.user.username, this.text)
          this.text = '';
        }
      }
    },

    // 真实姓名交流
    createContent(remoteUser, nowUser, text) {
      let html;
      // 当前用户消息（绿色气泡）
      if (nowUser) {
        html = `
    <div class="el-row" style="padding: 5px 0">
      <div class="el-col el-col-22" style="text-align: right; padding-right: 10px">
        <div class="user-name" style="text-align: right; margin-bottom: 5px; font-weight: bold;">${nowUser}</div>
        <div class="tip left">${text}</div>
      </div>
      <div class="el-col el-col-2">
        <span class="el-avatar el-avatar--circle" style="height: 40px; width: 40px; line-height: 40px;">
          <img src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png" style="object-fit: cover;">
        </span>
      </div>
    </div>
    `;
      } else if (remoteUser) {   // 远程用户消息（蓝色气泡）
        html = `
    <div class="el-row" style="padding: 5px 0">
      <div class="el-col el-col-2" style="text-align: right">
        <span class="el-avatar el-avatar--circle" style="height: 40px; width: 40px; line-height: 40px;">
          <img src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png" style="object-fit: cover;">
        </span>
      </div>
      <div class="el-col el-col-22" style="text-align: left; padding-left: 10px">
        <div class="user-name" style="text-align: left; margin-bottom: 5px; font-weight: bold;">${remoteUser}</div>
        <div class="tip right">${text}</div>
      </div>
    </div>
    `;
      }
      this.content += html;
    },

    // // 昵称和头像（未实现）
    // createContent(remoteUser, nowUser, text) {
    //   let html;
    //   // 当前用户消息（绿色气泡）
    //   if (nowUser) {
    //     // 从user对象中获取昵称
    //     const nickname = this.user.nickname || nowUser;
    //     html = `
    // <div class="el-row" style="padding: 5px 0">
    //   <div class="el-col el-col-22" style="text-align: right; padding-right: 10px">
    //     <div class="user-name" style="text-align: right; margin-bottom: 5px; font-weight: bold;">${nickname}</div>
    //     <div class="tip left">${text}</div>
    //   </div>
    //   <div class="el-col el-col-2">
    //     <span class="el-avatar el-avatar--circle" style="height: 40px; width: 40px; line-height: 40px;">
    //       <img :src="this.user.imgUrl || 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'" style="object-fit: cover;">
    //     </span>
    //   </div>
    // </div>
    // `;
    //   } else if (remoteUser) {   // 远程用户消息（蓝色气泡）
    //     // 假设remoteUser是用户对象，包含nickname和imgUrl
    //     html = `
    // <div class="el-row" style="padding: 5px 0">
    //   <div class="el-col el-col-2" style="text-align: right">
    //     <span class="el-avatar el-avatar--circle" style="height: 40px; width: 40px; line-height: 40px;">
    //       <img :src="remoteUser.imgUrl || 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'" style="object-fit: cover;">
    //     </span>
    //   </div>
    //   <div class="el-col el-col-22" style="text-align: left; padding-left: 10px">
    //     <div class="user-name" style="text-align: left; margin-bottom: 5px; font-weight: bold;">${remoteUser.nickname || remoteUser.username}</div>
    //     <div class="tip right">${text}</div>
    //   </div>
    // </div>
    // `;
    //   }
    //   this.content += html;
    // },

    // 真实姓名
    init() {
      this.user = localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
      let username = this.user.username;
      let _this = this;
      if (typeof (WebSocket) == "undefined") {
        console.log("您的浏览器不支持WebSocket");
      } else {
        console.log("您的浏览器支持WebSocket");
        // 后端ip:端口
        // let socketUrl = "ws://localhost:8081/imserver/" + username;
        const socketUrl = `${BASE_URL.replace('http', 'ws')}/imserver/${username}`;
        if (socket != null) {
          socket.close();
          socket = null;
        }
        // 开启一个websocket服务
        socket = new WebSocket(socketUrl);
        //打开事件
        socket.onopen = function () {
          console.log("websocket已打开");
        };
        //  浏览器端收消息，获得从服务端发送过来的文本消息
        socket.onmessage = function (msg) {
          console.log("收到数据====" + msg.data)
          let data = JSON.parse(msg.data)  // 对收到的json数据进行解析， 类似这样的： {"users": [{"username": "zhang"},{ "username": "admin"}]}
          if (data.users) {  // 获取在线人员信息
            _this.users = data.users.filter(user => user.username !== username)  // 获取当前连接的所有用户信息，并且排除自身，自己不会出现在自己的聊天列表里
          } else {
            // 如果服务器端发送过来的json数据 不包含 users 这个key，那么发送过来的就是聊天文本json数据
            //  // {"from": "zhang", "text": "hello"}
            if (data.from === _this.chatUser) {
              _this.messages.push(data)
              // 构建消息内容
              _this.createContent(data.from, null, data.text)
            }
          }
        };
        //关闭事件
        socket.onclose = function () {
          console.log("websocket已关闭");
        };
        //发生了错误事件
        socket.onerror = function () {
          console.log("websocket发生了错误");
        }
      }
    }

    // // 昵称和头像（未实现）
    // init() {
    //   this.user = localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    //
    //   let username = this.user.username;
    //   let _this = this;
    //   if (typeof (WebSocket) == "undefined111") {
    //     console.log("您的浏览器不支持WebSocket");
    //   } else {
    //     console.log("您的浏览器支持WebSocket");
    //     let socketUrl = "ws://localhost:8081/imserver/" + username;
    //     if (socket != null) {
    //       socket.close();
    //       socket = null;
    //     }
    //     socket = new WebSocket(socketUrl);
    //     socket.onopen = function () {
    //       console.log("websocket已打开");
    //     };
    //     socket.onmessage = function (msg) {
    //       console.log("收到数据====" + msg.data)
    //       let data = JSON.parse(msg.data)
    //       if (data.users) {
    //         // 假设服务器返回的用户数据包含nickname和imgUrl
    //         _this.users = data.users.filter(user => user.username !== username)
    //       } else {
    //         if (data.from === _this.chatUser) {
    //           _this.messages.push(data)
    //           // 假设data中包含发送者的用户信息
    //           const senderInfo = _this.users.find(user => user.username === data.from) || {
    //             nickname: '默认名',
    //             imgUrl: ''
    //           };
    //           _this.createContent(senderInfo, null, data.text)
    //         }
    //       }
    //     };
    //     //关闭事件
    //     socket.onclose = function () {
    //       console.log("websocket已关闭");
    //     };
    //     //发生了错误事件
    //     socket.onerror = function () {
    //       console.log("websocket发生了错误");
    //     }
    //   }
    // }

  }
}
</script>
<style>
.tip {
  color: white;
  text-align: center;
  border-radius: 10px;
  font-family: sans-serif;
  padding: 10px;
  width:auto;
  display:inline-block !important;
  display:inline;
}
.right {
  background-color: deepskyblue;
}
.left {
  background-color: forestgreen;
}

.user-name {
  font-size: 14px;
  color: #555;
}
.tip {
  color: white;
  text-align: center;
  border-radius: 10px;
  font-family: sans-serif;
  padding: 10px;
  width: auto;
  display: inline-block !important;
  display: inline;
}
</style>