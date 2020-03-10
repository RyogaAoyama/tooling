import Vue from "vue";
import Vuex from "vuex";
import { RepositoryFactory } from "./factories/repositoryFactory.js";
import Repository from "./repository.js";

import createPersistedState from 'vuex-persistedstate'
import Account from "./store/account.js";
import Alert from "./store/alert.js";
import Session from "./store/session.js";
import Destination from "./store/destination.js";

Vue.use(Vuex);

const TownsRepository = RepositoryFactory.get("towns");
export default new Vuex.Store({
  plugins: [createPersistedState({
    storage: window.sessionStorage,
    key: "ar-tooling-app",
    path: ["Session.id"]
  })],
  modules: {
    Account,
    Alert,
    Session,
    Destination
  },
  state: {
    towns: [],
    isDevelop: true
  },

  mutations: {
    getAllTown(state, payload) {
      for (let data of payload) {
        state.towns.push(data);
      }
    },

    ////////////////////////////////////////////////////////////////////////////
  },

  actions: {
    async getAllTown(context) {
      let data = [];
      await TownsRepository.all().then(res => {
        data = res.data;
      });
      return data;
    },

    ////////////////////////////////////////////////////////////////////////////

    async search(context, payload) {
      let data = {}
      let result = 0
      // 検索
      await Repository.post("/search", payload)
        .then(res => {
          data = res.data;
        })
        // エラー
        .catch(e => {
          console.log(e);
          result = e.response.status;
        });
        return [result, data]
    },
    ////////////////////////////////////////////////////////////////////////////
    reset(context) {
      context.commit("Account/resetUser");
      context.commit("Session/resetSession");
    }
  }
});
