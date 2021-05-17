from brownie import Flashloan, accounts


def main():
    # https://multiplierfinance.medium.com/multi-chain-lend-protocol-is-live-on-bsc-5003735e3c18
    multiplier = "0xCc0479a98cC66E85806D0Cd7970d6e07f77Fd633"
    flashloan = Flashloan.deploy(multiplier, {'from': accounts[0]})
    accounts[0].transfer(to=flashloan.address, amount=10**18)
    return flashloan
