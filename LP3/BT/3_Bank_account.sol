// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

// Smart contract for a basic bank account with deposit, withdraw, and balance features.
contract Bank {
    // Mapping to store the balance of each user
    mapping(address => uint) private user_account;
    // Mapping to check if a user has created an account
    mapping(address => bool) private user_exist;

    // Function to create a new account with an initial deposit.
    function create_account() public payable returns(string memory) {
        // Check if the account already exists
        require(user_exist[msg.sender] == false, "Account already created!");
        // Ensure the initial deposit is greater than 0
        require(msg.value > 0, "Initial deposit must be greater than 0.");
        
        // Initialize the user’s account with the deposited value
        user_account[msg.sender] = msg.value;
        // Mark the user as having an account
        user_exist[msg.sender] = true;
        
        return "Account created";
    }

    // Function to deposit money into the user's account.
    function deposit() public payable returns(string memory) {
        // Check if the user has created an account
        require(user_exist[msg.sender] == true, "Account not created!");
        // Ensure the deposit amount is greater than 0
        require(msg.value > 0, "Deposit amount must be greater than 0.");
        
        // Add the deposited amount to the user's balance
        user_account[msg.sender] += msg.value;
        
        return "Amount deposited successfully";
    }

   // Function to withdraw money from the user's account in Ether.
    function withdraw(uint amountInEther) public returns(string memory) {
        // Check if the user has created an account
        require(user_exist[msg.sender] == true, "Account not created!");
        // Ensure the withdrawal amount is greater than 0
        require(amountInEther > 0, "Withdraw amount must be greater than 0.");
        
        // Convert the input amount from Ether to Wei
        uint amountInWei = amountInEther * 1 ether;
        
        // Ensure the user has enough balance to withdraw in Wei
        require(user_account[msg.sender] >= amountInWei, "Insufficient balance.");
        
        // Deduct the withdrawal amount from the user's balance
        user_account[msg.sender] -= amountInWei;
        // Transfer the specified amount in Wei to the user
        payable(msg.sender).transfer(amountInWei);
        
        return "Amount withdrawn successfully";    
    }

    // Function to check the balance of the user's account.
    function account_balance() public view returns(uint) {
        // Ensure the user has created an account
        require(user_exist[msg.sender] == true, "Account not created!");
        
        return user_account[msg.sender];
    }

    // Function to check if the user's account exists.
    function account_exists() public view returns(bool) {
        return user_exist[msg.sender];
    }
}
