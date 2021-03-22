//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";


contract DecimalWrapper is ERC20 {
  using SafeMath for uint256;
  using SafeERC20 for IERC20;

  uint256 public conversion;
  IERC20 public underlying;

  constructor(string memory _name, string memory _symbol, address _underlying, uint256 _conversion) ERC20(_name, _symbol) {
    underlying = IERC20(_underlying);
    conversion = _conversion;
  }

  function deposit(uint256 _amount) external {
    underlying.safeTransferFrom(msg.sender, address(this), _amount);
    _mint(msg.sender, _amount.mul(conversion));
  }

  function withdraw(uint256 _amount) external {
    _burn(msg.sender, _amount);
    underlying.safeTransfer(msg.sender, _amount.div(conversion));
  }
}
