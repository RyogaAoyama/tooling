<template>
  <div id="app">
    <my-header></my-header>
    <v-container>
      <router-view />
    </v-container>
  </div>
</template>

<script>
import Header from "./packs/components/molecules/header.vue";
export default {
  components: {
    "my-header": Header
  }
};
</script>
