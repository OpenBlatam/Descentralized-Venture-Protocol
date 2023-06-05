// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;

import "./VentureConfiguration.sol";
import "./VentureCapital.sol";

contract VentureFactory is VentureConfiguration {
    function clone(Configuration calldata config) external returns (address) {
        return address(new VentureCapital(config));
    }
}
