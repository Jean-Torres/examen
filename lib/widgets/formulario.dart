import 'package:examen/class/validaciones.dart';
import 'package:examen/http/cargar_servicio.dart';
import 'package:examen/widgets/inputs.dart';
import 'package:flutter/material.dart';

class NuevoServicio extends StatefulWidget {
  final Function(String) callback;
  final String titulo;
  final String? idServicio;
  final String? numero;
  final String? placa;
  final String? horas;
  final String? precioCop;
  final String? observaciones;

  const NuevoServicio(
      {super.key,
      required this.callback,
      this.numero,
      this.placa,
      this.horas,
      this.precioCop,
      this.observaciones,
      required this.titulo,
      this.idServicio});

  @override
  State<NuevoServicio> createState() => _NuevoServicioState();
}

class _NuevoServicioState extends State<NuevoServicio> {
  @override
  void initState() {
    super.initState();

    jtNombreCtrl.text = widget.placa ?? "";
    jtPrecioCtrl.text = widget.precioCop ?? "";
    jtDescirpionCtrl.text = widget.horas ?? "";
    jtObservacionesCtrl.text = widget.observaciones ?? "";
    jtCodigoCtrl.text = widget.numero ?? "";
  }

  TextEditingController jtIdServicioCtrl = TextEditingController();
  TextEditingController jtNombreCtrl = TextEditingController();
  TextEditingController jtDescirpionCtrl = TextEditingController();
  TextEditingController jtPrecioCtrl = TextEditingController();
  TextEditingController jtCategoriaCtrl = TextEditingController();
  TextEditingController jtCodigoCtrl = TextEditingController();
  TextEditingController jtObservacionesCtrl = TextEditingController();
  GlobalKey<FormState> formNuevoRegistro = GlobalKey();
  Validaciones validaciones = Validaciones();

  List<String> categorias = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(widget.titulo),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                height: 500,
                child: SingleChildScrollView(
                  child: Form(
                      key: formNuevoRegistro,
                      child: Column(
                        children: [
                          Inputs(
                            titulo: "Numero",
                            labelInput: "numero",
                            colorFocus: Colors.black,
                            borderRadius: 5,
                            marginInput: 10,
                            controller: jtCodigoCtrl,
                            soloLectura: false,
                            validacion: validaciones.camposNumeros,
                          ),
                          Inputs(
                              titulo: "Placa",
                              labelInput: "placa",
                              colorFocus: Colors.black,
                              borderRadius: 5,
                              marginInput: 10,
                              controller: jtNombreCtrl,
                              validacion: validaciones.camposNumeroTexto),
                          Inputs(
                            titulo: "horas de reparacion",
                            labelInput: "horas de reparacion",
                            colorFocus: Colors.black,
                            borderRadius: 5,
                            marginInput: 10,
                            controller: jtDescirpionCtrl,
                            validacion: validaciones.camposNumeroTexto,
                          ),
                          Inputs(
                              titulo: "precio de reparacion",
                              labelInput: "Precio de reparacion",
                              colorFocus: Colors.black,
                              borderRadius: 5,
                              tipoInput: TextInputType.datetime,
                              controller: jtPrecioCtrl,
                              validacion: validaciones.camposNumeros),
                          Inputs(
                              titulo: "Observaciones",
                              labelInput: "observaciones",
                              colorFocus: Colors.black,
                              borderRadius: 5,
                              tipoInput: TextInputType.text,
                              controller: jtObservacionesCtrl,
                              validacion: validaciones.camposNumeroTexto),
                          Buttons(
                            callback: callBack,
                            backgraundButton:
                                const Color.fromRGBO(144, 202, 249, 1),
                          ),
                          if (widget.titulo != "Nuevo servicio")
                            Buttons(
                              callback: () {},
                              backgraundButton:
                                  const Color.fromARGB(0, 0, 0, 0),
                              titulotButton: "Eliminar Servicio",
                              foregroundButton: Colors.red,
                            ),
                        ],
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void callBack() {
    if (!formNuevoRegistro.currentState!.validate()) return;

    if (widget.titulo != "Editar Servicio") {
      guardarDatos();
    } else {
      actualizarServicio();
    }
  }

  void guardarDatos() async {
    var datos = {
      "numero": jtCodigoCtrl.text,
      "placa": jtNombreCtrl.text,
      "horaReparacion": jtDescirpionCtrl.text,
      "precioReparacion": jtPrecioCtrl.text,
      "observaciones": jtObservacionesCtrl.text
    };
    PeticionesServicios ps = PeticionesServicios();
    ps.setServicios(datos);
    setState(() {
      widget.callback("inicio");
    });
  }

  void actualizarServicio() async {
    jtNombreCtrl.text = widget.placa ?? "";
    jtPrecioCtrl.text = widget.precioCop ?? "";
    jtObservacionesCtrl.text = widget.observaciones ?? "";
    jtCodigoCtrl.text = widget.numero ?? "";
    var datos = {
      "placa": jtNombreCtrl.text,
      "horaReparacion": jtDescirpionCtrl.text,
      "precioReparacion": jtPrecioCtrl.text,
      "observaciones": jtObservacionesCtrl.text
    };

    PeticionesServicios ps = PeticionesServicios();
    var response = ps.updateServicios(jtIdServicioCtrl.text, datos);
    // ignore: prefer_typing_uninitialized_variables
    var id;
    await response.then((value) => id = value);

    if (id != null) {
      setState(() {});
      widget.callback!("inicio");
    }
  }

  void eliminarServicio() async {
    _showMyDialog();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '¿Estas seguro de eliminar el servicio con el id ${widget.idServicio}}?',
            style: const TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'eliminar',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
              onPressed: () {
                PeticionesServicios ps = PeticionesServicios();
                ps.deleteServicio(widget.idServicio ?? "");
                Navigator.of(context).pop();
                setState(() {});
                widget.callback("inicio");
              },
            ),
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Buttons extends StatelessWidget {
  final VoidCallback callback;
  final double? widthButton;
  final double? heightButton;
  final String? titulotButton;
  final Color backgraundButton;
  final Color? foregroundButton;
  const Buttons({
    super.key,
    required this.callback,
    this.widthButton,
    this.heightButton,
    this.titulotButton,
    required this.backgraundButton,
    this.foregroundButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 5.0),
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: backgraundButton,
        ),
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Text(titulotButton ?? "Guardar",
            style: TextStyle(
                color: foregroundButton ?? Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
