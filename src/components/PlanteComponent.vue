<template>
  <div class="container text-center">
    <h1>{{ plante.nom }}</h1>
    <div class="container mt-3">
      <div class="row justify-content-center gap-4">
        <img
          src="../assets/img/rose4.jpg"
          alt="Plante"
          width="550"
          height="400"
        />
        <div class="col-md-12">
          <div
            class="card-body d-flex justify-content-start align-items-center ms-5"
          >
            <h4 class="card-title me-4">Famille :</h4>
            <p class="card-text fw-normal">{{ plante.famille }}</p>
          </div>
        </div>
        <div class="col-md-12">
          <div
            class="card-body d-flex justify-content-start align-items-center ms-5"
          >
            <h4 class="card-title me-4">Dimension :</h4>
            <p class="card-text fw-normal">{{ plante.dimension }}</p>
          </div>
        </div>
        <div class="col-md-12">
          <div
            class="card-body d-flex justify-content-start align-items-center ms-5"
          >
            <h4 class="card-title me-4">Exposition :</h4>
            <p class="card-text fw-normal">{{ plante.exposition }}</p>
          </div>
        </div>
        <div class="col-md-12">
          <div
            class="card-body d-flex justify-content-start align-items-center ms-5"
          >
            <h4 class="card-title me-4">Arrosage :</h4>
            <p class="card-text fw-normal">{{ plante.arrosage }}</p>
          </div>
        </div>
        <div class="col-md-12">
          <div
            class="card-body d-flex justify-content-start align-items-center ms-5"
          >
            <h4 class="card-title me-4">Description :</h4>
            <p class="card-text fw-normal">{{ plante.description }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "PlanteCard",
  props: {
    plante: [],
  },
  data() {
    return {};
  },
};
</script>

<style scoped>
@media (max-width: 991.98px) {
  img {
    height: 40vh;
    width: 65vw;
    margin-bottom: 20px;
  }
}
@media (max-width: 750px) {
  img {
    height: 20vh;
    width: 40vw;
    margin-bottom: 20px;
  }
}
@media (max-width: 650px) {
  img {
    height: 20vh;
    width: 50vw;
    margin-bottom: 20px;
  }
}
@media (max-width: 500px) {
  img {
    height: 20vh;
    width: 60vw;
    margin-bottom: 20px;
  }
}
@media (max-width: 400px) {
  img {
    height: 20vh;
    width: 50vw;
    margin-bottom: 20px;
  }
}
@media (max-width: 350px) {
  img {
    height: 22vh;
    width: 70vw;
    margin-bottom: 20px;
  }
}
@media (max-width: 250px) {
  img {
    height: 15vh;
    width: 80vw;
    margin-bottom: 20px;
  }
}
</style>
