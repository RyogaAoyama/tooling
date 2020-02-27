import { RepositoryFactory } from "./../factories/repositoryFactory.js";
import router from "./../router";

const sessionsRepository = RepositoryFactory.get("sessions");

export default {
  namespaced: true,
  state: {
    id: "",
    loginError: ""
  },
  mutations: {
    setSessionError(state, payload) {
      state.loginError = payload;
    },
    setId(state, payload) {
      state.id = payload
    },
    resetSession(state) {
      state.id = "";
      state.loginError = "";
    }
  },
  actions: {
    async login(context, payload) {
      let data = "";
      await sessionsRepository.login(payload).then(res => {
        data = res.data;
        if (data.result == 0) {
          context.commit("setId", data.id);
          context.commit("Alert/setMsg", "ログインしました。", { root: true });
          context.commit("Alert/setIsShow", true, { root: true });
          context.commit("Alert/setType", "success", { root: true });
          router.push("/search");
        } else if (data.result == 1) {
          context.commit("setSessionError", data.error);
        }

      }).catch(e => {
        console.log(e);
        let responseCode = e.response.status;

        if (responseCode == 400) {
          context.commit("Alert/setIsShow", true, { root: true });
          context.commit("Alert/setMsg", "ネットワークエラーが発生しました。ネットワークの接続を確認してください。", { root: true });
          context.commit("Alert/setType", "error", { root: true });
        } else if (responseCode == 500) {
          context.commit("Alert/setType", "error", { root: true });
          context.commit("Alert/setIsShow", true, { root: true });
          context.commit("Alert/setMsg", "内部でエラーが発生しました。時間を置いて再度お試しください。", { root: true });
        } else {
          context.commit("Alert/setIsShow", true, { root: true });
          context.commit("Alert/setType", "error", { root: true });
          context.commit("Alert/setMsg", "予期せぬエラーが発生しました。システム管理者までご連絡ください。", { root: true });
        }
        
      });
      return data.result;
    }
  }
};
