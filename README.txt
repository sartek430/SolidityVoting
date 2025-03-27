# Voting Smart Contract

## Description
Ce projet est un **contrat intelligent Solidity** permettant de gérer un processus de vote en plusieurs étapes. Seuls les utilisateurs enregistrés peuvent proposer et voter pour des propositions. Le contrat suit un **workflow strict** pour assurer l'intégrité du processus de vote.

## Fonctionnalités
- **Enregistrement des électeurs** par l'administrateur.
- **Gestion des propositions** de vote.
- **Ouverture et fermeture des sessions de vote**.
- **Comptage des votes et annonce du gagnant**.
- **Suivi du workflow via un état du contrat**.

## Technologies utilisées
- **Solidity** (>=0.7.0 <0.9.0)
- **OpenZeppelin** (Ownable.sol pour la gestion des permissions)

## Installation
### 1. Cloner le projet
```sh
git clone https://github.com/sartek430/SolidityVoting.git
cd votre-repo
```

## Déploiement
Le contrat peut être déployé sur **Remix IDE**, **Hardhat**, ou **Truffle**. Exemple avec Remix IDE :
1. Ouvrir [Remix IDE](https://remix.ethereum.org/)
2. Importer le fichier `Voting.sol`
3. Compiler et déployer sur un réseau de test (Goerli, Sepolia, etc.)

## Explication des Fonctions Principales
### 1. **Gestion des électeurs**
- `registerVoter(address voter)`: Ajoute un électeur à la liste (Admin seulement).
- `VoterRegistered(address voterAddress)`: Événement déclenché lors de l'ajout d'un électeur.

### 2. **Propositions**
- `proposeProposals(string memory description)`: Ajoute une proposition.
- `ProposalRegistered(uint proposalId)`: Événement déclenché lors de l'ajout d'une proposition.

### 3. **Vote**
- `vote(address voter, uint proposalId)`: Permet à un électeur de voter.
- `Voted(address voter, uint proposalId)`: Événement déclenché lorsqu'un vote est enregistré.

### 4. **Décompte des votes et résultat**
- `tallyVotes()`: Décompte des votes et définit le gagnant.
- `getWinnerProposal()`: Retourne la proposition gagnante.

## Workflow du Vote
1. **Enregistrement des électeurs**
2. **Ouverture des propositions**
3. **Fermeture des propositions**
4. **Début du vote**
5. **Fin du vote**
6. **Décompte des votes et annonce du gagnant**

## Sécurité et Restrictions
- Seul l'**administrateur** (déployeur du contrat) peut gérer les électeurs et le workflow.
- Un **électeur ne peut voter qu'une seule fois**.
- Le **workflow suit une progression stricte**, empêchant toute manipulation.

## Améliorations possibles
- **Utilisation d'un système de signature** pour la vérification des votes.
- **Interface frontend** pour faciliter l'utilisation du contrat.
- **Déploiement sur une blockchain publique**.

## License
Ce projet est sous licence **GPL-3.0**.

---
**Auteur :** [Votre Nom](https://github.com/votre-utilisateur)

