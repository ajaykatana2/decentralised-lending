// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Decentralised Lending Platform
 * @dev A peer-to-peer lending platform allowing users to deposit, borrow, and repay funds
 * @author Decentralised Lending Team
 */
contract Project {
    // State variables
    mapping(address => uint256) public deposits;
    mapping(address => uint256) public borrowedAmounts;
    mapping(address => uint256) public borrowTimestamps;
    
    uint256 public totalDeposits;
    uint256 public totalBorrowed;
    uint256 public constant INTEREST_RATE = 5; // 5% annual interest rate
    uint256 public constant COLLATERAL_RATIO = 150; // 150% collateralization required
    uint256 public constant SECONDS_PER_YEAR = 365 * 24 * 60 * 60;
    
    // Events
    event Deposit(address indexed user, uint256 amount, uint256 timestamp);
    event Borrow(address indexed user, uint256 amount, uint256 timestamp);
    event Repay(address indexed user, uint256 amount, uint256 interest, uint256 timestamp);
    event Withdraw(address indexed user, uint256 amount, uint256 timestamp);
    
    // Modifiers
    modifier hasDeposit() {
        require(deposits[msg.sender] > 0, "No deposits found");
        _;
    }
    
    modifier hasBorrowed() {
        require(borrowedAmounts[msg.sender] > 0, "No active loan found");
        _;
    }
    
    modifier canBorrow(uint256 _amount) {
        uint256 maxBorrow = (deposits[msg.sender] * 100) / COLLATERAL_RATIO;
        require(_amount <= maxBorrow, "Insufficient collateral");
        require(_amount <= (totalDeposits - totalBorrowed), "Insufficient liquidity");
        _;
    }
    
    /**
     * @dev Allows users to deposit ETH as collateral
     * Users can deposit ETH which can be used as collateral for borrowing
     */
    function depositCollateral() external payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        
        deposits[msg.sender] += msg.value;
        totalDeposits += msg.value;
        
        emit Deposit(msg.sender, msg.value, block.timestamp);
    }
    
    /**
     * @dev Allows users to borrow ETH against their collateral
     * @param _amount The amount of ETH to borrow
     * Users can borrow up to 66.67% of their deposited collateral (150% collateralization)
     */
    function borrowFunds(uint256 _amount) external hasDeposit canBorrow(_amount) {
        require(borrowedAmounts[msg.sender] == 0, "Existing loan must be repaid first");
        require(_amount > 0, "Borrow amount must be greater than 0");
        
        borrowedAmounts[msg.sender] = _amount;
        borrowTimestamps[msg.sender] = block.timestamp;
        totalBorrowed += _amount;
        
        // Transfer borrowed amount to user
        payable(msg.sender).transfer(_amount);
        
        emit Borrow(msg.sender, _amount, block.timestamp);
    }
    
    /**
     * @dev Allows users to repay their loan with interest
     * Interest is calculated based on time elapsed and annual interest rate
     */
    function repayLoan() external payable hasBorrowed {
        uint256 principal = borrowedAmounts[msg.sender];
        uint256 timeElapsed = block.timestamp - borrowTimestamps[msg.sender];
        uint256 interest = (principal * INTEREST_RATE * timeElapsed) / (100 * SECONDS_PER_YEAR);
        uint256 totalRepayment = principal + interest;
        
        require(msg.value >= totalRepayment, "Insufficient repayment amount");
        
        // Reset borrower's loan data
        borrowedAmounts[msg.sender] = 0;
        borrowTimestamps[msg.sender] = 0;
        totalBorrowed -= principal;
        
        // Refund excess payment if any
        if (msg.value > totalRepayment) {
            payable(msg.sender).transfer(msg.value - totalRepayment);
        }
        
        emit Repay(msg.sender, principal, interest, block.timestamp);
    }
    
    /**
     * @dev Allows users to withdraw their collateral
     * @param _amount The amount of collateral to withdraw
     * Users can only withdraw if they have no active loans
     */
    function withdrawCollateral(uint256 _amount) external hasDeposit {
        require(borrowedAmounts[msg.sender] == 0, "Must repay loan before withdrawal");
        require(_amount <= deposits[msg.sender], "Insufficient balance");
        require(_amount > 0, "Withdrawal amount must be greater than 0");
        
        deposits[msg.sender] -= _amount;
        totalDeposits -= _amount;
        
        payable(msg.sender).transfer(_amount);
        
        emit Withdraw(msg.sender, _amount, block.timestamp);
    }
    
    // View functions
    function getDepositBalance(address _user) external view returns (uint256) {
        return deposits[_user];
    }
    
    function getBorrowedAmount(address _user) external view returns (uint256) {
        return borrowedAmounts[_user];
    }
    
    function calculateCurrentInterest(address _user) external view returns (uint256) {
        if (borrowedAmounts[_user] == 0) return 0;
        
        uint256 principal = borrowedAmounts[_user];
        uint256 timeElapsed = block.timestamp - borrowTimestamps[_user];
        return (principal * INTEREST_RATE * timeElapsed) / (100 * SECONDS_PER_YEAR);
    }
    
    function getMaxBorrowAmount(address _user) external view returns (uint256) {
        if (deposits[_user] == 0) return 0;
        return (deposits[_user] * 100) / COLLATERAL_RATIO;
    }
    
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
    
    function getPlatformStats() external view returns (uint256, uint256, uint256) {
        return (totalDeposits, totalBorrowed, totalDeposits - totalBorrowed);
    }
}
