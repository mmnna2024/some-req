<template>
  <div class="tab">
    <h4>染め直し確認書</h4>
    <p>弊社に製品の染め直し依頼をしていただきありがとうございます。
既製品を後染め加工させていただいただく場合、素材・種類によっては以下の事象が発生してしまう恐れがございます。
オーダーされる前に以下の注意事項のご確認をお願い致します。</p>
    <div class="checklist">
        <li>自然乾燥のため、天候の影響により納品日をご相談させていただく場合がございます。<br>
          <div class ="d-flex justify-content-center">
            <label class="label" for="checkbox1">
              <input type="checkbox" id="checkbox1" v-model="checkboxes.option1">了解
            </label>
          </div>
        </li>
      <li>サンプル染色（1点から可）のご依頼は、別途お見積りをご提示させていただきます。ご希望のお客様は、お問い合わせ時にお申し付けください。<br>
      <input type="checkbox" id="checkbox2" v-model="checkboxes.option2">
            <label for="checkbox2" class="label">了解</label></li>
      <li>ボタンやファスナーは、染色・加工時劣化する恐れがございます。ご心配な場合には、事前に取り外してくださいますようお願いいたします。<br>
      <input type="checkbox" id="checkbox3" v-model="checkboxes.option3">
            <label for="checkbox3">了解</label></li>
      <li>裏生地の付いている衣類は、縮率の違いにより型崩れが発生する可能性がございます。<br>
      <input type="checkbox" id="checkbox4" v-model="checkboxes.option4">
            <label for="checkbox4">了解</label></li>
      <li>生地に撥水などの特別な加工がしてある場合、部分的に染ムラが出る場合がございます。<br>
      <input type="checkbox" id="checkbox5" v-model="checkboxes.option5">
            <label for="checkbox1">了解</label></li>
      <li>皮は極端に縮みます。ご依頼物に皮が付属していないかなど、事前によくご確認ください。<br>
      <input type="checkbox" id="checkbox6" v-model="checkboxes.option6">
            <label for="checkbox1">了解</label></li>
      <li>縫い糸にポリエステルが使用されている場合がございます。混合のポリエステルは染まりませんのでご注意ください。<br>
      <input type="checkbox" id="checkbox7" v-model="checkboxes.option7">
            <label for="checkbox1">了解</label></li>
      <li>染められるものは、紺色か黒色のみとなっており、単色染めに限らせていただきます。<br>
      <input type="checkbox" id="checkbox8" v-model="checkboxes.option8">
            <label for="checkbox1">了解</label></li>
      <li>糸の加工や生地の性質により、製品が縮む場合がございます。<br>
      <input type="checkbox" id="checkbox9" v-model="checkboxes.option9">
            <label for="checkbox1">了解</label></li>
      <li>特にウール製品は極端に収縮率が高いです。依頼する場合はご注意ください。<br>
      <input type="checkbox" id="checkbox10" v-model="checkboxes.option10">
            <label for="checkbox1">了解</label></li>
      <li>丹念に洗濯をしてから、黒染め加工を行っておりますが、油染みが残っている染めムラが出てしまう場合がございます。<br>
      <input type="checkbox" id="checkbox11" v-model="checkboxes.option11">
            <label for="checkbox1">了解</label></li>
      <li>素材が集まり次第、加工を行うので、納期が伸びる場合がございます。ご了承ください。<br>
      <input type="checkbox" id="checkbox12" v-model="checkboxes.option12">
            <label for="checkbox1">了解</label></li>
      <li>品質表示タグが付いていない製品はお断りする場合がございます。<br>
      <input type="checkbox" id="checkbox13" v-model="checkboxes.option13">
            <label for="checkbox1">了解</label></li>
      <li>劣化や損傷が激しい製品はお断りする場合がございます。<br>
      <input type="checkbox" id="checkbox14" v-model="checkboxes.option14">
            <label for="checkbox1">了解</label></li>
    </div>
    <div class="form-group">
      <label for="order-note">上記をご了承の上、事前に確認したい内容があれば記載してください。</label>
      <input v-model="order.note" id="order-note" class="form-control">
    </div>
    <p class="error-message" v-if="!allChecked">全ての項目にチェックする必要があります。</p>
    <div>
      <button :disabled="!allChecked" @click="next" class="btn btn-outline-primary">次へ</button>
      <button @click="previous" class="btn btn-outline-primary">前へ</button>
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
      checkboxes: {
        option1: false,
        option2: false,
        option3: false,
        option4: false,
        option5: false,
        option6: false,
        option7: false,
        option8: false,
        option9: false,
        option10: false,
        option11: false,
        option12: false,
        option13: false,
        option14: false,
      }
    }
  },
  computed: {
    allChecked() {
      // 全てのチェックボックスの状態を確認
      return Object.values(this.checkboxes).every(value => value === true);
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

  input[type="checkbox"]:checked + label {
    background: #31A9EE;/* マウス選択時の背景色を指定する */ 
    color: #ffffff; /* マウス選択時のフォント色を指定する */ 
    }

  .label:hover { background-color: #E2EDF9; /* マウスオーバー時の背景色を指定する */ }
  
  .label { 
    display: block; /* ブロックレベル要素化する */ 
    float: left; /* 要素の左寄せ・回り込を指定する */ 
    margin: 5px; /* ラベル外側の余白を指定する */ 
    width: 100px; /* ラベルの横幅を指定する */ 
    height: 45px; /* ラベルの高さを指定する */
     text-align: center; /* テキストのセンタリングを指定する */ 
     line-height: 45px; /* 行の高さを指定する */ 
     padding-left: 5px; /* ラベル内左側の余白を指定する */ 
     padding-right: 5px; /* ラベル内右側の余白を指定する */ 
     cursor: pointer; /* マウスカーソルの形（リンクカーソル）を指定する */ 
     color: #b20000; /* フォントの色を指定 */ 
     border: 2px solid #006DD9;/*ラベルの境界線を実線で指定する */ 
     border-radius: 5px; /* 角丸を指定する */ }
</style>