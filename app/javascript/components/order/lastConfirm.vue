<template>
  入力内容確認

  <div>
    <p>お名前: {{ customer.name }}</p>
    <p>メールアドレス: {{ customer.email }}</p>
    <p>住所: {{ customer.address }}</p>
    <p>電話番号: {{ customer.phone }}</p>
  </div>

  <div>
    <div v-for="(item, index) in selected" :key="index">
      <p>{{ item.name }}</p>
      <p>{{ item.count }}</p>
      <p>{{ item.price }}</p>
    </div>
  </div>

  <button @click="order">注文を確定する</button>
</template>

<script>
export default {
  name: 'LastConfirm',
  props: {
    selected: {
      type: Array,
      default: () => []
    },
    customer: {
      type: Object,
      default: () => {}
    }
  },
  methods: {
    order() {
      window.location.href = '/orders/thanks'
    }
  }
}
</script>