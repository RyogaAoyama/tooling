<template>
  <my-opacity-image src="/destination.svg">
    <v-row justify="center">
      <div class="center">
        <h2 class="mb-5">行き先を登録してみましょう！</h2>
        <v-btn color="#1FAB89" class="white--text" large @click="$router.push('/search')">行き先を見つける</v-btn>
      </div>
    </v-row>
  </my-opacity-image>
</template>

<script>
import OpacityImage from "./../atoms/opacityImage.vue";
export default {
  components: {
    "my-opacity-image": OpacityImage
  }
};
</script>

<style>
</style>