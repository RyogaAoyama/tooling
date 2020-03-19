<template>
  <v-app class="teal lighten-3">
    <v-row align="center" justify="center">
      <my-account-form
        :towns="towns"
        :isLoading="isLoading"
        :errors="errors"
        @oncreate="userCreate"
      ></my-account-form>
    </v-row>
  </v-app>
</template>

<script>
import AccountForm from "./../../organisms/accountForm.vue";
import { createNamespacedHelpers } from "vuex";
import { mapState } from "vuex";
import { mapActions } from "vuex";

const { mapActions: mapActionsOfAccount } = createNamespacedHelpers("Account");

const {
  mapActions: mapActionsOfSession,
  mapMutations: mapMutationsOfSession
} = createNamespacedHelpers("Session");

const { mapActions: mapActionsOfAlert } = createNamespacedHelpers("Alert");

export default {
  data: function() {
    return {
      isLoading: false,
      errors: {},
      towns: []
    };
  },
  components: {
    "my-account-form": AccountForm
  },
  async created() {
    let data = await this.getAllTown();
    for (let town of data.towns) {
      this.towns.push(town);
    }
  },
  methods: {
    ...mapActionsOfAccount(["create"]),
    ...mapActionsOfSession(["login"]),
    ...mapMutationsOfSession(["setId", "setToken"]),
    ...mapActionsOfAlert(["setAlert"]),
    ...mapActions(["getAllTown"]),
    async userCreate(e) {
      // ロード開始
      this.isLoading = true;

      // アカウント作成
      let data = await this.create(e);

      // ロード終了
      this.isLoading = false;

      // 完了メッセージを出力
      if (data.result == 0) {
        await this.setId(data.id);
        await this.setToken(data.token);

        this.setAlert({
          msg: "アカウントを作成しました。サービスをお楽しみください！",
          type: "success"
        });

        // 画面遷移
        this.$router.push("/search").catch(e => {});
      } else if (data.result == 1) {
        // エラーメッセージをセット
        for (let key in data.errors) {
          this.$set(this.errors, key, data.errors[key]);
        }
      }
    }
  }
};
</script>

<style>
</style>