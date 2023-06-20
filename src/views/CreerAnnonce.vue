<template>
  <h1>Création d'une annonce</h1>
  <div v-if="!data.length">
    <div class="d-flex flex-column align-items-center">
      <!-- Trouver comment revenir sur cette page sans avoir à réactualiser la page quand on a soumis le formulaire -->
      <form
        class="row g-3 justify-content-center align-items-stretch container text-left mt-2"
        v-on:submit.prevent="submitAnnonce"
        method="POST"
      >
        <div class="col-md-10">
          <p class="text-end">*champs obligatoires</p>
          <div class="input-group has-validation">
            <span class="input-group-text">Nom de l'annonce*</span>
            <input
              type="text"
              class="form-control"
              v-model="annonce.titre"
              maxlength="90"
              placeholder="Garde d'un rosier en pot"
              required
            />
            <div class="invalid-feedback">Veuillez remplir ce champs</div>
          </div>
        </div>

        <!-- <div class="col-md-10">
          <input class="form-control" type="file" id="formFile" />
        </div> -->

        <!-- <div class="col-md-10">
          <label>Prendre une photo :</label>
          <CameraComponent
            class="border-primary p-2 w-100"
            :items="annonce.items"
          ></CameraComponent>
        </div> -->
        <div class="mt-5 col-md-10">
          <span class="input-group-text">Etat de l'annonce*</span>
          <select class="form-select" v-model="annonce.etat" required>
            <option selected disabled value="">Choisissez un état...</option>
            <option v-for="etat in etats" :key="etat" :value="etat">
              {{ etat }}
            </option>
          </select>
          <div class="invalid-feedback">L'annonce doit posséder un état</div>
        </div>

        <div class="mt-5 col-md-10">
          <div class="has-validation">
            <span class="input-group-text">Description*</span>
            <textarea
              class="form-control"
              v-model="annonce.description"
              rows="8"
              placeholder="A arroser 2 à 3 fois par semaine"
              required
            ></textarea>
            <div class="invalid-feedback">Veuillez remplir ce champs</div>
          </div>
        </div>

        <div class="mt-5 col-md-10" id="numero">
          <div class="input-group has-validation">
            <span class="input-group-text">Numéro de rue/voie*</span>
            <input
              type="number"
              class="form-control"
              v-model="annonce.numero"
              placeholder="1"
              min="1"
              max="999"
              required
            />
            <div class="invalid-feedback">Veuillez remplir ce champs</div>
          </div>
        </div>

        <div class="mt-5 col-md-10" id="voie">
          <div class="input-group has-validation">
            <span class="input-group-text">Rue/Voie*</span>
            <input
              type="text"
              class="form-control"
              v-model="annonce.rue"
              maxlength="90"
              placeholder="rue de la rose"
              required
            />
            <div class="invalid-feedback">Veuillez remplir ce champs</div>
          </div>
        </div>

        <div class="mt-5 col-md-10" id="cp">
          <div class="input-group has-validation">
            <span class="input-group-text">Code postal*</span>
            <input
              type="number"
              class="form-control"
              v-model="annonce.codePostal"
              v-on:change="checkCP"
              id="cp"
              placeholder="44000"
              required
            />
            <!-- checkCP vérifie que l'utilisateur tape un code postal valide -->
            <div class="invalid-feedback">Veuillez remplir ce champs</div>
          </div>
        </div>

        <div class="mt-5 col-md-10" id="ville">
          <div class="input-group has-validation">
            <span class="input-group-text">Ville*</span>
            <input
              type="text"
              class="form-control"
              v-model="annonce.ville"
              maxlength="90"
              placeholder="Nantes"
              onkeydown="return /[a-z]/i.test(event.key)"
              required
            />
            <!-- onkeydown permet à l'utilisateur de taper uniquement des lettres -->
            <div class="invalid-feedback">Veuillez remplir ce champs</div>
          </div>
        </div>

        <div class="mt-5 col-md-10">
          <span class="input-group-text">Plante*</span>
          <select class="form-select" v-model="annonce.plantes" required>
            <option selected disabled value="">Choisissez une plante...</option>
            <option v-for="plante in plantes" :key="plante.id" :value="plante">
              {{ plante }}
            </option>
          </select>
          <div class="invalid-feedback">Veuillez sélectionner une plante</div>
        </div>

        <div class="mt-5 mb-10">
          <button class="btn btn-danger me-5" type="reset">Annuler</button>
          <button class="btn btn-success" type="submit">Valider</button>
        </div>
      </form>
    </div>
  </div>
  <div v-else>
    <div
      class="alert alert-success alert-dismissible fade show w-50 mt-4 d-inline-flex"
      role="alert"
    >
      <div>Vous venez de créer une annonce !</div>
      <button
        type="button"
        class="btn-close"
        data-bs-dismiss="alert"
        aria-label="Close"
      ></button>
    </div>
    <div class="card">
      <div class="card-body">
        <h4 class="card-title">Rappel des informations</h4>
        <p class="mt-4 card-text fw-normal">
          <b>Titre de l'annonce :</b> {{ data[0].titre }}
        </p>
        <p class="mt-4 card-text fw-normal">
          <b>Description de l'annonce :</b> {{ data[0].description }}
        </p>
        <p class="mt-4 card-text fw-normal">
          <b>Adresse :</b> {{ data[0].numero }}
          {{ data[0].rue }}
          {{ data[0].codePostal }}
          {{ data[0].ville }}
        </p>
        <p class="mt-4 card-text fw-normal">
          <b>Plante :</b> {{ selectedPlant.nom }}
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import swal from "sweetalert";

