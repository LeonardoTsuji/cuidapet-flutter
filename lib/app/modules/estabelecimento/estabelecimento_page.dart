import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:cuidapet/app/models/fornecedor_model.dart';
import 'package:cuidapet/app/models/fornecedor_servico_model.dart';
import 'package:cuidapet/app/modules/estabelecimento/estabelecimento_controller.dart';
import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:cuidapet/app/shared/utils/formatter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EstabelecimentoPage extends StatefulWidget {
  final int estabelecimentoId;
  final String title;
  const EstabelecimentoPage(
      {Key? key,
      required this.estabelecimentoId,
      this.title = 'EstabelecimentoPage'})
      : super(key: key);
  @override
  EstabelecimentoPageState createState() => EstabelecimentoPageState();
}

class EstabelecimentoPageState
    extends ModularState<EstabelecimentoPage, EstabelecimentoController> {
  @override
  void initState() {
    super.initState();
    controller.initPage(widget.estabelecimentoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Observer(builder: (_) {
        return AnimatedOpacity(
          duration: Duration(microseconds: 300),
          opacity: controller.servicosSelecionados.isNotEmpty ? 1 : 0,
          child: FloatingActionButton.extended(
            onPressed: () => Modular.to.pushNamed('/agendamento', arguments: {
              'estabelecimentoId': widget.estabelecimentoId,
              'servicosSelecionados': controller.servicosSelecionados,
            }),
            label: Text('Fazer agendamento'),
            icon: Icon(Icons.schedule),
            backgroundColor: ThemeUtils.primaryColor,
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return FutureBuilder<FornecedorModel>(
        future: controller.fornecedorFuture,
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
                  child: Text('Erro ao buscar dados do fornecedor'),
                );
              }
              if (snapshot.hasData) {
                var fornecedor = snapshot.data;

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 300,
                      pinned: true,
                      backgroundColor: Colors.white,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(fornecedor?.nome ?? ''),
                        stretchModes: [
                          StretchMode.zoomBackground,
                          StretchMode.fadeTitle,
                        ],
                        background: Image.network(fornecedor?.logo ?? ''),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Divider(
                            thickness: 1,
                            color: ThemeUtils.primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Informações do estabelecimento',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: fornecedor?.endereco),
                              ).then((value) =>
                                  AsukaSnackbar.info("Endereço copiado")
                                      .show());
                            },
                            leading: Icon(
                              Icons.location_city,
                              color: Colors.black,
                            ),
                            title: Text(fornecedor?.endereco ?? ''),
                          ),
                          ListTile(
                            onTap: () async {
                              if (await canLaunch(
                                  'tel:${fornecedor?.telefone}')) {
                                await launch('tel:${fornecedor?.telefone}');
                              } else {
                                await Clipboard.setData(
                                  ClipboardData(text: fornecedor?.telefone),
                                ).then((value) =>
                                    AsukaSnackbar.info("Telefone copiado")
                                        .show());
                              }
                            },
                            leading: Icon(
                              Icons.local_phone,
                              color: Colors.black,
                            ),
                            title: Text(fornecedor?.telefone ?? ''),
                          ),
                          Divider(
                            thickness: 1,
                            color: ThemeUtils.primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Observer(builder: (_) {
                              return Text(
                                'Serviços (${controller.servicosSelecionados.length} selecionado${controller.servicosSelecionados.length > 1 ? 's' : ''})',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              );
                            }),
                          ),
                          buildServicos(),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: Text('Nenhum estabelecimento cadastrado'),
                );
              }

            default:
              return Container();
          }
        });
  }

  Widget buildServicos() {
    return Observer(builder: (_) {
      return FutureBuilder<List<FornecedorServicoModel>>(
          future: controller.fornecedorServicoFuture,
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
                    child: Text('Erro ao buscar serviços do fornecedor'),
                  );
                }
                if (snapshot.hasData) {
                  var servicos = snapshot.data;

                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          bottom: controller.servicosSelecionados.isNotEmpty
                              ? 150
                              : 0),
                      itemBuilder: (context, index) {
                        var servico = servicos?[index];
                        return Observer(builder: (_) {
                          return ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.pets),
                            ),
                            title: Text(servico?.nome ?? ''),
                            subtitle: Text(
                                Formatter.currency().format(servico?.valor)),
                            trailing: IconButton(
                              onPressed: () => controller
                                  .adicionarOuRemoverServico(servico!),
                              icon: controller.servicosSelecionados
                                      .contains(servico!)
                                  ? Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                      size: 24,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: ThemeUtils.primaryColor,
                                      size: 24,
                                    ),
                            ),
                          );
                        });
                      },
                      itemCount: servicos?.length ?? 0);
                } else {
                  return Center(
                    child: Text('Nenhum estabelecimento cadastrado'),
                  );
                }

              default:
                return Container();
            }
          });
    });
  }
}
