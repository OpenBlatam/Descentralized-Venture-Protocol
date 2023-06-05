pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./ReserveLogic.sol";

contract VentureCapital {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;
    using ReserveLogic for address;

    mapping(address => uint256) public reserves;

    function deposit(address reserve, uint256 amountOfRound) external {
        // Perform necessary checks and validations

        // Call the executeDeposit function from the ReserveLogic library
        reserve.executeDeposit(msg.sender, amountOfRound);

        // Update the reserve balance
        reserves[reserve] = reserves[reserve].add(amountOfRound);

        // Perform any additional actions required for the deposit
    }
}
