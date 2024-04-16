import { createApp } from "vue";
import New from "../../components/admin/New.vue";

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("adminNew");
    const initialData = JSON.parse(node.getAttribute("data"));
    const app = createApp(New, { initialData: initialData })
    app.mount("#adminNew");
});