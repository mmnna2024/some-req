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
    window.scrollTo(0, 0);
  }
  // Form.vue から受け取ったデータで formData を更新する処理
  if (data.formData) {
    Object.assign(formData, data.formData);
  }
}
function moveToTop() {
      const duration = 1000;  // 移動速度（1秒で終了）
      const interval = 25;    // 0.025秒ごとに移動
      const step = -window.scrollY / Math.ceil(duration / interval); // 1回に移動する距離
      const timer = setInterval(() => {
          window.scrollBy(0, step);   // スクロール位置を移動
          if(window.scrollY <= 0) {
              clearInterval(timer);
          }
      }, interval);
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
    },
    
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

.btn-outline-dark:hover {
  color: #F8C900;
}

.link-dark:hover {
  color: #F8C900;
  cursor: pointer;
}

</style>

