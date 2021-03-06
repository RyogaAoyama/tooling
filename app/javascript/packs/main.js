import "@mdi/font/css/materialdesignicons.css";
import "vuetify/dist/vuetify.min.css";
import Vue from "vue";
import * as VueGoogleMaps from "vue2-google-maps";
import axios from "axios";
import Vuetify from "vuetify";
import App from "../app.vue";
import router from "./router";
import store from "./store.js";

Vue.use(Vuetify, {});
const vuetify = new Vuetify({
  icon: {
    iconfont: "mdi"
  }
});

Vue.use(VueGoogleMaps, {
  load: {
    key: gon.GOOGLE_API_KEY,
    libraries: "places",
    region: "JP",
    language: "ja"
  }
});

Vue.prototype.$axios = axios;

document.addEventListener("DOMContentLoaded", () => {
  new Vue({
    store,
    router,
    vuetify,
    render: h => h(App)
  }).$mount("#app");
});
