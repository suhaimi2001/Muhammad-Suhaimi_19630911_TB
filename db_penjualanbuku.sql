-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 07 Jan 2022 pada 15.03
-- Versi server: 10.4.22-MariaDB
-- Versi PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_penjualanbuku`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang`
--

CREATE TABLE `tbl_barang` (
  `kd_barang` varchar(10) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `jumlah_barang` int(11) NOT NULL,
  `harga_beli` int(11) NOT NULL,
  `harga_jual` int(11) NOT NULL,
  `tanggal_masuk` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_barang`
--

INSERT INTO `tbl_barang` (`kd_barang`, `nama_barang`, `jumlah_barang`, `harga_beli`, `harga_jual`, `tanggal_masuk`) VALUES
('B0001', 'Buku Gambar', 97, 3000, 5000, '2018-05-15'),
('B0002', 'Buku Cerita', 28, 30000, 50000, '2018-05-15'),
('B0003', 'Buku Tulis', 5, 10000, 20000, '2018-05-15'),
('B0005', 'buku puki', 10, 3000, 3500, '2022-01-06');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_beli`
--

CREATE TABLE `tbl_beli` (
  `nofaktur` varchar(11) NOT NULL,
  `kd_buku` varchar(11) NOT NULL,
  `nama_buku` varchar(50) NOT NULL,
  `hsatuan` int(11) NOT NULL,
  `jumlah_beli` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `bayar` int(11) NOT NULL,
  `kembalian` int(11) NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_beli`
--

INSERT INTO `tbl_beli` (`nofaktur`, `kd_buku`, `nama_buku`, `hsatuan`, `jumlah_beli`, `harga`, `bayar`, `kembalian`, `tanggal`) VALUES
('F0001', 'B0002', 'setrika', 670000, 1, 670000, 6000000, 730000, '2018-05-15'),
('F0001', 'B0003', 'televisi', 2300000, 2, 4600000, 6000000, 730000, '2018-05-15'),
('F0002', 'B0005', 'mesin cuci', 5780000, 2, 11560000, 20000000, 40000, '2018-05-15'),
('F0002', 'B0001', 'kulkas', 1500000, 1, 1500000, 20000000, 40000, '2018-05-15'),
('F0002', 'B0003', 'televisi', 2300000, 3, 6900000, 20000000, 40000, '2018-05-15');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_login`
--

CREATE TABLE `tbl_login` (
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `jenis_kelamin` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_telp` int(30) NOT NULL,
  `agama` varchar(30) NOT NULL,
  `alamat` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_login`
--

INSERT INTO `tbl_login` (`username`, `password`, `jenis_kelamin`, `email`, `no_telp`, `agama`, `alamat`) VALUES
('puki', '1234', 'Laki-Laki', 'sadsadas', 321312, 'KhongHuCu', 'jalan neraka'),
('uhai', 'uhai', 'Laki-Laki', 'uhai@gmail.com', 12345, 'Islam', 'Tablong');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_tmp_beli`
--

CREATE TABLE `tbl_tmp_beli` (
  `id_tmp` int(11) NOT NULL,
  `kd_barang` varchar(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `hsatuan` int(11) NOT NULL,
  `jumlah_beli` int(11) NOT NULL,
  `harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_tmp_beli`
--

INSERT INTO `tbl_tmp_beli` (`id_tmp`, `kd_barang`, `nama_barang`, `hsatuan`, `jumlah_beli`, `harga`) VALUES
(1, 'B0001', 'Buku Gambar', 5000, 1, 5000),
(2, 'B0003', 'Buku Tulis', 20000, 10, 200000),
(3, 'B0002', 'buku cerita', 50000, 1, 50000),
(4, 'B0001', 'buku gambar', 5000, 1, 5000);

--
-- Trigger `tbl_tmp_beli`
--
DELIMITER $$
CREATE TRIGGER `batal` AFTER DELETE ON `tbl_tmp_beli` FOR EACH ROW BEGIN
UPDATE tbl_barang SET jumlah_barang = jumlah_barang + OLD.jumlah_beli
WHERE kd_barang = OLD.kd_barang;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `beli` AFTER INSERT ON `tbl_tmp_beli` FOR EACH ROW BEGIN 
UPDATE tbl_barang SET jumlah_barang = jumlah_barang - new.jumlah_beli 
WHERE kd_barang = new.`kd_barang`; 
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tbl_barang`
--
ALTER TABLE `tbl_barang`
  ADD PRIMARY KEY (`kd_barang`);

--
-- Indeks untuk tabel `tbl_login`
--
ALTER TABLE `tbl_login`
  ADD PRIMARY KEY (`username`);

--
-- Indeks untuk tabel `tbl_tmp_beli`
--
ALTER TABLE `tbl_tmp_beli`
  ADD PRIMARY KEY (`id_tmp`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tbl_tmp_beli`
--
ALTER TABLE `tbl_tmp_beli`
  MODIFY `id_tmp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
