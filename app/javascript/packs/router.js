import VueRouter from "vue-router";
import store from "./store.js";
import Vue from "vue";
import Search from "./components/pages/search/index.vue";
import Sandbox from "./components/pages/sandbox/index.vue";
import Home from "./components/pages/home/index.vue";
import AccountNew from "./components/pages/account/new.vue";
import Login from "./components/pages/session/new.vue";
import PageNotFound from "./components/pages/error/404.vue";
import AccountProfile from "./components/pages/account/edit.vue";
import DestinationIndex from "./components/pages/destination/index.vue";
import DestinationShow from "./components/pages/destination/show.vue";
import VisitMap from "./components/pages/map/index.vue";

Vue.use(VueRouter);

const router = new VueRouter({
  mode: "history",
  routes: [
    { path: "/search", component: Search, meta: { requiresAuth: true } },
    { path: "/sandbox", component: Sandbox },
    { path: "/", component: Home },
    { path: "/account/new", component: AccountNew },
    {
      path: "/account/edit",
      component: AccountProfile,
      meta: { requiresAuth: true }
    },
    { path: "/login", component: Login },
    {
      path: "/destination/index",
      component: DestinationIndex,
      meta: { requiresAuth: true }
    },
    {
      path: "/destination/:id",
      component: DestinationShow,
      meta: { requiresAuth: true }
    },
    { path: "/map", component: VisitMap, meta: { requiresAuth: true } },
    { path: "/notfound", component: PageNotFound },
    { path: "*", component: PageNotFound }
  ]
});

// 認証が必要なページに遷移する前に認証しているかチェック
router.beforeEach((to, from, next) => {
  if (to.matched.some(rec => rec.meta.requiresAuth)) {
    if (store.state.Session.id == "" || store.state.Session.token == "") {
      next({ path: "/login", query: { redirect: to.fullPath } });
    } else {
      next();
    }
  } else {
    next();
  }
});

export default router;
