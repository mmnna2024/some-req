<template>
  <div class="p-3">
    <h4>染め直し確認書</h4>
    <div class="card">
      <div class="card-body">
        弊社に製品の染め直し依頼をしていただきありがとうございます。
        既製品を後染め加工させていただいただく場合、素材・種類によっては以下の事象が発生してしまう恐れがございます。
        オーダーされる前に以下の注意事項のご確認をお願い致します。
      </div>
    </div>
    <div class="checklist py-3">
      <li v-for="confirmdata in confirmObject" :key="confirmdata.id">
        <div class ="form-check d-flex">
          <label :for="'checkbox' + confirmdata.id" class="label d-flex w-100 align-items-center">
            <div class="col-3">
              <input type="checkbox" :id="'checkbox' + confirmdata.id" v-model="confirmdata.is_checked">承諾します：
            </div>
              <div class="col-9">{{ confirmdata.text }}</div>
          </label>
        </div>
      </li>
    </div>
    <div class="form-group px-3">
      <label for="order-note">上記をご了承の上、事前に確認したい内容があれば記載してください。</label>
      <textarea v-model="order.note" id="order-note" class="form-control" />
      <ErrorMessage :message="validationMessage" v-if="!allChecked" />
    </div>
    <div px-3>
      <!-- :disabled="!allChecked"を一旦削除でバリデーションオフ -->
      <button :disabled="!allChecked" @click="next" class="btn btn-outline-dark">次へ</button>
      <button @click="previous" class="btn btn-outline-dark">前へ</button>
    </div>
  </div>
</template>

<script>
import ErrorMessage from './ErrorMessage.vue';
export default {
  props: {
    order: {
      type: Object,
      default: () => {}
    }
  },
  components: {
    ErrorMessage
  },
  data() {
    return {
      order: {},
      validationMessage: "全ての項目にチェックする必要があります。",
      confirmObject: [
        {
          id: 1,
          text: '自然乾燥のため、天候の影響により納品日をご相談させていただく場合がございます。',
          is_checked: false
        },
        {
          id: 2,
          text: 'サンプル染色（1点から可）のご依頼は、別途お見積りをご提示させていただきます。ご希望のお客様は、お問い合わせ時にお申し付けください。',
          is_checked: false
        },
        {
          id: 3,
          text: 'ボタンやファスナーは、染色・加工時劣化する恐れがございます。ご心配な場合には、事前に取り外してくださいますようお願いいたします。',
          is_checked: false
        },
        {
          id: 4,
          text: '裏生地の付いている衣類は、縮率の違いにより型崩れが発生する可能性がございます。',
          is_checked: false
        },
        {
          id: 5,
          text: '生地に撥水などの特別な加工がしてある場合、部分的に染ムラが出る場合がございます。',
          is_checked: false
        },
        {
          id: 6,
          text: '皮は極端に縮みます。ご依頼物に皮が付属していないかなど、事前によくご確認ください。',
          is_checked: false
        },
        {
          id: 7,
          text: '縫い糸にポリエステルが使用されている場合がございます。混合のポリエステルは染まりませんのでご注意ください。',
          is_checked: false
        },
        {
          id: 8,
          text: '染められるものは、紺色か黒色のみとなっており、単色染めに限らせていただきます。',
          is_checked: false
        },
        {
          id: 9,
          text: '糸の加工や生地の性質により、製品が縮む場合がございます。',
          is_checked: false
        },
        {
          id: 10,
          text: '特にウール製品は極端に収縮率が高いです。依頼する場合はご注意ください。',
          is_checked: false
        },
        {
          id: 11,
          text: '>丹念に洗濯をしてから、黒染め加工を行っておりますが、油染みが残っている染めムラが出てしまう場合がございます',
          is_checked: false
        },
        {
          id: 12,
          text: '素材が集まり次第、加工を行うので、納期が伸びる場合がございます。ご了承ください。',
          is_checked: false
        },
        {
          id: 13,
          text: '品質表示タグが付いていない製品はお断りする場合がございます。',
          is_checked: false
        },
        {
          id: 14,
          text: '劣化や損傷が激しい製品はお断りする場合がございます。',
          is_checked: false
        },
      ]
    }
  },
  computed: {
    allChecked() {
      // 全てのチェックボックスの状態を確認
      return this.confirmObject.every(confirmdata => confirmdata.is_checked);
    }
  },
  methods: {
    next() {
      this.$emit('change-page', {
        step: 1, // 1ページ進む
        formData: {
          order: this.order
        }
      });
    },
    previous(){
      this.$emit('change-page', {step: -1}); // 1ページ戻る
    }
  }
}
</script>

<style>
  .label:hover { background-color: #F8C900;}
  
  .label { 
    display: block;
    float: left;
    text-align: center;
    line-height: 30px;
    padding-left: 5px;
    padding-right: 5px;
    cursor: pointer;
    margin-right: 10px; 
  }
  ul{
    padding-left:0;
  }

  li{
    list-style:none;
  }

  .error-message {
  color: #dc3545 !important;
  font-size: 80%;
  }

  </style>