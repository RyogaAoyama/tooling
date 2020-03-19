<template>
  <v-container class="mb-5">
    <my-space size="30"></my-space>
    <v-progress-circular indeterminate color="green" v-show="isLoading"></v-progress-circular>
    <v-card v-if="status == 3">
      <my-gradient-image class="mb-3" xl="600" md="600" sm="500" :src="src">
        <v-card-title>
          <h1 class="pl-5 pb-5">{{ destination.name }}</h1>
        </v-card-title>
      </my-gradient-image>
      <div class="mb-12 px-xl-12 px-md-12 px-sm-12 px-1">
        <span>{{ destination.rating }}</span>
        <v-rating
          v-model="destination.rating"
          color="yellow darken-3"
          background-color="grey darken-1"
          empty-icon="$ratingFull"
          half-increments
          readonly
          dense
          small
          class="d-inline-block"
        ></v-rating>
        <span>({{ destination.user_ratings_total }})</span>
        <v-chip x-small color="yellow" text-color="white">行ったことない</v-chip>
      </div>
      <div class="px-xl-12 px-md-12 px-sm-12 px-1 pb-12">
        <my-picture-section class="mb-12" :searchResult="destination"></my-picture-section>
        <my-review-section class="mb-12" :searchResult="destination"></my-review-section>
        <my-address-section :searchResult="destination" :positionOk="positionOk"></my-address-section>
      </div>
    </v-card>

    <div v-else-if="status == 4">
      <my-opacity-image src="/search_error.svg">
        <h2>{{ errorMsg }}</h2>
      </my-opacity-image>
    </div>
  </v-container>
</template>

<script>
import Geolocation from "./../../../modules/geolocation.js";
import OpacityImage from "./../../atoms/opacityImage.vue";
import PicutureSection from "./../../organisms/pictureSection.vue";
import ReviewSection from "./../../organisms/reviewSection";
import AddressSection from "./../../organisms/addressSection.vue";
import GradientImage from "./../../atoms/gradientImage.vue";
import Space from "./../../atoms/space.vue";
import { createNamespacedHelpers } from "vuex";

const { mapActions: mapActionsOfDestination } = createNamespacedHelpers(
  "Destination"
);

export default {
  components: {
    "my-opacity-image": OpacityImage,
    "my-gradient-image": GradientImage,
    "my-picture-section": PicutureSection,
    "my-review-section": ReviewSection,
    "my-address-section": AddressSection,
    "my-space": Space
  },

  ////////////////////////////////////////////////////////////////////////////

  data: function() {
    return {
      destination: {},
      isLoading: false,
      status: 0,
      src: "",
      positionOk: true
    };
  },

  ////////////////////////////////////////////////////////////////////////////

  async created() {
    // 現在地を取得
    this.isLoading = true;
    let position = {};
    [position, this.positionOk] = await Geolocation.getCurrentPosition();
    let query = "";
    if (this.positionOk) {
      query = `lat=${position.lat}&lng=${position.lng}`;
    }

    // 行き先を取得
    let [result, data] = await this.getFullDestination({
      id: this.$route.params.id,
      query
    });

    if (result == 200) {
      this.destination = data.result;
      this.create_photo_url();
      this.status = 3;
    } else if (result == 400) {
      this.errorMsg =
        "ネットワークエラーが発生しました。ネットワークの接続を確認してください。";
      this.status = 4;
    } else if (result == 404) {
      this.$router.push("/notfound").catch(e => {});
    } else if (result == 500) {
      this.errorMsg =
        "内部でエラーが発生しました。時間を置いて再度お試しください。";
      this.status = 4;
    } else {
      this.errorMsg =
        "予期せぬエラーが発生しました。システム管理者までご連絡ください。";
      this.status = 4;
    }
    this.isLoading = false;
  },

  ////////////////////////////////////////////////////////////////////////////

  methods: {
    ...mapActionsOfDestination(["getFullDestination"]),
    create_photo_url() {
      if (this.destination["photos"].length == 0) {
        this.src = "/not_image.svg";
        return;
      }
      this.src =
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&key=" +
        gon.GOOGLE_API_KEY +
        "&photoreference=" +
        this.destination["photos"][0]["photo_reference"];
    }
  }
};
</script>

<style>
</style>