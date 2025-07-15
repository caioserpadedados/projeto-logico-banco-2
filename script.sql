-- Criação das tabelas
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE Veiculo (
    id_veiculo INT PRIMARY KEY,
    id_cliente INT,
    modelo VARCHAR(100),
    placa VARCHAR(10),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Servico (
    id_servico INT PRIMARY KEY,
    descricao VARCHAR(100),
    preco DECIMAL(10, 2)
);

CREATE TABLE OrdemServico (
    id_ordem INT PRIMARY KEY,
    id_veiculo INT,
    data_abertura DATE,
    status VARCHAR(20),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);

CREATE TABLE OrdemServico_Servico (
    id_ordem INT,
    id_servico INT,
    quantidade INT,
    PRIMARY KEY (id_ordem, id_servico),
    FOREIGN KEY (id_ordem) REFERENCES OrdemServico(id_ordem),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);

-- Inserção de dados
INSERT INTO Cliente VALUES (1, 'João Mecânico', '99999-1111');
INSERT INTO Cliente VALUES (2, 'Maria Andrade', '88888-2222');

INSERT INTO Veiculo VALUES (1, 1, 'Civic', 'ABC-1234');
INSERT INTO Veiculo VALUES (2, 2, 'Onix', 'XYZ-5678');

INSERT INTO Servico VALUES (1, 'Troca de óleo', 100.00);
INSERT INTO Servico VALUES (2, 'Alinhamento', 80.00);

INSERT INTO OrdemServico VALUES (1, 1, '2025-07-15', 'Em andamento');
INSERT INTO OrdemServico VALUES (2, 2, '2025-07-14', 'Concluída');

INSERT INTO OrdemServico_Servico VALUES (1, 1, 1);
INSERT INTO OrdemServico_Servico VALUES (2, 1, 1);
INSERT INTO OrdemServico_Servico VALUES (2, 2, 1); 

-- SELECT simples
SELECT * FROM Cliente;

-- WHERE com filtro
SELECT * FROM Veiculo WHERE modelo LIKE 'C%';

-- Expressão derivada (ex: preco * quantidade)
SELECT oss.id_ordem, s.descricao, s.preco, oss.quantidade, (s.preco * oss.quantidade) AS total
FROM OrdemServico_Servico oss
JOIN Servico s ON s.id_servico = oss.id_servico;

-- ORDER BY
SELECT * FROM OrdemServico ORDER BY data_abertura DESC;

-- GROUP BY + HAVING
SELECT os.id_veiculo, COUNT(*) AS total_servicos
FROM OrdemServico_Servico oss
JOIN OrdemServico os ON os.id_ordem = oss.id_ordem
GROUP BY os.id_veiculo
HAVING COUNT(*) > 1;

-- JOIN completo
SELECT os.id_ordem, c.nome, v.modelo, s.descricao
FROM OrdemServico os
JOIN Veiculo v ON v.id_veiculo = os.id_veiculo
JOIN Cliente c ON c.id_cliente = v.id_cliente
JOIN OrdemServico_Servico oss ON oss.id_ordem = os.id_ordem
JOIN Servico s ON s.id_servico = oss.id_servico;

