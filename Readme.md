# DegenToken - Decentralized Gaming Token

## Overview

The DegenToken is an ERC20 token contract designed for a decentralized gaming application. It provides features for minting, transferring, burning tokens, and tracking player achievements, along with loyalty rewards for token holders.

## Features

1. **Token Management:**
    - **Minting:** The contract owner can mint tokens using the `mintToken` function.
    - **Transferring:** Players can transfer their tokens to other players using the `transfer` function.
    - **Burning:** Players can burn their tokens using the `burnToken` and `redeem_Token` functions.
    - **Balance Checking:** Players can check their token balance by calling the `balanceOf` function.

2. **Player Achievements:**
    - **Loyalty Rewards:** The contract calculates loyalty rewards based on the holding duration of tokens by each player.
    - **Claim Rewards:** Players can claim their loyalty rewards using the `claim_rewards` function.

## Contract Functions

1. **mintToken(address to, uint256 amount):** Mints tokens for the specified player.
2. **burnToken(uint256 amount):** Allows the caller to burn their tokens.
3. **transfer(address recipient, uint256 amount):** Transfers tokens from the caller to the specified address.
4. **redeem_Token(uint256 amount):** Allows the caller to redeem their tokens for in-game rewards and burns the redeemed tokens.
5. **calculateLoyaltyRewards(address holder):** Calculates the loyalty rewards for the specified holder.
6. **claim_rewards():** Allows the caller to claim their loyalty rewards.

## Deployment and Usage

1. Deploy the `DegenToken1` contract to the desired Ethereum network.
2. Use the `mintToken` function to mint tokens for players as they progress in the game.
3. Players can use the `transfer`, `redeem_Token`, and `burnToken` functions to manage their tokens.
4. Players can claim their loyalty rewards using the `claim_rewards` function.

## Dependencies

The DegenToken contract depends on the following OpenZeppelin contracts:

1. ERC20

Make sure to include these dependencies when deploying the contract.

## Author

[@RiyaKesharwani](https://github.com/riya102002)

## License

[MIT](https://choosealicense.com/licenses/mit/)

This project DegenToken is licensed under the MIT license.
