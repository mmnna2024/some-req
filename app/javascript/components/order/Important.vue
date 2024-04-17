<template>
  <div class="container">
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
            <label for="checkbox1" class="label d-flex w-100 align-items-center">
              <div class="col-3">
                <input type="checkbox" :id="'checkbox' + confirmdata.id" v-model="confirmdata.is_checked">承諾します：</div>
              <div class="col-9">{{ confirmdata.text }}</div>
            </label>
          </div>
        </li>
      </div>

      <div class="form-group px-3">
        <label for="order-note">上記をご了承の上、事前に確認したい内容があれば記載してください。</label>
        <textarea v-model="order.note" id="order-note" class="form-control" />
      </div>
      <p class="error-message" v-if="!allChecked">全ての項目にチェックする必要があります。</p>
      <div>
        <!-- :disabled="!allChecked"を一旦削除でバリデーションオフ -->
        <button :disabled="!allChecked" @click="next" class="btn btn-outline-dark">次へ</button>
        <button @click="previous" class="btn btn-outline-dark">前へ</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    order: {
      type: Object,
      default: () => {}
    }
  },
  data() {
    return {
      order: {},
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
        }
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
  .error-message {
    color: #dc3545 !important;
    font-size: 80%;
  }

  .label:hover { background-color: #F8C900; /* マウスオーバー時の背景色を指定する */ }
  .label {
    display: block; /* ブロックレベル要素化する */
    float: left; /* 要素の左寄せ・回り込を指定する */
    text-align: center; /* テキストのセンタリングを指定する */
    line-height: 30px; /* 行の高さを指定する */
    padding-left: 5px; /* ラベル内左側の余白を指定する */
    padding-right: 5px; /* ラベル内右側の余白を指定する */
    cursor: pointer; /* マウスカーソルの形（リンクカーソル）を指定する */
    margin-right: 10px;
  }
  ul{
  padding-left:0;
  }

  li{
    list-style:none;
  }

  .btn-outline-dark:hover {
  color: #F8C900;
  }

  </style>