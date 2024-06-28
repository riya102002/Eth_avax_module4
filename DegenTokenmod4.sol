// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    constructor() ERC20("DegenToken", "DGN") Ownable(msg.sender) {}

    // Enum for gaming achievements
    enum Achievement { Novice, Apprentice, Journeyman, Expert, Master }

    // Struct to store player achievement data
    struct PlayerAchievement {
        address player;
        Achievement level;
        uint256 points;
    }
    // Mapping to track player achievements
    mapping(address => PlayerAchievement) public playerAchievements;
    // Function to award tokens for gameplay
    function awardTokens(address player, uint256 amount) public onlyOwner {
        _mint(player, amount);
        // Update player achievement points
        playerAchievements[player].points += amount;
        // Update player achievement level if necessary
        updateAchievementLevel(player);
    }
    // Function to update a player's achievement level
    function updateAchievementLevel(address player) internal {
        uint256 points = playerAchievements[player].points;
        if (points >= 100 && points < 500) {
            playerAchievements[player].level = Achievement.Novice;
        } else if (points >= 500 && points < 1000) {
            playerAchievements[player].level = Achievement.Apprentice;
        } else if (points >= 1000 && points < 2000) {
            playerAchievements[player].level = Achievement.Journeyman;
        } else if (points >= 2000 && points < 5000) {
            playerAchievements[player].level = Achievement.Expert;
        } else if (points >= 5000) {
            playerAchievements[player].level = Achievement.Master;
        }
    }
    // Function to transfer tokens to another player
    function transferArcade(address _to, uint256 _amt) public {
        require(_amt <= balanceOf(msg.sender), "Insufficient ARC");
        _transfer(msg.sender, _to, _amt);
    }
    // Function to redeem tokens for arcade features
    function redeemFeature(uint256 _amt) public {
        require(_amt <= balanceOf(msg.sender), "Insufficient ARC");
        // Add logic to redeem tokens for arcade features
        _burn(msg.sender, _amt); // Burn the redeemed tokens
    }
    // Function to check the token balance of the caller
    function checkBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }
    // Function to burn tokens
    function burnArcade(uint256 _amt) public {
        require(_amt <= balanceOf(msg.sender), "Insufficient ARC");
        _burn(msg.sender, _amt);
    }
}
