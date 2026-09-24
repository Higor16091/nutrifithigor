import 'package:flutter/material.dart';

void main() {
  runApp(const NutriFitApp());
}

class NutriFitApp extends StatelessWidget {
  const NutriFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriFit',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F8F6),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF208B57),
        ),
      ),
      home: const HomePage(),
    );
  }
}

// ============================================================
// CORES
// ============================================================

const Color verde = Color(0xFF208B57);
const Color verdeEscuro = Color(0xFF12613B);
const Color verdeClaro = Color(0xFFE7F5ED);
const Color fundo = Color(0xFFF6F8F6);
const Color texto = Color(0xFF18231D);
const Color cinza = Color(0xFF707A74);

// ============================================================
// MODELO DE RECEITA
// ============================================================

class Receita {
  final String nome;
  final String categoria;
  final String emoji;
  final String descricao;
  final int calorias;
  final int proteinas;
  final int carboidratos;
  final int gorduras;
  final String tempo;

  const Receita({
    required this.nome,
    required this.categoria,
    required this.emoji,
    required this.descricao,
    required this.calorias,
    required this.proteinas,
    required this.carboidratos,
    required this.gorduras,
    required this.tempo,
  });
}

// ============================================================
// RECEITAS
// ============================================================

const List<Receita> receitas = [
  Receita(
    nome: 'Bowl Proteico',
    categoria: 'Almoço',
    emoji: '🥗',
    descricao:
    'Frango grelhado, arroz integral, abacate, tomate e folhas frescas.',
    calorias: 420,
    proteinas: 38,
    carboidratos: 42,
    gorduras: 13,
    tempo: '25 min',
  ),
  Receita(
    nome: 'Panqueca de Banana',
    categoria: 'Café da manhã',
    emoji: '🥞',
    descricao:
    'Panqueca saudável preparada com banana, aveia, ovos e canela.',
    calorias: 280,
    proteinas: 15,
    carboidratos: 35,
    gorduras: 8,
    tempo: '15 min',
  ),
  Receita(
    nome: 'Wrap de Frango',
    categoria: 'Jantar',
    emoji: '🌯',
    descricao:
    'Wrap integral com frango desfiado, alface, tomate e creme de ricota.',
    calorias: 350,
    proteinas: 32,
    carboidratos: 34,
    gorduras: 10,
    tempo: '20 min',
  ),
  Receita(
    nome: 'Açaí Power',
    categoria: 'Lanche',
    emoji: '🫐',
    descricao:
    'Açaí sem açúcar com banana, morango, chia e granola integral.',
    calorias: 310,
    proteinas: 9,
    carboidratos: 45,
    gorduras: 9,
    tempo: '10 min',
  ),
  Receita(
    nome: 'Omelete Fit',
    categoria: 'Café da manhã',
    emoji: '🍳',
    descricao:
    'Omelete com ovos, queijo branco, tomate e ervas.',
    calorias: 260,
    proteinas: 24,
    carboidratos: 7,
    gorduras: 15,
    tempo: '12 min',
  ),
  Receita(
    nome: 'Frango com Batata-doce',
    categoria: 'Almoço',
    emoji: '🍗',
    descricao:
    'Frango grelhado com batata-doce assada e legumes.',
    calorias: 430,
    proteinas: 42,
    carboidratos: 37,
    gorduras: 11,
    tempo: '30 min',
  ),
];

