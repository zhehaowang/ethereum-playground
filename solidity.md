# [Solidity](https://solidity.readthedocs.io/en/latest/)

Features
* Influenced by C++, JS and Python
* Statically typed
* Compiled
* [Remix](https://remix.ethereum.org): try out Solidity in browser

* A **contract** is a collection of code and data that resides at a specific address on the eth blockchain
```
pragma solidity >=0.4.0 <0.6.0;

contract SimpleStorage {
    uint storedData;

    function set(uint x) public {
        storedData = x;
    }

    function get() public view returns (uint) {
        return storedData;
    }
}
```

```
pragma solidity >0.4.99 <0.6.0;

contract Coin {
    // The keyword "public" makes those variables
    // easily readable from outside.
    address public minter;
    // address is a 160-bit value that does not allow arithmetic oprs, for
    // storing address of contracts or of key pairs belonging to external
    // persons. In this case, the key pair of a minter, which is a state of the
    // contract.

    mapping (address => uint) public balances;
    // a hashtable, but keep in mind you can't iterate all keys, or all values,
    // but you can use [] operator to query the hashtable.

    // Events allow light clients to react to
    // changes efficiently.
    event Sent(address from, address to, uint amount);
    // send 'emits' a Sent event, to which clients can subscribe without much
    // cost.

    // This is the constructor whose code is
    // run only when the contract is created.
    constructor() public {
        minter = msg.sender;
        // msg (and tx, block) is a special global variable that contains
        // certain properties which allow access to the blockchain. msg.sender
        // is the address where the current (external) call is from.
    }

    // external functions:
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        require(amount < 1e60);
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance.");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
```

```js
// this code on client side can listen to emitted Sent events

// Coin is a contract object created via web3.js
Coin.Sent().watch({}, '', function(error, result) {
    if (!error) {
        console.log("Coin transfer: " + result.args.amount +
            " coins were sent from " + result.args.from +
            " to " + result.args.to + ".");
        console.log("Balances now:\n" +
            "Sender: " + Coin.balances.call(result.args.from) +
            "Receiver: " + Coin.balances.call(result.args.to));
    }
})
```

