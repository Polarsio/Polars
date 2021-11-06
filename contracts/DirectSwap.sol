pragma solidity ^0.7.6;
// "SPDX-License-Identifier: Apache License 2.0"

import "./IERC20.sol";

contract DirectSwap {
    
    IERC20 public _oldToken;
    IERC20 public _newToken;

    constructor(address oldTokenAdddress, address newTokenAddress) {
        _oldToken = IERC20(oldTokenAdddress);
        _newToken = IERC20(newTokenAddress);
    }

    function upgradeTokens() external {
        require(_oldToken.balanceOf(msg.sender) > 0, "No tokens to swap on user balance");
        require(_oldToken.balanceOf(msg.sender) <= _oldToken.allowance(msg.sender, address(this)));
        uint256 userBalance = _oldToken.balanceOf(msg.sender);
        _oldToken.transferFrom(msg.sender, address(this), userBalance);
        _newToken.transfer(msg.sender, userBalance);
    }
}