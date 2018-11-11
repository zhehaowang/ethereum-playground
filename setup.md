# Setting up dev env and running a contract on Mac

### Dependencies

* npm
  * [solc](https://www.npmjs.com/package/solc): js binding for Solidity compiler
  * (optional) [truffle](https://www.npmjs.com/package/truffle): dev environment, test framework, deployment tool
* Docker
* [go-ethereum](https://github.com/ethereum/go-ethereum/wiki/Installation-Instructions-for-Mac#installing-with-homebrew)

### Workflow

* Set up private network
```
docker-compose up
```
This sets up 1 bootnode, 3 miners running geth and 1 monitor.
* Compile contract
```
solcjs --abi voting.sol
solcjs --bin voting.sol
```
* Deploy contract (from miner-1)
```
geth attach http://localhost:8546
```
In geth console:
```js
var contract = web3.eth.contract(/* contract_abi */);

var deploy = {from: eth.coinbase, data: /* contract_bytecode */, gas: 2000000};

var instance = contract.new(/* candidates */, deploy);

// Error: invalid address
// web3.eth.defaultAccount = web3.eth.accounts[0]

var ins = contract.at(instance.address);

// interact with the contract
ins.voteForCandidate(/* candidate */, {from: web3.eth.accounts[0]});
```
* To retrieve a contract given a block number
```js
web3.eth.getBlock(3); // copy transaction hash out

web3.eth.getTransactionReceipt(/* transaction hash */); // copy contractAddress out

// need contract abi to retrieve an instance we can interact with
var contract = web3.eth.contract(/* contract_abi */);

var ins = contract.at(instance.address);
```

### What to expect

Blocks being mined and network dashboard at http://localhost:3000

### Working with Docker

List all containers, stop and remove
```
docker ps -aq
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
```
Remove all images
```
docker rmi $(docker images -q)
```

### Credit

* Tim Zöller, [setting up a private network](https://medium.com/@javahippie/building-a-local-ethereum-network-with-docker-and-geth-5b9326b85f37)
* Mahesh Murthy, [voting contract](https://medium.com/@mvmurthy/full-stack-hello-world-voting-ethereum-dapp-tutorial-part-1-40d2d0d807c2)
* Mercury Protocol, [deploying a contract](https://medium.com/mercuryprotocol/dev-highlights-of-this-week-cb33e58c745f)