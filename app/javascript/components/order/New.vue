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
  items: [],
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
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-12 col-md-10 col-lg-8">
        <keep-alive>
          <component :is="Pages[currentPageIndex]" 
            :categories="initialData.categories"
            :shippings="initialData.shippings" 
            @change-page="handlePageChange" 
            @files-selected="handleFilesSelected"
            v-bind="formData" />
        </keep-alive>
      </div>
    </div>
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
  data() {
    return {
      items: []  
    };
  },
  methods: {
    handleFilesSelected({ index, files }) {
      if (!this.items[index].uploadFiles) {
        this.$set(this.items[index], 'uploadFiles', []);
      }
      this.items[index].uploadFiles = files;
    }
  }
}
</script>

<style>
.categories-table {
  border: 1px solid gray;
}

.order-table-top {
  border: 1px solid gray;
  padding: 10px;
  color: white;
  background-color: #333;
  font-weight: bold;
}

.order-table {
  border: 1px solid gray;
  padding: 10px;
}

.categories-table th,
.categories-table td {
  border: 1px solid gray;
  
}

.total-table {
  border: 5px solid gray;
  color: #ff0019;
  font-size: 20px;
}

.error-message {
  color: #dc3545 !important;
  font-size: 80%;
}

.btn-outline-dark:hover {
  color: #F8C900;
}

.link-dark:hover {
  color: #F8C900;
  cursor: pointer;
}

</style>

