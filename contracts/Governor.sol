// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/governance/GovernorUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/governance/extensions/GovernorSettingsUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/governance/extensions/GovernorCountingSimpleUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/governance/extensions/GovernorTimelockControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "./interfaces/IFollowNFT.sol";

contract Governor is 
  Initializable,
  GovernorUpgradeable,
  GovernorSettingsUpgradeable,
  GovernorCountingSimpleUpgradeable,
  GovernorTimelockControlUpgradeable,
  OwnableUpgradeable,
  UUPSUpgradeable {

  IFollowNFT public token;

  /// @custom:oz-upgrades-unsafe-allow constructor
  constructor() initializer {}

  function initialize(IFollowNFT _token, TimelockControllerUpgradeable _timelock)
    initializer public
  {
    // TODO: Edit this to programmatically generate the name instead of governor (FE v1)
    __Governor_init("Governor");
    __GovernorSettings_init(1 /* 1 block */, 45818 /* 1 week */, 0);
    __GovernorCountingSimple_init();
    __GovernorTimelockControl_init(_timelock);
    __Ownable_init();
    __UUPSUpgradeable_init();

    token = _token;
  }

  function _authorizeUpgrade(address newImplementation)
    internal
    onlyOwner
    override
  {}

  // The following functions are overrides required by Solidity.
  function votingDelay()
    public
    view
    override(IGovernorUpgradeable, GovernorSettingsUpgradeable)
    returns (uint256)
  {
    return super.votingDelay();
  }

  function votingPeriod()
    public
    view
    override(IGovernorUpgradeable, GovernorSettingsUpgradeable)
    returns (uint256)
  {
    return super.votingPeriod();
  }

  function quorum(uint256 blockNumber)
    public
    view
    override(IGovernorUpgradeable)
    returns (uint256)
  {
    // TODO: constants and parameters for numerator and denominator (FE v1)
    uint256 numerator = 4;
    uint256 denominator = 100;
    return (token.getDelegatedSupplyByBlockNumber(blockNumber) * numerator) / denominator;
  }

  function getVotes(address account, uint256 blockNumber)
    public
    view
    override(IGovernorUpgradeable)
    returns (uint256)
  {
    return token.getPowerByBlockNumber(account, blockNumber);
  }

  function state(uint256 proposalId)
    public
    view
    override(GovernorUpgradeable, GovernorTimelockControlUpgradeable)
    returns (ProposalState)
  {
    return super.state(proposalId);
  }

  function propose(address[] memory targets, uint256[] memory values, bytes[] memory calldatas, string memory description)
    public
    override(GovernorUpgradeable, IGovernorUpgradeable)
    returns (uint256)
  {
    return super.propose(targets, values, calldatas, description);
  }

  function proposalThreshold()
    public
    view
    override(GovernorUpgradeable, GovernorSettingsUpgradeable)
    returns (uint256)
  {
    return super.proposalThreshold();
  }

  function _execute(uint256 proposalId, address[] memory targets, uint256[] memory values, bytes[] memory calldatas, bytes32 descriptionHash)
    internal
    override(GovernorUpgradeable, GovernorTimelockControlUpgradeable)
  {
    super._execute(proposalId, targets, values, calldatas, descriptionHash);
  }

  function _cancel(address[] memory targets, uint256[] memory values, bytes[] memory calldatas, bytes32 descriptionHash)
    internal
    override(GovernorUpgradeable, GovernorTimelockControlUpgradeable)
    returns (uint256)
  {
    return super._cancel(targets, values, calldatas, descriptionHash);
  }

  function _executor()
    internal
    view
    override(GovernorUpgradeable, GovernorTimelockControlUpgradeable)
    returns (address)
{
    return super._executor();
  }

  function supportsInterface(bytes4 interfaceId)
    public
    view
    override(GovernorUpgradeable, GovernorTimelockControlUpgradeable)
    returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }
}