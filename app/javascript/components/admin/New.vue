<template>
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-12 col-md-10 col-lg-8">
        <div class="py-3">
          <h4>ご依頼内容</h4>
          <div class="px-3 pt-3">
            <div class="row order-table-top justify-content-between pt-1">
              <div class="col-6 d-none d-md-block d-xl-block d-xxl-block text-center">衣類選択</div>
              <div class="col-6 d-none d-md-block d-xl-block d-xxl-block text-center">単価</div>
            </div>
            <transition-group  name="transit">
              <div class="row order-table justify-content-between" v-for="(v, v_index) in selected.length" :key="`selected_${v_index}`">
                <div class="col-sm-6">
                  <select v-model="selected[v_index]" @change="() => setContent(v_index)"  class="form-select" >
                    <option disabled value="">依頼する衣類を一つずつお選びください</option>
                    <option v-for="(category, index) in initialData.categories" :key="index" :value="category">
                      {{ category.name }}
                    </option>
                  </select>
                </div>
                <div class="col-sm-6 align-self-center d-flex justify-content-center">{{ selected[v_index].price }} </div>
              </div>
            </transition-group>
          </div>
          <!--エラーメッセージ-->
          <div class="px-3">
            <p class="error-message">{{ validation.selectedResult }}</p>
          </div>
          <div class="row justify-content-between px-3 pb-3">
            <div class="col-sm-4 pb-1">
              <a @click="increment" class="link-dark link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover p-1">衣類を追加する</a>
              <a @click="decrement" class="link-dark link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">１つ削除する</a>
            </div>
            <div class="col-sm-4">
              <div class="row">
                <div class="col-sm order-table">依頼品合計</div>
                <div class="col-sm order-table text-center">{{ totalPrice }}円</div>
              </div>
            </div>
          </div>

          <div class="row justify-content-between px-3 pt-3">
            <h4>送料</h4>
            <div class="col-sm-8 pb-2">
              <select v-model="selected_shipping" class="form-select">
                <option disabled value="">地域区分を選択してください。</option>
                <option v-for="(shipping, index) in initialData.shippings" :key="index" :value="shipping">
                  {{ shipping.name }}
                </option>
              </select>
            </div>
            <div class="col-sm-4">
              <div class="row">
                <div class="col-sm order-table">送料</div>
                <div class="col-sm order-table text-center">{{selected_shipping.price}}円</div>
              </div>
            </div>
            <!--エラーメッセージ-->
            <div class="px-3">
              <p class="error-message">{{ validation.shippingResult }}</p>
            </div>
          </div>

          <div class="row justify-content-between px-3">
            <div class="col-sm">
              <p>※着払いのため送料は参考価格です。</p>
            </div>
            <div class="col-sm-4">
              <div class="row total-table">
                <div class="col-sm border p-1">見積り合計</div>
                <div class="col-sm p-1 text-center">{{ totalPrice + selected_shipping.price }}円</div>
              </div>
            </div>
          </div>
          
          <div class="py-3">
            <h4>お客様情報</h4>
            <form>
              <div class="row g-3">
                <div class="col-sm-10">
                  <label for="order-name">氏名[必須]</label>
                  <input type="text" v-model="customer.name" id="order-name" class="form-control">
                  <!--エラーメッセージ-->
                  <div>
                    <p class="error-message">{{ validation.nameResult }}</p>
                  </div>
                </div>  
                <div class="col-sm-10">
                  <label for="order-email">メールアドレス</label>
                  <input v-model="customer.email" id="order-email" class="form-control">
                </div>
                <div class="col-sm-10">
                  <label for="order-phonenumber">電話番号[必須]</label>
                  <input v-model="customer.phonenumber" id="order-phonenumber" class="form-control">
                  <!--エラーメッセージ-->
                  <div>
                    <p class="error-message">{{ validation.phonenumberResult }}</p>
                  </div>
                </div>
                <div class="col-sm-10">
                  <label for="order-address">住所[必須]</label>
                  <input v-model="customer.address" id="order-address" class="form-control">
                  <!--エラーメッセージ-->
                  <div>
                    <p class="error-message">{{ validation.addressResult }}</p>
                  </div>  
                </div>
                <div class="col-sm-5">
                  <label for="order-sex">性別</label>
                  <select v-model="customer.sex" id="order-sex" class="form-select">
                    <option  value="male">男性</option>
                    <option  value="female">女性</option>
                  </select>
                </div>
                <div class="col-sm-5">
                  <label for="order-age">年齢</label>
                  <input v-model="customer.age" id="order-age" class="form-control">
                </div>
                <div class="col-sm-5">
                  <label for="order-chanel">受付</label>
                  <select v-model="customer.chanel" id="order-chanel" class="form-select">
                    <option value="shop" selected>店頭</option>
                    <option value="phonecall">電話</option>
                  </select>
                  <!--エラーメッセージ-->
                  <div>
                    <p class="error-message">{{ validation.chanelResult }}</p>
                  </div>
                </div>
                <div class="col-sm-10">
                  <label for="order-note">備考</label>
                  <textarea v-model="customer.note" id="order-note" class="form-control" />
                </div>
              </div>
            </form>
          </div>
          <div class="py-3">
            <button @click="submit" class="btn btn-outline-dark">登録する</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import {
  nameValidate,
  phonenumberValidate,
  addressValidate,
  selectedValidate,
  shippingValidate,
  chanelValidate,
  crearValidation
} from '../../packs/utils/validator.js';
export default {
  props: {
    initialData: {
      type: Object,
      default: () => {}
    }
  },
  data() {
    return {
      customer: {},
      alert: null,
      selected: [
        {
          category: {
          id: NaN,
          name: "",
          price: 0,
          },
        },
      ],
      selected_shipping: {
        id: NaN,
        name: "",
        price: 0,
      }, 
      validation: {
        nameResult: '',
        phonenumberResult: '',
        addressResult: '',
        selectedResult: '',
        shippingResult: '',
        chanelResult: ''
      },
      valid: false
    };
  },
  computed: {
    totalPrice() {
      // 選択された商品の合計金額を計算
      return this.selected.reduce((acc, cur) => acc + (Number.isFinite(cur.price) ? cur.price : 0), 0);
    },
  },
  methods: {
    increment() {
      this.selected.push({
        category: {
          id: NaN,
          name: "",
          price: 0,
        },
        uploadFiles: [],
        imagefile: null
      });
    },
    decrement() {
      if (this.selected.length === 1) return;
      this.selected.pop();
    },
    setContent(index) {
      // 選択された商品の料金を取得
      const price = initialData.categories.find(({name}) => name === this.selected[index].category.name).price;
      this.selected[index].category.price = price;
    },

    async submit(){ 
      this.checkValidate()
      if (this.valid === true){
        const FormData = require('form-data');
        const form = new FormData();
        form.append('order_form[name]', this.customer.name);
        form.append('order_form[email]', this.customer.email);
        form.append('order_form[phonenumber]', this.customer.phonenumber);
        form.append('order_form[address]', this.customer.address);
        if(this.customer.age !== undefined) form.append('order_form[age]', this.customer.age);
        if(this.customer.sex !== undefined) form.append('order_form[sex]', this.customer.sex);
        form.append('order_form[channel]', this.customer.chanel);
        form.append('order_form[note]', this.customer.note);
        form.append('order_form[status]', 'unchecked_order');
        form.append('order_form[shipping_id]', this.selected_shipping.id);
        this.selected.forEach((select) => {
          form.append('order_form[category_ids][]', select.id);
        })
        
        try {
          const res = await axios({
            method: 'post',
            url: '/admin/orders',
            data: form,
            headers: {'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')},
          });

          // リクエストが成功したら、完了ページへリダイレクト
          window.location.href = '/admin/orders/unchecked_index';
        } catch (error) {
          if (error.response.data && error.response.data.errors) {
                  this.errors = error.response.data.errors;
          }
        }
      }
    },
    checkValidate() {
      // NOTE: validationの順番に依存しているため、順番を変えないように注意
      [
        nameValidate(this.customer.name),
        phonenumberValidate(this.customer.phonenumber),
        addressValidate(this.customer.address),
        selectedValidate(this.selected),
        shippingValidate(this.selected_shipping?.id),
        chanelValidate(this.customer.chanel)
      ].forEach((result, index) => {
        this.validation[Object.keys(this.validation)[index]] = result.message;
      });
      if (crearValidation(this.validation) ==  true) {
        return this.valid = true
      }
      else{
        return this.valid = false
      }
    },
  },
};

</script>

<style scoped>
.error-message {
  color: #dc3545 !important;
  font-size: 80%;
}
.order-table-top {
  border: 1px solid gray;
  padding: 10px;
  color: white;
  background-color: #333;
  font-weight: bold;
}

.order-table {
  border: 1px solid gray;
  padding: 10px;
}

.total-table {
  border: 5px solid gray;
  color: #ff0019;
  font-size: 20px;
}

.btn-outline-dark:hover {
  color: #F8C900;
}

.link-dark:hover {
  color: #F8C900;
  cursor: pointer;
}

.trans {
  background-color: black;
  color: white;
  padding: 10px;
  font-size: 20pt;
}
.transit-enter-active {
  transition: opacity 1s;
}
.transit-leave-active {
  transition: opacity 300ms;
}
.transit-enter {
  opacity: 0;
}
t .transit-enter-from {
  opacity: 0;
}
.transit-enter-to {
  opacity: 1;
}
.transit-leave {
  opacity: 1;
}
.transit-leave-to {
  opacity: 0;
}

</style>

