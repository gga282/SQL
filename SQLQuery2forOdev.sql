USE Odev;
DROP TABLE IF EXISTS Yazarlar,Kategoriler,Makaleler;

CREATE TABLE Yazarlar
(	YazarID TINYINT NOT NULL,
	YazarAdi NVARCHAR(64) NOT NULL,
	YazarSoyadi NVARCHAR(32) NOT NULL,
	Email NVARCHAR(128) UNIQUE NOT NULL,
	Birthdate DATE,
	CONSTRAINT PK_t PRIMARY KEY (YazarID,YazarAdi,YazarSoyadi)

);
CREATE TABLE Kategoriler
(
	KategoriID TINYINT  NOT NULL,
	KategoriAdi NVARCHAR(64)  NOT NULL,
	CONSTRAINT PK_K PRIMARY KEY(KategoriID,KategoriAdi)
);
CREATE TABLE Makaleler
(
	YazarID TINYINT,
	YazarAdi NVARCHAR(64) NOT NULL,
	YazarSoyadi NVARCHAR(32) NOT NULL,
	MakaleAdi NVARCHAR(80) NOT NULL,
	MakaleKategorisi NVARCHAR(64) DEFAULT 'Genel',
	KategoriID TINYINT NOT NULL,
	YayinTarihi DATETIME NOT NULL,
	CONSTRAINT FK_key_Kategori
		FOREIGN KEY(MakaleKategorisi,KategoriID)
		References Kategoriler(KategoriAdi,KategoriID)
		ON DELETE SET DEFAULT
		ON UPDATE CASCADE,
	CONSTRAINT FK_key_Yazar
		FOREIGN KEY(YazarID,YazarAdi,YazarSoyadi)
		REFERENCES Yazarlar(YazarID,YazarAdi,YazarSoyadi)
		ON DELETE NO ACTION,
);
ALTER TABLE Makaleler
	ADD CONSTRAINT Dft_Makaleler
	DEFAULT(SYSDATETIME()) for YayinTarihi;

