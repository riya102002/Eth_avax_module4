// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenCorporateToken is ERC20, ERC20Burnable {
    event Tokens_Minted(address indexed to, uint256 amount);
    event Tokens_Redeemed(address indexed from, uint256 amount, string item);
    event ItemAdded(uint256 itemId, string itemName, uint256 itemCost);
    event ItemPurchased(address indexed player, uint256 itemId, string itemName);
    event Player_Registered(address indexed player);
    event ActivityCreated(uint256 activityId, string activityName, uint256 tokensRewarded, uint256 extraCurricularPointsRewarded);
    event ActivityParticipated(address indexed employee, uint256 activityId, uint256 tokensEarned);
    event TaskCompleted(address indexed employee, uint256 tokensEarned);
    event GamePlayed(address indexed employee, uint256 tokensEarned, uint256 extraCurricularPointsEarned);
    event EmployeeRegistered(address indexed employee);
    event BonusCreditsGranted(address indexed employee, uint256 projectCredits, uint256 trainingCredits, uint256 innovationCredits, uint256 leadershipCredits, uint256 extraCurricularPoints);
    struct Item {
        string name;
        uint256 cost;
    }

    struct Activity {
        string name;
        uint256 tokensRewarded;
        uint256 extraCurricularPointsRewarded;
    }
    struct EmployeeCredits {
        uint256 project;
        uint256 training;
        uint256 innovation;
        uint256 leadership;
        uint256 extraCurricularPoints;
    }
    mapping(address => bool) public registeredPlayers;
    mapping(address => bool) public registeredEmployees;
    mapping(uint256 => Item) public inGameItems;
    mapping(address => EmployeeCredits) public employeeCredits;
    mapping(uint256 => Activity) public activities;
    mapping(address => mapping(uint256 => bool)) public activityParticipation;

    uint256 public nextItemId;
    uint256 public nextActivityId;
    modifier onlyRegisteredPlayer() {
        require(registeredPlayers[msg.sender], "You must be a registered player to perform this action");
        _;
    }
    modifier onlyRegisteredEmployee() {
        require(registeredEmployees[msg.sender], "You must be a registered employee to perform this action");
        _;
    }
    constructor() ERC20("DegenCorporateToken", "DCT") {}

    function registerPlayer(address player) public {
        require(player != address(0), "Invalid player address");
        registeredPlayers[player] = true;
        emit Player_Registered(player);
    }
    function registerEmployee(address employee) public {
        require(employee != address(0), "Invalid employee address");
        registeredEmployees[employee] = true;
        emit EmployeeRegistered(employee);
    }
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
        emit Tokens_Minted(to, amount);
    }
    function addItem(string memory itemName, uint256 itemCost) public {
        inGameItems[nextItemId] = Item(itemName, itemCost);
        emit ItemAdded(nextItemId, itemName, itemCost);
        nextItemId++;
    }
    function redeemTokens(uint256 itemId) public onlyRegisteredPlayer {
        require(inGameItems[itemId].cost > 0, "Item does not exist");
        require(balanceOf(msg.sender) >= inGameItems[itemId].cost, "Insufficient tokens to redeem item");

        burn(inGameItems[itemId].cost);

        emit Tokens_Redeemed(msg.sender, inGameItems[itemId].cost, inGameItems[itemId].name);
        emit ItemPurchased(msg.sender, itemId, inGameItems[itemId].name);
    }
    function createActivity(string memory name, uint256 tokensRewarded, uint256 extraCurricularPointsRewarded) public {
        activities[nextActivityId] = Activity(name, tokensRewarded, extraCurricularPointsRewarded);
        emit ActivityCreated(nextActivityId, name, tokensRewarded, extraCurricularPointsRewarded);
        nextActivityId++;
    }
    function participateInActivity(uint256 activityId) public onlyRegisteredEmployee {
        require(activities[activityId].tokensRewarded > 0, "Activity does not exist");
        require(!activityParticipation[msg.sender][activityId], "You have already participated in this activity");

        activityParticipation[msg.sender][activityId] = true;
        _mint(msg.sender, activities[activityId].tokensRewarded);
        employeeCredits[msg.sender].extraCurricularPoints += activities[activityId].extraCurricularPointsRewarded;

        emit ActivityParticipated(msg.sender, activityId, activities[activityId].tokensRewarded);
    }
    function redeemCorporateTokens(uint256 amount, uint256 projectCredits, uint256 trainingCredits, uint256 innovationCredits, uint256 leadershipCredits, uint256 extraCurricularPoints) public onlyRegisteredEmployee {
        require(balanceOf(msg.sender) >= amount, "Insufficient tokens to redeem");

        burn(amount);

        employeeCredits[msg.sender].project += projectCredits;
        employeeCredits[msg.sender].training += trainingCredits;
        employeeCredits[msg.sender].innovation += innovationCredits;
        employeeCredits[msg.sender].leadership += leadershipCredits;
        employeeCredits[msg.sender].extraCurricularPoints += extraCurricularPoints;

        emit BonusCreditsGranted(msg.sender, projectCredits, trainingCredits, innovationCredits, leadershipCredits, extraCurricularPoints);
    }
    function completeTask(address employee, uint256 tokensEarned) public {
        require(employee != address(0), "Invalid employee address");
        require(registeredEmployees[employee], "Employee must be registered");
        _mint(employee, tokensEarned);
        emit TaskCompleted(employee, tokensEarned);
    }
    function playGame(address employee, uint256 tokensEarned, uint256 extraCurricularPointsEarned) public {
        require(employee != address(0), "Invalid employee address");
        require(registeredEmployees[employee], "Employee must be registered");
        _mint(employee, tokensEarned);
        employeeCredits[employee].extraCurricularPoints += extraCurricularPointsEarned;
        emit GamePlayed(employee, tokensEarned, extraCurricularPointsEarned);
    }
    function grantBonusCredits(address employee, uint256 projectCredits, uint256 trainingCredits, uint256 innovationCredits, uint256 leadershipCredits, uint256 extraCurricularPoints) public {
        require(employee != address(0), "Invalid employee address");
        require(registeredEmployees[employee], "Employee must be registered");

        employeeCredits[employee].project += projectCredits;
        employeeCredits[employee].training += trainingCredits;
        employeeCredits[employee].innovation += innovationCredits;
        employeeCredits[employee].leadership += leadershipCredits;
        employeeCredits[employee].extraCurricularPoints += extraCurricularPoints;

        emit BonusCreditsGranted(employee, projectCredits, trainingCredits, innovationCredits, leadershipCredits, extraCurricularPoints);
    }
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), allowance(sender, _msgSender()) - amount);
        return true;
    }
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }
    function balanceOf(address account) public view virtual override returns (uint256) {
        return super.balanceOf(account);
    }
    function burn(uint256 amount) public virtual override {
        super.burn(amount);
    }
}
