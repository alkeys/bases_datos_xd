-- INDICACIONES:
-- desde el Sql Developer cree un usuario llamado dreamhome, coloque una clave y pongale el rol de connect y RESOURCE
-- el nombre del usuario debe ser en ma
-- conectese al developer con el usuario dreamhome
-- desde la terminal ejecute este script

-- CREACIÓN DE TABLAS Y ESTRUCTURA



CREATE TABLE Branch (
    branchNo CHAR(4) PRIMARY KEY,
    street VARCHAR2(50),
    city VARCHAR2(20),
    postcode VARCHAR2(10)
);

CREATE TABLE Staff (
    staffNo CHAR(4) PRIMARY KEY,
    fName VARCHAR2(20),
    lName VARCHAR2(20),
    position VARCHAR2(20),
    sex CHAR(1),
    DOB DATE,
    salary NUMBER(8,2),
    branchNo CHAR(4),
    CONSTRAINT fk_staff_branch FOREIGN KEY (branchNo) REFERENCES Branch(branchNo)
);

CREATE TABLE Client (
    clientNo CHAR(4) PRIMARY KEY,
    fName VARCHAR2(20),
    lName VARCHAR2(20),
    telNo VARCHAR2(20),
    prefType VARCHAR2(10),
    maxRent NUMBER(6,2)
);

CREATE TABLE PrivateOwner (
    ownerNo CHAR(4) PRIMARY KEY,
    fName VARCHAR2(20),
    lName VARCHAR2(20),
    address VARCHAR2(100),
    telNo VARCHAR2(20)
);

CREATE TABLE PropertyForRent (
    propertyNo CHAR(4) PRIMARY KEY,
    street VARCHAR2(50),
    city VARCHAR2(20),
    postcode VARCHAR2(10),
    type VARCHAR2(10),
    rooms NUMBER(2),
    rent NUMBER(6,2),
    ownerNo CHAR(4),
    staffNo CHAR(4),
    branchNo CHAR(4),
    CONSTRAINT fk_prop_owner FOREIGN KEY (ownerNo) REFERENCES PrivateOwner(ownerNo),
    CONSTRAINT fk_prop_staff FOREIGN KEY (staffNo) REFERENCES Staff(staffNo),
    CONSTRAINT fk_prop_branch FOREIGN KEY (branchNo) REFERENCES Branch(branchNo)
);

CREATE TABLE Viewing (
    clientNo CHAR(4),
    propertyNo CHAR(4),
    viewDate DATE,
    comments VARCHAR2(100),
    PRIMARY KEY (clientNo, propertyNo, viewDate),
    CONSTRAINT fk_view_client FOREIGN KEY (clientNo) REFERENCES Client(clientNo),
    CONSTRAINT fk_view_prop FOREIGN KEY (propertyNo) REFERENCES PropertyForRent(propertyNo)
);

CREATE TABLE Registration (
    clientNo CHAR(4),
    branchNo CHAR(4),
    staffNo CHAR(4),
    dateJoined DATE,
    PRIMARY KEY (clientNo, branchNo),
    CONSTRAINT fk_reg_client FOREIGN KEY (clientNo) REFERENCES Client(clientNo),
    CONSTRAINT fk_reg_branch FOREIGN KEY (branchNo) REFERENCES Branch(branchNo),
    CONSTRAINT fk_reg_staff FOREIGN KEY (staffNo) REFERENCES Staff(staffNo)
);

-- 3. INSERCIÓN DE DATOS (Basado en la Figura 3.3 del PDF)

-- Datos de Branch [cite: 4]
INSERT INTO Branch VALUES ('B005', '22 Deer Rd', 'London', 'SW1 4EH');
INSERT INTO Branch VALUES ('B007', '16 Argyll St', 'Aberdeen', 'AB2 3SU');
INSERT INTO Branch VALUES ('B003', '163 Main St', 'Glasgow', 'G11 9QX');
INSERT INTO Branch VALUES ('B004', '32 Manse Rd', 'Bristol', 'BS99 1NZ');
INSERT INTO Branch VALUES ('B002', '56 Clover Dr', 'London', 'NW10 6EU');

