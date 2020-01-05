<template>
  <div>
    <my-icon-text iconName="mdi-home-city" size="25" class="mb-8">
      場所
    </my-icon-text>
    <div>住所：岡山県岡山市中区中庄2-6</div>
    <div class="d-inline-block">
      所要時間：1時間30分
      <v-chip color="red" text-color="white" x-small>渋滞</v-chip>
    </div>
    <div>距離：120Km</div>
    <div class="mb-5">ここにGooglemap</div>
    <div class="text-center">
      <v-btn rounded color="#1FAB89" dark>ここに行く</v-btn>
    </div>
  </div>
</template>

<script>
import IconText from "./../molecules/iconText.vue";
export default {
  components: {
    "my-icon-text": IconText
  }
};
</script>

<style></style>
