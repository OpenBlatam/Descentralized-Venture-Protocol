pragma solidity ^0.8.0;

contract Cliff {
    address public employee;
    uint256 public cliffDuration;
    uint256 public cliffStartTime;

    event CliffSet(address indexed employee, uint256 duration);
    event CliffPassed(address indexed employee);

    constructor(address _employee, uint256 _cliffDuration) {
        employee = _employee;
        cliffDuration = _cliffDuration;
        cliffStartTime = block.timestamp;
        emit CliffSet(employee, cliffDuration);
    }

    modifier onlyEmployee() {
        require(msg.sender == employee, "Only the employee can perform this action");
        _;
    }

    modifier cliffNotPassed() {
        require(block.timestamp >= cliffStartTime + cliffDuration, "Cliff period has not passed yet");
        _;
    }

    function setCliffDuration(uint256 duration) external onlyEmployee {
        require(duration > 0, "Duration must be greater than zero");
        cliffDuration = duration;
        emit CliffSet(employee, cliffDuration);
    }

    function passCliff() external onlyEmployee cliffNotPassed {
        emit CliffPassed(employee);
    }

    function getCliffStartTime() external view returns (uint256) {
        return cliffStartTime;
    }

    function getRemainingCliffTime() external view returns (uint256) {
        if (block.timestamp >= cliffStartTime + cliffDuration) {
            return 0;
        }
        return cliffStartTime + cliffDuration - block.timestamp;
    }
}

