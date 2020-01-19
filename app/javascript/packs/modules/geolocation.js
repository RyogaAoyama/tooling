export default {
  getCurrentPosition() {
    return new Promise((resolve, reject) => {
      // TODO: そのうちJSDoc書く
      // 現在地取得APIが利用できるか確認
      if (!navigator.geolocation) {
        console.log("位置情報取得不可");
        // TODO:ここに位置情報が取得できなかった時の処理
        return false;
      }

      navigator.geolocation.getCurrentPosition(
        // 取得できた時の処理
        position => {
          console.log("取得に成功しました");
          let currentPosition = {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          };
          console.log(currentPosition);
          resolve(currentPosition);
        },
        // エラー時の処理
        error => {
          switch (error.code) {
            case 1:
              alert("位置情報の利用が許可されていません");
              break;
            case 2:
              alert("現在地が取得できませんでした");
              break;
            case 3:
              alert("タイムアウトになりました");
              break;
            default:
              alert("不明なエラーが発生しました");
              console.log(error.code);
              break;
          }
          resolve(false);
        }
      );
    });
  }
};
