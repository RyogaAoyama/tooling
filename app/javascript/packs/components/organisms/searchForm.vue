<template>
  <v-col lg="4" md="6" sm="10" col="12">
    <v-card class="pa-10">
      <h1 class="center mb-2">ツーリング先を見つける</h1>
      <form>
        <v-row>
          <v-col cols="12">
            <div class="sub-header">到着時間</div>
            <v-select label="到着時間を選択" :items="arrivalTimes" v-model="form.search.arrivalTime" solo></v-select>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12">
            <div class="sub-header">場所</div>
            <v-select
              label="場所を選択"
              :items="towns"
              item-text="town_name"
              item-value="town_id"
              v-model="form.search.town"
              solo
            ></v-select>
          </v-col>
        </v-row>
        <div class="text-center">
          <v-btn
            rounded
            class="white--text"
            color="#1FAB89"
            @click="search"
            :disabled="isLoading"
            :loading="isLoading"
            large
          >検索する</v-btn>
        </div>
      </form>
    </v-card>
  </v-col>
</template>

<script>
import Repository from "./../../repository.js";
import Geolocation from "./../../modules/geolocation.js";
export default {
  props: ["towns", "arrivalTimes"],
  data: function() {
    return {
      form: {
        search: {
          arrivalTime: "",
          town: "",
          position: ""
        }
      },
      searchResultMsg: "",
      isLoading: false
    };
  },
  methods: {
    async setPosition() {
      this.form.search.position = await Geolocation.getCurrentPosition();
    },
    async search() {
      this.$store.commit("changeSearchStatus", 2);
      // 検索中はボタンを無効化
      this.isLoading = true;

      // 現在地をセット
      await this.setPosition();
      console.log(this.form);

      // 検索
      await this.$store.dispatch("search", this.form);

      // 検索終了後ボタンを有効化
      this.isLoading = false;
    }
  }
};
</script>

<style>
.sub-header {
  font-weight: bold;
  color: rgba(0, 0, 0, 0.6);
  margin-bottom: 10px;
}
</style>
