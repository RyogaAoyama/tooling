<template>
  <div>
    <v-icon :size="size" :style="{ 'vertical-align': 'text-bottom' }">{{
      iconName
    }}</v-icon>
    <span :style="{ 'font-size': size + 'px' }"><slot></slot></span>
  </div>
</template>

<script>
export default {
  props: ["size", "iconName"]
};
</script>

<style></style>
