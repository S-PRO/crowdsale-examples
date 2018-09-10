pragma solidity ^0.4.24;

import "./Crowdsale.sol";
import "../VestingStorage.sol";

  /**
   * @title VestingCrowdsale
   * @dev Crowdsale save all balances in additional contract where they stored until vesting period expires. 
   * During this period operations with tokens not available.
   *
   * !!! This contract is presented only for demo purpose and may contain errors, don't use it in production.
   */
contract VestingCrowdsale is Crowdsale {

  // The contract where tokens will be stored until vesting period expired
  VestingStorage public vestingStorage;

  
  /**
   * @param _vestingStorage Address of contract for storing balances during vesting period
   */
  constructor(address _vestingStorage) public {
    require(_vestingStorage != address(0));

    _vestingStorage = VestingStorage(_vestingStorage);
  }
  

  /**
   * @dev increase token balance for purchaser in vesting storage contract
   * @param _beneficiary Address performing the token purchase
   * @param _tokenAmount Number of tokens to be emitted
   */
  function _deliverTokens(
    address _beneficiary,
    uint256 _tokenAmount
  )
    internal
  {
    vestingStorage.deposit(_beneficiary, _tokenAmount);
  }
  
}