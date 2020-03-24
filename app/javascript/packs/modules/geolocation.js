export default {
  getCurrentPosition() {
    return new Promise((resolve, reject) => {
      // 現在地取得APIが利用できるか確認
      let defaultPosition = { lat: 35.68944, lng: 139.69167 };
      if (!navigator.geolocation) {
        console.log("位置情報取得不可");
        return [defaultPosition, false];
      }

      navigator.geolocation.getCurrentPosition(
        // 取得できた時の処理
        position => {
          let currentPosition = {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          };
          resolve([currentPosition, true]);
        },
        // エラー時の処理
        error => {
          switch (error.code) {
            case 1:
              console.log("位置情報の利用が許可されていません");
              break;
            case 2:
              console.log("現在地が取得できませんでした");
              break;
            case 3:
              console.log("タイムアウトになりました");
              break;
            default:
              console.log("不明なエラーが発生しました");
              console.log(error.code);
              break;
          }
          resolve([defaultPosition, false]);
        }
      );
    });
  }
};
