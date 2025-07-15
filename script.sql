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
