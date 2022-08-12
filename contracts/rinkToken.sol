// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Remix style import
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract rinkToken is ERC20 {

    constructor() ERC20("RinkToken", "RITK") {
    }

    function mint(
        address recipient,
        uint256 amount
        )
        public
        virtual
        {
        _mint(recipient, amount);
    }
}