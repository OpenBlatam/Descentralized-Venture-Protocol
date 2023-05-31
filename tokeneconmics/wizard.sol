pragma solidity ^0.8.0;

contract TokenomicsWizard {
    string public tokenName;
    string public tokenSymbol;
    uint256 public tokenSupply;
    uint8 public decimalPlaces;
    mapping(address => uint256) public initialDistribution;

    constructor() {
        tokenName = "";
        tokenSymbol = "";
        tokenSupply = 0;
        decimalPlaces = 0;
    }

    function setTokenName(string memory name) public {
        tokenName = name;
    }

    function setTokenSymbol(string memory symbol) public {
        tokenSymbol = symbol;
    }

    function setTokenSupply(uint256 supply) public {
        tokenSupply = supply;
    }

    function setDecimalPlaces(uint8 places) public {
        decimalPlaces = places;
    }

    function setInitialDistribution(address[] memory recipients, uint256[] memory amounts) public {
        require(recipients.length == amounts.length, "Array lengths do not match");

        for (uint256 i = 0; i < recipients.length; i++) {
            initialDistribution[recipients[i]] = amounts[i];
        }
    }

    function generateTokenomicsReport() public view returns (string memory) {
        string memory report = string(abi.encodePacked(
            "Token Name: ", tokenName, "\n",
            "Token Symbol: ", tokenSymbol, "\n",
            "Token Supply: ", uint2str(tokenSupply), "\n",
            "Decimal Places: ", uint2str(decimalPlaces), "\n",
            "Initial Distribution: ", initialDistributionToString(), "\n"
        ));
        // Add more information to the report as needed
        return report;
    }

    function initialDistributionToString() internal view returns (string memory) {
        string memory distribution = "";

        for (uint256 i = 0; i < recipients.length; i++) {
            distribution = string(abi.encodePacked(distribution, addressToString(recipients[i]), ": ", uint2str(initialDistribution[recipients[i]]), ", "));
        }

        return distribution;
    }

    function addressToString(address addr) internal pure returns (string memory) {
        bytes32 value = bytes32(uint256(uint160(addr)));
        bytes memory alphabet = "0123456789abcdef";

        bytes memory str = new bytes(42);
        str[0] = '0';
        str[1] = 'x';

        for (uint256 i = 0; i < 20; i++) {
            str[2 + i * 2] = alphabet[uint8(value[i + 12] >> 4)];
            str[3 + i * 2] = alphabet[uint8(value[i + 12] & 0x0f)];
        }

        return string(str);
    }

    function uint2str(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }

        uint256 temp = value;
        uint256 digits;

        while (temp != 0) {
            digits++;
            temp /= 10;
        }

        bytes memory buffer = new bytes(digits);
        uint256 index = digits - 1;

        while (value != 0) {
            buffer[index--] = bytes1(uint8(48 + (value % 10)));
            value /= 10;
        }

        return string(buffer);
    }
}

