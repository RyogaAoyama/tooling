<template>
  <v-app id="app">
    <my-header></my-header>
    <router-view />
  </v-app>
</template>

<script>
import Header from "./packs/components/molecules/header.vue";
export default {
  components: {
    "my-header": Header
  }
};
</script>
