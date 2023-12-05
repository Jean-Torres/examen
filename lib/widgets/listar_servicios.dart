import 'package:examen/http/cargar_servicio.dart';
import 'package:examen/http/get_dolar.dart';
import 'package:flutter/material.dart';
import 'package:examen/class/servicios.dart';

class ListaServicios extends StatefulWidget {
  final Function(String) funcion;
  const ListaServicios({super.key, required this.funcion});

  @override
  State<ListaServicios> createState() => _ListaServiciosState();
}

class _ListaServiciosState extends State<ListaServicios> {
  PeticionesServicios ps = PeticionesServicios();
  double valorDolar = 0, sumaTotalCop = 0, sumaTotalUsd = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: ps.getServicios(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Expanded(
                  child: ListView(
                children: servicios(snapshot.data, context),
              ))
            ],
          );
        }
        return const Text("Sin datos");
      },
    );
  }

  Future<void> getDolar(double dolarHoy) async {
    PeticionesDolar pd = PeticionesDolar();
    var response = pd.getDolar();
    await response.then((value) => {
          valorDolar = double.parse(value[0]["valor"]),
          valorDolar = (dolarHoy / valorDolar),
          sumaTotalUsd += valorDolar,
        });
  }

  String update(double dolarHoy) {
    getDolar(dolarHoy);
    return valorDolar.toString();
  }

  void valoresActualizar(String numero, String placa, String horas,
      String precioCop, String observaciones, String idServicio) {
    ValoresServicio vs = ValoresServicio();

    vs.setNumeroServicio(numero);
    vs.setPlacaServicio(placa);
    vs.setHoraServicio(horas);
    vs.setPrecioCopServicio(precioCop);
    vs.setObservacionesServicio(observaciones);
    vs.setIdServicio(idServicio);
  }

  List<Widget> servicios(List<dynamic> infom, BuildContext context) {
    List<Widget> servicio = [];

    for (var element in infom) {
      sumaTotalCop += element["precioReparacion"];
      servicio.add(
        GestureDetector(
          onTap: () => {
            widget.funcion("Eliminar servicio"),
            valoresActualizar(
                element["numero"].toString(),
                element["placa"].toString(),
                element["horaReparacion"].toString(),
                element["precioReparacion"].toString(),
                element["observaciones"].toString(),
                element["_id"].toString())
          },
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: 350,
                      child: Column(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              height: 40,
                              child: Column(
                                children: [
                                  CaracteristicaServicio(
                                    titulo: "Numero",
                                    subTitulo: element["numero"].toString(),
                                  ),
                                  CaracteristicaServicio(
                                    titulo: "Placa",
                                    subTitulo: element["placa"].toString(),
                                  ),
                                  CaracteristicaServicio(
                                    titulo: "hora de reparacion",
                                    subTitulo:
                                        element["horaReparacion"].toString(),
                                  ),
                                  CaracteristicaServicio(
                                    titulo: "precio de reparacion en Cop",
                                    subTitulo:
                                        element["precioReparacion"].toString(),
                                  ),
                                  CaracteristicaServicio(
                                      titulo: "precio de reparacion en usd",
                                      subTitulo: update(double.parse(
                                          element["precioReparacion"]
                                              .toString()))),
                                  CaracteristicaServicio(
                                    titulo: "observaciones",
                                    subTitulo:
                                        element["observaciones"].toString(),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      );
    }
    servicio.add(
      Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Card(
            child: Column(
              children: [
                SizedBox(
                  height: 350,
                  child: Column(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 40,
                          child: Column(
                            children: [
                              CaracteristicaServicio(
                                titulo: "Suma total peso",
                                subTitulo: sumaTotalCop.toString(),
                              ),
                              CaracteristicaServicio(
                                titulo: "Suma total dolar",
                                subTitulo: sumaTotalUsd.toString(),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
    return servicio;
  }
}

class CaracteristicaServicio extends StatelessWidget {
  final String titulo;
  final String subTitulo;

  const CaracteristicaServicio({
    super.key,
    required this.titulo,
    required this.subTitulo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width - 50,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            titulo,
          ),
        ),
        subtitle: Text(
          subTitulo,
        ),
      ),
    );
  }
}
