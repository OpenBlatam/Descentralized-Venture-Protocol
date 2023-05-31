pragma solidity ^0.8.0;

contract Bankruptcy {
    address public debtor;
    bool public isBankrupt;

    event BankruptcyDeclared(address indexed debtor);

    constructor() {
        debtor = msg.sender;
        isBankrupt = false;
    }

    modifier onlyDebtor() {
        require(msg.sender == debtor, "Only the debtor can perform this action");
        _;
    }

    function declareBankruptcy() external onlyDebtor {
        require(!isBankrupt, "Bankruptcy has already been declared");
        isBankrupt = true;
        emit BankruptcyDeclared(debtor);
    }
}

