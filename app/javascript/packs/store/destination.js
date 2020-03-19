import { RepositoryFactory } from "./../factories/repositoryFactory.js";

const DestinationsRepository = RepositoryFactory.get("destinations");

export default {
  namespaced: true,
  state: {},
  mutations: {},
  actions: {
    async getAllDestination({ dispatch, rootState }, payload = "") {
      let data = {};
      await DestinationsRepository.all(
        rootState.Session.id,
        rootState.Session.token,
        payload
      )
        .then(res => {
          data = res.data;
        })
        .catch(e => {
          console.log(e);
          let responseCode = e.response.status;

          if (responseCode == 400) {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "ネットワークエラーが発生しました。ネットワークの接続を確認してください。",
                type: "error"
              },
              { root: true }
            );
          } else if (responseCode == 500) {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "内部でエラーが発生しました。時間を置いて再度お試しください。",
                type: "error"
              },
              { root: true }
            );
          } else if (responseCode == 422) {
            dispatch(
              "Alert/setAlert",
              { msg: "指定したURLが見つかりませんでした。", type: "error" },
              { root: true }
            );
          } else {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "予期せぬエラーが発生しました。システム管理者までご連絡ください。",
                type: "error"
              },
              { root: true }
            );
          }
        });
      return data;
    },

    ////////////////////////////////////////////////////////////////////////////

    async getFullDestination({ dispatch, rootState }, payload) {
      let data = {};
      let result = 0;
      await DestinationsRepository.show(
        payload.id,
        rootState.Session.id,
        rootState.Session.token,
        payload.query
      )
        .then(res => {
          data = res.data;
          result = res.status;
        })
        .catch(e => {
          console.log(e);
          result = e.response.status;
        });
      return [result, data];
    },

    ////////////////////////////////////////////////////////////////////////////

    async createDestination({ dispatch, rootState }, payload) {
      let responseCode = "";
      await DestinationsRepository.create(
        rootState.Session.id,
        rootState.Session.token,
        payload
      )
        .then(res => {
          responseCode = res.status;
          dispatch(
            "Alert/setAlert",
            {
              msg: "行き先を登録しました。早速訪れてみましょう！",
              type: "success"
            },
            { root: true }
          );
        })
        .catch(e => {
          console.log(e);
          responseCode = e.response.status;

          if (responseCode == 400) {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "ネットワークエラーが発生しました。ネットワークの接続を確認してください。",
                type: "error"
              },
              { root: true }
            );
          } else if (responseCode == 500) {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "内部でエラーが発生しました。時間を置いて再度お試しください。",
                type: "error"
              },
              { root: true }
            );
          } else if (responseCode == 422) {
            dispatch(
              "Alert/setAlert",
              { msg: "指定したURLが見つかりませんでした。", type: "error" },
              { root: true }
            );
          } else {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "予期せぬエラーが発生しました。システム管理者までご連絡ください。",
                type: "error"
              },
              { root: true }
            );
          }
        });
      return responseCode;
    },

    ////////////////////////////////////////////////////////////////////////////

    async updateDestination({ dispatch, rootState }, payload) {
      let data = {};
      // HACK: ここ実装元に大きく依存しててやばい。時間ないからとりあえずこのやり方で。
      await DestinationsRepository.update(
        payload.id,
        rootState.Session.id,
        rootState.Session.token,
        payload.destination
      )
        .then(res => {
          data = res.data;
        })
        .catch(e => {
          console.log(e);
          let responseCode = e.response.status;

          if (responseCode == 400) {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "ネットワークエラーが発生しました。ネットワークの接続を確認してください。",
                type: "error"
              },
              { root: true }
            );
          } else if (responseCode == 500) {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "内部でエラーが発生しました。時間を置いて再度お試しください。",
                type: "error"
              },
              { root: true }
            );
          } else if (responseCode == 422) {
            dispatch(
              "Alert/setAlert",
              { msg: "指定したURLが見つかりませんでした。", type: "error" },
              { root: true }
            );
          } else {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "予期せぬエラーが発生しました。システム管理者までご連絡ください。",
                type: "error"
              },
              { root: true }
            );
          }
        });
      return data;
    },

    ////////////////////////////////////////////////////////////////////////////

    async destroyDestination({ dispatch, rootState }, payload) {
      await DestinationsRepository.destroy(
        payload,
        rootState.Session.id,
        rootState.Session.token
      )
        .then(res => {})
        .catch(e => {
          console.log(e);
          let responseCode = e.response.status;

          if (responseCode == 400) {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "ネットワークエラーが発生しました。ネットワークの接続を確認してください。",
                type: "error"
              },
              { root: true }
            );
          } else if (responseCode == 500) {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "内部でエラーが発生しました。時間を置いて再度お試しください。",
                type: "error"
              },
              { root: true }
            );
          } else if (responseCode == 422) {
            dispatch(
              "Alert/setAlert",
              { msg: "指定したURLが見つかりませんでした。", type: "error" },
              { root: true }
            );
          } else {
            dispatch(
              "Alert/setAlert",
              {
                msg:
                  "予期せぬエラーが発生しました。システム管理者までご連絡ください。",
                type: "error"
              },
              { root: true }
            );
          }
        });
    }
  }
};
