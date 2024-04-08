<template>
  <div>
    <p>ご依頼内容</p>
    <table class="categories-table">
      <tr>
        <th>衣類選択</th>
        <th>単価</th>
      </tr>
      <tr v-for="(item, index) in selected" :key="`selected_${index}`">
        <td>
          <select v-model="selected[index].id" @change="() => updatePrice(index)">
            <option disabled value=""></option>
            <option v-for="category in categories" :key="category.id" :value="category.id">
              {{ category.name }}
            </option>
          </select>
        </td>
        <td>
          <a>{{ selected[index].price }}</a>
        </td>

      </tr>
    </table>
  </div>
  <button @click="increment" class="btn btn-outline-primary">+</button>
  <button @click="decrement" class="btn btn-outline-primary">-</button>
  <div>
    合計{{ totalPrice }}円
  </div>
</template>

<script>
export default {
  props: {
    initialData: {
      type: Object,
      default: () => { }
    }
  },
  data() {
    return {
      selected: [
        {
          id: null,
          name: "",
          price: 0,
        },
      ],
      categories: this.initialData.categories,
    };
  },
  methods: {
    increment() {
      this.selected.push({
        id: null,
        name: "",
        price: 0
      });
    },
    decrement() {
      if (this.selected.length === 1) return;
      this.selected.pop();
    },
    updatePrice(index) {
      const selectedCategory = this.categories.find(category => category.id === this.selected[index].id);
      if (selectedCategory) {
        this.selected[index].name = selectedCategory.name;
        this.selected[index].price = selectedCategory.price;
      }
    }
  },
  computed: {
    totalPrice() {
      // 選択された商品の合計金額を計算
      return this.selected.reduce((acc, item) => acc + item.price, 0);
    },
  },
};
</script>

<style scoped></style>