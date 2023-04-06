import Vue from 'vue'
import App from './App.vue'

import Web3 from "web3";
import contract_abi from "../../build/contracts/NFTMarketplace.json";

Vue.config.productionTip = false

let contract_adress = "0xbbC4ec231D9Ce995Ec42621Ccd05494046734620"
const web3 = new Web3(window.ethereum);
const contract = new web3.eth.Contract(contract_abi.abi, contract_adress)

Vue.prototype.$contract = contract

new Vue({
  render: h => h(App),
}).$mount('#app')
