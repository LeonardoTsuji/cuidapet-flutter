import 'package:cuidapet/app/models/agendamento_model.dart';
import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:cuidapet/app/shared/utils/formatter.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidapet/app/modules/meus_agendamentos/meus_agendamentos_controller.dart';
import 'package:flutter/material.dart';

class MeusAgendamentosPage extends StatefulWidget {
  final String title;
  const MeusAgendamentosPage({Key? key, this.title = 'MeusAgendamentosPage'})
      : super(key: key);
  @override
  MeusAgendamentosPageState createState() => MeusAgendamentosPageState();
}

class MeusAgendamentosPageState
    extends ModularState<MeusAgendamentosPage, MeusAgendamentosController> {
  var statusAgendamento = {
    'P': 'Pendente',
    'CN': 'Confirmada',
    'F': 'Finalizada',
    'C': 'Cancelada',
  };

  @override
  void initState() {
    super.initState();
    controller.buscarAgendamentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de agendamentos'),
      ),
      body: FutureBuilder<List<AgendamentoModel>>(
        future: controller.agendamentosFuture,
        builder: (_, snapshot) {
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
                  child: Text('Erro ao buscar agendamentos'),
                );
              }
              if (snapshot.hasData) {
                var agendamentos = snapshot.data;

                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    var agendamento = agendamentos?[index];
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(Formatter.date('dd/MM/yyyy')
                                .format(agendamento!.dataAgendamento)),
                          ),
                          Card(
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        agendamento.fornecedor.logo),
                                  ),
                                  title: Text(agendamento.fornecedor.nome),
                                  subtitle: Text(
                                      statusAgendamento[agendamento.status]!),
                                ),
                                Divider(),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (_, index) {
                                    var servico = agendamento.servicos[index];
                                    return ListTile(
                                      leading: Icon(
                                        Icons.looks_one,
                                        color: ThemeUtils.primaryColor,
                                      ),
                                      title: Text(servico.nome),
                                    );
                                  },
                                  itemCount: agendamento.servicos.length,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: agendamentos?.length,
                );
              } else {
                return Center(
                  child: Text('Nenhum agendamento realizado'),
                );
              }

            default:
              return Container();
          }
        },
      ),
    );
  }
}
