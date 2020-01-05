<template>
  <v-app>
    <my-mask-image
      class="mb-xl-12 mb-md-12 mb-sm-12 mb-0"
      xl="750"
      md="750"
      sm="750"
    ></my-mask-image>
    <my-search-form class="serach-form-position"></my-search-form>
    <v-container>
      <my-icon-text size="35" iconName="mdi-magnify" class="mb-12">
        検索結果
      </my-icon-text>
      <my-search-result></my-search-result>
    </v-container>
  </v-app>
</template>

<script>
import MaskImage from "./../../atoms/maskImage.vue";
import SearchForm from "./../../organisms/searchForm.vue";
import SearchResult from "./../../organisms/searchResult.vue";
import IconText from "./../../molecules/iconText.vue";
export default {
  components: {
    "my-mask-image": MaskImage,
    "my-search-form": SearchForm,
    "my-search-result": SearchResult,
    "my-icon-text": IconText
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
