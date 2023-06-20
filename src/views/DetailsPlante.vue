<template>
  <PlanteCard :plante="plante" />
</template>

<script>
import PlanteCard from "../components/PlanteComponent.vue";
import axios from "axios";
import swal from "sweetalert";

const url = window.location.href;
const lastParam = url.split("/").slice(-1)[0];
console.log(url);
console.log(lastParam);

export default {
  name: "DetailsPlante",
  components: {
    PlanteCard,
  },
  data() {
    return {
      plante: [],
    };
  },
  created: function () {
    this.fetchPlante();
  },
  mounted: function () {
    this.fetchPlante();
  },
  methods: {
    fetchPlante: async function () {
      try {
        await axios
          .get(`http://localhost:80/plantes/${lastParam}`)
          .then((res) => {
            this.plante = res.data;
            console.log(this.plante);
          });
      } catch (error) {
        swal(
          "Veuillez nous excuser...",
          "Une erreur est survenue de notre côté",
          "error"
        );
        console.log(error);
      }
    },
  },
};
</script>
