<template>
  <div class="form-container container">
  <b-row>
    <b-col :span="12">
      <div>
        <h4>ご依頼内容</h4>
        <table class="categories-table">
          <tr>
            <th>衣類選択</th>
            <th>衣類タグ、全体写真アップロード</th>
            <th>単価</th>
          </tr>
          <tr v-for="(v, v_index) in selected.length" :key="`selected_${v_index}`">
            <td>
              <select v-model="selected[v_index]" @change="() => setContent(v_index)" >
                <option disabled value="">依頼する衣類を一つずつお選びください</option>
                <option v-for="(category, index) in categories" :key="index" :value="category">
                  {{ category.name }}
                </option>
              </select>
            </td>
            <td>
              <input type="file" @change="selectedFile" id="inputGroupFile01" name="products[image]" accept="image/png, image/jpg" :value="imagefile">
              {{ uploadFile }}
            </td>
            <td>
              <a>{{ selected[v_index].price }}</a>
            </td>
          </tr>
        </table>
      </div>
      <button @click="increment" class="btn btn-outline-primary">+</button>
      <button @click="decrement" class="btn btn-outline-primary">-</button>
      <div>
        <h4>送料</h4>
        <select v-model="selected_shipping">
          <option disabled value="">地域区分を選択してください。</option>
          <option v-for="(shipping, index) in shippings" :key="index" :value="shipping">
            {{ shipping.name }}
          </option>
        </select>
      </div>
      <div>
        依頼品合計{{ totalPrice }}円: 送料{{selected_shipping.price}}円: 合計{{ totalPrice + selected_shipping.price }}円 <br>
      </div>
      <div>
        <h4>お客様情報</h4>
        <form>
          <div v-if="alert" class="alert alert-danger">{{alert}}</div>
          <div class="form-group">
            <label for="order-name">氏名</label>
            <input type="text" v-model="customer.name" id="order-name" class="form-control">
          </div>
          <div class="form-group">
            <label for="order-email">メールアドレス</label>
            <input v-model="customer.email" id="order-email" class="form-control">
          </div>
          <!-- <div class="form-group">
            <label for="entry-body">メールアドレス（確認）</label>
            <textarea v-model="entry.body" id="entry-body" cols="80" rows="15"
          class="form-control" required maxlength="40000">
            </textarea>
          </div> -->
          <div class="form-group">
            <label for="order-phonenumber">電話番号</label>
            <input v-model="customer.phonenumber" id="order-phonenumber" class="form-control">
          </div>
          <div class="form-group">
            <label for="order-address">住所</label>
            <input v-model="customer.address" id="order-address" class="form-control">
          </div>
          <div class="form-group">
            <label for="order-sex">性別</label>
            <select v-model="customer.sex" id="order-sex" class="form-control">
              <option  value="male">男性</option>
              <option  value="female">女性</option>
            </select>
          </div>
          <div class="form-group">
            <label for="order-age">年齢</label>
            <input v-model="customer.age" id="order-address" class="form-control">
          </div>
        </form>
        <button @click="next" class="btn btn-outline-primary">次へ</button>
      </div>
    </b-col>
  </b-row>
</div>

</template>

<script>

export default {
  props: {
    customer:{
      type: Object,
      default: () => {}
    }, 
    categories: {
      type: Array,
      default: () => []
    },
    shippings: {
      type: Array,
      default: () => []
    },
  },
  data() {
    return {
      customer: {},
      alert: null,
      selected: [
        {
          id: NaN,
          name: "",
          price: 0,
        },
      ],
      selected_shipping: {
        id: NaN,
        name: "",
        price: 0,
      },
      uploadFile: null,
      imagefile: null
    };
  },
  methods: {
    increment() {
      this.selected.push({
        id: NaN,
        name: "",
        price: 0
      });
    },
    decrement() {
      if (this.selected.length === 1) return;
      this.selected.pop();
    },
    setContent(index) {
      // 選択された商品の料金を取得
      const price = this.categories.find(({name}) => name === this.selected[index].name).price;
      this.selected[index].price = price;
    },
    selectedFile(e) {
      // 選択された File の情報を保存しておく
      e.preventDefault();
      let files = e.target.files;
      this.uploadFile = files[0];
    },
    next() {
      this.$emit('change-page', {
        step: 1, // 1ページ進む
        formData: {
          customer: this.customer,
          items: this.selected,
          shipping: this.selected_shipping,
          totalprice: this.totalPrice,
          uploadFile: this.uploadFile,
        }
      });
    },
  },
  computed: {
    totalPrice() {
      // 選択された商品の合計金額を計算
      return this.selected.reduce((acc, cur) => acc + cur.price, 0);
    },
  },
};
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

