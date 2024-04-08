import { createApp } from 'vue';
import AddForm from '../../components/admin/AddForm.vue'; 

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('app');
  const initialData = JSON.parse(node.getAttribute('data'));
  const app = createApp(AddForm, { initialData: initialData })
    app.mount("#app");
});