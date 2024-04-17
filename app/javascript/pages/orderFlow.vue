<template>
  <component
    :is="currentComponent"
    :categories="initialData.categories"
    :selected="selected"
    :customer="customer"
    @change-component="changeComponent"
  >
  </component>
</template>

<script>
  import Order from '../components/order/new.vue'
  import Confirm from '../components/order/confirm.vue'
  import LastConfirm from '../components/order/lastConfirm.vue'

  export default {
    components: {
      Order,
      Confirm,
      LastConfirm
    },
    props: {
      initialData: {
        type: Object,
        default: () => {}
      }
    },
    data() {
      return {
        currentComponent: 'Order',
        selected: [],
        customer: {}
      }
    },
    methods: {
      changeComponent(data) {
        this.currentComponent = data.destination
        if (data.destination === 'Confirm') {
          this.selected = data.data
          this.customer = data.customer
        }
      }
    }
  }
</script>