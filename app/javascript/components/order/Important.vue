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
        <li>
          <div class ="form-check d-flex">
            <label for="checkbox1" class="label d-flex w-100 align-items-center">
              <div class="col-3"><input type="checkbox" id="checkbox1" v-model="checkboxes.option1">承諾します：</div>            
              <div class="col-9">自然乾燥のため、天候の影響により納品日をご相談させていただく場合がございます。</div>
            </label>
          </div>
        </li>
        <li>
          <div class ="form-check d-flex pb-2">
            <label for="checkbox2" class="label d-flex w-100 align-items-center">
              <div class="col-3"><input type="checkbox" id="checkbox2" v-model="checkboxes.option2">承諾します：</div>            
              <div class="col-9">サンプル染色（1点から可）のご依頼は、別途お見積りをご提示させていただきます。ご希望のお客様は、お問い合わせ時にお申し付けください。</div>
            </label>
          </div>
        </li>
        <li>
          <div class ="form-check d-flex pb-2">
            <label for="checkbox3" class="label d-flex w-100 align-items-center">
              <div class="col-3"><input type="checkbox" id="checkbox3" v-model="checkboxes.option3">承諾します：</div>
              <div class="col-9">ボタンやファスナーは、染色・加工時劣化する恐れがございます。ご心配な場合には、事前に取り外してくださいますようお願いいたします。</div>
            </label>
          </div>
        </li>
        <li>
          <div class ="form-check d-flex pb-2">
            <label for="checkbox4" class="label d-flex w-100 align-items-center">
              <div class="col-3"><input type="checkbox" id="checkbox4" v-model="checkboxes.option4">承諾します：</div>
              <div class="col-9">裏生地の付いている衣類は、縮率の違いにより型崩れが発生する可能性がございます。</div>
            </label>
          </div>
        </li>
        <li>
          <div class ="form-check d-flex pb-2">
            <label for="checkbox5" class="label d-flex w-100 align-items-center">
              <div class="col-3"><input type="checkbox" id="checkbox5" v-model="checkboxes.option5">承諾します：</div>
              <div class="col-9">生地に撥水などの特別な加工がしてある場合、部分的に染ムラが出る場合がございます。</div>
            </label>
          </div>
        </li>
        <li>
          <div class ="form-check d-flex pb-2">
            <label for="checkbox6" class="label d-flex w-100 align-items-center">
              <div class="col-3"><input type="checkbox" id="checkbox6" v-model="checkboxes.option6">承諾します：</div>
              <div class="col-9">皮は極端に縮みます。ご依頼物に皮が付属していないかなど、事前によくご確認ください。</div>
            </label>
          </div>
        </li>
        <li>
          <div class ="form-check d-flex pb-2">
            <label for="checkbox7" class="label d-flex w-100 align-items-center">
              <div class="col-3"><input type="checkbox" id="checkbox7" v-model="checkboxes.option7">承諾します：</div>
              <div class="col-9">縫い糸にポリエステルが使用されている場合がございます。混合のポリエステルは染まりませんのでご注意ください。</div>
            </label>
          </div>
        </li>
        <li>
          <div class ="form-check d-flex pb-2">
            <label for="checkbox8" class="label d-flex w-100 y-60 align-items-center">
              <div class="col-3"><input type="checkbox" id="checkbox8" v-model="checkboxes.option8">承諾します：</div>
              <div class="col-9">染められるものは、紺色か黒色のみとなっており、単色染めに限らせていただきます。</div>
            </label>
          </div>
        </li>
        <li>
          <div class ="form-check d-flex pb-2">
            <label for="checkbox9" class="label d-flex w-100 y-60 align-items-center">
              <div class="col-3"><input type="checkbox" id="checkbox9" v-model="checkboxes.option9">承諾します：</div>
              <div class="col-9">糸の加工や生地の性質により、製品が縮む場合がございます。</div>
            </label>
          </div>
        </li>
        <li>
          <div class ="form-check d-flex pb-2">
            <label for="checkbox10" class="label d-flex w-100 align-items-center">
              <div class="col-3"><input type="checkbox" id="checkbox10" v-model="checkboxes.option10">承諾します：</div>
              <div class="col-9">特にウール製品は極端に収縮率が高いです。依頼する場合はご注意ください。</div>
            </label>
          </div>
        </li>
        <li>
          <div class ="form-check d-flex pb-2">
            <label for="checkbox11" class="label d-flex w-100 align-items-center">
              <div class="col-3"><input type="checkbox" id="checkbox11" v-model="checkboxes.option11">承諾します：</div>
              <div class="col-9">丹念に洗濯をしてから、黒染め加工を行っておりますが、油染みが残っている染めムラが出てしまう場合がございます。</div>
            </label>
          </div>
        </li>
        <li>
          <div class ="form-check d-flex pb-2">
            <label for="checkbox12" class="label d-flex w-100 align-items-center">
              <div class="col-3"><input type="checkbox" id="checkbox12" v-model="checkboxes.option12">承諾します：</div>
              <div class="col-9">素材が集まり次第、加工を行うので、納期が伸びる場合がございます。ご了承ください。</div>
            </label>
          </div>
        </li>
        <li>
          <div class ="form-check d-flex pb-2">
            <label for="checkbox13" class="label d-flex w-100 align-items-center">
              <div class="col-3"><input type="checkbox" id="checkbox13" v-model="checkboxes.option13">承諾します：</div>
              <div class="col-9">品質表示タグが付いていない製品はお断りする場合がございます。</div>
            </label>
          </div>
        </li>
        <li>
          <div class ="form-check d-flex pb-2">
            <label for="checkbox14" class="label d-flex w-100 align-items-center">
              <div class="col-3"><input type="checkbox" id="checkbox14" v-model="checkboxes.option14">承諾します：</div>
              <div class="col-9">劣化や損傷が激しい製品はお断りする場合がございます。</div>
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

  </style>