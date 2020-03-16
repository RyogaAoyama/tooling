<template>
  <div @click="flash">
    <v-alert :type="type" v-show="isShow" class="my-alert">{{ msg }}</v-alert>
  </div>
</template>

<script>
import { createNamespacedHelpers } from "vuex";

const {
  mapState: mapStateOfAlert,
  mapMutations: mapMutationsOfAlert
} = createNamespacedHelpers("Alert");

export default {
  watch: {
    $route: function(to, from) {
      this.flash();
    }
  },
  methods: {
    ...mapMutationsOfAlert(["setIsShow", "setMsg"]),
    flash() {
      if (this.isShow) {
        this.setIsShow(false);
        this.setMsg("");
      }
    }
  },
  computed: {
    ...mapStateOfAlert(["type", "msg", "isShow", "flashed"])
  },
  created() {
    this.setIsShow(false);
    this.setMsg("");
  }
};
</script>

<style>
.my-alert {
  position: relative;
  z-index: 9999;
  width: 100%;
}
</style>