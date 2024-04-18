<template>
  <div>
    <p class="error-message">{{ message }}</p>
  </div>
</template>

<script>
export default {
  name: "ErrorMessage",
  props: {
    message: {
      type: String,
      default: ""
    }
  }
}
</script>

<style scoped>
.error-message {
  color: #dc3545 !important;
  font-size: 80%;
}
</style>