// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/proxy/ClonesUpgradeable.sol";
import "./Governor.sol";
import "./TimelockControl.sol";

contract GovernorFactory {
  address public governor;
  address public timelockControl;

  event GovernorCreated(address followNFT, address governorAddress, address timelockAddress);

  constructor(address _governor, address _timelockControl) {
    require(_governor != address(0), "Governor not defined");
    governor = _governor;
    timelockControl = _timelockControl;
  }

  function createGovernor(
    address _followNFT,
    uint256 minDelay,
    address[] memory proposers,
    address[] memory executors
  ) public {
    // TODO: NFT or wrapper?
    address payable newGovernorAddress = payable(ClonesUpgradeable.clone(governor));
    address payable newTimeLockControlAddress = payable(ClonesUpgradeable.clone(timelockControl));

    TimelockControl newTimelockControl = TimelockControl(newTimeLockControlAddress);
    newTimelockControl.initialize(minDelay, proposers, executors);

    Governor newGovernor = Governor(newGovernorAddress);
    newGovernor.initialize(_followNFT, newTimelockControl);

    emit GovernorCreated(_followNFT, newGovernorAddress, newTimeLockControlAddress);
  }


}