pragma solidity ^0.4.24;

import "./crowdsale/TimedCrowdsale.sol";
import "./crowdsale/VestingCrowdsale.sol";

/**
 * @title CustomCrowdsale
 * @dev Crowdsale contract which containing functionality 
 * for setting time period when token purchasing is available 
 * and locking tokens in additional contract for period of time specified in it.
 * After this period is ended tokens can be unlocked. 
 *
 * !!! This contract is presented only for demo purpose and may contain errors, don't use it in production.
 */
contract CustomCrowdsale is TimedCrowdsale, VestingCrowdsale {

  constructor(
    uint256 _openingTime,
    uint256 _closingTime,
    uint256 _rate,
    address _wallet,
    address _token,
    address _vestingStorage
  )
    public
    Crowdsale(_rate, _wallet, ERC20(_token))
    TimedCrowdsale(_openingTime, _closingTime)
    VestingCrowdsale(_vestingStorage)
  {

  }
}