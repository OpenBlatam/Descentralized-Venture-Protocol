// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;

import './interfaces/IUniswapV3Factory.sol';
import './UniswapV3Pair.sol';
import './UniswapV3PairDeployer.sol';
import './NoDelegateCall.sol';

import "./VentureCapital.sol";

/// @title Decentralized Venture Capital Uniswap V3 pair factory
/// @notice Deploys Uniswap V3 pairs and manages ownership and control over pair protocol fees
contract DecentralizedVentureCapitalFactory is IUniswapV3Factory, UniswapV3PairDeployer, NoDelegateCall {
    address public override owner;
    mapping(uint24 => int24) public override feeAmountTickSpacing;
    mapping(address => mapping(address => mapping(uint24 => address))) public override getPair;

    VentureCapital public ventureCapital;

    constructor() {
        owner = msg.sender;
        emit OwnerChanged(address(0), msg.sender);

        feeAmountTickSpacing[600] = 12;
        emit FeeAmountEnabled(600, 12);
        feeAmountTickSpacing[3000] = 60;
        emit FeeAmountEnabled(3000, 60);
        feeAmountTickSpacing[9000] = 180;
        emit FeeAmountEnabled(9000, 180);

        ventureCapital = new VentureCapital();
    }
    function createVentureCapitalPair(
        address investorA,
        address investorB,
        uint24 fee
    ) external override noDelegateCall returns (address ventureCapitalPair) {
        require(investorA != investorB);
        require(investorA != address(0));
        require(investorB != address(0));
        require(feeAmountTickSpacing[fee] != 0);

        // Create a new venture capital pair using the VentureCapital contract
        ventureCapitalPair = ventureCapital.createVentureCapitalPair(investorA, investorB, fee);

        // Store the pair address in the getPair mapping
        (address token0, address token1) = (investorA, investorB);
        getPair[token0][token1][fee] = ventureCapitalPair;
        getPair[token1][token0][fee] = ventureCapitalPair;

        emit PairCreated(token0, token1, fee, feeAmountTickSpacing[fee], ventureCapitalPair);
    }

    function setOwner(address _owner) external override {
        require(msg.sender == owner);
        emit OwnerChanged(owner, _owner);
        owner = _owner;
    }

    function enableFeeAmount(uint24 fee, int24 tickSpacing) public override {
        require(msg.sender == owner);
        require(fee < 1000000);
        require(tickSpacing > 0 && tickSpacing < 16384);
        require(feeAmountTickSpacing[fee] == 0);

        feeAmountTickSpacing[fee] = tickSpacing;
        emit FeeAmountEnabled(fee, tickSpacing);
    }
}
