pragma solidity ^0.4.19;
import "browser/manufacturer.sol";

contract Commissioner{

    pharmaDetails p1 = pharmaDetails([address]);
    function Commissioner() {
    }

    function checkBgc(address vaddress) constant returns (string){
        if(p1.validatePharma(vaddress)){
            return "Valid";
        }
        return "Invalid";
    }   
        
}


