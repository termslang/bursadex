/*
   BURSA DAO              Source code available under GPLv2 license
                          2018  Michael Baynov <m.baynov@gmail.com>
*/
pragma solidity ^0.4.19;
contract Bursa {
  function withdraw(uint256 amount) public {}
  function balanceOf(address user) constant public returns (uint256 balance) {}
}


contract BursaDAO {
  address public bursa = 0xC9d78ebd4D11d0Dd6FE16953EfE6534A2cc0A9c7;
  uint256 public totalSupply;
  address private admin;

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);


  mapping (address => mapping (address => uint256)) private approved;
  mapping (uint256 => address) private owners;
  mapping (address => uint256) private funds;


  function BursaDAO() public {
    admin = msg.sender;
    totalSupply = 1000000;
    funds[msg.sender] = 1000000;
  }


  function name() constant public returns (string) {
    return "BURSA OWNERSHIP TOKEN";
  }
  function symbol() constant public returns (string) {
    return "BDAO";
  }
  function decimals() constant public returns (uint256) {
    return 18;
  }
  function balanceOf(address user)
  constant public returns (uint256 balance) {
    return funds[user];
  }


  function _saveOwnership(address user) private {
    uint256 i;
    while (owners[i] != 0 && owners[i] != 0x01 && owners[i] != user) ++i;
    if (owners[i] != user) owners[i] = user;
  }
  function _removeOwnership(address user) private {
    uint256 i;
    while (owners[i] != 0 && owners[i] != user) ++i;
    if (owners[i] != 0) owners[i] = 0x01;
  }

  function transfer(address _to, uint256 _value) public returns (bool success) {
    if (_value > funds[msg.sender]) _value = funds[msg.sender];
    if (_value == 0) revert();

    funds[msg.sender] -= _value;
    funds[_to] += _value;

    if (funds[msg.sender] >= 5) {   // 5%
      _saveOwnership(msg.sender);
    } else _removeOwnership(msg.sender);

    if (funds[_to] >= 5) {
      _saveOwnership(_to);
    } else _removeOwnership(_to);

    Transfer(msg.sender, _to, _value);
    return true;
  }
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    if (_value > funds[msg.sender]) _value = funds[msg.sender];
    if (_value == 0) revert();

    //TODO::::same as transfer
    if (_value > approved[_from][msg.sender]) _value = approved[_from][msg.sender];
    funds[_from] -= _value;
    funds[_to] += _value;
    approved[_from][msg.sender] -= _value;
    Transfer(_from, _to, _value);
    return true;
  }
  function approve(address _spender, uint256 _value) public returns (bool success) {
    if (_spender == address(this)) return true;
    approved[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }
  function allowance(address _owner, address _spender) constant public returns (uint256 remaining) {
    if (_spender == address(this)) return balanceOf(_owner);
    return approved[_owner][_spender];
  }


  function withdraw() public {
    uint256 b = Bursa(bursa).balanceOf(address(this));
    uint256 totalShares;
    uint256 i;
    while (owners[i] != 0) {
      if (owners[i] != 0x01) totalShares += funds[owners[i]];
      ++i;
    }
    while (owners[i] != 0) {
      if (owners[i] != 0x01) {
        uint256 amount = b * funds[owners[i]] / totalShares;
        owners[i].transfer(amount);
      }
      ++i;
    }
    Bursa(bursa).withdraw(b);
  }


}
