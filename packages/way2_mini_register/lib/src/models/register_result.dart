/// Kết quả trả về super app khi mini flow kết thúc.
class RegisterResult {
  const RegisterResult({
    required this.success,
    this.investorType,
    this.fullName,
    this.phone,
    this.branch,
    this.cancelled = false,
  });

  final bool success;
  final bool cancelled;
  final String? investorType;
  final String? fullName;
  final String? phone;
  final String? branch;

  Map<String, dynamic> toJson() => {
        'success': success,
        'cancelled': cancelled,
        'investorType': investorType,
        'fullName': fullName,
        'phone': phone,
        'branch': branch,
      };
}
