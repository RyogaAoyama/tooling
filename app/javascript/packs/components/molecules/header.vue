<template>
  <v-card>
    <v-toolbar>
      <v-app-bar-nav-icon></v-app-bar-nav-icon>
      <v-toolbar-title>Tooling</v-toolbar-title>

      <v-spacer></v-spacer>
      <v-toolbar-items>
        <v-btn @click="$router.push('/')">TOP</v-btn>
        <v-btn @click="$router.push('/sandbox')">サンドボックス</v-btn>
        <v-btn @click="test">test</v-btn>
        <v-btn text v-show="isAuth">{{ user.name }}</v-btn>
      </v-toolbar-items>
      <v-avatar v-show="isAuth">
        <img :src="user.avatar">
      </v-avatar>
    </v-toolbar>
  </v-card>
</template>

<script>
import { createNamespacedHelpers } from "vuex";

const {
  mapState: mapStateOfAccount
} = createNamespacedHelpers("Account");

const {
  mapState: mapStateOfSession
} = createNamespacedHelpers("Session");

export default {
  data: function() {
    return {
      isAuth: false
    }
  },
  computed: {
    ...mapStateOfSession(["id"]),
    ...mapStateOfAccount(["user"]),
  },
  watch: {
    id: function() {
      this.existId();
    }
  },
  methods: {
    test() {
      console.log(this.user)
    },
    existId() {
      if (this.id != "") {
        this.isAuth = true;
      } else {
        this.isAuth = false
      }
    }
  }
};
</script>

<style></style>
