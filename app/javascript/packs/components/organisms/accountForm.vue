<template>
  <div class="card-wrap">
    <v-card class="mx-auto center in-wrap">
      <div>
        <h1>Tooling</h1>
        <div>新たなる地を求めて走る</div>
      </div>
      <div>
        <v-text-field label="ユーザー名"></v-text-field>
        <div class="error-msg">&nbsp;</div>
        <v-text-field label="メールアドレス"></v-text-field>
        <div class="error-msg">&nbsp;</div>
        <v-text-field label="パスワード"></v-text-field>
        <div class="error-msg">&nbsp;</div>
        <v-text-field label="パスワード(確認)"></v-text-field>
        <div class="error-msg mb-3">&nbsp;</div>
        <v-select label="お住いの都道府県を選択" solo></v-select>
      </div>
      <v-btn color="#1FAB89" class="mb-4" width="100%" dark>アカウントを登録</v-btn>
      <div>
        <div>すでにアカウントをお持ちの方</div>
        <div>
          <a>ログイン</a>
        </div>
      </div>
    </v-card>
  </div>
</template>

<script>
export default {};
</script>

<style>
.center {
  text-align: center;
}

.in-wrap {
  padding: 80px 100px;
}

.error-msg {
  text-align: left;
  color: red;
}

a:link {
  color: #1fab89;
}

.card-wrap {
  width: 600px;
}
@media screen and (max-width: 1264px) {
  .card-wrap {
    width: 600px;
  }
}
@media screen and (max-width: 959px) {
  .card-wrap {
    width: 600px;
  }
}
@media screen and (max-width: 599px) {
  .card-wrap {
    width: 100%;
  }
}
</style>