// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;
pragma abicoder v2;

import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';

interface IERC20{
    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 amount) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);
}

interface IUniswapV3Factory{
    function getPool(
        address tokenA,
        address tokenB,
        uint24 fee
    ) external view returns (address pool);
}

contract SimpleSwap {

    //definingISwapRouter
    address public constant swapRouteraddress = 0xE592427A0AEce92De3Edee1F18E0157C05861564; 
    ISwapRouter public immutable swapRouter = ISwapRouter(swapRouteraddress);

    //defining IUniswapV3Factory
    address public constant V3Factoryaddress = 0x1F98431c8aD98523631AE4a59f267346ea31F984;
    IUniswapV3Factory public immutable V3Factory = IUniswapV3Factory(V3Factoryaddress);
    
 //   constructor(ISwapRouter _swapRouter) {}

    function checkPool(address _tokenA, address _tokenB, uint24 _fee) external view returns (address _poolAddress){
        _poolAddress = V3Factory.getPool(_tokenA, _tokenB, _fee);
    }

    function swap_AtoB(uint256 amountIn, address _tokenA, address _tokenB, uint24 _fee) external returns (uint256 amountOut) {
        //checking if the pool exist
        require(V3Factory.getPool(_tokenA, _tokenB, _fee) != address(0));
        //defining IERC20
        IERC20 TokenA = IERC20(_tokenA);

        TokenA.transferFrom(msg.sender, address(this), amountIn);
        TokenA.approve(swapRouteraddress, amountIn);
        // Note: To use this example, you should explicitly set slippage limits, omitting for simplicity
        uint256 minOut = /* Calculate min output */ 0;
        uint160 priceLimit = /* Calculate price limit */ 0;
        // Create the params that will be used to execute the swap
        ISwapRouter.ExactInputSingleParams memory params =
            ISwapRouter.ExactInputSingleParams({
                tokenIn: _tokenA,
                tokenOut: _tokenB,
                fee: _fee,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountIn: amountIn,
                amountOutMinimum: minOut,
                sqrtPriceLimitX96: priceLimit
            });
        // The call to `exactInputSingle` executes the swap.
        amountOut = swapRouter.exactInputSingle(params);
    }
}