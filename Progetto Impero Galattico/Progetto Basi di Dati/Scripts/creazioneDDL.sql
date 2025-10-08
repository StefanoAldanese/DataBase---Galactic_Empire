--%%%%%%%%      CREA LE TABELLE IN ORDINE DI DIPENDENZE

-- Tabella radice: Sistema_Planetario
CREATE TABLE Sistema_Planetario (
    nome_stella_principale    VARCHAR2(50)    PRIMARY KEY,
    tipo_stella               VARCHAR2(20)    NOT NULL,
    coordinate_stellari_x     NUMBER,
    coordinate_stellari_y     NUMBER,
    coordinate_stellari_z     NUMBER
);

-- Tabella Pianeta: dipende da Sistema_Planetario tramite chiave esterna
CREATE TABLE Pianeta (
    nome_pianeta           VARCHAR2(50)    NOT NULL,
    nome_stella_principale VARCHAR2(50)    NOT NULL,
    classe                 VARCHAR2(20),
    abitabilita            NUMBER(1)       CHECK (abitabilita IN (0,1)),
    CONSTRAINT pk_pianeta PRIMARY KEY (nome_pianeta, nome_stella_principale),
    -- Vincolo di chiave esterna verso Sistema_Planetario
    CONSTRAINT fk_pianeta_sistema FOREIGN KEY (nome_stella_principale) 
        REFERENCES Sistema_Planetario(nome_stella_principale) ON DELETE CASCADE
);

-- Tabella Guerra_Conquista: dipende da Pianeta tramite chiave esterna
CREATE TABLE Guerra_Conquista (
    data_inizio           DATE           NOT NULL,
    nome_stella_principale VARCHAR2(50)  NOT NULL,
    nome_pianeta          VARCHAR2(50)   NOT NULL,
    nome_operazione       VARCHAR2(50),
    CONSTRAINT pk_guerra PRIMARY KEY (data_inizio, nome_stella_principale, nome_pianeta),
    -- Vincolo di chiave esterna verso Pianeta
    CONSTRAINT fk_guerra_pianeta FOREIGN KEY (nome_pianeta, nome_stella_principale) 
        REFERENCES Pianeta(nome_pianeta, nome_stella_principale) ON DELETE CASCADE,
    -- Chiave unica necessaria per FK di combatte1/combatte2
    CONSTRAINT uq_guerra_datainizio UNIQUE (data_inizio, nome_pianeta, nome_stella_principale)
);

-- Tabella radice: Gruppo_Ribelle
CREATE TABLE Gruppo_Ribelle (
    nome_armata        VARCHAR2(50)    PRIMARY KEY,
    livello_pericolo   NUMBER(2) CHECK (livello_pericolo BETWEEN 1 AND 10),
    stato             VARCHAR2(20) DEFAULT 'Attivo' CHECK (stato IN ('Attivo', 'Distrutto'))
);


-- Tabella radice: Divisione_Imperiale
CREATE TABLE Divisione_Imperiale (
    numero_armata      VARCHAR2(20)    NOT NULL,
    nome_armata        VARCHAR2(50)    UNIQUE,
    effettivi          NUMBER,
    specializzazione   VARCHAR2(30),
    CONSTRAINT pk_divisione PRIMARY KEY (numero_armata),
    CONSTRAINT formato_numero_armata CHECK (REGEXP_LIKE(numero_armata, '^DIV\d{2}-\d{3}$')),
    CONSTRAINT specializzazione_ammessa CHECK (LOWER(specializzazione) IN ('cavalleria', 'trasporti', 'fanteria', 'artiglieria', 'fanteria pesante', 'ricognizione'))
);


-- Tabella radice: Corporation
CREATE TABLE Corporation (
    nome_corporation   VARCHAR2(50)    PRIMARY KEY,
    anno_fondazione    VARCHAR2(4)     NOT NULL,
    nome_funzionario   VARCHAR2(50)    NOT NULL,
    numero_dipendenti  NUMBER
);

-- Tabella Corporation_Bellica: dipende da Corporation tramite chiave esterna
CREATE TABLE Corporation_Bellica (
    nome_corporation               VARCHAR2(50)    PRIMARY KEY,
    numero_stabilimenti_produttivi NUMBER,
    -- Vincolo di chiave esterna verso Corporation
    CONSTRAINT fk_corpbellica_corp FOREIGN KEY (nome_corporation) 
        REFERENCES Corporation(nome_corporation) ON DELETE CASCADE
);

