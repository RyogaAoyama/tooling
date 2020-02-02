<template>
  <v-app>
    <my-mask-image
      class="mb-xl-12 mb-md-12 mb-sm-12 mb-0"
      xl="750"
      md="750"
      sm="750"
    ></my-mask-image>
    <my-search-form
      class="serach-form-position"
      :towns="towns"
      :arrivalTimes="arrivalTimes"
    ></my-search-form>
    <v-container>
      <my-icon-text size="35" iconName="mdi-magnify" class="mb-12"
        >検索結果</my-icon-text
      >
      <my-opacity-image src="/search_not.svg" v-if="searchStatus == 1"
        >検索してみましょう</my-opacity-image
      >
      <v-progress-circular
        indeterminate
        color="green"
        v-else-if="searchStatus == 2"
      ></v-progress-circular>
      <my-search-result v-else-if="searchStatus == 3"></my-search-result>
      <my-opacity-image src="/search_error.svg" v-else-if="searchStatus == 4">
        {{ searchResultMsg }}
      </my-opacity-image>
    </v-container>
  </v-app>
</template>

<script>
// TODO: エラーごとに出力内容違うからそれの判定
// TODO: opacityImageの位置調整
import MaskImage from "./../../atoms/maskImage.vue";
import SearchForm from "./../../organisms/searchForm.vue";
import SearchResult from "./../../organisms/searchResult.vue";
import IconText from "./../../molecules/iconText.vue";
import OpacityImage from "./../../atoms/opacityImage.vue";
import { RepositoryFactory } from "./../../../factories/repositoryFactory.js";
import { mapState } from "vuex";

const TownsRepository = RepositoryFactory.get("towns");
export default {
  components: {
    "my-mask-image": MaskImage,
    "my-search-form": SearchForm,
    "my-icon-text": IconText,
    "my-search-result": SearchResult,
    "my-opacity-image": OpacityImage
  },
  data: function() {
    return {
      arrivalTimes: []
    };
  },
  async created() {
    this.$store.dispatch("getAllTown");
    this.createArrivalTime();
  },
  methods: {
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
    }
  },
  computed: {
    ...mapState(["towns", "searchStatus", "searchResultMsg"])
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
