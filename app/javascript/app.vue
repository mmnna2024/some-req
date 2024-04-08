<!-- Vue.js導入確認用ファイル -->
<template>
  <div>
    <p>
      {{ message }}
    </p>
    <div>
      <p>dev menu</p>
    </div>
    <div>
      <a href='/orders/new'
       class="btn btn-outline-primary" role="button">オンライン注文フォーム</a>
       <p>※画面遷移後一度更新</p>
    </div>
    <div>
      <a href='admin/orders/new'
      class="btn btn-outline-primary" role="button">店舗新規登録</a>
    </div>
    <!-- 適当に増やしてください -->
  </div>
</template>

<script>
export default {
  data() {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: left;
}
</style>