-- 1. Crear el usuario
CREATE USER dreamhome IDENTIFIED BY 1234;

-- 2. Asignar roles básicos
GRANT CONNECT, RESOURCE TO dreamhome;

-- 3. SOLUCIÓN AL ERROR: Asignar cuota de espacio (puedes usar 100M o UNLIMITED)
ALTER USER dreamhome QUOTA UNLIMITED ON USERS;

-- 4. Permiso adicional para crear vistas (opcional, muy útil en clase)
GRANT CREATE VIEW TO dreamhome;