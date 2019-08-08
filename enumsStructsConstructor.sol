pragma solidity 0.5.1;

contract structsEnumsAndMappings {
    mapping(address => uint) bids;
    
    struct Car{
        string model;
        uint value;
        uint built_year;
    }
    
    Car public private_car;
    mapping (address => Car) public cars;
     /* We can only have one constructor, it's used to initialize state variables
     and other variables, structurs you want to 
     */
     
    constructor(string memory _model, uint _value, uint _built_year) public{
        private_car.model = _model;
        private_car.value = _value;
        private_car.built_year = _built_year;
        cars[msg.sender] = private_car;
    }
    /*Enums work very similar to other languages, you define a type 
        and name it however you want to do it */
    
    enum AuctionState {Running, Stopped, Inactive}
    
    AuctionState public status = AuctionState.Running; 
    
    /* If you want to modify the car that you created
        we can create a modifier function that uses private 
        classes like in Java 
    */
    
    function modify_car(string memory _model, uint _value, uint _built_year) public returns (bool){
        /* IMPORTANT that we specify "memory" otherwise the car will
            be saved in storage which can cause problems, and on top of
            that we will have to pay gas for it 
        */
        /* Only if the auction is running we will execute this code, this mechanism will 
            later be used in more complex smart contract development
        */
        if(status == AuctionState.Running){
            Car memory newCar = Car({
                model: _model,
                value: _value,
                built_year: _built_year
            });
            private_car = newCar;
            return true;
        }
        
        else{
            return false;
        }
        
    }
}