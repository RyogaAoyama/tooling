<template>
  <transition>
    <div class="bottom-right" @click="onclick">
      <v-btn fab dark large color="primary">
        <v-icon dark><slot></slot></v-icon>
      </v-btn>
    </div>
  </transition>
</template>

<script>
export default {
  methods: {
    onclick() {
      this.$emit("bottomBtn");
    }
}
};
</script>

<style>
.bottom-right {
  position: fixed;
  z-index: 1000;
  bottom: 25px;
  right: 25px;
}

.v-enter,
.v-leave-to {
  opacity: 0;
}
.v-enter-to,
.v-leave {
  opacity: 1;
}
.v-enter-active,
.v-leave-active {
  transition: opacity 0.2s;
}
</style>
