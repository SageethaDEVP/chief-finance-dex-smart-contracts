pragma solidity ^0.6.2;

import './interfaces/IUniswapV2Factory.sol';
import './UniswapV2Pair.sol';
import './libraries/Roles.sol';

contract UniswapV2Factory is IUniswapV2Factory {
    using Roles for Roles.Role;

    Roles.Role private _admin;

    address public override feeTo;
    address public override feeToSetter;
    bytes32 public constant INIT_CODE_HASH =
        keccak256(abi.encodePacked(type(UniswapV2Pair).creationCode));

    mapping(address => mapping(address => address)) public override getPair;
    address[] public override allPairs;
    uint256 public override swapLimitBP;

    uint256 public override swapFeeBP;
    uint256 public override addLiquidityFeeBP;
    uint256 public override removeLiquidityFeeBP;

    address public override feeReceiver;

    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
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

    constructor(address _feeToSetter, address _feeReceiver) public {
        feeToSetter = _feeToSetter;
        feeReceiver = _feeReceiver;
        swapLimitBP = 500;
        swapFeeBP = 500;
        addLiquidityFeeBP = 500;
        removeLiquidityFeeBP = 500;
        _admin.add(msg.sender);
    }

    function addAdmin(address account) external {
        require(_admin.has(msg.sender), 'UniswapV2: FORBIDDEN');
        _admin.add(account);
        emit adminAdded(block.timestamp, account);
    }

    function removeAdmin(address account) external {
        require(_admin.has(msg.sender), 'UniswapV2: FORBIDDEN');
        _admin.remove(account);
        emit adminRemoved(block.timestamp, account);
    }

    function lock(address pool) external {
        require(_admin.has(msg.sender), 'UniswapV2: FORBIDDEN');
        UniswapV2Pair(pool).setLock(true);
        emit lockStatus(block.timestamp, pool);
    }

    function unlock(address pool) external {
        require(_admin.has(msg.sender), 'UniswapV2: FORBIDDEN');
        UniswapV2Pair(pool).setLock(false);
        emit unlockStatus(block.timestamp, pool);
    }

    function setFeeReceiver(address _feeReceiver) external override {
        require(_admin.has(msg.sender), 'UniswapV2: FORBIDDEN');
        feeReceiver = _feeReceiver;
        emit FeeReceiverChanged(block.timestamp, _feeReceiver);
    }

    function setSwapLimitBP(uint256 value) external override {
        require(_admin.has(msg.sender), 'UniswapV2: FORBIDDEN');
        swapLimitBP = value;
        emit SwapLimitBPChanged(block.timestamp, value);
    }

    function setSwapFeeBP(uint256 value) external override {
        require(_admin.has(msg.sender), 'UniswapV2: FORBIDDEN');
        swapFeeBP = value;
        emit SwapFeeBPChanged(block.timestamp, value);
    }

    function setAddLiquidityFeeBP(uint256 value) external override {
        require(_admin.has(msg.sender), 'UniswapV2: FORBIDDEN');
        addLiquidityFeeBP = value;
        emit AddLiquidityFeeBPChanged(block.timestamp, value);
    }

    function setRemoveLiquidityFeeBP(uint256 value) external override {
        require(_admin.has(msg.sender), 'UniswapV2: FORBIDDEN');
        removeLiquidityFeeBP = value;
        emit RemoveLiquidityFeeBPChanged(block.timestamp, value);
    }

    function allPairsLength() external view override returns (uint256) {
        return allPairs.length;
    }

    function createPair(
        address tokenA,
        address tokenB
    ) external override returns (address pair) {
        require(tokenA != tokenB, 'UniswapV2: IDENTICAL_ADDRESSES');
        (address token0, address token1) = tokenA < tokenB
            ? (tokenA, tokenB)
            : (tokenB, tokenA);
        require(token0 != address(0), 'UniswapV2: ZERO_ADDRESS');
        require(
            getPair[token0][token1] == address(0),
            'UniswapV2: PAIR_EXISTS'
        ); // single check is sufficient
        bytes memory bytecode = type(UniswapV2Pair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        IUniswapV2Pair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external override {
        require(_admin.has(msg.sender), 'UniswapV2: FORBIDDEN');
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external override {
        require(_admin.has(msg.sender), 'UniswapV2: FORBIDDEN');
        feeToSetter = _feeToSetter;
    }
}
