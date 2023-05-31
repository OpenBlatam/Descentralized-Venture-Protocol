pragma solidity ^0.8.0;

contract BalanceSheet {
    mapping(address => uint256) private assets;
    mapping(address => uint256) private liabilities;
    mapping(address => uint256) private equity;

    event AssetUpdated(address indexed account, uint256 amount);
    event LiabilityUpdated(address indexed account, uint256 amount);
    event EquityUpdated(address indexed account, uint256 amount);

    function updateAsset(uint256 amount) external {
        assets[msg.sender] = amount;
        emit AssetUpdated(msg.sender, amount);
    }

    function updateLiability(uint256 amount) external {
        liabilities[msg.sender] = amount;
        emit LiabilityUpdated(msg.sender, amount);
    }

    function updateEquity(uint256 amount) external {
        equity[msg.sender] = amount;
        emit EquityUpdated(msg.sender, amount);
    }

    function getAsset(address account) external view returns (uint256) {
        return assets[account];
    }

    function getLiability(address account) external view returns (uint256) {
        return liabilities[account];
    }

    function getEquity(address account) external view returns (uint256) {
        return equity[account];
    }
}

