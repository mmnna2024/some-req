import { createApp } from "vue";
import New from "../../components/order/New.vue";

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("orderNew");
    const initialData = JSON.parse(node.getAttribute("data"));
    const app = createApp(New, { initialData: initialData })
    app.mount("#orderNew");
});