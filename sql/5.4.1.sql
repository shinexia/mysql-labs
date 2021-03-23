CREATE TABLE t (
	a INT NOT NULL,
    b VARCHAR(8000),
    c INT NOT NULL,
    PRIMARY KEY (a),
    KEY idx_c (c)
) ENGINE=InnoDB;


INSERT INTO t SELECT 1, REPEAT('a', 7000), -1;
INSERT INTO t SELECT 2, REPEAT('a', 7000), -2;
INSERT INTO t SELECT 3, REPEAT('a', 7000), -3;
INSERT INTO t SELECT 4, REPEAT('a', 7000), -4;