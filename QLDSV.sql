use master
go
if exists(select name from sysdatabases where name='QLDSV')
drop Database QLDSV
go
Create Database QLDSV
go
use QLDSV
go

--==================TẠO CÁC BẢNG===================--
create table Lop
(
	MaLop nchar(10) primary key not null,
	TenLop nvarchar(30),
	TongSo int,
	MaKhoa nchar(10)
)
update Lop
set TongSo = (select count(masv)
from sinhvien
group by malop having malop=lop.malop)

create table SinhVien
(	
	MaSV nchar(10) primary key not null,
	TenSV nvarchar(30),
	NgaySinh datetime,
	GioiTinh nchar(3),
	QueQuan nvarchar(50),
	SDT int,
	Email nvarchar(50),
	MaLop nchar(10) not null
)
Create table DIEMHP
(
	MaSV nchar(10) not null,
	MaMH nchar(10) not null,
	MaHK nchar(10) not null,
	MaGV nchar(10) not null,
	Diem1 float,
	Diem2 float,
	primary key(MaSV,MaMH,MaHK)
)

create table GiaoVien
(
	MaGV nchar(10) not null primary key,
	TenGv nvarchar(30),
	MaKhoa nchar(10),
	Sdt int 
)

create table Khoa
(
	MaKhoa nchar(10) not null primary key,
	TenKhoa nvarchar(30),
	DiaChi nvarchar(30),
	SdtKhoa int,
	TongSoLop int
)
--tao cot tong so lop tang tu dong
update Khoa set TongSoLop = (select count(MaLop) 
from Lop group by MaKhoa 
having MaKhoa = Khoa.MaKhoa)

create table HocKy
(
	MaHK nchar(10) primary key not null,
	TenHK nvarchar(30),
	NamHoc int 
)
create table MonHoc
(
	MaMH nchar(10) primary key not null,
	TenMH nvarchar(30),
	SoTrinh int,
	
)
go
--===============TẠO CÁC KHÓA NGOẠI======================
alter table DIEMHP
add constraint FK_DIEMHP_SinhVien foreign key(MaSV)
References SinhVien(MaSV)

alter table DIEMHP
add constraint FK_DIEMHP_GiaoVien foreign key(MaGV)
references GiaoVien(MaGV)

alter table DIEMHP
add constraint FK_DIEMHP_MonHoc foreign key(MaMH)
references MonHoc(MaMH)

alter table DIEMHP
add constraint FK_DIEMHP_HocKy foreign key(MaHK)
references HocKy(MaHK)

alter table SinhVien 
add constraint FK_SinhVien_Lop foreign key(MaLop) 
references Lop(MaLop)

alter table Lop
add constraint FK_Lop_Khoa foreign key(MaKhoa)
references Khoa(MaKhoa)

alter table GiaoVien 
add constraint FK_GiaoVien_Khoa foreign key(makhoa)
references Khoa(makhoa) 

go

--================NHẬP DỮ LIỆU=========================

--Nhập Khoa
insert into Khoa(MaKhoa,TenKhoa,SdtKhoa,DiaChi)
values ('K001',N'Công Nghệ Thông Tin',639295,N'Tầng 12')
insert into Khoa(MaKhoa,TenKhoa,SdtKhoa,DiaChi)
values ('K002',N'Điện tử',639295,N'Tầng 13')
insert into Khoa(MaKhoa,TenKhoa,SdtKhoa,DiaChi)
values ('K003',N'Xe Máy',639295,N'Tầng 14')
insert into Khoa(MaKhoa,TenKhoa,SdtKhoa,DiaChi)
values ('K004',N'Công trình',639295,N'Tầng 12')
insert into Khoa(MaKhoa,TenKhoa,SdtKhoa,DiaChi)
values ('K005',N'Cơ bản',639295,N'Tầng 15')


--Nhập giáo viên
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV01',N'Đỗ Thị Mai Hường','K001',0987645321)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV02',N'Nguyễn Văn An','K001',0987782121)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV04',N'Lê Thị Tuyết','K001',0935689944)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV07',N'Vũ Thị Hiền','K001',0985846641)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV05',N'Bùi Thị Nga','K001',0982545456)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV10',N'Lê Thị Trâm','K001',0935689944)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV11',N'Bùi Thị Ánh','K001',0982545456)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV19',N'Vũ Ngọc Tân','K001',0985846641)

insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV06',N'Phạm Hồng Ngân','K002',0915545456)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV12',N'Phạm Hồng Xuyến','K002',0915545456)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV18',N'Phạm Thị Loan','K002',0915545456)

insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV03',N'Nguyễn Văn Công','K003',0936454321)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV09',N'Đỗ Thị Mai','K003',0977556545)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV15',N'Đỗ Văn Luận','K003',0977556545)

insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV08',N'Đặng Thị Ngọc Tuyết','K004',0946568523)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV14',N'Đặng Thị Ngọc','K004',0946568523)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV20',N'Đặng Văn Sơn','K004',0946568523)

insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV13',N'Vũ Thị Hồng','K005',0985846641)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV16',N'Lê Văn Tâm','K005',0935689944)
insert into GiaoVien(MaGV,TenGv,MaKhoa,Sdt)
values('GV17',N'Bùi Thị Kim Ngân','K005',0982545456)


