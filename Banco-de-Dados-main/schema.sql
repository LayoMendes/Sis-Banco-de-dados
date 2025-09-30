-- Ativa a verificação de chaves estrangeiras, conforme solicitado no enunciado.
PRAGMA foreign_keys = ON;

-- Tabela Participante
CREATE TABLE Participante (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    telefone TEXT
);

-- Tabela Evento
CREATE TABLE Evento (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    descricao TEXT,
    local TEXT NOT NULL,
    data TEXT NOT NULL
);

-- Tabela Inscricao (tabela associativa para resolver o relacionamento N:M)
CREATE TABLE Inscricao (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_evento INTEGER NOT NULL,
    id_participante INTEGER NOT NULL,
    data_inscricao TEXT,
    status TEXT,
    FOREIGN KEY (id_evento) REFERENCES Evento(id) ON DELETE CASCADE,
    FOREIGN KEY (id_participante) REFERENCES Participante(id) ON DELETE CASCADE
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_inscricao INTEGER UNIQUE, -- UNIQUE para garantir o relacionamento 1:1
    valor REAL,
    data_pagamento TEXT,
    status TEXT,
    FOREIGN KEY (id_inscricao) REFERENCES Inscricao(id) ON DELETE CASCADE
);

-- Inserção de dados
-- Participante: 3 registros
INSERT INTO Participante (nome, email, telefone) VALUES
    ('Ana Silva', 'ana.silva@email.com', '99999-1111'),
    ('Bruno Costa', 'bruno.costa@email.com', '99999-2222'),
    ('Carla Dias', 'carla.dias@email.com', '99999-3333');

-- Evento: 2 registros
INSERT INTO Evento (nome, descricao, local, data) VALUES
    ('Seminário de TI', 'Seminário sobre tendências em tecnologia', 'Auditório Principal', '2025-09-15'),
    ('Workshop de IA', 'Workshop prático sobre inteligência artificial', 'Sala de Treinamento', '2025-09-20');

-- Inscricao: 4 registros
INSERT INTO Inscricao (id_evento, id_participante, data_inscricao, status) VALUES
    (1, 1, '2025-08-27', 'confirmada'), -- Ana se inscreve no Seminário de TI
    (1, 2, '2025-08-27', 'confirmada'), -- Bruno se inscreve no Seminário de TI
    (2, 3, '2025-08-28', 'confirmada'), -- Carla se inscreve no Workshop de IA
    (2, 1, '2025-08-28', 'confirmada'); -- Ana também se inscreve no Workshop de IA

-- Pagamento: 4 registros
INSERT INTO Pagamento (id_inscricao, valor, data_pagamento, status) VALUES
    (1, 50.00, '2025-08-28', 'pago'),
    (2, 50.00, '2025-08-28', 'pago'),
    (3, 75.00, '2025-08-29', 'pendente'),
    (4, 75.00, '2025-08-29', 'pago');