# MultiSigWallet
Multi-Signature Wallet written in Solidity as Smart Contract

## Description
Simple Ethereum Smart Contract that is a Multi-Signature Wallet. This is a wallet that has it's owners and number of signatures needed for confirming a transfer of Ethereum. For instance, three people deposit thir money to the wallet. And one of them wanna to transfer these money to buy something. After the transfer was created, it needs three signatures from all owners of the wallet. When they all signed the transfer, the money succsessfully sends.

## Features
- deposit money
- create a transfer
- sign the transfer
- get balance of the wallet
- get the number of transfers
- get the status of specific transfer

## Test
1) ```truffle compile```
2) Copy and paste first three wallets to the array in our contract's code
3) ```migrate```
4) Lets test out our Multi Sign Wallet
Depost funds to a wallet 
```
await instance.deposit({value: web3.utils.toWei("10", "ether"), from: accounts[0]});
```
To check that that 10 ethers has been spent 
```
let balance = await web3.eth.getBalance(accounts[0]);
balance
```
And then do the same with the rest two wallets
```
await instance.deposit({value: web3.utils.toWei("10", "ether"), from: accounts[1]});
await instance.deposit({value: web3.utils.toWei("10", "ether"), from: accounts[2]});
```
5) Check that funds from wallets are really in the contract's balance
```
let contract_balance = instance.getBalance();
```
The outpout is weird but its not 0, so ok!! (BTW you can google how to convent it to normal)
```
BN {
  negative: 0,
  words: [ 31981568, 29933858, 2220, <1 empty item> ],
  length: 3,
  red: null
}
```
6) Creating a new transfer from wallet number 0
```
await instance.transfer(accounts[3], web3.utils.toWei("30", "ether"), {from: accounts[0]});
```
7) Sign transfer from rest two wallets
```
await instance.sign(0, {from: accounts[1]});
```
Check the balance of fourth wallet
```
balance = await web3.eth.getBalance(accounts[3]);
balance
'100000000000000000000'
```
So the balance in default, lets continue
Sign the transfer from last wallet
```
await instance.sign(0, {from: accounts[2]});
```
Check the balance again!!!!
```
balance = await web3.eth.getBalance(accounts[3]);
balance
'130000000000000000000'
```
Yeah!! Everyting is working properly!!

## Links
https://ipfs.io/ipfs/QmQGvxbDHLArdrYUkypLYEzPQje3igV1SSRsnkpvqRx4hN
https://ipfs.io/ipfs/QmNbAY6wWehWt1mTysTLkacuXnNkXWUCGuadGsokJgMEB7
