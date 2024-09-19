// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "./interfaces/IERC20.sol";

contract OrderBasedSwapContract {
     address owner;

     constructor() {
        owner = msg.sender;
     }

     struct userDeposit {
        address tokenAddress;
        uint userDepositAmount;
     }

     mapping(address => userDeposit) userDepositData;

     error insufficientBalance();


     function depositToken(uint _tokenAmount, address _tokenAddress) external {
        uint userTokenBalance = IERC20(_tokenAddress).balanceOf(msg.sender);

        if(userTokenBalance < _tokenAmount) {
            revert insufficientBalance();
        }

        IERC20(_tokenAddress).transferFrom(msg.sender, address(this), _tokenAmount);

        userDepositData[msg.sender] = userDeposit({
            tokenAddress: _tokenAddress,
            userDepositAmount: _tokenAmount

        });
        
     }

     function swapTokens() external {}
}
