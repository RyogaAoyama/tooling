import { RepositoryFactory } from "./../factories/repositoryFactory.js";
import router from "./../router";

const sessionsRepository = RepositoryFactory.get("sessions");

export default {
  namespaced: true,
  state: {
    id: "",
    token: ""
  },
  mutations: {
    setSessionError(state, payload) {
      state.loginError = payload;
    },
    setId(state, payload) {
      state.id = payload;
    },
    setToken(state, payload) {
      state.token = payload;
    },
    resetSession(state) {
      state.id = "";
      state.loginError = "";
    }
  },
  actions: {
    async login({ commit, dispatch }, payload) {
      let data = "";
      await sessionsRepository
        .login(payload)
        .then(res => {
          data = res.data;
          if (data.result == 0) {
            commit("setId", data.id);
            commit("setToken", data.token);
            dispatch("Alert/setAlert", {
              msg: "ログインしました。",
              type: "success"
            });

            router.push("/search");
          }
        })
        .catch(e => {
          console.log(e);
          let responseCode = e.response.status;

          if (responseCode == 400) {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "ネットワークエラーが発生しました。ネットワークの接続を確認してください。",
                type: "error"
              },
              { root: true }
            );
          } else if (responseCode == 500) {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "内部でエラーが発生しました。時間を置いて再度お試しください。",
                type: "error"
              },
              { root: true }
            );
          } else {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "予期せぬエラーが発生しました。システム管理者までご連絡ください。",
                type: "error"
              },
              { root: true }
            );
          }
        });
      return data;
    }
  }
};
