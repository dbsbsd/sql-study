
-- ���̺� ������ ��������
-- ���̺� ������ �������� (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: ���̺��� ���� �ĺ� �÷��Դϴ�. (�ֿ� Ű)
-- UNIQUE: ������ ���� ���� �ϴ� �÷� (�ߺ��� ����)
-- NOT NULL: null�� ������� ����. (�ʼ���)
-- FOREIGN KEY: �����ϴ� ���̺��� PRIMARY KEY�� �����ϴ� �÷�
-- CHECK: ���ǵ� ���ĸ� ����ǵ��� ���.

-- �÷� ���� ���� ���� (�÷� ���𸶴� �������� ����)
CREATE TABLE dept2 (
    dept_no NUMBER(2) CONSTRAINT dept2_deptno_pk PRIMARY KEY,
    dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE,
    loca NUMBER(4) CONSTRAINT dept2_loca_locid_fk REFERENCES locations(location_id),
    dept_bonus NUMBER(10) CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

DROP TABLE dept2;

-- ���̺� ���� ���� ���� (��� �� ���� �� ���� ������ ���ϴ� ���)
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) CONSTRAINT dept_name_notnull NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1),
    
    CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no),
    CONSTRAINT dept2_deptname_uk UNIQUE(dept_name),
    CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id),
    CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

-- �ܷ� Ű(foreign_key)�� �θ����̺�(�������̺�)�� ���ٸ� INSERT �Ұ���
INSERT INTO dept2
VALUES(10, 'aa', 4000, 100000, 'M');

INSERT INTO dept2
VALUES(10, 'bb', 1900, 100000, 'M');

UPDATE dept2
SET loca = 4000
WHERE dept_no = 10; -- ����(�ܷ�Ű �������� ����)

-- ���� ������ ����
-- ���� ������ �߰�, ������ �����մϴ�. ������ �ȵ˴ϴ�.
-- �����Ϸ��� �����ϰ� ���ο� �������� �߰��ϼž� �մϴ�.

CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

-- pk �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept_no_pk PRIMARY KEY(dept_no);
-- fk �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_loca_locid_fk
FOREIGN KEY(loca) REFERENCES locations(location_id);
-- check �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0);
-- unique �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptname_uk UNIQUE(dept_name);
-- NOT NULL�� �� �������·� �����մϴ�.
ALTER TABLE dept2 MODIFY dept_bonus NUMBER(10) NOT NULL;

-- ���� ���� Ȯ��
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';

-- ���� ���� ���� (���� ���� �̸�����)
ALTER TABLE dept2 DROP CONSTRAINT dept_no_pk;

SELECT * FROM dept2;

// ���� 1
CREATE TABLE mem (
    m_name VARCHAR2(10) CONSTRAINT m_name_notnull NOT NULL,
    m_num NUMBER(2),
    reg_date VARCHAR(10) NOT NULL,
    gender VARCHAR2(1),
    loca NUMBER(4),

    CONSTRAINT mem_memnum_pk PRIMARY KEY(m_num),
    CONSTRAINT mem_regdate_uk UNIQUE(reg_date),
    CONSTRAINT mem_gender_ck CHECK(gender IN('M', 'F')),    
    CONSTRAINT mem_loca_loc_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id)
);

INSERT INTO mem
VALUES('AAA', 1, '2018-07-01', 'M', 1800);
INSERT INTO mem
VALUES('BBB', 2, '2018-07-02', 'F', 1900);
INSERT INTO mem
VALUES('CCC', 3, '2018-07-03', 'M', 2000);
INSERT INTO mem
VALUES('DDD', 4, TO_CHAR(sysdate, 'YYYY-MM-DD'), 'M', 2000);

// ���� 2
SELECT * FROM user_constraints
WHERE table_name = 'MEM';

SELECT * FROM mem;

SELECT
    m.m_name,
    m.m_num,
    loc.street_address,
    loc.location_id
FROM mem m
JOIN locations loc
ON m.loca = loc.location_id
ORDER BY m.m_num;

