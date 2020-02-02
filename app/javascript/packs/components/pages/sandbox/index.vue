<template>
  <v-container>
    <my-google-map></my-google-map>
  </v-container>
</template>

<script>
import OpacityImage from "./../../atoms/opacityImage.vue";
import GoogleMap from "./../../organisms/googleMap.vue";
export default {
  components: {
    "my-opacity-image": OpacityImage,
    "my-google-map": GoogleMap
  }
};
</script>

<style></style>
