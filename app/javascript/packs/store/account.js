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
    }
  },
  mutations: {
    setUserErrors(state, payload) {
      state.errors = payload;
    },

    setUser(state, payload) {
      state.user.name = payload.user.name;
      state.user.email = payload.user.email;
      state.user.town_id = payload.user.town_id;
      state.user.avatar = payload.user.avatar;
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
    },

    async getUser(context, payload) {
      await UsersRepository.find(payload)
        .then(res => {
          console.log(res.data);
          context.commit("setUser", res.data);
        })
        .catch(e => {
          console.log(e);
        })
    }
  }
};
