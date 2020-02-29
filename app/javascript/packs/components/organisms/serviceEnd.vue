<template>
  <div>
    <h1>サービス退会</h1>
    <v-divider></v-divider>
    <my-space size="10"></my-space>

    <v-row>
      <v-col lg="5" md="12" sm="12" cols="12">
        <div class="pa-lg-6 pa-md-6">
          <div>サービスを退会しますか？</div>
          <my-space size="10"></my-space>
          <v-btn
            class="white--text"
            color="red"
            large
            @click="destroy"
            :disabled="isLoading"
            :loading="isLoading"
          >サービスを退会</v-btn>
        </div>
      </v-col>

      <v-col lg="7" md="12" sm="12" cols="12">
        <div class="warn-wrap pa-6">
          <h1>注意</h1>
          <v-divider></v-divider>
          <my-space size="20"></my-space>
          <p>
            サービスを退会した場合、
            今まで記録したツーリングの記録は全て削除され、
            元に復元することはできません。
          </p>
        </div>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import Space from "./../atoms/space.vue";

export default {
  props: ["isLoading"],
  components: {
    "my-space": Space
  },
  methods: {
    destroy() {
      this.$emit("destroy");
    }
  }
}
</script>

<style>
.warn-wrap {
  background-color: rgba(31,171,137,0.1);
}
</style>