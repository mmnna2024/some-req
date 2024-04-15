// Vue.js導入確認用ファイル
import { createApp } from "vue";
import App from "../app.vue";
// bootstrapをインポート
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

document.addEventListener("DOMContentLoaded", () => {
  const app = createApp(App);
  app.mount("#vue-app");
});