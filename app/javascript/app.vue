<!-- Vue.js導入確認用ファイル -->
<template>
  <p>
    {{ message }}
  </p>
  <!-- エラーが出るのでコメントアウト -->
  <!-- <button class="btn btn-primary">bootstrap</button> -->
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