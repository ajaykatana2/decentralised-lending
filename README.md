# Decentralised Lending

## Project Description

Decentralised Lending is a peer-to-peer lending platform built on blockchain technology that enables users to lend and borrow cryptocurrency without traditional intermediaries. The platform operates through smart contracts, ensuring transparency, security, and automated execution of lending agreements.

Users can deposit ETH as collateral and borrow funds against their deposits, with all transactions managed autonomously by the smart contract. The platform implements a collateralized lending model where borrowers must maintain a 150% collateralization ratio to ensure loan security.

## Project Vision

Our vision is to democratize access to financial services by creating a decentralized lending ecosystem that:

- **Eliminates Traditional Barriers**: Removes the need for credit checks, lengthy approval processes, and geographical restrictions
- **Ensures Financial Inclusion**: Provides lending services to anyone with cryptocurrency, regardless of their traditional banking status  
- **Promotes Transparency**: All transactions and terms are visible on the blockchain, ensuring complete transparency
- **Reduces Costs**: Eliminates intermediary fees and reduces overall borrowing costs through automation
- **Enhances Security**: Utilizes blockchain technology and smart contracts to secure funds and automate loan management

## Key Features

### Core Lending Functions
- **Collateral Deposits**: Users can deposit ETH as collateral to secure their borrowing capacity
- **Secured Borrowing**: Borrow up to 66.67% of deposited collateral value with 150% collateralization requirement
- **Automated Repayment**: Repay loans with automatically calculated interest based on time elapsed

### Advanced Features
- **Dynamic Interest Calculation**: 5% annual interest rate calculated in real-time based on loan duration
- **Liquidity Management**: Ensures sufficient platform liquidity before allowing new loans
- **Collateral Protection**: Prevents withdrawal of collateral while active loans exist
- **Real-time Monitoring**: Track deposit balances, borrowed amounts, and accrued interest

### Security & Transparency
- **Smart Contract Automation**: All operations handled automatically without human intervention
- **Event Logging**: Complete transaction history recorded on blockchain
- **Overflow Protection**: Built-in safeguards against arithmetic errors and edge cases
- **Access Control**: User-specific restrictions ensure only authorized operations

### Platform Analytics
- **Individual User Stats**: View personal deposit balances, loan amounts, and interest calculations
- **Platform Metrics**: Monitor total deposits, total borrowed funds, and available liquidity
- **Interest Tracking**: Real-time calculation of accumulated interest on active loans

## Future Scope

### Short-term Enhancements (3-6 months)
- **Multi-Token Support**: Expand beyond ETH to support various ERC-20 tokens as collateral and borrowing options
- **Variable Interest Rates**: Implement dynamic interest rates based on supply and demand
- **Liquidation Mechanism**: Add automated liquidation for under-collateralized positions
- **Governance Token**: Introduce platform governance tokens for community-driven decision making

### Medium-term Development (6-12 months)
- **Cross-Chain Integration**: Enable lending across multiple blockchain networks
- **Advanced Risk Management**: Implement sophisticated risk assessment algorithms
- **Insurance Integration**: Partner with DeFi insurance protocols to protect user funds
- **Mobile Application**: Develop user-friendly mobile interfaces for easier access

### Long-term Vision (1-2 years)
- **AI-Powered Credit Scoring**: Develop on-chain credit scoring based on DeFi transaction history
- **Institutional Features**: Add features for institutional lending and borrowing
- **Regulatory Compliance**: Implement features for regulatory compliance across different jurisdictions
- **Layer 2 Integration**: Deploy on Layer 2 solutions for reduced gas fees and faster transactions

### Innovation Pipeline
- **Flash Loan Integration**: Enable flash loans for advanced DeFi strategies
- **Yield Farming**: Allow depositors to earn additional yields through farming opportunities
- **NFT Collateral**: Accept NFTs as collateral for loans
- **Algorithmic Stable Coins**: Integration with algorithmic stable coin protocols for stable borrowing options

## Getting Started

### Prerequisites
- Solidity ^0.8.19
- Ethereum development environment (Hardhat/Truffle)
- MetaMask or compatible Web3 wallet

### Deployment
1. Clone the repository
2. Install dependencies
3. Compile the smart contract
4. Deploy to your preferred Ethereum network
5. Verify contract on block explorer

### Usage
1. **Deposit**: Call `depositCollateral()` with ETH to establish collateral
2. **Borrow**: Use `borrowFunds(amount)` to borrow against your collateral
3. **Repay**: Call `repayLoan()` with principal + interest to close your loan
4. **Withdraw**: Use `withdrawCollateral(amount)` to retrieve your collateral

Contract Address: 0xc49303a58206B94F759CD0FC44100F5426bB1fCA

<img width="1097" alt="image" src="https://github.com/user-attachments/assets/c80b3dc8-a244-41e9-a165-52573762084d" />
