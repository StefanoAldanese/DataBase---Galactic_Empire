-- Popolamento Sistema_Planetario
-- La maggior parte delle stelle è classificata usando le lettere O, B, A, F, G, K e M:
-- le stelle di tipo O sono le più calde, le altre lettere sono assegnate a stelle via via meno calde,
-- fino a quelle più fredde di classe M.
-- È uso descrivere le stelle di classe O come "blu", quelle di classe B come "azzurre",
-- quelle di classe A come "bianche", quelle di classe F come "bianco-gialle",
-- quelle di classe G come "gialle", quelle di classe K come "arancioni"
-- e quelle di classe M come "rosse".
INSERT INTO Sistema_Planetario VALUES ('Helios',  'B',  100,  200,  300);
INSERT INTO Sistema_Planetario VALUES ('Alpha',   'G',  400,  500,  600);
INSERT INTO Sistema_Planetario VALUES ('Beta',    'K',  700,  800,  900);
INSERT INTO Sistema_Planetario VALUES ('Gamma',   'M', 1000, 1100, 1200);
INSERT INTO Sistema_Planetario VALUES ('Delta',   'F', 1300, 1400, 1500);
INSERT INTO Sistema_Planetario VALUES ('Epsilon', 'A', 1600, 1700, 1800);
INSERT INTO Sistema_Planetario VALUES ('Zeta',    'O', 1900, 2000, 2100);
INSERT INTO Sistema_Planetario VALUES ('Eta',     'B', 2200, 2300, 2400);
INSERT INTO Sistema_Planetario VALUES ('Theta',   'G', 2500, 2600, 2700);
INSERT INTO Sistema_Planetario VALUES ('Iota',    'K', 2800, 2900, 3000);
INSERT INTO Sistema_Planetario VALUES ('Kappa',   'M', 3100, 3200, 3300);
INSERT INTO Sistema_Planetario VALUES ('Lambda',  'F', 3400, 3500, 3600);
INSERT INTO Sistema_Planetario VALUES ('Mu',      'A', 3700, 3800, 3900);
INSERT INTO Sistema_Planetario VALUES ('Nu',      'O', 4000, 4100, 4200);
INSERT INTO Sistema_Planetario VALUES ('Xi',      'B', 4300, 4400, 4500);

-- Popolamento Pianeta
-- La classe dei pianeti è determianta usando le lettere T (Terrestre) e G (Gioviani/gassosi):
INSERT INTO Pianeta VALUES ('Terra',    'Helios', 'Terrestre',  1);
INSERT INTO Pianeta VALUES ('Marte',    'Helios', 'Gioviani',   0);
INSERT INTO Pianeta VALUES ('Nova',     'Alpha',  'Terrestre',  1);
INSERT INTO Pianeta VALUES ('Venus',    'Helios', 'Terrestre',  1);
INSERT INTO Pianeta VALUES ('Jupiter',  'Helios', 'Gioviani',   0);
INSERT INTO Pianeta VALUES ('Mercury',  'Helios', 'Terrestre',  1);
INSERT INTO Pianeta VALUES ('Saturn',   'Helios', 'Gioviani',   0);
INSERT INTO Pianeta VALUES ('Uranus',   'Helios', 'Gioviani',   0);
INSERT INTO Pianeta VALUES ('Neptune',  'Helios', 'Gioviani',   0);
INSERT INTO Pianeta VALUES ('Pluto',    'Helios', 'Terrestre',  1);
INSERT INTO Pianeta VALUES ('Ares',     'Alpha',  'Terrestre',  1);
INSERT INTO Pianeta VALUES ('Gaia',     'Alpha',  'Terrestre',  1);
INSERT INTO Pianeta VALUES ('Chronos',  'Beta',   'Gioviani',   0);
INSERT INTO Pianeta VALUES ('Rhea',     'Beta',   'Terrestre',  1);
INSERT INTO Pianeta VALUES ('Hyperion', 'Gamma',  'Gioviani',   0);
INSERT INTO Pianeta VALUES ('Selene',   'Gamma',  'Terrestre',  1);
INSERT INTO Pianeta VALUES ('Ares',     'Epsilon', 'Terrestre', 1);
INSERT INTO Pianeta VALUES ('Gaia',     'Zeta',    'Terrestre', 1);
INSERT INTO Pianeta VALUES ('Venus',    'Eta',     'Terrestre', 1);
INSERT INTO Pianeta VALUES ('Jupiter',  'Theta',   'Gioviani',  0);
INSERT INTO Pianeta VALUES ('Mercury',  'Iota',    'Terrestre', 1);

