<template>
  <div style="padding: 10px; margin-bottom: 50px">
    <el-row>
      <!-- 左侧在线用户列表 -->
      <el-col :span="8">
        <el-card style="width: 100%; min-height: 500px; color: #333">
          <div style="padding-bottom: 10px; border-bottom: 1px solid #ccc">
            在线用户<span style="font-size: 12px">（点击按钮开始聊天）</span>
          </div>
          <div style="padding: 10px 0" v-for="user in users" :key="user.username">
            <span>{{ user.username }}</span>
            <!-- 聊天按钮，点击触发连接并设置聊天对象 -->
            <button class="el-icon-chat-dot-round" style="margin-left: 10px; font-size: 16px; cursor: pointer"
                    @click="connectToUser(user.username)">
            </button>
            <span style="font-size: 12px;color: limegreen; margin-left: 5px" v-if="chatUser === user.username">已连接</span>
          </div>
        </el-card>
      </el-col>

      <!-- 右侧聊天主界面 -->
      <el-col :span="16">
        <div style="width: 800px; margin: 0 auto; background-color: white;
                    border-radius: 5px; box-shadow: 0 0 10px #ccc">
          <div style="text-align: center; line-height: 50px;">
            Web聊天室（{{ chatUser || '未选择聊天对象' }}）
          </div>
          <div style="height: 350px; overflow:auto; border-top: 1px solid #ccc" v-html="content"></div>
          <div style="height: 100px">
<!--            <textarea v-model="text" style="height: 20px; width: 95%; padding: 20px; border: none; border-top: 1px solid #ccc;-->
<!--             border-bottom: 1px solid #ccc; outline: none" placeholder="请输入消息...（Enter发送）" @keyup.enter="send"></textarea>-->
            <textarea
                v-model="text"
                ref="textarea"
                style="height: 20px; width: 95%; padding: 20px; border: none; border-top: 1px solid #ccc; border-bottom: 1px solid #ccc; outline: none"
                placeholder="请输入消息...（Enter发送，Ctrl+Enter换行）"
                @keydown="handleKeyDown"
            ></textarea>

            <div style="text-align: right; padding-right: 10px">
              <el-button type="primary" size="mini" @click="send" :disabled="!chatUser">发送</el-button>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { ref } from "vue";

let socket;
export default {
  name: "Im",
  data() {
    return {
      circleUrl: 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
      user: {},
      users: [],
      chatUser: '',
      text: "",
      messages: [],
      content: '',
      isConnected: false
    }
  },
  created() {
    this.initWebSocket();
  },
  methods: {
    // 初始化WebSocket连接
    initWebSocket() {
      this.user = localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {};
      const username = this.user.username;

      if (typeof WebSocket === "undefined") {
        console.log("浏览器不支持WebSocket");
        return;
      }

      const socketUrl = `${BASE_URL.replace('http', 'ws')}/imserver/${username}`;
      if (socket) {
        socket.close();
        socket = null;
      }

      socket = new WebSocket(socketUrl);
      socket.onopen = () => {
        console.log("WebSocket连接已建立");
      };

      socket.onmessage = (msg) => {
        const data = JSON.parse(msg.data);
        console.log("收到消息:", data);

        // 处理在线用户列表
        if (data.users) {
          // this.users = data.users.map(user => ({ username: user.username }));
          // 自己不能出现在列表里
          this.users = data.users.filter(user => user.username !== username)
        }
        // 处理连接请求（来自服务端推送）
        else if (data.type === "connectRequest") {
          this.chatUser = data.from;
          this.isConnected = true;
          this.$message({ type: 'success', message: `已与 ${data.from} 建立连接` });
        }
        // 处理普通聊天消息
        else if (data.from) {
          this.messages.push(data);
          this.createContent(data.from, null, data.text);
        }
      };

      socket.onclose = () => {
        console.log("WebSocket连接已关闭");
        this.isConnected = false;
      };

      socket.onerror = (error) => {
        console.error("WebSocket连接错误:", error);
      };
    },

    // 连接指定用户（触发对方连接）
    connectToUser(targetUsername) {
      if (!this.user.username) return;

      this.chatUser = targetUsername;
      this.isConnected = true;

      // 发送连接请求给服务端，由服务端触发对方连接
      const message = {
        type: "requestConnect",
        from: this.user.username,
        to: targetUsername,
        text: "您好，我是 " + this.user.username + "，希望与您开启聊天~ (以上是打招呼的内容)"
      };
      socket.send(JSON.stringify(message));
      this.$message({ type: 'success', message: `已与 ${targetUsername} 建立连接` });
    },

    send() {
      if (!this.chatUser) {
        this.$message({ type: 'warning', message: "请选择聊天对象" });
        return;
      }
      if (!this.text.trim()) {  // 增加.trim()避免发送空字符串
        this.$message({ type: 'warning', message: "请输入内容" });
        return;
      }

      const message = {
        from: this.user.username,
        to: this.chatUser,
        text: this.text
      };
      socket.send(JSON.stringify(message));
      this.messages.push({ user: this.user.username, text: this.text });
      this.createContent(null, this.user.username, this.text);
      this.text = '';
    },
    handleKeyDown(event) {
      if (event.ctrlKey && event.key === 'Enter') {
        event.preventDefault();  // 阻止默认行为
        this.insertLineBreak();
      } else if (event.key === 'Enter' && !event.shiftKey && !event.ctrlKey) {
        // 只处理普通 Enter 键（无修饰符）
        event.preventDefault();  // 阻止默认换行
        this.send();
      }
    },
    insertLineBreak() {
      // 获取当前光标位置
      const textarea = this.$refs.textarea;
      if (!textarea) return;  // 防止报错
      const start = textarea.selectionStart;
      const end = textarea.selectionEnd;

      // 拼接文本并插入换行符
      this.text = this.text.substring(0, start) + '\n' + this.text.substring(end);

      // 调整光标位置到换行符后
      textarea.selectionStart = start + 1;
      textarea.selectionEnd = start + 1;
      textarea.focus();  // 聚焦到文本框
    },

    createContent(remoteUser, nowUser, text) {
      let html;
      // 将换行符替换为 HTML 换行标签
      const formattedText = text.replace(/\n/g, '<br>');
      if (nowUser) {
        html = `
        <div class="el-row" style="padding: 5px 0">
          <div class="el-col el-col-22" style="text-align: right; padding-right: 10px">
            <div class="user-name" style="text-align: right; margin-bottom: 5px; font-weight: bold;">${nowUser}</div>
            <div class="tip left">${formattedText}</div>
          </div>
          <div class="el-col el-col-2">
            <span class="el-avatar el-avatar--circle" style="height: 40px; width: 40px; line-height: 40px;">
              <img src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png" style="object-fit: cover;">
            </span>
          </div>
        </div>
        `;
      } else if (remoteUser) {
        html = `
        <div class="el-row" style="padding: 5px 0">
          <div class="el-col el-col-2" style="text-align: right">
            <span class="el-avatar el-avatar--circle" style="height: 40px; width: 40px; line-height: 40px;">
              <img src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png" style="object-fit: cover;">
            </span>
          </div>
          <div class="el-col el-col-22" style="text-align: left; padding-left: 10px">
            <div class="user-name" style="text-align: left; margin-bottom: 5px; font-weight: bold;">${remoteUser}</div>
            <div class="tip right">${formattedText}</div>
          </div>
        </div>
        `;
      }
      this.content += html;
    }

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