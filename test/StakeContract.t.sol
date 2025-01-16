// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {StakeContract} from "../test/mocks/StakeContract.t.sol";
import {MockERC20} from "../test/mocks/MockERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../lib";

contract StakeContractTest is Test {
    //  state variable
    StakeContract public stakeContract;
    MockERC20 public mockToken;

    function setUp() public {
        stakeContract = new StakeContract();
        mockToken = new MockERC20();
    }

    function testStake() public {
        uint256 amount = 10e18;
        mockToken.approve(address(stakeContract), amount);
        bool stakePassed = stakeContract.stake(amount, address(mockToken));
        assertTrue(stakePassed, "Stake failed");
    }
}
