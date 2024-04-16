<template>
  <div class="container">
    <div class="row">
        <div class="py-3">
          <h4>ご依頼内容</h4>
          <table class="table categories-table">
            <thead class="thead-dark">
            <tr>
              <th scope="col" style="width: 40%">衣類選択</th>
              <th scope="col" style="width: 30%">衣類タグ、全体写真アップロード</th>
              <th scope="col" style="width: 30%">単価</th>
            </tr>
            </thead>
            <tr v-for="(v, v_index) in selected.length" :key="`selected_${v_index}`">
              <td>
                <select v-model="selected[v_index]" @change="() => setContent(v_index)"  class="form-select" >
                  <option disabled value="">依頼する衣類を一つずつお選びください</option>
                  <option v-for="(category, index) in categories" :key="index" :value="category">
                    {{ category.name }}
                  </option>
                </select>
              </td>
              <td>
                <input type="file" @change="selectedFile($event, v_index)" id="inputGroupFile01" name="products[image][]" accept="image/png, image/jpg" multiple>
              </td>
              <td class="align-middle">
                <a>{{ selected[v_index].price }}</a>
              </td>
            </tr>
          </table>
          <!--エラーメッセージ-->
          <div class="px-3">
            <p class="error-message">{{ validation.selectedResult }}</p>
          </div>
          <div class="row justify-content-between px-3">
            <div class="col-4">
              <a @click="increment" class="link link-dark mr-3" style="text-decoration:underline">衣類を追加する</a>
              <a @click="decrement" class="link link-dark" style="text-decoration:underline">１つ削除する</a>
            </div>
            <div class="col-4">
              <table class="table categories-table" width="200">
                <tr>
                  <td scope="col" style="width: 50%">依頼品合計</td>
                  <td scope="col" style="width: 50%">{{ totalPrice }}円</td>
                </tr>
              </table>
            </div>
          </div>
          <h4>送料</h4>
          <div class="row justify-content-between align-items-center px-3">
            <div class="col-sm">
              <select v-model="selected_shipping" class="custom-select">
                <option disabled value="">地域区分を選択してください。</option>
                <option v-for="(shipping, index) in shippings" :key="index" :value="shipping">
                  {{ shipping.name }}
                </option>
              </select>
            </div>
            <div class="col-4">
              <table class="table categories-table" width="200">
                <tr>
                  <td scope="col" style="width: 50%">送料</td>
                  <td scope="col" style="width: 50%">{{selected_shipping.price}}円</td>
                </tr>
              </table>
            </div>
          </div>
        <!--エラーメッセージ-->
        <div class="px-3">
          <p class="error-message">{{ validation.shippingResult }}</p>
        </div>

        <div class="row justify-content-between px-3">
          <div class="col-sm">
            <p>※着払いのため送料は参考価格です。</p>
          </div>
          <div class="col-4">
            <table class="table total-table" width="100">
                <tr>
                  <td scope="col" style="width: 50%">合計</td>
                  <td scope="col" style="width: 50%">{{ totalPrice + selected_shipping.price }}円</td>
                </tr>
              </table>
          </div>
        </div>

        <div class="p-3">
          <h4>お客様情報</h4>
          <form>
            <div class="form-row">
              <div class="form-group col-10">
                <label for="order-name">氏名[必須]</label>
                <input type="text" v-model="customer.name" id="order-name" class="form-control" required>
                <!--エラーメッセージ-->
                <div>
                  <p class="error-message">{{ validation.nameResult }}</p>
                </div>
              </div>
              <div class="form-group col-10">
                <label for="order-email">メールアドレス</label>
                <input v-model="customer.email" id="order-email" class="form-control">
              </div>
              <div class="form-group col-10">
                <label for="order-phonenumber">電話番号[必須]</label>
                <input v-model="customer.phonenumber" id="order-phonenumber" class="form-control" required>
                <!--エラーメッセージ-->
                <div>
                  <p class="error-message">{{ validation.phonenumberResult }}</p>
                </div>  
              </div>
              
              <div class="form-group col-10">
                <label for="order-address">住所[必須]</label>
                <input v-model="customer.address" id="order-address" class="form-control" required>
                <!--エラーメッセージ-->
                <div>
                  <p class="error-message">{{ validation.addressResult }}</p>
                </div>  
              </div>
              <div class="form-group col-5">
                <label for="order-sex">性別</label>
                <select v-model="customer.sex" id="order-sex"  class="form-select">
                  <option  value="male">男性</option>
                  <option  value="female">女性</option>
                </select>
              </div>
              <div class="form-group col-5">
                <label for="order-age">年齢</label>
                <input v-model="customer.age" id="order-address" class="form-control">
              </div>
            </div>
          </form>
          <button @click="next" class="btn btn-outline-dark">次へ</button>
        </div>
      </div>
    </div>
  </div>

