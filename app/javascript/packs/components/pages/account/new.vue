<template>
  <v-app class="teal lighten-3">
    <v-row align="center" justify="center">
      <my-account-form :towns="towns" :isLoading="isLoading" :errors="errors" @oncreate="userCreate"></my-account-form>
    </v-row>
  </v-app>
</template>

<script>
import AccountForm from "./../../organisms/accountForm.vue";
import { createNamespacedHelpers } from "vuex";
import { mapState } from "vuex";

const {
  mapActions: mapActionsOfAccount
} = createNamespacedHelpers("Account");

const {
  mapActions: mapActionsOfSession,
  mapMutations: mapMutationsOfSession
} = createNamespacedHelpers("Session");

const {
  mapActions: mapActionsOfAlert
} = createNamespacedHelpers("Alert");

export default {
  data: function() {
    return {
      isLoading: false,
      errors: {}
    };
  },
  components: {
    "my-account-form": AccountForm
  },
  created() {
    this.$store.dispatch("getAllTown");
  },
  methods: {
    ...mapActionsOfAccount(["create"]),
    ...mapActionsOfSession(["login"]),
    ...mapMutationsOfSession(["setId"]),
    ...mapActionsOfAlert(["setAlert"]),
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

        this.setAlert({ msg: "アカウントを作成しました。サービスをお楽しみください！", type: "success" });

        // 画面遷移
        this.$router.push("/search");
      } else if(data.reuslt == 1) {
        // エラーメッセージをセット
        for (let key in data.errors) {
          this.$set(this.errors, key, data.errors[key]);
        }
      }
    }
  },
  computed: {
    ...mapState(["towns"])
  }
};
</script>

<style>
</style>