<template>
  <div>
    <div class="py-3">
      <h4>ご依頼内容</h4>
        <div class="card">
          <div class="card-body">
            ご依頼したい衣類種目を選択し、全体写真、衣類タグ写真をアップロードしてください。<br>
            衣類のカテゴリーは
            <a class="link-dark link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover" href="/">こちら</a>
          </div>
        </div>
      <div class="px-3 pt-3">
        <div class="row order-table-top justify-content-between pt-1">
          <div class="col-5 d-none d-md-block d-xl-block d-xxl-block text-center">衣類選択</div>
          <div class="col-5 d-none d-md-block d-xl-block d-xxl-block text-center">全体写真、衣類タグアップロード</div>
          <div class="col-2 d-none d-md-block d-xl-block d-xxl-block text-center">単価</div>
        </div>
        <transition-group  name="transit">
          <div class="row order-table justify-content-between" v-for="(v, v_index) in selected.length" :key="`selected_${v_index}`">
            <div class="col-sm-5">
              <select v-model="selected[v_index]" @change="() => setContent(v_index)"  class="form-select" >
                <option disabled value="">依頼する衣類を一つずつお選びください</option>
                <option v-for="(category, index) in categories" :key="index" :value="category">
                  {{ category.name }}
                </option>
              </select>
            </div>
            <div class="col-sm-5">
              <input type="file" @change="selectedFile($event, v_index)" :id="`inputGroupFile_${v_index}`" :name="`image_${v_index}`" accept="image/png, image/jpeg" multiple>
            </div>
            <div class="col-sm-2 align-self-center d-flex justify-content-center">{{ selected[v_index].price }} </div>
          </div>
        </transition-group>
      </div>
      <div class="px-3">
        <ErrorMessage :message="validation.selectedResult" />
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
            <option v-for="(shipping, index) in shippings" :key="index" :value="shipping">
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
        <div class="px-3">
          <ErrorMessage :message="validation.shippingResult" />
        </div>
      </div>

      <div class="row justify-content-between px-3">
        <div class="col-sm">
          <p>※依頼品の送付はお客様元払い、着払いのため送料は参考価格です。<br>
            ※染め上がり後、依頼品到着時の送料です。
          </p>
        </div>
        <div class="col-sm-4">
          <div class="row total-table">
            <div class="col-sm border p-1">見積り合計</div>
            <div class="col-sm p-1 text-center">{{ totalPrice + selected_shipping.price }}円</div>
          </div>
        </div>
      </div>
    </div>

    <div class="py-3">
      <h4>お客様情報</h4>
      <form>
        <div class="row g-3">
          <div class="col-sm-10">
            <label for="order-name">氏名[必須]</label>
            <input type="text" v-model="customer.name" id="order-name" class="form-control" required>
            <div>
              <ErrorMessage :message="validation.nameResult" />
            </div>
          </div>
          <div class="col-sm-10">
            <label for="order-email">メールアドレス</label>
            <input v-model="customer.email" id="order-email" class="form-control">
          </div>
          <div class="col-sm-10">
            <label for="order-phonenumber">電話番号[必須]</label>
            <input v-model="customer.phonenumber" id="order-phonenumber" class="form-control" required>
            <div>
              <ErrorMessage :message="validation.phonenumberResult" />
            </div>  
          </div>
          
          <div class="col-sm-10">
            <label for="order-address">住所[必須]</label>
            <input v-model="customer.address" id="order-address" class="form-control" required>
            <div>
              <ErrorMessage :message="validation.addressResult" />
            </div>  
          </div>
          <div class="col-sm-5">
            <label for="order-sex">性別</label>
            <select v-model="customer.sex" id="order-sex"  class="form-select">
              <option  value="male">男性</option>
              <option  value="female">女性</option>
            </select>
          </div>
          <div class="col-sm-5">
            <label for="order-age">年齢</label>
            <input v-model="customer.age" id="order-age" class="form-control">
          </div>
        </div>
      </form>
      <div class="py-3">
        <button @click="next" class="btn btn-outline-dark">次へ</button>
      </div>
    </div>
  </div>
</template>

<script>
import ErrorMessage from './ErrorMessage.vue';
import {
  nameValidate,
  phonenumberValidate,
  addressValidate,
  selectedValidate,
  shippingValidate,
  crearValidation
} from '../../packs/utils/validator.js';

export default {
  components: {
    ErrorMessage
  },
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
      view: true,
      customer: {},
      selected: [
        {
          category: {
          id: NaN,
          name: "",
          price: 0,
        },
        uploadFiles: []
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
      // 選択が変更されるとfileをリセットする
      const obj = document.getElementById(`inputGroupFile_${index}`);
        obj.value = "";
    },
    selectedFile(e, index) {
      // 選択された File の情報を保存しておく
      const files = Array.from(e.target.files);
      this.selected[index].uploadFiles = files;
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
        // NOTE: validationの順番に依存しているため、順番を変えないように注意
      [
        nameValidate(this.customer.name),
        phonenumberValidate(this.customer.phonenumber),
        addressValidate(this.customer.address),
        selectedValidate(this.selected),
        shippingValidate(this.selected_shipping?.id)
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
  computed: {
    totalPrice() {
      // 選択された商品の合計金額を計算
      return this.selected.reduce((acc, cur) => acc + (Number.isFinite(cur.price) ? cur.price : 0), 0);
    },
  },
};

</script>

<style>
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