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
    marker_data.position.lat = parseFloat(this.searchResult.lat);
    marker_data.position.lng = parseFloat(this.searchResult.lng);
    marker_data.position.title = this.searchResult.name;
    this.marker_items.push(marker_data);

    this.center = {
      lat: parseFloat(this.searchResult.lat),
      lng: parseFloat(this.searchResult.lng)
    };
  }
};
</script>

<style>
.g-map-size {
  height: 90vh;
}
</style>