-- Tabella Armi: dipende da Corporation_Bellica tramite chiave esterna
CREATE TABLE Armi (
    nome_corporation   VARCHAR2(50)    NOT NULL,
    modello            VARCHAR2(50)    NOT NULL,
    tipo_arma          VARCHAR2(30)    NOT NULL,
    data_produzione    DATE,
    CONSTRAINT pk_armi PRIMARY KEY (nome_corporation, modello, tipo_arma),
    -- Vincolo di chiave esterna verso Corporation_Bellica
    CONSTRAINT fk_armi_corpbellica FOREIGN KEY (nome_corporation) 
        REFERENCES Corporation_Bellica(nome_corporation) ON DELETE CASCADE
);

-- Tabella Corporation_Trasporti: dipende da Corporation tramite chiave esterna
CREATE TABLE Corporation_Trasporti (
    nome_corporation   VARCHAR2(50)    PRIMARY KEY,
    -- Vincolo di chiave esterna verso Corporation
    CONSTRAINT fk_corptrasporti_corp FOREIGN KEY (nome_corporation) 
        REFERENCES Corporation(nome_corporation) ON DELETE CASCADE
);

-- Tabella Corporation_Mineraria: dipende da Corporation tramite chiave esterna
CREATE TABLE Corporation_Mineraria (
    nome_corporation               VARCHAR2(50)    PRIMARY KEY,
    numero_giacimenti_a_carico    NUMBER,
    -- Vincolo di chiave esterna verso Corporation
    CONSTRAINT fk_corpmineraria_corp FOREIGN KEY (nome_corporation) 
        REFERENCES Corporation(nome_corporation) ON DELETE CASCADE
);

-- Tabella Partita_di_minerali: dipende da Corporation_Mineraria tramite chiave esterna
CREATE TABLE Partita_di_minerali (
    etichetta_partita  VARCHAR2(10)          NOT NULL,
    data_estrazione    DATE            NOT NULL,
    peso_totale        NUMBER,
    nome_corporation   VARCHAR2(50)    NOT NULL,
    CONSTRAINT pk_partita PRIMARY KEY (etichetta_partita),
    -- Vincolo di chiave esterna verso Corporation_Mineraria
    CONSTRAINT fk_partita_corpmineraria FOREIGN KEY (nome_corporation) 
        REFERENCES Corporation_Mineraria(nome_corporation) ON DELETE CASCADE
);

-- Tabella Ferro_Titanico: dipende da Partita_di_minerali tramite chiave esterna
CREATE TABLE Ferro_Titanico (
    etichetta_partita  VARCHAR2(10)          PRIMARY KEY,
    conduttivita       NUMBER,
    densita            NUMBER,
    -- Vincolo di chiave esterna verso Partita_di_minerali
    CONSTRAINT fk_ferro_partita FOREIGN KEY (etichetta_partita) 
        REFERENCES Partita_di_minerali(etichetta_partita) ON DELETE CASCADE
);

-- Tabella Nanosabbia_di_dune_profonde: dipende da Partita_di_minerali tramite chiave esterna
CREATE TABLE Nanosabbia_di_dune_profonde (
    etichetta_partita  VARCHAR2(10)          PRIMARY KEY,
    stabilita_campo_inverso NUMBER,
    -- Vincolo di chiave esterna verso Partita_di_minerali
    CONSTRAINT fk_nanosabbia_partita FOREIGN KEY (etichetta_partita) 
        REFERENCES Partita_di_minerali(etichetta_partita) ON DELETE CASCADE
);

-- Tabella Cristalli_di_plutonio: dipende da Partita_di_minerali tramite chiave esterna
CREATE TABLE Cristalli_di_plutonio (
    etichetta_partita  VARCHAR2(10)          PRIMARY KEY,
    purezza            NUMBER,
    -- Vincolo di chiave esterna verso Partita_di_minerali
    CONSTRAINT fk_cristalli_partita FOREIGN KEY (etichetta_partita) 
        REFERENCES Partita_di_minerali(etichetta_partita) ON DELETE CASCADE
);

