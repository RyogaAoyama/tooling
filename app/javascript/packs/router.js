import VueRouter from "vue-router";
import Vue from "vue";
import Search from "./components/pages/search/index.vue";

Vue.use(VueRouter);

const routes = [{ path: "/", component: Search }];

export default new VueRouter({
  mode: "history",
  routes
});