//import CameraComponent from "../components/CameraComponent.vue";

export default {
  name: "CreerAnnonce",
  components: {
    //CameraComponent,
  },
  data() {
    return {
      annonce: [
        {
          etat: "",
          titre: "",
          description: "",
          numero: 0,
          ville: "",
          rue: "",
          codePostal: "",
          plantes: [],
          utilisateurProp: "",
          utilisateursPart: [],
          commentaires: [],
        },
      ],
      etats: ["Active", "Innactive"],
      plantes: [],
      data: [],
    };
  },
  created() {
    this.fetchPlantes();
  },
  mounted() {
    this.fetchPlantes();
  },
  methods: {
    checkCP() {
      const Reg = new RegExp(/^(([0-8][\d])|(9[0-5]))[\d]{3}$/);
      if (!Reg.test(document.getElementById("cp").value))
        swal(
          "Erreur de syntaxe !",
          "Votre code postal ne comporte pas 5 chiffres",
          "error"
        );
    },
    submitAnnonce: async function () {
      try {
        await axios.post("http://localhost:80/annonces", this.annonce);
      } catch (error) {
        swal(
          "Veuillez nous excuser...",
          "Une erreur est survenue de notre côté",
          "error"
        );
        console.error(error);
      }
    },
    fetchPlantes: async function () {
      try {
        await axios.get("http://localhost:80/plantes?page=1").then((res) => {
          this.plantes = new Set(
            res.data["hydra:member"].map((plante) => plante.nom)
          );
          console.log(this.plantes);
        });
      } catch (error) {
        swal(
          "Veuillez nous excuser...",
          "Une erreur est survenue de notre côté",
          "error"
        );
        console.error(error);
      }
    },
  },
};
</script>

<style scoped>
.card {
  border-color: var(--color-background);
  background-color: var(--color-background);
}

.input-group-text {
  color: var(--color-secondary);
}

@media (max-width: 991.98px) {
  #numero {
    flex: 0 0 auto;
    width: 42%;
  }
  #voie {
    flex: 0 0 auto;
    width: 83.33333333%;
  }
  #cp {
    flex: 0 0 auto;
    width: 42%;
  }
  #ville {
    flex: 0 0 auto;
    width: 75%;
  }
}
</style>
