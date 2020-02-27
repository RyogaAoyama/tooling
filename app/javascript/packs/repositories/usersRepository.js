import Repository from "../repository.js";

const resources = "/v1/users";

export default {

  find(id) {
    return Repository.get(`${resources}/${id}`);
  },

  create(data) {
    return Repository.post(`${resources}`, data);
  },

  update(id, data) {
    return Repository.put(`${resources}/${id}`, data);
  },

  destroy(id) {
    return Repository.delete(`${resources}/${id}`);
  }
};