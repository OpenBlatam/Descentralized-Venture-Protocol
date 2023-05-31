// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LendingPool {
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public borrowBalance;

    event Deposit(address indexed depositor, uint256 amount);
    event Borrow(address indexed borrower, address indexed asset, uint256 amount);

    function deposit(address asset, uint256 amount) external {
        // Transfer tokens from the depositor to the lending pool
        // Assuming the asset is an ERC20 token
        // Implement appropriate token transfer logic here
        // For example, ERC20(asset).transferFrom(msg.sender, address(this), amount);

        // Update the balance of the depositor
        balances[msg.sender] += amount;

        emit Deposit(msg.sender, amount);
    }

    function borrow(address asset, uint256 amount) external {
        // Check if the borrower has enough deposited assets as collateral
        require(balances[msg.sender] >= amount, "Insufficient collateral");

        // Update the borrow balance of the borrower for the specific asset
        borrowBalance[msg.sender][asset] += amount;

        emit Borrow(msg.sender, asset, amount);
    }

    function repay(address asset, uint256 amount) external {
        // Assuming the asset is an ERC20 token
        // Implement appropriate token transfer logic here
        // For example, ERC20(asset).transferFrom(msg.sender, address(this), amount);

        // Update the borrow balance of the borrower for the specific asset
        borrowBalance[msg.sender][asset] -= amount;

        // Transfer tokens back to the lender as repayment
        // Implement appropriate token transfer logic here
        // For example, ERC20(asset).transfer(msg.sender, amount);
    }

    function getDepositBalance(address depositor) external view returns (uint256) {
        return balances[depositor];
    }

    function getBorrowBalance(address borrower, address asset) external view returns (uint256) {
        return borrowBalance[borrower][asset];
    }
}

