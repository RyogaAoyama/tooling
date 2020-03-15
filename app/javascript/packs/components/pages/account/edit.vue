<template>
  <v-app>
    <v-container>
      <my-space size="20"></my-space>

      <div class="d-lg-block d-md-block d-sm-none d-none">
        <my-dashboard :menus="menus" @pageChange="pageChange">
          <component
            :is="menuComponent"
            :parentErrors="errors"
            @emailChange="pageChange('my-email-edit')"
            @update="update"
            @destroy="destroy"
            :isLoading="isLoading"
          ></component>
        </my-dashboard>
      </div>

      <div class="d-lg-none d-md-none d-sm-block d-block">
        <my-bottom-btn @bottomBtn="isActive = !isActive">mdi-format-list-bulleted</my-bottom-btn>
        <v-navigation-drawer v-model="isActive" color="#1FAB89" fixed right dark>
          <template>
            <v-list-item>
              <v-list-item-icon>
                <v-icon>mdi-cogs</v-icon>
              </v-list-item-icon>
              <v-list-item-title>
                <strong>設定</strong>
              </v-list-item-title>
            </v-list-item>
          </template>

          <v-list>
            <v-list-item-group v-model="group">
              <v-list-item v-for="menu in menus" :key="menu.page" @click="pageChange(menu.page)">
                <v-list-item-icon>
                  <v-icon>{{ menu.icon }}</v-icon>
                </v-list-item-icon>
                <v-list-item-content>{{ menu.name }}</v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-navigation-drawer>
        <v-row justify="center">
          <v-col sm="10" xs="12">
            <component :is="menuComponent" @emailChange="pageChange('my-email-edit')"></component>
          </v-col>
        </v-row>
      </div>
    </v-container>
  </v-app>
</template>

<script>
import Dashboard from "./../../molecules/dashboard.vue";
import Profile from "./../../organisms/profile.vue";
import Space from "./../../atoms/space.vue";
import BottomBtn from "./../../atoms/bottomBtn.vue";
import PasswordEdit from "./../../organisms/passwordEdit.vue";
import ServiceEnd from "./../../organisms/serviceEnd.vue";
import EmailEdit from "./../../organisms/emailEdit.vue";
import { createNamespacedHelpers } from "vuex";
import { mapActions } from "vuex";

const {
  mapActions: mapActionsOfAccount,
  mapState: mapStateOfAccount
} = createNamespacedHelpers("Account");

const { mapMutations: mapMutationsOfSession } = createNamespacedHelpers(
  "Session"
);

const { mapActions: mapActionsOfAlert } = createNamespacedHelpers("Alert");

export default {
  components: {
    "my-dashboard": Dashboard,
    "my-profile": Profile,
    "my-space": Space,
    "my-bottom-btn": BottomBtn,
    "my-password-edit": PasswordEdit,
    "my-service-end": ServiceEnd,
    "my-email-edit": EmailEdit
  },
  data: function() {
    return {
      isActive: false,
      group: null,
      isLoading: false,
      errors: {},
      menus: [
        { name: "プロフィール", icon: "mdi-account", page: "my-profile" },
        {
          name: "パスワード",
          icon: "mdi-shield-account",
          page: "my-password-edit"
        },
        {
          name: "サービス退会",
          icon: "mdi-account-remove",
          page: "my-service-end"
        }
      ],
      menuComponent: "my-profile"
    };
  },
  computed: {
    ...mapStateOfAccount(["user"])
  },
  methods: {
    ...mapActionsOfAccount(["updateUser", "destroyUser"]),
    ...mapMutationsOfSession(["setId"]),
    ...mapActions(["reset"]),
    ...mapActionsOfAlert(["setAlert"]),

    pageChange(page) {
      this.menuComponent = page;
    },
    async update(e) {
      if (this.user.authority == 1) {
        this.setAlert({
          msg: "テストユーザーではアカウントを編集することができません。",
          type: "warning"
        });
        return;
      }
      this.isLoading = true;
      let data = await this.updateUser(e);
      this.isLoading = false;

      if (data.result == 1) {
        for (let key in data.errors) {
          this.$set(this.errors, key, data.errors[key]);
        }
      }
    },
    async destroy() {
      if (this.user.authority == 1) {
        this.setAlert({
          msg: "テストユーザーではアカウントを削除することができません。",
          type: "warning"
        });
        return;
      }
      this.isLoading = true;
      let result = await this.destroyUser();
      this.isLoading = false;
      if (result == 0) {
        this.reset();
        this.setId("");
        this.$router.push("/");
      }
    }
  },
  watch: {
    group() {
      this.isActive = false;
      // エラーメッセージ初期化
      for (let key in errors) {
        this.$set(this.errors, key, "");
      }
    }
  }
};
</script>

<style>
</style>