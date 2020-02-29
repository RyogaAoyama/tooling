<template>
  <div>
    <v-alert :type="type" v-show="isShow" dismissible>
      {{ msg }}
    </v-alert>
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
    '$route': function (to, from) {
      if (this.flashed && this.isShow) {
        this.setIsShow(false);
        this.setMsg("");
        this.setFlashed(false);
      } else if (!this.flashed && this.isShow) {
        this.setFlashed(true);
      }
    }
  },
  methods: {
    ...mapMutationsOfAlert(["setIsShow", "setMsg", "setFlashed"])
  },
  computed: {
    ...mapStateOfAlert(["type", "msg", "isShow", "flashed"])
  }

}
</script>

<style>

</style>