// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/proxy/ClonesUpgradeable.sol";
import "./Governor.sol";
import "./TimelockControl.sol";
import "./interfaces/ILensHub.sol";
import "./interfaces/IFollowNFT.sol";

contract GovernorFactory {
  address constant LENS_HUB_PROXY = 0x4BF0c7AD32Fd2d32089790a54485e23f5C7736C0;
  address public governor;
  address public timelockControl;

  event GovernorCreated(IFollowNFT followNFT, address governorAddress, address timelockAddress);

  constructor(address _governor, address _timelockControl) {
    require(_governor != address(0), "Governor not defined");
    governor = _governor;
    timelockControl = _timelockControl;
  }

  function createGovernor(
    uint256 profileId,
    uint256 minDelay,
    address[] memory proposers,
    address[] memory executors
  ) public {

    ILensHub LensHub = ILensHub(LENS_HUB_PROXY);
    address followNFTAddress = LensHub.getFollowNFT(profileId);
    require(followNFTAddress != address(0), "No existing FollowNFT");

    IFollowNFT followNFT = IFollowNFT(followNFTAddress);

    address payable newGovernorAddress = payable(ClonesUpgradeable.clone(governor));
    address payable newTimeLockControlAddress = payable(ClonesUpgradeable.clone(timelockControl));

    TimelockControl newTimelockControl = TimelockControl(newTimeLockControlAddress);
    newTimelockControl.initialize(minDelay, proposers, executors);

    Governor newGovernor = Governor(newGovernorAddress);
    newGovernor.initialize(followNFT, newTimelockControl);

    emit GovernorCreated(followNFT, newGovernorAddress, newTimeLockControlAddress);
  }

}