<template>
  <div class="tab">
    注意事項確認画面
    <div class="form-group">
      <label for="order-note">事前に確認したい内容を記載してください。</label>
      <input v-model="order.note" id="order-note" class="form-control">
    </div>
    <div>
      <button @click="next" class="btn btn-outline-primary">次へ</button>
      <button @click="previous" class="btn btn-outline-primary">前へ</button>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    order: {
      type: Object,
      default: () => {}
    }
  },
  data() {
    return {
      order: {}
    }
  },
  methods: {
    next() {
      this.$emit('change-page', {
        step: 1, // 1ページ進む
        formData: {
          order: this.order
        }
      });
    },
    previous(){
      this.$emit('change-page', {step: -1}); // 1ページ戻る
    }
  }
}
</script>