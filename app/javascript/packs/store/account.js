import { RepositoryFactory } from "./../factories/repositoryFactory.js";

const UsersRepository = RepositoryFactory.get("users");
export default {
  namespaced: true,
  state: {
    user: {
      val: {
        id: "",
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
      }
    }
  },
  mutations: {
    setUserErrors(state, payload) {
      state.user.errors = payload;
    },

    setUser(state, payload) {
      state.user.val = payload
    }
  },
  actions: {
    async create(context, payload) {
      let result = 0;
      await UsersRepository.create(payload)
        .then(res => {
          let data = res.data;
          result = data.result;
          if (data.result == 1) {
            context.commit("setUserErrors", data.errors);
          }
        }).catch(e => {

          result = e.response.status;
          // エラーメッセージ
          console.log(e);
        })
        return result;
    }
  }
};
