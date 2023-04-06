# Projet Solidity Groupe 3 - IIM

## Initialisation 

### Ganache 
Pour ce projet, il est nécessaire d'avoir `ganache` installé sur sa machine. Si ce n'est pas le cas, faire la commande suivante : 

```
// installer le package ganache
→ npm i -g ganache 

//créer une blockchain locale
→ ganache
```

### Metamask

Il faut également avoir installé Metamask sur son navigateur. [Voir ici pour le télécharger](https://metamask.io/download/).

Une fois le téléchargement effectuer, il faut ajouter son compte **Ganache** à Metamask. Pour cela : 
- Ajoutez un réseau
- "Ajouter manuellement un réseau"
- Remplissez les informations avec celles fournies par Ganache
- Enregistrez

## Installer le projet en local

Dans le répertoire `nftfront`, faire un `npm i` pour installer les packages necessaires au bon fonctionnement du projet.

Pour faire fonctionner le projet en local, il faut faire une compilation et une migration avec les commandes : 
````
→ truffle compile //va générer un fichier JSON de notre contrat (ABI)
→ truffle migration
`````

Ensuite, il faut modifier dans `nftfront/src/main.js` la valeur de la variable `contract_adress` pour lier le contrat à Web3.


À la racine de `nftfront`, faire un `npm run serve` et se rendre sur http://localhost:8080/ pour utiliser l'application.
