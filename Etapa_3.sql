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
-- Etapa 3
-- View com uma subquery como filtro de uma consulta 
-- Estrutura stand-in para view `produtosqueforamvendidos`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `produtosqueforamvendidos` (
`produto` varchar(150)
);
-- --------------------------------------------------------
-- Etapa 3
-- View com uma subquery como uma nova coluna de consulta
-- Estrutura stand-in para view `produtosvendidoscomtotal`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `produtosvendidoscomtotal` (
`numeroNotaFiscal` int(11)
,`idCliente` int(11)
,`dataDaVenda` date
,`item` int(11)
,`codigoProduto` int(11)
,`quantidade` int(11)
,`precoDoProduto` float
,`descricaoDoProduto` varchar(150)
,`qtdeVendasProduto` bigint(21)
);
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
-- Estrutura para view `produtosqueforamvendidos`
--
DROP TABLE IF EXISTS `produtosqueforamvendidos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `produtosqueforamvendidos`  AS SELECT `cardapio`.`descricaoDoProduto` AS `produto` FROM `cardapio` WHERE `cardapio`.`codigoProduto` in (select `vendas`.`codigoProduto` from `vendas` where `vendas`.`quantidade` > 0) ;
-- --------------------------------------------------------
--
-- Estrutura para view `produtosvendidoscomtotal`
--
DROP TABLE IF EXISTS `produtosvendidoscomtotal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `produtosvendidoscomtotal`  AS SELECT `vendas`.`numeroNotaFiscal` AS `numeroNotaFiscal`, `vendas`.`idCliente` AS `idCliente`, `vendas`.`dataDaVenda` AS `dataDaVenda`, `vendas`.`item` AS `item`, `vendas`.`codigoProduto` AS `codigoProduto`, `vendas`.`quantidade` AS `quantidade`, `vendas`.`precoDoProduto` AS `precoDoProduto`, `cardapio`.`descricaoDoProduto` AS `descricaoDoProduto`, (select count(0) from `vendas` where `vendas`.`codigoProduto` = `vendas`.`codigoProduto`) AS `qtdeVendasProduto` FROM (`vendas` join `cardapio` on(`vendas`.`codigoProduto` = `cardapio`.`codigoProduto`)) ;
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