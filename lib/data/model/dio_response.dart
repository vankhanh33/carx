class DioResponse {
  final String status;
  final dynamic data;
  const DioResponse({required this.status, required this.data});
  factory DioResponse.fromJson(Map<String, dynamic> json) => DioResponse(
        status: json['status'],
        data: json['data'],
      );
}
