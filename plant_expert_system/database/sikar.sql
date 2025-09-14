-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 14, 2025 at 09:57 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sikar`
--

-- --------------------------------------------------------

--
-- Table structure for table `fuzzy_rules`
--

CREATE TABLE `fuzzy_rules` (
  `id` int(11) NOT NULL,
  `kd_gejala` varchar(10) NOT NULL,
  `kode_hama` varchar(10) NOT NULL,
  `nilai_keanggotaan` decimal(3,2) NOT NULL,
  `bobot_kepentingan` decimal(3,2) NOT NULL DEFAULT 1.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fuzzy_rules`
--

INSERT INTO `fuzzy_rules` (`id`, `kd_gejala`, `kode_hama`, `nilai_keanggotaan`, `bobot_kepentingan`) VALUES
(1, 'G01', 'H01', 0.90, 1.00),
(2, 'G02', 'H01', 0.95, 1.00),
(3, 'G03', 'H01', 1.00, 1.00),
(4, 'G07', 'H01', 0.60, 0.80),
(5, 'G23', 'H01', 0.70, 0.70),
(6, 'G04', 'H02', 0.85, 1.00),
(7, 'G05', 'H02', 0.90, 1.00),
(8, 'G06', 'H02', 1.00, 1.00),
(9, 'G07', 'H02', 0.80, 0.90),
(10, 'G20', 'H02', 0.75, 0.80),
(11, 'G21', 'H02', 0.70, 0.70),
(12, 'G08', 'H03', 0.85, 1.00),
(13, 'G09', 'H03', 0.90, 1.00),
(14, 'G10', 'H03', 1.00, 1.00),
(15, 'G11', 'H03', 0.75, 0.80),
(16, 'G22', 'H03', 0.70, 0.70),
(17, 'G12', 'H04', 1.00, 1.00),
(18, 'G13', 'H04', 1.00, 1.00),
(19, 'G11', 'H04', 0.80, 0.90),
(20, 'G23', 'H04', 0.75, 0.80),
(21, 'G14', 'H05', 1.00, 1.00),
(22, 'G15', 'H05', 0.85, 0.90),
(23, 'G23', 'H05', 0.80, 0.80),
(24, 'G07', 'H05', 0.70, 0.70),
(25, 'G15', 'H06', 0.90, 1.00),
(26, 'G16', 'H06', 0.95, 1.00),
(27, 'G17', 'H06', 1.00, 1.00),
(28, 'G23', 'H06', 0.85, 0.90),
(29, 'G19', 'H07', 1.00, 1.00),
(30, 'G20', 'H07', 0.80, 0.90),
(31, 'G22', 'H07', 0.85, 0.80),
(32, 'G24', 'H07', 0.75, 0.70),
(33, 'G25', 'H08', 1.00, 1.00),
(34, 'G22', 'H08', 0.90, 0.90),
(35, 'G24', 'H08', 0.85, 0.80),
(36, 'G10', 'H08', 0.75, 0.70);

-- --------------------------------------------------------

--
-- Table structure for table `gejala`
--

