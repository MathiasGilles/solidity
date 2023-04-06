<template>
  <div>
    <button @click="connectMetamask" v-bind:disabled="currentAccount">
      Connecter à Metamask
    </button>
    <div v-if="currentAccount">
      <p>Compte connecté : {{ currentAccount }}</p>
    </div>
  </div>
</template>

<script>
import detectEthereumProvider from "@metamask/detect-provider";

export default {
  data() {
    return {
      currentAccount: null,
    };
  },
  methods: {
    async connectMetamask() {
      const provider = await detectEthereumProvider();

      if (provider) {
        try {
          await provider.request({ method: "eth_requestAccounts" });
          const accounts = await provider.request({ method: "eth_accounts" });
          this.currentAccount = accounts[0];
          console.log("Connecté à Metamask");
          this.$forceUpdate();
        } catch (error) {
          console.error(error);
        }
      } else {
        alert("Veuillez installer Metamask pour continuer");
      }
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
