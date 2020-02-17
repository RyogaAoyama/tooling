<template>
  <v-app class="teal lighten-3">
    <v-row align="center" justify="center">
      <my-account-form :towns="towns" :isLoading="isLoading" @oncreate="userCreate"></my-account-form>
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
  mapState: mapStateOfAlert,
  mapMutations: mapMutationsOfAlert
} = createNamespacedHelpers("Alert");

export default {
  data: function() {
    return {
      isLoading: false
    };
  },
  components: {
    "my-account-form": AccountForm
  },
  created() {
    this.$store.dispatch("getAllTown");
  },
  methods: {
    ...mapMutationsOfAlert(["setType", "setIsShow", "setMsg"]),
    ...mapActionsOfAccount(["create"]),
    async userCreate(e) {
      
      // ロード開始
      this.isLoading = true;

      // アカウント作成
      let result = await this.create(e);

      // ロード終了
      this.isLoading = false;



      // 完了メッセージを出力
      console.log(result);
      if (result == 0) {
        this.setIsShow(true);
        this.setMsg("アカウント作成が完了しました。");
        this.setType("success");
        // 画面遷移
        this.$router.push("/search");
      } else if (result == 1) {
        // 処理なし
      } else if (result == 400) {
        this.setIsShow(true);
        this.setMsg("ネットワークエラーが発生しました。ネットワークの接続を確認してください。");
        this.setType("error");
      } else if (result == 500) {
        this.setIsShow(true);
        this.setMsg("内部でエラーが発生しました。時間を置いて再度お試しください。");
        this.setType("error");
      } else {
        this.setIsShow(true);
        this.setMsg("予期せぬエラーが発生しました。システム管理者までご連絡ください。");
        this.setType("error");
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