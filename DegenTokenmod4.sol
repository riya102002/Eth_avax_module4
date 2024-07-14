// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol";

contract DegenToken1 is ERC20 {

    struct HolderInfo {
        uint256 balance;
        uint256 lastTransferTimestamp;
    }
    mapping(address => HolderInfo) public holders;
    uint256 public loyaltyRewardRate = 1; 

    address public owner;

    constructor() ERC20("DegenToken", "DGN") {
        owner = msg.sender;
    }

    function mintToken(address to, uint256 amount) public {
        _mint(to, amount);
        updateHolderInfo(to, int256(amount));
    }

    function burnToken(uint256 amount) public {
        _burn(msg.sender, amount);
        updateHolderInfo(msg.sender, -int256(amount));
    }

    function _transfer(address sender, address recipient, uint256 amount) internal override {
        super._transfer(sender, recipient, amount);
        updateHolderInfo(sender, -int256(amount));
        updateHolderInfo(recipient, int256(amount));
    }

    function redeem_Token(uint256 amount) public {
        _burn(msg.sender, amount);
        updateHolderInfo(msg.sender, -int256(amount));
        // Add logic for redeeming in-game rewards here
    }

    function calculateLoyaltyRewards(address holder) public view returns (uint256) {
        HolderInfo storage holderInfo = holders[holder];
        uint256 holdingDuration = block.timestamp - holderInfo.lastTransferTimestamp;
        uint256 dailyRewards = (holderInfo.balance * loyaltyRewardRate) / 100;
        uint256 totalRewards = (dailyRewards * holdingDuration) / 1 days;
        return totalRewards;
    }

    function claim_rewards() public {
        uint256 rewards = calculateLoyaltyRewards(msg.sender);
        require(rewards > 0, "No loyalty rewards available");
        _mint(msg.sender, rewards);
        holders[msg.sender].lastTransferTimestamp = block.timestamp;
    }

    function updateHolderInfo(address holder, int256 amountChange) internal {
        HolderInfo storage holderInfo = holders[holder];
        if (amountChange > 0) {
            holderInfo.balance += uint256(amountChange);
        } else {
            holderInfo.balance -= uint256(-amountChange);
        }
        holderInfo.lastTransferTimestamp = block.timestamp;
    }
}
