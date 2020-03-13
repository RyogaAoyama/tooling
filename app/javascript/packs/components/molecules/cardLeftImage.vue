<template>
  <v-card class="mx-auto" :max-width="width">
    <v-row>
      <v-col cols="6" class="pa-0">
        <v-img class="white--text align-end" width="100%" :height="imgHeight" :src="src"></v-img>
      </v-col>
      <v-col cols="6">
        <slot></slot>
      </v-col>
    </v-row>
  </v-card>
</template>

<script>
export default {
  props: ["src", "width", "imgHeight"]
};
</script>

<style>
</style>