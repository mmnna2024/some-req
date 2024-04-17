import { createApp } from "vue";
import New from "../../components/order/New.vue";
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("orderNew");
    const initialData = JSON.parse(node.getAttribute("data"));
    const app = createApp(New, { initialData })
    app.mount("#orderNew");
});