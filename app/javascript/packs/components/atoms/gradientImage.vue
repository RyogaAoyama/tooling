<template>
  <v-img
    gradient="rgba(0,0,0,.0), rgba(0,0,0,.5)"
    :src="src"
    class="white--text align-end"
    :height="height"
  >
    <slot></slot>
  </v-img>
</template>

<script>
import ResponsiveModule from "./../../modules/responsive.js";
export default {
  data: function() {
    return {
      height: ""
    };
  },
  props: ["src"],
  mixins: [ResponsiveModule]
};
</script>

<style></style>
