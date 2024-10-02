USE QuanLyHocVu
GO

--3--
ALTER TABLE GIAOVIEN
ADD CONSTRAINT chk_gt
CHECK (GIOITINH IN ('Nam','Nu'));

ALTER TABLE HOCVIEN
ADD CONSTRAINT chk_gt_hv
CHECK (GIOITINH IN ('Nam','Nu'));

--4--
ALTER TABLE KETQUATHI
ADD CONSTRAINT chk_diem_thi CHECK (DIEM >=0 AND DIEM <=10)
UPDATE KETQUATHI
SET DIEM = ROUND(DIEM, 2);

--5--
CREATE TRIGGER trg_Update_KetQuaThi
ON dbo.KETQUATHI
FOR INSERT, UPDATE
AS
BEGIN
   
    UPDATE KT
    SET KQUA = CASE 
                    WHEN I.DIEM  >= 5 THEN 'Dat'
                    ELSE 'Khong dat'
               END
    FROM KETQUATHI KT
    INNER JOIN INSERTED I ON KT.MAHV = I.MAHV AND KT.MAMH = I.MAMH AND KT.LANTHI = I.LANTHI;
END;
GO

--6--
CREATE TRIGGER trg_Limit_LanThi
ON dbo.KETQUATHI
FOR INSERT
AS
BEGIN
    DECLARE @MAHV char(5);
    DECLARE @MAMH varchar(10);
    DECLARE @LanThiCount INT;


    SELECT @MAHV = MAHV, @MAMH = MAMH FROM INSERTED;

    
    SELECT @LanThiCount = COUNT(*)
    FROM KETQUATHI
    WHERE MAHV = @MAHV AND MAMH = @MAMH;

    
    IF @LanThiCount >= 3
    BEGIN
        RAISERROR('Hoc vien da thi mon nay 3 lan, khong duoc phep thi tiep.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

--7--
ALTER TABLE GIANGDAY
ADD CONSTRAINT chk_hoc_ky
CHECK (HOCKY >=1 AND HOCKY <=3);

--8--
ALTER TABLE GIAOVIEN
ADD CONSTRAINT chk_hoc_vi
CHECK (HOCVI IN ('CN','KS','TS','PTS','Ths'));
