import VueRouter from "vue-router";
import Vue from "vue";
import Search from "./components/pages/search/index.vue";
import Sandbox from "./components/pages/sandbox/index.vue";

Vue.use(VueRouter);

const routes = [
  { path: "/", component: Search },
  { path: "/sandbox", component: Sandbox }
];

export default new VueRouter({
  mode: "history",
  routes
});
