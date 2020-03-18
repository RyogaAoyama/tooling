<template>
  <v-card>
    <my-gradient-image class="mb-3" xl="600" md="600" sm="500" :src="src">
      <v-card-title>
        <h1 class="pl-5 pb-5">{{ searchResult.name }}</h1>
      </v-card-title>
    </my-gradient-image>
    <div class="mb-12 px-xl-12 px-md-12 px-sm-12 px-1">
      <span>{{ searchResult.rating != "" ? searchResult.rating : 0.0 }}</span>
      <v-rating
        v-model="searchResult.rating"
        color="yellow darken-3"
        background-color="grey darken-1"
        empty-icon="$ratingFull"
        half-increments
        readonly
        dense
        small
        class="d-inline-block"
      ></v-rating>
      <span>({{ searchResult.user_ratings_total != "" ? searchResult.user_ratings_total : 0 }})</span>
      <v-chip x-small color="green" text-color="white" v-show="isRegist">訪問済み</v-chip>
    </div>
    <div class="px-xl-12 px-md-12 px-sm-12 px-1 pb-12">
      <my-picture-section class="mb-12" :searchResult="searchResult"></my-picture-section>
      <my-review-section class="mb-12" :searchResult="searchResult"></my-review-section>
      <my-address-section :searchResult="searchResult"></my-address-section>
      <div class="text-center" v-if="isRegist">
        <v-btn rounded color="#1FAB89" class="white--text" large disabled>登録済み</v-btn>
      </div>
      <div class="text-center" v-else>
        <v-btn
          rounded
          color="#1FAB89"
          class="white--text"
          large
          @click="create"
          :disabled="isLoading"
          :loading="isLoading"
        >ここに行く</v-btn>
      </div>
    </div>
  </v-card>
</template>

<script>
import GradientImage from "./../atoms/gradientImage.vue";
import PicutureSection from "./../organisms/pictureSection.vue";
import ReviewSection from "./../organisms/reviewSection.vue";
import AddressSection from "./../organisms/addressSection.vue";
import { mapState } from "vuex";
import { createNamespacedHelpers } from "vuex";

const { mapActions: mapActionsOfDestination } = createNamespacedHelpers(
  "Destination"
);

export default {
  props: ["searchResult", "isRegist"],
  data: function() {
    return {
      src: "",
      isLoading: false
    };
  },
  components: {
    "my-gradient-image": GradientImage,
    "my-picture-section": PicutureSection,
    "my-review-section": ReviewSection,
    "my-address-section": AddressSection
  },
  methods: {
    ...mapActionsOfDestination(["createDestination"]),
    create_photo_url() {
      if (this.searchResult["photos"].length == 0) {
        this.src = "/not_image.svg";
        return;
      }
      this.src =
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&key=" +
        gon.GOOGLE_API_KEY +
        "&photoreference=" +
        this.searchResult["photos"][0]["photo_reference"];
    },
    async create() {
      let send = { destination: {} };
      let result = this.searchResult;

      send.destination.place_id = result.place_id;
      send.destination.name = result.name;
      send.destination.picture = this.src;
      send.destination.address = result.address;
      send.destination.review_rank = result.rating == "" ? 0 : result.rating;
      send.destination.review_num =
        result.user_ratings_total == "" ? 0 : result.user_ratings_total;
      send.destination.lat = result.lat;
      send.destination.lng = result.lng;
      send.destination.is_visit = false;
      this.isLoading = true;
      let responseCode = await this.createDestination(send);
      this.isLoading = false;
      if (responseCode == 201) {
        this.$router.push("/destination/index");
      }
    }
  },
  created() {
    this.create_photo_url();
  }
};
</script>

<style></style>
