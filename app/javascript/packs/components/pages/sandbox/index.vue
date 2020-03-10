<template>
  <v-container>
    <my-card-top-image><h1>test</h1></my-card-top-image>
  </v-container>
</template>

<script>
import OpacityImage from "./../../atoms/opacityImage.vue";
import GoogleMap from "./../../organisms/googleMap.vue";
import Dashboard from "./../../molecules/dashboard.vue";
import CardTopImage from "./../../organisms/destination.vue"
export default {
  components: {
    "my-opacity-image": OpacityImage,
    "my-google-map": GoogleMap,
    "my-dashboard": Dashboard,
    "my-card-top-image": CardTopImage
  }
};
</script>

<style></style>
