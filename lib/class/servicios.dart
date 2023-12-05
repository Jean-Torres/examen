class ValoresServicio {
  String _numeroServicio = "";
  String _placaServicio = "";
  String _precioCopServicio = "";
  String _horasServicio = "";
  String _tituloOperacion = "";
  String _observacionServicio = "";
  String _idServicio = "";
  List<dynamic> _ValoresServicio = [];

  static ValoresServicio? _instance;
  ValoresServicio._internal();

  factory ValoresServicio() {
    _instance ??= ValoresServicio._internal();
    return _instance!;
  }

  void setNumeroServicio(String nombreServicio) {
    _numeroServicio = nombreServicio;
  }

  void setPlacaServicio(String descripcionServicio) {
    _placaServicio = descripcionServicio;
  }

  void setHoraServicio(String precioServicio) {
    _horasServicio = precioServicio;
  }

  void setPrecioCopServicio(String categoriaServicio) {
    _precioCopServicio = categoriaServicio;
  }

  void setObservacionesServicio(String observacion) {
    _observacionServicio = observacion;
  }

  void setIdServicio(String idServicio) {
    _idServicio = idServicio;
  }

  void setTituloServicio(String tituloOperacion) {
    _tituloOperacion = tituloOperacion;
  }

  void setValoresServicio(dynamic servicio) {
    _ValoresServicio.add(servicio);
  }

  void resetValoresServicio() {
    _ValoresServicio = [];
  }

  String getNumeroServicio() {
    return _numeroServicio;
  }

  String getPlacaServicio() {
    return _placaServicio;
  }

  String getHorasServicio() {
    return _horasServicio;
  }

  String getPrecioCopServicio() {
    return _precioCopServicio;
  }

  String getObservacionServicio() {
    return _observacionServicio;
  }

  String getTituloServicio() {
    return _tituloOperacion;
  }

  String getIdServicio() {
    return _idServicio;
  }
}