-- Datos de Staff [cite: 7]
INSERT INTO Staff VALUES ('SL21', 'John', 'White', 'Manager', 'M', TO_DATE('01-10-1945', 'DD-MM-YYYY'), 30000, 'B005');
INSERT INTO Staff VALUES ('SG37', 'Ann', 'Beech', 'Assistant', 'F', TO_DATE('10-11-1960', 'DD-MM-YYYY'), 12000, 'B003');
INSERT INTO Staff VALUES ('SG14', 'David', 'Ford', 'Supervisor', 'M', TO_DATE('24-03-1958', 'DD-MM-YYYY'), 18000, 'B003');
INSERT INTO Staff VALUES ('SA9', 'Mary', 'Howe', 'Assistant', 'F', TO_DATE('19-02-1970', 'DD-MM-YYYY'), 9000, 'B007');
INSERT INTO Staff VALUES ('SG5', 'Susan', 'Brand', 'Manager', 'F', TO_DATE('03-06-1940', 'DD-MM-YYYY'), 24000, 'B003');
INSERT INTO Staff VALUES ('SL41', 'Julie', 'Lee', 'Assistant', 'F', TO_DATE('13-06-1965', 'DD-MM-YYYY'), 9000, 'B005');

-- Datos de Client [cite: 22]
INSERT INTO Client VALUES ('CR76', 'John', 'Kay', '0207-774-5632', 'Flat', 425);
INSERT INTO Client VALUES ('CR56', 'Aline', 'Stewart', '0141-848-1825', 'Flat', 350);
INSERT INTO Client VALUES ('CR74', 'Mike', 'Ritchie', '01475-392178', 'House', 750);
INSERT INTO Client VALUES ('CR62', 'Mary', 'Tregear', '01224-196720', 'Flat', 600);

-- Datos de PrivateOwner [cite: 25]
INSERT INTO PrivateOwner VALUES ('CO46', 'Joe', 'Keogh', '2 Fergus Dr, Aberdeen AB2 7SX', '01224-861212');
INSERT INTO PrivateOwner VALUES ('CO87', 'Carol', 'Farrel', '6 Achray St, Glasgow G32 9DX', '0141-357-7419');
INSERT INTO PrivateOwner VALUES ('CO40', 'Tina', 'Murphy', '63 Well St, Glasgow G42', '0141-943-1728');
INSERT INTO PrivateOwner VALUES ('CO93', 'Tony', 'Shaw', '12 Park Pl, Glasgow G4 0QR', '0141-225-7025');

-- Datos de PropertyForRent [cite: 10]
INSERT INTO PropertyForRent VALUES ('PA14', '16 Holhead', 'Aberdeen', 'AB7 5SU', 'House', 6, 650, 'CO46', 'SA9', 'B007');
INSERT INTO PropertyForRent VALUES ('PL94', '6 Argyll St', 'London', 'NW2', 'Flat', 4, 400, 'CO87', 'SL41', 'B005');
INSERT INTO PropertyForRent VALUES ('PG4', '6 Lawrence St', 'Glasgow', 'G11 9QX', 'Flat', 3, 350, 'CO40', 'SG37', 'B003');
INSERT INTO PropertyForRent VALUES ('PG36', '2 Manor Rd', 'Glasgow', 'G32 4QX', 'Flat', 3, 375, 'CO93', 'SG37', 'B003');
INSERT INTO PropertyForRent VALUES ('PG21', '18 Dale Rd', 'Glasgow', 'G12', 'House', 5, 600, 'CO87', 'SG14', 'B003');
INSERT INTO PropertyForRent VALUES ('PG16', '5 Novar Dr', 'Glasgow', 'G12 9AX', 'Flat', 4, 450, 'CO93', 'SG14', 'B003');

-- Datos de Viewing [cite: 27]
INSERT INTO Viewing VALUES ('CR56', 'PA14', TO_DATE('24-05-2004', 'DD-MM-YYYY'), 'too small');
INSERT INTO Viewing VALUES ('CR76', 'PG4', TO_DATE('20-04-2004', 'DD-MM-YYYY'), 'too remote');
INSERT INTO Viewing VALUES ('CR56', 'PG4', TO_DATE('26-05-2004', 'DD-MM-YYYY'), NULL);
INSERT INTO Viewing VALUES ('CR62', 'PA14', TO_DATE('14-05-2004', 'DD-MM-YYYY'), 'no dining room');
INSERT INTO Viewing VALUES ('CR56', 'PG36', TO_DATE('28-04-2004', 'DD-MM-YYYY'), NULL);

-- Datos de Registration [cite: 36]
INSERT INTO Registration VALUES ('CR76', 'B005', 'SL41', TO_DATE('02-01-2004', 'DD-MM-YYYY'));
INSERT INTO Registration VALUES ('CR56', 'B003', 'SG37', TO_DATE('11-04-2003', 'DD-MM-YYYY'));
INSERT INTO Registration VALUES ('CR74', 'B003', 'SG37', TO_DATE('16-11-2002', 'DD-MM-YYYY'));
INSERT INTO Registration VALUES ('CR62', 'B007', 'SA9', TO_DATE('07-03-2003', 'DD-MM-YYYY'));

COMMIT;