--nhập thông tin bang lop
insert into Lop(MaLop, TenLop, MaKhoa)
values ('vb2k5dtvt',N'Điện Tử Viễn Thông k5','K002')
insert into Lop(MaLop, TenLop, MaKhoa)
values ('vb2k5cntt',N'Công Nghệ Thông Tin k5','K001')
insert into Lop(MaLop, TenLop, MaKhoa)
values ('vb2k5attt',N'An Toàn Thông Tin k5','K005')
insert into Lop(MaLop, TenLop, MaKhoa)
values ('vb2k5xqs',N'Xe Quân Sự k5','K003')
insert into Lop(MaLop, TenLop, MaKhoa)
values ('vb2k5ctqp',N'Công Trình Quốc Phòng','K004')

--nhập thông tin sinh viên
--a)Nhập thông tin lop CNTT

insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5cntt01',N'Nguyễn Nguyễn Hoàng Anh','1987/1/1',N'Nha Trang', N'Nam','0987263541',N'Hoanganh87k5@gmail.com','vb2k5cntt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5cntt02',N'Trần Thị Ánh','1990/6/12',N'Hà Tĩnh', N'Nữ','0987263541',N'Anh_Mai90k5@gmail.com','vb2k5cntt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5cntt03',N'Trương Quốc Bảo','1990/5/6',N'Cà Mau', N'Nam','0987263541',N'Bao90k5@gmail.com','vb2k5cntt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5cntt04',N'Vũ Đức Nam','1990/9/12',N'Ninh Bình', N'Nam','0987263541',N'Nam90k5@gmail.com','vb2k5cntt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5cntt05',N'Nguyễn Văn Linh','1991/9/16',N'Ninh Bình', N'Nam','0987263541',N'Long91k5@gmail.com','vb2k5cntt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5cntt06',N'Lâm Anh Sơn','1990/2/9',N'Nha Trang', N'Nam','0987263541',N'Son90k5@gmail.com','vb2k5cntt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5cntt07',N'Nguyễn Thị Tâm','1979/8/16',N'Nha Trang', N'Nữ','0987263541',N'Tam79k5@gmail.com','vb2k5cntt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5cntt08',N'Lê Song Thìn','1988/6/24',N'Nha Trang', N'Nam','0987263541',N'Thin88k5@gmail.com','vb2k5cntt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5cntt09',N'Trần Cao Trung','1990/9/26',N'Hà Tây', N'Nam','0987263541',N'Trung90k5@gmail.com','vb2k5cntt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5cntt10',N'Đào Hữu Tuấn','1990/3/27',N'Hà Tây', N'Nam','0987263541',N'Tuan90k5@gmail.com','vb2k5cntt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5cntt11',N'Trần Huy Vinh','1987/6/10',N'Hà Tĩnh', N'Nam','0987263541',N'Vinh87k5@gmail.com','vb2k5cntt')
--b)Nhập điểm lớp dtvt
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5dtvt01',N'Phan Văn Anh','1991/5/4',N'Hà Tây', N'Nam','01935465599',N'AnhHung91k5@gmail.com','vb2k5dtvt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5dtvt02',N'Nguyễn Quốc Đông','1984/7/1',N'Ninh Bình', N'Nam','01935465599',N'Dong84k5@gmail.com','vb2k5dtvt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5dtvt03',N'Nguyễn Thị Hoài','1989/7/8',N'TP Vinh', N'Nữ','01935465599',N'HoaiBao89k5@gmail.com','vb2k5dtvt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5dtvt04',N'Trần Văn Phú','1985/9/1',N'Hà Tĩnh', N'Nam','01935465599',N'Phu85k5@gmail.com','vb2k5dtvt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5dtvt05',N'Lê Thị Hường','1992/7/10',N'Thái Bình', N'Nữ','01935465599',N'Lehuong92k5@gmail.com','vb2k5dtvt')
--ATTT
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5attt01',N'Nguyễn Thanh Ngữ','1985/6/13',N'Hà Tĩnh', N'Nam','01935465599',N'Ngu84k5@gmail.com','vb2k5attt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5attt02',N'Nguyễn Thị Hường','1985/5/10',N'Đà Nẵng', N'Nữ','01935465599',N'Huong85k5@gmail.com','vb2k5attt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5attt03',N'Nguyễn Thị Hoa','1995/5/10',N'Quảng Bình', N'Nữ','01935465599',N'Hoa95k5@gmail.com','vb2k5attt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5attt04',N'Bùi Hữu Phúc','1990/8/6',N'Nghệ AN', N'Nam','01935465599',N'Phuc90k5@gmail.com','vb2k5attt')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5attt05',N'Bùi Khắc Việt','1989/10/12',N'Đà Nẵng', N'Nam','01935465599',N'viet89k5@gmail.com','vb2k5attt')

--XQS
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5xqs01',N'Nguyễn Quốc Dũng','1987/8/9',N'Ninh Bình', N'Nam','01935465599',N'Dung87xqsk5@gmail.com','vb2k5xqs')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5xqs02',N'Nguyễn Văn Phương','1984/11/3',N'Nam Định', N'Nam','01935465599',N'Phuong84xqsk5@gmail.com','vb2k5xqs')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5xqs03',N'Nguyễn Nguyễn Thị Hòa','1993/3/26',N'TP HCM', N'Nữ','01935465599',N'Hoaxqsk5@gmail.com','vb2k5xqs')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5xqs04',N'Nguyễn Thị Hương Trâm','1994/10/14',N'Nam Định', N'Nam','01935465599',N'huongtram94xqsk5@gmail.com','vb2k5xqs')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5xqs05',N'Trần Thị Hải Yến','1994/1/1',N'Thanh Hóa', N'Nam','01935465599',N'Haiyen94xqsk5@gmail.com','vb2k5xqs')

