<template>
  <v-container>
    <my-icon-text size="30" iconName="mdi-format-list-bulleted" class="mt-10 mb-1">
      <strong>行き先一覧</strong>
    </my-icon-text>
    <hr size="7" color="#1FAB89" class="mb-2" noshade />
    <h3 class="mb-2">今まで訪れた場所 {{ visitCnt }}/{{ destinations.length }}</h3>
    <v-row justify="start">
      <v-col
        xl="3"
        lg="4"
        md="6"
        sm="6"
        xs="12"
        v-for="destination in destinations"
        :key="destination.id"
      >
        <my-destination :destination="destination" @update="update" @destroy="destroy"></my-destination>
      </v-col>
    </v-row>
    <my-destination-none v-show="destinations.length == 0"></my-destination-none>
  </v-container>
</template>

<script>
import IconText from "./../../molecules/iconText.vue";
import Destination from "./../../organisms/destination.vue";
import DestinationNone from "./../../molecules/destinationNone.vue";
import { createNamespacedHelpers } from "vuex";

const { mapActions: mapActionsOfDestination } = createNamespacedHelpers(
  "Destination"
);

const { mapActions: mapActionsOfAlert } = createNamespacedHelpers("Alert");

export default {
  data: function() {
    return {
      destinations: [],
      visitCnt: 0
    };
  },
  components: {
    "my-icon-text": IconText,
    "my-destination": Destination,
    "my-destination-none": DestinationNone
  },
  async created() {
    let data = await this.getDestination();
    this.destinations = data.destinations;
    this.getVisitCnt();
  },
  methods: {
    ...mapActionsOfAlert(["setAlert"]),
    ...mapActionsOfDestination([
      "getAllDestination",
      "updateDestination",
      "destroyDestination"
    ]),
    async getDestination() {
      return await this.getAllDestination();
    },
    async update(e) {
      let data = await this.updateDestination(e);
      // データを更新
      this.destinations.forEach((val, idx) => {
        if (val.id == data.destination.id) {
          this.$set(this.destinations, idx, data.destination);
        }
      });
      this.getVisitCnt();
    },
    async destroy(e) {
      await this.destroyDestination(e);
      this.destinations.forEach((destination, idx) => {
        if (destination.id == e) {
          this.destinations.splice(idx, 1);
          this.setAlert({
            msg: `${destination.name}を一覧から削除しました。`,
            type: "error"
          });
        }
      });
    },
    getVisitCnt() {
      this.visitCnt = 0;
      for (let destination of this.destinations) {
        if (destination.is_visit) {
          this.visitCnt++;
        }
      }
    }
  }
};
</script>

<style>
</style>