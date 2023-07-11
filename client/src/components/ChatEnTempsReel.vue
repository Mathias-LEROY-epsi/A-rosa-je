<!-- <template>
  <div class="container">
    <div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white">
      <div
        class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom gap-2"
      >
        <input
          class="fs-5 fw-semibold px-2"
          v-model="username"
          placeholder="username"
        />
        <form @submit.prevent="submit">
          <button>vérifier</button>
        </form>
      </div>
      <div class="list-group list-group-flush border-bottom scrollarea">
        <div
          class="list-group-item list-group-item-action py-3 lh-tight"
          v-for="message in messages"
          :key="message"
        >
          <div class="d-flex w-100 align-items-center justify-content-between">
            <strong class="mb-1">{{ message.username }}</strong>
          </div>
          <div class="col-10 mb-1 small">{{ message.message }}</div>
        </div>
      </div>
    </div>
    <form @submit.prevent="submit">
      <input
        class="form-control"
        placeholder="Write a message"
        v-model="message"
      />
    </form>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import Pusher from "pusher-js";
import axios from "axios";

export default {
  name: "ChatEnTempsReel",
  setup() {
    const username = ref("");
    const messages = ref([]);
    const message = ref("");

    onMounted(() => {
      // Pusher.logToConsole = true;
      // const pusher = new Pusher("1d53f5b0fed7a2495082", {
      //   cluster: "eu",
      // });
      // const channel = pusher.subscribe("chat");
      // channel.bind("message", (data) => {
      //   messages.value.push(data);
      // });
    });

    const submit = async () => {
      await axios
        .get(
          `https://localhost:80/utilisateurs_from_pseudo?page=1&pseudo=${username.value}`
        )
        .then((res) => {
          console.log(res.data["hydra:member"][0].id);
          axios
            .post("https://localhost:80/messages", {
              message: message.value,
              user: `/utilisateurs/${res.data["hydra:member"][0].id}`,
            })
            .then((res) => {
              console.log(res);
            })
            .catch((err) => {
              console.log(err);
            });
        });

      message.value = "";
    };

    return {
      username,
      messages,
      message,
      submit,
    };
  },
};
</script> -->

<style>
.scrollarea {
  min-height: 500px;
}
</style>
