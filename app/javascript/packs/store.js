import Vue from "vue";
import Vuex from "vuex";
import { RepositoryFactory } from "./factories/repositoryFactory.js";
import Repository from "./repository.js";

import createPersistedState from 'vuex-persistedstate'
import Account from "./store/account.js";
import Alert from "./store/alert.js";
import Session from "./store/session.js";

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
    Session
  },
  state: {
    towns: [],
    searchStatus: 1,
    searchResult: {},
    searchResultMsg: "",
    isDevelop: true
  },

  mutations: {
    getAllTown(state, payload) {
      for (let data of payload) {
        state.towns.push(data);
      }
    },

    ////////////////////////////////////////////////////////////////////////////

    changeSearchStatus(state, payload) {
      state.searchStatus = payload;
    },

    ////////////////////////////////////////////////////////////////////////////

    setSearchResult(state, payload) {
      state.searchResult = payload;
    },

    ////////////////////////////////////////////////////////////////////////////

    setSearchResultMsg(state, payload) {
      state.searchResultMsg = payload;
    }
  },

  actions: {
    async getAllTown(context) {
      await TownsRepository.all().then(res => {
        context.commit("getAllTown", res.data.towns);
      });
    },

    ////////////////////////////////////////////////////////////////////////////

    async search(context, payload) {
      let data = {}
      // 検索
      await Repository.post("/search", payload)
        .then(res => {
          data = res.data;

          // 結果が取得できなかったらエラー表示
          if (data.result["name"] == "") {
            context.commit("changeSearchStatus", 4);
            context.commit(
              "setSearchResultMsg",
              "条件に該当する行き先が見つかりませんでした。"
            );
            return;
          }

          context.commit("setSearchResult", data.result);
          context.commit("changeSearchStatus", 3);
        })

        // エラー
        .catch(e => {
          console.log(e);
          if (e.response.status == 400) {
            context.commit(
              "setSearchResultMsg",
              "ネットワークエラーが発生しました。ネットワークの接続を確認してください。"
            );
            context.commit("changeSearchStatus", 4);
          } else if (e.response.status == 500) {
            context.commit("changeSearchStatus", 4);
            context.commit(
              "setSearchResultMsg",
              "内部でエラーが発生しました。時間を置いて再度お試しください。"
            );
          } else {
            context.commit("changeSearchStatus", 4);
            context.commit(
              "setSearchResultMsg",
              "予期せぬエラーが発生しました。システム管理者までご連絡ください。"
            );
          }
        });
    },
    ////////////////////////////////////////////////////////////////////////////
    reset(context) {
      context.commit("Account/resetUser");
      context.commit("Session/resetSession");
    }
  }
});
