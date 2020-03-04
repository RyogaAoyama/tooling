<template>
  <my-card-top-image>
    <v-row>
      <v-col>
        <h2>Cafe Badilico</h2>

        <v-spacer></v-spacer>

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
          <span class="grey--text">4.5 (413)</span>
      </v-col>
    </v-row>

    <my-icon-text iconName="mdi-home-city" size="15" color="#9E9E9E" class="mb-1">岡山県倉敷市水島4-5-3</my-icon-text>
    <my-icon-text iconName="mdi-calendar-today" size="15" class="mb-4" color="#9E9E9E">2020-01-01</my-icon-text>

    <v-divider></v-divider>

    <v-row>
      <v-col cols="3">
        <my-icon-text iconName="mdi-nature-people" size="15" color="#9E9E9E">300</my-icon-text>
      </v-col>
      <v-col cols="3">
        <my-icon-text iconName="mdi-heart" size="15" color="#9E9E9E">20</my-icon-text>
      </v-col>
    </v-row>

    <v-divider class="mb-5"></v-divider>

    <v-row class="ml-1">
      <v-btn
        class="white--text mr-4"
        color="#1FAB89"
        large>訪れた</v-btn>
      <v-btn
        class="white--text"
        color="red"
        large>削除</v-btn>
        <v-spacer></v-spacer>
      <v-btn icon class="align-end left mr-1">
        <v-icon color="grey lighten-1" large>mdi-heart</v-icon>
      </v-btn>
    </v-row>

  </my-card-top-image>
</template>

<script>
import CardTopImage from "./../molecules/cardTopImage.vue"
import IconText from "./../molecules/iconText.vue"
import Space from "./../atoms/space.vue"
export default {
  components: {
    "my-card-top-image": CardTopImage,
    "my-icon-text": IconText,
    "my-space": Space
  }
}
</script>

<style>
.left {
  text-align: left;
}

.dest-icon-text{
  color: red !important;
}

</style>