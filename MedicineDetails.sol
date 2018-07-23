pragma solidity ^0.4.19;

contract pharmaDetails{
    //Struct is the composite datatype which can store collectively various data types
    struct pharma {
        string pname;
        string drug;
        string purpose;
        address paddress;
        string exp;
    }

    address owner;
    mapping (address => pharma) pharmas ; //mapping is datatype which has key and value , here key is address and value is struct datatype ,students is variable
    address[] public pharmaAccts;
    
	  //defining the constuctor for the contract
    function pharmaDetails(){
        owner = msg.sender;
    }
    
    //modifier to check owner or not , it provides reusability to use the same modifier at multi functions in the same contract 
    modifier ifOwner() {
        if (owner!=msg.sender){
            throw;
        }
        _;
    }
 
    function insertDetails(string _pname,string _purpose,string _drug,string _exp) ifOwner {
        pharmas[msg.sender].paddress = msg.sender;
        pharmas[msg.sender].pname = _pname;
        pharmas[msg.sender].purpose = _purpose;
        pharmas[msg.sender].drug = _drug;
        pharmas[msg.sender].exp = _exp;
        pharmaAccts.push(msg.sender) -1;

    }

   
	  //function to update details , here we can notice we added modifer so that only owner can update the details
    function updateDetails(string _exp) ifOwner {

        pharmas[msg.sender].exp = _exp;

    }
    
    function getPharmas() view public returns(address[]) {
        
        return pharmaAccts;
        
    }
   
	  //function to fetch the details of student which are in the blockchain, here also we use the mapping to retrieve the details
    function getpharmaDetails(address paddress) constant returns(string,string,string,string){

        return (pharmas[paddress].pname, pharmas[paddress].drug,
        pharmas[paddress].purpose,pharmas[paddress].exp);

    }
	  //function to validate the entered details are correct or not 
    function validatePharma(address valAddress) constant returns(bool){
        
        if ((pharmas[valAddress].paddress==valAddress)){
            return true;
        }
        else {
            return false;
        }
        
    }
    
    function countPharmas() view public returns (uint) {
        
        return pharmaAccts.length;
        
    }
   
}