--CTQP
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5ctqp01',N'Trần Văn Chính','1989/4/6',N'Thanh Hóa', N'Nam','01935465599',N'chinh89k5@gmail.com','vb2k5ctqp')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5ctqp02',N'Hoàng Hải Linh','1993/5/6',N'Nghệ An', N'Nam','01935465599',N'linh93k5@gmail.com','vb2k5ctqp')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5ctqp03',N'Nguyễn Trọng Đức','1990/12/11',N'Nghệ An', N'Nam','01935465599',N'duc88k5@gmail.com','vb2k5ctqp')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5ctqp04',N'Trần Trùng Phùng','1991/5/6',N'Nghệ An', N'Nam','01935465599',N'phung88k5@gmail.com','vb2k5ctqp')
insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
values ('k5ctqp05',N'Trần Thanh Phong','1995/5/16',N'HÀ Tĩnh', N'Nam','01935465599',N'ThanhPhong88k5@gmail.com','vb2k5ctqp')

--nhập hoc kỳ
insert into HocKy(MaHK,TenHK,NamHoc)
values ('v2k5I',N'Học kỳ 1',2015)
insert into HocKy(MaHK,TenHK,NamHoc)
values ('v2k5II',N'Học kỳ 2',2016)
insert into HocKy(MaHK,TenHK,NamHoc)
values ('v2k5III',N'Học kỳ 3',2016)
insert into HocKy(MaHK,TenHK,NamHoc)
values ('v2k5IV',N'Học kỳ 4',2017)
insert into HocKy(MaHK,TenHK,NamHoc)
values ('v2k5V',N'Học kỳ 5',2017)


--Nhập môn học
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('72AV',N'Tiếng Anh CN',3)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('03BB',N'Nhập Môn CSDL',4)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('77CF',N'Lập Trình Hướng Đối Tượng',3)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('02AL',N'Automat',3)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('02BO',N'Xữ lý THS',4)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('02BJ',N'Lý thuyết HĐH',3)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('73BO',N'Lý thuyết MMT',3)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('73AZ',N'Mã Hóa Thông Tin',3)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('73AJ',N'Lập trình Dosnet',3)

insert into MonHoc(MaMH,TenMH,SoTrinh)
values('77CX',N'Ngôn ngữ lập trình 2',3)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('03BQ',N'Phân tích và thiết kết',4)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('77BQ',N'Xây dựng bảo trì hệ thống',3)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('77AF',N'Công nghệ phần mềm',3)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('01BR',N'Toán chuyên đề',3)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('31AW',N'Kỹ thuật VXL',3)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('30AV',N'Do lường điện',3)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('04CK',N'Cấu trúc máy tính',3)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('31AE',N'Thiết kế logic số',4)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('32BR',N'Kỹ thuật SCT',3)
insert into MonHoc(MaMH,TenMH,SoTrinh)
values('32BO',N'Truyền sóng Anten',3)


--Nhập điểm

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV, Diem1,Diem2)
values('k5cntt01','72AV','v2k5II','GV01',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt01','03BB','v2k5II','GV02',7.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt01','77CF','v2k5II','GV03',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt01','02AL','v2k5II','GV04',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt01','02BO','v2k5II','GV05',8.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt01','02BJ','v2k5II','GV09',8.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt01','73BO','v2k5II','GV07',8.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt01','73AZ','v2k5II','GV07',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt01','73AJ','v2k5II','GV08',9.5,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt02','72AV','v2k5II','GV01',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt02','03BB','v2k5II','GV02',7.7,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt02','77CF','v2k5II','GV03',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt02','02AL','v2k5II','GV04',8.1,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt02','02BO','v2k5II','GV05',7.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt02','02BJ','v2k5II','GV09',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt02','73BO','v2k5II','GV07',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt02','73AZ','v2k5II','GV07',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt02','73AJ','v2k5II','GV08',8.5,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt03','72AV','v2k5II','GV01',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt03','03BB','v2k5II','GV02',8.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt03','77CF','v2k5II','GV03',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt03','02AL','v2k5II','GV04',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt03','02BO','v2k5II','GV05',7.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt03','02BJ','v2k5II','GV09',6.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt03','73BO','v2k5II','GV07',8.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt03','73AZ','v2k5II','GV07',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt03','73AJ','v2k5II','GV08',9.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt04','72AV','v2k5II','GV01',9.2,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt04','03BB','v2k5II','GV02',7.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt04','77CF','v2k5II','GV03',6.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt04','02AL','v2k5II','GV04',7.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt04','02BO','v2k5II','GV05',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt04','02BJ','v2k5II','GV09',8.4,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt04','73BO','v2k5II','GV07',7.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt04','73AZ','v2k5II','GV07',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt04','73AJ','v2k5II','GV08',8.5,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt05','72AV','v2k5II','GV01',9.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt05','03BB','v2k5II','GV02',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt05','77CF','v2k5II','GV03',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt05','02AL','v2k5II','GV04',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt05','02BO','v2k5II','GV05',7.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt05','02BJ','v2k5II','GV09',8.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt05','73BO','v2k5II','GV07',6.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt05','73AZ','v2k5II','GV07',8.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt05','73AJ','v2k5II','GV08',7.5,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt06','72AV','v2k5II','GV01',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt06','03BB','v2k5II','GV02',8.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt06','77CF','v2k5II','GV03',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt06','02AL','v2k5II','GV04',9.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt06','02BO','v2k5II','GV05',9.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt06','02BJ','v2k5II','GV09',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt06','73BO','v2k5II','GV07',7.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt06','73AZ','v2k5II','GV07',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt06','73AJ','v2k5II','GV08',6.9,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt07','72AV','v2k5II','GV01',8.4,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt07','03BB','v2k5II','GV02',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt07','77CF','v2k5II','GV03',7.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt07','02AL','v2k5II','GV04',9.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt07','02BO','v2k5II','GV05',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt07','02BJ','v2k5II','GV09',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt07','73BO','v2k5II','GV07',6.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt07','73AZ','v2k5II','GV07',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt07','73AJ','v2k5II','GV08',3.5,7.4)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt08','72AV','v2k5II','GV01',8.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt08','03BB','v2k5II','GV02',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt08','77CF','v2k5II','GV03',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt08','02AL','v2k5II','GV04',3.8,7.6)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt08','02BO','v2k5II','GV05',9.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt08','02BJ','v2k5II','GV09',6.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt08','73BO','v2k5II','GV07',7.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt08','73AZ','v2k5II','GV07',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt08','73AJ','v2k5II','GV08',8.5,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt09','72AV','v2k5II','GV01',8.1,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt09','03BB','v2k5II','GV02',9.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt09','77CF','v2k5II','GV03',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt09','02AL','v2k5II','GV04',9.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt09','02BO','v2k5II','GV05',7.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt09','02BJ','v2k5II','GV09',8.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt09','73BO','v2k5II','GV07',8.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt09','73AZ','v2k5II','GV07',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt09','73AJ','v2k5II','GV08',6.5,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt10','72AV','v2k5II','GV01',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt10','03BB','v2k5II','GV02',7.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt10','77CF','v2k5II','GV03',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt10','02AL','v2k5II','GV04',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt10','02BO','v2k5II','GV05',8.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt10','02BJ','v2k5II','GV09',8.4,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt10','73BO','v2k5II','GV07',8.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt10','73AZ','v2k5II','GV07',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt10','73AJ','v2k5II','GV08',9.5,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt11','72AV','v2k5II','GV01',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt11','03BB','v2k5II','GV02',9.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt11','77CF','v2k5II','GV03',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt11','02AL','v2k5II','GV04',7.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt11','02BO','v2k5II','GV05',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt11','02BJ','v2k5II','GV09',8.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt11','73BO','v2k5II','GV07',8.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt11','73AZ','v2k5II','GV07',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5cntt11','73AJ','v2k5II','GV08',9.3,0)


