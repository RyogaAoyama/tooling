import Repository from "../repository.js";



export default {

  login(data) {
    return Repository.post(`/v1/login`, data);
  },

  logout() {
    return Repository.delete(`/v2/logout`);
  }
};