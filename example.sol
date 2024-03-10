// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract CallAnything {
    address public s_someAddr;
    uint256 public s_amount;
    function transfer(address someAddr, uint256 amount) public {
        s_someAddr = someAddr;
        s_amount = amount;
    }

    function getSelectorOne() public  pure returns (bytes4 selector) {
        return bytes4(keccak256(bytes("transfer(address,uint256)")));
    }

    function getDataToCallTransfer(address someAddr, uint256 amount) public pure returns (bytes memory) {
        return abi.encodeWithSelector(getSelectorOne(), someAddr, amount);
    }

    function callTransferFunctionWithBinary(address someAddr, uint256 amount) public returns(bytes4,bool){
        (bool success,bytes memory returnData) = address(this).call(getDataToCallTransfer(someAddr, amount));
        return (bytes4(returnData), success);
    }
}