<script setup>
import Form from './Form.vue'
import Important from './Important.vue'
import Confirm from './Confirm.vue'
import { ref } from 'vue'



const currentPageIndex = ref(0)

const Pages = [
  Form,
  Important,
  Confirm
]

function nextPage() {
  if (currentPageIndex.value < Pages.length - 1) {
    currentPageIndex.value = (currentPageIndex.value + 1) % Pages.length
  }
}

function previousPage() {
  if (currentPageIndex.value > 0) {
    currentPageIndex.value = (currentPageIndex.value - 1) % Pages.length
  }
}


</script>

<template>
  <div class="mx-auto" style="width: 800px;">
    <keep-alive>
      <component :is="Pages[currentPageIndex]" class="tab-Page" v-bind:categories="initialData.categories"></component>
    </keep-alive>
    <button type="button" class="btn btn-outline-primary" @click="nextPage" v-if="currentPageIndex < Pages.length - 1">
      つぎへ
    </button>
    <button type="button" class="btn btn-outline-primary" @click="previousPage" v-if="currentPageIndex > 0">
      もどる
    </button>
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

