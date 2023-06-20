import { createRouter, createWebHashHistory } from "vue-router";
import ListeAnnonces from "../views/ListeAnnonces.vue";
import DetailsPlante from "../views/DetailsPlante.vue";
import DetailsAnnonce from "../views/DetailsAnnonce.vue";
import CreerAnnonce from "../views/CreerAnnonce.vue";
import NotFound from "../views/NotFound.vue";

// import ChatComponent from "../components/ChatComponent.vue";

const routes = [
  {
    path: "/",
    name: "home",
    component: ListeAnnonces,
  },
  // {
  //   path: "/chat",
  //   name: "conversation",
  //   component: ChatComponent,
  // },
  {
    path: "/plantes/:id",
    name: "plante",
    component: DetailsPlante,
  },
  {
    path: "/annonces/:id",
    name: "annonce",
    component: DetailsAnnonce,
  },
  {
    path: "/nouvelle-annonce",
    name: "creerAnnonce",
    component: CreerAnnonce,
  },
  {
    path: "/:catchAll(.*)",
    name: "notFound",
    component: NotFound,
  },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;
