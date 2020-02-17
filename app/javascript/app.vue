<template>
  <v-app id="app">
    <my-header></my-header>
    <my-alert></my-alert>
      <router-view />
  </v-app>
</template>

<script>
import Header from "./packs/components/molecules/header.vue";
import Alert from "./packs/components/organisms/alert.vue";
export default {
  components: {
    "my-header": Header,
    "my-alert": Alert
  }
};
</script>
