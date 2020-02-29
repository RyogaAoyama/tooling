<template>
  <v-card class="header-wrap">
    <v-toolbar height="65px" width="100%" class="fixed" color="white">
      <v-app-bar-nav-icon @click="isActive = !isActive" v-show="id != ''"></v-app-bar-nav-icon>
      <v-toolbar-title>Tooling</v-toolbar-title>

      <v-spacer></v-spacer>
      <v-toolbar-items>
        <v-btn @click="$router.push('/')">TOP</v-btn>
        <v-btn @click="$router.push('/sandbox')">サンドボックス</v-btn>
        <v-btn @click="test">test</v-btn>
        <v-btn @click="$router.push('/account/edit')">設定</v-btn>
        <v-btn text v-show="isAuth">{{ user.name }}</v-btn>
      </v-toolbar-items>
    </v-toolbar>

    <v-navigation-drawer
      fixed
      dark
      temporary
      color="#1FAB89"
      v-model="isActive"
    >
      <template>
        <v-list-item>
          <v-list-item-icon>
            <v-icon>mdi-cogs</v-icon>
          </v-list-item-icon>
          <v-list-item-title><strong>設定</strong></v-list-item-title>
        </v-list-item>
      </template>

      <v-divider></v-divider>

      <v-list>
        <v-list-item-group v-model="group">
          <v-list-item v-for="menu in menus" :key="menu.page" @click="$router.push(menu.page)">
            <v-list-item-icon>
              <v-icon>{{ menu.icon }}</v-icon>
            </v-list-item-icon>
            <v-list-item-content>{{ menu.name }}</v-list-item-content>
          </v-list-item>

          <v-list-item @click="logout">
            <v-list-item-icon>
              <v-icon>mdi-logout-variant</v-icon>
            </v-list-item-icon>
            <v-list-item-content>ログアウト</v-list-item-content>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
  </v-card>
</template>

<script>
import { createNamespacedHelpers, mapActions } from "vuex"

const {
  mapState: mapStateOfAccount
} = createNamespacedHelpers("Account");

const {
  mapState: mapStateOfSession,
} = createNamespacedHelpers("Session");

const {
  mapActions: mapActionsOfAlert
} = createNamespacedHelpers("Alert");

export default {
  data: function() {
    return {
      isAuth: false,
      isActive: false,
      group: false,
      userName: "",
      menus:[
        { name: "行き先を検索", icon: "mdi-logout-variant", page: "/search" },
        { name: "設定", icon: "mdi-cogs", page: "/account/edit" }
      ]
    }
  },
  computed: {
    ...mapStateOfSession(["id", "token"]),
    ...mapStateOfAccount(["user"])
  },

  methods: {
    ...mapActionsOfAlert(["setAlert"]),
    ...mapActions(["reset"]),
    test() {
      console.log(this.id);
      console.log(this.token);
      console.log(this.user);
    },
    logout() {
      this.setAlert({ msg: "ログアウトしました", type: "success" });
      this.reset();
      this.$router.push("/");
    },
    existId() {
      if (this.id != "") {
        this.isAuth = true;
      } else {
        this.isAuth = false
      }
    }
  },
  created() {
    this.existId()
  },
  watch: {
    group() {
      this.isActive = false;
    },
    id() {
      this.existId();
    }
  }
};
</script>

<style>

.fixed {
  position: fixed;
  z-index: 1000;
}

.header-wrap {
  margin-bottom: 65px;
}
</style>
