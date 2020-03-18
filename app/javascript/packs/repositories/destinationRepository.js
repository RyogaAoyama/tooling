import Repository from "../repository.js";

// HACK: 動的ルートどうやってやる？時間あったら修正
const resources = "/v1/users";

export default {
  all(user_id, token, query = "") {
    Repository.defaults.headers.common["Authorization"] = `Bearer ${token}`;
    if (query != "") query = `?${query}`;
    return Repository.get(`${resources}/${user_id}/destinations${query}`);
  },

  show(id, user_id, token, query = "") {
    Repository.defaults.headers.common["Authorization"] = `Bearer ${token}`;
    if (query != "") query = `?${query}`;
    return Repository.get(`${resources}/${user_id}/destinations/${id}${query}`);
  },

  create(user_id, token, data) {
    Repository.defaults.headers.common["Authorization"] = `Bearer ${token}`;
    return Repository.post(`${resources}/${user_id}/destinations`, data);
  },

  update(id, user_id, token, data) {
    Repository.defaults.headers.common["Authorization"] = `Bearer ${token}`;
    return Repository.put(`${resources}/${user_id}/destinations/${id}`, data);
  },

  destroy(id, user_id, token) {
    Repository.defaults.headers.common["Authorization"] = `Bearer ${token}`;
    return Repository.delete(`${resources}/${user_id}/destinations/${id}`);
  }
};
