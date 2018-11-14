pragma solidity >0.4.0 <0.6.0;

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