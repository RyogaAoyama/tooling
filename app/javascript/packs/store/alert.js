export default {
  namespaced: true,
  state: {
    type: "success",
    msg: "",
    isShow: false,
    flashed: false
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
    },
    setFlashed(state, payload) {
      state.flashed = payload;
    }
}
};
