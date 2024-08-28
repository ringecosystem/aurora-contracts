// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Aggregator} from "../src/Aggregator.sol";

contract AggregatorScript is Script {
    Aggregator public aggregator;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        aggregator = new Aggregator();

        vm.stopBroadcast();
    }
}
