<template>
  <div class="wrap">
    <v-img :src="src" class="opacity-image"></v-img>
    <div class="image-on-center">
      <slot></slot>
    </div>
  </div>
</template>

<script>
export default {
  props: ["src"]
};
</script>

<style>
.opacity-image {
  opacity: 0.5;
}

.wrap {
}

.image-on-center {
  position: absolute;
  top: 50%;
  left: 50%;
  -ms-transform: translate(-50%, -50%);
  -webkit-transform: translate(-50%, -50%);
  transform: translate(-50%, -50%);
  margin: 0;
  padding: 0;
}
</style>
