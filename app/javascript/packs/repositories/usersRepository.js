import Repository from "../repository.js";

const resources = "/v1/users";

export default {

  find(id, token) {
    alert(token);
    alert(id);
    Repository.defaults.headers.common["Authorization"] = `Bearer ${token}`
    return Repository.get(`${resources}/${id}`);
  },

  create(data) {
    return Repository.post(`${resources}`, data);
  },

  update(id, data, token) {
    Repository.defaults.headers.common["Authorization"] = `Bearer ${token}`
    return Repository.put(`${resources}/${id}`, data);
  },

  destroy(id, token) {
    Repository.defaults.headers.common["Authorization"] = `Bearer ${token}`
    return Repository.delete(`${resources}/${id}`);
  }
};