-- Tabella Navi: dipende da Corporation_Bellica tramite chiave esterna
CREATE TABLE Navi (
    nome_nave          VARCHAR2(50)    PRIMARY KEY,
    modello            VARCHAR2(50),
    velocita_max       NUMBER,
    nome_corporation   VARCHAR2(50)    NOT NULL,
    -- Vincolo di chiave esterna verso Corporation_Bellica
    CONSTRAINT fk_navi_corpbellica FOREIGN KEY (nome_corporation) 
        REFERENCES Corporation_Bellica(nome_corporation) ON DELETE CASCADE
);

-- Tabella Navi_mercantili: dipende da Navi e Corporation_Trasporti tramite chiavi esterne
CREATE TABLE Navi_mercantili (
    nome_nave          VARCHAR2(50)    PRIMARY KEY,
    nome_corporation   VARCHAR2(50)    NOT NULL,
    capacita_carico_max NUMBER,
    -- Vincolo di chiave esterna verso Navi
    CONSTRAINT fk_navimerc_navi FOREIGN KEY (nome_nave) 
        REFERENCES Navi(nome_nave) ON DELETE CASCADE,
    -- Vincolo di chiave esterna verso Corporation_Trasporti
    CONSTRAINT fk_navimerc_corptrans FOREIGN KEY (nome_corporation) 
        REFERENCES Corporation_Trasporti(nome_corporation) ON DELETE CASCADE
);

-- Tabella finanzia: dipende da Corporation e Guerra_Conquista tramite chiavi esterne
CREATE TABLE finanzia (
    nome_corporation   VARCHAR2(50)    NOT NULL,
    data_inizio        DATE            NOT NULL,
    nome_stella_principale VARCHAR2(50) NOT NULL,
    nome_pianeta       VARCHAR2(50)    NOT NULL,
    valore_contributo  NUMBER,
    CONSTRAINT pk_finanzia PRIMARY KEY (nome_corporation, data_inizio, nome_stella_principale, nome_pianeta),
    -- Vincolo di chiave esterna verso Corporation
    CONSTRAINT fk_finanzia_corp FOREIGN KEY (nome_corporation) 
        REFERENCES Corporation(nome_corporation) ON DELETE CASCADE,
    -- Vincolo di chiave esterna verso Guerra_Conquista
    CONSTRAINT fk_finanzia_guerra FOREIGN KEY (data_inizio, nome_stella_principale, nome_pianeta) 
        REFERENCES Guerra_Conquista(data_inizio, nome_stella_principale, nome_pianeta) ON DELETE CASCADE
);

-- Tabella Flotta: dipende da Divisione_Imperiale tramite chiave esterna
CREATE TABLE Flotta (
    numero_flotta      VARCHAR2(20)    PRIMARY KEY,
    nome_flotta        VARCHAR2(50)    NOT NULL,
    effettivi_flotta   NUMBER,
    numero_armata      VARCHAR2(20)    NOT NULL,
    -- Vincolo di chiave esterna verso Divisione_Imperiale
    CONSTRAINT fk_flotta_divisione FOREIGN KEY (numero_armata) 
        REFERENCES Divisione_Imperiale(numero_armata) ON DELETE CASCADE,
    -- Vincolo CHECK sul formato del numero_flotta (es. FLOT00-001)
    CONSTRAINT formato_numero_flotta CHECK (REGEXP_LIKE(numero_flotta, '^FLOT\d{2}-\d{3}$'))
);


-- Tabella Navi_da_combattimento: dipende da Navi (e Flotta, vedi dopo)
CREATE TABLE Navi_da_combattimento (
    nome_nave          VARCHAR2(50)    PRIMARY KEY,
    numero_flotta      VARCHAR2(20)    NOT NULL,
    ruolo              VARCHAR2(30),
    -- Vincolo di chiave esterna verso Navi
    CONSTRAINT fk_navicomb_navi FOREIGN KEY (nome_nave) 
        REFERENCES Navi(nome_nave) ON DELETE CASCADE,
    -- Vincolo di chiave esterna verso Flotta (solo numero_flotta)
    CONSTRAINT fk_navicomb_flotta FOREIGN KEY (numero_flotta) 
        REFERENCES Flotta(numero_flotta) ON DELETE CASCADE,
    -- Vincolo CHECK sul formato del numero_flotta (es. FLOT00-001)
    CONSTRAINT formato_numero_flotta_navi_comb CHECK (REGEXP_LIKE(numero_flotta, '^FLOT\d{2}-\d{3}$')),
    CONSTRAINT check_ruolo CHECK (LOWER(ruolo) IN ('ricognizione', 'supporto', 'assalto', 'bombardamento'))
);


