// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VentureCapitalKernel {
    mapping(address => uint256) public investorBalances;
    uint256 public totalFunds;

    event FundsDeposited(address indexed investor, uint256 amount);
    event InvestmentMade(address indexed investor, uint256 amount);

    constructor() {
        totalFunds = 0;
    }

    function depositFunds() external payable {
        require(msg.value > 0, "Amount must be greater than zero");

        investorBalances[msg.sender] += msg.value;
        totalFunds += msg.value;

        emit FundsDeposited(msg.sender, msg.value);
    }

    function invest() external payable {
        require(msg.value > 0, "Amount must be greater than zero");
        require(investorBalances[msg.sender] >= msg.value, "Insufficient balance");

        investorBalances[msg.sender] -= msg.value;
        totalFunds -= msg.value;

        emit InvestmentMade(msg.sender, msg.value);
    }

    function withdrawFunds(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(investorBalances[msg.sender] >= amount, "Insufficient balance");

        payable(msg.sender).transfer(amount);
        investorBalances[msg.sender] -= amount;
        totalFunds -= amount;
    }

    function getInvestorBalance(address investor) external view returns (uint256) {
        return investorBalances[investor];
    }
}

