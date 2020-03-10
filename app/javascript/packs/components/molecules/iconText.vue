<template>
  <div>
    <v-icon :size="iconSize" :style="{ 'vertical-align': 'text-bottom' }" :color="color">{{
      iconName
    }}</v-icon>
    <span :style="{ 'font-size': size + 'px', 'color': color }"><slot></slot></span>
  </div>
</template>

<script>
export default {
  props: ["size", "iconName", "color"],
  computed: {
    iconSize() {
      return parseInt(this.size) + 3;
    }
  }
};
</script>

<style></style>
