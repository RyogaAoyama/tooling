<template>
  <v-card>
    <my-gradient-image class="mb-3" xl="600" md="600" sm="500">
      <v-card-title>
        <h1 class="pl-5 pb-5">羅生門</h1>
      </v-card-title>
    </my-gradient-image>
    <div class="mb-12 px-xl-12 px-md-12 px-sm-12 px-1">
      <span>3.5</span>
      <v-rating
        color="yellow darken-3"
        background-color="grey darken-1"
        empty-icon="$ratingFull"
        half-increments
        readonly
        dense
        small
        class="d-inline-block"
      ></v-rating>
      <span>(71)</span>
      <v-chip x-small color="yellow" text-color="white">行ったことない</v-chip>
    </div>
    <div class="px-xl-12 px-md-12 px-sm-12 px-1 pb-12">
      <my-picture-section class="mb-12"></my-picture-section>
      <my-review-section class="mb-12"></my-review-section>
      <my-address-section></my-address-section>
    </div>
  </v-card>
</template>

<script>
import GradientImage from "./../atoms/gradientImage.vue";
import PicutureSection from "./../organisms/pictureSection.vue";
import ReviewSection from "./../organisms/reviewSection.vue";
import AddressSection from "./../organisms/addressSection.vue";
export default {
  components: {
    "my-gradient-image": GradientImage,
    "my-picture-section": PicutureSection,
    "my-review-section": ReviewSection,
    "my-address-section": AddressSection
  }
};
</script>

<style></style>
