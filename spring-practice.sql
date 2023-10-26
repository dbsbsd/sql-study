SELECT * FROM users;

SELECT
    user_name, user_phone1, user_phone2,
    user_email1, user_email2, addr_basic,
    addr_detail, addr_zip_num.
    f.bno,
    f.title,
    f.reg_date
FROM users u
LEFT JOIN freeboard f
ON u.user_id = f.writer
WHERE user_id = 'page1234'
ORDER BY  f.bno DESC;

CREATE TABLE tbl_reply (
    reply_no NUMBER PRIMARY KEY,
    reply_text VARCHAR2(1000) NOT NULL,
    reply_writer VARCHAR2(100) NOT NULL,
    reply_pw VARCHAR2(100) NOT NULL,
    reply_date DATE DEFAULT sysdate,
    bno NUMBER,
    update_date DATE DEFAULT NULL, 
    
    CONSTRAINT reply_bno_fk FOREIGN KEY(bno) REFERENCES freeboard(bno)
    ON DELETE CASCADE -- 참조하고 있는 부모값이 삭제될 때 자식의 값도 같이 삭제.  
);

CREATE SEQUENCE reply_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10000
    NOCYCLE
    NOCACHE;
    
SELECT * FROM tbl_reply;

-- SNS 게시판
CREATE TABLE snsboard(
    bno NUMBER PRIMARY KEY,
    writer VARCHAR2(50) NOT NULL,
    upload_path VARCHAR2(100),
    file_loca VARCHAR2(100),
    file_name VARCHAR2(100),
    file_real_name VARCHAR2(100),
    content VARCHAR2(4000),
    reg_date DATE DEFAULT sysdate
);

CREATE SEQUENCE snsboard_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 1000000
    NOCYCLE
    NOCACHE;
    
-- 좋아요 테이블
CREATE TABLE sns_like(
    lno NUMBER PRIMARY KEY,
    user_id VARCHAR2(50) NOT NULL,
    bno NUMBER NOT NULL
);

-- ON DELETE CASCADE
-- 외래 키(FK)를 참조할 때, 참조하는 데이터가 삭제되는 경우
-- 참조하고 있는 데이터도 함께 삭제를 진행하겠다.
ALTER TABLE sns_like ADD FOREIGN KEY(bno)
REFERENCES snsboard(bno)
ON DELETE CASCADE;

CREATE SEQUENCE sns_like_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100000
    NOCYCLE
    NOCACHE;

SELECT tbl2.*,
    (SELECT COUNT(*) FROM sns_like WHERE bno = tbl2.bno) AS like_cnt
FROM
    (
    SELECT ROWNUM AS rn, tbl.*
        FROM
        (
        SELECT * FROM snsboard
        ORDER BY bno DESC
        ) tbl
    ) tbl2
WHERE rn > 0
AND rn <= 3;

SELECT tbl2.*, NVL(b.like_cnt, 0) AS like_cnt
FROM
    (
    SELECT ROWNUM AS rn, tbl.*
        FROM
        (
        SELECT * FROM snsboard
        ORDER BY bno DESC
        ) tbl
    ) tbl2
LEFT JOIN
    (
    SELECT
        bno,
        COUNT(*) AS like_cnt
    FROM sns_like
    GROUP BY bno
    ) b
ON tbl2.bno = b.bno
WHERE rn >0
AND rn <= 3;

CREATE TABLE test_location (
    area1 VARCHAR2(50),
    area2 VARCHAR2(50),
    nx NUMBER,
    ny NUMBER,
    latitude NUMBER(20, 15),
    longitude NUMBER(20, 15)
);

SELECT nx, ny
FROM test_location
WHERE area1 LIKE '경기도'
AND area2 LIKE '%부천시%';
