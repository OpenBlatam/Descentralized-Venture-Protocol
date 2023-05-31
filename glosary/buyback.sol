pragma solidity ^0.8.0;

contract Buyback {
    address public company;
    uint256 public buybackPrice;
    uint256 public totalShares;

    mapping(address => uint256) private balances;

    event SharesPurchased(address indexed buyer, uint256 amount);

    constructor(uint256 _buybackPrice, uint256 _totalShares) {
        company = msg.sender;
        buybackPrice = _buybackPrice;
        totalShares = _totalShares;
    }

    function purchaseShares(uint256 amount) external payable {
        require(amount > 0, "Amount must be greater than zero");
        require(amount <= balances[msg.sender], "Insufficient shares balance");
        require(msg.value == amount * buybackPrice, "Insufficient payment");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(msg.value);

        emit SharesPurchased(msg.sender, amount);
    }

    function setBalance(address account, uint256 amount) external {
        require(msg.sender == company, "Only the company can set balances");

        balances[account] = amount;
    }

    function getBalance(address account) external view returns (uint256) {
        return balances[account];
    }
}

