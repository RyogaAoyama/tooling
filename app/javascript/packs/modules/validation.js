export default {
  //// 検証汎用メソッド
  // 空白チェック
  isblank(val) {
    return val == "" || val == null;
  },

  ////////////////////////////////////////////////////////////////////////////

  // 文字数範囲チェック
  isLengthOverRange(val, min, max) {
    return val < min || val > max;
  },

  ////////////////////////////////////////////////////////////////////////////

  // パスワード照合チェック
  confirmationNg(target, check) {
    return target != check;
  },

  ////////////////////////////////////////////////////////////////////////////

  // 正規表現チェック
  patternNg(str, pattern) {
    return !pattern.test(str);
  },

  ////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////

  //// 項目検証メソッド
  // ユーザー名チェック
  userNameValid(name) {
    const COLUMN_NAME = "ユーザー名";

    // 空白
    if (this.isblank(name)) {
      return [false, `${COLUMN_NAME}を入力してください`];
    }

    // 文字列範囲
    if (this.isLengthOverRange(name.length, 0, 50)) {
      return [false, `${COLUMN_NAME}は1文字以上50文字以内で入力してください`];
    }

    return [true, ""];
  },

  ////////////////////////////////////////////////////////////////////////////

  // メールアドレスチェック
  emailValid(email) {
    const COLUMN_NAME = "メールアドレス";

    // 空白
    if (this.isblank(email)) {
      return [false, `${COLUMN_NAME}を入力してください`];
    }

    // 文字列範囲
    if (this.isLengthOverRange(email.length, 0, 256)) {
      return [false, `${COLUMN_NAME}は3文字以上256文字以内で入力してください`];
    }

    // 禁止文字
    let pattern = /^[^,'"\\/=\?!:;]+$/;
    if (this.patternNg(email, pattern)) {
      return [false, `${COLUMN_NAME}は「-_.@」以外の記号は使用できません`];
    }

    // メールアドレス形式
    pattern = /^[\w][\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i;
    if (this.patternNg(email, pattern)) {
      return [false, `${COLUMN_NAME}の形式が違います`];
    }

    return [true, ""];
  },

  ////////////////////////////////////////////////////////////////////////////

  // パスワードチェック
  passwordValid(password) {
    const COLUMN_NAME = "パスワード";

    // 空白
    if (this.isblank(password)) {
      return [false, `${COLUMN_NAME}を入力してください`];
    }

    // 文字列範囲
    if (this.isLengthOverRange(password.length, 8, 50)) {
      return [false, `${COLUMN_NAME}は8文字以上50文字以内で入力してください`];
    }

    return [true, ""];
  },

  ////////////////////////////////////////////////////////////////////////////

  // パスワード確認
  confirmationValid(password, confirmation) {
    // パスワードと同じか
    if (this.confirmationNg(password, confirmation)) {
      return [false, "パスワードと一致しません"];
    }

    return [true, ""];
  },

  // 住んでる都道府県
  townIdValid(townId) {
    const COLUMN_NAME = "お住いの都道府県";

    // 空白
    if (this.isblank(townId)) {
      return [false, `${COLUMN_NAME}を入力してください`];
    }

    return [true, ""];
  }
};
