<template>
  <div class="tab">
    注意事項確認画面
    <button @click="next" class="btn btn-outline-primary">次へ</button>
    <button @click="previous" class="btn btn-outline-primary">前へ</button>
  </div>
</template>

<script>
export default {
  // props, data, methods, etc.
  methods: {
    next() {
      this.$emit('change-page', {step: 1}); // 1ページ進む
    },
    previous(){
      this.$emit('change-page', {step: -1}); // 1ページ戻る
    }
  }
}
</script>