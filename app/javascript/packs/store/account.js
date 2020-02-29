import { RepositoryFactory } from "./../factories/repositoryFactory.js";

const UsersRepository = RepositoryFactory.get("users");
export default {
  namespaced: true,
  state: {
    user: {
      name: "",
      email: "",
      town_id: "",
      avatar: ""
      },
    errors: {
      name: "",
      email: "",
      town_id: "",
      avatar: "",
      password: "",
      password_confirmation: "",
      authenticate: ""
    }
  },
  mutations: {
    setUser(state, payload) {
      for (let key in payload.user) {
        state.user[key] = payload.user[key];
      }
    },

    resetUser(state) {
      state.user = {};
      state.errors = {};
    }
  },
  actions: {
    async create(context, payload) {
      let data = {};
      await UsersRepository.create(payload)
        .then(res => {
          data = res.data;
        }).catch(e => {

          responseCode = e.response.status;
          if (responseCode == 400) {
            this.setIsShow(true);
            this.setMsg("ネットワークエラーが発生しました。ネットワークの接続を確認してください。");
            this.setType("error");
          } else if (responseCode == 500) {
            this.setIsShow(true);
            this.setMsg("内部でエラーが発生しました。時間を置いて再度お試しください。");
            this.setType("error");
          } else {
            this.setIsShow(true);
            this.setMsg("予期せぬエラーが発生しました。システム管理者までご連絡ください。");
            this.setType("error");
          }
          // エラーメッセージ
          console.log(e);
        })
        return data;
    },

    async getUser({ commit, rootState }) {
      await UsersRepository.find(rootState.Session.id, rootState.Session.token)
        .then(res => {
          commit("setUser", res.data);
        })
        .catch(e => {
          console.log(e);
        })
    },

    async updateUser({ commit, dispatch, rootState }, payload) {
      let data = {};
      await UsersRepository.update(rootState.Session.id, payload, rootState.Session.token)
      .then(res => {
        data = res.data;

        if (data.result == 0) {
          commit("setUser", data);
          dispatch("Alert/setAlert",
            { msg: "保存が完了しました。", type: "success" },
            { root: true }
          );
        }
        })
        .catch(e => {
          console.log(e);
          let responseCode = e.response.status;
  
          if (responseCode == 400) {
            dispatch("Alert/setAlert",
              { msg: "ネットワークエラーが発生しました。ネットワークの接続を確認してください。", type: "error" },
              { root: true }
            );
          } else if (responseCode == 500) {
            dispatch("Alert/setAlert",
              { msg: "内部でエラーが発生しました。時間を置いて再度お試しください。", type: "error" },
              { root: true }
            );
          } else {
            dispatch("Alert/setAlert",
              { msg: "予期せぬエラーが発生しました。システム管理者までご連絡ください。", type: "error" },
              { root: true }
            );
          }
        })
        return data;
    },
    async destroyUser({ dispatch, rootState }) {
      let result = await UsersRepository.destroy(rootState.Session.id, rootState.Session.token)
        .then(res => {
          dispatch(
            "Alert/setAlert",
            { msg: "サービスを退会しました、ご利用ありがとうございました。",type: "success" },
            { root: true }
          )
          return res.data.result;
        })
        .catch(e => {
          console.log(e);

          let responseCode = e.response.status;
          if (responseCode == 400) {
            dispatch(
              "Alert/setAlert",
              { msg: "ネットワークエラーが発生しました。ネットワークの接続を確認してください。",type: "error" },
              { root: true }
            )
          } else if (responseCode == 500) {
            dispatch(
              "Alert/setAlert",
              { msg: "内部でエラーが発生しました。時間を置いて再度お試しください。",type: "error" },
              { root: true }
            )
          } else {
            dispatch(
              "Alert/setAlert",
              { msg: "予期せぬエラーが発生しました。システム管理者までご連絡ください。",type: "error" },
              { root: true }
            )
          }
          return responseCode;
        });
        return result;
    }
  }
};