--ATTT
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt01','72AV','v2k5II','GV01',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt01','77AF','v2k5II','GV15',7.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt01','32BR','v2k5II','GV11',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt01','02AL','v2k5II','GV04',3.7,7.9)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt01','01BR','v2k5II','GV12',8.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt01','30AV','v2k5II','GV13',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt01','73BO','v2k5II','GV07',8.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt01','04CK','v2k5II','GV14',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt01','73AJ','v2k5II','GV08',8.5,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt02','72AV','v2k5II','GV01',7.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt02','77AF','v2k5II','GV15',7.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt02','32BR','v2k5II','GV11',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt02','02AL','v2k5II','GV04',9.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt02','01BR','v2k5II','GV12',8.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt02','30AV','v2k5II','GV13',8.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt02','73BO','v2k5II','GV07',8.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt02','04CK','v2k5II','GV14',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt02','73AJ','v2k5II','GV08',8.5,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt03','72AV','v2k5II','GV01',7.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt03','77AF','v2k5II','GV15',7.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt03','32BR','v2k5II','GV11',6.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt03','02AL','v2k5II','GV04',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt03','01BR','v2k5II','GV12',8.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt03','30AV','v2k5II','GV13',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt03','73BO','v2k5II','GV07',8.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt03','04CK','v2k5II','GV14',8.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt03','73AJ','v2k5II','GV08',8.5,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt04','72AV','v2k5II','GV01',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt04','77AF','v2k5II','GV15',7.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt04','32BR','v2k5II','GV11',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt04','02AL','v2k5II','GV04',7.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt04','01BR','v2k5II','GV12',8.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt04','30AV','v2k5II','GV13',6.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt04','73BO','v2k5II','GV07',8.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt04','04CK','v2k5II','GV14',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt04','73AJ','v2k5II','GV08',8.5,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt05','72AV','v2k5II','GV01',6.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt05','77AF','v2k5II','GV15',8.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt05','32BR','v2k5II','GV11',8.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt05','02AL','v2k5II','GV04',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt05','01BR','v2k5II','GV12',9.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt05','30AV','v2k5II','GV13',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt05','73BO','v2k5II','GV07',7.5,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt05','04CK','v2k5II','GV14',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5attt05','73AJ','v2k5II','GV08',8.5,0)


--XQS
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs01','03BB','v2k5II','GV02',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs01','77AF','v2k5II','GV15',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs01','01BR','v2k5II','GV12',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs01','02BJ','v2k5II','GV09',8.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs01','32BR','v2k5II','GV11',8.3,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs02','03BB','v2k5II','GV02',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs02','77AF','v2k5II','GV15',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs02','01BR','v2k5II','GV12',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs02','02BJ','v2k5II','GV09',8.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs02','32BR','v2k5II','GV11',8.3,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs03','03BB','v2k5II','GV02',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs03','77AF','v2k5II','GV15',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs03','01BR','v2k5II','GV12',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs03','02BJ','v2k5II','GV09',8.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs03','32BR','v2k5II','GV11',8.3,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs04','03BB','v2k5II','GV02',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs04','77AF','v2k5II','GV15',2.5,7.8)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs04','01BR','v2k5II','GV12',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs04','02BJ','v2k5II','GV09',3.3,8.0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs04','32BR','v2k5II','GV11',8.3,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs05','03BB','v2k5II','GV02',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs05','77AF','v2k5II','GV15',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs05','01BR','v2k5II','GV12',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs05','02BJ','v2k5II','GV09',8.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5xqs05','32BR','v2k5II','GV11',8.3,0)

