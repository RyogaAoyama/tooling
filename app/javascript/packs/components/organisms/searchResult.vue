<template>
  <v-card>
    <my-gradient-image class="mb-3" xl="600" md="600" sm="500" :src="src">
      <v-card-title>
        <h1 class="pl-5 pb-5">{{ searchResult.name }}</h1>
      </v-card-title>
    </my-gradient-image>
    <div class="mb-12 px-xl-12 px-md-12 px-sm-12 px-1">
      <span>{{ searchResult.rating }}</span>
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
      <span>({{ searchResult.user_ratings_total }})</span>
      <v-chip x-small color="yellow" text-color="white">行ったことない</v-chip>
    </div>
    <div class="px-xl-12 px-md-12 px-sm-12 px-1 pb-12">
      <my-picture-section class="mb-12"></my-picture-section>
      <my-review-section class="mb-12"></my-review-section>
      <my-address-section></my-address-section>
    </div>
    <v-btn @click="test">test</v-btn>
  </v-card>
</template>

<script>
import GradientImage from "./../atoms/gradientImage.vue";
import PicutureSection from "./../organisms/pictureSection.vue";
import ReviewSection from "./../organisms/reviewSection.vue";
import AddressSection from "./../organisms/addressSection.vue";
import { mapState } from "vuex";
export default {
  data: function() {
    return {
      src: ""
    };
  },
  components: {
    "my-gradient-image": GradientImage,
    "my-picture-section": PicutureSection,
    "my-review-section": ReviewSection,
    "my-address-section": AddressSection
  },
  computed: {
    ...mapState(["searchResult"])
  },
  methods: {
    test() {
      console.log(this.searchResult);
      console.log(this.src);
    },
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
    }
  },
  created() {
    this.create_photo_url();
  }
};
</script>

<style></style>
