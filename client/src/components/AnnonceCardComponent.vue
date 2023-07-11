<template>
  <div class="card m-4">
    <img
      src="../assets/img/Fleur.png"
      class="card-img mt-4 img-fluid"
      alt="image de l'annonce"
    />
    <div class="card-body">
      <h5 class="card-title">{{ annonce.titre }}</h5>
      <p class="card-text">
        {{ annonce.description }}
      </p>
      <router-link :to="`annonces/${annonce.id}`" class="btn goto">
        Voir l'annonce
      </router-link>
    </div>
  </div>
</template>

<script>
export default {
  name: "AnnonceCardComponent",
  props: {
    annonce: null,
    annonce_id: null,
  },
  computed: {
    id() {
      console.log(this.annonce);
      //this.annonce_id = annonce["@id"];
      return this.annonce_id;
    },
  },
};
</script>

<style scoped>
.card {
  border: var(--border-3);
  width: 19rem;
}

.card-body {
  display: flex;
  flex-direction: column;
}

.card > img {
  width: 80%;
  margin: 0 auto;
}

.card-text {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.card .goto {
  background-color: var(--color-secondary);
  color: var(--color-light);
  position: relative;
  margin-top: auto;
  margin-bottom: 10px;
}

.card .goto:hover,
.card .goto:focus {
  background-color: var(--color-primary);
  color: var(--color-secondary);
}
</style>
