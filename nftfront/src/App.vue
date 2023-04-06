<template>
  <div id="app">
    <button v-if="!this.currentAccount" @click="connectMetamask">CONNECT </button>
    <div v-if="this.currentAccount">
      <button @click="addNFT">ADD</button>
      <button @click="getNFTbyIndex">GET BY INDEX</button>
      <button @click="getNFTs">GET ALL</button>
      <button @click="getOwnedNFT">GET OWNED</button>
    </div>
    <div class="card__container" >
      <div v-for="nft, index in nfts" :key="index" class="card">
        <p>Name : {{nft.name}}</p>
        <p>Image : {{nft.image}}</p>
        <p>price : {{nft.price}}</p>
        <button v-if="nft.owner === '0x0000000000000000000000000000000000000000'" @click="buyNFT(index)">buy</button>
        <img class="image" :src="`/${nft.image}`" alt="nft image">
      </div>
    </div>
  </div>
</template>

<script>
import detectEthereumProvider from "@metamask/detect-provider";

export default {
  name: 'App',
  data(){
    return{
      nfts: [],
      currentAccount: null,
    }
  },
  methods: {
    addNFT(){
      this.$contract.methods.addNFT("test", "1.jpg", 10).send({from: this.currentAccount},
        (res)=>{
          console.log(res)
          this.getNFTs()
        })
  },
  getNFTCount(){
    this.$contract.methods.getNFTCount().call().then(
      function(res){
        console.log(res)
      })
  },
  getNFTbyIndex(){
    this.$contract.methods.getNFTbyIndex(0).call().then(
      function(res){
        console.log(res)
      })
  },
  buyNFT(id){
    this.$contract.methods.buyNFT(id).send({from: this.currentAccount,value : this.nfts[id].price},
        (res)=>{
          console.log(res)
        })
  },
  getNFTs(){
    this.$contract.methods.getNFTs().call().then(
      (res) =>{
        console.log(res)
        this.$set(this.$data, 'nfts', res)
      })
  },
  getOwnedNFT(){
    this.$contract.methods.getNFTsByOwner(this.currentAccount).call().then(
      (res) =>{
        this.$set(this.$data, 'nfts', res)
      })
  },

  async connectMetamask() {
      const provider = await detectEthereumProvider();
      if (provider) {
        try {
          await provider.request({ method: "eth_requestAccounts" });
          const accounts = await provider.request({ method: "eth_accounts" });
          this.currentAccount = accounts[0];
          console.log("Connecté à Metamask", this.currentAccount);
          this.$forceUpdate();
        } catch (error) {
          console.error(error);
        }
      } else {
        alert("Veuillez installer Metamask pour continuer");
      }
    },
  },

  mounted(){
   this.getNFTs()
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
.card{
  width: 100px;
  border: 1px solid black;
  margin: 10px;
  padding:10px;
  border-radius: 10px;
}
.card__container{
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
}
.image{
  width: 100%;
}
</style>
