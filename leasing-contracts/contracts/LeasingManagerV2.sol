// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../contracts/LeasingRigth.sol";

contract FinancialLeasing {
    struct Lease {
        address lessor;
        address lessee;
        uint256 monthlyPayment;
        uint256 totalCost;
        uint256 paymentsMade;
        bool isActive;
        string name;
        string symbol;
        string tokenUri;
        address leasingRigthAddress;
    }

    Lease[] public leases;
    mapping(address => uint256[]) public lessorToLeases;
    mapping(address => uint256[]) public lesseeToLeases;

    event NewLease(address indexed lessor, address indexed lessee, uint256 leaseIndex);
    event PaymentMade(address indexed lessee, uint256 leaseIndex, uint256 amount);
    event LeaseEnded(address indexed lessee, uint256 leaseIndex);

    function createLease(
        address _lessee,
        uint256 _monthlyPayment,
        uint256 _totalCost,
        string memory _name,
        string memory _symbol,
        string memory _tokenUri
    ) public returns (uint256) {
        require(_lessee != address(0), "Invalid lessee address");
        require(_monthlyPayment > 0, "Monthly payment must be greater than 0");
        require(_totalCost > 0, "Total cost must be greater than 0");
        require(_totalCost % _monthlyPayment == 0, "Total cost must be a multiple of monthly payment");

        uint256 leaseIndex = leases.length;
        leases.push(
            Lease(
                msg.sender,
                _lessee,
                _monthlyPayment,
                _totalCost,
                0,
                true,
                _name,
                _symbol,
                _tokenUri,
                address(new LeasingRigth(_name, _symbol))
            )
        );
        lessorToLeases[msg.sender].push(leaseIndex);
        lesseeToLeases[_lessee].push(leaseIndex);

        emit NewLease(msg.sender, _lessee, leaseIndex);

        return leaseIndex;
    }

    function makePayment(uint256 _leaseIndex) public payable {
        Lease storage lease = leases[_leaseIndex];

        require(lease.isActive, "Lease is not active");
        require(msg.sender == lease.lessee, "Only lessee can make payments");
        require(msg.value == lease.monthlyPayment, "Payment amount must be equal to monthly payment");

        lease.paymentsMade++;

        if (lease.paymentsMade == lease.totalCost / lease.monthlyPayment) {
            lease.isActive = false;
            LeasingRigth(lease.leasingRigthAddress).safeMint(lease.lessee, 1, lease.tokenUri);
            emit LeaseEnded(lease.lessee, _leaseIndex);
        }

        emit PaymentMade(lease.lessee, _leaseIndex, msg.value);
    }

    function getLeasesByLessor(address _lessor) public view returns (uint256[] memory) {
        return lessorToLeases[_lessor];
    }

    function getLeasesByLessee(address _lessee) public view returns (uint256[] memory) {
        return lesseeToLeases[_lessee];
    }

    function getLeaseDetails(uint256 _leaseIndex)
        public
        view
        returns (
            address,
            address,
            uint256,
            uint256,
            uint256,
            bool,
            string memory,
            string memory,
            string memory,
            address
        )
    {
        Lease storage lease = leases[_leaseIndex];
        return (
            lease.lessor,
            lease.lessee,
            lease.monthlyPayment,
            lease.totalCost,
            lease.paymentsMade,
            lease.isActive,
            lease.name,
            lease.symbol,
            lease.tokenUri,
            lease.leasingRigthAddress
        );
    }
}
