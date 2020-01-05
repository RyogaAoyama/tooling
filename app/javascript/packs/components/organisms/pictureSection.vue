<template>
  <div>
    <my-icon-text iconName="mdi-camera" size="25" class="mb-8">
      写真
    </my-icon-text>
    <my-carousel></my-carousel>
  </div>
</template>

<script>
import Carousel from "./../molecules/carousel.vue";
import IconText from "./../molecules/iconText.vue";
export default {
  components: {
    "my-carousel": Carousel,
    "my-icon-text": IconText
  }
};
</script>

<style></style>
