<template>
  <div class="card-wrap">
    <v-card class="mx-auto center in-wrap">
      <div>
        <h1>Tooling</h1>
        <div>新たなる地を求めて走る</div>
      </div>
      <div>
        <div class="error-msg">&nbsp;{{ error }}</div>
        <v-text-field label="メールアドレス" v-model="form.user.email"></v-text-field>
        <v-text-field label="パスワード" v-model="form.user.password" type="password"></v-text-field>
        <div class="error-msg">&nbsp;</div>
      </div>
      <v-btn
        color="#1FAB89"
        class="mb-4 white--text"
        width="100%"
        @click="onlogin"
        :disabled="isLoading"
        :loading="isLoading"
      >ログイン</v-btn>
      <v-btn
        color="#1FAB89"
        class="mb-4 white--text"
        width="100%"
        @click="testlogin"
        :disabled="isLoading"
        :loading="isLoading"
        v-show="isDevelop"
      >すぐに利用する</v-btn>
      <div>
        <div>まだアカウントをお持ちでない方</div>
        <div>
          <a @click="$router.push('/account/new')">アカウント登録</a>
        </div>
      </div>
    </v-card>
  </div>
</template>

<script>
import { createNamespacedHelpers } from "vuex";
import { mapState } from "vuex";

const { mapMutations: mapMutationsOfSession } = createNamespacedHelpers(
  "Session"
);

export default {
  props: ["isLoading", "error"],
  data: function() {
    return {
      form: {
        user: {
          email: "",
          password: ""
        }
      }
    };
  },
  watch: {
    $route: function(to, from) {
      // エラーメッセージの初期化
      this.setSessionError("");
    }
  },
  methods: {
    ...mapMutationsOfSession(["setSessionError"]),
    onlogin() {
      this.$emit("onlogin", this.form);
    },
    testlogin() {
      this.form.user.email = "test@gmail.com";
      this.form.user.password = "password123";
      this.onlogin();
    }
  },
  computed: {
    ...mapState(["isDevelop"])
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