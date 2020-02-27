<template>
  <div class="card-wrap">
    <v-card class="mx-auto center in-wrap">
      <div>
        <h1>Tooling</h1>
        <div>新たなる地を求めて走る</div>
      </div>
      <div>
        <v-text-field label="ユーザー名" v-model="form.user.name"></v-text-field>
        <div class="error-msg">&nbsp;{{ errors.name }}</div>
        <v-text-field label="メールアドレス" v-model="form.user.email"></v-text-field>
        <div class="error-msg">&nbsp;{{ errors.email }}</div>
        <v-text-field label="パスワード" v-model="form.user.password" type="password"></v-text-field>
        <div class="error-msg">&nbsp;{{ errors.password }}</div>
        <v-text-field label="パスワード(確認)" v-model="form.user.password_confirmation" type="password"></v-text-field>
        <div class="error-msg mb-3">&nbsp;{{ errors.password_confirmation }}</div>
        <v-select
          label="お住いの都道府県を選択"
          :items="towns"
          item-text="town_name"
          item-value="town_id"
          v-model="form.user.town_id"
          solo
        ></v-select>
        <div class="error-msg mb-3">&nbsp;{{ errors.town_id }}</div>
      </div>
      <v-btn
        color="#1FAB89"
        class="mb-4 white--text"
        width="100%"
        @click="oncreate"
        :disabled="isLoading"
        :loading="isLoading"
      >アカウントを登録</v-btn>
      <div>
        <div>すでにアカウントをお持ちの方</div>
        <div>
          <a @click="$router.push('/login')">ログイン</a>
        </div>
      </div>
    </v-card>
  </div>
</template>

<script>
import Valid from "./../../modules/validation.js";
import { createNamespacedHelpers } from "vuex";

const { mapState: mapStateOfAccount } = createNamespacedHelpers("Account");
export default {
  props: ["towns", "isLoading", "errors"],
  data: function() {
    return {
      form: {
        user: {
          name: "",
          email: "",
          password: "",
          password_confirmation: "",
          town_id: ""
        }
      }
    }
  },
  mixins: [Valid],
  computed: {
    ...mapStateOfAccount(["user"]),
  },
  methods: {
    oncreate() {
      if (this.userFormValid()) {
        this.$emit("oncreate", this.form);
      }
    },
    userFormValid() {
      let results = {};
      let errors = {};

      // 検証
      [results.name, errors.name] =
        Valid.userNameValid(this.form.user.name);
      [results.email, errors.email] =
        Valid.emailValid(this.form.user.email);
      [results.password,　errors.password] =
        Valid.passwordValid(this.form.user.password);
      [results.password_confirmation, errors.password_confirmation] =
        Valid.confirmationValid(this.form.user.password, this.form.user.password_confirmation);
      [results.town_id, errors.town_id] =
        Valid.townIdValid(this.form.user.town_id);

      // エラーメッセージをセット
      for (let key in errors) {
        this.$set(this.errors, key, errors[key]);
      }

      // 全てのバリデーションが成功しているか真偽値で返却
      return Object.values(results).every((val) => val);
    }
  }
};
</script>

<style>
.center {
  text-align: center;
}

.in-wrap {
  padding: 80px 100px;
}

.error-msg {
  text-align: left;
  color: red;
}

a:link {
  color: #1fab89;
}

.card-wrap {
  width: 600px;
}
@media screen and (max-width: 1264px) {
  .card-wrap {
    width: 600px;
  }
}
@media screen and (max-width: 959px) {
  .card-wrap {
    width: 600px;
  }
}
@media screen and (max-width: 599px) {
  .card-wrap {
    width: 100%;
  }
}
</style>