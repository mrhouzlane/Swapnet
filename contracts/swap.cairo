# SPDX-License-Identifier: MIT

# Declare this file as a StarkNet contract.
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import library_call, get_caller_address
from starkware.cairo.common.uint256 import Uint256

# Openzepplin imports
from openzeppelin.token.erc20.library import (
    ERC20_name, ERC20_symbol, ERC20_totalSupply, ERC20_decimals, ERC20_balanceOf, ERC20_allowance,
    ERC20_initializer, ERC20_approve, ERC20_increaseAllowance, ERC20_decreaseAllowance,
    ERC20_transfer, ERC20_transferFrom)

from openzeppelin.utils.constants import TRUE

# ---------------------------------------------- SETUP FOR THE SWAP ----------------------------------------------
# 1. TRANSFER FROM
# Smart contract in control of 100 DAI : before the swap
# We send 100 DAI to the smart contract

func SetupSwap{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        sender : felt, recipient : felt, amount : Uint256) -> (success : felt):
    let (caller) = get_caller_address()
    let (contract_address) = get_contract_address()
    ERC20.transfer_from(
        contract_address=DAI_address, sender=caller, recipient=contract_address, amount=amount)
    return (TRUE)
end

# 2.APPROVE

IERC20.approve(contract_address=DAI_address, spender=router, amount=amount)

# ---------------------------------------------- SWAP PROCESS ----------------------------------------------

let (deadline) = get_block_timestamp()
let (local path : felt*) = alloc()
assert [path] = DAI_address
assert [path + 1] = ETH_address
let path_len = 2
IRouter.swap_exact_tokens_for_tokens(
    contract_address=router,
    amountIn=amount,
    amountOutMin=amountOutMin,
    path_len=path_len,
    path=path,
    to=contract_address,
    deadline=deadline)
