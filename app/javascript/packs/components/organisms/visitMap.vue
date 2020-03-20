<template>
  <div class="app">
    <div id="map">
      <GmapMap :center="center" :zoom="zoom" class="visit-g-map-size">
        <GmapInfoWindow
          :options="infoOptions"
          :position="infoWindowPos"
          :opened="infoWinOpen"
          @closeclick="infoWinOpen=false"
        >
          <div class="g-window-size">
            <v-row>
              <v-col cols="6" class="pa-0">
                <v-img class="white--text align-end img-height" width="100%" :src="item.picture"></v-img>
              </v-col>
              <v-col cols="6">
                <h2 class="mb-2">{{ item.name }}</h2>
                <div class="mb-2">
                  <span>{{ item.review_rank }}</span>
                  <v-rating
                    v-model="item.review_rank"
                    color="yellow darken-3"
                    background-color="grey darken-1"
                    empty-icon="$ratingFull"
                    half-increments
                    readonly
                    dense
                    small
                    class="d-inline-block"
                  ></v-rating>
                  <span>({{ item.review_num }})</span>
                </div>
                <my-icon-text
                  iconName="mdi-home-city"
                  size="13"
                  color="#9E9E9E"
                  class="mb-2"
                >{{ item.address }}</my-icon-text>
                <my-icon-text
                  iconName="mdi-calendar-today"
                  size="13"
                  color="#9E9E9E"
                  class="mb-2"
                >{{ item.is_visit ? `${item.visited_at.substr(0, 10)}に訪れました` : "まだ訪れていません" }}</my-icon-text>

                <v-divider class="mb-1"></v-divider>
                <v-row>
                  <v-col cols="3">
                    <my-icon-text
                      iconName="mdi-account"
                      size="13"
                      color="#9E9E9E"
                    >{{ item.all_destination_num }}</my-icon-text>
                  </v-col>
                  <v-col cols="3">
                    <my-icon-text
                      iconName="mdi-nature-people"
                      size="13"
                      color="#9E9E9E"
                    >{{ item.all_visit_num }}</my-icon-text>
                  </v-col>
                </v-row>
              </v-col>
            </v-row>
          </div>
        </GmapInfoWindow>
        <GmapMarker
          v-for="m in marker_items"
          :position="m.position"
          :clickable="true"
          :draggable="true"
          :key="m.id"
          @click="toggleInfoWindow(m)"
        ></GmapMarker>
      </GmapMap>
    </div>

    <v-card class="visit-info-card ml-2 pa-1" v-show="notExists">
      <v-card-text>
        <my-icon-text iconName="mdi-information-outline" class="mb-2" size="21">
          <strong>まだ行き先が登録されていないようです</strong>
        </my-icon-text>
        <p>行き先を検索して穴場スポットを見つけてみませんか？</p>
        <v-btn
          color="#1FAB89"
          class="white--text"
          large
          @click="$router.push('/search').catch(e=>{})"
        >穴場スポットを探す</v-btn>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import IconText from "./../molecules/iconText.vue";
import Geolocation from "./../../modules/geolocation.js";
import { createNamespacedHelpers } from "vuex";
const { mapActions: mapActionsOfDestination } = createNamespacedHelpers(
  "Destination"
);
export default {
  components: {
    "my-icon-text": IconText
  },
  data() {
    return {
      destinations: [],
      notExists: false,
      center: {},
      zoom: 11,
      marker_items: [],
      item: {},
      infoOptions: {
        pixelOffset: {
          width: 0,
          height: -40
        }
      },
      infoWindowPos: null,
      infoWinOpen: false
    };
  },
  ////////////////////////////////////////////////////////////////////////////
  async created() {
    // 登録した行き先を取得
    this.destinations = await this.getDestination();
    if (this.destinations.length == 0) {
      this.notExists = true;
    }
    // 行き先をGoogleMap用にフォーマットして格納
    for (let val of this.destinations) {
      let marker_data = {};
      marker_data.position = {};
      for (let key in val) {
        // latとlngはpositionオブジェクトに格納
        if (key == "lat" || key == "lng") {
          marker_data.position[key] = parseFloat(val[key]);
          // その他はそのまま格納
        } else {
          marker_data[key] = val[key];
        }
      }
      // オブジェクトをリストに格納
      this.marker_items.push(marker_data);
    }
    let ok;
    [this.center, ok] = await Geolocation.getCurrentPosition();
  },
  ////////////////////////////////////////////////////////////////////////////
  methods: {
    ...mapActionsOfDestination(["getAllDestination"]),
    toggleInfoWindow(marker) {
      // マーカーをつける位置をセット
      this.infoWindowPos = marker.position;
      this.infoWinOpen = true;
      // Gmapピンのwindowに表示する値をセット
      for (let key in marker) {
        this.item[key] = marker[key];
      }
    },
    ////////////////////////////////////////////////////////////////////////////
    async getDestination() {
      let data = await this.getAllDestination();
      return data.destinations;
    }
  }
};
</script>

<style>
.visit-info-card {
  position: absolute;
  top: 75px;
  text-align: center;
}
.visit-g-map-size {
  width: 100vw;
  height: 100vh;
}
.img-height {
  height: 250px;
}
.g-window-size {
  width: 450px;
}
@media screen and (max-width: 1264px) {
  .img-height {
    height: 250px;
  }
  .g-window-size {
    width: 450px;
  }
}
@media screen and (max-width: 959px) {
  .img-height {
    height: 250px;
  }
  .g-window-size {
    width: 400px;
  }
}
@media screen and (max-width: 599px) {
  .img-height {
    height: 210px;
  }
  .g-window-size {
    width: 390px;
  }
}
</style>