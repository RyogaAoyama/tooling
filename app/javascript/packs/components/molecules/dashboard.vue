<template>
  <div>
    <v-navigation-drawer
      fixed
      permanent
      dark
      color="#1FAB89"
      class="nav-position"
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
        <v-list-item v-for="menu in menus" :key="menu.page" @click="pageChange(menu.page)">
          <v-list-item-icon>
            <v-icon>{{ menu.icon }}</v-icon>
          </v-list-item-icon>
          <v-list-item-content>{{ menu.name }}</v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <div class="dashboard-center dash-board-content-wrap"><slot></slot></div>
    
  </div>
</template>

<script>
export default {
  props: ["menus"],
  methods: {
    pageChange(page) {
      this.$emit("pageChange", page);
    }
  }
}
</script>

<style>
.nav-position {
  top: 65px !important;
}

.dashboard-center {
  margin-left:256px
}

.dash-board-content-wrap {
  width: 1000px;
  padding-left: 100px;
}
@media screen and (max-width: 1264px) {
  .dash-board-content-wrap {
    width: 700px;
    padding-left: 100px;
  }
}
@media screen and (max-width: 959px) {
  .dash-board-content-wrap {
    width: 600px;
    padding-left: 100px;
  }
}
@media screen and (max-width: 599px) {
  .dash-board-content-wrap {
    width: 100%;
  }
}
</style>