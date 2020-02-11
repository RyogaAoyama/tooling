<template>
  <v-app class="teal lighten-3">
    <v-row align="center" justify="center">
      <my-account-form></my-account-form>
    </v-row>
  </v-app>
</template>

<script>
import AccountForm from "./../../organisms/accountForm.vue";
export default {
  components: {
    "my-account-form": AccountForm
  }
};
</script>

<style>
</style>