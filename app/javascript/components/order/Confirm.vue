<template>
  <div class="tab">
    <div>
      <h2>受付内容確認</h2>
    </div>
    <div>
      <h4>お客様情報</h4>
      <p>名前：{{customer.name}}</p>
      <p>メールアドレス: {{ customer.email }}</p>
      <p>電話番号: {{ customer.phonenumber }}</p>
      <p>住所: {{ customer.address }}</p>
    </div>
    <div>
      <h4>注文内容</h4>
      <ul>
        <li v-for="(item, index) in items" :key="index">
          id:{{ item.id }} {{ item.name }} - 数量: {{ item.count }} - 単価: {{ item.price }}
        </li>
      </ul>
    </div>
    <div>
      <button @click="submit" class="btn btn-outline-primary">内容を確定して仮見積を送信する</button>
    </div>
    <button @click="previous" class="btn btn-outline-primary">前へ</button>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  props: {
    customer: Object,
    items: Array
  },
  methods: {
    previous(){
      this.$emit('change-page', {step: -1}); // 1ページ戻る
    },
    submit(){
      const FormData = require('form-data');
      const form = new FormData();
      form.append('customer[name]', this.customer.name);
      form.append('customer[email]', this.customer.email);
      form.append('customer[phonenumber]', this.customer.phonenumber);
      form.append('customer[address]', this.customer.address);
      this.items.forEach((item) => {
        form.append('item[category_id]', item.id);
        form.append('item[count]', item.count);
      })
      debugger;
      axios({
        method: 'post',
        url: '/orders',
        data: form,
        headers: {'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')},
      });
      window.location.href = '/orders/complete';
    }
  }
}
</script>