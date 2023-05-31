// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Interface for ERC20 token
interface ERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

library DecisionLib {
    struct Decision {
        address owner;
        address aiAddress;
        bool result;
        bool executed;
        uint256 timestamp;
    }

    function makeDecision(bytes memory inputData, Decision storage decision) external {
        require(decision.owner == msg.sender, "Only the owner can execute a decision.");
        require(!decision.executed, "Decision has already been executed.");

        // Call AI module with input data
        // Apply decision-making logic
        // Set result variable based on the decision logic
        decision.result = true;

        decision.executed = true;
        decision.timestamp = block.timestamp;
    }

    function updateAIAddress(address newAIAddress, Decision storage decision) external {
        require(decision.owner == msg.sender, "Only the owner can update the AI address.");
        decision.aiAddress = newAIAddress;
    }
}

contract VentureCapital {
    using DecisionLib for DecisionLib.Decision;

    struct Investor {
        uint256 investedAmount;  // Total invested amount
        uint256 shares;          // Investor's shares
        bool active;             // Flag to indicate active/inactive investor
    }

    mapping(address => Investor) public investors;
    address public admin;
    ERC20 public token;          // ERC20 token contract address
    uint256 public totalShares;  // Total shares issued
    uint256 public totalFunds;   // Total funds raised

    DecisionLib.Decision public decision;

    event FundsDeposited(address indexed investor, uint256 amount);
    event InvestmentMade(address indexed investor, uint256 amount);
    event SharesClaimed(address indexed investor, uint256 amount);
    event InvestorStatusUpdated(address indexed investor, bool activeStatus);

    constructor(address _token, address aiAddress) {
        admin = msg.sender;
        token = ERC20(_token);
        decision.owner = msg.sender;
        decision.aiAddress = aiAddress;
    }

    // Modifier to restrict access to the admin only
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    // Function to deposit funds to the venture capital contract
    function depositFunds(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(token.transferFrom(msg.sender, address(this), amount), "Token transfer failed");
        totalFunds += amount;
        emit FundsDeposited(msg.sender, amount);
    }

    // Function to invest in the venture capital
    function invest(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(totalFunds >= amount, "Insufficient funds in the contract");

        Investor storage investor = investors[msg.sender];
        if (!investor.active) {
            investor.active = true;
            emit InvestorStatusUpdated(msg.sender, true);
        }

        uint256 sharesToIssue = (amount * totalShares) / totalFunds;
        investor.investedAmount += amount;
        investor.shares += sharesToIssue;
        totalShares += sharesToIssue;
        totalFunds -= amount;

        emit InvestmentMade(msg.sender, amount);
    }

    // Function to claim investor's shares
    function claimShares() external {
        require(investors[msg.sender].active, "Investor is not a ctive");
        uint256 investorShares = investors[msg.sender].shares;
        require(investorShares > 0, "No shares to claim");
            investors[msg.sender].shares = 0;
    require(token.transferFrom(address(this), msg.sender, investorShares), "Token transfer failed");

    emit SharesClaimed(msg.sender, investorShares);
}

// Function to update investor's active status
function updateInvestorStatus(address investor, bool activeStatus) external onlyAdmin {
    require(investors[investor].active != activeStatus, "No change in investor status");
    investors[investor].active = activeStatus;

    emit InvestorStatusUpdated(investor, activeStatus);
}

// Function to withdraw remaining funds from the contract
function withdrawRemainingFunds() external onlyAdmin {
    uint256 remainingFunds = token.balanceOf(address(this));
    require(remainingFunds > 0, "No remaining funds in the contract");

    require(token.transferFrom(address(this), admin, remainingFunds), "Token transfer failed");
    totalFunds -= remainingFunds;
}

// Function to make a decision using the decision-making library
function makeDecision(bytes memory inputData) external {
    decision.makeDecision(inputData);
}

// Function to update the AI address using the decision-making library
function updateAIAddress(address newAIAddress) external {
    decision.updateAIAddress(newAIAddress);
}

