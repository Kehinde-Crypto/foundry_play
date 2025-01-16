// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/NFT.sol";

contract DeployAndMintNFT is Script {
    NFT public nft;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        nft = new NFT();

        vm.stopBroadcast();
    }
}
