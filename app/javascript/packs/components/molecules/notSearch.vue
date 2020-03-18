<template>
  <div>
    <my-opacity-image src="/search_not.svg">
      <h2>見つかりませんでした</h2>
    </my-opacity-image>
  </div>
</template>

<script>
import OpacityImage from "./../atoms/opacityImage.vue";
export default {
  components: {
    "my-opacity-image": OpacityImage
  }
};

<style></style>;
