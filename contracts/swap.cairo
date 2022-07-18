# SPDX-License-Identifier: MIT

# Declare this file as a StarkNet contract.
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import (
    library_call, get_caller_address, get_contract_address, get_block_timestamp)
from starkware.cairo.common.uint256 import Uint256

# Openzepplin imports
from openzeppelin.token.erc20.library import ERC20
from openzeppelin.token.erc20.interfaces.IERC20 import IERC20
from starkware.cairo.common.bool import TRUE

@storage_var
func DAI_address() -> (dai : felt):
end

@storage_var
func router() -> (routed : felt):
end

# 1. TransferFrom
@external
func SetupSwap{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        sender : felt, recipient : felt, amount : Uint256) -> (success : felt):
    let (caller) = get_caller_address()
    let (contract_address) = get_contract_address()
    let (dai) = DAI_address.read()

    IERC20.transferFrom(
        contract_address=dai, sender=caller, recipient=contract_address, amount=amount)
    return (TRUE)
end

# 2.APPROVE
@external
func ApproveSwap{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        contract_address : felt, spender : felt, amount : Uint256) -> (res : felt):
    let (DAI_addr) = DAI_address.read()
    let (res) = router.read()
    IERC20.approve(contract_address=DAI_addr, spender=res, amount=amount)
    return (TRUE)
end
