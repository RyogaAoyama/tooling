<template>
  <div>
    <h1>プロフィール編集</h1>
    <v-divider></v-divider>
    <my-space size="20"></my-space>

    <!-- <v-row>
      <v-col lg="3" md="12" sm="12" cols="12">
        <h3>プロフィール写真</h3>
      </v-col>

      <v-col lg="4" md="6" sm="6" cols="12">
        <div>
          <img src="" class="profile-img">
        </div>
      </v-col>

      <v-col lg="4" md="6" sm="6" cols="12">
        <v-file-input
        label="プロフィール画像を選択"
        filled
        accept="image/*"
        color="#1FAB89"
        width="100%"
        prepend-icon="mdi-camera"
        ></v-file-input>
        <div><small>写真の形式はjpeg, png, gifを選択してください。</small></div>
      </v-col>

      <v-col cols="12"><div class="red--text">&nbsp;時間なくて実装できてない...優先順位低め</div></v-col>
    </v-row>

    <my-space size="20"></my-space>
    <v-divider></v-divider>
    <my-space size="20"></my-space>-->

    <v-row>
      <v-col lg="3" md="12" sm="12" cols="12">
        <h3>ユーザー名</h3>
      </v-col>

      <v-col lg="9" md="12" sm="12" cols="12">
        <v-text-field v-model="form.user.name" placeholder="ユーザー名" solo></v-text-field>
        <div class="red--text">&nbsp;{{ errors.name }}</div>
      </v-col>
    </v-row>

    <my-space size="20"></my-space>
    <v-divider></v-divider>
    <my-space size="20"></my-space>

    <v-row>
      <v-col lg="3" md="12" sm="12" cols="12">
        <h3>お住いの都道府県</h3>
      </v-col>

      <v-col lg="9" md="12" sm="12" cols="12">
        <v-select
          label="お住いの都道府県を選択"
          :items="towns"
          item-text="town_name"
          item-value="town_id"
          v-model="form.user.town_id"
          solo
        ></v-select>
        <div class="red--text">&nbsp;{{ errors.town_id }}</div>
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
        <div>{{ form.user.email }}</div>
        <div>
          <a @click="emailChange">メールアドレスを変更</a>
        </div>
        <div class="red--text">&nbsp;</div>
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
import Dashboard from "./../molecules/dashboard.vue";
import Space from "./../atoms/space.vue";
import Valid from "./../../modules/validation.js";
import { createNamespacedHelpers, mapMutations } from "vuex";
import { mapActions } from "vuex";
import { mapState } from "vuex";

const {
  mapActions: mapActionsOfAccount,
  mapState: mapStateOfAccount,
  mapMutations: mapMutationsOfAccount
} = createNamespacedHelpers("Account");

export default {
  mixins: [Valid],
  components: {
    "my-dashboard": Dashboard,
    "my-space": Space
  },
  props: ["isLoading", "parentErrors"],
  data: function() {
    return {
      form: {
        user: {
          name: "",
          town_id: "",
          email: ""
        },
        auth: {
          is_authenticate: false
        }
      },
      errors: {},
      towns: []
    };
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
    ...mapActions(["getAllTown"]),
    ...mapActionsOfAccount(["update"]),
    emailChange() {
      this.$emit("emailChange");
    },
    async get() {
      let data = await this.getAllTown();
      for (let town of data.towns) {
        this.towns.push(town);
      }
      // フォームで使用するキーのみ取得
      for (let key in this.form.user) {
        this.form.user[key] = this.user[key];
      }
    },
    async update() {
      if (this.profileFormValid()) {
        this.$emit("update", this.form);
      }
    },
    profileFormValid() {
      let results = {};
      let errors = {};

      // 検証
      [results.name, errors.name] = Valid.userNameValid(this.form.user.name);
      [results.town_id, errors.town_id] = Valid.townIdValid(
        this.form.user.town_id
      );

      // エラーメッセージをセット
      for (let key in errors) {
        this.$set(this.errors, key, errors[key]);
      }

      // 全てのバリデーションが成功しているか真偽値で返却
      return Object.values(results).every(val => val);
    }
  },
  created() {
    this.get();
  }
};
</script>

<style>
.profile-img {
  width: 100%;
  height: 300px;
}
</style>