# [Solidity](https://solidity.readthedocs.io/en/latest/)

### Features

* Influenced by C++, JS and Python
* Statically typed
* Compiled
* [Remix](https://remix.ethereum.org): try out Solidity in browser

### Contract basics

* A **contract** is a collection of code and data that resides at a specific address on the eth blockchain
  * Basic example: [simple storage](src/simple_storage.sol)
  * [Coin example](src/coin.sol), [client side js event callback](src/coin_client_send_callback.js)

### Blockchain

For the purpose of this discussion, think of them as **globally shared transactional database**.

For how that's done via public key cryptography and proof-of-work, refer to [first discussion](https://github.com/zhehaowang/zhehao.me/blob/master/tech-notes/blockchain/blockchain.pdf).

"Transactional": in the Coin example, in a `send` call where A transfers to B, if we call `balances[A]` and `balances[B]` at the same time, the result is an invariant.

In practice for Ethereum, a new block is grown roughly every 17s.

A transaction can be reverted, but the longer you wait, the less likely it will be.

### Ethereum virtual machine: the runtime environment

* **Accounts**: external (user key pair), contract (when created), each account has a balance in wei (`1 ether = 10^18 wei`)
* **Transactions**: a message from one account to another, and can contain payload and ether
  * if target account contains code, the code is executed and payload is input data.
  * if target account is not set, the transaction creates a new contract. Payload is EVM bytecode to be executed, output from its execution is the code of the contract.
* Upon creation, each transaction is charged with a certain amount of **gas**, to limit the amount of work to execute the transaction and to pay for the execution. Gas price is a value set by the creator of the transaction, who pays `gas price * gas` up front from the sending account. Out-of-gas causes halt in execution and reverts the state back, and any remaining gas is refunded to the sender.

* EVM has storage, memory and stack.
  * Storage (`<256-bit-word, 256-bit-word>`) is persistent between function calls and transactions. Cannot be enumerated, and a contract can only read / write its own storage.
  * A contract obtains memory for each message call (for call payload and return val). Gas is paid to expand memory.
  * Stack is where the data for computation is stored. EVM is a stack machine (as opposed to a register machine).
(_a note on Turing completeness, a single-stack pushdown automaton is not Turing complete, but a two-stack machine is equivalent to a Turing machine_)

* [EVM instruction set](https://solidity.readthedocs.io/en/latest/assembly.html#opcodes) (arithmetic, bit, logical, comparison, conditional and unconditional jumps)

* The only way to remove code from the blockchain is when a contract at that address performs `selfdestruct`. Remaining ether is returned to a target, and if someone sends ether to removed contracts, the ether is forever lost. A deleted contract is still part of the history recorded by blockchain. It may be a better idea to disable a contract than `selfdestruct` it.


