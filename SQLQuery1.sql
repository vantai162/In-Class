CREATE DATABASE QuanLyBanHang
USE QuanLyBanHang
GO
CREATE TABLE KHACHHANG
(
		MAKH	char(4),
		HOTEN	varchar(40),
		DCHI	varchar(50),
		SODT	varchar(20),
		NGSINH	smalldatetime,
		NGDK	smalldatetime,
		DOANHSO	money,
		PRIMARY KEY (MAKH),
)

CREATE TABLE NHANVIEN
(
		MANV	char(4),
		HOTEN	varchar(40),
		SODT	varchar(20),
		NGVL	smalldatetime,
		PRIMARY KEY (MANV),
)

CREATE TABLE SANPHAM
(
		MASP	char(4),
		TENSP	varchar(40),
		DVT		varchar(20),
		NUOCSX	varchar(40),
		GIA		money,
		PRIMARY KEY (MASP),
)

CREATE TABLE HOADON
(
		SOHD	int,
		NGHD	smalldatetime,
		MAKH	char(4),
		MANV	char(4),
		TRIGIA	money,
		PRIMARY KEY (SOHD),
)

CREATE TABLE CTHD
(
		SOHD	int,
		MASP	char(4),
		SL		int,
		PRIMARY KEY (SOHD, MASP)
)
ALTER TABLE HOADON
ADD CONSTRAINT FK_MANV FOREIGN KEY (MANV) REFERENCES dbo.NHANVIEN(MANV);

ALTER TABLE HOADON
ADD CONSTRAINT FK_MAKH FOREIGN KEY (MAKH) REFERENCES dbo.KHACHHANG(MAKH);

ALTER TABLE CTHD
ADD CONSTRAINT FK_MASP FOREIGN KEY (MASP) REFERENCES dbo.SANPHAM(MASP);

ALTER TABLE CTHD
ADD CONSTRAINT FK_SOHD FOREIGN KEY (SOHD) REFERENCES dbo.HOADON(SOHD);

--QUAN LY HOC VU--

CREATE DATABASE QuanLyHocVu
USE QuanLyHocVu
GO
CREATE TABLE KHOA 
	(
		MAKHOA	varchar(4),
		TENKHOA	varchar(40),
		NGTLAP	smalldatetime,
		TRGKHOA	char(4),
		PRIMARY KEY (MAKHOA)
	)


CREATE TABLE MONHOC
	(
		MAMH	varchar(10),
		TENMH	varchar(40),
		TCLT	tinyint,
		TCTH	tinyint,
		MAKHOA varchar(4),
		PRIMARY KEY (MAMH)
	)

CREATE TABLE DIEUKIEN
	(
		MAMH			varchar(10),
		MAMH_TRUOC		varchar (10),
		PRIMARY KEY (MAMH,MAMH_TRUOC)
	)


CREATE TABLE GIAOVIEN
	(
		MAGV		char(4),
		HOTEN		varchar(40),
		HOCVI		varchar(10),
		HOCHAM		varchar(10),
		GIOITINH	varchar(3),
		NGSINH		smalldatetime,
		NGVL		smalldatetime,
		HESO		numeric(4,2),
		MUCLUONG	money,
		MAKHOA		varchar(4),
		PRIMARY KEY (MAGV)
	)


CREATE TABLE LOP
	(
		MALOP	char(3),
		TENLOP	varchar(40),
		TRGLOP	char(5),
		SISO	tinyint,
		MAGVCN	char(4),
		PRIMARY KEY (MALOP)
	)

CREATE TABLE HOCVIEN
	(
		MAHV		char(5),
		HO			varchar(40),
		TEN			varchar(10),
		NGSINH		smalldatetime,
		GIOITINH	varchar(3),
		NOISINH		varchar(40),
		MALOP		char (3),
		PRIMARY KEY (MAHV)
	)

CREATE TABLE GIANGDAY
	(
		MALOP	char(3),
		MAMH	varchar(10),
		MAGV	char(4),
		HOCKY	tinyint,
		NAM		smallint,
		TUNGAY	smalldatetime,
		DENNGAY	smalldatetime,
		PRIMARY KEY (MALOP,MAMH)
	)


CREATE TABLE KETQUATHI
	(
		MAHV	char(5),
		MAMH	varchar(10),
		LANTHI	tinyint,
		NGTHI	smalldatetime,
		DIEM	numeric(4,2),
		KQUA	varchar(10),
		PRIMARY KEY (MAHV,MAMH,LANTHI)
	)
USE QuanLyHocVu
GO
ALTER TABLE MONHOC
ADD CONSTRAINT FK_MAKHOA FOREIGN KEY (MAKHOA) REFERENCES dbo.KHOA(MAKHOA);

ALTER TABLE DIEUKIEN
ADD CONSTRAINT FK_MAMH FOREIGN KEY (MAMH) REFERENCES dbo.MONHOC(MAMH);

ALTER TABLE GIAOVIEN
ADD CONSTRAINT FK_MAKHOA_2 FOREIGN KEY (MAKHOA) REFERENCES dbo.KHOA(MAKHOA);

ALTER TABLE LOP
ADD CONSTRAINT FK_MAGVCN FOREIGN KEY (MAGVCN) REFERENCES dbo.GIAOVIEN(MAGV);

ALTER TABLE HOCVIEN
ADD CONSTRAINT FK_MALOP FOREIGN KEY (MALOP) REFERENCES dbo.LOP(MALOP);

ALTER TABLE GIANGDAY
ADD CONSTRAINT FK_MALOP_2 FOREIGN KEY (MALOP) REFERENCES dbo.LOP(MALOP);

ALTER TABLE GIANGDAY
ADD CONSTRAINT FK_MAMH_2 FOREIGN KEY (MAMH) REFERENCES dbo.MONHOC(MAMH);

ALTER TABLE GIANGDAY
ADD CONSTRAINT FK_MAGV FOREIGN KEY (MAGV) REFERENCES dbo.GIAOVIEN(MAGV);

ALTER TABLE KETQUATHI
ADD CONSTRAINT FK_MAHV FOREIGN KEY (MAHV) REFERENCES dbo.HOCVIEN(MAHV);

ALTER TABLE KETQUATHI
ADD CONSTRAINT FK_MAMH_3 FOREIGN KEY (MAMH) REFERENCES dbo.MONHOC(MAMH);

ALTER TABLE HOCVIEN
ADD GHICHU varchar(10);

ALTER TABLE HOCVIEN
ADD DIEMTB float;

ALTER TABLE HOCVIEN
ADD XEPLOAI varchar(4);
