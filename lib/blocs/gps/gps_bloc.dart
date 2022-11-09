import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? streamSuscription;

  GpsBloc() : super(const GpsState(isGpsEnabled: false, isGpsPermissionGranted: false)) {
    on<GpsAndPermissionEvent>((event, emit) =>
        emit(state.copyWith(event.isGpsEnabled, event.isGpsPermissionGranted)));
    _init();
  }

  Future<void> _init() async {
    //Lo hago al principio pero...
    // final isEnabled = await _checkGpsStatus();
    // final isGranted = await _isPermissionGranted();
    //print('isEnabled: $isEnabled, isGranted: $isGranted');

    //Hago que en la espera se ejecuten los 2
    final gpsInitStatus = await Future.wait([
      //
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);

    add(GpsAndPermissionEvent(
        isGpsEnabled: gpsInitStatus[0], isGpsPermissionGranted: gpsInitStatus[1]));
  }

  Future<bool> _checkGpsStatus() async {
    //
    final isEnable = await Geolocator.isLocationServiceEnabled();

    //Nos suscribimos al Stream
    streamSuscription = Geolocator.getServiceStatusStream().listen(
      (event) {
        //
        final isEnabled = (event.index == 1) ? true : false;
        print('Service status: $isEnabled');
        add(GpsAndPermissionEvent(
            isGpsEnabled: isEnabled,
            isGpsPermissionGranted: state.isGpsPermissionGranted));
      },
    );

    return isEnable;
  }

  Future<void> askGpsAccess() async {
    //
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false));
        openAppSettings();
        break;
    }
  }

  Future<bool> _isPermissionGranted() async {
    //
    final isGranted = await Permission.location.isGranted;

    return isGranted;
  }

  @override
  Future<void> close() {
    // Cancelamos la suscripción al Stream
    streamSuscription?.cancel();
    return super.close();
  }
}
