import VueRouter from "vue-router";
import Vue from "vue";
import Search from "./components/pages/search/index.vue";
import Sandbox from "./components/pages/sandbox/index.vue";
import Home from "./components/pages/home/index.vue";
import AccountNew from "./components/pages/account/new.vue";

Vue.use(VueRouter);

const routes = [
  { path: "/search", component: Search },
  { path: "/sandbox", component: Sandbox },
  { path: "/", component: Home },
  { path: "/account/new", component: AccountNew }
];

export default new VueRouter({
  mode: "history",
  routes
});
