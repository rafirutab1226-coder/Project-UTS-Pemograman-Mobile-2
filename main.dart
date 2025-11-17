import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const GameStoreApp());
}

class GameStoreApp extends StatelessWidget {
  const GameStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFF0D1117);
    const accentBlue = Color(0xFF58A6FF);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rafi Game Store\n232101363',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accentBlue,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: background,
          elevation: 1,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        textTheme: ThemeData.dark().textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool _obscure = true;

  void _login() {
    final user = userController.text.trim();
    final pass = passController.text.trim();

    if (user == "rafi" && pass == "123") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username atau password salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/profile.jpg', height: 120, fit: BoxFit.cover),
              const SizedBox(height: 20),
              const Text(
                'Rafi Game Store\n232101363',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: userController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passController,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() => _obscure = !_obscure);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF58A6FF),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, dynamic>> allGames;
  late List<Map<String, dynamic>> filteredGames;
  List<String> genres = [];
  String selectedGenre = 'All';
  String searchQuery = ''; // Tambahan: untuk menyimpan kata pencarian
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
allGames = [
  {
    "title": "God of War Ragnarök",
    "genre": "Action",
    "rating": 9.5,
    "asset": "assets/gow.jpg",
    "desc":
        "Kratos dan Atreus kini berhadapan dengan takdir yang tidak dapat dihindari — Ragnarök, kehancuran para dewa. Setelah peristiwa di Midgard, hubungan ayah dan anak ini semakin diuji oleh waktu, kepercayaan, dan perbedaan pandangan tentang masa depan. Kratos yang mencoba meninggalkan masa lalunya sebagai Dewa Perang, terus dihantui oleh dosa dan amarah yang tak pernah benar-benar padam. Sementara Atreus, yang mulai memahami jati dirinya sebagai Loki, berusaha menemukan kebenaran tentang ramalan yang menyebutkan perannya dalam akhir dunia. Dunia Nordik yang luas kini penuh dengan konflik, monster legendaris, dan misteri mitologi yang menunggu untuk dijelajahi. Ragnarök bukan sekadar pertarungan melawan dewa, tetapi kisah tentang keluarga, pengorbanan, dan keberanian menghadapi takdir — bahkan ketika seluruh dunia berusaha melawanmu."
  },
  {
    "title": "The Last of Us Part II",
    "genre": "Survival",
    "rating": 9.6,
    "asset": "assets/tlou2.jpg",
    "desc":
        "Beberapa tahun setelah kejadian di game pertama, Ellie hidup damai di Jackson bersama Joel. Namun, tragedi kejam memaksa Ellie meninggalkan kedamaian itu dan menempuh perjalanan penuh amarah. Di dunia pasca-apokaliptik yang brutal, ia belajar bahwa balas dendam membawa harga yang tinggi. Narasi The Last of Us Part II mengajak pemain mempertanyakan moralitas, cinta, dan pengampunan. Dunia yang sunyi, karakter kompleks, dan animasi realistis membuat emosi pemain ikut terkoyak. Ini bukan sekadar game, tetapi refleksi tentang kemanusiaan dalam dunia yang kehilangan nurani."
  },
  {
    "title": "Ghost of Tsushima",
    "genre": "Action",
    "rating": 9.3,
    "asset": "assets/ghost.jpg",
    "desc":
        "Ghost of Tsushima menceritakan perjalanan Jin Sakai, samurai terakhir dari klannya, dalam mempertahankan pulau Tsushima dari invasi Mongol. Untuk melindungi rakyatnya, Jin harus mengesampingkan kehormatan dan berubah menjadi 'The Ghost', simbol perlawanan yang menakutkan. Permainan ini menghadirkan dunia yang indah — dari ladang bunga yang berayun ditiup angin hingga duel samurai yang penuh gaya. Namun di balik keindahannya, terdapat dilema moral tentang harga dari kebebasan dan kehormatan. Ini adalah kisah tentang pengorbanan, identitas, dan bagaimana legenda lahir dari bayangan."
  },
  {
    "title": "Red Dead Redemption 2",
    "genre": "Action",
    "rating": 9.8,
    "asset": "assets/rdr2.jpg",
    "desc":
        "Sebagai Arthur Morgan, pemain hidup di masa senja para penjahat. Bersama geng Van der Linde, Arthur berjuang bertahan di dunia yang terus berubah. Dunia terbuka yang sangat detail menggambarkan Amerika abad ke-19 dengan sempurna — dari kota berdebu hingga pegunungan salju. Setiap karakter memiliki kedalaman dan cerita pribadi. Red Dead Redemption 2 bukan hanya kisah koboi, tetapi refleksi tentang kehormatan, kesetiaan, dan penyesalan seorang pria yang mencoba menemukan arti hidup di ambang kematian peradaban lama."
  },
  {
    "title": "Marvel’s Spider-Man",
    "genre": "Action",
    "rating": 9.4,
    "asset": "assets/spiderman.jpg",
    "desc":
        "Peter Parker kini bukan remaja biasa, tapi ilmuwan muda yang berusaha menyeimbangkan kehidupan pribadi dan tanggung jawab sebagai Spider-Man. Ketika ancaman baru muncul di New York, Peter menghadapi dilema antara cinta, pengorbanan, dan tanggung jawab. Dunia terbuka New York terasa hidup, dengan gerakan bergelantungan yang mulus dan pertarungan penuh aksi. Cerita ini menyoroti sisi manusia Peter: lelah, jatuh, tapi tidak pernah menyerah. Sebuah kisah superhero yang juga tentang kemanusiaan, kehilangan, dan harapan."
  },
  {
    "title": "Horizon Forbidden West",
    "genre": "RPG",
    "rating": 9.2,
    "asset": "assets/hfw.jpg",
    "desc":
        "Aloy kembali dalam petualangan baru melintasi peradaban yang telah runtuh. Di barat jauh, dunia dipenuhi mesin-mesin berbahaya dan rahasia peninggalan manusia masa lalu. Aloy harus menghadapi suku-suku baru dan menemukan penyebab wabah misterius yang mengancam seluruh planet. Dunia yang luas dan indah memadukan alam liar dengan reruntuhan teknologi tinggi. Horizon Forbidden West menghadirkan eksplorasi mendalam, pertempuran strategis, dan narasi emosional tentang tanggung jawab manusia terhadap bumi dan masa depannya."
  },
  {
    "title": "Uncharted 4: A Thief’s End",
    "genre": "Adventure",
    "rating": 9.1,
    "asset": "assets/uncharted4.jpg",
    "desc":
        "Nathan Drake, pemburu harta karun legendaris, kembali untuk satu petualangan terakhir. Ketika saudara yang telah lama hilang muncul dan membawa rahasia lama, Drake harus memilih antara kehidupan damai dan panggilan masa lalunya. Dari kota tropis hingga reruntuhan kuno, setiap lokasi dipenuhi teka-teki dan adegan aksi sinematik. Uncharted 4 menutup kisah Nathan dengan penuh emosi, menyoroti cinta, pengorbanan, dan arti sesungguhnya dari 'petualangan'."
  },
  {
    "title": "Elden Ring",
    "genre": "RPG",
    "rating": 9.7,
    "asset": "assets/eldenring.jpg",
    "desc":
        "Kolaborasi epik antara Hidetaka Miyazaki dan George R.R. Martin melahirkan dunia fantasi kelam bernama The Lands Between. Sebagai Tarnished, pemain menjelajahi dunia terbuka luas, penuh misteri, makhluk ilahi, dan rahasia tersembunyi. Setiap sudut peta menyimpan cerita dan tantangan unik. Elden Ring menggabungkan kebebasan eksplorasi dengan pertarungan Souls-like yang brutal dan memuaskan. Dunia ini tidak sekadar besar — ia hidup, bernapas, dan menuntut keberanian serta rasa ingin tahu tanpa batas."
  },
  {
    "title": "GTA V",
    "genre": "Action",
    "rating": 9.4,
    "asset": "assets/gtav.jpg",
    "desc":
        "Tiga karakter dengan latar belakang berbeda — Michael, Franklin, dan Trevor — terjebak dalam dunia kriminal Los Santos. GTA V menghadirkan kebebasan total, dari perampokan bank besar hingga sekadar jalan-jalan di pantai. Dunia yang penuh satir sosial menggambarkan ambisi, kekuasaan, dan korupsi di kota modern. Cerita yang tajam, dialog yang lucu, dan gameplay yang bebas menjadikannya salah satu game open-world paling ikonik sepanjang masa."
  },
  {
    "title": "The Witcher 3: Wild Hunt",
    "genre": "RPG",
    "rating": 9.8,
    "asset": "assets/witcher3.jpg",
    "desc":
        "Geralt of Rivia, sang pemburu monster, melakukan perjalanan epik untuk menemukan anak angkatnya, Ciri, yang dikejar oleh Wild Hunt. Dunia terbuka The Witcher 3 adalah mahakarya: luas, penuh kehidupan, dan sarat pilihan moral yang berdampak nyata. Setiap quest terasa bermakna dan ditulis dengan kedalaman emosional. Dengan narasi dewasa dan dunia fantasi kelam, The Witcher 3 menjadi tolak ukur bagi RPG modern — kisah tentang cinta, kehilangan, dan arti kemanusiaan di dunia tanpa belas kasihan."
  },
  {
    "title": "Bloodborne",
    "genre": "RPG",
    "rating": 9.0,
    "asset": "assets/bloodborne.jpg",
    "desc":
        "Di kota gothic Yharnam, pemain menjadi Hunter yang terjebak dalam mimpi penuh darah dan kegilaan. Dunia yang kelam ini dipenuhi makhluk kosmik, rahasia, dan simbolisme yang mengganggu. Bloodborne menuntut keteguhan mental dan kemampuan refleks tinggi, menghadirkan ketegangan di setiap pertempuran. Lebih dari sekadar game aksi, Bloodborne adalah perjalanan psikologis yang menguji batas logika dan kewarasan pemainnya."
  },
  {
    "title": "Sekiro: Shadows Die Twice",
    "genre": "Action",
    "rating": 9.5,
    "asset": "assets/sekiro.jpg",
    "desc":
        "Sebagai shinobi bernama Wolf, pemain bertugas melindungi tuannya dalam dunia Jepang era Sengoku. Sekiro menghadirkan pertarungan berbasis refleks, fokus pada parry dan timing yang presisi. Ceritanya tentang kehormatan, dendam, dan kehidupan abadi. Dunia yang suram namun indah menggabungkan mitologi Jepang dengan tragedi manusia. Setiap kemenangan terasa seperti pencapaian besar, setiap kekalahan adalah pelajaran tentang kesabaran dan ketekunan."
  },
  {
    "title": "Resident Evil 4 Remake",
    "genre": "Horror",
    "rating": 9.3,
    "asset": "assets/re4.jpg",
    "desc":
        "Leon S. Kennedy kembali dalam misi penyelamatan anak presiden di desa misterius Spanyol. Resident Evil 4 Remake menghidupkan ulang klasik legendaris dengan visual modern, kontrol halus, dan atmosfer menegangkan. Ketegangan, aksi, dan survival horror berpadu sempurna, menghadirkan pengalaman yang menakutkan sekaligus mendebarkan dari awal hingga akhir."
  },
  {
    "title": "Final Fantasy VII Remake",
    "genre": "JRPG",
    "rating": 9.1,
    "asset": "assets/ff7.jpg",
    "desc":
        "Cloud Strife, mantan prajurit elit, bergabung dengan kelompok pemberontak AVALANCHE untuk melawan perusahaan jahat Shinra. Dunia futuristik Midgar hidup dengan energi dan konflik sosial. Pertarungan hybrid yang menggabungkan aksi real-time dan strategi turn-based memberikan pengalaman baru yang dinamis. Remake ini bukan hanya nostalgia, tapi reinterpretasi emosional tentang identitas, kehilangan, dan perjuangan melawan nasib."
  },
  {
    "title": "Monster Hunter: World",
    "genre": "RPG",
    "rating": 9.0,
    "asset": "assets/mhw.jpg",
    "desc":
        "Sebagai pemburu di dunia baru yang luas, pemain menjelajahi ekosistem penuh makhluk raksasa dan berbahaya. Monster Hunter: World menghadirkan sistem perburuan kooperatif yang mendalam, di mana setiap senjata dan monster membutuhkan strategi berbeda. Lingkungan yang interaktif membuat setiap pertempuran terasa hidup dan alami. Ini bukan sekadar berburu — ini adalah seni bertahan hidup di dunia liar yang indah dan mematikan."
  },
  {
    "title": "Persona 5 Royal",
    "genre": "JRPG",
    "rating": 9.5,
    "asset": "assets/persona5.jpg",
    "desc":
        "Sebagai siswa SMA di Tokyo, pemain menjalani kehidupan ganda sebagai anggota Phantom Thieves — kelompok misterius yang mencuri hati orang-orang jahat. Persona 5 Royal menggabungkan kehidupan sosial, eksplorasi dungeon, dan sistem pertarungan bergaya anime. Dengan gaya visual yang mencolok, musik jazzy, dan tema kebebasan melawan tekanan sosial, game ini menyentuh isu identitas dan pemberontakan dengan cara yang elegan dan berani."
  },
  {
    "title": "Cyberpunk 2077",
    "genre": "RPG",
    "rating": 8.8,
    "asset": "assets/cyberpunk.jpg",
    "desc":
        "Selamat datang di Night City — kota masa depan yang dipenuhi cahaya neon dan dosa tersembunyi. Pemain berperan sebagai V, tentara bayaran yang berjuang mencari keabadian dalam dunia penuh korporasi korup, geng berbahaya, dan manusia yang memodifikasi tubuhnya. Cyberpunk 2077 menghadirkan narasi bercabang, kebebasan eksplorasi, dan visual futuristik yang memukau. Ini adalah kisah tentang ambisi, identitas, dan batas antara manusia dan mesin."
  },
  {
    "title": "Dark Souls III",
    "genre": "RPG",
    "rating": 9.0,
    "asset": "assets/darksouls3.jpg",
    "desc":
        "Dark Souls III menutup trilogi legendaris dengan dunia suram yang hancur oleh api dan waktu. Sebagai Ashen One, pemain menjelajahi reruntuhan kerajaan tua dan menghadapi bos monumental. Setiap area penuh simbolisme, setiap kematian mengajarkan kesabaran. Dengan atmosfer gotik dan musik epik, game ini menjadi puncak filosofi FromSoftware tentang penderitaan, ketekunan, dan keindahan dalam kesulitan."
  },
  {
    "title": "Assassin’s Creed Valhalla",
    "genre": "Action",
    "rating": 8.9,
    "asset": "assets/valhalla.jpg",
    "desc":
        "Sebagai Eivor, pejuang Viking yang gagah berani, pemain memimpin klan Norse untuk menaklukkan Inggris abad ke-9. Dunia terbuka yang indah menghadirkan budaya, mitologi, dan pertempuran brutal khas era itu. Selain penaklukan, Valhalla menekankan pembangunan pemukiman dan keputusan moral yang memengaruhi jalan cerita. Ini bukan hanya kisah penyerangan — tapi juga perjalanan tentang keluarga, kehormatan, dan mencari rumah di negeri asing."
  },
  {
    "title": "Call of Duty: Modern Warfare",
    "genre": "Shooter",
    "rating": 8.8,
    "asset": "assets/codmw.jpg",
    "desc":
        "Modern Warfare menghadirkan konflik modern yang realistis dan intens. Pemain mengikuti misi-misi taktis di berbagai negara, menghadapi terorisme global dan dilema etika perang. Kampanye sinematiknya mengguncang emosi, sementara mode multiplayer-nya cepat dan kompetitif. Dengan grafis memukau dan cerita yang menggugah, Modern Warfare mengaburkan batas antara kebenaran dan kejahatan dalam peperangan modern."
  },
];


    genres = ['All', ...allGames.map((g) => g['genre'] as String).toSet()];
    filteredGames = List.from(allGames);
  }

  // Filter genre
  void _filterGames(String genre) {
    setState(() {
      selectedGenre = genre;
      _applyFilters();
    });
  }

  // Filter berdasarkan pencarian + genre
  void _applyFilters() {
    setState(() {
      filteredGames = allGames.where((game) {
        final matchesGenre =
            selectedGenre == 'All' || game['genre'] == selectedGenre;
        final matchesSearch = game['title']
            .toString()
            .toLowerCase()
            .contains(searchQuery.toLowerCase());
        return matchesGenre && matchesSearch;
      }).toList();
    });
  }

  // Update pencarian
  void _searchGames(String query) {
    setState(() {
      searchQuery = query;
      _applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!genres.contains(selectedGenre)) {
      selectedGenre = 'All';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Store'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButton<String>(
              value: selectedGenre,
              dropdownColor: const Color(0xFF161B22),
              icon: const Icon(Icons.filter_list, color: Colors.white),
              underline: const SizedBox(),
              onChanged: (val) {
                if (val != null) _filterGames(val);
              },
              items: genres
                  .map((g) => DropdownMenuItem(
                        value: g,
                        child: Text(
                          g,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // 🔍 TextField pencarian
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: _searchGames,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Cari game...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF161B22),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 🔍 Jika tidak ada hasil
          if (filteredGames.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  searchQuery.isEmpty
                      ? 'Tidak ada game yang tersedia.'
                      : 'Game "${searchQuery}" tidak ditemukan.\nCoba kata kunci lain.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
            )
          else
            // 🕹 Daftar game
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredGames.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, i) {
                  final game = filteredGames[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailPage(game: game)),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF161B22),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: Image.asset(
                                game['asset'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  game['title'] ?? '',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(game['genre'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.grey)),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text('${game['rating']}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}


class DetailPage extends StatefulWidget {
  final Map<String, dynamic> game;
  const DetailPage({super.key, required this.game});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isDownloading = false;
  double progress = 0;

  Future<void> _simulateDownload() async {
    setState(() {
      isDownloading = true;
      progress = 0;
    });

    Timer? timer;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
          if (!mounted) return;
          setState(() {
            progress += 0.05;
          });
          if (progress >= 1.0) {
            t.cancel();
            Future.delayed(const Duration(milliseconds: 200), () {
              if (Navigator.canPop(ctx)) Navigator.of(ctx).pop();
            });
          }
        });

        return AlertDialog(
          backgroundColor: const Color(0xFF161B22),
          title: const Text('Downloading...'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(value: progress),
              const SizedBox(height: 12),
              Text('${(progress * 100).toStringAsFixed(0)}%'),
            ],
          ),
        );
      },
    );

    timer?.cancel();
    if (!mounted) return;

    setState(() => isDownloading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.game['title']} berhasil diunduh!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;

    return Scaffold(
      appBar: AppBar(
        title: Text(game['title']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar utama
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(game['asset']),
            ),
            const SizedBox(height: 16),

            // Judul dan rating
            Text(
              game['title'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.category, color: Colors.blueAccent),
                const SizedBox(width: 6),
                Text(
                  game['genre'],
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(width: 20),
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${game['rating']} / 10',
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
            const Divider(height: 32, color: Colors.white24),

            // Deskripsi
            const Text(
              'Sinopsis:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              game['desc'],
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),

            const SizedBox(height: 30),

            // Tombol Download
            Center(
              child: ElevatedButton.icon(
                onPressed: isDownloading ? null : _simulateDownload,
                icon: const Icon(Icons.download),
                label: const Text('Download Game'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF58A6FF),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
