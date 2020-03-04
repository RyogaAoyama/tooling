<template>
  <div>
    <my-icon-text iconName="mdi-home-city" size="25" class="mb-8">場所</my-icon-text>
    <div>住所：{{ searchResult.address }}</div>
    <div class="d-inline-block">所要時間：{{ searchResult.rows[0].elements[0].duration.text }}</div>
    <div class="mb-5">距離：{{ searchResult.rows[0].elements[0].distance.text }}</div>
    <my-google-map :searchResult="searchResult" class="mb-10"></my-google-map>
  </div>
</template>

<script>
import IconText from "./../molecules/iconText.vue";
import GoogleMap from "./googleMap.vue";
import { mapState } from "vuex";
export default {
  props: ["searchResult"],
  components: {
    "my-icon-text": IconText,
    "my-google-map": GoogleMap
  }
};
</script>

<style></style>
