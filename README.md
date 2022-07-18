# Swapnet
Swaping ERC20 inspired by Jediswap open-source contracts : https://bip.so/@meshfinance/Implement-a-swap-njBZO/public

Swapnet is 2 functions setting up the swap instructions 

1. TransferFrom
2. Approve 


This class hash will be used in order to deploy an instance of the contract using the deploy system call.

Run : ``` starknet declare --contract swap_compiled.json ```

- Contract class hash: 0x434b275d84d66298aa5a7d854c9e227727113b6a4c04ca62fb9d11a2efc4ceb.


The contract is deployed on StarkNet testnet by running : 
``` starknet deploy --contract swap_compiled.json ```

- Contract address : 0x003eb294c57b21e498658d23e879adde1d97aba36ec8a4958152fc519401ffdb


In the command line do : 

```export CONTRACT_ADDRESS= "0x003eb294c57b21e498658d23e879adde1d97aba36ec8a4958152fc519401ffdb" ``` 
