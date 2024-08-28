// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {
    AuroraSdk,
    Codec,
    NEAR,
    PromiseCreateArgs,
    PromiseResult,
    PromiseResultStatus,
    PromiseWithCallback
} from "aurora-sdk/AuroraSdk.sol";
import "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract Aggregator {
    using AuroraSdk for NEAR;
    using AuroraSdk for PromiseCreateArgs;
    using AuroraSdk for PromiseWithCallback;
    using Codec for bytes;

    event LogCallback(string result);

    NEAR public near;
    bytes32 public constant CALLBACK_ROLE = keccak256("CALLBACK_ROLE");

    constructor() {
        near = AuroraSdk.initNear(IERC20(0x4861825E75ab14553E5aF711EbbE6873d369d146));
    }

    function requestMpc() public {
        bytes memory data = abi.encodePacked(
            "{\"request\":{\"payload\":[162,253,86,233,66,108,214,56,2,159,148,32,96,165,195,112,79,150,192,88,60,73,206,14,69,241,68,174,142,115,61,249],\"path\":\"ethereum-1\",\"key_version\":0}}"
        );
        PromiseCreateArgs memory callMpc =
            near.call("v1.signer-prod.testnet", "sign", data, 100_000_000_000_000_000_000_0000, 250_000_000_000_000);
        PromiseCreateArgs memory callback =
            near.auroraCall(address(this), abi.encodePacked(this.mpcCallback.selector), 0, 10_000_000_000_000);
        callMpc.then(callback).transact();
    }

    function mpcCallback() public {
        PromiseResult memory result = AuroraSdk.promiseResult(0);

        if (result.status != PromiseResultStatus.Successful) {
            revert("MpcCallback failed");
        }
        emit LogCallback(string(result.output));
    }
}
