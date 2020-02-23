import VueRouter from "vue-router";
import Vue from "vue";
import Search from "./components/pages/search/index.vue";
import Sandbox from "./components/pages/sandbox/index.vue";
import Home from "./components/pages/home/index.vue";
import AccountNew from "./components/pages/account/new.vue";
import Login from "./components/pages/session/new.vue";
import PageNotFound from "./components/pages/error/404.vue";

Vue.use(VueRouter);

const routes = [
  { path: "/search", component: Search },
  { path: "/sandbox", component: Sandbox },
  { path: "/", component: Home },
  { path: "/account/new", component: AccountNew },
  { path: "/login", component: Login },
  { path: "*", component: PageNotFound }
];

export default new VueRouter({
  routes
});
