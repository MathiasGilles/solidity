<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/logo.png">
    <Button></Button>
    <button @click="getNFTCount">getNFTCount test</button>
    <button @click="addNFT">addNFT test</button>
    <button @click="getNFTbyIndex">getNFTbyIndex test</button>
    <button @click="getNFTs">getNFTs test</button>
    <button @click="getOwnedNFT">getOwnedNFT test</button>
    <div class="card__container" >
      <div v-for="nft, index in nfts" :key="index" class="card">
        <p>Name : {{nft.name}}</p>
        <p>Image : {{nft.image}}</p>
        <p>price : {{nft.price}}</p>
        <button @click="buyNFT(index)">buy</button>
      </div>
    </div>
  </div>
</template>

<script>
import Button from './components/Button.vue'

export default {
  name: 'App',
  components: {
    Button
  },
  data(){
    return{
      nfts: []
    }
  },
  methods: {
    addNFT(){
      this.$contract.methods.addNFT("test", "test", 10).send({from: "0x55554E17D541f8Ead78D1c2f2379349761bb3092"},
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
    this.$contract.methods.buyNFT(id).send({from: "0x55554E17D541f8Ead78D1c2f2379349761bb3092",value : this.nfts[id].price},
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
    this.$contract.methods.getNFTsByOwner().call().then(
      (res) =>{
        console.log(res)
      })
  }
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
</style>
