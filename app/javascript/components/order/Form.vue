<template>
  <div class="form-container container">
  <b-row>
    <b-col :span="12">
      <div>
        <p>ご依頼内容</p>
        <table class="categories-table">
          <tr>
            <th>衣類選択</th>
            <th>衣類タグ、全体写真アップロード</th>
            <th>数量</th>
            <th>単価</th>
            <th>小計</th>
          </tr>
          <tr v-for="(v, v_index) in selected.length" :key="`selected_${v_index}`">
            <td>
              <select v-model="selected[v_index]"
                      @change="() => setContent(v_index)"
              >
                <option disabled value="">依頼する衣類を一つずつお選びください</option>
                <option v-for="(category, index) in categories" :key="index" :value="category">
                  {{ category.name }}
                </option>
              </select>
            </td>
            <td>
              <input type="file" id="inputGroupFile01" accept="image/png, image/jpeg">
            </td>
            <td>
              <input type="number" v-model="selected[v_index].count" />
            </td>

            <td>
              <a>{{ selected[v_index].price }}</a>
            </td>

            <td>
              <a>{{ selected[v_index].price * selected[v_index].count }}</a>
            </td>

          </tr>
        </table>
      </div>
      <button @click="increment" class="btn btn-outline-primary">+</button>
      <button @click="decrement" class="btn btn-outline-primary">-</button>
      <!-- <div>
        <select v-model="selected[v_index]"
        @change="() => setContent(v_index)"
        >
          <option disabled value="">地域区分を選択してください。</option>
          <option v-for="(category, index) in categories" :key="index" :value="category">
            {{ category.name }}
          </option>
        </select>
      </div> -->
      <div>
        合計{{ totalPrice }}円
        <span v-if="totalPrice >= deliveryFreePrice" >
          (送料無料)
        </span>
        <span v-else>
          あと{{ deliveryFreePrice - totalPrice }}円の注文で送料無料
        </span>
      </div>
      <div>
        <p>お客様情報</p>
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
            <label for="order-phone">電話番号</label>
            <input v-model="customer.phone" id="order-phone" class="form-control">
          </div>
          <div class="form-group">
            <label for="order-address">住所</label>
            <input v-model="customer.address" id="order-address" class="form-control">
          </div>
          <div class="form-group">
            <label for="order-sex">性別</label>
            <select v-model="customer.sex" id="order-sex" class="form-control">
              <option  value="0">男性</option>
              <option  value="1">女性</option>
            </select>
          </div>
          <div class="form-group">
            <label for="order-age">年齢</label>
            <input v-model="customer.age" id="order-address" class="form-control">
          </div>
        </form>
      </div>
    </b-col>
  </b-row>
</div>

</template>

<script>
export default {
  props: {
    order: {
      type: Object,
      default: () => {}
    },
    customer:{
      type: Object,
      default: () => {}
    }, 
    categories: {
      type: Array,
      default: () => []
    }
  },
  data() {
    return {
      customer: {},
      alert: null,
      selected: [
        {
          id: NaN,
          name: "",
          count: 1,
          price: 0,
        },
      ],
      deliveryFreePrice: 10000,
    };
  },
  methods: {
    increment() {
      this.selected.push({
        id: NaN,
        name: "",
        count: 0,
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
      // selectedにすでに同一のnameがある場合は対象の個数を1つ増やし, 新しく追加されているselectedは削除する, 重複行を削除するため
      if (this.selected.filter(({name}) => name === this.selected[index].name).length > 1) {
        // 最初に見つかったselectedの個数を1つ増やす
        this.selected.find(({name}) => name === this.selected[index].name).count++;
        // 重複しているselectedを削除
        this.selected = this.selected.filter((_, i) => i !== index);
        return;
      }
      // 選択された商品の個数が0の場合は1にする
      if (this.selected[index].count === 0) this.selected[index].count = 1;
      this.selected[index].price = price;
    },
  },
  computed: {
    totalPrice() {
      // 選択された商品の合計金額を計算
      return this.selected.reduce((acc, cur) => acc + cur.price * cur.count, 0);
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