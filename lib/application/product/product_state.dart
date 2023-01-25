


class ProductState {

  final bool isLoad;
  final String errorMessage;
  final bool isSuccess;

  ProductState({
    required this.isLoad,
    required this.errorMessage,
    required this.isSuccess
  });

  ProductState copyWith({
    bool? isLoad,
    String? errorMessage,
    bool? isSuccess
  }){
    return ProductState(
        isLoad: isLoad ?? this.isLoad,
        errorMessage: errorMessage ?? this.errorMessage,
        isSuccess:  isSuccess ?? this.isSuccess
    );
  }

}