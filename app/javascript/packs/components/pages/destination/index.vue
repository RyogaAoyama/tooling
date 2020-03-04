<template>
  <v-container>
    <my-icon-text size="30" iconName="mdi-format-list-bulleted" class="mt-10 mb-1"><strong>行き先一覧</strong></my-icon-text>
    <hr size="7" color="#1FAB89" class="mb-2" noshade>
    <h3 class="mb-2">今まで訪れた場所 3/6</h3>
    <v-row justify="start">
      <v-col xl="3" lg="4" md="6" sm="6" xs="12">
        <my-destination></my-destination>
      </v-col>
      <v-col xl="3" lg="4" md="6" sm="6" xs="12">
        <my-destination></my-destination>
      </v-col>
      <v-col xl="3" lg="4" md="6" sm="6" xs="12">
        <my-destination></my-destination>
      </v-col>
      <v-col xl="3" lg="4" md="6" sm="6" xs="12">
        <my-destination></my-destination>
      </v-col>
    </v-row>
  </v-container>
  
</template>

<script>
import IconText from "./../../molecules/iconText.vue";
import Destination from "./../../organisms/destination.vue"
export default {
  components: {
    "my-icon-text": IconText,
    "my-destination": Destination
  }

}
</script>

<style>

</style>