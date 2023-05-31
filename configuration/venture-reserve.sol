// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

import "./ReserveConfiguration.sol";

contract VentureCapital {
    using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

    // Reserve configuration mapping
    mapping(address => DataTypes.ReserveConfigurationMap) public reserveConfigurations;

    // Event emitted when the reserve configuration is updated
    event ReserveConfigurationUpdated(address indexed reserve, uint256 data);

    /**
     * @dev Sets the Loan to Value of a reserve
     * @param reserve The address of the reserve
     * @param ltv The new loan to value
     **/
    function setLtv(address reserve, uint256 ltv) external {
        reserveConfigurations[reserve].setLtv(ltv);
        emit ReserveConfigurationUpdated(reserve, reserveConfigurations[reserve].data);
    }

    /**
     * @dev Gets the Loan to Value of a reserve
     * @param reserve The address of the reserve
     * @return The loan to value
     **/
    function getLtv(address reserve) external view returns (uint256) {
        return reserveConfigurations[reserve].getLtv();
    }

    // Add other functions to set and get other reserve configuration parameters
}

