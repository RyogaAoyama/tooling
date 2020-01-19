<template>
  <v-col lg="4" md="6" sm="10" col="12">
    <v-card class="pa-10">
      <h1 class="center mb-2">ツーリング先を見つける</h1>
      <form>
        <v-row>
          <v-col cols="6">
            <div class="sub-header">到着時間</div>
            <v-select label="到着時間を選択" :items="arrivalTimes" v-model="form.search.arrivalTime" solo></v-select>
          </v-col>
          <v-col cols="6">
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
        <div class="sub-header">ルート</div>
        <v-radio-group v-model="form.search.route">
          <v-radio label="無料区間ルートで検索" value="0"></v-radio>
          <v-radio label="最短ルートで検索" value="1"></v-radio>
        </v-radio-group>
        <div class="text-center">
          <v-btn rounded color="#1FAB89" dark @click="search" :disabled="searchDisable">検索する</v-btn>
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
          route: "0",
          position: ""
        }
      },
      searchDisable: false
    };
  },
  methods: {
    async setPosition() {
      this.form.search.position = await Geolocation.getCurrentPosition();
    },
    async search() {
      // 検索中はボタンを無効化
      this.searchDisable = true;

      // 現在地をセット
      await this.setPosition();
      console.log(this.form);

      // 検索
      Repository.post("/search", this.form)
        .then(res => {
          // TODO: なんかの処理（まだなんの処理すればええかわからん）
          console.log(res);
        })
        .catch(err => {
          console.log(err);
        });

      // 検索終了後ボタンを有効化
      this.searchDisable = false;
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
