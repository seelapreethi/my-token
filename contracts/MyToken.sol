// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Simple ERC-20-like token for learning
/// @notice Not a complete OpenZeppelin implementation, but covers the core ERC-20 behaviors
contract MyToken {
    // --- Token metadata ---
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    // --- State mappings ---
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // --- Events (emit after state changes) ---
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /// @notice Constructor mints the entire initial supply to deployer
    /// @param _name token name (e.g., "MyToken")
    /// @param _symbol token symbol (e.g., "MTK")
    /// @param _decimals number of decimals (commonly 18)
    /// @param _initialSupply initial token supply in smallest units (i.e., include decimals)
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;

        // Set totalSupply and assign to creator
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = _initialSupply;

        // Emit transfer event from 0x0 to deployer to signify minting
        emit Transfer(address(0), msg.sender, _initialSupply);
    }

    // --- Transfer tokens from caller to _to ---
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_to != address(0), "ERC20: transfer to the zero address");
        require(balanceOf[msg.sender] >= _value, "ERC20: insufficient balance");

        // Update balances
        unchecked {
            // unchecked safe here because require ensures balance >= _value
            balanceOf[msg.sender] -= _value;
        }
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // --- Approve _spender to spend _value on behalf of caller ---
    function approve(address _spender, uint256 _value) public returns (bool) {
        require(_spender != address(0), "ERC20: approve to the zero address");

        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // --- transferFrom: move tokens from _from to _to, using allowance ---
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool) {
        require(_from != address(0), "ERC20: transfer from the zero address");
        require(_to != address(0), "ERC20: transfer to the zero address");
        require(balanceOf[_from] >= _value, "ERC20: insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "ERC20: allowance exceeded");

        // Update balances and allowance
        unchecked {
            balanceOf[_from] -= _value;
            allowance[_from][msg.sender] -= _value;
        }
        balanceOf[_to] += _value;

        emit Transfer(_from, _to, _value);
        return true;
    }

    // --- Convenience functions to increase / decrease allowance safely ---
    function increaseAllowance(address _spender, uint256 _addedValue) public returns (bool) {
        require(_spender != address(0), "ERC20: increaseAllowance to zero address");

        allowance[msg.sender][_spender] += _addedValue;
        emit Approval(msg.sender, _spender, allowance[msg.sender][_spender]);
        return true;
    }

    function decreaseAllowance(address _spender, uint256 _subtractedValue) public returns (bool) {
        require(_spender != address(0), "ERC20: decreaseAllowance to zero address");
        uint256 current = allowance[msg.sender][_spender];
        require(current >= _subtractedValue, "ERC20: decreased allowance below zero");

        unchecked {
            allowance[msg.sender][_spender] = current - _subtractedValue;
        }
        emit Approval(msg.sender, _spender, allowance[msg.sender][_spender]);
        return true;
    }
}
