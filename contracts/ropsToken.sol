// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/* Contract Imports */

//Remix style import
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { ERC20Burnable } from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract ropsToken is ERC20, ERC20Burnable {
    

    constructor () ERC20("RopsToken", "RTK") {
    }

    /**
    * @dev Only callable by account with access (gateway role)
    */

    function mint(
        address recipient,
        uint256 amount
        )
        public
        virtual
        {
        _mint(recipient, amount);
    }

    /**
    * @dev Only callable by account with access (gateway role)
    * @inheritdoc ERC20Burnable
    */
    function burn(
        uint256 amount
        )
        public
        override(ERC20Burnable)
        virtual
        {
        super.burn(amount);
    }

    /**
    * @dev Only callable by account with access (gateway role)
    * @inheritdoc ERC20Burnable
    */
    function burnFrom(
        address account,
        uint256 amount
        )
        public
        override(ERC20Burnable)
        virtual
        {
        super.burnFrom(account, amount);
    }
}