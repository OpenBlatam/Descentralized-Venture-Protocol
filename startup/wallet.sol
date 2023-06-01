pragma solidity ^0.8.0;

library StartupWalletLibrary {
    struct StartupWallet {
        address startup;
        mapping(address => uint256) balances;
        mapping(address => bool) mutex;
    }

    event Deposit(address indexed from, uint256 amount);
    event Withdrawal(address indexed to, uint256 amount);

    function initialize(StartupWallet storage wallet, address startup) external {
        wallet.startup = startup;
    }

    function deposit(StartupWallet storage wallet) external payable {
        require(msg.value > 0, "Invalid deposit amount");

        wallet.balances[msg.sender] += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(StartupWallet storage wallet, uint256 amount) external {
        require(amount > 0, "Invalid withdrawal amount");
        require(wallet.balances[msg.sender] >= amount, "Insufficient balance");
        require(!wallet.mutex[msg.sender], "Reentrant call");

        // Acquire mutex
        wallet.mutex[msg.sender] = true;

        uint256 balance = wallet.balances[msg.sender];

        // Update balance before transferring funds
        wallet.balances[msg.sender] -= amount;

        // Transfer the funds to the startup address
        (bool success, ) = payable(wallet.startup).call{value: amount}("");
        require(success, "Withdrawal failed");

        // Release mutex
        wallet.mutex[msg.sender] = false;

        emit Withdrawal(msg.sender, amount);

        // Refund any excess funds after the transfer
        if (balance > amount) {
            wallet.balances[msg.sender] += balance - amount;
        }
    }

    // Other library functions and logic for the startup wallet...
}

