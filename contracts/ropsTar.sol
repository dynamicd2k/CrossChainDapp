// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC20Rops } from "./IERC20Rops.sol";

contract ropsTar {

    event BridgeInitialized(uint indexed timestamp);
    event TokensBridged(address indexed requester, bytes32 indexed mainDepositHash, uint amount, uint timestamp);
    event TokensReturned(address indexed requester, bytes32 indexed sideDepositHash, uint amount, uint timestamp);
    
    IERC20Rops private ropsToken;
    bool private bridgeInitState;
    address private owner;


    constructor () {
        owner = msg.sender;
    }

    function initializeBridge (address _ropsTokenAddress) onlyOwner external {
        ropsToken = IERC20Rops(_ropsTokenAddress);
        bridgeInitState = true;
    }

    function bridgeTokens (address _requester, uint _bridgedAmount, bytes32 _rinkebyDepositHash) verifyInitialization   external {
        require(_requester== msg.sender, 'Only owner can bridge tokens');
        ropsToken.mint(address(ropsToken),_bridgedAmount);
        ropsToken.mint(_requester,_bridgedAmount);
        emit TokensBridged(_requester, _rinkebyDepositHash, _bridgedAmount, block.timestamp);
    }


    function returnTokens (address _requester, uint _bridgedAmount, bytes32 _ropstenDepositHash) verifyInitialization  external {
        require(_requester== msg.sender, 'Only owner can retrieve tokens');
        ropsToken.burnFrom(_requester, _bridgedAmount);
        emit TokensReturned(_requester, _ropstenDepositHash, _bridgedAmount, block.timestamp);
    }

    modifier verifyInitialization {
      require(bridgeInitState, "Bridge has not been initialized");
      _;
    }

    modifier onlyOwner {
      require(msg.sender == owner, "Only owner can execute this function");
      _;
    }
}