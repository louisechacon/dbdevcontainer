CREATE TABLE pessoa (
    cpf CHAR(11),
    email VARCHAR(50) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    data_nasc DATE NOT NULL,
    endereco VARCHAR(300) NOT NULL,
    telefone VARCHAR(15) NULL,
    CONSTRAINT pessoa_pk PRIMARY KEY (cpf),
    CONSTRAINT pessoa_un UNIQUE (email, nome)
);

CREATE TABLE paciente (
    cpf_pessoa CHAR(11),
    senha VARCHAR(20) NOT NULL,
    plano_saude BOOLEAN NOT NULL DEFAULT (false),
    CONSTRAINT paciente_pk PRIMARY KEY (cpf_pessoa),
    CONSTRAINT paciente_fk FOREIGN KEY (cpf_pessoa) REFERENCES pessoa (cpf)
);

CREATE TABLE medico (
    cpf_pessoa CHAR(11),
    crm VARCHAR(10) UNIQUE NOT NULL,
    CONSTRAINT medico_pk PRIMARY KEY (cpf_pessoa),
    CONSTRAINT medico_fk FOREIGN KEY (cpf_pessoa) REFERENCES pessoa (cpf)
);

CREATE TABLE agendamento (
    cpf_paciente CHAR(11),
    cpf_medico CHAR(11),
    dh_consulta TIMESTAMP,
    dh_agendamento TIMESTAMP NOT NULL DEFAULT (current_timestamp),
    valor_consulta FLOAT NOT NULL DEFAULT (0.0),
    CONSTRAINT agendamento_pk PRIMARY KEY (cpf_paciente, cpf_medico, dh_consulta),
    CONSTRAINT agendamento_paciente_fk FOREIGN KEY (cpf_paciente) REFERENCES paciente (cpf_pessoa),
    CONSTRAINT agendamento_medico_fk FOREIGN KEY (cpf_medico) REFERENCES medico (cpf_pessoa)
);

CREATE TABLE especialidade (
    id INT GENERATED ALWAYS AS IDENTITY,
    descricao VARCHAR(300) NOT NULL,
    CONSTRAINT especialidade_pk PRIMARY KEY (id)
);

CREATE TABLE medico_especialidade (
    cpf_medico CHAR(11),
    id_especialidade INT,
    CONSTRAINT medico_especialidade_pk PRIMARY KEY (cpf_medico, id_especialidade),
    CONSTRAINT medico_fk FOREIGN KEY (cpf_medico) REFERENCES medico (cpf_pessoa),
    CONSTRAINT especialidade_fk FOREIGN KEY (id_especialidade) REFERENCES especialidade (id)
);