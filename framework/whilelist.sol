// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VentureCapital {
    // ... existing contract code ...

    mapping(address => bool) public whitelistedInvestors;

    modifier onlyWhitelisted() {
        require(whitelistedInvestors[msg.sender], "Only whitelisted investors can call this function");
        _;
    }

    function whitelistInvestor(address investor) external onlyAdmin {
        whitelistedInvestors[investor] = true;
    }

    function removeWhitelist(address investor) external onlyAdmin {
        whitelistedInvestors[investor] = false;
    }

    function invest(uint256 amount) external onlyWhitelisted {
        // Compliance check: Only whitelisted investors can invest
        require(whitelistedInvestors[msg.sender], "Only whitelisted investors can invest");

        // ... existing investment logic ...
    }

    function withdrawFunds(uint256 amount) external onlyWhitelisted {
        // Compliance check: Only whitelisted investors can withdraw funds
        require(whitelistedInvestors[msg.sender], "Only whitelisted investors can withdraw funds");

        // ... existing withdrawal logic ...
    }

    // ... other functions ...
}