--DTVT
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt01','01BR','v2k5II','GV12',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt01','31AW','v2k5II','GV17',7.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt01','30AV','v2k5II','GV13',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt01','04CK','v2k5II','GV14',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt01','32BR','v2k5II','GV11',8.3,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt02','01BR','v2k5II','GV12',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt02','31AW','v2k5II','GV17',7.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt02','30AV','v2k5II','GV13',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt02','04CK','v2k5II','GV14',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt02','32BR','v2k5II','GV11',8.3,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt03','01BR','v2k5II','GV12',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt03','31AW','v2k5II','GV17',7.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt03','30AV','v2k5II','GV13',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt03','04CK','v2k5II','GV14',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt03','32BR','v2k5II','GV11',8.3,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt04','01BR','v2k5II','GV12',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt04','31AW','v2k5II','GV17',7.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt04','30AV','v2k5II','GV13',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt04','04CK','v2k5II','GV14',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt04','32BR','v2k5II','GV11',8.3,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)

values('k5dtvt05','01BR','v2k5II','GV12',8.2,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt05','31AW','v2k5II','GV17',7.8,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt05','30AV','v2k5II','GV13',7.6,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt05','04CK','v2k5II','GV14',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5dtvt05','32BR','v2k5II','GV11',8.3,0)


--CTQP
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp01','72AV','v2k5II','GV01',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp01','03BQ','v2k5II','GV16',8.4,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp01','77AF','v2k5II','GV15',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp01','31AW','v2k5II','GV17',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp01','02BO','v2k5II','GV05',8.6,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp02','72AV','v2k5II','GV01',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp02','03BQ','v2k5II','GV16',8.4,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp02','77AF','v2k5II','GV15',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp02','31AW','v2k5II','GV17',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp02','02BO','v2k5II','GV05',8.6,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp03','72AV','v2k5II','GV01',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp03','03BQ','v2k5II','GV16',8.4,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp03','77AF','v2k5II','GV15',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp03','31AW','v2k5II','GV17',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp03','02BO','v2k5II','GV05',8.6,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp04','72AV','v2k5II','GV01',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp04','03BQ','v2k5II','GV16',8.4,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp04','77AF','v2k5II','GV15',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp04','31AW','v2k5II','GV17',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp04','02BO','v2k5II','GV05',8.6,0)

insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp05','72AV','v2k5II','GV01',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp05','03BQ','v2k5II','GV16',8.4,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp05','77AF','v2k5II','GV15',7.9,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp05','31AW','v2k5II','GV17',8.0,0)
insert into DIEMHP(MaSV,MaMH,MaHK,MaGV,Diem1,Diem2)
values('k5ctqp05','02BO','v2k5II','GV05',8.6,0)
		sql	"select MaSV from SinhVien"	string




/*=============================== BAI TAP==================================*/


/* ========================= PHAN 1 TAO, SUA, XOA, CAP NHAP BANG=================*/

--BAI TAP--
use QLDSV
--===CHINH SUA TABLE===
--XOA table
drop table diemhp
--xoa table KHOA
alter table thannhan drop constraint FK_THANNHAN_NHANVIEN
alter table SinhVien drop FK_SinhVien_Lop
alter table GiaoVien drop FK_GiaoVien_Khoa
drop table khoa
-- them, xoa cot trong table ,xoa cac khóa ngoại trước
alter table Lop drop column MaKhoa
select * from Lop
-- sua cot
alter table Lop alter column TenLop nvarchar(31)
-- chen ban ghi
insert into Lop(MaLop,TenLop) values('vb2002','Van bang 2')
-- update ban ghi
update Lop set TongSo=3 where MaLop='vb2002'
-- xoa ban ghi
delete Lop where MaLop='vb2002'

/*để xóa 1 sinh viên trước hết ta kích chuột phải vao đường khóa ngoại của sinhvien voi deimhp 
trong diagram chọn properties sau đó tìm đến 'insert and update' để cài đặt*/

--=====================truy van tu 2 den 3 bang=======================================

-- sap xep sinh vien theo ma
select * from sinhvien order by masv asc
--theo ten va ngay sinh
select * from sinhvien order by tensv asc, NgaySinh desc

--tim kiem sinh vien theo ho, ten, ten dem
select * from sinhvien where tensv like N'trần%'
select * from sinhvien where tensv like N'%văn%'
select * from sinhvien where tensv like N'%anh'
--tim kiem sinh vien theo do tuoi
select * from sinhvien where year(getdate())-year(NgaySinh) between 20 and 21

--danh sach sinh vien theo lop
select s.masv, tensv
from sinhvien s, lop l
where s.MaLop=l.MaLop and l.malop='vb2k5cntt'

--truy xuat bang diem cua lop attt
select tensv, tenmh, diem
from sinhvien sv, diemhp d, monhoc mh
where sv.masv=d.masv and mh.mamh=d.mamh and mh.mamh='01BR' and sv.malop='vb2k5dtvt'

--cho biet lop 'cong nghhe thong tin' hoc nhung mon gi
select distinct mh.mamh, tenmh
from diemhp d, monhoc mh, sinhvien sv
where d.mamh=mh.mamh and malop='vb2k5cntt' and sv.masv=d.masv

--tao bang co truong tang tu dong
create table sv
(
	masv int identity(100,1) primary key,
	tensv nvarchar(50),

)
insert into sv(tensv)
values('tran van quang')
select * from sv


