// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface TokenA {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

interface TokenB {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract VentureCapital {
    mapping(address => uint256) public investorBalancesA;
    mapping(address => uint256) public investorBalancesB;
    uint256 public totalFundsA;
    uint256 public totalFundsB;

    TokenA public tokenA;
    TokenB public tokenB;

    event FundsDeposited(address indexed investor, uint256 amount, string tokenType);
    event InvestmentMade(address indexed investor, uint256 amount, string tokenType);
    event InvestmentChanged(address indexed investor, uint256 amount, string fromTokenType, string toTokenType);

    constructor(address _tokenA, address _tokenB) {
        tokenA = TokenA(_tokenA);
        tokenB = TokenB(_tokenB);
        totalFundsA = 0;
        totalFundsB = 0;
    }

    function depositFundsA(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(tokenA.transferFrom(msg.sender, address(this), amount), "Token A transfer failed");

        investorBalancesA[msg.sender] += amount;
        totalFundsA += amount;

        emit FundsDeposited(msg.sender, amount, "Token A");
    }

    function depositFundsB(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(tokenB.transferFrom(msg.sender, address(this), amount), "Token B transfer failed");

        investorBalancesB[msg.sender] += amount;
        totalFundsB += amount;

        emit FundsDeposited(msg.sender, amount, "Token B");
    }

    function investA(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(investorBalancesA[msg.sender] >= amount, "Insufficient Token A balance");

        investorBalancesA[msg.sender] -= amount;
        totalFundsA -= amount;

        emit InvestmentMade(msg.sender, amount, "Token A");
    }

    function investB(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(investorBalancesB[msg.sender] >= amount, "Insufficient Token B balance");

        investorBalancesB[msg.sender] -= amount;
        totalFundsB -= amount;

        emit InvestmentMade(msg.sender, amount, "Token B");
    }

    function changeInvestmentFromAtoB(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(investorBalancesA[msg.sender] >= amount, "Insufficient Token A balance");

        investorBalancesA[msg.sender] -= amount;
        totalFundsA -= amount;

        investorBalancesB[msg.sender] += amount;
        totalFundsB += amount;

        emit InvestmentChanged(msg.sender, amount, "Token A", "Token B");
    }
    function changeInvestmentFromBtoA(uint256 amount) external {
        require(amount > 0, "Amount must be more than 0 ")
            // greater than zero
        require(investorBalancesB[msg.sender] >= amount, "Insufficient Token B balance");

        investorBalancesB[msg.sender] -= amount;
        totalFundsB -= amount;

        investorBalancesA[msg.sender] += amount;
        totalFundsA += amount;

        emit InvestmentChanged(msg.sender, amount, "Token B", "Token A");
    }

    function withdrawFundsA(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(investorBalancesA[msg.sender] >= amount, "Insufficient Token A balance");

        investorBalancesA[msg.sender] -= amount;
        totalFundsA -= amount;

        require(tokenA.transfer(msg.sender, amount), "Token A transfer failed");
    }

    function withdrawFundsB(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(investorBalancesB[msg.sender] >= amount, "Insufficient Token B balance");

        investorBalancesB[msg.sender] -= amount;
        totalFundsB -= amount;

        require(tokenB.transfer(msg.sender, amount), "Token B transfer failed");
    }

    function getInvestorBalanceA(address investor) external view returns (uint256) {
        return investorBalancesA[investor];
    }

    function getInvestorBalanceB(address investor) external view returns (uint256) {
        return investorBalancesB[investor];
    }
}

