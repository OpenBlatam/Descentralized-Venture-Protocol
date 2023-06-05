pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
//import "@openzeppelin/contracts/utils/math/WadRayMath.sol";

library ReserveLogic {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;
    // using WadRayMath for uint256;

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
