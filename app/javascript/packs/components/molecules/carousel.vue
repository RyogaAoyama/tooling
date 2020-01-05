<template>
  <div>
    <v-carousel cycle show-arrows :height="height">
      <v-carousel-item>
        <v-sheet color="#red" height="100%" tile>
          <v-row class="fill-height" align="center" justify="center">
            <div class="display-3">Slide {{ 1 }}</div>
          </v-row>
        </v-sheet>
      </v-carousel-item>
    </v-carousel>
  </div>
</template>

<script>
export default {
  props: ["height"]
};
</script>

<style></style>
