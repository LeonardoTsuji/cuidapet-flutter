import 'package:cuidapet/app/shared/components/cuidapet_textformfield.dart';
import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:cuidapet/app/shared/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:cuidapet/app/models/fornecedor_servico_model.dart';
import 'package:cuidapet/app/modules/agendamento/agendamento_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgendamentoPage extends StatefulWidget {
  final int estabelecimento;
  final List<FornecedorServicoModel> servicos;

  const AgendamentoPage({
    Key? key,
    required this.estabelecimento,
    required this.servicos,
  }) : super(key: key);

  @override
  AgendamentoPageState createState() => AgendamentoPageState();
}

class AgendamentoPageState
    extends ModularState<AgendamentoPage, AgendamentoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('Escolha uma data'),
          backgroundColor: Colors.transparent,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Observer(builder: (_) {
                return CalendarCarousel(
                  locale: 'pt_BR',
                  headerTextStyle:
                      TextStyle(color: ThemeUtils.primaryColor, fontSize: 24),
                  height: 420,
                  iconColor: ThemeUtils.primaryColor!,
                  customGridViewPhysics: NeverScrollableScrollPhysics(),
                  selectedDateTime: controller.dataSelecionada,
                  onDayPressed: (day, _) => controller.alterarData(day),
                );
              }),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      ThemeUtils.primaryColor!),
                ),
                onPressed: () async {
                  var horario = await showTimePicker(
                      context: context,
                      initialTime:
                          controller.horarioSelecionado ?? TimeOfDay.now());
                  controller.alterarHorario(horario);
                },
                child: Column(
                  children: [
                    Text('Selecione um horário'),
                    Observer(builder: (_) {
                      return Text(
                          '${controller.horarioSelecionado!.hour}:${controller.horarioSelecionado!.minute}');
                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Serviços',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    var servico = widget.servicos[index];
                    return ListTile(
                      title: Text(servico.nome),
                      subtitle:
                          Text(Formatter.currency().format(servico.valor)),
                    );
                  },
                  itemCount: widget.servicos.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Dados para reserva',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CuidapetTextFormField(
                        label: 'Seu nome',
                        controller: controller.nomeController,
                        validator: (String? valor) {
                          if (valor!.isEmpty) {
                            return 'Nome obrigatório';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CuidapetTextFormField(
                        label: 'Nome do pet',
                        controller: controller.petController,
                        validator: (String? valor) {
                          if (valor!.isEmpty) {
                            return 'Nome do pet obrigatório';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                width: ScreenUtil.defaultSize.width * .9,
                height: 60,
                child: ElevatedButton(
                  onPressed: () => controller.salvarAgendamento(
                      widget.estabelecimento, widget.servicos),
                  child: Text(
                    'Agendar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: ThemeUtils.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
