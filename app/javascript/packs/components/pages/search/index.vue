<template>
  <v-app>
    <my-mask-image class="mb-xl-12 mb-md-12 mb-sm-12 mb-0" xl="750" md="750" sm="750"></my-mask-image>
    <my-search-form class="serach-form-position" :towns="towns" :arrivalTimes="arrivalTimes"></my-search-form>
    <v-container>
      <my-icon-text size="35" iconName="mdi-magnify" class="mb-12">検索結果</my-icon-text>
      <my-search-result></my-search-result>
    </v-container>
  </v-app>
</template>

<script>
import MaskImage from "./../../atoms/maskImage.vue";
import SearchForm from "./../../organisms/searchForm.vue";
import SearchResult from "./../../organisms/searchResult.vue";
import IconText from "./../../molecules/iconText.vue";
import { RepositoryFactory } from "./../../../factories/repositoryFactory.js";
import { mapState } from "vuex";

const TownsRepository = RepositoryFactory.get("towns");
export default {
  components: {
    "my-mask-image": MaskImage,
    "my-search-form": SearchForm,
    "my-search-result": SearchResult,
    "my-icon-text": IconText
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
      const MAX_MINUTE = 420;
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
    ...mapState(["towns"])
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