-- Tabella Occupazione: dipende da Guerra_Conquista e Corporation tramite chiavi esterne
-- Per evitare update, abbiamo deciso di invertire la logica di generazione di occupazione: 
-- quando facciamo l'insert di un occupazione allora la guerra sarà già vinta, 
-- quindi anno di conquista sarà la data fine della guerra sono uguali (per evitare ridodnanza, usiamo una vista per Data_fine guerra -> c'è una vista appostia con le guerre finite)
CREATE TABLE Occupazione (
    anno_conquista       DATE            NOT NULL,
    nome_stella_principale  VARCHAR2(50)    NOT NULL,
    nome_pianeta            VARCHAR2(50)    NOT NULL,
    data_inizio             DATE            NOT NULL,
    popolazione             NUMBER,
    nome_corporation        VARCHAR2(50)    NOT NULL,
    CONSTRAINT pk_occupazione PRIMARY KEY (anno_conquista, nome_stella_principale, nome_pianeta, data_inizio),
    -- Vincolo di chiave esterna verso Guerra_Conquista
    CONSTRAINT fk_occupazione_guerra FOREIGN KEY (data_inizio, nome_stella_principale, nome_pianeta) 
        REFERENCES Guerra_Conquista(data_inizio, nome_stella_principale, nome_pianeta) ON DELETE CASCADE,
    -- Vincolo di chiave esterna verso Corporation
    CONSTRAINT fk_occupazione_corporation FOREIGN KEY (nome_corporation) 
        REFERENCES Corporation(nome_corporation) ON DELETE CASCADE
);

-- Tabella Viaggio: dipende da Navi_mercantili e Occupazione (creata dopo) 
-- E' enorme!
-- ATTENZIONE: va messo tutto attaccato se no a SQL*PLUS NON piace!
CREATE TABLE Viaggio (
    data_inizio_viaggio DATE NOT NULL,
    data_fine_viaggio DATE,
    distanza_tragitto NUMBER,
    nome_nave VARCHAR2(50) NOT NULL,
    -- Campi partenza
    anno_conquista_partenza DATE NOT NULL,
    nome_stella_principale_partenza VARCHAR2(50) NOT NULL,
    nome_pianeta_partenza VARCHAR2(50) NOT NULL,
    data_inizio_GC_partenza DATE NOT NULL,
    -- Campi destinazione
    nome_pianeta_destinazione VARCHAR2(50) NOT NULL,
    nome_stella_principale_destinazione VARCHAR2(50) NOT NULL,
    anno_conquista_destinazione DATE NOT NULL,
    data_inizio_GC_destinazione DATE NOT NULL,
    CONSTRAINT pk_viaggio PRIMARY KEY (data_inizio_viaggio, nome_nave),
    CONSTRAINT fk_viaggio_navimerc FOREIGN KEY (nome_nave) 
        REFERENCES Navi_mercantili(nome_nave) ON DELETE CASCADE,
    CONSTRAINT fk_viaggio_occupazione_partenza FOREIGN KEY (anno_conquista_partenza, nome_stella_principale_partenza, nome_pianeta_partenza, data_inizio_GC_partenza) 
        REFERENCES Occupazione(anno_conquista, nome_stella_principale, nome_pianeta, data_inizio) ON DELETE CASCADE,
    CONSTRAINT fk_viaggio_occupazione_destinazione FOREIGN KEY (anno_conquista_destinazione, nome_stella_principale_destinazione, nome_pianeta_destinazione, data_inizio_GC_destinazione) 
        REFERENCES Occupazione(anno_conquista, nome_stella_principale, nome_pianeta, data_inizio) ON DELETE CASCADE
);


-- Tabella viene_trasportato_attraverso_minerali: dipende da Partita_di_minerali e Viaggio tramite chiavi esterne
-- Se hai un carico il carico non è mai vuoto, quindi non serve un vincolo NOT NULL su quantita_cargo
CREATE TABLE viene_trasportato_attraverso_minerali (
    etichetta_partita      VARCHAR2(10)          NOT NULL,
    data_inizio_viaggio    DATE                  NOT NULL,
    nome_nave              VARCHAR2(50)          NOT NULL,
    quantita_cargo         NUMBER                NOT NULL,
    CONSTRAINT pk_trasporto PRIMARY KEY (etichetta_partita, data_inizio_viaggio, nome_nave),
    -- Vincolo di chiave esterna verso Partita_di_minerali
    CONSTRAINT fk_trasporto_partita FOREIGN KEY (etichetta_partita) 
        REFERENCES Partita_di_minerali(etichetta_partita) ON DELETE CASCADE,
    -- Vincolo di chiave esterna verso Viaggio
    CONSTRAINT fk_trasporto_viaggio FOREIGN KEY (data_inizio_viaggio, nome_nave) 
        REFERENCES Viaggio(data_inizio_viaggio, nome_nave) ON DELETE CASCADE
);

-- Tabella viene_trasportato_attraverso_armi: dipende da Partita_di_minerali e Viaggio tramite chiavi esterne
-- Se hai un carico il carico non è mai vuoto, quindi non serve un vincolo NOT NULL su quantita_cargo_armi
CREATE TABLE viene_trasportato_attraverso_armi (
    nome_corporation        VARCHAR2(50)    NOT NULL,
    modello                 VARCHAR2(50)    NOT NULL,
    tipo_arma               VARCHAR2(30)    NOT NULL,
    data_inizio_viaggio     DATE            NOT NULL,
    nome_nave               VARCHAR2(50)    NOT NULL,
    quantita_cargo_armi     NUMBER          NOT NULL,
    CONSTRAINT pk_trasporto_armi PRIMARY KEY (nome_corporation, modello, tipo_arma, data_inizio_viaggio, nome_nave),
    -- Vincolo di chiave esterna verso Armi
    CONSTRAINT fk_trasporto_armi FOREIGN KEY (nome_corporation, modello, tipo_arma) 
        REFERENCES Armi(nome_corporation, modello, tipo_arma) ON DELETE CASCADE,
    -- Vincolo di chiave esterna verso Viaggio
    CONSTRAINT fk_trasporto_armi_viaggio FOREIGN KEY (data_inizio_viaggio, nome_nave) 
        REFERENCES Viaggio(data_inizio_viaggio, nome_nave) ON DELETE CASCADE
);



-- Tabella Stazionamento: dipende da Divisione_Imperiale e Occupazione tramite chiavi esterne
CREATE TABLE Stazionamento (
    data_inizio_stazionamento DATE     NOT NULL,
    numero_armata      VARCHAR2(20)    NOT NULL,
    anno_conquista     DATE            NOT NULL,
    nome_stella_principale VARCHAR2(50) NOT NULL,
    nome_pianeta       VARCHAR2(50)    NOT NULL,
    data_inizio        DATE            NOT NULL,
    numero_occupanti   NUMBER,
    CONSTRAINT pk_stazionamento PRIMARY KEY (data_inizio_stazionamento, numero_armata, anno_conquista, nome_stella_principale, nome_pianeta, data_inizio),
    -- Vincolo di chiave esterna verso Divisione_Imperiale
    CONSTRAINT fk_stazionamento_divisione FOREIGN KEY (numero_armata) 
        REFERENCES Divisione_Imperiale(numero_armata) ON DELETE CASCADE,
    -- Vincolo di chiave esterna verso Occupazione
    CONSTRAINT fk_stazionamento_occupazione FOREIGN KEY (anno_conquista, nome_stella_principale, nome_pianeta, data_inizio) 
        REFERENCES Occupazione(anno_conquista, nome_stella_principale, nome_pianeta, data_inizio) ON DELETE CASCADE
);

-- Tabella e_presidiato: dipende da Stazionamento e Flotta tramite chiavi esterne
CREATE TABLE e_presidiato (
    data_inizio_stazionamento DATE            NOT NULL,
    numero_armata             VARCHAR2(20)    NOT NULL,
    anno_conquista            DATE            NOT NULL,
    nome_stella_principale    VARCHAR2(50)    NOT NULL,
    nome_pianeta              VARCHAR2(50)    NOT NULL,
    data_inizio               DATE            NOT NULL,
    numero_flotta             VARCHAR2(20)    NOT NULL,
    data_fine_stazionamento   DATE,
    CONSTRAINT pk_presidiato PRIMARY KEY (data_inizio_stazionamento, numero_armata, anno_conquista, nome_stella_principale, nome_pianeta, data_inizio, numero_flotta),
    -- Vincolo di chiave esterna verso Stazionamento
    CONSTRAINT fk_presidiato_stazionamento FOREIGN KEY (data_inizio_stazionamento, numero_armata, anno_conquista, nome_stella_principale, nome_pianeta, data_inizio) 
        REFERENCES Stazionamento(data_inizio_stazionamento, numero_armata, anno_conquista, nome_stella_principale, nome_pianeta, data_inizio) ON DELETE CASCADE,
    -- Vincolo di chiave esterna verso Flotta (solo numero_flotta)
    CONSTRAINT fk_presidiato_flotta FOREIGN KEY (numero_flotta) 
        REFERENCES Flotta(numero_flotta) ON DELETE CASCADE
);

-- Tabella Soth: dipende da Flotta tramite chiave esterna
CREATE TABLE Soth (
    ID_chip_cibernetico NUMBER         PRIMARY KEY,
    nome                  VARCHAR2(50),
    data_conversione          DATE,
    numero_flotta         VARCHAR2(20)    NOT NULL,
    -- Vincolo di chiave esterna verso Flotta (solo numero_flotta)
    CONSTRAINT fk_soth_flotta FOREIGN KEY (numero_flotta) 
        REFERENCES Flotta(numero_flotta) ON DELETE CASCADE
);

-- Tabella combatte1: dipende da Gruppo_Ribelle e Guerra_Conquista tramite chiavi esterne
CREATE TABLE combatte1 (
    nome_armata_ribelle        VARCHAR2(50)    NOT NULL,
    data_inizio                DATE            NOT NULL,
    nome_stella_principale     VARCHAR2(50)    NOT NULL,
    nome_pianeta               VARCHAR2(50)    NOT NULL,
    CONSTRAINT pk_combatte1 PRIMARY KEY (nome_armata_ribelle, data_inizio, nome_stella_principale, nome_pianeta),
    -- Vincolo di chiave esterna verso Gruppo_Ribelle
    CONSTRAINT fk_combatte1_ribelle FOREIGN KEY (nome_armata_ribelle) 
        REFERENCES Gruppo_Ribelle(nome_armata) ON DELETE CASCADE,
    -- Vincolo di chiave esterna verso Guerra_Conquista (ora su UNIQUE)
    CONSTRAINT fk_combatte1_guerra FOREIGN KEY (data_inizio, nome_stella_principale, nome_pianeta) 
        REFERENCES Guerra_Conquista(data_inizio, nome_stella_principale, nome_pianeta) ON DELETE CASCADE
);

-- Tabella combatte2: dipende da Divisione_Imperiale e Guerra_Conquista tramite chiavi esterne
CREATE TABLE combatte2 (
    numero_armata          VARCHAR2(20)    NOT NULL,
    data_inizio            DATE            NOT NULL,
    nome_stella_principale VARCHAR2(50)    NOT NULL,
    nome_pianeta           VARCHAR2(50)    NOT NULL,
    numero_perdite         NUMBER,
    CONSTRAINT pk_combatte2 PRIMARY KEY (numero_armata, data_inizio, nome_stella_principale, nome_pianeta),
    -- Vincolo di chiave esterna verso Divisione_Imperiale
    CONSTRAINT fk_combatte2_divisione FOREIGN KEY (numero_armata) 
        REFERENCES Divisione_Imperiale(numero_armata) ON DELETE CASCADE,
    -- Vincolo di chiave esterna verso Guerra_Conquista (riferimento completo)
    CONSTRAINT fk_combatte2_guerra FOREIGN KEY (data_inizio, nome_stella_principale, nome_pianeta) 
        REFERENCES Guerra_Conquista(data_inizio, nome_stella_principale, nome_pianeta) ON DELETE CASCADE
);