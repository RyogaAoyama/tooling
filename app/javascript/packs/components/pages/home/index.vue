<template>
  <div>
    <div class="home-header-wrap mb-10">
      <v-img
        src="/home_image.jpg"
        gradient="rgba(31,171,137,.8), rgba(31,171,137,.8)"
        width="100%"
        height="700px"
      ></v-img>
      <v-container>
        <v-row>
          <v-col class="home-header-text-wrap white--text mt-12">
            <div class="font-weight-bold display-3 mb-7">目的地を自動で探す</div>
            <div class="display-1">休日どこに行こうか？</div>
            <div class="display-1">普段行かない場所に行ってみようか?</div>
            <div class="display-1 mb-7">そんな時にSPOTに行き先を委ねてみませんか？</div>
            <v-btn
              class="ma-2 teal--text"
              color="white"
              block
              large
              @click="$router.push('/account/new').catch(e=>{})"
            >無料でアカウントを作成</v-btn>
          </v-col>
        </v-row>
      </v-container>
    </div>

    <v-container>
      <my-icon-text iconName="mdi-help-circle-outline" size="34" class="center" color="black">
        <strong>SPOTはいつ、どんな時に使う？</strong>
      </my-icon-text>

      <my-space size="100"></my-space>

      <v-row>
        <v-col
          xl="7"
          lg="7"
          md="6"
          sm="12"
          cols="12"
          order-xl="10"
          order-lg="10"
          order-md="10"
          order-sm="1"
          order-xs="1"
          class="mb-2"
        >
          <v-img src="undraw_faq_rjoy.svg"></v-img>
        </v-col>
        <v-col
          xl="5"
          lg="5"
          md="6"
          sm="12"
          cols="12"
          order-xl="1"
          order-lg="1"
          order-md="1"
          order-sm="10"
          order="10"
        >
          <div class="display-1 font-weight-bold mb-5">休日に出かけ先が決まらない時</div>
          <div class="headline">待ちに待った休日、でも出かけようとしても目的地が見つからないこと、ありませんか？</div>
        </v-col>
      </v-row>

      <my-space size="100"></my-space>
      <v-divider></v-divider>
      <my-space size="100"></my-space>

      <v-row>
        <v-col
          xl="5"
          lg="5"
          md="6"
          sm="12"
          cols="12"
          order-xl="10"
          order-lg="10"
          order-md="10"
          order-sm="1"
          order-xs="1"
        >
          <div class="display-1 font-weight-bold mb-5">普段行かない場所にドライブする時</div>
          <div class="headline">
            「ドライブどこ行く？」「海！」「それ前行った。」「あぁ。」「刺激が欲しいなぁ...」
            <br />普段と違う刺激が欲しい時がありませんか？
          </div>
        </v-col>
        <v-col
          xl="7"
          lg="7"
          md="6"
          sm="12"
          cols="12"
          order-xl="1"
          order-lg="1"
          order-md="1"
          order-sm="10"
          order-xs="10"
          class="mb-2"
        >
          <v-img src="undraw_electric_car_b7hl.svg"></v-img>
        </v-col>
      </v-row>

      <my-space size="100"></my-space>
      <v-divider></v-divider>
      <my-space size="100"></my-space>

      <v-row>
        <v-col
          xl="5"
          lg="5"
          md="6"
          sm="12"
          cols="12"
          order-xl="1"
          order-lg="1"
          order-md="1"
          order-sm="10"
          order-xs="10"
        >
          <div class="display-1 font-weight-bold mb-5">穴場スポットを見つけたい時</div>
          <div class="headline">
            誰も知らない秘境を巡ってみたい。少し冒険してみたい。そんな冒険心がくすぐられること、
            ありませんか？
          </div>
        </v-col>
        <v-col
          xl="7"
          lg="7"
          md="6"
          sm="12"
          cols="12"
          order-xl="1"
          order-lg="1"
          order-md="1"
          order-sm="10"
          order-xs="10"
          class="mb-2"
        >
          <v-img src="undraw_adventure_4hum.svg"></v-img>
        </v-col>
      </v-row>

      <my-space size="100"></my-space>
      <v-divider></v-divider>
      <my-space size="100"></my-space>

      <div class="center display-1 font-weight-bold">SPOTにはこんな機能があります</div>

      <my-space size="100"></my-space>

      <v-row>
        <v-col xl="4" lg="4" md="4" sm="12" cols="12" class="center">
          <div class="display-1 font-weight-bold mb-10">行き先検索機能</div>
          <div class="headline mb-10">行き先を自動で探し出してくれます</div>
          <v-avatar size="280">
            <img src="undraw_house_searching_n8mp.svg" alt="John" />
          </v-avatar>
        </v-col>
        <v-col xl="4" lg="4" md="4" sm="12" cols="12" class="center">
          <div class="display-1 font-weight-bold mb-10">行き先保存</div>
          <div class="headline mb-10">気に入った行き先を保存することができます</div>
          <v-avatar size="280">
            <img src="undraw_collecting_fjjl.svg" alt="John" />
          </v-avatar>
        </v-col>
        <v-col xl="4" lg="4" md="4" sm="12" cols="12" class="center">
          <div class="display-1 font-weight-bold mb-10">行き先マップ</div>
          <div class="headline mb-10">保存した行き先をマップから確認できます</div>
          <v-avatar size="280">
            <img src="undraw_Map_light_3hjy.svg" alt="John" />
          </v-avatar>
        </v-col>
      </v-row>
    </v-container>

    <my-space size="150"></my-space>

    <div class="row--teal">
      <div class="home-footer-content">
        <div class="display-1 white--text mb-10">
          <strong>SPOTで誰も知らないスポットへ訪れてみましょう！</strong>
        </div>
        <v-btn
          class="ma-2 teal--text"
          color="white"
          large
          @click="$router.push('/account/new').catch(e=>{})"
        >無料でアカウントを作成</v-btn>
      </div>
    </div>
  </div>
</template>

<script>
import IconText from "./../../molecules/iconText.vue";
import Space from "./../../atoms/space.vue";
export default {
  components: {
    "my-icon-text": IconText,
    "my-space": Space
  }
};
</script>

<style>
.home-header-wrap {
  position: relative;
}

.home-header-text-wrap {
  position: absolute;
  top: 0;
  width: 500px;
}

.teal--text {
  color: "#1FAB89";
}

.center {
  text-align: center;
}

.row--teal {
  position: relative;
  background-color: rgba(31, 171, 137, 0.7);
}

.home-footer-content {
  text-align: center;
  padding: 100px 0px;
}
</style>