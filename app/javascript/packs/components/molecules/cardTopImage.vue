<template>
  <v-card class="mx-auto" max-width="450">
    <v-img class="white--text align-end" height="350px" :src="src"></v-img>
    <div class="px-5 pb-5">
      <slot></slot>
    </div>
  </v-card>
</template>

<script>
export default {
  props: ["src", "width"]
};
</script>

<style>
</style>