<template>
  <!-- TODO: srcをコンポーネント使用側から指定できるようにする -->
  <v-img
    gradient="rgba(0,0,0,.0), rgba(0,0,0,.5)"
    src="/rasyoumon.jpg"
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
  mixins: [ResponsiveModule]
};
</script>

<style></style>
