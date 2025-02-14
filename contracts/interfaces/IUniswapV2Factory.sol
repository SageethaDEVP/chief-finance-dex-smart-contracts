pragma solidity >=0.6.2;

interface IUniswapV2Factory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint
    );
    event SwapFeeBPChanged(uint256 timestamp, uint256 value);
    event SwapLimitBPChanged(uint256 timestamp, uint256 value);
    event AddLiquidityFeeBPChanged(uint256 timestamp, uint256 value);
    event RemoveLiquidityFeeBPChanged(uint256 timestamp, uint256 value);
    event FeeReceiverChanged(uint256 timestamp, address feeTo);
    event adminAdded(uint256 timestamp, address admin);
    event adminRemoved(uint256 timestamp, address admin);
    event lockStatus(uint256 timestamp, address pool);
    event unlockStatus(uint256 timestamp, address pool);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);

    function feeReceiver() external view returns (address);
    function setFeeReceiver(address _feeReceiver) external;

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;

    function swapLimitBP() external view returns (uint256);
    function setSwapLimitBP(uint256 value) external;

    function swapFeeBP() external view returns (uint256);
    function setSwapFeeBP(uint256 value) external;

    function addLiquidityFeeBP() external view returns (uint256);
    function setAddLiquidityFeeBP(uint256 value) external;

    function removeLiquidityFeeBP() external view returns (uint256);
    function setRemoveLiquidityFeeBP(uint256 value) external;
}
