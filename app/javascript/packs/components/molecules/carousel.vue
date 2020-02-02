<template>
  <div>
    <v-carousel cycle show-arrows :height="height">
      <v-carousel-item v-for="(src, idx) in srcs" :key="idx">
        <v-sheet color="#red" height="100%" tile>
          <v-row class="fill-height" align="center" justify="center">
            <img :src="src" />
          </v-row>
        </v-sheet>
      </v-carousel-item>
    </v-carousel>
  </div>
</template>

<script>
// TODO: 写真ない時の処理
export default {
  props: ["height", "srcs"]
};
</script>

<style></style>
