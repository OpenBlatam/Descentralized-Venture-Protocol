pragma solidity ^0.8.0;


library ReserveLogic {
    using WadRayMath for uint256;
    using PercentageMath for uint256;
    using safeERC20 for IERC20;

    // Pool
    event Deposit(
        address indexed reserve,
        address investor,
        uint256 amountOfRound
    );

    function executeDeposit(address reserve, address investor, uint256 amountOfRound) internal {
        // Perform your desired logic for depositing funds
        // Here, you can add your custom implementation for handling the deposit

        // Emit the deposit event
        emit Deposit(reserve, investor, amountOfRound);
    }
}
