<template>
  <v-card>
    <v-toolbar>
      <v-app-bar-nav-icon></v-app-bar-nav-icon>
      <v-toolbar-title>Tooling</v-toolbar-title>

      <v-spacer></v-spacer>
      <v-toolbar-items>
        <v-btn @click="$router.push('/')">TOP</v-btn>
        <v-btn @click="$router.push('/sandbox')">サンドボックス</v-btn>
        <v-btn text>Masayuki</v-btn>
      </v-toolbar-items>
      <v-avatar color="indigo">
        <v-icon dark>account_circle</v-icon>
      </v-avatar>
    </v-toolbar>
  </v-card>
</template>

<script>
export default {};
</script>

<style></style>
