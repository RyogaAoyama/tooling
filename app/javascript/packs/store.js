import Vue from "vue";
import Vuex from "vuex";
import { RepositoryFactory } from "./factories/repositoryFactory.js";

Vue.use(Vuex);

const TownsRepository = RepositoryFactory.get("towns");
export default new Vuex.Store({
  state: { towns: [] },

  //// Stateの更新 ////
  mutations: {
    getAllTown(state, payload) {
      for (let data of payload) {
        state.towns.push(data);
      }
    }
  },
  //// 非同期処理 ////
  actions: {
    async getAllTown(context) {
      await TownsRepository.all().then(res => {
        context.commit("getAllTown", res.data.towns);
      });
    }
  }
});
