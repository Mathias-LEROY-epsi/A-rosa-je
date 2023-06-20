<template>
  <div class="container">
    <div
      class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white rounded w-100"
    >
      <div class="list-group list-group-flush border-bottom scrollarea">
        <div
          class="list-group-item list-group-item-action py-3 lh-tight"
          v-for="commentairesDetail in commentairesDetails"
          :key="commentairesDetail"
        >
          <div class="d-flex w-100 align-items-center justify-content-between">
            <strong class="mb-1">{{
              commentairesDetail.utilisateurDetails.pseudo
            }}</strong>
          </div>
          <div class="col-12 mb-1 small">{{ commentairesDetail.message }}</div>
        </div>
      </div>
    </div>
    <div>
      <div
        class="d-flex align-items-center flex-shrink-0 py-3 px-5 link-dark text-decoration-none gap-2"
      >
        <input
          class="form-control w-25 rounded"
          v-model="pseudo"
          placeholder="Pseudo"
        />
        <form @submit.prevent="checkValidity">
          <button class="rounded">Vérifier</button>
        </form>
      </div>
      <div
        class="d-flex align-items-center flex-shrink-0 pb-5 px-5 link-dark text-decoration-none gap-2"
      >
        <input
          class="form-control"
          placeholder="Laisse un commentaire..."
          v-model="commentairesDetail"
        />
        <form @submit.prevent="submit">
          <button class="rounded">Envoyer</button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import axios from "axios";
import swal from "sweetalert";

export default {
  name: "CommentairesComponent",
  setup() {
    const pseudo = ref("");
    const commentaire = ref("");

    const checkValidity = async () => {
      try {
        await axios
          .get(
            `http://localhost:80/utilisateurs_from_pseudo?page=1&pseudo=${pseudo.value}`
          )
          .then(swal("Good job!", "You clicked the button!", "success"));
      } catch (error) {
        swal("Surnom inconnu...", "Veuillez choisir un surnom valide", "error");
        console.log(error);
      }
    };

    const submit = async () => {
      try {
        await axios
          .get(
            `http://localhost:80/utilisateurs_from_pseudo?page=1&pseudo=${pseudo.value}`
          )
          .then((res) => {
            console.log(res.data["hydra:member"][0].id);
            axios
              .post("http://localhost:80/commentaires", {
                message: commentaire.value,
                annonce: `/annonces/1`,
                utilisateur: `/utilisateurs/${pseudo.value}`,
              })
              .then((res) => {
                console.log(res);
              })
              .catch((err) => {
                console.log(err);
              });
          });
      } catch (error) {
        swal(
          "Veuillez nous excuser...",
          "Une erreur est survenue de notre côté",
          "error"
        );
        console.log(error);
      }

      commentaire.value = "";
    };

    return {
      pseudo,
      commentaire,
      submit,
      checkValidity,
    };
  },
  data() {
    return {
      commentaires: [],
      commentairesDetails: [],
    };
  },
};
</script>

<style>
.scrollarea {
  min-height: 500px;
}
</style>
