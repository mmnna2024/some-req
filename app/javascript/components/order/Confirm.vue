<<template>
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
      <p>年齢: {{ customer.age }}</p>
      <p>性別: {{ customer.sex }}</p>
    </div>
    <div>
      <h4>注文内容</h4>
      <ul>
        <li v-for="(item, index) in items" :key="index">
          id:{{ item.id }} {{ item.name }} - 単価: {{ item.price }}円
        </li>
        <li>
          送料: {{shipping.price}}円
        </li>
        <li>
          見積り合計金額: {{totalprice + shipping.price}}
        </li>

      </ul>
    </div>
    <div>
      <h4>事前に確認したい内容</h4>
      <p>{{order.note}}</p>
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
    order: Object,
    items: Array,
    shipping: Object,
    totalprice: {}
  },
  methods: {
    previous(){
      this.$emit('change-page', {step: -1}); // 1ページ戻る
    },
    async submit(){
      const FormData = require('form-data');
      const form = new FormData();
      form.append('order_form[customer_name]', this.customer.name);
      form.append('order_form[customer_email]', this.customer.email);
      form.append('order_form[customer_phonenumber]', this.customer.phonenumber);
      form.append('order_form[customer_address]', this.customer.address);
      if(this.customer.age !== undefined) form.append('order_form[customer_age]', this.customer.age);
      if(this.customer.sex !== undefined) form.append('order_form[customer_sex]', this.customer.sex);
      form.append('order_form[channel]', 'online');
      form.append('order_form[order_note]', this.order.note);
      form.append('order_form[status]', 'unchecked_order');
      form.append('order_form[shipping_id]', this.shipping.id);
      this.items.forEach((item) => {
        form.append('order_form[category_ids][]', item.id);
      })
      
      try {
        const res = await axios({
          method: 'post',
          url: '/orders',
          data: form,
          headers: {'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')},
        });

        // リクエストが成功したら、完了ページへリダイレクト
        window.location.href = '/orders/complete';
      } catch (error) {
        console.error('Order submission failed:', error);
      }
    }
  }
}
</script>