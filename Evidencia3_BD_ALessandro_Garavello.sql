CREATE TYPE tFamilia AS OBJECT (
  idFamilia NUMBER,
  familia VARCHAR2(50)
);
CREATE TABLE FAMILIA OF tFamilia;
ALTER TABLE FAMILIA ADD PRIMARY KEY (idFamilia);

INSERT INTO FAMILIA VALUES (1, 'Aves');
INSERT INTO FAMILIA VALUES (2, 'Mamíferos');
INSERT INTO FAMILIA VALUES (3, 'Peces');

CREATE TYPE tNombres AS VARRAY(20) OF VARCHAR2(50);

CREATE TYPE tAnimal AS OBJECT (
  idAnimal NUMBER,
  idFamilia NUMBER,
  animal VARCHAR2(50),
  nombres tNombres,
  MEMBER FUNCTION ejemplares RETURN VARCHAR2
);

CREATE TYPE BODY tAnimal AS
  MEMBER FUNCTION ejemplares RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Hay ' || self.nombres.COUNT || ' animales de la especie ' || self.animal;
  END;
END;

CREATE TABLE Animal OF tAnimal;
ALTER TABLE Animal ADD PRIMARY KEY (idAnimal);
ALTER TABLE Animal ADD FOREIGN KEY (idFamilia) REFERENCES FAMILIA (idFamilia);

INSERT INTO Animal VALUES (1, 1, 'Garza Real', tNombres('Calíope', 'Izaro'));
INSERT INTO Animal VALUES (2, 1, 'Cigüeña Blanca', tNombres('Perica', 'Clara', 'Miranda'));
INSERT INTO Animal VALUES (3, 1, 'Gorrión', tNombres('coco', 'roco', 'loco', 'peco', 'rico'));
INSERT INTO Animal VALUES (4, 2, 'Zorro', tNombres('Lucas', 'Mario'));
INSERT INTO Animal VALUES (5, 2, 'Lobo', tNombres('Pedro', 'Pablo'));
INSERT INTO Animal VALUES (6, 2, 'Ciervo', tNombres('Bravo', 'Listo', 'Rojo', 'Astuto'));
INSERT INTO Animal VALUES (7, 3, 'Pez globo', tNombres());
INSERT INTO Animal VALUES (8, 3, 'Pez payaso', tNombres());
INSERT INTO Animal VALUES (9, 3, 'Ángel llama', tNombres());

SELECT a.idAnimal, a.animal, f.familia, a.ejemplares() AS num_ejemplares
FROM Animal a
JOIN FAMILIA f ON a.idFamilia = f.idFamilia;
SELECT * FROM FAMILIA;