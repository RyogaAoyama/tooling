<template>
<div>

  <h1>メールアドレス編集</h1>
  <v-divider></v-divider>
  <my-space size="20"></my-space>

  <v-row>
    <v-col lg="3" md="12" sm="12" cols="12">
      <h3>パスワード</h3>
    </v-col>

    <v-col lg="9" md="12" sm="12" cols="12">
      <v-text-field
        placeholder="パスワード"
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
      <h3>メールアドレス</h3>
    </v-col>

    <v-col lg="9" md="12" sm="12" cols="12">
      <v-text-field
        placeholder="メールアドレス"
        solo
        v-model="form.user.email"
      ></v-text-field>
      <div class="red--text">&nbsp;{{ errors.email }}</div>
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
import { createNamespacedHelpers, mapMutations } from "vuex";

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
          email: ""
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
      if (this.emailFormValid()) {
        this.$emit("update", this.form);
      }
    },
    emailFormValid() {
      let results = {};
      let errors = {};

      // 検証
      [results.email, errors.email] =
        Valid.emailValid(this.form.user.email);
      [results.authenticate,　errors.authenticate] =
        Valid.passwordValid(this.form.auth.authenticate);

      // エラーメッセージをセット
      for (let key in errors) {
        this.$set(this.errors, key, errors[key]);
      }

      // 全てのバリデーションが成功しているか真偽値で返却
      return Object.values(results).every((val) => val);
    },
  },
  created() {
    this.form.user.email = this.user.email;
  }
}
</script>

<style>

</style>