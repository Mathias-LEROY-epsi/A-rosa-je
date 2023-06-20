<template>
  <div class="annonce_component">
    <h1 class="mb-4">{{ annonce.titre }}</h1>
    <div class="d-flex justify-content-center mb-5">
      <div
        class="card"
        style="
          border-color: var(--color-background);
          background-color: var(--color-background);
        "
      >
        <div class="row g-4">
          <!-- <div
            class="list-group-item list-group-item-action py-3 lh-tight"
            v-for="plante in plantes"
            :key="plante"
          >
            <div
              class="d-flex w-100 align-items-center justify-content-between"
            >
              <strong class="mb-1">{{ plante }}</strong>
            </div>
            <div class="col-10 mb-1 small">{{ message.message }}</div>
          </div> -->
        </div>
        <div class="col-md-12">
          <div class="card-body">
            <h3 class="card-title">Description :</h3>
            <p class="card-text fw-normal">{{ annonce.description }}</p>
          </div>
        </div>

        <h3 class="mb-4">Catalogue des botanistes</h3>
        <div class="col-md-12">
          <div class="d-flex justify-content-evenly" id="catalogue">
            <router-link :to="`/plantes/1`"
              ><img src="../assets/img/rose1.jpg" alt="image_rose1"
            /></router-link>
            <router-link :to="`/plantes/2`"
              ><img src="../assets/img/rose2.jpg" alt="image_rose2"
            /></router-link>
            <router-link :to="`/plantes/3`"
              ><img src="../assets/img/rose3.jpg" alt="image_rose3"
            /></router-link>
          </div>
        </div>
        <div class="col-md-12">
          <div class="card-body">
            <h3 class="card-title">Commentaires :</h3>
            <!-- <div
              class="d-flex text-left"
              v-for="commentairesDetail in commentairesDetails"
              :key="commentairesDetail"
            >
              <p class="card-text fw-normal">
                <strong>
                  {{ commentairesDetail.utilisateurDetails.pseudo }} :
                </strong>
                {{ commentairesDetail.message }}
              </p>
            </div> -->
            <CommentairesComponent
              :commentairesDetails="commentairesDetails"
              :annonce="annonce"
            >
            </CommentairesComponent>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "AnnonceComponent",
  props: {
    annonce: {},
    plantes: [],
    commentairesDetails: [],
  },
};
</script>

<style scoped>
.card > img {
  width: 80%;
  margin: 0 auto;
}
img {
  width: 100vw;
  height: 16vh;
  max-width: 200px;
  max-height: 150px;
}
@media (max-width: 540px) {
  #catalogue {
    display: flex !important;
    flex-direction: column !important;
    align-items: center;
    margin-bottom: 50px;
  }
}
</style>
