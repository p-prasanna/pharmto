pragma solidity ^0.4.19;
pragma experimental ABIEncoderV2;
import "browser/stringUtils.sol";
    

contract pharmaDetails{
//Struct is the composite datatype which can store collectively various data types
    struct pharma {
        address paddress;
        string pname;
        string drug;
        string purpose;
        string exp;
    }
    
    struct user {
        address uaddress;
        string uname;
        string ugid;
        string mail;
        string haddress;
    }

    address owner;
    mapping (address => pharma) public pharmas ; //mapping is datatype which has key and value , here key is address and value is struct datatype ,students is variable
    address[] public pharmaAccts;
    string[] public cart;
    mapping (address => user) public users ; //mapping is datatype which has key and value , here key is address and value is struct datatype ,students is variable
    address[] public userAccts;
    
	//defining the constuctor for the contract
    function pharmaDetails() public {
        owner = msg.sender;
    }
    
    //modifier to check owner or not , it provides reusability to use the same modifier at multi functions in the same contract 
    modifier ifOwner() {
        require(msg.sender == owner);
        _;
    }
    
    event pharmaInfo(
        address paddress,
        string pname,
        string drug,
        string purpose,
        string exp
    );
    
    event userInfo(
        address uaddress,
        string uname,
        string ugid,
        string mail,
        string haddress
    );
 
    function insertDetails(string _pname,string _drug,string _purpose,string _exp) ifOwner public {
        pharmas[msg.sender].paddress = msg.sender;
        var pharma = pharmas[msg.sender];
        pharma.pname = _pname;
        pharma.purpose = _purpose;
        pharma.drug = _drug;
        pharma.exp = _exp;
        pharmaAccts.push(msg.sender) -1;
        pharmaInfo(msg.sender, _pname, _drug, _purpose, _exp);
    }
    
    
    function registerUser(string _uname,string _ugid,string _email,string _haddress) ifOwner public {
        users[msg.sender].uaddress = msg.sender;
        var user = users[msg.sender];
        user.uname = _uname;
        user.ugid=_ugid;
        user.mail=_email;
        user.haddress=_haddress;
        userAccts.push(msg.sender) -1;
        userInfo(msg.sender, _uname, _ugid, _email, _haddress);
    }


   
	//function to update details , here we can notice we added modifer so that only owner can update the details
    function updateDetails(string _exp) ifOwner public {
        pharmas[msg.sender].exp = _exp;
    }
    
    function getPharmas() view public returns(address[]) {
        return pharmaAccts;
    }
   
	//function to fetch the details of student which are in the blockchain, here also we use the mapping to retrieve the details
    function getpharmaDetails(address paddress) constant public returns(string,string,string,string){
        return (pharmas[paddress].pname, pharmas[paddress].drug, 
        pharmas[paddress].purpose,pharmas[paddress].exp);
    }
	//function to validate the entered details are correct or not 
    function validatePharma(address valAddress) constant public returns(bool){
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
    
    function getByName(string _mname) view returns(string,string,string,string) {
         
        uint count=pharmaAccts.length;
        address maddress;
        string mdrug;
        string memory medicine;
        medicine=_mname;
        for(uint i=0; i<count; i++) {
            
            maddress=pharmaAccts[i];    
            mdrug=pharmas[maddress].drug;
            if(compareStrings(_mname,mdrug)) 
            {
                
                return (pharmas[maddress].pname, pharmas[maddress].drug, 
                pharmas[maddress].purpose,pharmas[maddress].exp);     
            }
        }
        return ("NULL","NULL","NULL","NULL");
    }
    
    function compareStrings (string a, string b) view returns (bool success){
        return keccak256(a) == keccak256(b);
    }
    
    function addCart(string _mname){
        cart.push(_mname);
    }
    
    function viewCart() view returns(string[]){
        return cart;
    }
   
}


