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

Vue.use(VueRouter);




const router =  new VueRouter({
  routes: [
    { path: "/search", component: Search, meta: { requiresAuth:true } },
    { path: "/sandbox", component: Sandbox },
    { path: "/", component: Home },
    { path: "/account/new", component: AccountNew },
    { path: "/account/edit", component: AccountProfile, meta: { requiresAuth:true } },
    { path: "/login", component: Login },
    { path: "*", component: PageNotFound }
  ]
});

router.beforeEach((to, from, next) => {
  if (to.matched.some(rec => rec.meta.requiresAuth)) {
    if (store.state.Session.id == "" || store.state.Session.token == "") {
      next({ path: "/login", query: { redirect: to.fullPath }});
    } else {
      next();
    }
  } else {
    next();
  }
});

export default router;
