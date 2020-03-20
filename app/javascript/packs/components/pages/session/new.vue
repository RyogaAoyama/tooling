<template>
  <v-app class="teal lighten-3">
    <v-row align="center" justify="center">
      <my-login-form :isLoading="isLoading" :error="error" @onlogin="onlogin"></my-login-form>
    </v-row>
  </v-app>
</template>

<script>
import LoginForm from "./../../organisms/loginForm.vue";
import { createNamespacedHelpers, mapActions } from "vuex";

const { mapActions: mapActionsOfSession } = createNamespacedHelpers("Session");

const { mapMutations: mapMutationsOfAccount } = createNamespacedHelpers(
  "Account"
);

const { mapMutations: mapMutationsOfAlert } = createNamespacedHelpers("Alert");

export default {
  data: function() {
    return {
      isLoading: false,
      error: ""
    };
  },
  components: {
    "my-login-form": LoginForm
  },
  methods: {
    ...mapActionsOfSession(["login"]),
    ...mapMutationsOfAccount(["setUser"]),
    ...mapMutationsOfAlert(["setType", "setIsShow", "setMsg"]),
    async onlogin(e) {
      this.isLoading = true;

      let data = await this.login(e);
      if (data.result == 1) {
        this.error = data.error;
      }

      this.isLoading = false;
    }
  }
};
</script>

<style>
</style>