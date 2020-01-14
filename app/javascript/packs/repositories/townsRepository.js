import Repository from "../repository.js";

const resource = "/towns";

export default {
  // 要素全取得
  all() {
    return Repository.get(`${resource}`);
  },

  create(data) {
    return Repository.post(`${resource}`, data);
  },

  update(id, data) {
    return Repository.put(`${resource}/${id}`, data);
  },

  destroy(id) {
    return Repository.delete(`${resource}/${id}`);
  }
};
