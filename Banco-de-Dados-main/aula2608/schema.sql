-- Ativa foregin keys no inicio do Script
PRAGMA foreign_keys = NO;

-- Tabela Usuário
CREATE TABLE usuario(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    emiail TEXT NOT NULL UNIQUE,
    senha TEXT NOT NULL
);

-- Tabela Cliente
CREATE TABLE cliente(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    telefone TEXT,
    usuario_id INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
);


-- Tabela Produto
CREATE TABLE produto(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    descricao TEXT,
    preco REAL NOT NULL CHECK (preco >= 0)
);

-- Tabela Venda
CREATE TABLE venda(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data TEXT NOT NULL,
    usuario_id INTEGER,
    cliente_id INTEGER,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE SET NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE SET NULL
);

-- tABELA Venda_produto tabela associativa para N:M produto <-> venda
CREATE TABLE venda_produto(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    venda_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unitario REAL NOT NULL CHECK (preco_unitario >= 0),
   -- PRIMARY KEY (venda_id, produto_id), -- CHAVE COMPOSTA
    FOREIGN KEY (venda_id) REFERENCES venda(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produto(id) ON DELETE CASCADE
);
    
    -- Inserir usuario
    INSERT INTO usuario (nome, emiail, senha) VALUES ('Rafael', 'rafael@email', 'leafar');
    INSERT INTO usuario (nome, emiail, senha) VALUES ('Jose', 'jose@email', 'jose123');
    INSERT INTO usuario (nome, emiail, senha) VALUES ('João', 'joao@email', 'joao123');
    INSERT INTO usuario (nome, emiail, senha) VALUES ('Maria', 'maria@email', 'maria123');

    -- Inserir cliente
    INSERT INTO cliente (nome, telefone, usuario_id) VALUES ('Rafael Marinho', '99999-9999', 1);
    INSERT INTO cliente (nome, telefone, usuario_id) VALUES ('Jose Silva', '88888-8888', 2);
    INSERT INTO cliente (nome, telefone, usuario_id) VALUES ('João Souza', '77777-7777', 3);
    INSERT INTO cliente (nome, telefone, usuario_id) VALUES ('Maria Oliveira', '66666-6666',4);

    -- Inserir produto
    INSERT INTO produto (nome, descricao, preco) VALUES ('Arroz 5Kg', 'Arroz Tipo 1', '10.20');
    INSERT INTO produto (nome, descricao, preco) VALUES ('Feijao 1Kg', 'Feijao Carioca', '7.25');
    INSERT INTO produto (nome, descricao, preco) VALUES ('Acucar 2Kg', 'Açucar Refinado', '5.35');

    -- Inserir venda
    INSERT INTO venda (data, usuario_id, cliente_id) VALUES ('2025-08-27', '1', '1');
    INSERT INTO venda (data, usuario_id, cliente_id) VALUES ('2025-08-27', '2', '2');
    INSERT INTO venda (data, usuario_id, cliente_id) VALUES ('2025-08-27', '3', '3');

    --Inserir dados na tabela  de associação de venda_produto
    INSERT INTO venda_produto (venda_id, produto_id, quantidade, preco_unitario) VALUES ('1', '1', '3', '10.20');
    INSERT INTO venda