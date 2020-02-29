<template>
  <v-container>
    <h1>test</h1>
  </v-container>
</template>

<script>
import OpacityImage from "./../../atoms/opacityImage.vue";
import GoogleMap from "./../../organisms/googleMap.vue";
import Dashboard from "./../../molecules/dashboard.vue";
export default {
  components: {
    "my-opacity-image": OpacityImage,
    "my-google-map": GoogleMap,
    "my-dashboard": Dashboard
  },
  mounted() {
    alert("aaa");
  }
};
</script>

<style></style>
