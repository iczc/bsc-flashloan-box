pragma solidity ^0.5.0;

import "OpenZeppelin/openzeppelin-contracts@2.4.0/contracts/token/ERC20/SafeERC20.sol";
import "OpenZeppelin/openzeppelin-contracts@2.4.0/contracts/math/SafeMath.sol";
import "OpenZeppelin/openzeppelin-contracts@2.4.0/contracts/utils/Address.sol";
import "./interfaces/IDefi.sol";


contract Defi is IDefi {

    using SafeMath for uint256;
    using Address for address;


    mapping(address => uint256) public bnbBank;

    address public constant BNB_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    event DepositBnbEvent(address indexed _user, uint256 _amount);
    event WithdrawBnbEvent(address indexed _user, uint256 _amount);

    function depositBNB( uint256 _amount) external payable {
        require(msg.value == _amount, "Incorrect funds amount");
        bnbBank[msg.sender] =  bnbBank[msg.sender].add(_amount);

        emit DepositBnbEvent(msg.sender, _amount);
    }

    function withdraw(uint256 _amount) external {

        require(_amount != 0, "Invalid withdrawal amount");
        require(bnbBank[msg.sender] >= _amount, "Insufficient amount to withdraw");

        bnbBank[msg.sender] =  bnbBank[msg.sender].sub(_amount);

        (bool success, ) = msg.sender.call.value(_amount)("");
        require(success, "Withdraw failed");

        emit WithdrawBnbEvent(msg.sender, _amount);
    }
}
