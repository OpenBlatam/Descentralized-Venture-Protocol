pragma solidity ^0.8.0;

contract CallOption {
    address public owner;
    address public counterparty;
    uint256 public strikePrice;
    uint256 public expirationDate;
    bool public exercised;

    event OptionCreated(address indexed owner, address indexed counterparty, uint256 strikePrice, uint256 expirationDate);
    event OptionExercised(address indexed exerciser, uint256 amount);

    constructor(
        address _counterparty,
        uint256 _strikePrice,
        uint256 _expirationDate
    ) {
        owner = msg.sender;
        counterparty = _counterparty;
        strikePrice = _strikePrice;
        expirationDate = _expirationDate;

        emit OptionCreated(owner, counterparty, strikePrice, expirationDate);
    }

    function exerciseOption() external {
        require(!exercised, "Option has already been exercised");
        require(msg.sender == counterparty, "Only the counterparty can exercise the option");
        require(block.timestamp <= expirationDate, "Option has expired");

        exercised = true;

        // Perform any required logic for exercising the option
        // For example, transfer funds or assets to the exerciser

        emit OptionExercised(msg.sender, strikePrice);
    }
}

