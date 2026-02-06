// SPDX-License-Identifier: BSL-1.1
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Patocoin ($PATO) - Sistema Financiero Mundial
 * @dev Gestionado por DALabs & Fundación Harmony
 */
contract Patocoin is ERC20, ERC20Burnable, Ownable {
    
    uint256 public constant MAX_GLOBAL_SUPPLY = 222_000_000 * 10**18;
    address public crossChainGateway;

    constructor() ERC20("Patocoin", "PATO") Ownable(msg.sender) {
        // Emisión inicial de 100M para el lanzamiento
        _mint(msg.sender, 100_000_000 * 10**18);
    }

    /**
     * @notice Emisión controlada para interoperabilidad (Worldcoin, ETH, Solana)
     * @dev Respeta la Regla de Oro de los 222M
     */
    function mintSovereign(address to, uint256 amount) external {
        require(msg.sender == crossChainGateway || msg.sender == owner(), "No autorizado");
        require(totalSupply() + amount <= MAX_GLOBAL_SUPPLY, "Excede el suministro maestro de 222M");
        _mint(to, amount);
    }

    function setGateway(address _gateway) external onlyOwner {
        crossChainGateway = _gateway;
    }

    // Sección para conectar con DEXs (Selector de ruta barata)
    function getBestRoute(uint256 amount, address targetToken) external pure returns (string memory) {
        // Esta lógica se consume vía Oracle para rapidez y bajo costo de gas
        return "Routing via DALabs Optimized Path (DEX Aggregator)";
    }
}