--them 1 truong tong so sinh vien trong bang lop
update lop
set TongSo = (select count(masv)
from sinhvien
group by malop having malop=lop.malop)

select STT = (select count(masv)
from sinhvien), MaSV, TenSV, GioiTinh, NgaySinh, MaLop from SinhVien

select tenlop, tongso from lop
select MaLop from Lop
--
select dense_rank() over (order by malop) --STT, tensv, ngaysinh, quequan, malop
from sinhvien

select row_number() over (partition by malop order by (select 1)) STT, 
					tensv, ngaysinh, quequan, malop
from sinhvien


--cau 2
--A
--cho biết sinh vien nào có điểm cao nhất môn 'Nhập Môn CSDL'
select tensv, malop, tenmh, lanthi, diem
from sinhvien s, monhoc m, diemhp d
where s.masv=d.masv and m.mamh=d.mamh
and diem>=(select max(diem) from diemhp d, monhoc m where d.mamh=m.mamh and tenmh=N'Nhập Môn CSDL')

--cho biết sinh vien nào có điểm cao nhất môn 'Nhập Môn CSDL' cua lop cntt
select tensv, malop, tenmh, lanthi, diem
from sinhvien s, monhoc m, diemhp d
where s.masv=d.masv and m.mamh=d.mamh and malop='vb2k5attt'
and diem>=(select max(diem) 
			from diemhp d, monhoc m, sinhvien sv 
			where d.mamh=m.mamh and sv.masv=d.masv and malop='vb2k5attt' and tenmh=N'Toán chuyên đề')

/*  Cho biet diem trung binh, diem lon nhat, diem nho nhat lan thi thu nhat cua tung sinh vien */
/* Thong tin gom: TENSV,TENKHOA,DIEMTB */
select sv.tensv, l.tenlop,avg(DIEM) as [DIEM TB], max(DIEM) as [DIEM LON NHAT], min(DIEM)as [DIEM NHO NHAT]
    from sinhvien sv, diemhp d, lop l
    where sv.masv=d.masv and l.malop=sv.malop
    group by sv.tensv, l.tenlop

--cho biết sinh viên có độ tuổi lớn nhất của lớp vb2k5cntt
select tensv, ngaysinh, gioitinh
from sinhvien
where ngaysinh=(select min(ngaysinh)from sinhvien where malop='vb2k5cntt')

--cho biết sinh viên của từng khoa
select MaKhoa, 'tong so sinh vien' = sum(Tongso)
from Lop
group by makhoa

select k.makhoa, k.tenkhoa, 'so sinh vien'=count(s.masv)
from khoa k, sinhvien s, lop l
where k.makhoa=l.makhoa and l.malop=s.malop
group by k.makhoa, k.tenkhoa

--cho biet so sinh vien nam cua tung khoa
select k.makhoa, k.tenkhoa, 'so sinh vien'=count(s.masv)
from khoa k, sinhvien s, lop l
where k.makhoa=l.makhoa and l.malop=s.malop and GioiTinh='Nam'
group by k.makhoa, k.tenkhoa


-- tong so sinh vien cua tung lop
select l.malop,tenlop, count(masv) 
from lop l,sinhvien sv
where l.malop=sv.malop
group by l.malop,tenlop

--cho biet khoa dong sinh vien nhat
select tenkhoa, k.makhoa
from khoa k, lop l, sinhvien s
where k.makhoa=l.makhoa and l.malop=s.malop
group by tenkhoa, k.makhoa
having count(masv)>=all (select count(masv) from sinhvien group by malop)

--lop dong sinh vien nhat
select tenlop, 'tong so sinh vien' = count(masv)
from sinhvien sv, lop l
where sv.malop=l.malop
group by tenlop
having count(masv)>=all(select count(masv) from sinhvien group by malop)

--cho biet mon nao sinh vien thi rot lan 1 nhieu nhat
select mamh, 'tong so sv thi rot'=count(masv)
from diemhp
where lanthi=2
group by mamh
having count(masv)>=all(select count(masv) from diemhp where lanthi =2 group by mamh)

--cho biet sinh vien dat diem cao nhat trong tung mon
select masv, d.mamh,diem
from diemhp d, (select distinct mamh, max(diem) maxdiem from diemhp group by mamh) a
where a.mamh=d.mamh and diem=a.maxdiem

--cho biet nhung sinh vien khong rot mon nao
select distinct tensv
from diemhp d,sinhvien sv
where d.masv=sv.masv and lanthi>=2 and diem>=5



--================MAX MIN, COUNT, SUM AVG================

--Tong so sv cua truong
select 'Tổng sinh viên'=count(masv) from sinhvien

--tong so sinh vien nữ
select 'tổng so sv'=count(masv), 
		'sv nữ'=(select count(masv) from sinhvien where GioiTinh='nữ')
from sinhvien

--sinh vien cua tung lop
select malop, 'số sinh vien'=count(masv)
from sinhvien
group by malop

--so luong sinh vien cua tung mon hoc
select tenmh, count(distinct masv)
from  monhoc m,diemhp d
where d.mamh=m.mamh
group by tenmh

--so mon hoc ma sinh vien da hoc
select 'số môn đã học'=count(distinct mamh) from diemhp

--những môn có hơn 10 sinh viên dự thi
select 'mã môn học'= mamh, 'số sv dự thi'=count(masv)
from diemhp
group by mamh
having count(masv)>10

--nhung sinh vien thi lai lan 1
select tensv,tenmh, diem
from sinhvien s, diemhp d, monhoc m
where s.masv=d.masv and d.mamh=m.mamh and lanthi>1

