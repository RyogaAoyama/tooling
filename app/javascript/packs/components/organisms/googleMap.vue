<template>
  <div class="app">
    <div id="map">
      <GmapMap :center="center" :zoom="zoom" class="g-map-size">
        <GmapMarker
          v-for="(m, id) in marker_items"
          :position="m.position"
          :title="m.title"
          :clickable="true"
          :draggable="true"
          :key="id"
        ></GmapMarker>
      </GmapMap>
    </div>
  </div>
</template>

<script>
export default {
  props: ["searchResult"],
  data() {
    return {
      center: {},
      zoom: 12,
      marker_items: []
    };
  },
  created() {
    let marker_data = {};
    marker_data.position = {};
    marker_data.position.lat = this.searchResult.lat;
    marker_data.position.lng = this.searchResult.lng;
    marker_data.position.title = this.searchResult.name;
    this.marker_items.push(marker_data);

    this.center = { lat: this.searchResult.lat, lng: this.searchResult.lng };
  }
};
</script>

<style>
.g-map-size {
  height: 1200px;
}
@media screen and (max-width: 1264px) {
  .g-map-size {
    height: 950px;
  }
}
@media screen and (max-width: 959px) {
  .g-map-size {
    height: 700px;
  }
}
@media screen and (max-width: 599px) {
  .g-map-size {
    height: 500px;
  }
}
</style>
