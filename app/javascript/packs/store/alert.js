export default {
  namespaced: true,
  state: {
    type: "success",
    msg: "",
    isShow: false
  },
  mutations: {
    setIsShow(state, payload) {
      state.isShow = payload;
    },
    setType(state, payload) {
      state.type = payload;
    },
    setMsg(state, payload) {
      state.msg = payload;
      state.flashed = false;
    }
  },
  actions: {
    setAlert(context, payload) {
      context.commit("setIsShow", true);
      context.commit("setMsg", payload.msg);
      context.commit("setType", payload.type);
    }
  }
};
