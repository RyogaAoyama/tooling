<template>
  <my-card-top-image :src="destination.picture">
    <v-row>
      <v-col>
        <h2>{{ destination.name }}</h2>

        <v-spacer></v-spacer>
        <span class="grey--text">{{ destination.review_rank }}</span>
        <v-rating
          v-model="destination.review_rank"
          color="yellow darken-3"
          background-color="grey darken-1"
          empty-icon="$ratingFull"
          half-increments
          readonly
          dense
          small
          class="d-inline-block"
        ></v-rating>
        <span class="grey--text">({{ destination.review_num }})</span>
      </v-col>
    </v-row>

    <my-icon-text
      iconName="mdi-home-city"
      size="15"
      color="#9E9E9E"
      class="mb-1"
    >{{ destination.address }}</my-icon-text>
    <my-icon-text
      iconName="mdi-calendar-today"
      size="15"
      color="#9E9E9E"
    >{{ destination.is_visit ? `${destination.visited_at.substr(0, 10)}に訪れました` : "まだ訪れたことはありません" }}</my-icon-text>

    <v-divider class="mt-4"></v-divider>

    <v-row>
      <v-col cols="3">
        <my-icon-text
          iconName="mdi-account"
          size="15"
          color="#9E9E9E"
        >{{ destination.all_destination_num }}</my-icon-text>
      </v-col>
      <v-col cols="3">
        <my-icon-text
          iconName="mdi-nature-people"
          size="15"
          color="#9E9E9E"
        >{{ destination.all_visit_num }}</my-icon-text>
      </v-col>
    </v-row>

    <v-divider class="mb-5"></v-divider>

    <v-row class="ml-1">
      <v-btn
        v-show="!destination.is_visit"
        class="white--text mr-4"
        color="#1FAB89"
        @click="update"
        large
      >訪れた</v-btn>
      <v-btn v-show="destination.is_visit" class="mr-4" color="#EEEEEE" @click="update" large>訪問済</v-btn>

      <v-btn class="white--text" color="red" @click="destroy(destination.id)" large>削除</v-btn>
    </v-row>
  </my-card-top-image>
</template>

<script>
import CardTopImage from "./../molecules/cardTopImage.vue";
import IconText from "./../molecules/iconText.vue";
import Space from "./../atoms/space.vue";
export default {
  props: ["destination"],
  components: {
    "my-card-top-image": CardTopImage,
    "my-icon-text": IconText,
    "my-space": Space
  },
  methods: {
    update() {
      // HACK: 圧倒的リファクタポイント
      this.$emit("update", {
        destination: { is_visit: !this.destination.is_visit },
        id: this.destination.id
      });
    },
    destroy(e) {
      this.$emit("destroy", e);
    }
  }
};
</script>

<style>
.left {
  text-align: left;
}

.dest-icon-text {
  color: red !important;
}
</style>