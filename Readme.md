
# DegenCorporateToken

## Overview

`DegenCorporateToken` is an ERC20 token contract designed for managing corporate activities, rewards, and employee engagement. This token implements various features including minting, burning, redeeming tokens for in-game items, and managing employee credits and activities.

## Features
**ERC20 Token Implementation:** Enhanced features together with standard ERC20 functionality.
**Minting and Burning:** As needed, mint new tokens and burn existing ones.
**Item Redemption**: Exchange tokens for in-game merchandise.
**Activity Management:** Arrange games and provide tokens and extracurricular points to those who complete them.
- **Employee Credits:** Control and use company credits across a range of areas.
- **Task and Game Rewards:** Give staff members prizes for doing tasks and taking part in games.
- **Bonus Credits:** Allocate extra points for certain business endeavours.
## Contract Structure

### Imports

- **OpenZeppelin Contracts:**
  - `ERC20`: Standard ERC20 token implementation.
  - `ERC20Burnable`: Extension allowing tokens to be burned.

### Events

- **Tokens_Minted:** Released with the issuance of tokens.
- **Tokens_Redeemed:** Emitted in the event that an item is purchased using tokens.
- **ItemAdded:** Dispatched upon addition of a new item.
- **ItemPurchased:** Published upon acquisition of an item.
- **Player_Registered:** This signal is sent out after a player registers.
- **ActivityCreated:** Dispatched upon creation of a new activity.
- **ActivityParticipated:** A notification sent out whenever a worker takes part in an activity.
- **TaskCompleted:** Emitted upon an employee completing a task.
- **GamePlayed:** Message sent out whenever an employee plays a game.
- **EmployeeRegistered:** Sent upon registration of an employee.
- **BonusCreditsGranted:** Issued in the event that an employee receives bonus credits.

### Structs

- **Item:** Represents an in-game item with a name and cost.
- **Activity:** Represents an activity with rewards in tokens and extra-curricular points.
- **EmployeeCredits:** Tracks credits for project, training, innovation, leadership, and extra-curricular points.

### Mappings

- **registeredPlayers:** Maps addresses to their registration status as players.
- **registeredEmployees:** Maps addresses to their registration status as employees.
- **inGameItems:** Maps item IDs to their respective `Item`.
- **employeeCredits:** Maps employee addresses to their credits.
- **activities:** Maps activity IDs to their respective `Activity`.
- **activityParticipation:** Maps employee addresses to their activity participation status.

### Functions

* **registerPlayer(address player):** Adds a new participant to the list.
**registerEmployee(address employee):** Adds a new worker to the roster.
* **mint(address to, uint256 amount)**: This command mints fresh tokens to the given address.
- **addItem(uint256 itemCost, string memory itemName):** Adds a new item to the game.
**redeemTokens(uint256 itemId):** Exchanges tokens for an item that may be used in-game.
- **createActivity(uint256 tokensRewarded, uint256 extraCurricularPointsRewarded, string memory name):** initiates a fresh task.
- **participateInActivity(uint256 activityId):** enables a worker to take part in a task and get incentives.
- **redeemCorporateTokens(uint256 amount, uint256 projectCredits, uint256 trainingCredits, uint256 leadersCredits, uint256 extraCurricularPoints):** Exchanges tokens for corporate credits.
- **fullTask(worker address, uint256 tokensEarned):** Gives tokens to an employee when they finish a task.
- **playGame(address employee, uint256 tokensEarned, uint256 extraCurricularPointsEarned):** Rewards an employee for playing a game.
- **grantBonusCredits(address employee, uint256 projectCredits, uint256 trainingCredits, uint256 innovationCredits, uint256 leadershipCredits, uint256 extraCurricularPoints):** Grants bonus credits to an employee.
- **transfer(address to, uint256 amount):** Transfers tokens to another address.
- **transferFrom(address sender, address recipient, uint256 amount):** Transfers tokens from one address to another using allowance.
- **approve(address spender, uint256 amount):** Approves a spender to use a specified amount of tokens.
- **balanceOf(address account):** Returns the balance of a specified account.
- **burn(uint256 amount):** Burns a specified amount of tokens.

## Usage

1. **Deploy the Contract:** Using a Solidity development environment such as Hardhat or Remix, deploy {DegenCorporateToken}.
2. Engage in Contract Interaction:
   - Register staff and participants.
   - As needed, mint and burn tokens.
   - Create and control in-game objects.
   - Plan and direct activities.
   - Give workers prizes for playing games, participating, and doing tasks.
   - Give out and redeem company credits.
## Requirements

- **Solidity Compiler:** ^0.8.24
- **OpenZeppelin Contracts:** Ensure to install OpenZeppelin contracts for ERC20 and ERC20Burnable.
- 
## License

This project is licensed under the MIT License.

## Author

 @RiyaKesharwani [https://github.com/riya102002]

