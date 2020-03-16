<template>
  <div>
    <my-icon-text iconName="mdi-home-city" size="25" class="mb-8">場所</my-icon-text>
    <div
      v-show="searchResult.address != ''"
    >住所：{{ searchResult.address == "" ? "住所が登録されていません" : searchResult.address }}</div>
    <div class="d-inline-block">現在地からの所要時間：{{ searchResult.rows[0].elements[0].duration.text }}</div>
    <div class="mb-5">現在地からの距離：{{ searchResult.rows[0].elements[0].distance.text }}</div>
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
