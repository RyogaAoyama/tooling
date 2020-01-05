<template>
  <div>
    <v-img
      src="/tooling.jpg"
      gradient="rgba(0,0,0,.3), rgba(0,0,0,.3)"
      width="100%"
      :height="height"
    ></v-img>
  </div>
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
