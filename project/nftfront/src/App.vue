<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/logo.png">
    <Button></Button>
    <button @click="getNFTCount">getNFTCount test</button>
    <button @click="addNFT">addNFT test</button>
    <button @click="getNFTbyIndex">getNFTbyIndex test</button>
    <button @click="getNFTs">getNFTs test</button>
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

    }
  },
  methods: {
    addNFT(){
      this.$contract.methods.addNFT("test", "test", 10).send({from: "0x41284d1BF23F5878b2F08c87723Fd5641f8F54Ac"},
        function(res){
          console.log(res)
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
  getNFTs(){
    this.$contract.methods.getNFTs().call().then(
      function(res){
        console.log(res)
      })
  }
  },

  mounted(){
    
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
</style>
