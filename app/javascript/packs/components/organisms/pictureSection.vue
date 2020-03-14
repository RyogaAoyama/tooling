<template>
  <div>
    <my-icon-text iconName="mdi-camera" size="25" class="mb-8">写真</my-icon-text>

    <div v-if="searchResult.photos == ''">
      <my-opacity-image src="not_content.svg">
        <h2>写真はありません</h2>
      </my-opacity-image>
    </div>
    <my-carousel :srcs="srcs" v-else></my-carousel>
  </div>
</template>

<script>
import Carousel from "./../molecules/carousel.vue";
import IconText from "./../molecules/iconText.vue";
import OpacityImage from "./../atoms/opacityImage.vue";
import { mapState } from "vuex";
export default {
  data: function() {
    return {
      srcs: []
    };
  },
  props: ["searchResult"],
  components: {
    "my-carousel": Carousel,
    "my-icon-text": IconText,
    "my-opacity-image": OpacityImage
  },
  methods: {
    create_photo_url() {
      // もし写真がなかったら処理終了
      if (this.searchResult.photos == "") {
        return;
      }

      const BASE_URL =
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&key=" +
        gon.GOOGLE_API_KEY;

      // 写真のURLを発行(Gooogle APIから写真を取得するため)
      this.srcs = this.searchResult["photos"].map(
        val => BASE_URL + "&photoreference=" + val["photo_reference"]
      );

      // 写真が2枚以上あったら1枚目の写真は切り捨てる
      // 切り捨てる理由は1枚目の写真はヘッダー写真で使用するため
      if (this.srcs.length > 1) {
        this.srcs = this.srcs.slice(1, this.srcs.length);
      }
    }
  },
  created() {
    this.create_photo_url();
  }
};
</script>

<style></style>
