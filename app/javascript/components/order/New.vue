<script setup>
import Form from './Form.vue'
import Important from './Important.vue'
import Confirm from './Confirm.vue'
import { ref, reactive } from 'vue'

const currentPageIndex = ref(0)
const Pages = [Form, Important, Confirm]
const formData = reactive({
  customer: {
    name: '',
    email: '',
    phonenumber: '',
    address: '',
    sex: '',
    age: null,
  },
  order: {
    note: ''
  },
  items: {},
  shipping: {},
  totalprice: {}
});

function handlePageChange(data) {
  // ページを進める処理
  const newIndex = currentPageIndex.value + data.step;
  if (newIndex >= 0 && newIndex < Pages.length) {
    currentPageIndex.value = newIndex;
  }
  // Form.vue から受け取ったデータで formData を更新する処理
  if (data.formData) {
    Object.assign(formData, data.formData);
  }
}
</script>

<template>
  <div class="mx-auto" style="width: 800px;">
    <keep-alive>
      <component :is="Pages[currentPageIndex]" 
        :categories="initialData.categories"
        :shippings="initialData.shippings" 
        @change-page="handlePageChange" 
        v-bind="formData" />
    </keep-alive>
  </div>
</template>

<script>
export default {
  components: {
    Form,
    Important,
    Confirm
  },
  props: {
    initialData: {
      type: Object,
      default: () => {}
    }
  },
}
</script>

<style scoped>
.categories-table {
  border: 1px solid gray;
  margin: 10px;
}

.categories-table th,
.categories-table td {
  border: 1px solid gray;
}
</style>

