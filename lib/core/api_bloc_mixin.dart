import 'package:rxdart/rxdart.dart';

import 'base_model.dart';


abstract class APIBlocMixin<T extends BaseModel<T>,E extends BaseModel<E>>{
  PublishSubject<T> successSubject = PublishSubject();
  Stream<T> get successStream => successSubject.stream;

  PublishSubject<E> errorSubject = PublishSubject();
  Stream<E> get errorStream => errorSubject.stream;
}