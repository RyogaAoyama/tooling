<template>
  <div>
    <my-icon-text iconName="mdi-file-document-box-multiple-outline" size="25" class="mb-8">クチコミ</my-icon-text>
    <v-card class="pa-7">
      <div v-for="(review, idx) in searchResult.reviews" :key="idx">
        <div class="mb-2">
          <v-avatar class="mr-3">
            <img :src="review.profile_photo_url" />
          </v-avatar>
          <strong>{{review.author_name}}</strong>
        </div>

        <div class="mb-2">
          <span>{{review.rating.toFixed(1)}}</span>
          <v-rating
            v-model="review.rating"
            color="yellow darken-3"
            background-color="grey darken-1"
            empty-icon="$ratingFull"
            half-increments
            readonly
            dense
            small
            class="d-inline-block"
          ></v-rating>
          <span>{{review.relative_time_description}}</span>
        </div>

        <div class="mb-10">{{review.text}}</div>

        <v-divider class="mb-10"></v-divider>
      </div>

      <div v-if="searchResult.reviews.length == 0">
        <my-opacity-image src="/not_content.svg">
          <h2>クチコミはありません</h2>
        </my-opacity-image>
      </div>
    </v-card>
  </div>
</template>

<script>
import IconText from "./../molecules/iconText.vue";
import OpacityImage from "./../atoms/opacityImage.vue";
import { mapState } from "vuex";
export default {
  props: ["searchResult"],
  components: {
    "my-icon-text": IconText,
    "my-opacity-image": OpacityImage
  }
};
</script>

<style></style>
