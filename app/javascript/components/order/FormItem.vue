<template>
  <div class="form-group col-10">
    <label :for="`order-${name}`">{{ value }}</label>
    <slot name="input"></slot>
    
  </div>

</template>

<script>

export default {
  props: {
    name: {
      type: String,
      default: ''
    },
    value: {
      type: String,
      default: ''
    }
  }
}
</script>