-- Popolamento Guerra_Conquista (Tutte le guerre attive sono l'innerJoin con Guerra_Conquista e Occupazione)
INSERT INTO Guerra_Conquista VALUES (TO_DATE('2416-01-01','YYYY-MM-DD'), 'Helios',  'Terra',    'Operazione Aurora');
INSERT INTO Guerra_Conquista VALUES (TO_DATE('2425-03-15','YYYY-MM-DD'), 'Alpha',   'Nova',     'Operazione PullBack');
INSERT INTO Guerra_Conquista VALUES (TO_DATE('2116-02-01','YYYY-MM-DD'), 'Beta',    'Rhea',     'Operazione Thunder');
INSERT INTO Guerra_Conquista VALUES (TO_DATE('2323-03-01','YYYY-MM-DD'), 'Gamma',   'Hyperion', 'Operazione Storm');
INSERT INTO Guerra_Conquista VALUES (TO_DATE('2323-03-01','YYYY-MM-DD'), 'Gamma',   'Selene',   'Operazione Dawn');
INSERT INTO Guerra_Conquista VALUES (TO_DATE('2126-04-01','YYYY-MM-DD'), 'Epsilon', 'Ares',     'Operazione Eclipse');
INSERT INTO Guerra_Conquista VALUES (TO_DATE('2216-05-01','YYYY-MM-DD'), 'Zeta',    'Gaia',     'Operazione Nova');
INSERT INTO Guerra_Conquista VALUES (TO_DATE('2234-06-01','YYYY-MM-DD'), 'Eta',     'Venus',    'Operazione Genesis');
INSERT INTO Guerra_Conquista VALUES (TO_DATE('2224-07-01','YYYY-MM-DD'), 'Theta',   'Jupiter',  'Operazione Exodus');
INSERT INTO Guerra_Conquista VALUES (TO_DATE('2321-08-01','YYYY-MM-DD'), 'Iota',    'Mercury',  'Operazione Omega');

-- Popolamento Corporation
INSERT INTO Corporation VALUES ('KRAXX Extractors',    '2100', 'Joe Biden',         500);
INSERT INTO Corporation VALUES ('TARKON Armaments',    '2090', 'Jessika Caldouron', 800);
INSERT INTO Corporation VALUES ('VORST Dynamics',      '2110', 'Alan Smithee',      300);
INSERT INTO Corporation VALUES ('SEKIGUCHI Armaments', '2053', 'Miura Oda',         600);
INSERT INTO Corporation VALUES ('ASTRA Mining',        '2105', 'Lara Croft',        700);
INSERT INTO Corporation VALUES ('NEBULA Tech',         '2115', 'Rick Sanchez',      900);
INSERT INTO Corporation VALUES ('ORION Logistics',     '2125', 'Morty Smith',       400);
INSERT INTO Corporation VALUES ('GALAXY Arms',         '2130', 'Sarah Connor',      850);
INSERT INTO Corporation VALUES ('COSMOS Energy',       '2140', 'John Connor',       950);
INSERT INTO Corporation VALUES ('SOLARIS Ventures',    '2150', 'Ellen Ripley',      600);
INSERT INTO Corporation VALUES ('QUANTUM Dynamics',    '2160', 'Peter Parker',      750);
INSERT INTO Corporation VALUES ('INFINITY Corp',       '2170', 'Tony Spark',       1000);
INSERT INTO Corporation VALUES ('STELLAR Industries',  '2180', 'Bruce Wyn',       650);
INSERT INTO Corporation VALUES ('LUNAR Holdings',      '2190', 'Clark Kento',        550);
INSERT INTO Corporation VALUES ('PULSAR Systems',      '2200', 'Diana Prince',      800);

-- Popolamento Corporation_Bellica
INSERT INTO Corporation_Bellica VALUES ('KRAXX Extractors',    4);
INSERT INTO Corporation_Bellica VALUES ('GALAXY Arms',         3);
INSERT INTO Corporation_Bellica VALUES ('NEBULA Tech',         2);
INSERT INTO Corporation_Bellica VALUES ('ASTRA Mining',        2);
INSERT INTO Corporation_Bellica VALUES ('ORION Logistics',     2);
INSERT INTO Corporation_Bellica VALUES ('COSMOS Energy',       2);
INSERT INTO Corporation_Bellica VALUES ('SOLARIS Ventures',    2);
INSERT INTO Corporation_Bellica VALUES ('QUANTUM Dynamics',    2);
INSERT INTO Corporation_Bellica VALUES ('INFINITY Corp',       2);
INSERT INTO Corporation_Bellica VALUES ('STELLAR Industries',  2);
INSERT INTO Corporation_Bellica VALUES ('LUNAR Holdings',      2);
INSERT INTO Corporation_Bellica VALUES ('TARKON Armaments',    1);
INSERT INTO Corporation_Bellica VALUES ('SEKIGUCHI Armaments', 3);

-- Popolamento Corporation_Trasporti
INSERT INTO Corporation_Trasporti VALUES ('ORION Logistics');
INSERT INTO Corporation_Trasporti VALUES ('COSMOS Energy');
INSERT INTO Corporation_Trasporti VALUES ('QUANTUM Dynamics');
INSERT INTO Corporation_Trasporti VALUES ('INFINITY Corp');
INSERT INTO Corporation_Trasporti VALUES ('GALAXY Arms');

-- Popolamento Corporation_Mineraria
INSERT INTO Corporation_Mineraria VALUES ('KRAXX Extractors', 10);

-- Popolamento Armi
INSERT INTO Armi VALUES ('TARKON Armaments', 'LaserCannonOZ-32', 'Laser', TO_DATE('2102-02-01','YYYY-MM-DD'));
INSERT INTO Armi VALUES ('SEKIGUCHI Armaments', 'PlasmaAlice-64', 'Plasma', TO_DATE('2098-07-01','YYYY-MM-DD'));
INSERT INTO Armi VALUES ('GALAXY Arms', 'RailgunX-1', 'Railgun', TO_DATE('2131-01-01','YYYY-MM-DD'));
INSERT INTO Armi VALUES ('GALAXY Arms', 'RailgunPoor-2', 'Railgun', TO_DATE('2132-01-01','YYYY-MM-DD'));
INSERT INTO Armi VALUES ('NEBULA Tech', 'IonBlaster-7', 'Ion', TO_DATE('2116-03-01','YYYY-MM-DD'));
INSERT INTO Armi VALUES ('NEBULA Tech', 'YodaBlaster-8', 'Ion', TO_DATE('2117-03-01','YYYY-MM-DD'));
INSERT INTO Armi VALUES ('KRAXX Extractors', 'MiningLaser-1', 'Laser', TO_DATE('2101-02-01','YYYY-MM-DD'));

-- Popolamento Partita_di_minerali
INSERT INTO Partita_di_minerali VALUES ('STE00-3003', TO_DATE('2417-01-01','YYYY-MM-DD'),  750, 'KRAXX Extractors');
INSERT INTO Partita_di_minerali VALUES ('DON00-2977', TO_DATE('2417-02-01','YYYY-MM-DD'),  500, 'KRAXX Extractors');
INSERT INTO Partita_di_minerali VALUES ('PLU00-4001', TO_DATE('2417-03-01','YYYY-MM-DD'),  800, 'KRAXX Extractors');
INSERT INTO Partita_di_minerali VALUES ('NEB00-4002', TO_DATE('2417-04-01','YYYY-MM-DD'),  600, 'KRAXX Extractors');
INSERT INTO Partita_di_minerali VALUES ('GAL00-4003', TO_DATE('2418-01-01','YYYY-MM-DD'),  900, 'KRAXX Extractors');
INSERT INTO Partita_di_minerali VALUES ('AST00-4004', TO_DATE('2418-02-01','YYYY-MM-DD'),  550, 'KRAXX Extractors');
INSERT INTO Partita_di_minerali VALUES ('COS00-4005', TO_DATE('2418-03-01','YYYY-MM-DD'),  700, 'KRAXX Extractors');

-- Popolamento Ferro_Titanico
INSERT INTO Ferro_Titanico VALUES ('STE00-3003', 80, 7.8);
INSERT INTO Ferro_Titanico VALUES ('NEB00-4002', 40, 2.5);
INSERT INTO Ferro_Titanico VALUES ('COS00-4005', 99, 10.8);

-- Popolamento Nanosabbia_di_dune_profonde
INSERT INTO Nanosabbia_di_dune_profonde VALUES ('DON00-2977', 95);
INSERT INTO Nanosabbia_di_dune_profonde VALUES ('AST00-4004', 88);

-- Popolamento Cristalli_di_plutonio
INSERT INTO Cristalli_di_plutonio VALUES ('STE00-3003', 99);
INSERT INTO Cristalli_di_plutonio VALUES ('PLU00-4001', 33);

-- Popolamento Gruppo_Ribelle (check status)
INSERT INTO Gruppo_Ribelle VALUES ('Ribelli Helios',  5, 'Attivo');
INSERT INTO Gruppo_Ribelle VALUES ('Ribelli Alpha',   3, 'Distrutto');
INSERT INTO Gruppo_Ribelle VALUES ('Ribelli Beta',    4, 'Attivo');
INSERT INTO Gruppo_Ribelle VALUES ('Ribelli Gamma',   6, 'Attivo');
INSERT INTO Gruppo_Ribelle VALUES ('Ribelli Delta',   2, 'Distrutto');
INSERT INTO Gruppo_Ribelle VALUES ('Ribelli Epsilon', 7, 'Attivo');
INSERT INTO Gruppo_Ribelle VALUES ('Ribelli Zeta',    3, 'Attivo');
INSERT INTO Gruppo_Ribelle VALUES ('Ribelli Eta',     5, 'Distrutto');
INSERT INTO Gruppo_Ribelle VALUES ('Ribelli Theta',   8, 'Attivo');

-- Popolamento Divisione_Imperiale
INSERT INTO Divisione_Imperiale VALUES ('DIV00-001', 'Armata Wayn',      1000, 'fanteria');
INSERT INTO Divisione_Imperiale VALUES ('DIV00-002', 'Armata Sighr',      150, 'cavalleria');
INSERT INTO Divisione_Imperiale VALUES ('DIV00-003', 'Armata Nop',        500, 'trasporti');
INSERT INTO Divisione_Imperiale VALUES ('DIV01-001', 'Armata Thropos',   1300, 'fanteria');
INSERT INTO Divisione_Imperiale VALUES ('DIV01-002', 'Armata Phanteon',   800, 'artiglieria');
INSERT INTO Divisione_Imperiale VALUES ('DIV01-003', 'Armata Nein',      1200, 'trasporti');
INSERT INTO Divisione_Imperiale VALUES ('DIV00-004', 'Armata Beta',       900, 'fanteria');
INSERT INTO Divisione_Imperiale VALUES ('DIV00-005', 'Armata Gammadium', 1100, 'cavalleria');
INSERT INTO Divisione_Imperiale VALUES ('DIV00-006', 'Armata Delta',      700, 'trasporti');
INSERT INTO Divisione_Imperiale VALUES ('DIV01-004', 'Armata Epsilon',   1400, 'fanteria');
INSERT INTO Divisione_Imperiale VALUES ('DIV01-005', 'Armata Zeta',       600, 'artiglieria');
INSERT INTO Divisione_Imperiale VALUES ('DIV01-006', 'Armata Etany',     1000, 'trasporti');
INSERT INTO Divisione_Imperiale VALUES ('DIV02-001', 'Armata Thet',       800, 'fanteria');
INSERT INTO Divisione_Imperiale VALUES ('DIV02-002', 'Armata Iota',       950, 'cavalleria');
INSERT INTO Divisione_Imperiale VALUES ('DIV02-003', 'Armata Kappa',     1200, 'trasporti');
INSERT INTO Divisione_Imperiale VALUES ('DIV02-004', 'Armata Lambda',    1050, 'fanteria');
INSERT INTO Divisione_Imperiale VALUES ('DIV02-005', 'Armata Mu',        1150, 'artiglieria');
INSERT INTO Divisione_Imperiale VALUES ('DIV02-006', 'Armata Nunu',      1250, 'trasporti');

-- Popolamento Flotta
INSERT INTO Flotta VALUES ('FLOT00-001', 'Flotta Helios', 10, 'DIV00-001');
INSERT INTO Flotta VALUES ('FLOT00-002', 'Flotta Alpha', 8, 'DIV01-001');
INSERT INTO Flotta VALUES ('FLOT00-003', 'Flotta Beta', 12, 'DIV00-004');
INSERT INTO Flotta VALUES ('FLOT00-004', 'Flotta Gamma', 9, 'DIV00-005');
INSERT INTO Flotta VALUES ('FLOT00-005', 'Flotta Delta', 11, 'DIV00-006');
INSERT INTO Flotta VALUES ('FLOT01-003', 'Flotta Epsilon', 13, 'DIV01-004');
INSERT INTO Flotta VALUES ('FLOT01-004', 'Flotta Zeta', 7, 'DIV01-005');
INSERT INTO Flotta VALUES ('FLOT01-005', 'Flotta Eta', 14, 'DIV01-006');
INSERT INTO Flotta VALUES ('FLOT02-001', 'Flotta Theta', 10, 'DIV02-001');
INSERT INTO Flotta VALUES ('FLOT02-002', 'Flotta Iota', 8, 'DIV02-002');
INSERT INTO Flotta VALUES ('FLOT02-003', 'Flotta Kappa', 15, 'DIV02-003');
INSERT INTO Flotta VALUES ('FLOT02-004', 'Flotta Lambda', 6, 'DIV02-004');
INSERT INTO Flotta VALUES ('FLOT02-005', 'Flotta Mu', 16, 'DIV02-005');
INSERT INTO Flotta VALUES ('FLOT02-006', 'Flotta Nu', 5, 'DIV02-006');
INSERT INTO Flotta VALUES ('FLOT03-001', 'Flotta Omega', 17, 'DIV02-001');

-- Popolamento Navi (dopo Corporation_Bellica)
INSERT INTO Navi VALUES ('Odyssey',       'Origin 600i',         700, 'KRAXX Extractors');
INSERT INTO Navi VALUES ('Aurora',        'RSI Aurora',          600, 'ASTRA Mining');
INSERT INTO Navi VALUES ('Constellation', 'RSI Constellation',   750, 'NEBULA Tech');
INSERT INTO Navi VALUES ('Starfarer',     'MISC Starfarer',      900, 'ORION Logistics');
INSERT INTO Navi VALUES ('Carrack',       'Anvil Carrack',      1000, 'GALAXY Arms');
INSERT INTO Navi VALUES ('Reclaimer',     'Aegis Reclaimer',     650, 'COSMOS Energy');
INSERT INTO Navi VALUES ('Hammerhead',    'Aegis Hammerhead',    850, 'SOLARIS Ventures');
INSERT INTO Navi VALUES ('Cutlass',       'Drake Cutlass',       700, 'QUANTUM Dynamics');
INSERT INTO Navi VALUES ('Freelancer',    'MISC Freelancer',     800, 'INFINITY Corp');
INSERT INTO Navi VALUES ('Gladius',       'Aegis Gladius',       950, 'STELLAR Industries');
INSERT INTO Navi VALUES ('Vanguard',      'Aegis Vanguard',      900, 'LUNAR Holdings');

-- Popolamento Navi_da_combattimento (dopo Navi e Flotta)
INSERT INTO Navi_da_combattimento VALUES ('Odyssey', 'FLOT00-004', 'ricognizione');
INSERT INTO Navi_da_combattimento VALUES ('Aurora', 'FLOT01-003', 'supporto');
INSERT INTO Navi_da_combattimento VALUES ('Constellation', 'FLOT01-004', 'assalto');

-- Popolamento Navi_mercantili (dopo Navi e Corporation_Trasporti)
-- INSERT INTO Navi_mercantili VALUES ('Voyagerest', 'VORST Dynamics', '1000');
INSERT INTO Navi_mercantili VALUES ('Starfarer', 'ORION Logistics', 2000);
INSERT INTO Navi_mercantili VALUES ('Reclaimer', 'COSMOS Energy', 1500);
INSERT INTO Navi_mercantili VALUES ('Cutlass', 'QUANTUM Dynamics', 800);
INSERT INTO Navi_mercantili VALUES ('Freelancer', 'INFINITY Corp', 1200);
INSERT INTO Navi_mercantili VALUES ('Carrack', 'GALAXY Arms', 1800);

-- Popolamento finanzia
INSERT INTO finanzia VALUES ('KRAXX Extractors', TO_DATE('2416-01-01','YYYY-MM-DD'), 'Helios', 'Terra', 100000);
INSERT INTO finanzia VALUES ('TARKON Armaments', TO_DATE('2425-03-15','YYYY-MM-DD'), 'Alpha', 'Nova', 200000);
INSERT INTO finanzia VALUES ('SEKIGUCHI Armaments', TO_DATE('2323-03-01','YYYY-MM-DD'), 'Gamma', 'Hyperion', 180000);
INSERT INTO finanzia VALUES ('NEBULA Tech', TO_DATE('2126-04-01','YYYY-MM-DD'), 'Epsilon', 'Ares', 160000);
INSERT INTO finanzia VALUES ('ORION Logistics', TO_DATE('2216-05-01','YYYY-MM-DD'), 'Zeta', 'Gaia', 140000);

-- Popolamento Occupazione (dopo Guerra_Conquista e Corporation)
INSERT INTO Occupazione VALUES (TO_DATE('2424-02-01','YYYY-MM-DD'), 'Helios',  'Terra',    TO_DATE('2416-01-01','YYYY-MM-DD'), 5000000, 'KRAXX Extractors');
INSERT INTO Occupazione VALUES (TO_DATE('2435-12-25','YYYY-MM-DD'), 'Alpha',   'Nova',     TO_DATE('2425-03-15','YYYY-MM-DD'), 3000000, 'TARKON Armaments');
INSERT INTO Occupazione VALUES (TO_DATE('2324-03-01','YYYY-MM-DD'), 'Gamma',   'Hyperion', TO_DATE('2323-03-01','YYYY-MM-DD'), 4000000, 'NEBULA Tech');
INSERT INTO Occupazione VALUES (TO_DATE('2333-03-01','YYYY-MM-DD'), 'Gamma',   'Selene',   TO_DATE('2323-03-01','YYYY-MM-DD'), 3500000, 'ORION Logistics');
INSERT INTO Occupazione VALUES (TO_DATE('2134-04-01','YYYY-MM-DD'), 'Epsilon', 'Ares',     TO_DATE('2126-04-01','YYYY-MM-DD'), 2500000, 'GALAXY Arms');
INSERT INTO Occupazione VALUES (TO_DATE('2226-05-22','YYYY-MM-DD'), 'Zeta',    'Gaia',     TO_DATE('2216-05-01','YYYY-MM-DD'), 4500000, 'COSMOS Energy');
INSERT INTO Occupazione VALUES (TO_DATE('2244-06-11','YYYY-MM-DD'), 'Eta',     'Venus',    TO_DATE('2234-06-01','YYYY-MM-DD'), 1500000, 'QUANTUM Dynamics');
INSERT INTO Occupazione VALUES (TO_DATE('2233-07-01','YYYY-MM-DD'), 'Theta',   'Jupiter',  TO_DATE('2224-07-01','YYYY-MM-DD'), 5000000, 'INFINITY Corp');
INSERT INTO Occupazione VALUES (TO_DATE('2331-04-01','YYYY-MM-DD'), 'Iota',    'Mercury',  TO_DATE('2321-08-01','YYYY-MM-DD'), 1800000, 'STELLAR Industries');


-- Popolamento combatte1 (dopo Gruppo_Ribelle e Guerra_Conquista)
INSERT INTO combatte1 VALUES ('Ribelli Helios',  TO_DATE('2416-01-01','YYYY-MM-DD'), 'Helios', 'Terra');
INSERT INTO combatte1 VALUES ('Ribelli Alpha',   TO_DATE('2425-03-15','YYYY-MM-DD'), 'Alpha', 'Nova');
INSERT INTO combatte1 VALUES ('Ribelli Beta',    TO_DATE('2116-02-01','YYYY-MM-DD'), 'Beta', 'Rhea');
INSERT INTO combatte1 VALUES ('Ribelli Gamma',   TO_DATE('2323-03-01','YYYY-MM-DD'), 'Gamma', 'Hyperion');
INSERT INTO combatte1 VALUES ('Ribelli Delta',   TO_DATE('2126-04-01','YYYY-MM-DD'), 'Epsilon', 'Ares');
INSERT INTO combatte1 VALUES ('Ribelli Epsilon', TO_DATE('2216-05-01','YYYY-MM-DD'), 'Zeta', 'Gaia');
INSERT INTO combatte1 VALUES ('Ribelli Zeta',    TO_DATE('2234-06-01','YYYY-MM-DD'), 'Eta', 'Venus');
INSERT INTO combatte1 VALUES ('Ribelli Eta',     TO_DATE('2224-07-01','YYYY-MM-DD'), 'Theta', 'Jupiter');
INSERT INTO combatte1 VALUES ('Ribelli Theta',   TO_DATE('2321-08-01','YYYY-MM-DD'), 'Iota', 'Mercury');

-- Popolamento combatte2 (dopo Divisione_Imperiale e Guerra_Conquista)
INSERT INTO combatte2 VALUES ('DIV00-001', TO_DATE('2416-01-01','YYYY-MM-DD'), 'Helios', 'Terra', 300);
INSERT INTO combatte2 VALUES ('DIV01-002', TO_DATE('2425-03-15','YYYY-MM-DD'), 'Alpha', 'Nova', 250);
INSERT INTO combatte2 VALUES ('DIV00-004', TO_DATE('2116-02-01','YYYY-MM-DD'), 'Beta', 'Rhea', 200);
INSERT INTO combatte2 VALUES ('DIV00-005', TO_DATE('2323-03-01','YYYY-MM-DD'), 'Gamma', 'Hyperion', 150);
INSERT INTO combatte2 VALUES ('DIV00-006', TO_DATE('2323-03-01','YYYY-MM-DD'), 'Gamma', 'Selene', 180);
INSERT INTO combatte2 VALUES ('DIV01-004', TO_DATE('2126-04-01','YYYY-MM-DD'), 'Epsilon', 'Ares', 220);
INSERT INTO combatte2 VALUES ('DIV01-005', TO_DATE('2216-05-01','YYYY-MM-DD'), 'Zeta', 'Gaia', 170);
INSERT INTO combatte2 VALUES ('DIV01-006', TO_DATE('2234-06-01','YYYY-MM-DD'), 'Eta', 'Venus', 210);
INSERT INTO combatte2 VALUES ('DIV02-001', TO_DATE('2224-07-01','YYYY-MM-DD'), 'Theta', 'Jupiter', 160);
INSERT INTO combatte2 VALUES ('DIV02-002', TO_DATE('2321-08-01','YYYY-MM-DD'), 'Iota', 'Mercury', 190);

-- Popolamento Viaggio
INSERT INTO Viaggio VALUES (TO_DATE('2424-03-15','YYYY-MM-DD'), TO_DATE('2424-04-20','YYYY-MM-DD'), 500, 'Starfarer', TO_DATE('2424-02-01','YYYY-MM-DD'), 'Helios', 'Terra', TO_DATE('2416-01-01','YYYY-MM-DD'), 'Nova', 'Alpha', TO_DATE('2435-12-25','YYYY-MM-DD'), TO_DATE('2425-03-15','YYYY-MM-DD'));
INSERT INTO Viaggio VALUES (TO_DATE('2436-01-10','YYYY-MM-DD'), TO_DATE('2436-02-25','YYYY-MM-DD'), 300, 'Reclaimer', TO_DATE('2435-12-25','YYYY-MM-DD'), 'Alpha', 'Nova', TO_DATE('2425-03-15','YYYY-MM-DD'), 'Hyperion', 'Gamma', TO_DATE('2324-03-01','YYYY-MM-DD'), TO_DATE('2323-03-01','YYYY-MM-DD'));
INSERT INTO Viaggio VALUES (TO_DATE('2125-03-01','YYYY-MM-DD'), TO_DATE('2125-04-10','YYYY-MM-DD'), 700, 'Carrack', TO_DATE('2324-03-01','YYYY-MM-DD'), 'Gamma', 'Hyperion', TO_DATE('2323-03-01','YYYY-MM-DD'), 'Ares', 'Epsilon', TO_DATE('2134-04-01','YYYY-MM-DD'), TO_DATE('2126-04-01','YYYY-MM-DD'));
INSERT INTO Viaggio VALUES (TO_DATE('2226-06-01','YYYY-MM-DD'), TO_DATE('2226-07-15','YYYY-MM-DD'), 450, 'Freelancer', TO_DATE('2226-05-22','YYYY-MM-DD'), 'Zeta', 'Gaia', TO_DATE('2216-05-01','YYYY-MM-DD'), 'Venus', 'Eta', TO_DATE('2244-06-11','YYYY-MM-DD'), TO_DATE('2234-06-01','YYYY-MM-DD'));
INSERT INTO Viaggio VALUES (TO_DATE('2331-05-01','YYYY-MM-DD'), TO_DATE('2331-06-20','YYYY-MM-DD'), 600, 'Cutlass', TO_DATE('2331-04-01','YYYY-MM-DD'), 'Iota', 'Mercury', TO_DATE('2321-08-01','YYYY-MM-DD'), 'Jupiter', 'Theta', TO_DATE('2233-07-01','YYYY-MM-DD'), TO_DATE('2224-07-01','YYYY-MM-DD'));


-- Popolamento viene_trasportato_attraverso_minerali
INSERT INTO viene_trasportato_attraverso_minerali VALUES ('STE00-3003', TO_DATE('2424-03-15','YYYY-MM-DD'), 'Starfarer', 1200);
INSERT INTO viene_trasportato_attraverso_minerali VALUES ('DON00-2977', TO_DATE('2436-01-10','YYYY-MM-DD'), 'Reclaimer', 1000);
INSERT INTO viene_trasportato_attraverso_minerali VALUES ('PLU00-4001', TO_DATE('2125-03-01','YYYY-MM-DD'), 'Carrack', 1200);
INSERT INTO viene_trasportato_attraverso_minerali VALUES ('NEB00-4002', TO_DATE('2226-06-01','YYYY-MM-DD'), 'Freelancer', 700);
INSERT INTO viene_trasportato_attraverso_minerali VALUES ('GAL00-4003', TO_DATE('2331-05-01','YYYY-MM-DD'), 'Cutlass', 600);


-- Popolamento viene_trasportato_attraverso_armi
INSERT INTO viene_trasportato_attraverso_armi VALUES ('TARKON Armaments', 'LaserCannonOZ-32', 'Laser', TO_DATE('2424-03-15','YYYY-MM-DD'), 'Starfarer', 800);
INSERT INTO viene_trasportato_attraverso_armi VALUES ('SEKIGUCHI Armaments', 'PlasmaAlice-64', 'Plasma', TO_DATE('2436-01-10','YYYY-MM-DD'), 'Reclaimer', 500);
INSERT INTO viene_trasportato_attraverso_armi VALUES ('GALAXY Arms', 'RailgunX-1', 'Railgun', TO_DATE('2125-03-01','YYYY-MM-DD'), 'Carrack', 500);
INSERT INTO viene_trasportato_attraverso_armi VALUES ('NEBULA Tech', 'IonBlaster-7', 'Ion', TO_DATE('2226-06-01','YYYY-MM-DD'), 'Freelancer', 400);
INSERT INTO viene_trasportato_attraverso_armi VALUES ('KRAXX Extractors', 'MiningLaser-1', 'Laser', TO_DATE('2331-05-01','YYYY-MM-DD'), 'Cutlass', 200);


-- Popolamento Stazionamento
INSERT INTO Stazionamento VALUES (TO_DATE('2424-02-01','YYYY-MM-DD'), 'DIV00-001', TO_DATE('2424-02-01','YYYY-MM-DD'), 'Helios', 'Terra', TO_DATE('2416-01-01','YYYY-MM-DD'), 5000);
INSERT INTO Stazionamento VALUES (TO_DATE('2435-12-25','YYYY-MM-DD'), 'DIV01-002', TO_DATE('2435-12-25','YYYY-MM-DD'), 'Alpha', 'Nova', TO_DATE('2425-03-15','YYYY-MM-DD'), 3000);
INSERT INTO Stazionamento VALUES (TO_DATE('2324-03-01','YYYY-MM-DD'), 'DIV00-005', TO_DATE('2324-03-01','YYYY-MM-DD'), 'Gamma', 'Hyperion', TO_DATE('2323-03-01','YYYY-MM-DD'), 4000);
INSERT INTO Stazionamento VALUES (TO_DATE('2333-03-01','YYYY-MM-DD'), 'DIV00-006', TO_DATE('2333-03-01','YYYY-MM-DD'), 'Gamma', 'Selene', TO_DATE('2323-03-01','YYYY-MM-DD'), 3500);
INSERT INTO Stazionamento VALUES (TO_DATE('2134-04-01','YYYY-MM-DD'), 'DIV01-004', TO_DATE('2134-04-01','YYYY-MM-DD'), 'Epsilon', 'Ares', TO_DATE('2126-04-01','YYYY-MM-DD'), 2500);
INSERT INTO Stazionamento VALUES (TO_DATE('2226-05-22','YYYY-MM-DD'), 'DIV01-005', TO_DATE('2226-05-22','YYYY-MM-DD'), 'Zeta', 'Gaia', TO_DATE('2216-05-01','YYYY-MM-DD'), 4500);
INSERT INTO Stazionamento VALUES (TO_DATE('2244-06-11','YYYY-MM-DD'), 'DIV01-006', TO_DATE('2244-06-11','YYYY-MM-DD'), 'Eta', 'Venus', TO_DATE('2234-06-01','YYYY-MM-DD'), 1500);
INSERT INTO Stazionamento VALUES (TO_DATE('2233-07-01','YYYY-MM-DD'), 'DIV02-001', TO_DATE('2233-07-01','YYYY-MM-DD'), 'Theta', 'Jupiter', TO_DATE('2224-07-01','YYYY-MM-DD'), 5000);
INSERT INTO Stazionamento VALUES (TO_DATE('2331-04-01','YYYY-MM-DD'), 'DIV02-002', TO_DATE('2331-04-01','YYYY-MM-DD'), 'Iota', 'Mercury', TO_DATE('2321-08-01','YYYY-MM-DD'), 1800);


-- Popolamento e_presidiato
INSERT INTO e_presidiato VALUES (TO_DATE('2424-02-01','YYYY-MM-DD'), 'DIV00-001', TO_DATE('2424-02-01','YYYY-MM-DD'), 'Helios', 'Terra', TO_DATE('2416-01-01','YYYY-MM-DD'), 'FLOT00-001', TO_DATE('2417-01-01','YYYY-MM-DD'));
INSERT INTO e_presidiato VALUES (TO_DATE('2435-12-25','YYYY-MM-DD'), 'DIV01-002', TO_DATE('2435-12-25','YYYY-MM-DD'), 'Alpha', 'Nova', TO_DATE('2425-03-15','YYYY-MM-DD'), 'FLOT00-002', TO_DATE('2426-03-15','YYYY-MM-DD'));
INSERT INTO e_presidiato VALUES (TO_DATE('2324-03-01','YYYY-MM-DD'), 'DIV00-005', TO_DATE('2324-03-01','YYYY-MM-DD'), 'Gamma', 'Hyperion', TO_DATE('2323-03-01','YYYY-MM-DD'), 'FLOT00-004', TO_DATE('2324-03-01','YYYY-MM-DD'));
INSERT INTO e_presidiato VALUES (TO_DATE('2333-03-01','YYYY-MM-DD'), 'DIV00-006', TO_DATE('2333-03-01','YYYY-MM-DD'), 'Gamma', 'Selene', TO_DATE('2323-03-01','YYYY-MM-DD'), 'FLOT00-005', TO_DATE('2324-03-01','YYYY-MM-DD'));
INSERT INTO e_presidiato VALUES (TO_DATE('2134-04-01','YYYY-MM-DD'), 'DIV01-004', TO_DATE('2134-04-01','YYYY-MM-DD'), 'Epsilon', 'Ares', TO_DATE('2126-04-01','YYYY-MM-DD'), 'FLOT01-003', TO_DATE('2127-04-01','YYYY-MM-DD'));
INSERT INTO e_presidiato VALUES (TO_DATE('2226-05-22','YYYY-MM-DD'), 'DIV01-005', TO_DATE('2226-05-22','YYYY-MM-DD'), 'Zeta', 'Gaia', TO_DATE('2216-05-01','YYYY-MM-DD'), 'FLOT01-004', NULL);
INSERT INTO e_presidiato VALUES (TO_DATE('2244-06-11','YYYY-MM-DD'), 'DIV01-006', TO_DATE('2244-06-11','YYYY-MM-DD'), 'Eta', 'Venus', TO_DATE('2234-06-01','YYYY-MM-DD'), 'FLOT01-005', TO_DATE('2235-06-01','YYYY-MM-DD'));
INSERT INTO e_presidiato VALUES (TO_DATE('2233-07-01','YYYY-MM-DD'), 'DIV02-001', TO_DATE('2233-07-01','YYYY-MM-DD'), 'Theta', 'Jupiter', TO_DATE('2224-07-01','YYYY-MM-DD'), 'FLOT02-001', TO_DATE('2225-07-01','YYYY-MM-DD'));
INSERT INTO e_presidiato VALUES (TO_DATE('2331-04-01','YYYY-MM-DD'), 'DIV02-002', TO_DATE('2331-04-01','YYYY-MM-DD'), 'Iota', 'Mercury', TO_DATE('2321-08-01','YYYY-MM-DD'), 'FLOT02-002', NULL);


-- Popolamento Soth
INSERT INTO Soth VALUES (1, 'Yodalok',    TO_DATE('2316-01-01','YYYY-MM-DD'), 'FLOT00-001');
INSERT INTO Soth VALUES (2, 'Starwalker', TO_DATE('2117-01-01','YYYY-MM-DD'), 'FLOT00-002');
INSERT INTO Soth VALUES (3, 'Nebulon',    TO_DATE('2322-01-01','YYYY-MM-DD'), 'FLOT00-003');
INSERT INTO Soth VALUES (4, 'Galaxion',   TO_DATE('2111-01-01','YYYY-MM-DD'), 'FLOT00-004');
INSERT INTO Soth VALUES (5, 'Thanos',     TO_DATE('2200-01-01','YYYY-MM-DD'), 'FLOT00-005');
INSERT INTO Soth VALUES (6, 'Soleir',     TO_DATE('2413-01-01','YYYY-MM-DD'), 'FLOT01-003');


