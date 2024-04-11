<template>
  <div class="tab">
    <h4>染め直し確認書</h4>
    <p>弊社に製品の染め直し依頼をしていただきありがとうございます。
既製品を後染め加工させていただいただく場合、素材・種類によっては以下の事象が発生してしまう恐れがございます。
オーダーされる前に以下の注意事項のご確認をお願い致します。</p>
    <div class="checklist">
        <li>自然乾燥のため、天候の影響により納品日をご相談させていただく場合がございます。<br>
          <div class ="d-flex justify-content-center">
            <input type="checkbox" id="checkbox1" v-model="isChecked">
            <label for="checkbox1">了解</label>
          </div>
        </li>
      <li>サンプル染色（1点から可）のご依頼は、別途お見積りをご提示させていただきます。ご希望のお客様は、お問い合わせ時にお申し付けください。<br>
      <input type="checkbox" id="checkbox1" v-model="isChecked">
            <label for="checkbox1">了解</label></li>
      <li>ボタンやファスナーは、染色・加工時劣化する恐れがございます。ご心配な場合には、事前に取り外してくださいますようお願いいたします。<br>
      <input type="checkbox" id="checkbox1" v-model="isChecked">
            <label for="checkbox1">了解</label></li>
      <li>裏生地の付いている衣類は、縮率の違いにより型崩れが発生する可能性がございます。<br>
      <input type="checkbox" id="checkbox1" v-model="isChecked">
            <label for="checkbox1">了解</label></li>
      <li>生地に撥水などの特別な加工がしてある場合、部分的に染ムラが出る場合がございます。<br>
      <input type="checkbox" id="checkbox1" v-model="isChecked">
            <label for="checkbox1">了解</label></li>
      <li>皮は極端に縮みます。ご依頼物に皮が付属していないかなど、事前によくご確認ください。<br>
      <input type="checkbox" id="checkbox1" v-model="isChecked">
            <label for="checkbox1">了解</label></li>
      <li>縫い糸にポリエステルが使用されている場合がございます。混合のポリエステルは染まりませんのでご注意ください。<br>
      <input type="checkbox" id="checkbox1" v-model="isChecked">
            <label for="checkbox1">了解</label></li>
      <li>染められるものは、紺色か黒色のみとなっており、単色染めに限らせていただきます。<br>
      <input type="checkbox" id="checkbox1" v-model="isChecked">
            <label for="checkbox1">了解</label></li>
      <li>糸の加工や生地の性質により、製品が縮む場合がございます。<br>
      <input type="checkbox" id="checkbox1" v-model="isChecked">
            <label for="checkbox1">了解</label></li>
      <li>特にウール製品は極端に収縮率が高いです。依頼する場合はご注意ください。<br>
      <input type="checkbox" id="checkbox1" v-model="isChecked">
            <label for="checkbox1">了解</label></li>
      <li>丹念に洗濯をしてから、黒染め加工を行っておりますが、油染みが残っている染めムラが出てしまう場合がございます。<br>
      <input type="checkbox" id="checkbox1" v-model="isChecked">
            <label for="checkbox1">了解</label></li>
      <li>素材が集まり次第、加工を行うので、納期が伸びる場合がございます。ご了承ください。<br>
      <input type="checkbox" id="checkbox1" v-model="isChecked">
            <label for="checkbox1">了解</label></li>
      <li>品質表示タグが付いていない製品はお断りする場合がございます。<br>
      <input type="checkbox" id="checkbox1" v-model="isChecked">
            <label for="checkbox1">了解</label></li>
      <li>劣化や損傷が激しい製品はお断りする場合がございます。<br>
      <input type="checkbox" id="checkbox1" v-model="isChecked">
            <label for="checkbox1">了解</label></li>
    </div>
    <div class="form-group">
      <label for="order-note">事前に確認したい内容を記載してください。</label>
      <input v-model="order.note" id="order-note" class="form-control">
    </div>
    <div>
      <button @click="next" class="btn btn-outline-primary">次へ</button>
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
      order: {}
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