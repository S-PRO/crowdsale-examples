pragma solidity ^0.4.24;

import "./math/SafeMath.sol";
import "./ownership/Ownable.sol";
import "./token/ERC20.sol";
import "./token/SafeERC20.sol";

/**
 * @title VestingStorage
 * @dev The contract where tokens will be stored until vesting period expired
 *
 * !!! This contract is presented only for demo purpose and may contain errors, don't use it in production.
*/

contract VestingStorage is Ownable {
  using SafeMath for uint256;
  using SafeERC20 for ERC20;

  event Deposited(address indexed payee, uint256 weiAmount);
  event Unlocked(address indexed payee, uint256 weiAmount);

  ERC20 public token;

  uint unlockTime;

  mapping(address => uint256) private deposits;

  constructor(address _token, uint _unlockTime) {
    require(_unlockTime >= block.timestamp);

    token = ERC20(_token);
    unlockTime = _unlockTime;
  }

  function depositsOf(address _beneficiary) public view returns (uint256) {
    return deposits[_beneficiary];
  }

  /**
  * @dev Stores specified amount of tokens for beneficiary.
  * @param _beneficiary The address of the tokens owner.
  */
  function deposit(address _beneficiary, uint _amount) public onlyOwner {
    deposits[_beneficiary] = deposits[_beneficiary].add(_amount);

    emit Deposited(_beneficiary, _amount);
  }

  /**
  * @dev Unlocks tokens for specified address.
  * @param _beneficiary The address whose funds will be unlocked.
  */
  function unlock(address _beneficiary) public {
    require(block.timestamp == unlockTime);

    uint256 payment = deposits[_beneficiary];

    require(payment > 0);

    deposits[_beneficiary] = 0;

    token.safeTransfer(_beneficiary, payment);

    emit Unlocked(_beneficiary, payment);
  }
}