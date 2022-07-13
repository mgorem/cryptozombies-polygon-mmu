pragma solidity >=0.5.0 <0.6.0;

// Create Contract named ZombieFactory
contract ZombieFactory {
    // Declare an event that passes the following arguments
    event NewZombie(uint zombieId, string name, uint dna);

    // declare some data types, name them and initialize them
    uint dnaDigits = 16;
    uint dnaModulus = 10**dnaDigits;

    // Create your data structure
    struct Zombie {
        string name;
        uint dna;
    }

    // Use the data structure to create an array of zombies with a name and dna
    Zombie[] public zombies;

    // function to create a ne zombie, push it into zombies array and store the id in a uint named id
    // it's a private function i.e it can only be accessed by the functions in this contract
    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    }

    // function to generate random dna and convert it into a hash, typecast it into a uint and store it in a rand variable
    // It returns a uint
    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint)
    {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    // function to create random zombie using the function generateRandomDna function
    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

    // Listen for the event in the js file and log it:
    // ZombieFactory.NewZombie(function(error, result) {
    //   console.log(result);
    // })
}
