pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract SawmillFactory is CastleFactory {
    
    using SafeMath for uint;
    
    mapping (address => uint) public ownerWoodProduceTime;
    uint produceWoodAbility = 1;

    function _createSawmill(uint _x, uint _y) internal {
        createBuilding("Sawmill", _x, _y);
        _updateProduceWood(msg.sender);
    }


    function _updateProduceWood(address _owner) internal {
        uint[] memory sawmills = getSpecificBuildingByOwner(_owner, "Sawmill");
        if (sawmills.length > 0){
            while (now > ownerWoodProduceTime[_owner].add(10 seconds)) {
                for (uint i = 0; i < sawmills.length; i++) {
                    woodOwnerCount[_owner] = woodOwnerCount[_owner].add(buildings[sawmills[i]].level * produceWoodAbility );
                }
                ownerWoodProduceTime[_owner] = ownerWoodProduceTime[_owner].add(10 seconds);
            }
        }
        else {
            ownerWoodProduceTime[_owner] = now;
        }
    }
}