
# DegenToken - Decentralized Gaming Token





## Overview

The DegenToken is an ERC20 token contract designed for a decentralized gaming application. It provides features for minting, transferring, and burning tokens, as well as tracking player achievements.
## Features

1. Token Management:

Minting: The contract owner can mint tokens using the awardTokens function, which also updates the player's achievement points.

Transferring: Players can transfer their tokens to other players using the transferArcade function.

Burning: Players can burn their tokens using the redeemFeature and burnArcade functions.

Balance Checking: Players can check their token balance using the checkBalance function.

2. Player Achievements:

The contract defines an Achievement enum to represent different achievement levels.

The PlayerAchievement struct stores the player's address, achievement level, and points.

The playerAchievements mapping tracks the achievement data for each player.

The updateAchievementLevel function updates the player's achievement level based on their accumulated points.
## Contract Function

1. awardTokens(address player, uint256 amount): Mints tokens for the specified player and updates their achievement points.

2. transferArcade(address _to, uint256 _amt): Transfers tokens from the caller to the specified address.

3. redeemFeature(uint256 _amt): Allows the caller to redeem their tokens for arcade features and burns the redeemed tokens.

4. checkBalance(): Returns the token balance of the caller.

5. burnArcade(uint256 _amt): Allows the caller to burn their tokens.
## Deployment and Usage

1. Deploy the DegenToken contract to the desired Ethereum network.

2. Use the awardTokens function to mint tokens for players as they progress in the game.

3. Players can use the transferArcade, redeemFeature, and burnArcade functions to manage their tokens.

4. The contract owner can monitor the player achievements using the playerAchievements mapping.
## Dependencies

The DegenToken contract depends on the following OpenZeppelin contracts:

1. ERC20

2. Ownable

3. ERC20Burnable

Make sure to include these dependencies when deploying the contract.
## Author

 @RiyaKesharwani [https://github.com/riya102002]



## License

[MIT](https://choosealicense.com/licenses/mit/)

This project DegenToken is licensed under the MIT license.

