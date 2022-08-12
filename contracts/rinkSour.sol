// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract rinkSour {

    address private admin;

    address private ownerOfERC20Token;

    IERC20 private erc20Token;

    mapping(address=>uint) public lockedTokens;

    event tokensLocked(address indexed requester, bytes32 indexed rinkebyDepositHash, uint amount, uint timestamp);

    event tokensUnlocked(address indexed requester, bytes32 indexed ropstenDepositHash, uint amount, uint timestamp);

    constructor(){
        admin= msg.sender;
    }

    function initialiseERC20TokenAddress(IERC20 ERC20TokenAddress, address _owner) external{
        erc20Token =ERC20TokenAddress;
        ownerOfERC20Token = _owner;
    }

    function approve(address _requester, uint _bridgedAmount) external{
        require(_bridgedAmount>=1000000000000000000,'Atleast 1.0 tokens should be sent');
        erc20Token.approve(_requester, _bridgedAmount);
    }

    function lockTokens(address _requester, uint _bridgedAmount, bytes32 rinkebyDepositHash) payable external{
        require(_bridgedAmount>=1000000000000000000,'Atleast 1.0 tokens should be sent');
        lockedTokens[_requester]= lockedTokens[_requester]+ _bridgedAmount;
        emit tokensLocked(_requester, rinkebyDepositHash, _bridgedAmount, block.timestamp);
    }

    function unlockTokens(address _requester, uint _unlockAmount, bytes32 ropstenDepositHash) external{
        require(msg.sender== _requester, 'Only holder of tokens can unlock tokens');
        require(lockedTokens[_requester]>= _unlockAmount, 'Unlock amount requested greater than total locked amount');
        lockedTokens[_requester]= lockedTokens[_requester]- _unlockAmount;
        erc20Token.transfer(_requester, _unlockAmount);
        emit tokensUnlocked(_requester, ropstenDepositHash, _unlockAmount, block.timestamp);
    }

    function viewERC20Token() view external returns (IERC20){
        return erc20Token;
    }

    function viewERC20Owner() view external returns(address){
        return ownerOfERC20Token;
    }
}