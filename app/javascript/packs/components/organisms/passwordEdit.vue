<template>
<div>

  <h1>パスワード編集</h1>
  <v-divider></v-divider>
  <my-space size="20"></my-space>

  <v-row>
    <v-col lg="3" md="12" sm="12" cols="12">
      <h3>古いパスワード</h3>
    </v-col>

    <v-col lg="9" md="12" sm="12" cols="12">
      <v-text-field
        placeholder="古いパスワード"
        solo
        v-model="form.auth.authenticate"
        type="password"
      ></v-text-field>
      <div class="red--text">&nbsp;{{ errors.authenticate }}</div>
    </v-col>
  </v-row>

  <my-space size="20"></my-space>
  <v-divider></v-divider>
  <my-space size="20"></my-space>

  <v-row>
    <v-col lg="3" md="12" sm="12" cols="12">
      <h3>新しいパスワード</h3>
    </v-col>

    <v-col lg="9" md="12" sm="12" cols="12">
      <v-text-field
        placeholder="新しいパスワード"
        solo
        v-model="form.user.password"
        type="password"
      ></v-text-field>
      <div class="red--text">&nbsp;{{ errors.password }}</div>
    </v-col>
  </v-row>

  <my-space size="20"></my-space>
  <v-divider></v-divider>
  <my-space size="20"></my-space>

  <v-row>
    <v-col lg="3" md="12" sm="12" cols="12">
      <h3>新しいパスワード(確認)</h3>
    </v-col>

    <v-col lg="9" md="12" sm="12" cols="12">
      <v-text-field
        placeholder="新しいパスワード(確認)"
        solo
        v-model="form.user.password_confirmation"
        type="password"
      ></v-text-field>
      <div class="red--text">&nbsp;{{ errors.password_confirmation }}</div>
    </v-col>
  </v-row>

    <my-space size="20"></my-space>
    <v-divider></v-divider>
    <my-space size="20"></my-space>

    <v-row justify="center">
      <v-col cols="1">
        <v-btn
          class="white--text"
          color="#1FAB89"
          large
          @click="update"
          :disabled="isLoading"
          :loading="isLoading"
        >保存</v-btn>
      </v-col>
    </v-row>
    <my-space size="40"></my-space>
</div>
</template>

<script>
import Space from "./../atoms/space.vue";
import Valid from "./../../modules/validation.js";
import { createNamespacedHelpers } from "vuex";

const {
  mapState: mapStateOfAccount,
  mapMutations: mapMutationsOfAccount
} = createNamespacedHelpers("Account");

export default {
  components: {
    "my-space": Space
  },
  props: ["isLoading", "parentErrors"],
  data: function() {
    return {
      form: {
        user: {
          password: "",
          password_confimation: ""
        },
        auth: {
          is_authenticate: true,
          authenticate: ""
        }
      },
      errors: {}
    }
  },
  computed: {
    ...mapStateOfAccount(["user"]),
    emailErrors() {
      // エラーメッセージをセット
      for (let key in this.parentErrors) {
        this.$set(this.errors, key, parentErrors[key]);
      }
    }
  },
  methods: {
    async update() {
      if (this.passwordFormValid()) {
        this.$emit("update", this.form);
      }
    },
    passwordFormValid() {
      let results = {};
      let errors = {};

      // 検証
      [results.authenticate,　errors.authenticate] =
        Valid.passwordValid(this.form.auth.authenticate);
      [results.password,　errors.password] =
        Valid.passwordValid(this.form.user.password);
      [results.password_confirmation, errors.password_confirmation] =
        Valid.confirmationValid(this.form.user.password, this.form.user.password_confirmation);

      // エラーメッセージをセット
      for (let key in errors) {
        this.$set(this.errors, key, errors[key]);
      }

      // 全てのバリデーションが成功しているか真偽値で返却
      return Object.values(results).every((val) => val);
    },
  }
}
</script>

<style>

</style>