pragma solidity ^0.8.0;

contract ConversionRatio {
    uint256 public ratio;

    event ConversionRatioSet(uint256 ratio);

    constructor(uint256 _ratio) {
        ratio = _ratio;
    }

    function setConversionRatio(uint256 newRatio) external {
        require(newRatio > 0, "Conversion ratio must be greater than zero");
        ratio = newRatio;
        emit ConversionRatioSet(ratio);
    }
}