--cho biết số sinh viên đạt Gioi của tưng môn
select tenmh, 'khá'=count(masv)
from diemhp d, monhoc m
where d.mamh=m.mamh and diem>8 and lanthi=1
group by tenmh


--================viet thu tuc ham======================================

--A. them xoa
create procedure themsv(@Ma_SV nchar(10), @Ten_SV nvarchar(50), @Ngay_Sinh datetime, @Que_Quan nvarchar(50), 
						@Gioi_Tinh nchar(3), @SDT_sv int,@Email_sv nvarchar(50),@Ma_Lop nchar(10))
as
begin	
	insert into SinhVien(MaSV, TenSV, NgaySinh, QueQuan, GioiTinh, SDT,Email,MaLop)
	values (@Ma_SV, @Ten_SV, @Ngay_Sinh,@Que_Quan, @Gioi_Tinh , @SDT_sv,@Email_sv, @Ma_Lop)
end

themsv 'k5xqs06',N'Nguyễn Chí Vịnh','1987/8/9',N'Ninh Bình', N'Nam','01935465599',N'chivinh87xqsk5@gmail.com','vb2k5xqs'

create procedure xoasv(@ma nchar(10))
as
begin
	delete diemhp where masv=@ma
	delete sinhvien where masv=@ma
end
xoasv 'k5xqs06'



--B truy van thong ke du lieu

--thong tin toan bo giao vien cua lop
create procedure xemgiaovien(@ma_lop nchar(10))
as
begin
	select tengv
	from giaovien gv, khoa k, lop l
	where gv.makhoa=k.makhoa and l.makhoa=k.makhoa and malop=@ma_lop
end
xemgiaovien 'vb2k5cntt'

--xem danh sach sinh vien cua lop
create procedure danhsachsv_lop(@ma nchar(10))
as
begin
	select sv.masv, tensv, tenlop, ngaysinh, quequan
	from sinhvien sv, lop l
	where sv.malop=l.malop and l.malop=@ma
end
danhsachsv_lop 'vb2k5attt'

--xem danh sach sinh vien cua khoa
create procedure danhsachsv_khoa(@ma nchar(10))
as
begin
	select sv.masv, tensv, tenlop, ngaysinh, quequan
	from sinhvien sv, lop l, khoa k
	where sv.malop=l.malop and l.makhoa=k.makhoa and k.makhoa=@ma
end
drop procedure danhsachsv_khoa
danhsachsv_khoa 'K001'

--xem toan bo mon hoc cua lop
create procedure lop_mon(@ma nchar(10))
as
begin
	select distinct malop,mh.mamh, tenmh
	from diemhp d, monhoc mh, sinhvien sv
	where d.mamh=mh.mamh and malop=@ma and sv.masv=d.masv
end
lop_mon 'vb2k5ctqp'

--xem ket qua cua lop theo ma mon hoc
create procedure diem_mamon(@ma_lop nchar(10),@ma_mon nchar(10))
as
begin
	select tensv, tenmh, diem
	from sinhvien sv, diemhp d, monhoc mh
	where sv.masv=d.masv and mh.mamh=d.mamh and mh.mamh=@ma_mon and sv.malop=@ma_lop
end
diem_mamon 'vb2k5cntt', '01SS'

--xem ket qua cua lop theo ten mon hoc
create procedure diem_tenmonhoc(@ma_lop nchar(10),@tenmonhoc nvarchar(50))
as
begin
	select tensv, tenmh, diem1, diem2
	from sinhvien sv, diemhp d, monhoc mh
	where sv.masv=d.masv and mh.mamh=d.mamh and mh.tenmh=@tenmonhoc and sv.malop=@ma_lop
enddiem_tenmonhoc 'vb2k5cntt', N'Automat'

select MaLop from Lop

--tao 1 mon hoc moi cua lop co ma nao do, cho tat ca sinh vien cua lop do tham gia

create procedure themmonhoc(@ma_mh nchar(10),@Ten_mh nvarchar(50), @sotrinh int, 
							@ma_lop nchar(10), @mahocky nchar(10),@magiaovien nchar(10))
as
begin
	insert into monhoc(mamh,tenmh,sotrinh)
	values(@Ma_mh,@Ten_mh,@sotrinh)
	insert diemhp(Masv,mamh,mahk,magv,diem,lanthi)
	select sv.masv, @ma_mh, @mahocky, @magiaovien, null, null
	from sinhvien sv
	where sv.malop=@ma_lop
end
themmonhoc '01CQ',N'Cấu trúc giải thuật','3','vb2k5cntt','v2k5I','GV19'

--tao 1 mon hoc moi cua lop co ten nao do, cho tat ca sinh vien cua lop do tham gia

create procedure themmonhoc_ten(@ma_mh nchar(10),@Ten_mh nvarchar(50), @sotrinh int, 
							@ten_lop nvarchar(50), @mahocky nchar(10),@magiaovien nchar(10))
as
begin
	insert into monhoc(mamh,tenmh,sotrinh)
	values(@Ma_mh,@Ten_mh,@sotrinh)
	insert diemhp(Masv,mamh,mahk,magv,diem,lanthi)
	select sv.masv, @ma_mh, @mahocky, @magiaovien, null, null
	from sinhvien sv
	where sv.malop=(select malop from lop where tenlop=@ten_lop)
end

themmonhoc_ten '01SS',N'Tin học cơ bản','3',N'Công Nghệ Thông Tin k5','v2k5I','GV19'

