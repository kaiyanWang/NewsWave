import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'

//配置根路径
// const BASE_URL = 'http://39.99.43.230:8080';
const BASE_URL = 'http://localhost:8080';
//window里面的是全局内容,可以在任意script标签内部使用
window.BASE_URL = BASE_URL;

const app = createApp(App)
//在vue实例中也要添加全局内容,添加后可以在任意template标签内部使用
app.config.globalProperties.BASE_URL = BASE_URL;
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
}

app.use(ElementPlus).use(store).use(router).mount('#app')
