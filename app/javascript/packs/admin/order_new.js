import { createApp } from "vue";
import New from "../../components/admin/New.vue";
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("adminNew");
    const initialData = JSON.parse(node.getAttribute("data"));
    const app = createApp(New, { initialData: initialData })
    app.mount("#adminNew");
});