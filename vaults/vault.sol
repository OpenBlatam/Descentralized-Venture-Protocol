// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VentureCapitalVault {
    mapping(address => uint256) public balances;
    mapping(address => bool) public allowedTokens;

    modifier nonReentrant() {
        bool locked = false;
        modifier reentrancyGuard() {
            require(!locked, "Reentrant call");
            locked = true;
            _;
            locked = false;
        }
        _;
    }

    event Deposit(address indexed investor, uint256 amount);
    event Withdrawal(address indexed investor, uint256 amount);

    constructor() {
        allowedTokens[address(0)] = true; // Allow Ether as a default token
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function depositToken(address token, uint256 amount) external {
        require(allowedTokens[token], "Token not allowed");
        require(amount > 0, "Amount must be greater than zero");

        // Transfer tokens from the sender to this contract
        // Make sure to approve the contract to spend the tokens beforehand
        // Example: ERC20(token).transferFrom(msg.sender, address(this), amount);

        balances[msg.sender] += amount;
        emit Deposit(msg.sender, amount);
    }

    function withdraw(uint256 amount) external nonReentrant {
        require(amount > 0, "Amount must be greater than zero");
        require(amount <= balances[msg.sender], "Insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function addAllowedToken(address token) external {
        allowedTokens[token] = true;
    }

    function removeAllowedToken(address token) external {
        allowedTokens[token] = false;
    }
}