</template>

<script>

export default {
  props: {
    categories: {
      type: Array,
      default: () => []
    },
    shippings: {
      type: Array,
      default: () => []
    }
  },
  data() {
    return {
      customer: {},
      selected: [
        {
          category: {
          id: NaN,
          name: "",
          price: 0,
        },
        uploadFiles: [],
        imagefile: null
        },
      ],
      selected_shipping: {
        id: NaN,
        name: "",
        price: 0,
      },
      validation: {
        nameResultameResult: '',
        phonenumberResult: '',
        addressResult: '',
        selectedResult: '',
        shippingResult: ''
      },
      valid: false
    };
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
      const price = this.categories.find(({name}) => name === this.selected[index].category.name).price;
      this.selected[index].category.price = price;
    },
    selectedFile(e, index) {
      // 選択された File の情報を保存しておく
      const files = Array.from(e.target.files);
      if (this.selected[index]) {
      this.selected[index].uploadFiles = files;
      } else {
      console.error('Selected index is out of range or not initialized:', index);
    }
    },
    next() {
      // 作成のためバリデーション削除
      this.checkValidate()
      if (this.valid === true){
        this.$emit('change-page', {
          step: 1, // 1ページ進む
          formData: {
            customer: this.customer,
            items: this.selected,
            shipping: this.selected_shipping,
            totalprice: this.totalPrice,
          }
        });
      }
    },    
      checkValidate() {
      const name_error_message = this.nameValidate(this.customer.name)
      if(name_error_message === true) {
        this.validation.nameResult = '';
      } else {
        this.validation.nameResult = name_error_message;
      }

      const phonenumber_error_message = this.phonenumberValidate(this.customer.phonenumber)
      if(phonenumber_error_message === true) {
        this.validation.phonenumberResult = '';
      } else {
        this.validation.phonenumberResult = phonenumber_error_message;
      }

      const address_error_message = this.addressValidate(this.customer.address)
      if(address_error_message === true) {
        this.validation.addressResult = '';
      } else {
        this.validation.addressResult = address_error_message;
      }

      const selected_error_message = this.selectedValidate(this.selected)
      if(selected_error_message === true) {
        this.validation.selectedResult = '';
      } else {
        this.validation.selectedResult = selected_error_message;
      }

      const shipping_error_message = this.shippingValidate(this.selected_shipping)
      if(shipping_error_message === true) {
        this.validation.shippingResult = '';
      } else {
        this.validation.shippingResult = shipping_error_message;
      }

      if (this.crearValidation(this.validation) ==  true) {
        return this.valid = true
      }
      else{
        return this.valid = false
      }
    },
    
    nameValidate(name) {
      if(!name) {
        return '名前は入力必須項目です。';
      }
      return true;
    },

    phonenumberValidate(phonenumber) {
      if(!phonenumber) {
        return '電話番号は入力必須項目です。';
      }
      if(!phonenumber.match(/[0-9]+/g)) {
        return '整数で入力してください';
      }
      return true;
    },

    addressValidate(address) {
      if(!address) {
        return '住所は入力必須項目です。';
      }
      return true;
    },

    selectedValidate(selected) {
      let validationResult = true;
      selected.forEach((select) => {
    if (select.category && select.category.id !== undefined && Number.isNaN(select.category.id)) {
      validationResult = '衣類の選択をしてください。'; // エラーメッセージを設定
    }
  });
  return validationResult; // 結果を返す
},

    shippingValidate(shipping) {
      if(Number.isNaN(shipping.id)) {
        return '送付先の選択をしてください。';
      }
      return true;
    },

    crearValidation(msg) {
      return Object.values(msg).every(value => value === '');
    }
  },
  computed: {
    totalPrice() {
      // 選択された商品の合計金額を計算
      return this.selected.reduce((acc, cur) => acc + (Number.isFinite(cur.price) ? cur.price : 0), 0);
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

  .total-table {
  border: 5px solid gray;
  margin: 10px;
  }

  .total-table th,
  .total-table td {
  border: 1px solid rgb(204, 204, 204);
  color: #ff0019;
  font-size: 20px;
  }

  .link:hover {
  color: #F8C900;
  }

  .error-message {
    color: #dc3545 !important;
    font-size: 80%;
  }
  
  .btn-outline-dark:hover {
  color: #F8C900;
  }

</style>