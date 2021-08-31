import 'package:cuidapet/app/models/categorias_model.dart';
import 'package:cuidapet/app/models/fornecedor_busca_model.dart';
import 'package:cuidapet/app/modules/home/components/home_drawer.dart';
import 'package:cuidapet/app/modules/home/home_controller.dart';
import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({this.title = "Home"});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final categoriasIcons = {
    'P': Icons.pets,
    'V': Icons.local_hospital,
    'C': Icons.store_mall_directory
  };
  final _estabelecimentoPageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    controller.initPage();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = PreferredSize(
      preferredSize: Size(double.infinity, 100),
      child: AppBar(
        backgroundColor: Colors.grey[100]!,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'Cuidapet',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        elevation: 0,
        flexibleSpace: Stack(
          children: <Widget>[
            Container(
              height: 110,
              width: double.infinity,
              color: ThemeUtils.primaryColor,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: ScreenUtil.defaultSize.width * .9,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(32),
                  child: TextFormField(
                    controller: controller.filtroNomeController,
                    onChanged: (nome) =>
                        controller.filtrarFornecedoresPorNome(),
                    decoration: InputDecoration(
                      filled: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 18),
                        child: Icon(
                          Icons.search,
                          size: 24,
                        ),
                      ),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.grey[200]!,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.grey[200]!,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.grey[200]!,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () async {
              await Modular.to.pushNamed('/home/enderecos');
              await controller.recuperarEnderecoSelecionado();
              await controller.buscarFornecedores();
            },
          ),
        ],
      ),
    );
    return Scaffold(
      drawer: HomeDrawer(),
      backgroundColor: Colors.grey[100]!,
      appBar: appBar,
      body: RefreshIndicator(
        onRefresh: () => controller.buscarFornecedores(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            width: ScreenUtil.defaultSize.width,
            height: ScreenUtil.defaultSize.height -
                (appBar.preferredSize.height + ScreenUtil().statusBarHeight),
            child: Column(
              children: <Widget>[
                _buildEndereco(),
                _buildCategorias(),
                Expanded(child: _buildEstabelecimentos())
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Container _buildEndereco() {
    return Container(
      padding: EdgeInsets.all(18),
      child: Column(
        children: <Widget>[
          Text('Estabelecimentos próximos de '),
          Observer(builder: (_) {
            return Text(
              controller.enderecoSelecionado?.endereco ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategorias() {
    return Observer(builder: (_) {
      return FutureBuilder<List<CategoriaModel>>(
          future: controller.categoriasFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container();
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao buscar categorias'),
                  );
                }
                if (snapshot.hasData) {
                  var categorias = snapshot.data;

                  return Container(
                    height: 150,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: categorias?.length,
                        itemBuilder: (context, index) {
                          var categoria = categorias?[index];
                          return InkWell(
                            onTap: () => controller
                                .filtrarPorCategoria(categoria?.id ?? 0),
                            child: Container(
                              margin: EdgeInsets.all(24),
                              child: Column(
                                children: <Widget>[
                                  Observer(builder: (_) {
                                    return CircleAvatar(
                                      backgroundColor:
                                          controller.categoriaSelecionada ==
                                                  categoria?.id
                                              ? ThemeUtils.primaryColor
                                              : ThemeUtils.primaryColorLight,
                                      child: Icon(
                                        categoriasIcons[categoria?.tipo],
                                        size: 32,
                                        color: Colors.black,
                                      ),
                                      radius: 32,
                                    );
                                  }),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(categoria?.nome ?? ''),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return Center(
                    child: Text('Nenhuma categoria cadastrada'),
                  );
                }

              default:
                return Container();
            }
          });
    });
  }

  Widget _buildEstabelecimentos() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Observer(builder: (_) {
            return Row(
              children: <Widget>[
                Text('Estabelecimentos'),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Icon(
                      Icons.view_headline,
                      color: controller.paginaSelecionada == 0
                          ? Colors.black
                          : Colors.grey,
                    ),
                    onTap: () {
                      _estabelecimentoPageController.previousPage(
                          duration: Duration(microseconds: 200),
                          curve: Curves.ease);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Icon(
                      Icons.view_comfy,
                      color: controller.paginaSelecionada == 1
                          ? Colors.black
                          : Colors.grey,
                    ),
                    onTap: () {
                      _estabelecimentoPageController.nextPage(
                          duration: Duration(microseconds: 200),
                          curve: Curves.ease);
                    },
                  ),
                ),
              ],
            );
          }),
        ),
        Expanded(
            child: PageView(
          controller: _estabelecimentoPageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (pagina) =>
              controller.alterarPaginaSelecionada(pagina),
          children: <Widget>[
            _buildEstabelecimentosLista(),
            _buildEstabelecimentosGrid(),
          ],
        ))
      ],
    );
  }

  Widget _buildEstabelecimentosLista() {
    return Observer(builder: (_) {
      return FutureBuilder(
          future: controller.fornecedoresFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container();
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao buscar fornecedores'),
                  );
                }
                if (snapshot.hasData) {
                  var fornecedores =
                      snapshot.data as List<FornecedorBuscaModel>?;

                  return Container(
                    height: 150,
                    child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var fornecedor = fornecedores?[index];
                          return InkWell(
                            onTap: () => Modular.to.pushNamed(
                                '/estabelecimento/${fornecedor?.id}'),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 32),
                                    width: ScreenUtil.defaultSize.width,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 52),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(fornecedor?.nome ?? ''),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 16,
                                                    color: Colors.grey[500],
                                                  ),
                                                  Text(fornecedor?.distancia
                                                          .toStringAsFixed(2) ??
                                                      '')
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          margin: EdgeInsets.all(12),
                                          child: CircleAvatar(
                                            backgroundColor:
                                                ThemeUtils.primaryColor,
                                            maxRadius: 16,
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey[100]!,
                                              width: 4),
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                fornecedor?.logo ?? ''),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, index) => Divider(
                              color: Colors.transparent,
                            ),
                        itemCount: fornecedores?.length ?? 0),
                  );
                } else {
                  return Center(
                    child: Text('Nenhum fornecedor cadastrado'),
                  );
                }

              default:
                return Container();
            }
          });
    });
  }

  Widget _buildEstabelecimentosGrid() {
    return FutureBuilder(
        future: controller.fornecedoresFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao buscar fornecedores'),
                );
              }
              if (snapshot.hasData) {
                var fornecedores = snapshot.data as List<FornecedorBuscaModel>?;
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    var fornecedor = fornecedores?[index];
                    return InkWell(
                      onTap: () => Modular.to
                          .pushNamed('/estabelecimento/${fornecedor?.id}'),
                      child: Stack(
                        children: <Widget>[
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            margin:
                                EdgeInsets.only(top: 44, left: 12, right: 12),
                            elevation: 4,
                            child: Container(
                              width: double.infinity,
                              height: 120,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 40, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(fornecedor?.nome ?? '',
                                        style: ThemeUtils
                                            .theme?.textTheme.subtitle2),
                                    Text(fornecedor?.distancia
                                            .toStringAsFixed(2) ??
                                        '')
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[200],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: CircleAvatar(
                                radius: 34,
                                backgroundImage:
                                    NetworkImage(fornecedor?.logo ?? ''),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: fornecedores?.length ?? 0,
                );
              } else {
                return Center(
                  child: Text('Nenhum fornecedor cadastrado'),
                );
              }

            default:
              return Container();
          }
        });
  }
}
