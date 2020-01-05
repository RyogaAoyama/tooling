<template>
  <div>
    <my-icon-text
      iconName="mdi-file-document-box-multiple-outline"
      size="25"
      class="mb-8"
    >
      クチコミ
    </my-icon-text>
    <v-card class="pa-7">
      <div class="mb-2">
        <v-avatar color="indigo" class="mr-3">
          <v-icon dark>account_circle</v-icon>
        </v-avatar>
        <strong>青山　稜河</strong>
      </div>

      <div class="mb-2">
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
        <span>2ヶ月前</span>
      </div>

      <div class="mb-10">
        ここにレビュー文
      </div>

      <v-divider class="mb-10"></v-divider>
      <div class="mb-2">
        <v-avatar color="indigo" class="mr-3">
          <v-icon dark>account_circle</v-icon>
        </v-avatar>
        <strong>青山　稜河</strong>
      </div>

      <div class="mb-2">
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
        <span>2ヶ月前</span>
      </div>

      <div>
        ここにレビュー文
      </div>
    </v-card>
  </div>
</template>

<script>
import IconText from "./../molecules/iconText.vue";
export default {
  components: {
    "my-icon-text": IconText
  }
};
</script>

<style></style>
