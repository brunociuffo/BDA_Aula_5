SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
-- --------------------------------------------------------
--
-- Banco de dados: `atividadepratica`
--
-- --------------------------------------------------------
--
-- Estrutura para tabela `cardapio`
--
CREATE TABLE `cardapio` (
  `codigoProduto` int(11) NOT NULL,
  `descricaoDoProduto` varchar(150) NOT NULL,
  `informacaoDoProduto` varchar(250) NOT NULL,
  `precoDoProduto` float NOT NULL,
  `idCategoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- --------------------------------------------------------
--
-- Estrutura para tabela `categorias`
--
CREATE TABLE `categorias` (
  `idCategoria` int(11) NOT NULL,
  `nomeCategoria` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- --------------------------------------------------------
--
-- Estrutura para tabela `clientes`
--
CREATE TABLE `clientes` (
  `idCliente` int(11) NOT NULL,
  `nomeCliente` varchar(150) NOT NULL,
  `genero` char(1) NOT NULL CHECK (`genero` in ('M','F','O')),
  `dataDeNascimento` date NOT NULL,
  `cpf` bigint(20) NOT NULL,
  `email` varchar(150) NOT NULL,
  `celular` int(11) NOT NULL,
  `logradouro` varchar(250) NOT NULL,
  `cidade` varchar(150) NOT NULL,
  `uf` char(2) NOT NULL,
  `cep` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- --------------------------------------------------------
--
-- Estrutura para tabela `vendas`
--
CREATE TABLE `vendas` (
  `numeroNotaFiscal` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `dataDaVenda` date NOT NULL,
  `item` int(11) NOT NULL,
  `codigoProduto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `precoDoProduto` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
-- --------------------------------------------------------
--
-- Índices para tabelas despejadas
--
-- --------------------------------------------------------
--
-- Índices de tabela `cardapio`
--
ALTER TABLE `cardapio`
  ADD PRIMARY KEY (`codigoProduto`),
  ADD KEY `PK_codigoProduto` (`codigoProduto`),
  ADD KEY `FK_idCategoria` (`idCategoria`);
-- --------------------------------------------------------
--
-- Índices de tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`idCategoria`),
  ADD KEY `PK_idCategoria` (`idCategoria`);
-- --------------------------------------------------------
--
-- Índices de tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idCliente`),
  ADD UNIQUE KEY `cpf` (`cpf`),
  ADD KEY `PK_idCliente` (`idCliente`),
  ADD KEY `AK_cpf` (`cpf`);
-- --------------------------------------------------------
--
-- Índices de tabela `vendas`
--
ALTER TABLE `vendas`
  ADD KEY `PK_numeroNotaFiscal` (`numeroNotaFiscal`),
  ADD KEY `FK_idCliente` (`idCliente`),
  ADD KEY `FK_codigoProduto` (`codigoProduto`);
-- --------------------------------------------------------
--
-- AUTO_INCREMENT para tabelas despejadas
--
-- --------------------------------------------------------
--
-- AUTO_INCREMENT de tabela `cardapio`
--
ALTER TABLE `cardapio`
  MODIFY `codigoProduto` int(11) NOT NULL AUTO_INCREMENT;
-- --------------------------------------------------------
--
-- AUTO_INCREMENT de tabela `categorias`
--
ALTER TABLE `categorias`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT;
-- --------------------------------------------------------
--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT;
-- --------------------------------------------------------
--
-- AUTO_INCREMENT de tabela `vendas`
--
ALTER TABLE `vendas`
  MODIFY `numeroNotaFiscal` int(11) NOT NULL AUTO_INCREMENT;
-- --------------------------------------------------------
--
-- Restrições para tabelas despejadas
--
-- --------------------------------------------------------
--
-- Restrições para tabelas `cardapio`
--
ALTER TABLE `cardapio`
  ADD CONSTRAINT `FK_idCategoria` FOREIGN KEY (`idCategoria`) REFERENCES `categorias` (`idCategoria`);
-- --------------------------------------------------------
--
-- Restrições para tabelas `vendas`
--
ALTER TABLE `vendas`
  ADD CONSTRAINT `FK_codigoProduto` FOREIGN KEY (`codigoProduto`) REFERENCES `cardapio` (`codigoProduto`),
  ADD CONSTRAINT `FK_idCliente` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;