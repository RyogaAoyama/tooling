<template>
  <v-app>
    <my-mask-image class="mb-xl-12 mb-md-12 mb-sm-12 mb-0" xl="750" md="750" sm="750"></my-mask-image>
    <my-search-form
      class="serach-form-position"
      :towns="towns"
      :arrivalTimes="arrivalTimes"
      :isLoading="isLoading"
      @search="search"
    ></my-search-form>
    <v-container>
      <my-icon-text size="35" iconName="mdi-magnify" class="mb-12">検索結果</my-icon-text>
      <my-opacity-image src="/search_not.svg" v-if="searchStatus == 1">
        <h2>検索してみましょう</h2>
      </my-opacity-image>
      <v-progress-circular indeterminate color="green" v-else-if="searchStatus == 2"></v-progress-circular>
      <my-search-result
        :searchResult="SearchResult"
        v-else-if="searchStatus == 3"
        :isRegist="isRegist"
      ></my-search-result>
      <my-opacity-image src="/search_error.svg" v-else-if="searchStatus == 4">
        <h2>{{ searchResultMsg }}</h2>
      </my-opacity-image>
    </v-container>
  </v-app>
</template>

<script>
import MaskImage from "./../../atoms/maskImage.vue";
import SearchForm from "./../../organisms/searchForm.vue";
import SearchResult from "./../../organisms/searchResult.vue";
import IconText from "./../../molecules/iconText.vue";
import OpacityImage from "./../../atoms/opacityImage.vue";
import { RepositoryFactory } from "./../../../factories/repositoryFactory.js";
import Geolocation from "./../../../modules/geolocation.js";
import { createNamespacedHelpers } from "vuex";
import { mapActions } from "vuex";

const { mapState: mapStateOfSession } = createNamespacedHelpers("Session");

const {
  mapActions: mapActionsOfAccount,
  mapState: mapStateOfAccount
} = createNamespacedHelpers("Account");

const { mapActions: mapActionsOfDestination } = createNamespacedHelpers(
  "Destination"
);

const UsersRepository = RepositoryFactory.get("users");

export default {
  components: {
    "my-mask-image": MaskImage,
    "my-search-form": SearchForm,
    "my-icon-text": IconText,
    "my-search-result": SearchResult,
    "my-opacity-image": OpacityImage
  },

  ////////////////////////////////////////////////////////////////////////////

  data: function() {
    return {
      arrivalTimes: [],
      SearchResult: {},
      searchStatus: 1,
      searchResultMsg: "",
      isLoading: false,
      isRegist: false,
      isVisit: false,
      towns: []
    };
  },

  ////////////////////////////////////////////////////////////////////////////

  async created() {
    let data = await this.getAllTown();
    for (let town of data.towns) {
      this.towns.push(town);
    }
    this.createArrivalTime();
    this.get();
  },

  ////////////////////////////////////////////////////////////////////////////

  computed: {
    ...mapStateOfSession(["id"]),
    ...mapStateOfAccount(["user"])
  },

  ////////////////////////////////////////////////////////////////////////////

  methods: {
    ...mapActionsOfAccount(["getUser"]),
    ...mapActions(["getAllTown"]),
    ...mapActionsOfDestination(["getAllDestination"]),

    // 到着時間のセレクトボックスにデータを格納するメソッド
    createArrivalTime() {
      // 上限到着時間(分)
      const MAX_MINUTE = 340;
      for (let countMinute = 30; countMinute <= MAX_MINUTE; countMinute += 30) {
        let hour = Math.floor(countMinute / 60);
        let minute = ("00" + (countMinute - hour * 60)).slice(-2);
        let second = countMinute * 60;

        // 到着時間のデータ
        let option = {
          text: `${hour}時間${minute}分`,
          value: second
        };

        // 到着時間を格納
        this.arrivalTimes.push(option);
      }
    },

    ////////////////////////////////////////////////////////////////////////////

    async get() {
      await this.getUser();
    },

    ////////////////////////////////////////////////////////////////////////////

    async search(e) {
      this.searchStatus = 2;
      // 検索中はボタンを無効化
      this.isLoading = true;

      // 現在地をセット
      e.search.position = await Geolocation.getCurrentPosition();

      if (e.search.town == 0 || e.search.town == undefined) {
        e.search.town = this.user.town_id;
      }
      let data = {};
      let result = 0;
      // 検索
      [result, data] = await this.$store.dispatch("search", e);
      await this.setDestinationStatus(data.result.place_id);

      if (result == 0) {
        if (data.result["name"] == "") {
          this.searchResultMsg = "条件に該当する行き先が見つかりませんでした。";
          this.searchStatus = 4;
        } else {
          this.SearchResult = data.result;
          this.searchStatus = 3;
        }
      } else if (result == 400) {
        this.searchResultMsg =
          "ネットワークエラーが発生しました。ネットワークの接続を確認してください。";
        this.searchStatus = 4;
      } else if (result == 500) {
        this.searchResultMsg =
          "内部でエラーが発生しました。時間を置いて再度お試しください。";
        this.searchStatus = 4;
      } else {
        this.searchResultMsg =
          "予期せぬエラーが発生しました。システム管理者までご連絡ください。";
        this.searchStatus = 4;
      }

      // 検索終了後ボタンを有効化
      this.isLoading = false;
    },

    ////////////////////////////////////////////////////////////////////////////

    async setDestinationStatus(place_id) {
      let data = await this.getAllDestination();
      if (data == undefined) {
        return;
      }

      for (let destination of data.destinations) {
        if (destination.place_id == place_id) {
          this.isVisit = destination.is_visit;
          this.isRegist = true;
        }
      }
    }
  }
};
</script>

<style>
.serach-form-position {
  position: absolute;
  left: 5%;
  top: 150px;
}

@media screen and (max-width: 599px) {
  .serach-form-position {
    position: static;
    left: 0;
    top: 0;
    padding: 0;
    margin-bottom: 48px;
  }
}
</style>
