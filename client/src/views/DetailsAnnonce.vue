<template>
  <div class="annonce_component">
    <div class="d-flex row justify-content-center mb-5 gap-5">
      <h1>{{ annonce.titre }}</h1>
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
      </div>
      <div class="d-flex row mx-10 col-md-8">
        <div
          class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white rounded"
        >
          <div class="list-group list-group-flush border-bottom scrollarea">
            <div
              class="list-group-item list-group-item-action py-3 lh-tight"
              v-for="commentairesDetail in commentairesDetails"
              :key="commentairesDetail"
            >
              <div class="d-flex text-left justify-content-between">
                <strong class="mb-1">{{
                  commentairesDetail.utilisateurDetails.pseudo
                }}</strong>
              </div>
              <div class="col-12 mb-1 small">
                {{ commentairesDetail.message }}
              </div>
            </div>
          </div>
        </div>
        <div>
          <div
            class="d-flex align-items-center flex-shrink-0 py-3 px-5 link-dark text-decoration-none gap-2"
          >
            <input
              class="form-control w-50 rounded"
              v-model="pseudo"
              placeholder="Pseudo"
            />
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
        <!-- <ChatComponent
          :commentairesDetails="commentairesDetails"
          :annonce="annonce"
        /> -->
      </div>
    </div>
  </div>
</template>

<script>
// import ChatComponent from "@/components/ChatComponent.vue";
import axios from "axios";
import { ref } from "vue";
import swal from "sweetalert";

const url = window.location.href;
const lastParam = url.split("/").slice(-1)[0];

export default {
  name: "DetailsAnnonce",
  components: {
    // ChatComponent,
  },
  data() {
    return {
      annonce: {},
      utilisateur: {},
      utilisateursPartOld: [],
      utilisateursPart: [],
      plantes: [],
      commentaires: [],
      commentairesDetails: [],
      commentairesDetail: "",
      pseudo: ref(""),
      commentaire: ref(""),
    };
  },
  mounted: async function () {
    this.fetchAnnonce();
    this.fetchComments();
  },
  created: async function () {
    await this.fetchAnnonce();
    await this.fetchComments();
  },
  methods: {
    fetchAnnonce: async function () {
      try {
        await axios
          .get("https://localhost/annonces/" + lastParam)
          .then((res) => {
            this.annonce = res.data;
            this.plantes = res.data.plantes;
            this.commentaires = res.data.commentaires;
            console.log(this.commentaires);
            this.utilisateursPartOld = res.data.utilisateursPart;
          });
      } catch (error) {
        swal(
          "Veuillez nous excuser...",
          "Une erreur est survenue de notre côté",
          "error"
        );
      }
    },
    patchUtilisateurPartOfAnnonce: async function () {
      try {
        this.utilisateursPartOld.push(`/utilisateurs/${this.utilisateur}`);
        this.utilisateursPart = new Set(this.utilisateursPartOld);
        await axios
          .patch(
            "https://localhost/annonces/" + lastParam,
            {
              utilisateursPart: [this.utilisateursPart],
            },
            {
              headers: {
                "Content-Type": "application/merge-patch+json",
              },
            }
          )
          .then(() => {
            this.fetchAnnonce();
            console.log(this.annonce);
          });
      } catch (error) {
        swal(
          "Veuillez nous excuser...",
          "Une erreur est survenue de notre côté",
          "error"
        );
      }
    },
    fetchComments: async function () {
      for (const commentaire of this.commentaires) {
        try {
          const response = await axios.get("https://localhost" + commentaire);
          const commentaireDetails = response.data;
          const utilisateurResponse = await axios.get(
            "https://localhost" + commentaireDetails.utilisateur
          );
          commentaireDetails.utilisateurDetails = utilisateurResponse.data;
          this.commentairesDetails.push(commentaireDetails);
          console.log(this.commentairesDetails);
        } catch (error) {
          swal(
            "Veuillez nous excuser...",
            "Une erreur est survenue de notre côté",
            "error"
          );
        }
      }
    },
    submit: async function () {
      try {
        await axios
          .get(
            `https://localhost/utilisateurs_from_pseudo?page=1&pseudo=${this.pseudo}`
          )
          .then((res) => {
            this.utilisateur = res.data;
            this.patchUtilisateurPartOfAnnonce();
          })
          .then(() => {
            axios
              .post("https://localhost/commentaires", {
                message: `${this.commentairesDetail}`,
                annonce: `/annonces/${this.annonce.id}`,
                utilisateur: `/utilisateurs/${this.utilisateur}`,
              })
              .then(swal("Bien joué!", "message envoyé!", "success"))
              .then(() => {
                this.commentaires = [];
                this.fetchAnnonce();
                this.fetchComments();
              })
              .catch(() => {
                swal(
                  "Veuillez nous excuser...",
                  "Une erreur est survenue de notre côté",
                  "error"
                );
              });
          });
      } catch (error) {
        swal("Surnom inconnu...", "Veuillez choisir un surnom valide", "error");
      }
    },
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
.scrollarea {
  min-height: 500px;
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
