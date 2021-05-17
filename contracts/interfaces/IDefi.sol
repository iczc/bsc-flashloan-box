pragma solidity ^0.5.0;

interface IDefi {
    function depositBNB( uint256 _amount) external payable ;
    function withdraw(uint256 _amount) external ;
}