// ============================================================
// HOME
// ============================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int categoriaSelecionada = 0;

  final List<String> categorias = [
    'Todos',
    'Café da manhã',
    'Almoço',
    'Lanche',
    'Jantar',
  ];

  List<Receita> get receitasFiltradas {
    if (categoriaSelecionada == 0) {
      return receitas;
    }

    return receitas
        .where(
          (receita) =>
      receita.categoria ==
          categorias[categoriaSelecionada],
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuLateral(),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: texto,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Row(
          children: [
            LogoNutriFit(tamanho: 36),
            SizedBox(width: 10),
            Text(
              'NutriFit',
              style: TextStyle(
                color: texto,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: texto,
            ),
            onPressed: () {
              mostrarMensagem(
                context,
                'Você não possui novas notificações.',
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bom dia! 👋',
                      style: TextStyle(
                        color: cinza,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'O que vamos comer\nhoje?',
                      style: TextStyle(
                        color: texto,
                        fontSize: 29,
                        height: 1.15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // PESQUISA
                    Container(
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFE2E8E4),
                        ),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                          'Buscar receitas...',
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: verde,
                          ),
                          suffixIcon: Icon(
                            Icons.tune_rounded,
                            color: cinza,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 26),

                    const Text(
                      'Categorias',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: texto,
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      height: 42,
                      child: ListView.builder(
                        scrollDirection:
                        Axis.horizontal,
                        itemCount: categorias.length,
                        itemBuilder:
                            (context, index) {
                          final selecionada =
                              categoriaSelecionada ==
                                  index;

                          return Padding(
                            padding:
                            const EdgeInsets.only(
                              right: 8,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  categoriaSelecionada =
                                      index;
                                });
                              },
                              child: Container(
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  horizontal: 17,
                                ),
                                alignment:
                                Alignment.center,
                                decoration:
                                BoxDecoration(
                                  color: selecionada
                                      ? verde
                                      : Colors.white,
                                  borderRadius:
                                  BorderRadius
                                      .circular(13),
                                  border: Border.all(
                                    color: selecionada
                                        ? verde
                                        : const Color(
                                      0xFFE0E6E2,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  categorias[index],
                                  style: TextStyle(
                                    color: selecionada
                                        ? Colors.white
                                        : texto,
                                    fontSize: 12,
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 28),

                    // DESTAQUE
                    Container(
                      width: double.infinity,
                      padding:
                      const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient:
                        const LinearGradient(
                          colors: [
                            verdeEscuro,
                            verde,
                          ],
                        ),
                        borderRadius:
                        BorderRadius.circular(22),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Text(
                                  'RECEITA DO DIA',
                                  style: TextStyle(
                                    color:
                                    Colors.white70,
                                    fontSize: 10,
                                    fontWeight:
                                    FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Bowl Proteico',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '420 kcal • 38g proteína',
                                  style: TextStyle(
                                    color:
                                    Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Text(
                            '🥗',
                            style: TextStyle(
                              fontSize: 68,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Receitas para você',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: texto,
                      ),
                    ),

                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              sliver: SliverList(
                delegate:
                SliverChildBuilderDelegate(
                      (context, index) {
                    final receita =
                    receitasFiltradas[index];

                    return Padding(
                      padding:
                      const EdgeInsets.only(
                        bottom: 14,
                      ),
                      child: CardReceita(
                        receita: receita,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalhesPage(
                                    receita: receita,
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  childCount:
                  receitasFiltradas.length,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 25),
            ),
          ],
        ),
      ),

      bottomNavigationBar:
      const BarraNavegacao(),
    );
  }
}

// ============================================================
// CARD
// ============================================================

class CardReceita extends StatelessWidget {
  final Receita receita;
  final VoidCallback onTap;

  const CardReceita({
    super.key,
    required this.receita,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE4E9E5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: verdeClaro,
                borderRadius:
                BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              child: Text(
                receita.emoji,
                style: const TextStyle(
                  fontSize: 43,
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    receita.categoria
                        .toUpperCase(),
                    style: const TextStyle(
                      color: verde,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    receita.nome,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: texto,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 9),

                  Row(
                    children: [
                      const Icon(
                        Icons
                            .local_fire_department_rounded,
                        color: Colors.orange,
                        size: 15,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${receita.calorias} kcal',
                        style: const TextStyle(
                          color: cinza,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.timer_outlined,
                        color: cinza,
                        size: 15,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        receita.tempo,
                        style: const TextStyle(
                          color: cinza,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: cinza,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DETALHES
// ============================================================

class DetalhesPage extends StatelessWidget {
  final Receita receita;

  const DetalhesPage({
    super.key,
    required this.receita,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite_border_rounded,
            ),
            onPressed: () {
              mostrarMensagem(
                context,
                'Receita adicionada aos favoritos.',
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: verdeClaro,
              alignment: Alignment.center,
              child: Text(
                receita.emoji,
                style: const TextStyle(
                  fontSize: 125,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: verdeClaro,
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                    child: Text(
                      receita.categoria,
                      style: const TextStyle(
                        color: verde,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    receita.nome,
                    style: const TextStyle(
                      color: texto,
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    receita.descricao,
                    style: const TextStyle(
                      color: cinza,
                      height: 1.5,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // RESUMO
                  Container(
                    padding:
                    const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(
                          0xFFE2E8E4,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceAround,
                      children: [
                        Info(
                          icone: Icons
                              .local_fire_department,
                          valor:
                          '${receita.calorias}',
                          nome: 'kcal',
                          cor: Colors.orange,
                        ),
                        Info(
                          icone:
                          Icons.timer_outlined,
                          valor:
                          receita.tempo,
                          nome: 'preparo',
                          cor: verde,
                        ),
                        Info(
                          icone:
                          Icons.fitness_center,
                          valor:
                          '${receita.proteinas}g',
                          nome: 'proteína',
                          cor: Colors.blue,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    'Informações nutricionais',
                    style: TextStyle(
                      color: texto,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Nutricao(
                    nome: 'Proteínas',
                    valor:
                    '${receita.proteinas} g',
                    progresso: 0.85,
                    cor: verde,
                  ),

                  Nutricao(
                    nome: 'Carboidratos',
                    valor:
                    '${receita.carboidratos} g',
                    progresso: 0.60,
                    cor: Colors.orange,
                  ),

                  Nutricao(
                    nome: 'Gorduras',
                    valor:
                    '${receita.gorduras} g',
                    progresso: 0.35,
                    cor: Colors.blue,
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        mostrarMensagem(
                          context,
                          'Receita salva com sucesso!',
                        );
                      },
                      icon: const Icon(
                        Icons.bookmark_border_rounded,
                      ),
                      label: const Text(
                        'Salvar receita',
                      ),
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor: verde,
                        foregroundColor:
                        Colors.white,
                        elevation: 0,
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// INFO
// ============================================================

class Info extends StatelessWidget {
  final IconData icone;
  final String valor;
  final String nome;
  final Color cor;

  const Info({
    super.key,
    required this.icone,
    required this.valor,
    required this.nome,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icone,
          color: cor,
          size: 23,
        ),
        const SizedBox(height: 6),
        Text(
          valor,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Text(
          nome,
          style: const TextStyle(
            color: cinza,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// NUTRIÇÃO
// ============================================================

class Nutricao extends StatelessWidget {
  final String nome;
  final String valor;
  final double progresso;
  final Color cor;

  const Nutricao({
    super.key,
    required this.nome,
    required this.valor,
    required this.progresso,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(bottom: 17),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nome,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                valor,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          ClipRRect(
            borderRadius:
            BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progresso,
              minHeight: 7,
              backgroundColor:
              const Color(0xFFE3E9E5),
              valueColor:
              AlwaysStoppedAnimation<Color>(
                cor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LOGO
// ============================================================

class LogoNutriFit extends StatelessWidget {
  final double tamanho;

  const LogoNutriFit({
    super.key,
    this.tamanho = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tamanho,
      height: tamanho,
      decoration: BoxDecoration(
        color: verdeClaro,
        shape: BoxShape.circle,
        border: Border.all(
          color: verde,
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.eco_rounded,
            color: verde,
            size: tamanho * 0.60,
          ),
          Positioned(
            right: tamanho * 0.10,
            bottom: tamanho * 0.10,
            child: Icon(
              Icons.favorite_rounded,
              color: Colors.redAccent,
              size: tamanho * 0.24,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DRAWER
// ============================================================

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              22,
              65,
              22,
              28,
            ),
            color: verde,
            child: const Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                LogoNutriFit(
                  tamanho: 65,
                ),
                SizedBox(height: 15),
                Text(
                  'NutriFit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Seu estilo de vida saudável.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          ItemMenu(
            icone: Icons.home_rounded,
            texto: 'Início',
            selecionado: true,
            aoClicar: () {
              Navigator.pop(context);
            },
          ),

          ItemMenu(
            icone: Icons.restaurant_menu_rounded,
            texto: 'Receitas',
            aoClicar: () {
              Navigator.pop(context);
            },
          ),

          ItemMenu(
            icone: Icons.favorite_rounded,
            texto: 'Favoritos',
            aoClicar: () {
              Navigator.pop(context);
            },
          ),

          ItemMenu(
            icone: Icons.calendar_month_rounded,
            texto: 'Planejamento',
            aoClicar: () {
              Navigator.pop(context);
            },
          ),

          ItemMenu(
            icone: Icons.analytics_rounded,
            texto: 'Meu progresso',
            aoClicar: () {
              Navigator.pop(context);
            },
          ),

          ItemMenu(
            icone: Icons.settings_rounded,
            texto: 'Configurações',
            aoClicar: () {
              Navigator.pop(context);
            },
          ),

          const Spacer(),

          const Divider(),

          ItemMenu(
            icone: Icons.help_outline_rounded,
            texto: 'Ajuda',
            aoClicar: () {
              Navigator.pop(context);
            },
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

// ============================================================
// ITEM MENU
// ============================================================

class ItemMenu extends StatelessWidget {
  final IconData icone;
  final String texto;
  final bool selecionado;
  final VoidCallback aoClicar;

  const ItemMenu({
    super.key,
    required this.icone,
    required this.texto,
    required this.aoClicar,
    this.selecionado = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: selecionado
            ? verdeClaro
            : Colors.transparent,
        borderRadius:
        BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icone,
          color:
          selecionado ? verde : cinza,
        ),
        title: Text(
          texto,
          style: TextStyle(
            color:
            selecionado ? verde : Color(0xFF18231D),
            fontWeight: selecionado
                ? FontWeight.bold
                : FontWeight.w500,
          ),
        ),
        onTap: aoClicar,
      ),
    );
  }
}

// ============================================================
// BARRA INFERIOR
// ============================================================

class BarraNavegacao extends StatelessWidget {
  const BarraNavegacao({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.white,
      selectedIndex: 0,
      indicatorColor: verdeClaro,
      onDestinationSelected: (index) {
        if (index != 0) {
          String mensagem;

          if (index == 1) {
            mensagem = 'Receitas';
          } else if (index == 2) {
            mensagem = 'Favoritos';
          } else {
            mensagem = 'Perfil';
          }

          mostrarMensagem(
            context,
            'Abrindo $mensagem...',
          );
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(
            Icons.home_outlined,
          ),
          selectedIcon: Icon(
            Icons.home_rounded,
            color: verde,
          ),
          label: 'Início',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.restaurant_menu_outlined,
          ),
          selectedIcon: Icon(
            Icons.restaurant_menu_rounded,
            color: verde,
          ),
          label: 'Receitas',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.favorite_border_rounded,
          ),
          selectedIcon: Icon(
            Icons.favorite_rounded,
            color: verde,
          ),
          label: 'Favoritos',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.person_outline_rounded,
          ),
          selectedIcon: Icon(
            Icons.person_rounded,
            color: verde,
          ),
          label: 'Perfil',
        ),
      ],
    );
  }
}

// ============================================================
// SNACKBAR
// ============================================================

void mostrarMensagem(
    BuildContext context,
    String mensagem,
    ) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mensagem),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
