import Repository from "../repository.js";

const resources = "/v1/users";
const resource = "/v1/user"

export default {

  find(id) {
    return Repository.get(`${resources}`, id);
  },

  create(data) {
    return Repository.post(`${resources}`, data);
  },

  update(id, data) {
    return Repository.put(`${resource}/${id}`, data);
  },

  destroy(id) {
    return Repository.delete(`${resource}/${id}`);
  }
};