CREATE TABLE `gejala` (
  `kd_gejala` varchar(10) NOT NULL,
  `gejala` text NOT NULL,
  `bobot` decimal(3,2) NOT NULL DEFAULT 1.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gejala`
--

INSERT INTO `gejala` (`kd_gejala`, `gejala`, `bobot`) VALUES
('G01', 'Daun berlubang-lubang kecil', 0.85),
('G02', 'Daun dimakan dari tepi', 0.90),
('G03', 'Terdapat ulat hijau pada daun', 0.95),
('G04', 'Daun menggulung ke atas', 0.80),
('G05', 'Daun keriting dan mengecil', 0.85),
('G06', 'Terdapat kutu hijau pada pucuk daun', 0.90),
('G07', 'Daun menguning dan layu', 0.75),
('G08', 'Terdapat bercak putih seperti tepung pada daun', 0.85),
('G09', 'Daun berbintik-bintik putih kecil', 0.80),
('G10', 'Daun tampak keperakan', 0.85),
('G11', 'Bunga rontok sebelum waktunya', 0.70),
('G12', 'Buah berlubang dan busuk', 0.90),
('G13', 'Terdapat ulat dalam buah', 0.95),
('G14', 'Batang berlubang', 0.85),
('G15', 'Tanaman layu mendadak', 0.80),
('G16', 'Akar rusak dan membusuk', 0.85),
('G17', 'Terdapat ulat di dalam tanah', 0.90),
('G18', 'Daun berbercak coklat', 0.75),
('G19', 'Terdapat serangga kecil putih terbang', 0.85),
('G20', 'Daun lengket seperti madu', 0.80),
('G21', 'Terdapat semut pada tanaman', 0.70),
('G22', 'Daun berubah warna menjadi kekuningan', 0.75),
('G23', 'Pertumbuhan tanaman terhambat', 0.70),
('G24', 'Daun rontok berlebihan', 0.75),
('G25', 'Terdapat jaring laba-laba halus pada daun', 0.85);

-- --------------------------------------------------------

--
-- Table structure for table `hama`
--

CREATE TABLE `hama` (
  `kode` varchar(10) NOT NULL,
  `nama_hama` varchar(100) NOT NULL,
  `nama_latin` varchar(100) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `tingkat_bahaya` enum('Rendah','Sedang','Tinggi','Sangat Tinggi') DEFAULT 'Sedang'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hama`
--

INSERT INTO `hama` (`kode`, `nama_hama`, `nama_latin`, `deskripsi`, `tingkat_bahaya`) VALUES
('H01', 'Ulat Grayak', 'Spodoptera litura', 'Ulat yang memakan daun cabai dari tepi hingga berlubang', 'Tinggi'),
('H02', 'Kutu Daun', 'Aphis gossypii', 'Serangga kecil yang menghisap cairan daun dan menyebabkan keriting', 'Sedang'),
('H03', 'Trips', 'Thrips parvispinus', 'Serangga kecil yang menyebabkan bercak putih pada daun', 'Sedang'),
('H04', 'Ulat Buah', 'Helicoverpa armigera', 'Ulat yang menyerang buah cabai dan membuatnya berlubang', 'Sangat Tinggi'),
('H05', 'Penggerek Batang', 'Leucinodes orbonalis', 'Ulat yang membuat lubang pada batang tanaman', 'Tinggi'),
('H06', 'Ulat Tanah', 'Agrotis ipsilon', 'Ulat yang hidup di tanah dan memakan akar tanaman', 'Tinggi'),
('H07', 'Kutu Kebul', 'Bemisia tabaci', 'Serangga putih kecil yang terbang dan menghisap cairan daun', 'Sedang'),
('H08', 'Tungau Merah', 'Tetranychus urticae', 'Tungau kecil yang membuat jaring dan menyebabkan daun kekuningan', 'Sedang');

-- --------------------------------------------------------

--
-- Table structure for table `pengendalian`
--

CREATE TABLE `pengendalian` (
  `kd_pengendalian` varchar(10) NOT NULL,
  `kode_hama` varchar(10) NOT NULL,
  `metode_pengendalian` enum('Biologis','Mekanis','Organik','Terpadu') NOT NULL,
  `deskripsi` longtext NOT NULL,
  `bahan_aktif` varchar(200) DEFAULT NULL,
  `dosis_aplikasi` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pengendalian`
--

INSERT INTO `pengendalian` (`kd_pengendalian`, `kode_hama`, `metode_pengendalian`, `deskripsi`, `bahan_aktif`, `dosis_aplikasi`) VALUES
('PH01', 'H01', 'Biologis', 'Gunakan Bacillus thuringiensis untuk mengendalikan ulat grayak', 'Bacillus thuringiensis', '2-3 ml/liter air'),
('PH02', 'H01', 'Organik', 'Semprot dengan ekstrak daun nimba atau bawang putih', 'Ekstrak nimba, bawang putih', '10-15 ml/liter air'),
('PH03', 'H02', 'Biologis', 'Lepaskan predator alami seperti kepik atau lacewing', 'Coccinella sp., Chrysopa sp.', 'Sesuai kebutuhan'),
('PH04', 'H02', 'Organik', 'Semprot dengan sabun insektisida atau minyak neem', 'Sabun kalium, minyak neem', '5-10 ml/liter air'),
('PH05', 'H03', 'Mekanis', 'Pasang perangkap biru atau kuning untuk menarik trips', 'Perangkap lengket biru', 'Sesuai luas lahan'),
('PH06', 'H03', 'Organik', 'Aplikasi predator alami Orius atau Amblyseius', 'Orius sp., Amblyseius sp.', 'Sesuai kebutuhan'),
('PH07', 'H04', 'Mekanis', 'Bungkus buah muda dengan plastik atau kertas', 'Plastik/kertas pembungkus', 'Setiap buah muda'),
('PH08', 'H04', 'Biologis', 'Gunakan feromon seks untuk menarik dan menangkap imago', 'Feromon Helicoverpa', '1 perangkap/1000 m²'),
('PH09', 'H05', 'Mekanis', 'Potong dan bakar bagian batang yang terserang', 'Alat pemotong steril', 'Sesuai serangan'),
('PH10', 'H05', 'Biologis', 'Aplikasi jamur entomopatogen Beauveria bassiana', 'Beauveria bassiana', '2-3 g/liter air'),
('PH11', 'H06', 'Mekanis', 'Bajak tanah dan biarkan terkena sinar matahari', 'Alat bajak', 'Sebelum tanam'),
('PH12', 'H06', 'Organik', 'Tabur umpan beracun dari dedak dan insektisida nabati', 'Dedak, ekstrak tembakau', '5-10 kg/ha'),
('PH13', 'H07', 'Mekanis', 'Pasang perangkap kuning lengket', 'Perangkap kuning lengket', '20-30 perangkap/ha'),
('PH14', 'H07', 'Biologis', 'Lepaskan parasitoid Encarsia atau Eretmocerus', 'Encarsia sp., Eretmocerus sp.', 'Sesuai kebutuhan'),
('PH15', 'H08', 'Organik', 'Semprot dengan akarisida nabati dari ekstrak serai', 'Ekstrak serai wangi', '15-20 ml/liter air'),
('PH16', 'H08', 'Biologis', 'Lepaskan predator tungau Phytoseiulus persimilis', 'Phytoseiulus persimilis', 'Sesuai kebutuhan');

-- --------------------------------------------------------

--
-- Stand-in structure for view `penyakit`
-- (See below for the actual view)
--
CREATE TABLE `penyakit` (
`kode` varchar(10)
,`nama_penyakit` varchar(100)
,`nama_latin` varchar(100)
,`deskripsi` text
,`tingkat_bahaya` enum('Rendah','Sedang','Tinggi','Sangat Tinggi')
);

-- --------------------------------------------------------

--
-- Table structure for table `solusi`
--

CREATE TABLE `solusi` (
  `id` int(10) NOT NULL,
  `kd_solusi` varchar(10) NOT NULL,
  `kode_hama` varchar(10) NOT NULL,
  `nama_obat` varchar(255) NOT NULL,
  `solusi` longtext NOT NULL,
  `dosis` varchar(255) DEFAULT NULL,
  `cara_aplikasi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `solusi`
--

INSERT INTO `solusi` (`id`, `kd_solusi`, `kode_hama`, `nama_obat`, `solusi`, `dosis`, `cara_aplikasi`) VALUES
(1, 'S01', 'H01', 'Brotowali', 'Bahan dan alat: 200 gram batang brotowali, 1 liter air, Alat tumbuk, Blender, Pisau, Ember. Cara membuat: Rajang batang brotowali dengan pisau lalu tumbuk atau blender, Rendam dalam 1 liter air, aduk, lalu saring.', '200g/1L air', 'Rendam benih 24 jam atau semprot pada pagi/sore hari'),
(2, 'S02', 'H02', 'Brotowali', 'Bahan dan alat: 200 gram batang brotowali, 1 liter air, Alat tumbuk, Blender, Pisau, Ember. Cara membuat: Rajang batang brotowali dengan pisau lalu tumbuk atau blender, Rendam dalam 1 liter air, aduk, lalu saring.', '200g/1L air', 'Rendam benih 24 jam atau semprot pada pagi/sore hari'),
(3, 'S03', 'H01', 'Ekstrak buah Mengkudu', 'Bahan dan Alat: 1 kg buah mengkudu matang, 0,5 kg daun nangka, 0,5 kg tembakau, 1-2 gram detergen, 1-5 liter air, Alat tumbuk atau blender, Saringan. Cara membuat: Hancurkan semua bahan hingga halus menggunakan blender atau alat tumbuk, Tambahkan 2-5 liter air, lalu saring.', '1kg mengkudu/5L air', 'Semprotkan ke seluruh bagian tanaman pada pagi hari'),
(4, 'S04', 'H01', 'Kombinasi ekstrak Cabe, Bawang Merah dan Bawang Putih', 'Bahan dan alat: 1 sendok teh bubuk cabe, 1 siung bawang putih, 1 butir bawang merah, 1 liter air, 1 sendok teh sabun, Pisau, Saringan, Ember. Cara membuat: Hancurkan bawang putih dan bawang merah, Campurkan dengan bubuk cabe, Tambahkan air dan aduk rata, Biarkan larut dalam 1 jam, lalu saring.', '1 sdt bubuk cabe/1L air', 'Semprotkan pada pagi atau sore hari, ulangi bila perlu'),
(5, 'S05', 'H03', 'Ekstrak Cabai Merah', 'Bahan dan alat: 0,5 kg cabai merah atau biji cabai merah, 30 gram sabun atau detergen, Panci, Penyaring. Cara membuat: Rebus cabai merah atau biji cabai merah ke dalam panci selama 15-20 menit, Matikan api dan tambahkan 3 liter air, Biarkan sampai dingin lalu saring, Tambahkan sabun atau detergen, Aduk hingga rata.', '0.5kg cabai/3L air', 'Semprotkan pada pagi atau sore hari'),
(6, 'S06', 'H04', 'Ekstrak Cabai Merah', 'Bahan dan alat: 0,5 kg cabai merah atau biji cabai merah, 30 gram sabun atau detergen, Panci, Penyaring. Cara membuat: Rebus cabai merah atau biji cabai merah ke dalam panci selama 15-20 menit, Matikan api dan tambahkan 3 liter air, Biarkan sampai dingin lalu saring, Tambahkan sabun atau detergen, Aduk hingga rata.', '0.5kg cabai/3L air', 'Semprotkan pada pagi atau sore hari'),
(7, 'S07', 'H01', 'Ekstrak Sirih dan Tembakau', 'Bahan dan alat: Daun sirih 50 lembar, Ember, Daun tembakau 5 lembar, Alat penyaring, 20 liter air, Alat penumbuk, Sabun cair 20 gram, Alat pengaduk. Cara membuat: Tumbuk daun sirih dan tembakau hingga halus, Masukkan bahan yang sudah di haluskan kedalam ember lalu campur dengan air dan aduk hingga rata, Diamkan selama satu malam, Saring larutan lalu encerkan dengan 50-60 liter air.', '50 lembar sirih/20L air', 'Semprotkan pada tanaman yang terserang'),
(8, 'S08', 'H02', 'Ekstrak Mimba', 'Bahan dan alat: Air 1 liter, Baskom atau ember, Alkohol 70% 1 cc, Alat penyaring, Daun mimba 50 gram, Sprayer, Alat penumbuk/penghalus. Cara membuat: Tumbuk daun mimba hingga halus, Masukkan bahan yang sudah halus kedalam ember, Tambahkan alkohol dan aduk hingga rata, Encerkan dengan 1 liter air, Endapkan larutan semalam, lalu saring.', '50g daun mimba/1L air', 'Semprotkan pada tanaman yang terserang'),
(9, 'S09', 'H05', 'Kombinasi ekstrak Cabai Merah dan daun Mimba', 'Bahan dan Alat: 10-20 buah cabai merah, 2 sendok teh sabun, 2-2,5 daun mimba segar, Alat tumbuk atau blender, 21 liter air, Ember. Cara membuat: Hancurkan cabai merah dengan daun mimba sampai halus, Tambahkan 1 liter air, Biarkan selama 24 jam, Saring, Tambahkan 20 liter air dan sabun kedalam larutan, Aduk hingga rata.', '15 buah cabai + 2 lembar mimba/21L air', 'Kocok sebelum digunakan, semprot pagi dan sore hari'),
(10, 'S10', 'H06', 'Kombinasi ekstrak Cabai Merah dan daun Mimba', 'Bahan dan Alat: 10-20 buah cabai merah, 2 sendok teh sabun, 2-2,5 daun mimba segar, Alat tumbuk atau blender, 21 liter air, Ember. Cara membuat: Hancurkan cabai merah dengan daun mimba sampai halus, Tambahkan 1 liter air, Biarkan selama 24 jam, Saring, Tambahkan 20 liter air dan sabun kedalam larutan, Aduk hingga rata.', '15 buah cabai + 2 lembar mimba/21L air', 'Kocok sebelum digunakan, semprot pagi dan sore hari'),
(11, 'S11', 'H07', 'Kombinasi ekstrak Cabai Merah dan daun Mimba', 'Bahan dan Alat: 10-20 buah cabai merah, 2 sendok teh sabun, 2-2,5 daun mimba segar, Alat tumbuk atau blender, 21 liter air, Ember. Cara membuat: Hancurkan cabai merah dengan daun mimba sampai halus, Tambahkan 1 liter air, Biarkan selama 24 jam, Saring, Tambahkan 20 liter air dan sabun kedalam larutan, Aduk hingga rata.', '15 buah cabai + 2 lembar mimba/21L air', 'Kocok sebelum digunakan, semprot pagi dan sore hari'),
(12, 'S12', 'H04', 'Kombinasi ekstrak Cabai Merah dengan biji Mimba', 'Bahan dan alat: 12 buah cabai merah, Ember, 200 gram biji kering mimba, Alat penumbuk, 4 liter air, Pisau. Cara membuat: Hancurkan cabai merah dan biji mimba sampai halus, Rendam selama 24 jam, Tambahkan serbuk cabai merah, Aduk hingga rata, lalu saring.', '12 buah cabai + 200g biji mimba/4L air', 'Semprot pada pagi dan sore hari'),
(13, 'S13', 'H07', 'Kombinasi ekstrak Cabai Merah dengan biji Mimba', 'Bahan dan alat: 12 buah cabai merah, Ember, 200 gram biji kering mimba, Alat penumbuk, 4 liter air, Pisau. Cara membuat: Hancurkan cabai merah dan biji mimba sampai halus, Rendam selama 24 jam, Tambahkan serbuk cabai merah, Aduk hingga rata, lalu saring.', '12 buah cabai + 200g biji mimba/4L air', 'Semprot pada pagi dan sore hari'),
(14, 'S14', 'H08', 'Ekstrak daun gamal dan Mimba', 'Bahan dan alat: 1 kg daun gamal, Pisau, 1 kg daun mimba, Alat tumbuk atau blender, 25 liter air, Saringan. Cara membuat: Tumbuk daun gamal dan daun mimba sampai halus, Rendam di dalam 5 liter air selama 3 hari, Saring dengan kain halus.', '1kg gamal + 1kg mimba/25L air', 'Semprot dengan interval 4-5 hari pada pagi/sore'),
(15, 'S15', 'H04', 'Ekstrak daun gamal dan Mimba', 'Bahan dan alat: 1 kg daun gamal, Pisau, 1 kg daun mimba, Alat tumbuk atau blender, 25 liter air, Saringan. Cara membuat: Tumbuk daun gamal dan daun mimba sampai halus, Rendam di dalam 5 liter air selama 3 hari, Saring dengan kain halus.', '1kg gamal + 1kg mimba/25L air', 'Semprot dengan interval 4-5 hari pada pagi/sore'),
(16, 'S16', 'H08', 'Ekstrak daun gamal dan Mimba', 'Bahan dan alat: 1 kg daun gamal, Pisau, 1 kg daun mimba, Alat tumbuk atau blender, 25 liter air, Saringan. Cara membuat: Tumbuk daun gamal dan daun mimba sampai halus, Rendam di dalam 5 liter air selama 3 hari, Saring dengan kain halus.', '1kg gamal + 1kg mimba/25L air', 'Semprot dengan interval 4-5 hari pada pagi/sore'),
(17, 'S17', 'H07', 'Ekstrak daun gamal dan Mimba', 'Bahan dan alat: 1 kg daun gamal, Pisau, 1 kg daun mimba, Alat tumbuk atau blender, 25 liter air, Saringan. Cara membuat: Tumbuk daun gamal dan daun mimba sampai halus, Rendam di dalam 5 liter air selama 3 hari, Saring dengan kain halus.', '1kg gamal + 1kg mimba/25L air', 'Semprot dengan interval 4-5 hari pada pagi/sore'),
(18, 'S18', 'H03', 'Ekstrak Kipait, Laos, Serai Wangi', 'Bahan dan alat: 8 kg kipait, Panci, 6 kg laos, Alat tumbuk atau blender, 6 kg serai wangi, Ember, 20 liter air, Drum kapasitas 20 liter, Perekat. Cara membuat: Cincang kipait, laos, serai wangi, lalu tumbuk sampai halus, Masukkan bahan-bahan yang telah di tumbuk kedalam ember atau drum yang telah diisi air, Diamkan selama 24 jam, lalu saring, Tambahkan air sampai menjadi 20 liter larutan.', '8kg kipait + 6kg laos + 6kg serai/20L air', 'Encerkan 1:560 dengan air untuk 1 ha lahan'),
(19, 'S19', 'H03', 'Ekstrak Kipait, Laos, Serai Wangi', 'Bahan dan alat: 8 kg kipait, Panci, 6 kg laos, Alat tumbuk atau blender, 6 kg serai wangi, Ember, 20 liter air, Drum kapasitas 20 liter, Perekat. Cara membuat: Cincang kipait, laos, serai wangi, lalu tumbuk sampai halus, Masukkan bahan-bahan yang telah di tumbuk kedalam ember atau drum yang telah diisi air, Diamkan selama 24 jam, lalu saring, Tambahkan air sampai menjadi 20 liter larutan.', '8kg kipait + 6kg laos + 6kg serai/20L air', 'Encerkan 1:560 dengan air untuk 1 ha lahan'),
(20, 'S20', 'H02', 'Ekstrak Legundi dan lidah Buaya', 'Bahan dan alat: 5 kg daun legundi, Pemanas atau kompor panci, 2 kg daun lidah buaya, Ember, 50-60 ml sabun, 60-70 liter air. Cara membuat: Rendam daun legundi dalam 10 liter air, Didihkan sampai 30 menit, Dinginkan, lalu saring. Hilangkan bagian luar kulit lidah buaya, Giling dan tambahkan agar diperoleh ekstrak, Saring ekstrak yang diperoleh, Campur kedua ekstrak.', '5kg legundi + 2kg lidah buaya/70L air', 'Semprot pada pagi/sore, untuk 0.4 ha lahan'),
(21, 'S21', 'H04', 'Ekstrak Pacar Cina', 'Bahan dan alat: 5-100 gram ranting atau kulit batang, 1 gram sabun atau detergen, Ember, Alat tumbuk atau blender, Saringan. Cara membuat: Hancurkan kulit batang atau ranting, Rebus dengan 1 liter air selama 45-75 menit, Dinginkan, lalu tambahkan deterjen, Aduk sampai merata, lalu saring.', '100g kulit batang/1L air', 'Semprotkan pada pagi hari'),
(22, 'S22', 'H01', 'Ekstrak Pacar Cina', 'Bahan dan alat: 5-100 gram ranting atau kulit batang, 1 gram sabun atau detergen, Ember, Alat tumbuk atau blender, Saringan. Cara membuat: Hancurkan kulit batang atau ranting, Rebus dengan 1 liter air selama 45-75 menit, Dinginkan, lalu tambahkan deterjen, Aduk sampai merata, lalu saring.', '100g kulit batang/1L air', 'Semprotkan pada pagi hari'),
(23, 'S23', 'H06', 'Ekstrak daun sirsak', 'Bahan dan alat: 50-100 daun sirsak, 15 gram sabun atau detergen, Ember, Pisau, Alat saring. Cara membuat: Tumbuk daun sampai halus, Rendam di dalam 5 liter air, Tambahkan detergen, lalu aduk sampai tercampur rata, Biarkan sampai 24 jam, lalu saring.', '100 daun sirsak/5L air', 'Encerkan 1:10-15 dengan air, semprot pagi/sore'),
(24, 'S24', 'H05', 'Fermentasi ekstrak kenikir', 'Bahan dan alat: 5-10 tanaman kenikir yang sedang berbunga, 20 liter air, Detergen atau sabun, Alat penyaring, Drum. Cara membuat: Masukkan tanaman kenikir dan air ke dalam drum, Biarkan selama 5-10 hari, Aduk secara berkala dan saring sebelum digunakan.', '10 tanaman kenikir/20L air', 'Encerkan 1:2 dengan air, semprot pagi/sore'),
(25, 'S25', 'H08', 'Ekstrak Jahe', 'Bahan dan alat: 50 gram jahe, Alat tumbuk atau blender, 12 ml detergen, Saringan, 3 liter air, Ember. Cara membuat: Hancurkan jahe sampai halus, Tambahkan air dan detergen, Aduk sampai rata, lalu saring.', '50g jahe/3L air', 'Semprotkan pada pagi atau sore hari');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(10) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `level` varchar(20) NOT NULL DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `username`, `password`, `fullname`, `level`, `created_at`) VALUES
(1, 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator', 'admin', '2025-09-08 05:50:39'),
(2, 'expert', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Chili Pest Expert', 'expert', '2025-09-08 05:50:39'),
(3, 'petani', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Petani Cabai', 'user', '2025-09-08 05:50:39');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_pest_control`
-- (See below for the actual view)
--
CREATE TABLE `v_pest_control` (
`kode` varchar(10)
,`nama_hama` varchar(100)
,`metode_pengendalian` enum('Biologis','Mekanis','Organik','Terpadu')
,`deskripsi` longtext
,`bahan_aktif` varchar(200)
,`dosis_aplikasi` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_pest_solutions`
-- (See below for the actual view)
--
CREATE TABLE `v_pest_solutions` (
`kode` varchar(10)
,`nama_hama` varchar(100)
,`nama_latin` varchar(100)
,`tingkat_bahaya` enum('Rendah','Sedang','Tinggi','Sangat Tinggi')
,`nama_obat` varchar(255)
,`solusi` longtext
,`dosis` varchar(255)
,`cara_aplikasi` text
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_pest_symptoms`
-- (See below for the actual view)
--
CREATE TABLE `v_pest_symptoms` (
`kode` varchar(10)
,`nama_hama` varchar(100)
,`nama_latin` varchar(100)
,`symptom_name` text
,`membership_value` decimal(3,2)
,`importance_weight` decimal(3,2)
);

-- --------------------------------------------------------

--
-- Structure for view `penyakit`
--
DROP TABLE IF EXISTS `penyakit`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `penyakit`  AS SELECT `hama`.`kode` AS `kode`, `hama`.`nama_hama` AS `nama_penyakit`, `hama`.`nama_latin` AS `nama_latin`, `hama`.`deskripsi` AS `deskripsi`, `hama`.`tingkat_bahaya` AS `tingkat_bahaya` FROM `hama` ;

-- --------------------------------------------------------

--
-- Structure for view `v_pest_control`
--
DROP TABLE IF EXISTS `v_pest_control`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pest_control`  AS SELECT `h`.`kode` AS `kode`, `h`.`nama_hama` AS `nama_hama`, `p`.`metode_pengendalian` AS `metode_pengendalian`, `p`.`deskripsi` AS `deskripsi`, `p`.`bahan_aktif` AS `bahan_aktif`, `p`.`dosis_aplikasi` AS `dosis_aplikasi` FROM (`hama` `h` join `pengendalian` `p` on(`h`.`kode` = `p`.`kode_hama`)) ;

-- --------------------------------------------------------

--
-- Structure for view `v_pest_solutions`
--
DROP TABLE IF EXISTS `v_pest_solutions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pest_solutions`  AS SELECT `h`.`kode` AS `kode`, `h`.`nama_hama` AS `nama_hama`, `h`.`nama_latin` AS `nama_latin`, `h`.`tingkat_bahaya` AS `tingkat_bahaya`, `s`.`nama_obat` AS `nama_obat`, `s`.`solusi` AS `solusi`, `s`.`dosis` AS `dosis`, `s`.`cara_aplikasi` AS `cara_aplikasi` FROM (`hama` `h` join `solusi` `s` on(`h`.`kode` = `s`.`kode_hama`)) ;

-- --------------------------------------------------------

--
-- Structure for view `v_pest_symptoms`
--
DROP TABLE IF EXISTS `v_pest_symptoms`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pest_symptoms`  AS SELECT `h`.`kode` AS `kode`, `h`.`nama_hama` AS `nama_hama`, `h`.`nama_latin` AS `nama_latin`, `g`.`gejala` AS `symptom_name`, `fr`.`nilai_keanggotaan` AS `membership_value`, `fr`.`bobot_kepentingan` AS `importance_weight` FROM ((`hama` `h` join `fuzzy_rules` `fr` on(`h`.`kode` = `fr`.`kode_hama`)) join `gejala` `g` on(`fr`.`kd_gejala` = `g`.`kd_gejala`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fuzzy_rules`
--
ALTER TABLE `fuzzy_rules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_fuzzy_gejala` (`kd_gejala`),
  ADD KEY `fk_fuzzy_hama` (`kode_hama`),
  ADD KEY `idx_fuzzy_symptoms` (`kd_gejala`),
  ADD KEY `idx_fuzzy_pests` (`kode_hama`),
  ADD KEY `idx_fuzzy_rules_hama` (`kode_hama`),
  ADD KEY `idx_fuzzy_rules_gejala` (`kd_gejala`);

--
-- Indexes for table `gejala`
--
ALTER TABLE `gejala`
  ADD PRIMARY KEY (`kd_gejala`),
  ADD KEY `idx_gejala_search` (`gejala`(50)),
  ADD KEY `idx_gejala_kd` (`kd_gejala`);

--
-- Indexes for table `hama`
--
ALTER TABLE `hama`
  ADD PRIMARY KEY (`kode`),
  ADD KEY `idx_hama_search` (`nama_hama`),
  ADD KEY `idx_hama_kode` (`kode`);

--
-- Indexes for table `pengendalian`
--
ALTER TABLE `pengendalian`
  ADD PRIMARY KEY (`kd_pengendalian`),
  ADD KEY `fk_pengendalian_hama` (`kode_hama`);

--
-- Indexes for table `solusi`
--
ALTER TABLE `solusi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_solusi_kode` (`kd_solusi`),
  ADD KEY `fk_solusi_hama` (`kode_hama`),
  ADD KEY `idx_solusi_search` (`nama_obat`),
  ADD KEY `idx_solusi_hama` (`kode_hama`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fuzzy_rules`
--
ALTER TABLE `fuzzy_rules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `solusi`
--
ALTER TABLE `solusi`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `fuzzy_rules`
--
ALTER TABLE `fuzzy_rules`
  ADD CONSTRAINT `fk_fuzzy_gejala` FOREIGN KEY (`kd_gejala`) REFERENCES `gejala` (`kd_gejala`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_fuzzy_hama` FOREIGN KEY (`kode_hama`) REFERENCES `hama` (`kode`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pengendalian`
--
ALTER TABLE `pengendalian`
  ADD CONSTRAINT `fk_pengendalian_hama` FOREIGN KEY (`kode_hama`) REFERENCES `hama` (`kode`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `solusi`
--
ALTER TABLE `solusi`
  ADD CONSTRAINT `fk_solusi_hama` FOREIGN KEY (`kode_hama`) REFERENCES `hama` (`kode`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
