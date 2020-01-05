<template>
  <v-col lg="4" md="6" sm="10" col="12">
    <v-card class="pa-10">
      <h1 class="center mb-2">ツーリング先を見つける</h1>
      <v-row>
        <v-col cols="6">
          <div class="sub-header">到着時間</div>
          <v-select label="到着時間を選択" solo></v-select>
        </v-col>
        <v-col cols="6">
          <div class="sub-header">場所</div>
          <v-select label="場所を選択" solo></v-select>
        </v-col>
      </v-row>
      <div class="sub-header">ルート</div>
      <v-radio-group>
        <v-radio label="無料区間ルートで検索"></v-radio>
        <v-radio label="最短ルートで検索"></v-radio>
      </v-radio-group>
      <div class="text-center">
        <v-btn rounded color="#1FAB89" dark>検索する</v-btn>
      </div>
    </v-card>
  </v-col>
</template>

<script>
export default {};
</script>

<style>
.sub-header {
  font-weight: bold;
  color: rgba(0, 0, 0, 0.6);
  margin-bottom: 10px;
}
</style>
