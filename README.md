# FundMe Contract

A Solidity smart contract for ETH-based fundraising on Ethereum. This contract allows users to contribute ETH with a minimum amount set in USD. It uses Chainlink’s price feed to convert ETH to USD and ensures only the contract owner can withdraw the funds.

## Features

- **Funding:** Users can send ETH to the contract. Contributions are tracked with a minimum threshold in USD.
- **Withdrawal:** Only the contract owner can withdraw all funds from the contract.
- **Price Conversion:** Uses Chainlink's price feed to convert ETH to USD.
- **Fallback Functions:** Accepts ETH sent directly to the contract.
