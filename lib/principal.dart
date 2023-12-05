import 'package:examen/class/servicios.dart';
import 'package:examen/widgets/formulario.dart';
import 'package:examen/widgets/listar_servicios.dart';
import 'package:examen/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  String selectedOption = "inicio";
  String? numero;
  String? placa;
  String? horas;
  String? precioCop;
  String? observaciones;
  String? idServicio;

  void selectDrawerOption(String option) {
    ValoresServicio vs = ValoresServicio();
    numero = vs.getNumeroServicio();
    placa = vs.getPlacaServicio();
    horas = vs.getHorasServicio();
    precioCop = vs.getPrecioCopServicio();
    observaciones = vs.getObservacionServicio();
    observaciones = vs.getIdServicio();
    setState(() {
      selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: MenuLateral(onChanged: selectDrawerOption),
        appBar: AppBar(title: const Text("Taller mecanico"), actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.restart_alt))
        ]),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    switch (selectedOption) {
      case "inicio":
        return ListaServicios(funcion: selectDrawerOption);
      case "nuevo servicio":
        return NuevoServicio(
          callback: selectDrawerOption,
          titulo: 'Nuevo servicio',
        );
      case "Eliminar servicio":
        return NuevoServicio(
          callback: selectDrawerOption,
          numero: numero,
          placa: placa,
          horas: horas,
          precioCop: precioCop,
          observaciones: observaciones,
          idServicio: idServicio,
          titulo: 'Editar Servicio',
        );
    }
    return ListaServicios(funcion: selectDrawerOption);
  }
}
