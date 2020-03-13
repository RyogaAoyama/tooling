<template>
  <div>
    <my-visit-map>
      <my-card-left-image
        width="450"
        imgHeight="250"
        src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg"
      ></my-card-left-image>
    </my-visit-map>
  </div>
</template>

<script>
import OpacityImage from "./../../atoms/opacityImage.vue";
import GoogleMap from "./../../organisms/googleMap.vue";
import Dashboard from "./../../molecules/dashboard.vue";
import CardLeftImage from "./../../molecules/cardLeftImage.vue";
import VisitMap from "./../../organisms/visitMap.vue";

export default {
  components: {
    "my-opacity-image": OpacityImage,
    "my-google-map": GoogleMap,
    "my-dashboard": Dashboard,
    "my-card-left-image": CardLeftImage,
    "my-visit-map": VisitMap
  }
};
</script>

<style></style>
