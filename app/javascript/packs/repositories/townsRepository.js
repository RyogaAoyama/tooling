import Repository from "../repository.js";

const resource = "/towns";

export default {
  // 要素全取得
  all() {
    return Repository.get(`${resource}`);
  }
};