delete from monhoc where mamh='01CQ'
drop procedure themmonhoc

--diem mon csdl lon nhat theo tung lop
select SinhVien.MaLop,TenLop,max(DIEMHP.Diem)
from (MonHoc inner join DIEMHP on MonHoc.MaMH=DIEMHP.MaMH)inner join SinhVien on DIEMHP.MaSV=SinhVien.MaSV,Lop
where MonHoc.TenMH=N'NH?p Môn CSDL' and Lop.MaLop=SinhVien.MaLop	
group by SinhVien.MaLop,tenlop

--các l?p thi môn csdl
select l.malop,TenLop
from SinhVien s,Lop l,DIEMHP d,MonHoc m
where s.MaLop=l.MaLop and s.MaSV=d.MaSV and m.MaMH=d.MaMH and m.TenMH=N'Nh' 
group by l.MaLop,TenLop

-- dua ra các sinh viên có di?m môn csdl l?n nh?t theo t?ng l?p
select *
from sinhvien s1 inner join (select SinhVien.MaLop,TenLop,max(DIEMHP.Diem) as diemcaonhat
							from (MonHoc inner join DIEMHP on MonHoc.MaMH=DIEMHP.MaMH)inner join SinhVien on DIEMHP.MaSV=SinhVien.MaSV,Lop
							where MonHoc.TenMH=N'NH?p Môn CSDL' and Lop.MaLop=SinhVien.MaLop	
							group by SinhVien.MaLop,tenlop) s2 on s2.MaLop=s1.MaLop ,DIEMHP d
where s1.MaSV =d.MaSV and d.Diem = s2.diemcaonhat




Create table DIEMHP1
(
	MaSV nchar(10) not null,
	MaMH nchar(10) not null,
	MaHK nchar(10) not null,
	MaGV nchar(10) not null,
	lanthi int,
	Diem float,
	primary key(MaSV,MaMH,MaHK)
)
alter table diemhp1 add constraint fk_diemhp1_sinhvien foreign key(masv) references sinhvien(masv)
alter table diemhp1 add constraint fk_diemhp1_monhoc foreign key(mamh) references monhoc(mamh)
alter table diemhp1 add constraint fk_diemhp1_hocky foreign key(mahk) references hocky(mahk)


alter table sinhvien add DiemTB float
update sinhvien set diemtb=(select sum(diem*sotrinh)/sum(sotrinh) 
							from diemhp dhp, monhoc mh, sinhvien sv
							where sv.masv=dhp.masv and dhp.mamh=mh.mamh)

select distinct GioiTinh from sinhvien 

select Lop.MaLop, TenLop, SySo=(select count(masv)from sinhvien
group by malop having malop=lop.malop)
from Lop, SinhVien
where Lop.MaKhoa=SinhVien.MaLop

insert into Lop(MaLop, TenLop, MaKhoa) values ('112', N'456','K001') 


,cbMaLop.SelectedValue.ToString().Trim(),
cbTenLop.SelectedValue.ToString().Trim(),cbMaKhoa.SelectedValue.ToString().Trim()

select MaKhoa, TenKhoa, DiaChi, SdtKhoa, tongsolop from Khoa

update Khoa set TongSoLop = (select count(MaLop) from Lop group by MaKhoa having MaKhoa = Khoa.MaKhoa)
alter table Khoa alter column TongSo int

select MaLop from Lop
select MaMH from MonHoc
select MaHK from HocKy
select MaSV, MaMH, MaHK, Diem1, Diem2 from DiemHP

update Khoa set TongSoLop = (select count(MaLop) 
from Lop group by MaKhoa 
having MaKhoa = Khoa.MaKhoa)

		insert into DiemHP(MaSV, MaMH, MaHK, MaGV, Diem1, Diem2) values ('10101', '01BR','v2k5I','GV04','8.4','0')

select tenmh from sinhvien sv, monhoc mh, diemhp where sv.masv=diemhp.masv and diemhp.mamh=mh.mamh

		select distinct tenmh 
		from diemhp d, monhoc mh, sinhvien sv, lop 
		where d.mamh = mh.mamh and Lop.tenLop = N'Công Nghệ Thông Tin k5' and sv.masv = d.masv and lop.malop=sv.malop

select tenmh from monhoc

select tensv, tenmh, diem1, diem2
from sinhvien sv, diemhp d, monhoc mh, lop
where lop.malop = sv.malop and sv.masv = d.masv and mh.mamh = d.mamh and mh.tenmh = N'Mã Hóa Thông Tin' and lop.tenlop = N'Công Nghệ Thông Tin k5'


		select MaSV, TenSV, GioiTinh, NgaySinh from SinhVien where year(getdate())-year(NgaySinh) between '25' and '30'

select MaSV, TenSV, GioiTinh, NgaySinh
from SinhVien, Lop
where SinhVien.MaLop=Lop.MaLop and TenLop = N'An Toàn Thông Tin k5'

select MaSV, TenSV, GioiTinh, NgaySinh from SinhVien where year(getdate())-year(NgaySinh) between 20 and 25
select MaSV, TenSV, GioiTinh, NgaySinh from SinhVien where year(getdate())-year(NgaySinh) = 21

select count(masv), MaSV, MaMH, MaHK, Diem1, Diem2 from DiemHP
select  MaSV, TenSV, GioiTinh, NgaySinh, MaLop 
from SinhVien
group by masv, tensv
insert into SinhVien(MaSV, TenSV, NgaySinh, GioiTinh, MaLop) values ('101',N'gfdgdfg','06/27/2006',N'Nam','1111')

		delete sinhvien where masv='10101'
