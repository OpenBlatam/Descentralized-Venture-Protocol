// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

import "./Token.sol";

contract Reserve {
    Token public token;
    mapping(address => uint256) public balances;

    event Deposit(address indexed account, uint256 amount);
    event Withdrawal(address indexed account, uint256 amount);

    constructor(address tokenAddress) public {
        token = Token(tokenAddress);
    }

    function deposit(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(token.balanceOf(msg.sender) >= amount, "Insufficient token balance");

        balances[msg.sender] += amount;
        token.transferFrom(msg.sender, address(this), amount);

        emit Deposit(msg.sender, amount);
    }

    function withdraw(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient reserve balance");

        balances[msg.sender] -= amount;
        token.transfer(msg.sender, amount);

        emit Withdrawal(msg.sender, amount);
    }
}
